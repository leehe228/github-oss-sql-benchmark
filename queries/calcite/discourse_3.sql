SELECT "id", "parent_theme_id", "child_theme_id", "created_at", "updated_at" FROM "child_themes"
WHERE "parent_theme_id" = 4076 GROUP BY "id", "parent_theme_id", "child_theme_id", "created_at",
"updated_at";
