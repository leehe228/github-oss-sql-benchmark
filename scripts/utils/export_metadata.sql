SET NOCOUNT ON;

SELECT
    t.name AS TABLE_NAME,
    c.name AS COLUMN_NAME,
    ty.name AS DATA_TYPE,
    -- NVARCHAR/NCHAR은 max_length를 문자 수로 변환
    CASE 
        WHEN ty.name IN ('nvarchar', 'nchar') AND c.max_length > 0 THEN c.max_length / 2
        WHEN ty.name IN ('nvarchar', 'nchar') AND c.max_length = -1 THEN 4000 -- nvarchar(max)
        ELSE c.max_length
    END AS MAX_LENGTH,
    CASE WHEN c.is_nullable = 1 THEN 'YES' ELSE 'NO' END AS IS_NULLABLE,
    dc.definition AS DEFAULT_VALUE,
    pk.CONSTRAINT_NAME AS PRIMARY_KEY,
    fk.FK_NAME AS FOREIGN_KEY,
    fk.REFERENCED_TABLE_NAME AS REFERENCED_TABLE,
    fk.REFERENCED_COLUMN_NAME AS REFERENCED_COLUMN,
    uq.CONSTRAINT_NAME AS UNIQUE_KEY
FROM sys.columns c
INNER JOIN sys.tables t ON c.object_id = t.object_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
LEFT JOIN sys.default_constraints dc ON c.default_object_id = dc.object_id

-- Primary Key 매핑
LEFT JOIN (
    SELECT 
        KU.TABLE_NAME,
        KU.COLUMN_NAME,
        TC.CONSTRAINT_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
        ON TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
    WHERE TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
) pk ON pk.TABLE_NAME = t.name AND pk.COLUMN_NAME = c.name

-- Foreign Key 매핑
LEFT JOIN (
    SELECT
        fk.name AS FK_NAME,
        tp.name AS TABLE_NAME,
        cp.name AS COLUMN_NAME,
        tr.name AS REFERENCED_TABLE_NAME,
        cr.name AS REFERENCED_COLUMN_NAME
    FROM sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fkc
        ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.tables tp
        ON fkc.parent_object_id = tp.object_id
    INNER JOIN sys.columns cp
        ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
    INNER JOIN sys.tables tr
        ON fkc.referenced_object_id = tr.object_id
    INNER JOIN sys.columns cr
        ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
) fk ON fk.TABLE_NAME = t.name AND fk.COLUMN_NAME = c.name

-- Unique Key 매핑
LEFT JOIN (
    SELECT 
        ku.TABLE_NAME,
        ku.COLUMN_NAME,
        tc.CONSTRAINT_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS ku
        ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
    WHERE tc.CONSTRAINT_TYPE = 'UNIQUE'
) uq ON uq.TABLE_NAME = t.name AND uq.COLUMN_NAME = c.name

WHERE t.is_ms_shipped = 0
ORDER BY t.name, c.column_id;
