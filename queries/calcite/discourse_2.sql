SELECT "t5"."id", "t5"."user_id", "t5"."topic_id", "t5"."post_number", "t5"."raw", "t5"."cooked",
"t5"."created_at", "t5"."updated_at", "t5"."reply_to_post_number", "t5"."reply_count", "t5"."quote_count",
"t5"."deleted_at", "t5"."off_topic_count", "t5"."like_count", "t5"."incoming_link_count", "t5"."bookmark_count",
"t5"."avg_time", "t5"."score", "t5"."reads", "t5"."post_type", "t5"."sort_order", "t5"."last_editor_id",
"t5"."hidden", "t5"."hidden_reason_id", "t5"."notify_moderators_count", "t5"."spam_count",
"t5"."illegal_count", "t5"."inappropriate_count", "t5"."last_version_at", "t5"."user_deleted",
"t5"."reply_to_user_id", "t5"."percent_rank", "t5"."notify_user_count", "t5"."like_score",
"t5"."deleted_by_id", "t5"."edit_reason", "t5"."word_count", "t5"."version", "t5"."cook_method",
"t5"."wiki", "t5"."baked_at", "t5"."baked_version", "t5"."hidden_at", "t5"."self_edits", "t5"."reply_quoted",
"t5"."via_email", "t5"."raw_email", "t5"."public_version", "t5"."action_code", "t5"."image_url",
"t5"."locked_by_id", "t5"."id0", "t5"."group_id", "t5"."topic_id0" FROM (SELECT "t0"."topic_id"
AS "TOPIC_ID", "t0"."topic_id" FROM (SELECT "id", "user_id", "topic_id" FROM "topic_allowed_users"
WHERE "user_id" = 1086) AS "t0" INNER JOIN (SELECT "id", "topic_id" FROM "topic_allowed_users")
AS "t1" ON "t0"."topic_id" = "t1"."topic_id" AND "t1"."id" <> "t0"."id" GROUP BY "t0"."topic_id"
HAVING COUNT(*) = 1) AS "t4" INNER JOIN (SELECT * FROM "posts" LEFT JOIN "topic_allowed_groups"
ON "posts"."topic_id" = "topic_allowed_groups"."topic_id" WHERE "topic_allowed_groups"."id"
IS NULL) AS "t5" ON "t4"."topic_id" = "t5"."topic_id" AND "t4"."TOPIC_ID" = "t5"."topic_id";
