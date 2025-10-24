#!/usr/bin/env python3
"""
dbgen.py — Type-safe, FK-aware synthetic data generator for MSSQL schema metadata
"""

import argparse, gc, hashlib, uuid
from pathlib import Path
import numpy as np, pandas as pd, networkx as nx
from faker import Faker
fake = Faker()

# --------------------------------
# Helper functions
# --------------------------------
def stable_seed_from_name(name: str) -> int:
    return int(hashlib.md5(name.encode("utf-8")).hexdigest()[:8], 16)

def get_effective_length(dtype: str, maxlen):
    """NVARCHAR/NCHAR"""
    if pd.isna(maxlen) or maxlen is None or maxlen <= 0:
        return 50
    dt = dtype.lower()
    if dt in ("nvarchar", "nchar"):
        return int(maxlen // 2)
    return int(maxlen)

def coerce_string_len(s: str, maxlen: int) -> str:
    return s if pd.isna(maxlen) or not maxlen else str(s)[:int(maxlen)]

def gen_value(dtype: str, maxlen=None):
    dt = dtype.lower()
    if "int" in dt: return np.random.randint(1, 1_000_000)
    if "float" in dt or "decimal" in dt or "real" in dt: return round(np.random.random() * 1000, 3)
    if "date" in dt or "time" in dt: return fake.date_time_this_decade().strftime("%Y-%m-%d %H:%M:%S")
    if "char" in dt or "text" in dt: return coerce_string_len(" ".join(fake.words(3)), maxlen)
    if "bit" in dt or "bool" in dt: return int(np.random.choice([0, 1]))
    return coerce_string_len(fake.word(), maxlen)

def gen_unique(dtype: str, n, maxlen):
    dt = dtype.lower()
    if "int" in dt:
        vals = np.arange(1, n + 1)
        np.random.shuffle(vals)
        return vals
    else:
        return [uuid.uuid4().hex[:maxlen if maxlen else 32] for _ in range(n)]

def choose_rows(table, meta, scale):
    fks = meta[(meta["TABLE_NAME"] == table) & meta["REFERENCED_TABLE"].notna()]
    if len(fks) >= 2: return int(1_000_000 * scale)
    if len(fks) == 1: return int(100_000 * scale)
    return int(10_000 * scale)

# --------------------------------
# Main generator
# --------------------------------
class DBGenerator:
    def __init__(self, meta_path, scale=1.0, verbose=False, out_dir="./synthetic_data"):
        self.meta = pd.read_csv(meta_path, sep="\t", engine="python")
        self.scale, self.verbose = scale, verbose
        self.out_dir = Path(out_dir); self.out_dir.mkdir(parents=True, exist_ok=True)
        self.table_data = {}

    def build_graph(self):
        G = nx.DiGraph()
        for t in self.meta["TABLE_NAME"].unique(): G.add_node(t)
        for _, r in self.meta[self.meta["REFERENCED_TABLE"].notna()].iterrows():
            G.add_edge(r["REFERENCED_TABLE"], r["TABLE_NAME"])
        if not nx.is_directed_acyclic_graph(G): return list(self.meta["TABLE_NAME"].unique())
        return list(nx.topological_sort(G))

    def generate_table(self, tbl, n):
        cols = self.meta[self.meta["TABLE_NAME"] == tbl]; data = {}
        np.random.seed(stable_seed_from_name(tbl)); Faker.seed(stable_seed_from_name(tbl))
        for _, c in cols.iterrows():
            cname, dtype = c["COLUMN_NAME"], c["DATA_TYPE"]
            eff_len = get_effective_length(dtype, c["MAX_LENGTH"])
            is_pk, is_fk = pd.notna(c["PRIMARY_KEY"]), pd.notna(c["REFERENCED_TABLE"])
            is_unique = pd.notna(c["UNIQUE_KEY"])
            if is_pk: data[cname] = np.arange(1, n+1); continue
            if is_fk:
                ptab, pcol = c["REFERENCED_TABLE"], c["REFERENCED_COLUMN"]
                if ptab in self.table_data: data[cname] = np.random.choice(self.table_data[ptab][pcol], n)
                else: data[cname] = np.random.randint(1, n+1, n)
                continue
            if is_unique: data[cname] = gen_unique(dtype, n, eff_len); continue
            data[cname] = [gen_value(dtype, eff_len) for _ in range(n)]
        df = pd.DataFrame(data)
        self.table_data[tbl] = df
        return df

    def run(self):
        order = self.build_graph()
        for i, t in enumerate(order, 1):
            rows = choose_rows(t, self.meta, self.scale)
            if self.verbose: print(f"[{i}/{len(order)}] {t}: {rows} rows")
            df = self.generate_table(t, rows)
            df.to_csv(self.out_dir / f"{t}.csv", index=False, encoding="utf-8")
        print("Data generation complete.")

# --------------------------------
def main():
    a = argparse.ArgumentParser(); 
    a.add_argument("--meta", required=True); a.add_argument("--scale", type=float, default=1.0)
    a.add_argument("--verbose", action="store_true"); a.add_argument("--outdir", default="../data")
    args = a.parse_args()
    gen = DBGenerator(args.meta, args.scale, args.verbose, args.outdir); gen.run()

if __name__ == "__main__": main()
