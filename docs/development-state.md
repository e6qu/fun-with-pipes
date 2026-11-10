# Current work

**Next:** finish PR #274's final gates and merge it; then verify and measure the
prepared [compiler-checking investigation](measurements/compiler-checking.md).
Only [PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) is active.

This is a separate preparation worktree, `.worktrees/compiler-checking-costs`,
branch `compiler-checking-costs`, based on final PR head
`a0261f9ccaa4a87651fbcae11966afee68208d4d`. Preserve unrelated root-worktree work and
`.worktrees/application-milestone/docs/development-state.md`, which records the
current delivery monitoring. Do not publish another PR before #274 merges.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup repair | Recorded measurement limits still apply |
| 5 | In progress | Applications, compiler reports/growth, HTTP allocation/backpressure and all timed sessions | Exact-head final delivery gates |

#273 merged as `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`; its
[delivery receipt](measurements/ownership-peer-final-gates-2026-11-09/README.md)
retains exact-source passing gates. Original milestone 1–3 timing limits remain
open; do not repeat unchanged noisy runs to obtain qualification.

## PR #274 delivery monitoring

Final head: `a0261f9ccaa4a87651fbcae11966afee68208d4d`.

- Production `42730888995`: nine required jobs; Windows AMD64 has started,
  others queued at this preparation update. No failed jobs reported.
- Docs `42730888467`, job `129548275958`: queued.
- After all nine and docs pass, dispatch `suite=production-log-audit` with
  `source_revision=a0261f9ccaa4a87651fbcae11966afee68208d4d`,
  `evidence_run=42730888995`, `production_attempt=1`,
  `documentation_job=129548275958`, `audit_host=all`.
- Audit every failure and completed target before repairs. Squash-merge only
  after all exact-head gates and the log audit pass, with one subject ≤80
  characters, empty body and no trailers/attribution. Verify tree and message.

All focused M5 checks and timed sessions pass at measured source
`7a65a8bb2ac23df0554610dfb90609c5fed30ee8`, tag
`roadmap/application-tooling-measurements-2026-11-10`. The
[measurement receipt](measurements/application-compiler-load-2026-11-10/README.md)
retains all 48 compiler comparisons and 34 HTTP trials, with CPU-model and
retention limits explicit. Superseded matrices `42721961219` and `42724948766`
were cancelled after their replacements existed. All available full logs were
audited; the earlier missing-`rec` fixture was repaired, with no other failures
or compiler warnings. Cancellation is not passing platform evidence.

## Prepared work, not verified support

- Added nested reporting for superclass validation, dependency ordering and
  library/user/mixed binding groups. Inference and implementation lookup are
  unchanged; no cache or skipped validation.
- Extended report checks to reconcile group counts with total checked bindings,
  including nested macro checking. Child-time verification now uses one pass
  instead of scanning all events for each event.
- The [investigation contract](measurements/compiler-checking.md) specifies
  representative inputs, observer controls and the evidence needed before
  selecting an optimization. Trait lookup's linear candidate scan is a hypothesis,
  not an attributed cost or selected fix.

Local `python3 scripts/local-guard.py rustfmt --edition 2021 src/infer.rs tests/compiler_options.rs`
passes. The guarded roadmap audit also passes: 441 link sets, 106 immutable
anchors and five roadmap rows. Native verification is pending; no local compiler
build or full suite ran.
Finish the preparation as a coherent diagnostic batch, verify it on runners,
then select and freeze the actual optimization contract from the resulting costs.
Keep 64 GiB free disk, generated targets below 2 GiB, sampled workload RSS below
1 GiB and the guard's 180-second deadline. Do not raise or bypass limits.
