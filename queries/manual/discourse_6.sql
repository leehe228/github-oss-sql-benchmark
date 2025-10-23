SELECT * FROM posts INNER JOIN topics ON topics.id = posts.topic_id INNER JOIN categories ON categories.id = topics.category_id WHERE categories.search_priority <> 5;
