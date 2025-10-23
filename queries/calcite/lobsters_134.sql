SELECT `t0`.`id` AS `ID`, TRUE AS `i` FROM (SELECT `comment_id` FROM `moderations`) AS `t`
INNER JOIN ((SELECT `id` FROM `users`) AS `t0` INNER JOIN (SELECT `id`, `story_id`, `user_id`
FROM `comments` WHERE `story_id` = 8895) AS `t2` ON `t0`.`id` = `t2`.`user_id`) ON `t`.`comment_id`
= `t2`.`id` GROUP BY `t0`.`id`, TRUE;

SELECT * FROM `users`;

SELECT COUNT(*) AS `c`, COUNT(*) AS `ck` FROM (SELECT `comment_id` FROM `moderations`) AS `t`
INNER JOIN ((SELECT `id` FROM `users`) AS `t0` INNER JOIN (SELECT `id`, `story_id`, `user_id`
FROM `comments` WHERE `story_id` = 8895) AS `t2` ON `t0`.`id` = `t2`.`user_id`) ON `t`.`comment_id`
= `t2`.`id`;
