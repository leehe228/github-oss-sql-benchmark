SELECT "id", "user_id", "requested_at" FROM "members" WHERE "requested_at" IS NULL;

SELECT * FROM "members" LEFT JOIN (SELECT "id" AS "ID", TRUE AS "i" FROM "members" WHERE "source_id"
= 165620945 GROUP BY "id", TRUE) AS "t1" ON "members"."id" = "t1"."ID" ORDER BY "members"."id";
