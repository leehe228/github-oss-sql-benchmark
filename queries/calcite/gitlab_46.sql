SELECT * FROM (SELECT * FROM "merge_requests" WHERE "state_id" = 1 AND "target_project_id"
= 13083) AS "t" INNER JOIN (SELECT "label_id", "target_id", "target_type" FROM "label_links"
WHERE "target_type" = 'MergeRequest') AS "t1" ON "t"."id" = "t1"."target_id" INNER JOIN (SELECT
"id", "title" FROM "labels" WHERE "title" = 'bug') AS "t3" ON "t1"."label_id" = "t3"."id";
