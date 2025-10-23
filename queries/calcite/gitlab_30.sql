SELECT "t"."id", "t"."project_id", "t"."job_id", "t"."file_type", "t"."size", "t"."created_at",
"t"."updated_at", "t"."expire_at", "t"."file", "t"."file_store", "t"."file_sha256", "t"."file_format",
"t"."file_location" FROM (SELECT * FROM "ci_job_artifacts" WHERE "file_store" IS NULL OR "file_store"
= 1) AS "t" LEFT JOIN (SELECT "id", "job_artifact_id" FROM "geo_job_artifact_deleted_events")
AS "t0" ON "t"."id" = "t0"."job_artifact_id" WHERE "t0"."id" IS NULL FETCH NEXT 1000 ROWS ONLY;
