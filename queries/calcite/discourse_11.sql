SELECT * FROM "posts" INNER JOIN "topics" ON "posts"."topic_id" = "topics"."id";

SELECT COUNT(*) AS "c", COUNT(*) AS "ck" FROM "post_search_data" WHERE "locale" = '0';
