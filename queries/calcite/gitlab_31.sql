SELECT "issues"."id", "issues"."title", "issues"."author_id", "issues"."project_id", "issues"."created_at",
"issues"."updated_at", "issues"."description", "issues"."milestone_id", "issues"."iid", "issues"."updated_by_id",
"issues"."weight", "issues"."confidential", "issues"."due_date", "issues"."moved_to_id", "issues"."lock_version",
"issues"."title_html", "issues"."description_html", "issues"."time_estimate", "issues"."relative_position",
"issues"."service_desk_reply_to", "issues"."cached_markdown_version", "issues"."last_edited_at",
"issues"."last_edited_by_id", "issues"."discussion_locked", "issues"."closed_at", "issues"."closed_by_id",
"issues"."state_id", "issues"."duplicated_to_id", "issues"."promoted_to_epic_id", "issues"."health_status",
"issues"."external_key", "t"."id" AS "ISSUE_LINKS_ID" FROM (SELECT * FROM "issue_links" WHERE
"target_id" = 1153) AS "t" INNER JOIN "issues" ON "t"."source_id" = "issues"."id" UNION SELECT
"issues0"."id", "issues0"."title", "issues0"."author_id", "issues0"."project_id", "issues0"."created_at",
"issues0"."updated_at", "issues0"."description", "issues0"."milestone_id", "issues0"."iid",
"issues0"."updated_by_id", "issues0"."weight", "issues0"."confidential", "issues0"."due_date",
"issues0"."moved_to_id", "issues0"."lock_version", "issues0"."title_html", "issues0"."description_html",
"issues0"."time_estimate", "issues0"."relative_position", "issues0"."service_desk_reply_to",
"issues0"."cached_markdown_version", "issues0"."last_edited_at", "issues0"."last_edited_by_id",
"issues0"."discussion_locked", "issues0"."closed_at", "issues0"."closed_by_id", "issues0"."state_id",
"issues0"."duplicated_to_id", "issues0"."promoted_to_epic_id", "issues0"."health_status", "issues0"."external_key",
"t1"."id" AS "ISSUE_LINKS_ID" FROM (SELECT * FROM "issue_links" WHERE "source_id" = 1009) AS
"t1" INNER JOIN "issues" AS "issues0" ON "t1"."source_id" = "issues0"."id" AND "t1"."target_id"
= "issues0"."id";
