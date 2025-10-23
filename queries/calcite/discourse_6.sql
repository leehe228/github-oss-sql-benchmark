SELECT * FROM "posts" INNER JOIN "topics" ON "posts"."topic_id" = "topics"."id" INNER JOIN
"categories" ON "topics"."category_id" = "categories"."id";

SELECT COUNT(*) AS "c", COUNT(*) AS "ck" FROM "categories" WHERE "search_priority" = 5;
