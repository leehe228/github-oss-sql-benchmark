SELECT users.* FROM users INNER JOIN group_users ON group_users.user_id = users.id WHERE active IS TRUE AND group_users.group_id = 8861 LIMIT 20;
