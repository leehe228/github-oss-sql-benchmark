SELECT `story_id` AS `STORY_ID`, TRUE AS `i` FROM `hidden_stories` WHERE `user_id` = 1 GROUP
BY `story_id`, TRUE;

SELECT * FROM `comments` WHERE NOT `is_deleted` AND NOT `is_moderated`;

SELECT COUNT(*) AS `c`, COUNT(*) AS `ck` FROM `hidden_stories` WHERE `user_id` = 1;
