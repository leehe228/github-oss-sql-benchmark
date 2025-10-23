SELECT * FROM projects WHERE projects.status <> 'ARCHIVED' AND EXISTS (SELECT 1 AS one FROM enabled_modules em WHERE em.project_id = projects.id AND em.name = 'default');
