# sfdc-trailhead


This repository *intentionally* contains many over-engineered solutions woven into a rat's nest of spaghetti and lasagna.
It should not be mistaken for production quality code.

## What are my intentions here?

1. To enrich my knowledge of SFDC.
2. To record interesting approaches to solutions.
3. To separate concerns.
4. To minimize code duplication.
5. To practice solving probably in a field that is far from green.
6. To balance time spent "developing new features" against time spent refactoring.

## Known issues

1. More layers than necessary to solve most probably ("lasagna code").
2. Frequently delegating methods from one object to the next ("feature envy").
3. Building solutions around low-quality code because those parts of the problem don't interest me ("lava flow")
4. Incomplete features, todos, fix-mes, and dead code
5. Duplicate code.
6. Inconsistent interfaces.
7. "Unit of Work" is creating more problems than it is solving through inconsistent and mis- use.
8. Tests are sometimes over-complicated or over-specified.
9. Incomplete, useless, and failing tests.
10. Tests are often at questionable levels, either testing private methods or integration.
11. Mock factories are too complicated.
