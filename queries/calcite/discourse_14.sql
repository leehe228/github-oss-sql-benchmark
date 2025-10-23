SELECT "t2"."id", "t2"."username", "t2"."created_at", "t2"."updated_at", "t2"."name", "t2"."seen_notification_id",
"t2"."last_posted_at", "t2"."password_hash", "t2"."salt", "t2"."active", "t2"."username_lower",
"t2"."last_seen_at", "t2"."admin", "t2"."last_emailed_at", "t2"."trust_level", "t2"."approved",
"t2"."approved_by_id", "t2"."approved_at", "t2"."previous_visit_at", "t2"."suspended_at", "t2"."suspended_till",
"t2"."date_of_birth", "t2"."views", "t2"."flag_level", "t2"."ip_address", "t2"."moderator",
"t2"."title", "t2"."uploaded_avatar_id", "t2"."locale", "t2"."primary_group_id", "t2"."registration_ip_address",
"t2"."staged", "t2"."first_seen_at", "t2"."silenced_till", "t2"."group_locked_trust_level",
"t2"."manual_locked_trust_level", "t2"."secure_identifier" FROM (SELECT "users"."id", "users"."username",
"users"."created_at", "users"."updated_at", "users"."name", "users"."seen_notification_id",
"users"."last_posted_at", "users"."password_hash", "users"."salt", "users"."active", "users"."username_lower",
"users"."last_seen_at", "users"."admin", "users"."last_emailed_at", "users"."trust_level",
"users"."approved", "users"."approved_by_id", "users"."approved_at", "users"."previous_visit_at",
"users"."suspended_at", "users"."suspended_till", "users"."date_of_birth", "users"."views",
"users"."flag_level", "users"."ip_address", "users"."moderator", "users"."title", "users"."uploaded_avatar_id",
"users"."locale", "users"."primary_group_id", "users"."registration_ip_address", "users"."staged",
"users"."first_seen_at", "users"."silenced_till", "users"."group_locked_trust_level", "users"."manual_locked_trust_level",
"users"."secure_identifier", "t0"."user_id" FROM "users" INNER JOIN (SELECT "user_id" FROM
"group_users" WHERE "group_id" = 8861 GROUP BY "user_id") AS "t0" ON "users"."id" = "t0"."user_id"
WHERE "users"."active" FETCH NEXT 20 ROWS ONLY) AS "t2";
