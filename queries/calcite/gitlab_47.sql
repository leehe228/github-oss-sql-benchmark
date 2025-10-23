SELECT * FROM "projects" WHERE "pending_delete" = 'f';

SELECT "t"."id" AS "ID" FROM (SELECT * FROM "projects" WHERE "pending_delete" = 'f') AS "t"
INNER JOIN (SELECT * FROM "users_star_projects" WHERE "user_id" = 1) AS "t0" ON "t"."id" =
"t0"."project_id" INNER JOIN (SELECT * FROM "project_authorizations" WHERE "user_id" = 1) AS
"t1" ON "t"."id" = "t1"."project_id" UNION ALL SELECT "t3"."id" AS "ID" FROM (SELECT * FROM
"projects" WHERE "visibility_level" IN (10, 20)) AS "t3" INNER JOIN (SELECT * FROM "users_star_projects"
WHERE "user_id" = 1) AS "t4" ON "t3"."id" = "t4"."project_id";
