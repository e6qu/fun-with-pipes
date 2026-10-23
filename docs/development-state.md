# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing, prefer
ownership and borrowing, and reserve ARC for necessary sharing. JIT is excluded.

## Accepted foundation

[PR #200](https://github.com/e6qu/fun-with-pipes/pull/200) merged as
`a57a2593a11178934cba33dffb3f0e2fafa15fcc` after nine production jobs, documentation and inspection of
1,050 saved binaries passed at `69c3b1e0135dd95961dba3729911ec27dc1736b6`. Complete logs were audited;
the squash tree, sole parent and one-line message were verified.
[History](roadmap-history.md#repeated-constructor-and-call-cleanup-pr-200) and the
[inspection record](measurements/constructor-cleanup-2026-10-23.json) retain evidence.
Checked ARC is the native default; explicit tracing still exists.

## Current delivery and next action

Worktree: `/private/tmp/fwp-collection-delivery`, branch `collection-cleanup-delivery`, based on the accepted
merge. The clean preparation source `96dce6277c00d0afa9751b207686bc01e127c2d1` and its immutable tag
`roadmap/preparation-collection-cleanup-96dce6277c00` remain preserved in `/private/tmp/fwp-post-constructor-collections`.

**Next:** check documentation and the unchanged code/workflow comparison against
that preparation, then publish one PR and run all nine production jobs plus
documentation on its final source. Focused run `39942810768` passed all
28 targets and its complete log audit; 331 GCC images passed inspection. Only
ancestry and acceptance documentation changed afterward, so do not repeat that
focused run. Inspect the six final native artifact sets before squash merge.
Use one subject of at most eighty characters and an explicit empty body. Continue
PLAN.md afterward; no approval is pending.

## Changes and checks

Four probes repeat loop, map, filter/take-while and zip cleanup in ARC and tracing,
including callback/allocation failures, cancellation, aliases and scalar address
bits. Missing releases, temporary-buffer cleanup and loop cleanup must fail.
Thirteen related probes now save C, binaries and output before asserting success,
preserving evidence when an unexpected failure occurs. Focused CI selects 28
targets, all covered by Windows and exactly one macOS shard. The
[collection guide](measurements/collection-cleanup.md) explains an executed example.
Compiler behavior and language syntax are unchanged.

Local checks use accepted compiler `5e17fc10` with its unchanged runtime: 172
Apple Clang ARM64 images pass, including sixteen complete O1/O2 programs compared
with raw interpretation. Final fixture/C/binary hashes, formatting, links, thirteen
runner controls, scheduling and the guide example pass. Receipts:
`/private/tmp/fwp-loop-current/{results,inspection}.json`,
`/private/tmp/fwp-collections-current/{map,selection,zip}/results.json` and
`/private/tmp/fwp-collection-current-proof-links.json`.

Focused acceptance: `/private/tmp/fwp-collection-focused-acceptance.json`.
Binary report: `/private/tmp/fwp-collection-ownership-evidence/96dce6277c00/ubuntu-latest-39942810768.json`. Final native acceptance remains required.
Field/match source checks are a separate unpublished preparation in
`/private/tmp/fwp-post-collection-aliases`; they are outside this delivery and
still need verification. Reuse-token probes remain unextended.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local checks;
full builds and suites stay on GitHub. Keep 64 GiB free, target data below 2 GiB,
sampled workload RSS below 1 GiB and the 180-second deadline. Never raise limits.

## Resume records

`/private/tmp/fwp-200-merge.json` records the verified merge.
`/private/tmp/fwp-collection-preparation.json` records the preparation source/tag.
Publication and mutation helpers for that preparation have COMPLETED; do not rerun.
`/private/tmp/fwp-prepare-collection-delivery.py` COMPLETED this transplant and
acceptance documentation. Preserve the original worktrees and evidence.
The preparation inspector is `/private/tmp/fwp-inspect-collection-builds.py`;
its current root is the preparation worktree. Final delivery inspection needs
an explicit delivery-root copy and the final source, not the preparation source.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

The largest measured descent case still takes about 10–14 times the C/Rust time.
Fewer allocations alone do not establish parity; the inlining experiment did not
pass its speed screen. The plan retains the remaining contracts and measurements.
