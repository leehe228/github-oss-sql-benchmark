SELECT `t`.`id`, `t`.`name`, `t`.`description`, `t`.`available_on`, `t`.`discontinue_on`, `t`.`deleted_at`,
`t`.`slug`, `t`.`meta_description`, `t`.`meta_keywords`, `t`.`tax_category_id`, `t`.`shipping_category_id`,
`t`.`created_at`, `t`.`updated_at`, `t`.`promotionable`, `t`.`meta_title` FROM (SELECT * FROM
`spree_products` WHERE `deleted_at` IS NULL) AS `t` INNER JOIN (SELECT `product_id` AS `PRODUCT_ID`
FROM `spree_variants` GROUP BY `product_id` HAVING COALESCE(SUM(`count_on_hand`), 0) > 0) AS
`t2` ON `t`.`id` = `t2`.`PRODUCT_ID` LIMIT 100;
