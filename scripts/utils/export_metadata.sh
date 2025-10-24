#!/bin/bash
# =====================================================
# Export dbgen metadata for 7 MSSQL databases to TSV (Docker-safe)
# =====================================================

SERVER="localhost"
USER="SA"
PASS="Password123@"
SQLCMD="/opt/mssql-tools18/bin/sqlcmd"

# 현재 스크립트의 실제 경로 계산
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QUERY_FILE="${SCRIPT_DIR}/export_metadata.sql"
OUTDIR="${SCRIPT_DIR}/../metadata_tsv"

mkdir -p "$OUTDIR"

DBS=("diaspora" "discourse" "gitlab" "lobsters" "redmine" "solidus" "spree")

for DB in "${DBS[@]}"; do
    echo "📘 Exporting metadata for database: $DB"

    OUTFILE="${OUTDIR}/${DB}_metadata.tsv"

    # extract_metadata.sql을 절대경로로 지정
    $SQLCMD -S "$SERVER" -U "$USER" -P "$PASS" -C -d "$DB" \
        -i "$QUERY_FILE" \
        -s "	" -W -h -1 -o "$OUTFILE"

    if [ -f "$OUTFILE" ]; then
        sed -i '1iTABLE_NAME\tCOLUMN_NAME\tDATA_TYPE\tMAX_LENGTH\tIS_NULLABLE\tDEFAULT_VALUE\tPRIMARY_KEY\tFOREIGN_KEY\tREFERENCED_TABLE\tREFERENCED_COLUMN\tUNIQUE_KEY' "$OUTFILE"
        echo "Saved: $OUTFILE"
    else
        echo "Failed to export $DB (file not created)"
    fi
done

echo "All metadata exports complete (TSV format)!"
