SELECT COUNT(*) FROM (SELECT "t3"."project_id" AS "project_id0", "t1"."id", "t0"."project_id"
FROM (SELECT "project_id" FROM "todos" WHERE "user_id" = 1 AND "state" = 'pending' GROUP BY
"project_id") AS "t0" INNER JOIN (SELECT "id" FROM "projects") AS "t1" ON "t0"."project_id"
= "t1"."id" INNER JOIN (SELECT "project_id" FROM "todos" WHERE "user_id" = 1 AND "state" =
'pending') AS "t3" ON "t1"."id" = "t3"."project_id") AS "t4" INNER JOIN (SELECT "t5"."id" FROM
(SELECT "id", "visibility_level" FROM "projects") AS "t5" LEFT JOIN (SELECT "project_id", TRUE
AS "$f1" FROM "project_authorizations" WHERE "user_id" = 1 GROUP BY "project_id") AS "t8" ON
"t5"."id" = "t8"."project_id" WHERE "t8"."$f1" IS NOT NULL OR "t5"."visibility_level" IN (10,
20) GROUP BY "t5"."id") AS "t10" ON "t4"."id" = "t10"."id";
