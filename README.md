# Github Open-Source-based SQL Benchmark (GOSSB)

This SQL query benchmark including schemas for MS SQL Server for 7 databases, 3 types of queries (original queries with issues, queries manually optimized by human experts, queries optimized by Calcite) 

### Specification

| Database | Number of relations | Total #attributes | Avg. #attribute | #q | #q (full) |
|--|--|--|--|--|--|
| [diaspora](https://github.com/diaspora/diaspora) | 49 | 375 | 7.65 | 1 | - |
| [discoure](https://github.com/discourse/discourse) | 155 | 1378 | 8.89 | 15 | - |
| [gitlab](https://gitlab.com/gitlab-org/gitlab) | 332 | 3141 | 9.46 | 25 | - |
| [lobsters](https://github.com/lobsters/lobsters) | 22 | 178 | 8.09 | 2 | - |
| [redmine](https://github.com/redmine/redmine) | 56 | 407 | 7.27 | 2 | - |
| [solidus](https://github.com/solidusio/solidus) | 98 | 808 | 8.24 | 1 | - |
| [spree](https://github.com/spree/spree) | 87 | 727 | 8.36 | 4 | - |

*Full versions including 8000+ queries planned for release

### Usage

// 

### Query Source

| Query No. | Database (Repo) | Rewritting Type | Issue URL |
|------|------------|------------------------------------|-------------|
| 2 | discourse | Predicate Elimination | https://github.com/discourse/discourse/commit/f364317625ee273d1e8983faa271831db912953b |
| 3 | discourse | DISTINCT elimination | https://github.com/discourse/discourse/commit/5cef71e885004d32c5ee19382389773ecc80e6c8 |
| 4 | discourse | Subquery to join | https://github.com/discourse/discourse/commit/6525613b89219036ebc461c48658b67e9ae7abbd |
| 5 | discourse | OR to union | https://github.com/discourse/discourse/commit/ac80360bea2ce4c9e93a38395d16e2ecc2cee2ed |
| 6 | discourse | Subquery to predicate | https://github.com/discourse/discourse/commit/248bebb8cdb7f8f2cb104d91a08e529b36224f6d |
| 7 | discourse | Predicate pushdown | https://github.com/discourse/discourse/commit/1fdeec564ba903571763b8372b97636e76c6bfb1 |
| 8 | discourse | Subquery elimination | https://github.com/discourse/discourse/commit/e6f73a1c802442715bc41cf8ce93d0ae44a06547 |
| 10 | discourse | Subquery to join | https://github.com/discourse/discourse/commit/f0f3deb32b84c87390aa9323597c13818bd6084a |
| 11 | discourse | Subquery to join | https://github.com/discourse/discourse/commit/03f63d970bb683e0e33097d39d8ae78d786b0309 |
| 12 | discourse | Subquery to join | https://github.com/discourse/discourse/commit/1f062ae2fde43a44f407f4af91a190c8c02fb1e0 |
| 13 | discourse | Subquery elimination | https://github.com/discourse/discourse/commit/e564614b7030d79910c481d3d8cbe933201d2f56 |
| 14 | discourse | Subquery to join | https://github.com/discourse/discourse/commit/63292cecd9e52751b1ce173799951b88886e60d7 |
| 15 | discourse | Subquery to join | https://github.com/discourse/discourse/commit/5a77f6218101b85b360d2ec564928d863bc91964 |
| 17 | discourse | Subquery to join | https://github.com/discourse/discourse/commit/28148197d6467cdc7469409f961c00d4e32f4c41 |
| 18 | discourse | OR to union | https://github.com/discourse/discourse/commit/fcfce3e426a64ffa567c572eeeaeb2ef700b15dc |
| 19 | gitlab | OrderBy Elimination | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/aada01030cd23719a54a4e499b72c12f95ce0d24 |
| 21 | gitlab | Predicate pushup | https://gitlab.com/gitlab-org/gitlab/-/commit/3205efc1a4652fdf06132fefc0e59999dedac5b4 |
| 22 | gitlab | Join Elimination | https://gitlab.com/gitlab-org/gitlab/-/commit/f40d8c1ce0e1f19b12aa85f40a9c3e2f8f1e853a |
| 23 | gitlab | Join Elimination | https://gitlab.com/gitlab-org/gitlab/-/commit/a6cf8fa55266a6ed95619972a7993cf1e8603977 |
| 24 | gitlab | Join Elimination | https://gitlab.com/gitlab-org/gitlab/-/commit/fbc3f8bb6ed93196f28f835e6045d7339c2ae592 |
| 25 | gitlab | Predicate Elimination | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/cdfe437e8eaad61acf0ba7f2be719ef03d724493 |
| 26 | gitlab | Subquery to join | https://gitlab.com/gitlab-org/gitlab/-/commit/86174a1b88d57c8630b3703a88723dee0d01a71c |
| 27 | gitlab | OR to union | https://gitlab.com/gitlab-org/gitlab/-/commit/aed26bfc724be55275a7e90ba06bdae091915ae1?merge_request_iid=2196 |
| 28 | gitlab | OR to union | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/c16b99a49c58161971d1a86613930be439385f02 |
| 29 | gitlab | Replace column used in predicate | https://gitlab.com/gitlab-org/gitlab/-/commit/11e93a9a4c2ac1b5bd4d32a93a949fc8afbcc449?merge_request_iid=5348 |
| 30 | gitlab | Replace column used in predicate | https://gitlab.com/gitlab-org/gitlab/-/commit/4626bed943fbb84f4b3948c07ae496e7559948a4 |
| 31 | gitlab | Union to OR | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/4ae25fdb6d335d6b4fa091f1b8d197a3fb753e94 |
| 32 | gitlab | Subquery elimination | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/f09fe848da02189a3dafe2d532fefb1379eacac4?merge_request_iid=17462 |
| 34 | gitlab | Subquery elimination | https://gitlab.com/gitlab-org/gitlab/-/commit/66d48385ecaf46b7ddfe0bd33440baaf4ff81a77 |
| 35 | gitlab | Subquery to join | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/9127ae5ca80aa06b0a83d275e2a2d9b7ccfbfc3d |
| 37 | gitlab | Group by elimination | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/0f1452c2d1a59f8460b01eee7ae4a1ef51f41514?merge_request_iid=10573 |
| 39 | gitlab | Subquery to join | https://gitlab.com/gitlab-org/gitlab/-/commit/a9fcc790dd9b47d51d322845226d625e140b79c8 |
| 40 | gitlab | OR to union | https://gitlab.com/gitlab-org/gitlab/-/commit/271e7a325340551475ae937aaf2ed7a6344be9e8 |
| 41 | gitlab | OR to union | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/d13aebabc36b6f5fcf41ba32a9c6ee45b91daf3f?merge_request_iid=17088 |
| 42 | gitlab | Subquery to join | https://gitlab.com/gitlab-org/gitlab/-/commit/cd063eec32a8b32d9b118f6cbdb0e96de0d0ec51 |
| 43 | gitlab | Subquery to join | https://gitlab.com/gitlab-org/gitlab/-/commit/b603a513cf6ce28cbcd16f330daf9325aa8a77eb |
| 44 | gitlab | OR to union | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/df7d65a7aa213834b25f9480d6debc22c6315630?merge_request_iid=17190 |
| 45 | gitlab | Subquery elimination | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/f66c00adc6d475162b14eed29290923e9ea8a25f?merge_request_iid=32679 |
| 46 | gitlab | Subquery elimination | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/6c46656afc372124d25c22648ecccc9d9c0ff016?merge_request_iid=14022 |
| 47 | gitlab | Union to OR | https://gitlab.com/gitlab-org/gitlab-foss/-/commit/d29347220c07ab0191cf208d3775475c7b5d71ca?merge_request_iid=12135 |
| 50 | spree | Group by elimination | https://github.com/spree/spree/commit/53edfb882b7867995ae0ab4df4ae9adad8fb3bec |
| 51 | spree | Join Elimination | https://github.com/spree/spree/commit/6a5f22c054fa3f0e6ef9a6bbc47502191336a170 |
| 53 | spree | Join Elimination | https://github.com/spree/spree/commit/4f7e121cc2c6f519ae429e592648b15c93aa6837 |
| 54 | spree | OR to union (left join to inner join | https://github.com/spree/spree/commit/715d4439f4f02a1d75b8adac74b77dd445b61908 |
| 57 | diaspora | Join Elimination | https://github.com/diaspora/diaspora/commit/24fffc022096da41ac0dccc1ceae0ed59839ad76 |
| 64 | redmine | Predicate pushdown | https://github.com/redmine/redmine/commit/402d73914634e0e0a2ec06cc94e7b3ec13275546 |
| 65 | redmine | Subquery to join | https://github.com/redmine/redmine/commit/10b3e3e32394216fd8700635e71fd25ea52dfda1 |
| 79 | solidus | Join Elimination | https://github.com/solidusio/solidus/commit/6a5f22c054fa3f0e6ef9a6bbc47502191336a170 |
| 88 | lobsters | Predicate pushdown | https://github.com/lobsters/lobsters/commit/22bb4cb069bf012ef5eb9719de621a91eca4219a |
| 134 | lobsters | Join Elimination | https://github.com/opf/openproject/commit/91ff59a41d4a1893381cbd70e6dfd1c2fd39a337 |
