SELECT * FROM "tags" INNER JOIN (SELECT "id", "tag_id", "taggable_id", "taggable_type", "tagger_id",
"tagger_type", "context", "created_at" FROM "taggings" WHERE "taggable_type" = 'default' GROUP
BY "id", "tag_id", "taggable_id", "taggable_type", "tagger_id", "tagger_type", "context", "created_at")
AS "t0" ON "tags"."id" = "t0"."tag_id";
