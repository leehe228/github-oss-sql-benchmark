SELECT COUNT(DISTINCT topics.id) FROM topics INNER JOIN posts ON topics.id = posts.topic_id AND topics.user_id <> posts.user_id WHERE posts.deleted_at IS NULL AND posts.user_id = 9627;
