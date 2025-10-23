SELECT * FROM "issues";

SELECT COUNT(*) AS "c", COUNT("target_id") AS "ck" FROM "label_links" WHERE "target_type" =
'default';
