# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current delivery and preparation

**Next:** finish [PR #203](https://github.com/e6qu/fun-with-pipes/pull/203) at
`460e847b34a7b2691b69f89a4dfea84ea25950b7`. Require nine production jobs,
docs and 853 inspected binaries on each native host before squash merge.
Its source remains unchanged while this preparation extends the next grouped PR.

Worktree `/private/tmp/fwp-derivative-growth`, branch
`derivative-growth-preparation`, adds derivative capacity and workspace checks to
`7bd18c374797e427872723382e34452bdab64613`. That parent includes derivative
buffers/scopes, borrowed callbacks and arrays. The combined six-group extension
adds 308 local outcomes; the focused selection now has 50 targets and expects
1,161 saved binary images per host. Final delivery requires all six native hosts.

## Actual checks and limits

The three added checks pass locally: capacity failures 24 outcomes (7.48s),
weight transfers 44 (8.30s), unused suffix 48 (8.19s). Generated C and actual
ARM64 binaries were inspected at `-O1` and `-O2`. The existing accepted compiler
`5e17fc10e860b1971ffc9cd9cb57fcb795ccad24` has unchanged runtime/compiler
sources. Fixtures now own their temporary records, lists, input/result arrays and
tape scopes explicitly. Missing-release controls fail. They repeat 32 rounds;
workspace checks cover caching enabled and disabled. No production code changed.

Receipts: `/private/tmp/fwp-growth-{capacity,operations,prefix}/results.json`.
The previous four groups retain 192 passing local outcomes. Their first combined
focused run failed compilation because the array artifact helper was undeclared;
all three failure logs were audited and the declaration repaired in the parent.
Its repaired focused jobs remain separate evidence, not final acceptance here.

## Resume records

`/private/tmp/fwp-task-publication.json` identifies the active delivery.
`fwp-growth-preparation.json` will identify this preparation and its focused runs.
Use `fwp-audit-growth-focused.py`, its Windows variant, and
`fwp-inspect-growth-builds.py` for the 1,161-image inspection. Download archives
explicitly with `fwp-download-artifact-ranges.py` first. Preserve source tags,
complete logs, failure evidence and binary reports. Do not repeat completed
publication/merge helpers. Final delivery helpers must include both added groups;
older four-group helpers expect only 1,045 images and must not accept this source.

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, suites and
benchmarks stay on GitHub. Keep the fixed CPU, RSS, disk and deadline limits.

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
Fewer allocations alone do not establish parity. Preserve measured controls and
separate callback, indexing, output and buffer costs before selecting changes.
