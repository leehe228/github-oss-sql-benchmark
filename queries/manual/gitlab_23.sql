SELECT COUNT(*) FROM project_repository_states WHERE project_repository_states.wiki_verification_checksum IS NOT NULL AND project_repository_states.last_wiki_verification_failure IS NULL;
