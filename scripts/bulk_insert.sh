#!/bin/bash
# =====================================================
# Bulk import all CSV files from a given directory into a specific MSSQL database
# Usage:
#   ./bulk_import_dir.sh <database_name> <csv_directory>
# Example:
#   ./bulk_import_dir.sh diaspora ./data/diaspora
# =====================================================

SERVER="localhost"
USER="SA"
PASS="YourStrong!Passw0rd"
SQLCMD="/opt/mssql-tools18/bin/sqlcmd"

DB_NAME="$1"
DATA_DIR="$2"

if [ -z "$DB_NAME" ] || [ -z "$DATA_DIR" ]; then
    echo "Usage: $0 <database_name> <csv_directory>"
    exit 1
fi

if [ ! -d "$DATA_DIR" ]; then
    echo "Directory not found: $DATA_DIR"
    exit 1
fi

echo "Importing all CSV files from '$DATA_DIR' into database '$DB_NAME'..."
echo

echo "Disabling foreign key constraints..."
$SQLCMD -S "$SERVER" -U "$USER" -P "$PASS" -C -d "$DB_NAME" -Q \
"EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';"

for csv_file in "$DATA_DIR"/*.csv; do
    tbl=$(basename "$csv_file" .csv)
    echo "Importing table: $tbl"

    $SQLCMD -S "$SERVER" -U "$USER" -P "$PASS" -C -d "$DB_NAME" -Q "
        BULK INSERT dbo.${tbl}
        FROM '$(realpath "$csv_file")'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK,
            FORMAT = 'CSV',
            KEEPNULLS
        );
    "
done

echo "Re-enabling foreign key constraints..."
$SQLCMD -S "$SERVER" -U "$USER" -P "$PASS" -C -d "$DB_NAME" -Q \
"EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';"

echo
echo "All CSV files in '$DATA_DIR' imported into '$DB_NAME' successfully."
