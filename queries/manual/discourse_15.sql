SELECT notifications.* FROM notifications LEFT JOIN topics ON notifications.topic_id = topics.id AND topics.deleted_at IS NULL;
