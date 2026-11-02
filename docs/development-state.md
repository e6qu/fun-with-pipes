# Current work

**Next:** audit the remaining PR #242 production jobs at
`f411df1f402c0f51f3fab8276edd43661f738299`, then squash-merge only after all nine
jobs and documentation pass. Production `41399968432` has benchmark, both macOS
ARM jobs and Intel ownership passing; five platform jobs are still running with
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
| 3 | In progress | Both second sessions complete; repaired first sessions measure; retain every missed limit and earlier rejection |
| 4 | Pending | Audit all raw evidence on GitHub; publish current time/memory costs; final production gates before delivery |

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
| ARM64 / 1 | `125147087471` | Reference checks pass; measuring |
| AMD64 / 1 | `125147087334` | Reference checks pass; measuring |

Six hosts were rejected before building or timing; their logs and qualification
records remain selected. Initial ARM session 1 (`125141953749`) failed only two
reference assertions expecting `double v3`, while its declared word-state layout
uses `V v3`. Repair `9f6d0f7c` changes those expectations only in the isolated
reference checkout, retaining alias, failure, cancellation and cleanup checks.
That job never timed; completed sessions are not rerun to seek passing limits.

Once all selected runs finish, dispatch `current-kernel-report` on this branch.
It audits every raw observation and binary on GitHub and retains compact reports,
source identities, file hashes, full job logs and every failed decision. A missed
speed/noise limit remains open; it is not an evidence-audit failure.

## Verification and source retention

- Protocol tag: `roadmap/current-kernel-costs-protocol-2026-11-02` (`818731e3`).
- Initial measured-source tag: `roadmap/current-kernel-initial-measurements-2026-11-02`
  (`b9da15a1`). Tag `9f6d0f7c` before rebasing.
- Guarded local checks: reference preparation 4 tests (0.13s); scheduling and
  decisions 7 (0.13s); damaged evidence 10 (4.28s); job retention 4 (0.13s);
  actionlint (5.07s); roadmap/link/commit audit (2.83s). No local full build or timing.
- #242 prior production `41391756089` is fully audited. All compiler/runtime
  targets pass; Intel deadline-control and docs-reference failures are repaired
  in `f411df1f`. The full preceding handoff is in that revision.
- Final-head passing logs: `/private/tmp/fwp-242-final-bench.log`,
  `/private/tmp/fwp-242-repaired-docs.log`, and
  `/private/tmp/fwp-242-f411-mac-{arm-regular,arm-ownership,amd-ownership}.log`.
  Corresponding target ZIPs contain 131, 126 and 126 clean summaries. No unexpected
  warnings; only documented deliberate rejection/panic controls.
- Numerical complete logs: `/private/tmp/fwp-current-kernels-{arm2,amd2}.log`.
  Their only failures are the retained performance decisions above.
