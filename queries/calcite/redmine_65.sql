SELECT `t1`.`id`, `t1`.`tracker_id`, `t1`.`project_id`, `t1`.`subject`, `t1`.`description`,
`t1`.`due_date`, `t1`.`category_id`, `t1`.`status_id`, `t1`.`assigned_to_id`, `t1`.`priority_id`,
`t1`.`fixed_version_id`, `t1`.`author_id`, `t1`.`lock_version`, `t1`.`created_on`, `t1`.`updated_on`,
`t1`.`start_date`, `t1`.`done_ratio`, `t1`.`estimated_hours`, `t1`.`parent_id`, `t1`.`root_id`,
`t1`.`lft`, `t1`.`rgt`, `t1`.`is_private`, `t1`.`closed_on` FROM (SELECT `issues`.`id`, `issues`.`tracker_id`,
`issues`.`project_id`, `issues`.`subject`, `issues`.`description`, `issues`.`due_date`, `issues`.`category_id`,
`issues`.`status_id`, `issues`.`assigned_to_id`, `issues`.`priority_id`, `issues`.`fixed_version_id`,
`issues`.`author_id`, `issues`.`lock_version`, `issues`.`created_on`, `issues`.`updated_on`,
`issues`.`start_date`, `issues`.`done_ratio`, `issues`.`estimated_hours`, `issues`.`parent_id`,
`issues`.`root_id`, `issues`.`lft`, `issues`.`rgt`, `issues`.`is_private`, `issues`.`closed_on`,
`t0`.`root_id` AS `root_id0` FROM `issues` INNER JOIN (SELECT `root_id` FROM `issues` WHERE
`id` = 1 GROUP BY `root_id`) AS `t0` ON `issues`.`root_id` = `t0`.`root_id` ORDER BY `issues`.`id`
IS NULL, `issues`.`id`) AS `t1`;
