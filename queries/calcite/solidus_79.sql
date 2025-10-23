SELECT `spree_promotions`.`id`, `spree_promotions`.`description`, `spree_promotions`.`expires_at`,
`spree_promotions`.`starts_at`, `spree_promotions`.`name`, `spree_promotions`.`type`, `spree_promotions`.`usage_limit`,
`spree_promotions`.`match_policy`, `spree_promotions`.`advertise`, `spree_promotions`.`path`,
`spree_promotions`.`created_at`, `spree_promotions`.`updated_at`, `spree_promotions`.`promotion_category_id`,
`spree_promotions`.`per_code_usage_limit`, `spree_promotions`.`apply_automatically` FROM `spree_promotions`
INNER JOIN (SELECT `order_id`, `promotion_id` FROM `spree_orders_promotions`) AS `t` ON `spree_promotions`.`id`
= `t`.`promotion_id` INNER JOIN (SELECT `id` FROM `spree_orders`) AS `t0` ON `t`.`order_id`
= `t0`.`id` GROUP BY `spree_promotions`.`id`, `spree_promotions`.`description`, `spree_promotions`.`expires_at`,
`spree_promotions`.`starts_at`, `spree_promotions`.`name`, `spree_promotions`.`type`, `spree_promotions`.`usage_limit`,
`spree_promotions`.`match_policy`, `spree_promotions`.`advertise`, `spree_promotions`.`path`,
`spree_promotions`.`created_at`, `spree_promotions`.`updated_at`, `spree_promotions`.`promotion_category_id`,
`spree_promotions`.`per_code_usage_limit`, `spree_promotions`.`apply_automatically`;
