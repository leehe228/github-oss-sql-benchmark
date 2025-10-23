SELECT `t`.`id`, `t`.`description`, `t`.`expires_at`, `t`.`starts_at`, `t`.`name`, `t`.`type`,
`t`.`usage_limit`, `t`.`match_policy`, `t`.`code`, `t`.`advertise`, `t`.`path`, `t`.`created_at`,
`t`.`updated_at`, `t`.`promotion_category_id` FROM (SELECT * FROM `spree_promotions` WHERE
(`starts_at` IS NULL OR `starts_at` < TIMESTAMP '2020-05-06 04:33:11') AND (`expires_at` IS
NULL OR `expires_at` > TIMESTAMP '2020-05-06 04:33:11')) AS `t` LEFT JOIN (SELECT `order_id`,
`promotion_id` FROM `spree_order_promotions`) AS `t0` ON `t`.`id` = `t0`.`promotion_id` WHERE
`t`.`code` IS NULL AND `t`.`path` IS NULL OR `t0`.`order_id` = 1 GROUP BY `t`.`id`, `t`.`description`,
`t`.`expires_at`, `t`.`starts_at`, `t`.`name`, `t`.`type`, `t`.`usage_limit`, `t`.`match_policy`,
`t`.`code`, `t`.`advertise`, `t`.`path`, `t`.`created_at`, `t`.`updated_at`, `t`.`promotion_category_id`;
