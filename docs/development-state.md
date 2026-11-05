# Current work

**Next:** publish the complete measurement evidence and mark [PR #259](https://github.com/e6qu/fun-with-pipes/pull/259)
ready for its nine exact-head production jobs plus docs. Keep that head unchanged
while gates run. Audit every completed job/full target log, fix every unexplained
failure, then squash merge with one line ≤80 characters and an empty body.

Independent runtime audit `41970153152` passes. It verifies all four sessions of
`41967904120`, including the 17 missed timing limits. Compiler-cost run
`41967900961`, corrected census audit `41967470333` and docs `41967470162` also
pass with complete log audits. Measurement head is
`d494dd910723303f99992610895d9784968c79e8`, immutable tag
`roadmap/gradient-call-timing-2026-11-05`. Preserve reductions with timing goals
open under the accepted policy; do not rerun unchanged measurements.

Branch: `gradient-call-storage`; worktree `.worktrees/owned-numeric-updates`.
Frozen measurement source: `8c0e4b0ef06aa9f528eeaedbfbab9461a82dd0d7`, tag
`roadmap/gradient-call-storage-measurements-2026-11-05`. The current repair changes
measurement checks and documentation, not compiler/runtime/library/test trees.
Other worktrees are unrelated; `../gradient-call-recorded-checker` is a clean
sparse checkout of that frozen source for auditing its original checker.

## Roadmap status

| Step | Status | Evidence and remaining acceptance |
|---|---|---|
| 1 | Implemented | Scoped borrowing controls and allocation counts pass; runtime measurements are audited; production gates remain. |
| 2 | Implemented | Numeric fold/constant-seed controls and counts pass; same remaining gates. |
| 3 | Implemented | Scalar/owned-weight, precision, failure controls and counts pass; same remaining gates. |
| 4 | Implemented | Scratch alias/view, both positions, unwind controls and counts pass; same remaining gates. |
| 5 | In progress | Focused native checks pass. Corrected census audits pass locally; report-only CI passes; compiler costs pass; runtime audit passes with 17 timing misses retained; final production/docs and squash merge remain. |

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
The report-only workflow passed on both architectures without compiling or executing
saved programs. Full-log audit passes (3.02s), with no unexpected diagnostics.

Fresh 129/199: 2,121 → 727 requests, 1,265,230 → 1,034,366 requested bytes;
398 fewer effective retains. Eight repeated solves save 11,145 requests,
1,846,744 bytes and 3,184 retains. Zero-update counts stay identical.
Runtime sessions completed; see the current next action for the missed limits.
Fewer allocations alone do not establish speed or process RAM.

Compiler-cost audits pass: [seven-input results](measurements/gradient-call-analysis-2026-11-05/README.md),
336 commands and six untimed checks per host. Maximum time/RSS ratios are
1.004374/1.005311; largest identical-copy ratio is 1.009769. Full logs, raw samples,
reference patches and generated sources are retained. Local guarded audits:
AMD64 59.18s, ARM64 34.53s; retention 1.73s.

## Runtime outcome and remaining delivery

[Audited runtime report](measurements/gradient-call-time-2026-11-05/README.md):
three-coordinate long solves are 14.3–25.2% faster. All sixteen 33/199 and 129/199
comparisons miss 5%; AMD64 session 2 3/0 current is 2.1822% slower, beyond 2%.
Copy variation is at most 1.1644%; frame growth at most 80 bytes. All 48 memory
comparisons, with workspace reuse on/off, match the untimed census. Raw storage
is unchanged and final bytes are zero. Process RSS varies in both directions.

The independent runner audit verifies 5,336 raw-file records; its full log and all
four original job logs have no unexplained diagnostics. Local collection/audit
4.08s; result retention and memory reconciliation 0.74s. No native timing reran.
Keep the 17 misses and all older goals separately in PLAN.md.

1. Pass nine exact-head production jobs and docs; audit complete and target logs.
2. Squash merge with explicit subject/empty body; verify tree and commit message.
3. Continue with the [remaining allocation sites](measurements/gradient-call-census-2026-11-05/README.md#remaining-storage):
   map the two forward recording requests (32N bytes per update) to their actual
   producer/consumer lifetimes before selecting a new optimization. The result
   array adds one request and 8N+8 bytes per update. These formulas were checked
   against every saved fresh case on both architectures (0.13s).
4. Separately review the zero-update source/driver and saved sample ordering.
   No root cause is established; positive-update savings do not explain it.
   Freeze any new experiment before collecting measurements.

## Local checks and resources

Use `python3 scripts/local-guard.py`; full builds, native tests and measurements
stay on runners. Existing bounded checks pass: primitive inventory (397), target
assignment (255), references, library documentation, roadmap links, measurement
budgets and evidence reconstruction. Checker controls, Python parsing, actionlint and diff checks pass (8.80s).
Retained archives now use distinct paths for outer reports and inner archive
reports; a duplicate-name warning in the first retention attempt was repaired
and the rebuilt archives pass uniqueness checks. Staged roadmap validation passes:
283 documentation link sets, 106 preparation anchors and five steps (2.61s).
Compiler-result docs pass the expanded 284-link check (2.63s); final runtime
report/link and diff checks pass: 285 link sets, 106 anchors and five steps
(2.61s). Measured compiler/runtime/library/test/script trees remain unchanged. The ownership page
incorrectly left #255 awaiting platform verification; corrected it against its
verified delivery record and replaced the obsolete task list with current work.

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
