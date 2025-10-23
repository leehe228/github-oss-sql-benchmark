SELECT issues.* FROM issues INNER JOIN milestone_releases ON issues.milestone_id = milestone_releases.milestone_id INNER JOIN releases ON milestone_releases.release_id = releases.id;
