# Current work

**Next:** publish the borrowed-callback observer repair, then rerun
`scalar-constant-census` with focused run `42048215807`. Audit its complete
allocation/stack results before timing. Compiler/test sources remain identical
to the passing focused checks; only measurement reachability was repaired.

## Roadmap status

| Step | Status | Evidence still needed |
|---|---|---|
| 1 | Implemented | Bounded proof passes 296 compiler units on three hosts; final production coverage remains. |
| 2 | Implemented | Complete-program selection and O1/O2 exact-bit/root probes pass on three hosts. |
| 3 | Verified | All 25 targets per host and full artifact audit pass at `37da7217`. |
| 4 | In progress | Freeze source; census/stack, compiler costs and two runtime sessions per architecture remain. |
| 5 | Pending | Nine final-head jobs, docs and full audit; squash merge. |

Draft [PR #261](https://github.com/e6qu/fun-with-pipes/pull/261),
branch/worktree: `scalar-constant-lowering`. [The contract](measurements/scalar-constant-lowering.md)
was frozen at `4bad4992` before code, tag
`roadmap/scalar-constant-lowering-protocol-2026-11-05`. Keep its original identity.
Rebased onto `a85f59d2`; all pre-rebase evidence sources remain under
`roadmap/scalar-constant-premerge-2026-11-05` at `5e1c51d5`. The rebase changed
no tree bytes. The first census stopped at a source-observer error before any timing. All earlier timing misses remain in PLAN.md.

## Parent delivery is verified

PR #260 merged as `a85f59d23918c1854f43fb3a3ce2af65383ac5f9`. Its tree equals
tested `ba3f0d8793dc3bbd3c21f94d06a1bca2896b6d45`; the one-line message has
no body/trailers. All nine jobs, docs and full audit pass.
[Delivery receipts](measurements/packed-pair-delivery-2026-11-05/README.md) retain
sources, logs and cancelled same-tree postmerge runs. One new PR can now proceed.

## Current repair and completed checks

- [Census observer repair](measurements/scalar-constant-checks-2026-11-05/census-observer/README.md):
  `42071040601` fails on both hosts because shared reachability omitted borrowed
  callbacks. Four reachability and four scalar controls now pass, as do 21 saved
  candidate/reference programs. All six measurement/auditor callers use the fix.
- Docs `42071048625` passes completely at `26a5cbe6`; the stale test-count
  repair is verified. No remaining failure from the previous docs run.

- [Passing focused evidence](measurements/scalar-constant-checks-2026-11-05/native-passing/README.md)
  completes 25 targets, 828 native images and 844 probe observations per host.
  Audit `42070540044` has no unresolved issues.
- Docs `42051839171` found a stale cache-test count (three instead of four).
  The checker and fixture are repaired; `python3 scripts/local-guard.py python3
  scripts/test-collection-evidence.py` passes all eight controls. The repaired full docs gate now passes. Superseded queued docs `42048220794` was cancelled.

- [Native run 42037640087](measurements/scalar-constant-checks-2026-11-05/native-first/README.md)
  at `943f749e` completes all 25 targets per host: 24 pass and one cache-ownership
  observer fails. Its literal character length is already folded before the new
  scalar pass. Use byte length to keep a computed scalar, with unchanged strict
  ownership assertions. Audit `42043247325` accounts for every target, image and
  diagnostic; it fails only for that original observer.
- [Measurement controls](measurements/scalar-constant-checks-2026-11-05/measurement-controls/README.md)
  pass at `bb23f87c`, run `42038834040`: ten script groups, 91 tests. The superseded
  request `42037645434` was cancelled while queued, before execution.
- Earlier build repairs are retained: [shared-proof visibility](measurements/scalar-constant-checks-2026-11-05/first-build/README.md)
  and [borrowing the interpreter result](measurements/scalar-constant-checks-2026-11-05/second-build/README.md).
  Neither remains an unresolved compiler error.
- Guarded local checks pass: formatting; scalar reference (4), descent budgets
  (23), census/reconciliation (10), phase budgets (9), compiler measurements (10),
  roadmap controls (5), YAML syntax and five matching plan/handoff rows.
  Initial sparse-fixture failures were fixed by materializing small tracked files;
  the larger historical evidence checks passed remotely.
- Guarded review of saved parent C also passes the new cached-reference selector:
  `One[F64].one` reaches `caf66`, then `prim.one` reaches `caf68`; private pair
  reuse remains selected. This checks the observer, not performance. The first
  one-off invocation omitted the scripts import path; supplying it fixed the call.

## Next measurement sequence

1. Focused native checks and their complete artifact audit.
2. `scalar-constant-census` and `scalar-constant-census-report`: exact unchanged
   counts, parent reconciliation, raw/final storage and complete-program stack costs.
3. `scalar-constant-analysis` and `scalar-constant-compiler-report`: seven inputs,
   336 measured/warmup commands per host and unchanged frozen limits.
4. `scalar-constant-time` with two qualified sessions per architecture, followed
   by `scalar-constant-report`. Retain every outcome; no unchanged timing reruns.
5. Final production/docs/audit and authorized squash merge.

Reference construction disables only scalar replacement. Selection checks require
literal candidate reads and cached reference reads, preserving prior buffer reuse.
The native tests' source must match the sources used by measurement jobs.

## Resources and workflow maintenance

Free space recovered to about 85 GiB. User-authorized cleanup removed
1,098,786,631 bytes of downloads after verifying remote originals; logs and source
remain. Receipt: `../gradient-work/removed-verified-downloads-2026-11-05-user-cleanup.json`.
Use the unchanged local guard; full native builds and measurements stay on CI.

Numerics.yml is 508,914 bytes, below GitHub's 512,000-byte limit. The initial
[oversize failure](measurements/scalar-constant-checks-2026-11-05/format-startup.json)
was repaired by moving maintenance jobs into a reusable workflow. Formatting and
measurement-control requests verify that workflow; docs now enforce the size limit.
