SELECT "t"."id", "t"."status", "t"."finished_at", "t"."trace", "t"."created_at", "t"."updated_at",
"t"."started_at", "t"."runner_id", "t"."coverage", "t"."commit_id", "t"."commands", "t"."name",
"t"."options", "t"."allow_failure", "t"."stage", "t"."trigger_request_id", "t"."stage_idx",
"t"."tag", "t"."ref", "t"."user_id", "t"."type", "t"."target_url", "t"."description", "t"."artifacts_file",
"t"."project_id", "t"."artifacts_metadata", "t"."erased_by_id", "t"."erased_at", "t"."artifacts_expire_at",
"t"."environment", "t"."artifacts_size", "t"."when", "t"."yaml_variables", "t"."queued_at",
"t"."token", "t"."lock_version", "t"."coverage_regex", "t"."auto_canceled_by_id", "t"."retried",
"t"."stage_id", "t"."artifacts_file_store", "t"."artifacts_metadata_store", "t"."protected",
"t"."failure_reason", "t"."scheduled_at", "t"."token_encrypted", "t"."upstream_pipeline_id",
"t"."resource_group_id", "t"."waiting_for_resource_at", "t"."processed", "t"."scheduling_type"
FROM (SELECT * FROM "ci_builds" WHERE "type" = 'Ci::Build') AS "t" LEFT JOIN (SELECT "job_id",
TRUE AS "$f1" FROM "ci_job_artifacts" GROUP BY "job_id") AS "t1" ON "t"."id" = "t1"."job_id"
WHERE "t"."artifacts_file" <> '' OR "t1"."$f1" IS NOT NULL;
