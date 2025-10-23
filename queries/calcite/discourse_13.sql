SELECT * FROM "group_users";

SELECT * FROM (SELECT "id" FROM "groups") AS "t" INNER JOIN (SELECT "group_id", "user_id" FROM
"group_users") AS "t0" ON "t"."id" = "t0"."group_id" INNER JOIN (SELECT "id" FROM "users")
AS "t1" ON "t0"."user_id" = "t1"."id";

SELECT COUNT(*) AS "c", COUNT(*) AS "ck" FROM "users" WHERE "admin";
