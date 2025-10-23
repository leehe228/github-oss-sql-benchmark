SELECT DISTINCT * FROM tags INNER JOIN taggings ON tags.id = taggings.tag_id WHERE taggable_type = 'default';
