SELECT "ci_pipelines"."id", "ci_pipelines"."ref", "ci_pipelines"."sha", "ci_pipelines"."before_sha",
"ci_pipelines"."created_at", "ci_pipelines"."updated_at", "ci_pipelines"."tag", "ci_pipelines"."yaml_errors",
"ci_pipelines"."committed_at", "ci_pipelines"."project_id", "ci_pipelines"."status", "ci_pipelines"."started_at",
"ci_pipelines"."finished_at", "ci_pipelines"."duration", "ci_pipelines"."user_id", "ci_pipelines"."lock_version",
"ci_pipelines"."auto_canceled_by_id", "ci_pipelines"."pipeline_schedule_id", "ci_pipelines"."source",
"ci_pipelines"."config_source", "ci_pipelines"."protected", "ci_pipelines"."failure_reason",
"ci_pipelines"."iid", "ci_pipelines"."merge_request_id", "ci_pipelines"."source_sha", "ci_pipelines"."target_sha",
"ci_pipelines"."external_pull_request_id" FROM "ci_pipelines" INNER JOIN (SELECT "EXPR$0" FROM
(SELECT "ref", MAX("id") AS "EXPR$0" FROM "ci_pipelines" WHERE "project_id" = 14074169 AND
"ref" IN ('actually', 'existing', 'here', 'refs') GROUP BY "ref") AS "t0" GROUP BY "EXPR$0")
AS "t1" ON "ci_pipelines"."id" = "t1"."EXPR$0" ORDER BY "ci_pipelines"."id" DESC FETCH NEXT
20 ROWS ONLY;
