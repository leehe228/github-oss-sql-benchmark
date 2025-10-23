SELECT "posts"."id", "posts"."user_id", "posts"."topic_id", "posts"."post_number", "posts"."raw",
"posts"."cooked", "posts"."created_at", "posts"."updated_at", "posts"."reply_to_post_number",
"posts"."reply_count", "posts"."quote_count", "posts"."deleted_at", "posts"."off_topic_count",
"posts"."like_count", "posts"."incoming_link_count", "posts"."bookmark_count", "posts"."avg_time",
"posts"."score", "posts"."reads", "posts"."post_type", "posts"."sort_order", "posts"."last_editor_id",
"posts"."hidden", "posts"."hidden_reason_id", "posts"."notify_moderators_count", "posts"."spam_count",
"posts"."illegal_count", "posts"."inappropriate_count", "posts"."last_version_at", "posts"."user_deleted",
"posts"."reply_to_user_id", "posts"."percent_rank", "posts"."notify_user_count", "posts"."like_score",
"posts"."deleted_by_id", "posts"."edit_reason", "posts"."word_count", "posts"."version", "posts"."cook_method",
"posts"."wiki", "posts"."baked_at", "posts"."baked_version", "posts"."hidden_at", "posts"."self_edits",
"posts"."reply_quoted", "posts"."via_email", "posts"."raw_email", "posts"."public_version",
"posts"."action_code", "posts"."image_url", "posts"."locked_by_id" FROM "posts" LEFT JOIN (SELECT
"id" AS "ID", TRUE AS "i" FROM "posts" WHERE "percent_rank" <= 88.0 AND "topic_id" = 7290 GROUP
BY "id", TRUE) AS "t1" ON "posts"."id" = "t1"."ID" WHERE "posts"."topic_id" = 6020 AND "posts"."post_number"
= 1 OR "t1"."i" IS NOT NULL;
