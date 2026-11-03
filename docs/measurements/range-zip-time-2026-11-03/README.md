# Range consumer runtime comparison

**Status:** measurement requested; no completed timing results yet. Source
`3be9479c4150d7aae5695d7f7aa4ce3f84d0f738` is frozen as
`roadmap/range-zip-measurement-2026-11-03`. The reference disables only private
range consumption in the same source. [Contract, inputs and timing scope](../range-zip-storage.md).

Original run `41603246961` requests two sessions on each architecture.
Both AMD64 jobs stopped before building because GitHub supplied EPYC 9V74;
the frozen CPU is EPYC 7763. Both full logs contain only the expected host-rejection
exit. Source, artifact digests and skipped build/timing steps are verified.
These are host rejections, not measured regressions.

| Session | Job | Evidence |
|---|---:|---|
| AMD64 1 | 125806772756 | [Host and job](rejected-hosts/initial-amd1.json), [full log](rejected-hosts/initial-amd1.log.gz) |
| AMD64 2 | 125806772669 | [Host and job](rejected-hosts/initial-amd2.json), [full log](rejected-hosts/initial-amd2.log.gz) |

Replacement run `41603882629` requests only these two unmeasured AMD64 sessions.
Both replacements qualified and are measuring: session 1 `125808854223`,
session 2 `125808854159`. The original ARM64 sessions remain active.
Keep source, CPU, driver, inputs and
limits fixed; retain every completed timing outcome without retries for a pass.
