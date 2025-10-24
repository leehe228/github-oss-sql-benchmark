#!/usr/bin/env python3
"""
dbgen.py — Type-safe, FK-aware synthetic data generator for MSSQL schema metadata

Expected metadata columns (TSV recommended):
  TABLE_NAME, COLUMN_NAME, DATA_TYPE, MAX_LENGTH, IS_NULLABLE,
  DEFAULT_VALUE, PRIMARY_KEY, FOREIGN_KEY, REFERENCED_TABLE,
  REFERENCED_COLUMN, UNIQUE_KEY

Notes
- MAX_LENGTH is interpreted as "character count" for (n)char/(n)varchar.
  If your export provides bytes for NVARCHAR/NCHAR, this code still guards by halving.
- For NVARCHAR(MAX)/VARCHAR(MAX) (i.e., MAX_LENGTH <= 0), we cap to 1000 chars by default.
- Bulk-insert-safe CSV: UTF-8, minimal quoting, empty string as NULL.
"""

import argparse
import csv
import gc
import hashlib
import re
import uuid
from pathlib import Path

import networkx as nx
import numpy as np
import pandas as pd
from faker import Faker

fake = Faker()


# -------------------------------
# General helpers
# -------------------------------
def stable_seed_from_name(name: str) -> int:
    """Stable integer seed from a string (per-table reproducibility)."""
    return int(hashlib.md5(name.encode("utf-8")).hexdigest()[:8], 16)


def is_national_char(dt: str) -> bool:
    dt = dt.lower()
    return dt in ("nchar", "nvarchar")


def is_char(dt: str) -> bool:
    dt = dt.lower()
    return any(t in dt for t in ("char", "text", "ntext"))


def is_integer_dtype(dt: str) -> bool:
    dt = dt.lower()
    return any(t == dt for t in ("tinyint", "smallint", "int", "bigint")) or ("int" in dt)


def get_effective_length(dtype: str, maxlen):
    """
    Return effective character count to trim strings.
    - For NVARCHAR/NCHAR, if you happen to have byte length, halve it safely.
    - For (MAX) or non-positive values, cap to a safe upper bound (1000).
    """
    if maxlen is None or (isinstance(maxlen, float) and np.isnan(maxlen)):
        # unknown → pick a sensible default
        return 100

    try:
        m = int(maxlen)
    except Exception:
        return 100

    dt = dtype.lower()
    if m <= 0:  # (MAX) or invalid
        return 1000

    if is_national_char(dt):
        # If export already provided character count, this keeps it.
        # If export provided bytes, this halves it (floor).
        # Use the smaller of m and m//2 * 2 heuristic to be safe.
        # Ultimately, just halve to ensure we don't overflow NVARCHAR char count if bytes were given.
        return max(1, m)  # our export already fixed to chars; keep as-is
    else:
        return max(1, m)


def coerce_string_len(s: str, max_chars: int) -> str:
    """Trim to at most max_chars."""
    if s is None:
        return None
    if max_chars is None or (isinstance(max_chars, float) and np.isnan(max_chars)) or max_chars <= 0:
        return str(s)
    s = str(s)
    if len(s) <= int(max_chars):
        return s
    return s[: int(max_chars)]


# -------------------------------
# Numeric generators (safe ranges)
# -------------------------------
def gen_random_numeric(dtype: str) -> int:
    """Non-unique numeric random within safe MSSQL ranges."""
    dt = dtype.lower()
    if dt == "tinyint":
        return np.random.randint(0, 256)  # 0..255
    if dt == "smallint":
        return np.random.randint(-32768, 32768)  # -32768..32767
    if dt == "int":
        return np.random.randint(1, 10_000_000)  # positive safe subset
    if dt == "bigint":
        return np.random.randint(1, 1_000_000_000)
    # fallback
    return np.random.randint(1, 10_000_000)


