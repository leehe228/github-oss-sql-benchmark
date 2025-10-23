SELECT "t11"."id", "t11"."title", "t11"."last_posted_at", "t11"."created_at", "t11"."updated_at",
"t11"."views", "t11"."posts_count", "t11"."user_id", "t11"."last_post_user_id", "t11"."reply_count",
"t11"."featured_user1_id", "t11"."featured_user2_id", "t11"."featured_user3_id", "t11"."avg_time",
"t11"."deleted_at", "t11"."highest_post_number", "t11"."image_url", "t11"."like_count", "t11"."incoming_link_count",
"t11"."category_id", "t11"."visible", "t11"."moderator_posts_count", "t11"."closed", "t11"."archived",
"t11"."bumped_at", "t11"."has_summary", "t11"."archetype", "t11"."featured_user4_id", "t11"."notify_moderators_count",
"t11"."spam_count", "t11"."pinned_at", "t11"."score", "t11"."percent_rank", "t11"."subtype",
"t11"."slug", "t11"."deleted_by_id", "t11"."participant_count", "t11"."word_count", "t11"."excerpt",
"t11"."pinned_globally", "t11"."pinned_until", "t11"."fancy_title", "t11"."highest_staff_post_number",
"t11"."featured_link", "t11"."reviewable_score" FROM (SELECT "t"."id", "t"."title", "t"."last_posted_at",
"t"."created_at", "t"."updated_at", "t"."views", "t"."posts_count", "t"."user_id", "t"."last_post_user_id",
"t"."reply_count", "t"."featured_user1_id", "t"."featured_user2_id", "t"."featured_user3_id",
"t"."avg_time", "t"."deleted_at", "t"."highest_post_number", "t"."image_url", "t"."like_count",
"t"."incoming_link_count", "t"."category_id", "t"."visible", "t"."moderator_posts_count", "t"."closed",
"t"."archived", "t"."bumped_at", "t"."has_summary", "t"."archetype", "t"."featured_user4_id",
"t"."notify_moderators_count", "t"."spam_count", "t"."pinned_at", "t"."score", "t"."percent_rank",
"t"."subtype", "t"."slug", "t"."deleted_by_id", "t"."participant_count", "t"."word_count",
"t"."excerpt", "t"."pinned_globally", "t"."pinned_until", "t"."fancy_title", "t"."highest_staff_post_number",
"t"."featured_link", "t"."reviewable_score", "t1"."user_id" AS "user_id0", "t1"."topic_id",
"t3"."topic_id" AS "topic_id0", "t6"."TOPIC_ID", "t6"."i", "t9"."TOPIC_ID" AS "TOPIC_ID0",
"t9"."i" AS "i0" FROM (SELECT * FROM "topics" WHERE "deleted_at" IS NULL AND "archetype" =
'private_message' AND "id" NOT IN (42145, 60069, 68559) AND "visible" = 't') AS "t" LEFT JOIN
(SELECT "user_id", "topic_id" FROM "topic_users" WHERE "user_id" = 13455) AS "t1" ON "t"."id"
= "t1"."topic_id" INNER JOIN (SELECT "topic_id" FROM "topic_allowed_users" WHERE "user_id"
= 13455 GROUP BY "topic_id") AS "t3" ON "t"."id" = "t3"."topic_id" LEFT JOIN (SELECT "topic_id"
AS "TOPIC_ID", TRUE AS "i" FROM "topic_allowed_users" WHERE "user_id" IN (-10, 2, 1995, 8307,
17621, 22980) GROUP BY "topic_id", TRUE) AS "t6" ON "t"."id" = "t6"."TOPIC_ID" LEFT JOIN (SELECT
"topic_id" AS "TOPIC_ID", TRUE AS "i" FROM "topic_allowed_groups" WHERE "group_id" = -10 GROUP
BY "topic_id", TRUE) AS "t9" ON "t"."id" = "t9"."TOPIC_ID" WHERE "t6"."i" IS NOT NULL OR "t9"."i"
IS NOT NULL ORDER BY "t"."bumped_at" DESC) AS "t11";
