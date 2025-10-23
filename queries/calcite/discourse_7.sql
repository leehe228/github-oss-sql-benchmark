SELECT * FROM "posts";

SELECT "post_timings"."topic_id" AS "TOPIC_ID", "post_timings"."post_number" AS "POST_NUMBER",
EXP(CAST(COALESCE(SUM("post_timings"."msecs"), 0) / COUNT(*) AS INTEGER)) AS "GMEAN" FROM "post_timings"
INNER JOIN (SELECT "user_id", "topic_id", "post_number" FROM "posts") AS "t" ON "post_timings"."post_number"
= "t"."post_number" AND "post_timings"."topic_id" = "t"."topic_id" AND "t"."user_id" <> "post_timings"."user_id"
GROUP BY "post_timings"."topic_id", "post_timings"."post_number";