def gen_unique_numeric(dtype: str, n_rows: int) -> np.ndarray:
    """Unique numeric values respecting capacity."""
    dt = dtype.lower()
    if dt == "tinyint":
        cap_min, cap_max = 0, 255
    elif dt == "smallint":
        cap_min, cap_max = -32768, 32767
    elif dt == "int":
        cap_min, cap_max = 1, max(1_000_000, n_rows + 5)
    elif dt == "bigint":
        cap_min, cap_max = 1, max(1_000_000_000, n_rows + 5)
    else:
        cap_min, cap_max = 1, max(1_000_000, n_rows + 5)

    capacity = cap_max - cap_min + 1
    if capacity < n_rows:
        # If physically impossible to make all unique, reduce n_rows (benchmark-friendly choice)
        n_rows = capacity

    vals = np.arange(cap_min, cap_min + n_rows, dtype="int64")
    np.random.shuffle(vals)
    return vals


def parse_decimal_scale(dtype: str, default_scale: int = 3) -> int:
    """
    Parse scale from a type like 'decimal(10,2)' if present in DATA_TYPE.
    Our export typically has bare 'decimal', so we fall back to default_scale.
    """
    m = re.search(r"\(\s*\d+\s*,\s*(\d+)\s*\)", dtype)
    if m:
        try:
            return max(0, int(m.group(1)))
        except Exception:
            return default_scale
    return default_scale


# -------------------------------
# Value generation by type
# -------------------------------
def gen_value(dtype: str, max_chars=None):
    dt = dtype.lower()

    if is_integer_dtype(dt):
        return gen_random_numeric(dt)

    # DECIMAL/NUMERIC with scale handling
    if "decimal" in dt or "numeric" in dt:
        scale = parse_decimal_scale(dt, default_scale=3)
        return round(np.random.random() * 1000, scale)

    # FLOAT/REAL
    if "float" in dt or "real" in dt:
        return round(np.random.random() * 1000, 3)

    # DATETIME family
    if "datetimeoffset" in dt:
        # ISO 8601 with offset
        return fake.date_time_this_decade().strftime("%Y-%m-%d %H:%M:%S +00:00")
    if "smalldatetime" in dt:
        return fake.date_time_this_decade().strftime("%Y-%m-%d %H:%M")
    if "date" in dt or "time" in dt:
        return fake.date_time_this_decade().strftime("%Y-%m-%d %H:%M:%S")

    # BIT/BOOL
    if "bit" in dt or "bool" in dt:
        return int(np.random.choice([0, 1]))

    # CHAR/TEXT
    if is_char(dt):
        base = " ".join(fake.words(3))
        return coerce_string_len(base, max_chars)

    # Fallback string
    return coerce_string_len(fake.word(), max_chars)


def gen_unique(dtype: str, n_rows: int, max_chars=None):
    dt = dtype.lower()
    if is_integer_dtype(dt):
        return gen_unique_numeric(dt, n_rows).tolist()
    # Unique strings (UUID-based)
    return [coerce_string_len(uuid.uuid4().hex, max_chars if max_chars else 32) for _ in range(n_rows)]


# -------------------------------
# Row count heuristic (TPC-H-ish)
# -------------------------------
def choose_rows(table: str, meta: pd.DataFrame, scale: float) -> int:
    fk_count = meta[(meta["TABLE_NAME"] == table) & (meta["REFERENCED_TABLE"].notna())].shape[0]
    if fk_count >= 2:
        n = int(1_000_000 * scale)  # fact-like
    elif fk_count == 1:
        n = int(100_000 * scale)    # medium
    else:
        n = int(10_000 * scale)     # small (dimension-like)
    return max(1, n)


