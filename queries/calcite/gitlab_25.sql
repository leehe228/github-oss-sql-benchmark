SELECT COUNT(*) FROM (SELECT * FROM (SELECT * FROM (SELECT "id", "project_id", "closed_at",
"state_id" FROM "issues" WHERE "closed_at" IS NULL AND CAST("state_id" AS INTEGER) = 1) AS
"t0" INNER JOIN (SELECT "id", "visibility_level" FROM "projects") AS "t1" ON "t0"."project_id"
= "t1"."id" LEFT JOIN (SELECT "project_id", "issues_access_level" FROM "project_features")
AS "t2" ON "t1"."id" = "t2"."project_id" WHERE "t2"."issues_access_level" IS NULL OR "t2"."issues_access_level"
IN (10, 20)) AS "t3" INNER JOIN (SELECT "issue_id" FROM "issue_assignees" WHERE "user_id" =
1 GROUP BY "issue_id") AS "t5" ON "t3"."id" = "t5"."issue_id" LEFT JOIN (SELECT "project_id",
TRUE AS "$f1" FROM "project_authorizations" WHERE "user_id" = 1 GROUP BY "project_id") AS "t8"
ON "t3"."id0" = "t8"."project_id" WHERE "t8"."$f1" IS NOT NULL OR "t3"."visibility_level" IN
(0, 10, 20)) AS "t9" INNER JOIN (SELECT "t11"."project_id" FROM (SELECT "id", "project_id",
"closed_at", "state_id" FROM "issues" WHERE "closed_at" IS NULL AND "state_id" = 1) AS "t11"
INNER JOIN (SELECT "issue_id" FROM "issue_assignees" WHERE "user_id" = 1 GROUP BY "issue_id")
AS "t13" ON "t11"."id" = "t13"."issue_id" GROUP BY "t11"."project_id") AS "t14" ON "t9"."id0"
= "t14"."project_id";
