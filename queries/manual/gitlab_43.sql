SELECT * FROM (SELECT * FROM users WHERE email = 'abc@163.com' UNION ALL SELECT users.* FROM users INNER JOIN emails ON users.id = emails.user_id WHERE emails.email = 'xyz@163.com') subquery LIMIT 1;
