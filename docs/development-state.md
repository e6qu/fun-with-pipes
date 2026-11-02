# Current work

**Next:** deliver `current-kernel-costs`: finish the documentation audit, then run
all nine production jobs on the final head and squash-merge only after they pass.
Keep one active PR. Use `gh pr view` from the branch to find its exact head and
checks. Do not rerun completed numerical sessions or change a passing CI head.

Worktree: `/private/tmp/fwp-current-kernel-costs`. The branch was rebased onto
verified #242 squash merge `10b9bbff10afd97cb6ce653b1bf9c4aaea5f2531`; measured
source commits remain available through the tags below. #242's nine production
jobs and docs pass, all logs are audited, and its merge tree/message are verified.
[History](roadmap-history.md#numeric-callbacks-and-inline-cleanup-pr-242) holds the
delivery record. Duplicate merge-tree runs were cancelled after that verification.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Protocol `818731e3` published before implementation; #242 fully verified and merged as `10b9bbff` |
| 2 | Verified | Paired reference and six-program runner pass correctness/memory audits; damaged-evidence controls pass; no production compiler change |
| 3 | Verified | Four sessions retained; raw audit `41407524129` passes; four speed and nine copy limits remain open |
| 4 | In progress | Reproducible current costs and concrete matrix follow-up documented; documentation audit and final production gates remain |

The [protocol](measurements/current-kernel-costs.md) fixes the inputs, hosts,
timing scopes and rules. The historical AMD64 array slowdown predates typed loop
state (#227); it is not current overhead. Bounds-proved array increments already
wrap, and typed double state already exists. Neither fact proves a speedup.

## Current measurements

[Selected runs and jobs](measurements/current-kernel-selection.json) retain all
attempts. Sources `b9da15a1` and `9f6d0f7c` have identical compiler/runtime/library
trees; the latter changes only the isolated reference's expected layout checks.

| Architecture/session | Job | Current result |
|---|---|---|
| ARM64 / 2 | `125141953515` | Raw audit passes; array ratios 0.99814 and 1.00141 miss the required 0.95 |
| AMD64 / 2 | `125145128971` | Raw audit passes; small array and small matrix identical-copy controls exceed 2% |
| ARM64 / 1 | `125147087471` | Reference and raw checks pass; both array speed targets miss |
| AMD64 / 1 | `125147087334` | Reference and raw checks pass; five array copy limits miss |

Six hosts were rejected before building or timing; their logs and qualification
records remain selected. Initial ARM session 1 (`125141953749`) failed only two
reference assertions expecting `double v3`, while its declared word-state layout
uses `V v3`. Repair `9f6d0f7c` changes those expectations only in the isolated
reference checkout, retaining alias, failure, cancellation and cleanup checks.
That job never timed; completed sessions are not rerun to seek passing limits.

The independent report job `125152829956`, run `41407524129`, passes at `c3add130`.
It checks raw streams, actual binaries, compiler patches and every decision.
Retained summaries/data are in `docs/measurements/current-kernels-2026-11-02/`;
artifact `13123504113` and full audit log hashes are recorded in `download.json`.
The docs workflow recomputes the committed tables from retained observations.

Qualified large-matrix calculation costs about 65% more time than C on AMD64,
6% more on ARM64. Both kernels perform zero effective retains; array allocation
count matches peers, matrices add two input records. PLAN.md now specifies the
next source-level matrix investigation and its safety/measurement requirements.
No new compiler optimization is selected in this measurement batch.

## Verification and source retention

- Protocol tag: `roadmap/current-kernel-costs-protocol-2026-11-02` (`818731e3`).
- Initial measured-source tag: `roadmap/current-kernel-initial-measurements-2026-11-02`
  (`b9da15a1`). Repaired checks retained by
  `roadmap/current-kernel-reference-checks-2026-11-02` (`9f6d0f7c`);
  audit by `roadmap/current-kernel-audit-2026-11-02` (`c3add130`).
- Guarded local checks: reference preparation 4 tests (0.13s); scheduling and
  decisions 7 (0.13s); damaged evidence 10 (4.28s); job retention 4 (0.13s);
  report normalization 2 (0.13s); actionlint (6.73s); roadmap/link/commit audit (3.13s). No local full build or timing.
- #242 final production `41399968432` and docs `41399968400` pass on `f411df1f`.
  Full logs: `/private/tmp/fwp-242-f411-{linux-arm,linux-amd,windows-arm,windows-amd,
  mac-arm-regular,mac-arm-ownership,mac-amd-regular,mac-amd-ownership}.log`, plus
  `/private/tmp/fwp-242-final-bench.log` and `/private/tmp/fwp-242-repaired-docs.log`.
  Corresponding target ZIPs: 257 logs per Linux, 131 regular/126 ownership per
  macOS, and 135 passing summaries per Windows native archive. Only intentional
  scheduler panics/TLS rejections appear; no unresolved diagnostic.
- Numerical logs: `/private/tmp/fwp-current-kernels-{arm2,amd2}.log` and
  `/private/tmp/fwp-current-kernels-{arm1,amd1}-repaired.log`. Their only failures
  are the retained performance decisions. `/private/tmp/fwp-current-kernel-audit.log`
  is clean; its compressed copy is committed with the data.
- Initial matrix source audit: `/private/tmp/fwp-matrix-source-audit.md`. Input
  records are outside the kernel timer; task-free scheduler polls are already
  eliminated. Preserve byte-copy alias safety. No speculative runtime edit.
