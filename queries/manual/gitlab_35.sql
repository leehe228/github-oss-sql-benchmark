SELECT issues.* FROM issues LEFT OUTER JOIN label_links ON label_links.target_type = 'default' AND label_links.target_id = issues.id WHERE label_links.target_id IS NULL;
