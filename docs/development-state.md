# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing; prefer
ownership, borrowing and moves; reserve ARC for necessary sharing. JIT is excluded.

## Current delivery and next action

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) is accepted and merged as
`27a3e009b83e28f06130a5d686a3196b9934e53f`. Its nine production jobs, documentation
and binary inspection passed. [History](roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198)
records its results and remaining numerical performance gaps.

[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199) is the only open delivery.
Worktree: `/private/tmp/fwp-checked-native-default`, branch `checked-native-default`.
The primary checkout is detached at #198 and holds the live handoff. Preparation
worktrees and their evidence are retained; they are not separate pending PRs.

Source `df84b726cc2a2a37fbaf7c1cca53aacc93cc8bb8` passed focused run `39922765292`:
65 integration tests across twenty targets, 179 library tests and independent
compiler, ownership inventory and coverage audits. The complete log has no
errors or unexpected diagnostics. All 95 saved GCC/AMD64 images passed inspection:
three default builds, twelve allocator probes and eighty record outcomes.

The following workflow-only repair adds two missing Windows record targets,
sets ARC artifact output for the whole job, and uploads the whole ownership
evidence directory. Compiler, runtime and tests remain identical to the focused
source. Documentation records the result. Do not repeat unchanged focused work;
require the full matrix and binary inspection on the new exact commit.

**Next:** publish the workflow repair with `/private/tmp/fwp-publish-windows-evidence.py`,
then register production/documentation runs with `/private/tmp/fwp-discover-199-runs.py`.
Audit every final job and inspect actual binaries on all six native platforms.
After all gates pass, squash-merge using `/private/tmp/fwp-merge-199.py`: one-line
subject, at most eighty characters, empty body, no trailers or attribution.
Verify tree, sole parent and message; then continue PLAN.md. No approval is pending.

The publication helper is UNRUN in this snapshot. Check its receipt before use:
`/private/tmp/fwp-windows-evidence-publication.json`. The current exact source and
run IDs live in `/private/tmp/fwp-default-ownership-publication.json`. Do not rerun
completed publication or dispatch helpers. The earlier focused-ready helper is
superseded by this workflow-only publication; no extra focused dispatch is needed.

## Changes and repairs

Native commands, builds, modules and compiler APIs select checked ARC by default.
Unproved ownership is a compile error. Explicit tracing remains available; this
does not complete GC removal. Python disassembly requires an explicit ownership
mode. Collector tests request tracing; ordinary native tests compare ARC,
interpreter and saved output. Independent CI checks continue after failures.

Static-heap pressure now forces a full collection and rechecks freed small slots
before exhaustion. Tests retain the original 1 MiB limit and demonstrate failures
when either repair is removed. ARC excludes mark storage, age checks, collector
stack discovery and late poisoning of released objects, arrays, files and sockets.
Page metadata falls from 4,648 to 4,128 bytes; counts remain 4,096 bytes.
[The layout report](measurements/arc-metadata.md) makes no timing or process-memory claim.

[Record checks](measurements/record-cleanup.md) run updates, copies and field
conversions in ARC and tracing. They repeat 32 rounds, requiring ARC byte balance,
no wide-count entries and no collections. Missing releases fail. Five old overflow
fixtures restored auxiliary counts but left inline marker 255, preventing their
final frees. One round retained 64 bytes and four entries. They now restore the
fixture's real sole owner with `fwp_rc_fresh`; broken-cleanup controls detect the
old defect. This is a fixture repair, with no change to runtime ownership rules.

Guides now link accepted callbacks, manual pointers, REST/MCP, task storage and
range sets to delivery history. The primitive guide correctly describes unique
ASCII case-conversion reuse. All superseded full logs have been audited; the
latest old run `39918185432` has only seven requested cancellation errors, with
no hidden test failures. Cancellation is not acceptance.

## Verification and resume tools

Local checks use `python3 scripts/local-guard.py COMMAND...`, serially. Full
builds, suites and measurements stay on GitHub. Preserve at least 64 GiB free,
generated target data below 2 GiB, sampled workload RSS below 1 GiB and the
180-second deadline. Never raise or bypass limits.

- Focused audit: `/private/tmp/fwp-record-cleanup-focused-acceptance.json`.
- Focused binary report: `/private/tmp/fwp-default-ownership-evidence/df84b726cc2a/ubuntu-latest-39922765292.json`;
  guarded inspection took 12.40 seconds.
- `/private/tmp/fwp-check-windows-evidence.py`: both Windows hosts select all seven
  saved-image targets and upload their shared directory; thirteen existing runner
  controls also pass (7.91 seconds).
- Local record checks: `/private/tmp/fwp-record-rounds/results.json` and
  `/private/tmp/fwp-wide-fixtures/results.json`, 26 ARM64 binaries/36 observations.
  These use the accepted #197 compiler with the current runtime substituted;
  they do not establish new-compiler or cross-platform acceptance.
- Original fixture leak: `/private/tmp/fwp-record-fixture-leak.json`.
- Superseded full audit: `/private/tmp/fwp-199-production-acceptance-5f3e7e53.json`.

`/private/tmp/fwp-audit-199-final.py` audits all final production/documentation
logs and exact-source PR checks. `/private/tmp/fwp-inspect-default-builds.py`
requires 95 images per host and sixty allocator observations. On macOS, provide
both regular and GC artifact/job arguments: record updates/conversions and variants
are regular; general copies and retain probes are GC. Windows legitimately uses
stack-bound APIs for contexts/static storage; inspect collector startup at O0.
The ARM64 resolver has passed old-binary controls.

`/private/tmp/fwp-merge-199.py` requires all six binary reports and all ten checks.
`/private/tmp/fwp-after-merge-199.py` preserves the primary handoff, moves its
detached checkout and cancels only redundant same-tree main production CI,
keeping documentation. Both helpers are UNRUN. Archive receipts before changing
sources; preserve prior evidence. No numerical optimization has been selected.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
