SELECT "t3"."id" AS "ID", "t3"."last_repository_updated_at" FROM (SELECT "t0"."id", "t0"."repository_storage",
"t0"."last_repository_updated_at", "t1"."id" AS "id0", "t1"."project_id" FROM (SELECT "id",
"repository_storage", "last_repository_updated_at" FROM "projects" WHERE "repository_storage"
= 'default') AS "t0" LEFT JOIN (SELECT "id", "project_id" FROM "project_repository_states")
AS "t1" ON "t0"."id" = "t1"."project_id" WHERE "t1"."id" IS NULL ORDER BY "t0"."last_repository_updated_at"
FETCH NEXT 1000 ROWS ONLY) AS "t3";
