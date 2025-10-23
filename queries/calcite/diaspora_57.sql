SELECT `posts`.`id`, `posts`.`author_id`, `posts`.`public`, `posts`.`guid`, `posts`.`type`,
`posts`.`text`, `posts`.`created_at`, `posts`.`updated_at`, `posts`.`provider_display_name`,
`posts`.`root_guid`, `posts`.`likes_count`, `posts`.`comments_count`, `posts`.`o_embed_cache_id`,
`posts`.`reshares_count`, `posts`.`interacted_at`, `posts`.`tweet_id`, `posts`.`open_graph_cache_id`,
`posts`.`tumblr_ids` FROM (SELECT `id` FROM `people` WHERE `id` = 1) AS `t0` INNER JOIN `posts`
ON `t0`.`id` = `posts`.`author_id` INNER JOIN ((SELECT `id` FROM `aspects` WHERE `id` = 1)
AS `t2` INNER JOIN (SELECT `shareable_id`, `aspect_id` FROM `aspect_visibilities`) AS `t3`
ON `t2`.`id` = `t3`.`aspect_id`) ON `posts`.`id` = `t3`.`shareable_id`;
