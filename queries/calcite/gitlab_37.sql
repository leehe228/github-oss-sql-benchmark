SELECT * FROM (SELECT "id", "status", "commit_id", "type" FROM "ci_builds" WHERE "type" = 'Ci::Build'
AND "status" IN ('canceled', 'failed') AND "commit_id" = 8088) AS "t0" INNER JOIN (SELECT "EXPR$0"
FROM (SELECT "commit_id", "name", MAX("id") AS "EXPR$0" FROM "ci_builds" WHERE "type" = 'Ci::Build'
GROUP BY "commit_id", "name") AS "t2" GROUP BY "EXPR$0") AS "t3" ON "t0"."id" = "t3"."EXPR$0";
