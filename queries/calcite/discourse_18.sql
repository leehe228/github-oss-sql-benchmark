SELECT * FROM "categories" INNER JOIN "topics" ON "categories"."topic_id" = "topics"."id" AND
("categories"."id" = 1 OR "categories"."parent_category_id" = 1 AND "categories"."topic_id"
<> "topics"."id");
