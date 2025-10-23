SELECT * FROM "members" WHERE "source_type" = 'Project' AND ("type" = 'ProjectMember' AND "source_id"
= 13083) AND ("requested_at" IS NULL AND ("invite_token" IS NULL AND "user_id" IS NOT NULL));

SELECT "user_id" AS "USER_ID", TRUE AS "i" FROM "members" WHERE "source_type" = 'Project' AND
("type" = 'ProjectMember' AND "source_id" = 13083) AND ("requested_at" IS NULL AND ("invite_token"
IS NULL AND "user_id" IS NOT NULL));

SELECT "id", "source_id", "source_type", "user_id", "type", "invite_token", "requested_at"
FROM "members" WHERE "source_type" = 'Namespace' AND "type" = 'GroupMember' AND "source_id"
= 9970 AND "requested_at" IS NULL AND "invite_token" IS NULL;

SELECT * FROM "members" LEFT JOIN (SELECT "id" FROM "users") AS "t" ON "members"."user_id"
= "t"."id" LEFT JOIN (SELECT "id" AS "ID", TRUE AS "i" FROM "members" WHERE "source_type" =
'Project' AND "type" = 'ProjectMember' AND "source_id" = 13083 AND "requested_at" IS NULL AND
"invite_token" IS NULL GROUP BY "id", TRUE) AS "t2" ON "members"."id" = "t2"."ID" ORDER BY
"members"."id";
