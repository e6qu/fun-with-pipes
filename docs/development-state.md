# Current work

**Next:** audit the remaining PR #242 production jobs at
`f411df1f402c0f51f3fab8276edd43661f738299`, then squash-merge only after all nine
jobs and documentation pass. Production `41399968432` has benchmark, all four
macOS jobs and Windows ARM passing. Linux ARM/AMD and Windows AMD still run with
no failed steps. Docs `41399968400` passes. Preserve this head.

This preparation branch is `current-kernel-costs`, worktree
`/private/tmp/fwp-current-kernel-costs`, based on that #242 head. Do not open a
second PR. After its squash merge, retain measured source tags and rebase only
this branch's new commits onto the verified merge tree.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | In progress | Protocol `818731e3` published before implementation; #242 final matrix running |
| 2 | Implemented | Paired reference, six-program runner, raw audit and damaged-evidence controls; no production compiler change |
| 3 | Verified | Four sessions retained; raw audit `41407524129` passes; four speed and nine copy limits remain open |
| 4 | In progress | Reproducible current costs and concrete matrix follow-up documented; publish the next PR after #242 merges, then final production gates |

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
- #242 prior production `41391756089` is fully audited. All compiler/runtime
  targets pass; Intel deadline-control and docs-reference failures are repaired
  in `f411df1f`. The full preceding handoff is in that revision.
- Final-head passing logs: `/private/tmp/fwp-242-final-bench.log`,
  `/private/tmp/fwp-242-repaired-docs.log`, and
  `/private/tmp/fwp-242-f411-mac-{arm-regular,arm-ownership,amd-ownership}.log`.
  Intel regular log `/private/tmp/fwp-242-f411-mac-amd-regular.log` also passes.
  All four macOS target archives are clean (131 regular / 126 ownership each).
  Windows ARM full log `/private/tmp/fwp-242-f411-windows-arm.log` is clean except
  deliberate scheduler panic and TLS rejection controls. Both Windows native ZIPs
  have 135 clean summaries; AMD's later checks still run.
- Numerical complete logs: `/private/tmp/fwp-current-kernels-{arm2,amd2}.log`.
  First-session logs: `/private/tmp/fwp-current-kernels-{arm1,amd1}-repaired.log`.
  Their only failures are the retained performance decisions above. The full audit
  log `/private/tmp/fwp-current-kernel-audit.log` has no warnings or errors.
