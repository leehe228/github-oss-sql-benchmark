SELECT * FROM "notifications";

SELECT COUNT(*) AS "c" FROM "topics" WHERE "deleted_at" IS NULL;