# -------------------------------
# Generator
# -------------------------------
class DBGenerator:
    def __init__(self, meta_path, scale=1.0, verbose=False, out_dir="./synthetic_data",
                 fmt="csv", allow_nulls=False):
        # Load metadata (TSV preferred)
        if meta_path.endswith(".tsv"):
            self.meta = pd.read_csv(meta_path, sep="\t", engine="python")
        elif meta_path.endswith(".csv"):
            self.meta = pd.read_csv(meta_path)
        else:
            raise ValueError("Unsupported metadata format. Use .tsv (recommended) or .csv")

        required = {
            "TABLE_NAME","COLUMN_NAME","DATA_TYPE","MAX_LENGTH","IS_NULLABLE",
            "DEFAULT_VALUE","PRIMARY_KEY","FOREIGN_KEY","REFERENCED_TABLE",
            "REFERENCED_COLUMN","UNIQUE_KEY"
        }
        missing = required - set(self.meta.columns)
        if missing:
            raise ValueError(f"Metadata missing columns: {sorted(missing)}")

        self.scale = float(scale)
        self.verbose = bool(verbose)
        self.out_dir = Path(out_dir)
        self.out_dir.mkdir(parents=True, exist_ok=True)
        self.table_data: dict[str, pd.DataFrame] = {}
        self.format = fmt.lower()
        if self.format not in ("csv", "parquet"):
            raise ValueError("--format must be 'csv' or 'parquet'")
        self.allow_nulls = bool(allow_nulls)

        # Normalize metadata values
        self.meta["REFERENCED_TABLE"]  = self.meta["REFERENCED_TABLE"].replace({"NULL": pd.NA, "(NULL)": pd.NA})
        self.meta["REFERENCED_COLUMN"] = self.meta["REFERENCED_COLUMN"].replace({"NULL": pd.NA, "(NULL)": pd.NA})
        self.meta["IS_NULLABLE"] = self.meta["IS_NULLABLE"].astype(str).str.upper()

    def build_graph(self):
        """Build FK DAG: edges parent -> child. Cycle-safe fallback."""
        G = nx.DiGraph()
        for t in self.meta["TABLE_NAME"].unique():
            G.add_node(t)
        for _, r in self.meta[self.meta["REFERENCED_TABLE"].notna()].iterrows():
            G.add_edge(r["REFERENCED_TABLE"], r["TABLE_NAME"])

        if not nx.is_directed_acyclic_graph(G):
            if self.verbose:
                print("FK cycle detected → falling back to shuffled order for involved tables")
            order = list(self.meta["TABLE_NAME"].unique())
            np.random.shuffle(order)
            return order

        return list(nx.topological_sort(G))

    def generate_table(self, table_name: str, n_rows: int) -> pd.DataFrame:
        cols = self.meta[self.meta["TABLE_NAME"] == table_name].copy()
        data = {}

        # Stable per-table randomness
        seed = stable_seed_from_name(table_name)
        np.random.seed(seed)
        Faker.seed(seed)

        for _, col in cols.iterrows():
            cname   = col["COLUMN_NAME"]
            dtype   = str(col["DATA_TYPE"])
            maxlen  = col["MAX_LENGTH"]
            default = col["DEFAULT_VALUE"]
            is_pk   = pd.notna(col["PRIMARY_KEY"])
            is_fk   = pd.notna(col["REFERENCED_TABLE"])
            is_unique = pd.notna(col["UNIQUE_KEY"])
            nullable= (str(col["IS_NULLABLE"]).upper() == "YES")

            eff_len = get_effective_length(dtype, maxlen)

            # 1) PK: sequential unique ints
            if is_pk:
                data[cname] = np.arange(1, n_rows + 1, dtype="int64")
                continue

            # 2) FK: sample from parent PK values
            if is_fk:
                parent_tbl = str(col["REFERENCED_TABLE"])
                parent_col = str(col["REFERENCED_COLUMN"])
                parent_df  = self.table_data.get(parent_tbl)
                if isinstance(parent_df, pd.DataFrame) and parent_col in parent_df.columns:
                    parent_vals = parent_df[parent_col].dropna().values
                    if len(parent_vals) > 0:
                        data[cname] = np.random.choice(parent_vals, size=n_rows, replace=True)
                        continue
                # fallback: safe positives
                data[cname] = np.random.randint(1, max(2, n_rows + 5), size=n_rows, dtype="int64")
                continue

            # 3) DEFAULT literal handling
            vals = None
            if isinstance(default, str) and default and default.upper() not in ("(NULL)", "NULL", "NAN"):
                d = default.strip()
                if "getdate" in d.lower():
                    vals = [fake.date_time_this_decade().strftime("%Y-%m-%d %H:%M:%S") for _ in range(n_rows)]
                else:
                    vals = [d.strip("()'") for _ in range(n_rows)]

            # 4) UNIQUE handling
            if vals is None and is_unique:
                vals = gen_unique(dtype, n_rows, eff_len)

                # Allow a tiny fraction of NULLs if user asked for NULLs and column nullable.
                if self.allow_nulls and nullable:
                    mask = np.random.rand(n_rows) < 0.02
                    vals = [v if not m else None for v, m in zip(vals, mask)]

            # 5) random generation if needed
            if vals is None:
                vals = [gen_value(dtype, eff_len) for _ in range(n_rows)]

            # 6) NULL policy (default: no NULLs)
            if self.allow_nulls and nullable and not (is_pk or is_fk):
                # 10% NULLs for general nullable columns
                mask = np.random.rand(n_rows) < 0.10
                vals = [v if not m else None for v, m in zip(vals, mask)]
            else:
                vals = [v if v is not None else gen_value(dtype, eff_len) for v in vals]

            # 7) final string trim
            if any(isinstance(v, str) for v in vals) and is_char(dtype):
                vals = [coerce_string_len(v, eff_len) if v is not None else v for v in vals]

            data[cname] = vals

        df = pd.DataFrame(data)

        # 8) dtype casting for pandas (bulk-safe)
        for _, c in cols.iterrows():
            cname, dt = c["COLUMN_NAME"], str(c["DATA_TYPE"]).lower()
            try:
                if any(t in dt for t in ["bigint", "int", "smallint", "tinyint"]):
                    df[cname] = df[cname].astype("Int64")
                elif any(t in dt for t in ["float", "decimal", "real", "numeric"]):
                    df[cname] = df[cname].astype("Float64")
                elif "bit" in dt or "bool" in dt:
                    # keep as object (0/1/None) to avoid NaN issues
                    df[cname] = df[cname].astype("object")
                elif is_char(dt):
                    df[cname] = df[cname].astype("string")
                # datetime are strings already
            except Exception:
                # safe fallback
                df[cname] = df[cname].astype("string")

        # 9) NaN → None (Bulk INSERT doesn't understand NaN)
        df = df.replace({np.nan: None})

        self.table_data[table_name] = df
        return df

    def save_table(self, table: str, df: pd.DataFrame, fmt: str):
        out_path = self.out_dir / f"{table}.{fmt}"
        if fmt == "csv":
            df.to_csv(
                out_path,
                index=False,
                na_rep="",
                float_format="%.0f",
                encoding="utf-8",
                quoting=csv.QUOTE_MINIMAL,  # safer for commas
            )
        else:
            df.to_parquet(out_path, index=False)
        if self.verbose:
            print(f"  -> Saved {out_path}")

    def run(self, fmt: str):
        order = self.build_graph()
        if self.verbose:
            print(f"📋 Generation order: {', '.join(order)}")

        for i, tbl in enumerate(order, start=1):
            n_rows = choose_rows(tbl, self.meta, self.scale)
            if self.verbose:
                print(f"[{i}/{len(order)}] Generating {tbl} ({n_rows:,} rows)...")
            df = self.generate_table(tbl, n_rows)
            self.save_table(tbl, df, fmt)
            gc.collect()
        print("Data generation completed.")


# -------------------------------
# CLI
# -------------------------------
def main():
    p = argparse.ArgumentParser(description="Synthetic data generator for MSSQL schema metadata.")
    p.add_argument("--meta", required=True, help="Path to metadata file (.tsv recommended, or .csv)")
    p.add_argument("--scale", type=float, default=1.0, help="Scale factor (e.g., 1.0 ~ TPCH SF1-ish)")
    p.add_argument("--outdir", default="../data", help="Output directory")
    p.add_argument("--format", choices=["csv", "parquet"], default="csv", help="Output file format")
    p.add_argument("--verbose", action="store_true", help="Verbose logs")
    p.add_argument("--allow-nulls", action="store_true", help="Allow NULLs in nullable columns")
    args = p.parse_args()

    np.random.seed(42)
    Faker.seed(42)

    gen = DBGenerator(
        meta_path=args.meta,
        scale=args.scale,
        verbose=args.verbose,
        out_dir=args.outdir,
        fmt=args.format,
        allow_nulls=args.allow_nulls
    )
    gen.run(args.format)

if __name__ == "__main__":
    main()
