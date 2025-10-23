SELECT DISTINCT * FROM issues i1 INNER JOIN (SELECT root_id FROM issues WHERE id IN (1)) i2 ON i1.root_id = i2.root_id ORDER BY id;
