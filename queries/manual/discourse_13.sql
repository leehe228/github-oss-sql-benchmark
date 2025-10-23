SELECT group_users.* FROM group_users JOIN (SELECT users.id FROM users WHERE NOT users.admin IS TRUE) u ON group_users.user_id = u.id;
