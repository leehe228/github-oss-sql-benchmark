SELECT * FROM (SELECT * FROM (SELECT "id", "created_at", "user_id", "category_id", "visible",
"closed", "archived", "archetype" FROM "topics" WHERE "visible" AND ("created_at" > '2004-01-10T05:23:45'
AND "created_at" < '2004-01-24T07:45:25') AND ("archetype" <> 'regular' AND (NOT "closed" AND
NOT "archived"))) AS "t0" LEFT JOIN (SELECT "user_id", "topic_id", "notification_level" FROM
"topic_users" WHERE "user_id" = 3287) AS "t2" ON "t0"."id" = "t2"."topic_id" WHERE CASE WHEN
"t2"."notification_level" IS NOT NULL THEN CAST("t2"."notification_level" AS INTEGER) <> 3
ELSE TRUE END) AS "t3" LEFT JOIN (SELECT "category_id", "user_id" FROM "category_users" WHERE
"user_id" = 5904) AS "t5" ON "t3"."category_id" = "t5"."category_id" LEFT JOIN (SELECT "id"
FROM "users") AS "t6" ON "t3"."user_id" = "t6"."id";
