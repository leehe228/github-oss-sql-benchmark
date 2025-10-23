SELECT "t"."id" AS "ID" FROM (SELECT "id", "diff_note_id" FROM "note_diff_files") AS "t" INNER
JOIN (SELECT "id", "project_id", "type" FROM "notes" WHERE "type" = 'DiffNote') AS "t1" ON
"t"."diff_note_id" = "t1"."id" LEFT JOIN (SELECT "id" FROM "projects") AS "t2" ON "t1"."project_id"
= "t2"."id" INNER JOIN (SELECT "id" FROM (SELECT "id" FROM "notes" WHERE "noteable_id" = 18527120
AND "noteable_type" = 'MergeRequest' UNION ALL SELECT "id" FROM "notes" WHERE "project_id"
= 7764 AND "noteable_type" = 'Commit' AND "commit_id" = 2044708959) AS "t7" GROUP BY "id")
AS "t8" ON "t"."diff_note_id" = "t8"."id";
