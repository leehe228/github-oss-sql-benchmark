SELECT `projects`.`id`, `projects`.`name`, `projects`.`description`, `projects`.`homepage`,
`projects`.`is_public`, `projects`.`parent_id`, `projects`.`created_on`, `projects`.`updated_on`,
`projects`.`identifier`, `projects`.`status`, `projects`.`lft`, `projects`.`rgt`, `projects`.`inherit_members`,
`projects`.`default_version_id`, `projects`.`default_assigned_to_id` FROM `projects` INNER
JOIN (SELECT `project_id` FROM `enabled_modules` WHERE `name` = 'default' GROUP BY `project_id`)
AS `t0` ON `projects`.`id` = `t0`.`project_id` WHERE `projects`.`status` <> 'ARCHIVED';
