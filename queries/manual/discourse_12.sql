SELECT * FROM category_users WHERE user_id IN (SELECT cu.user_id FROM category_users cu LEFT JOIN users u ON u.id = cu.user_id WHERE u.id IS NULL);
