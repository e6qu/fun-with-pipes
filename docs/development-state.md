# Current work

**Next:** publish the phase-byte checker repair and run `gradient-call-census-report`
against saved census `41964853201`, source `8c0e4b0e`. Both local re-audits pass.
After the report-only CI check passes, start the compiler/runtime measurements.
Do not rerun unchanged native measurements. Keep the group in
[PR #259](https://github.com/e6qu/fun-with-pipes/pull/259).

Branch: `gradient-call-storage`; worktree `.worktrees/owned-numeric-updates`.
Frozen measurement source: `8c0e4b0ef06aa9f528eeaedbfbab9461a82dd0d7`, tag
`roadmap/gradient-call-storage-measurements-2026-11-05`. The current repair changes
measurement checks and documentation, not compiler/runtime/library/test trees.
Other worktrees are unrelated; `../gradient-call-recorded-checker` is a clean
sparse checkout of that frozen source for auditing its original checker.

## Roadmap status

| Step | Status | Evidence and remaining acceptance |
|---|---|---|
| 1 | Implemented | Scoped borrowing controls and allocation counts pass; compiler/runtime measurements and production gates remain. |
| 2 | Implemented | Numeric fold/constant-seed controls and counts pass; same remaining gates. |
| 3 | Implemented | Scalar/owned-weight, precision, failure controls and counts pass; same remaining gates. |
| 4 | Implemented | Scratch alias/view, both positions, unwind controls and counts pass; same remaining gates. |
| 5 | In progress | Focused native checks pass. Corrected census audits pass locally; report-only CI, compiler/runtime measurements, final production/docs and squash merge remain. |

[Contract](measurements/gradient-call-storage.md) was frozen before implementation:
`1ed3ad99ef7263161d526cea816c33b36ac40b9b`, tag
`roadmap/gradient-call-storage-protocol-2026-11-05`.

## Verified checks and repaired failures

[Focused run 41962981349](measurements/gradient-call-checks-2026-11-05/README.md#passing-focused-matrix)
and docs `41962933179` pass with complete log audits. Each of three hosts passes
292 units, all selections, formatting and 124 native tests in 25 targets;
798 images and 814 probe statuses are checked per host. Four units are explicit
runner-only measurement tests. No selected native test is ignored. Earlier
compiler, ownership-fixture and formatting failures are repaired and documented
in that evidence index; their original logs remain available.

[Census 41964853201](measurements/gradient-call-census-2026-11-05/README.md)
measured both architectures successfully but failed its phase-byte checker.
Scratch reserves N+1 words; the original rule put eight bytes per update in
recording instead of scratch. Correct savings: (8N+8)U outside and 120U+24 during
recording. Total (8N+128)U+24 is unchanged. No acceptance budget was relaxed.

Original-policy audits reproduce exactly 80 phase differences per host, with
all other counts, raw storage, cleanup and frame limits passing. Corrected
re-audits pass: AMD64 11.13s, ARM64 11.23s. The six budget controls use literal
phase totals and reject transferring bytes between phases while preserving totals.
`audit-gradient-call-census.py` reconstructs source/counters, checks images and
raw output, and preserves original failures separately from corrected results.
The report-only workflow runs it without compiling or executing saved programs.

Fresh 129/199: 2,121 → 727 requests, 1,265,230 → 1,034,366 requested bytes;
398 fewer effective retains. Eight repeated solves save 11,145 requests,
1,846,744 bytes and 3,184 retains. Zero-update counts stay identical.
No timing has run; fewer allocations do not establish speed or process RAM.

## Remaining measurement and delivery sequence

1. Pass the report-only CI audit of the immutable census above.
2. Run `gradient-call-analysis` (seven compiler inputs) and `gradient-call-time`
   (`native_runner=all`, `comparison_session=both`), with correctness
   `evidence_run=41962981349`. Record their actual head and matching code trees.
3. Audit saved samples with `gradient-call-report`. Keep speed/copy,
   compiler/RSS, frame and managed/raw-memory limits; preserve older misses.
4. Complete nine exact-head production jobs and docs, audit all full/target logs,
   then squash merge with one subject of at most 80 characters and empty body.
   Verify message/tree and continue the plan.

## Local checks and resources

Use `python3 scripts/local-guard.py`; full builds, native tests and measurements
stay on runners. Existing bounded checks pass: primitive inventory (397), target
assignment (255), references, library documentation, roadmap links, measurement
budgets and evidence reconstruction. Checker controls, Python parsing, actionlint and diff checks pass (8.80s).
Retained archives now use distinct paths for outer reports and inner archive
reports; a duplicate-name warning in the first retention attempt was repaired
and the rebuilt archives pass uniqueness checks. Staged roadmap validation passes:
283 documentation link sets, 106 preparation anchors and five steps (2.61s).

The recorded checkout initially lacked its index and then a tutorial needed for
source reconstruction. Populate it and include `docs/tutorials`; use quiet Git
diff checks so an incomplete checkout cannot print a whole-repository diff.
The disk guard stopped the first ARM64 audit below 64 GiB. Hash-verified duplicate
extractions were removed (290 MiB), retaining both original archives and all
receipts; the resumed audit passes. Never raise guard limits.

Scratch: `../gradient-work/gradient-call-census-2026-11-05/` contains originals
and corrected receipts; `gradient-call-checks-4/` contains focused audit data.
Full generated sources/images remain in digest-identified GitHub artifacts.
Retained repository records include all observations, logs and file hashes.
Completed individual logs are fetched through `gh api .../actions/jobs/ID/logs`;
`gh run view --log` can wait for the whole run.

## Previous delivery

[PR #258](https://github.com/e6qu/fun-with-pipes/pull/258) merged at
`68115090b161f198e11fb625946259f65f781580`, tree equal to tested `35745c0b`.
All nine production jobs `41939753207`, docs `41939719588`, and full/target audits
pass. [Delivery receipts](measurements/owned-numeric-checks-2026-11-05/platforms/final-gates.json)
verify the tree and one-line squash message. Redundant main runs were cancelled.
[Four AMD64 speed misses](measurements/owned-numeric-time-2026-11-05/README.md)
remain open, separate from this comparison.
