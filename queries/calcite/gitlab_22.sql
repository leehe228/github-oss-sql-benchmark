SELECT "t1"."id", "t1"."title", "t1"."author_id", "t1"."project_id", "t1"."created_at", "t1"."updated_at",
"t1"."description", "t1"."milestone_id", "t1"."iid", "t1"."updated_by_id", "t1"."weight", "t1"."confidential",
"t1"."due_date", "t1"."moved_to_id", "t1"."lock_version", "t1"."title_html", "t1"."description_html",
"t1"."time_estimate", "t1"."relative_position", "t1"."service_desk_reply_to", "t1"."cached_markdown_version",
"t1"."last_edited_at", "t1"."last_edited_by_id", "t1"."discussion_locked", "t1"."closed_at",
"t1"."closed_by_id", "t1"."state_id", "t1"."duplicated_to_id", "t1"."promoted_to_epic_id",
"t1"."health_status", "t1"."external_key" FROM (SELECT "t0"."id", "t0"."title", "t0"."author_id",
"t0"."project_id", "t0"."created_at", "t0"."updated_at", "t0"."description", "t0"."milestone_id",
"t0"."iid", "t0"."updated_by_id", "t0"."weight", "t0"."confidential", "t0"."due_date", "t0"."moved_to_id",
"t0"."lock_version", "t0"."title_html", "t0"."description_html", "t0"."time_estimate", "t0"."relative_position",
"t0"."service_desk_reply_to", "t0"."cached_markdown_version", "t0"."last_edited_at", "t0"."last_edited_by_id",
"t0"."discussion_locked", "t0"."closed_at", "t0"."closed_by_id", "t0"."state_id", "t0"."duplicated_to_id",
"t0"."promoted_to_epic_id", "t0"."health_status", "t0"."external_key", "milestone_releases"."release_id"
FROM (SELECT "issues"."id", "issues"."title", "issues"."author_id", "issues"."project_id",
"issues"."created_at", "issues"."updated_at", "issues"."description", "issues"."milestone_id",
"issues"."iid", "issues"."updated_by_id", "issues"."weight", "issues"."confidential", "issues"."due_date",
"issues"."moved_to_id", "issues"."lock_version", "issues"."title_html", "issues"."description_html",
"issues"."time_estimate", "issues"."relative_position", "issues"."service_desk_reply_to", "issues"."cached_markdown_version",
"issues"."last_edited_at", "issues"."last_edited_by_id", "issues"."discussion_locked", "issues"."closed_at",
"issues"."closed_by_id", "issues"."state_id", "issues"."duplicated_to_id", "issues"."promoted_to_epic_id",
"issues"."health_status", "issues"."external_key", CAST("t"."id" AS BIGINT) AS "id00" FROM
"issues" LEFT JOIN (SELECT "id" FROM "milestones") AS "t" ON "issues"."milestone_id" = "t"."id")
AS "t0" INNER JOIN "milestone_releases" ON "t0"."id00" = "milestone_releases"."milestone_id")
AS "t1" INNER JOIN (SELECT CAST("id" AS BIGINT) AS "id0" FROM "releases") AS "t2" ON "t1"."release_id"
= "t2"."id0";
