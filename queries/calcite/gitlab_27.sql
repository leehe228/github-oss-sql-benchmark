SELECT "user_id" AS "USER_ID", TRUE AS "i" FROM "approvals" WHERE "merge_request_id" = 2294769
GROUP BY "user_id", TRUE;

SELECT * FROM (SELECT "id", "state", "ghost", "bot_type" FROM "users" WHERE "state" = 'active'
AND (NOT "ghost" OR "ghost" IS NULL) AND (CAST("bot_type" AS INTEGER) = 0 OR "bot_type" IS
NULL) AND "id" <> 840794) AS "t0" LEFT JOIN (SELECT "user_id" AS "USER_ID", TRUE AS "i" FROM
"project_authorizations" WHERE "project_id" = 13083 AND "access_level" > 20 GROUP BY "user_id",
TRUE) AS "t3" ON "t0"."id" = "t3"."USER_ID" WHERE "t3"."i" IS NOT NULL OR "t0"."id" = 443319;
