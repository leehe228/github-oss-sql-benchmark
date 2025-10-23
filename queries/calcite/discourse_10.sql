SELECT COUNT(*) FROM (SELECT "id" FROM "topics") AS "t" INNER JOIN (SELECT "t1"."topic_id"
FROM (SELECT "user_id", "topic_id", "deleted_at" FROM "posts" WHERE "deleted_at" IS NULL AND
"user_id" = 9627) AS "t1" INNER JOIN (SELECT "id", "user_id" FROM "topics") AS "t2" ON "t1"."topic_id"
= "t2"."id" AND "t2"."user_id" <> "t1"."user_id" GROUP BY "t1"."topic_id") AS "t3" ON "t"."id"
= "t3"."topic_id";
