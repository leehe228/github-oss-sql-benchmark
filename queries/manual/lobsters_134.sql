SELECT users.* FROM users WHERE users.id IN (SELECT c.user_id FROM comments AS c WHERE c.story_id = 8895);
