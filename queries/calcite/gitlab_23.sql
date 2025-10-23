SELECT COUNT(*) FROM (SELECT "id" FROM "projects") AS "t" INNER JOIN (SELECT "project_id",
"wiki_verification_checksum", "last_wiki_verification_failure" FROM "project_repository_states"
WHERE "last_wiki_verification_failure" IS NULL AND "wiki_verification_checksum" IS NOT NULL)
AS "t1" ON "t"."id" = "t1"."project_id";
