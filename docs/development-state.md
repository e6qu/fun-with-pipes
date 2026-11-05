# Current work

**Next:** dispatch and audit `gradient-call-checks` for the expanded head of
[PR #259](https://github.com/e6qu/fun-with-pipes/pull/259). GCC ARM64/AMD64 and
Clang ARM64 must verify all four changes and the additional direct-seed controls.
Audit every failed step and completed native target before one repair push.
Implementation is not yet verified; do not launch final production yet.

Contract frozen before code at `1ed3ad99ef7263161d526cea816c33b36ac40b9b`, tag
`roadmap/gradient-call-storage-protocol-2026-11-05`.

Branch: `gradient-call-storage`, worktree `.worktrees/owned-numeric-updates`.
PR #259 is the only active PR and remains a draft. Other dirty worktrees and the
primary checkout are unrelated.

## Roadmap status

| Step | Status | Evidence or remaining work |
|---|---|---|
| 1 | In progress | Direct derivative scope, word worker convention, caller-owned input proof. |
| 2 | In progress | Numeric fold fields and bounded constant seed proof. |
| 3 | In progress | Explicit single-root scalar/owned-weight backward peers. |
| 4 | In progress | Consume exclusive 64-bit gradient scratch; protect other layouts/aliases. |
| 5 | Pending | Grouped controls, counts and measurements, then final CI/delivery. |

## Verified previous delivery

[PR #258](https://github.com/e6qu/fun-with-pipes/pull/258) is merged at
`68115090b161f198e11fb625946259f65f781580`; tree equals tested
`35745c0b8fab61c9ac4e0a9e57efd81fd1a283bd`. Nine production jobs in
`41939753207` and docs `41939719588` pass, with all full/target logs audited.
[Retained gates](measurements/owned-numeric-checks-2026-11-05/platforms/final-gates.json)
verify source, logs, tree and the one-line squash message. Redundant same-tree
push runs `41952053890` / `41952053874` were cancelled after verification.

[The old failures and repair](measurements/owned-numeric-ci-repair-2026-11-05/README.md)
remain explicit: six jobs hit the same outdated identity-array allocation assertion.
All old full/target logs are audited; no other failing target was found.
The expanded focused suite passes 285 units and 110 integrations/19 targets on
three hosts, with 722 native images and 733 outcomes each.

[Runtime results](measurements/owned-numeric-time-2026-11-05/README.md) retain four
missed AMD64 speed targets. No unchanged measurements should be rerun. Compiler
source for these measurements is `07541ff956d582bb9c3936b86261e43fa25b0b2f`;
it is unchanged through the tested merge. All older goals remain separate in PLAN.

## Implementation preparation

[Current allocation attribution](measurements/gradient-storage-2026-11-05/README.md)
passes on both hosts: 96 observations reconcile with source constructors.
Fresh single-solve totals differ from the repeated shared-input timing driver.
One fresh 129/199 solve uses 2,121 requests and 1,265,230 requested bytes;
the proposed four-part reduction targets 727 requests and 1,034,366 bytes.
The reduction is implemented but has not been compiled or measured yet.

Scratch review: `../gradient-work/owned-numeric-remaining-storage/`, especially
`scoped-call-design.md`, `inspection.json` and `source-predictions.json`.
The worker needs an explicit word-valued borrowed convention; removing a retain
alone is unsafe. Keep AD admission, graph edges, caller ownership through unwind
and matching callee cleanup. Constant seed proof must explicitly admit concrete
F64 zero/one intrinsics; arbitrary user-defined zero remains evaluated normally.
Single-root peers need separate scalar/owned-weight layout and callback proofs.
Scratch reuse requires 64-bit pointer-free storage and a separate owner from
independently allocated scratch. The reference disables `GRADIENT_CALL_STORAGE` and restores the multi-root
selection in `rev._finish`; all preceding ownership changes stay enabled.

## Local checks and resources

All checks use `python3 scripts/local-guard.py`; full builds/suites run on runners.
Premerge ten-gate verification: 0.65s. Merge/tree/message verification: 1.61s.
Delivery evidence retention: 0.13s. Final log audits: Linux AMD64/cache reconciliation
5.05s, Windows ARM64 136.57s, Windows AMD64 142.81s; other results are retained.

Before implementation, free space was 64.596 GiB. Full Windows downloads were removed only after
verifying all 157 retained logs and archive digests; final collection keeps the
retirement receipts. Preserve 64 GiB; do not redownload audited full archives.
Scratch: `../gradient-work/owned-numeric-platforms-258-final`.
The merged #257 worktree was archived with its dirty handoff/patch before removal;
other dirty worktrees remain untouched.


## Current edits and focused checks

- Direct scoped callbacks use explicit word workers; ordinary exported/dynamic
  entries retain their owning convention. Borrow inference includes the continuing
  owner through enclosing call arguments, and only proved plain list reads qualify.
- Packed folds accept/return numeric fields. Constant seeds admit only bounded
  literal records, nullary chains and concrete scalar zero/one primitives.
- Backward accepts one explicit root/seed in both engines. Scalar native code
  reads borrowed word slices; typed code uses an explicit list/single-root layout.
  No fabricated stack array/list object or heap ownership header is needed.
- Coordinate scratch consumes only dead I64/U64/F64 arrays. Separate cleanup
  protects array storage and scratch, with alias/view and shared-list controls.

New scope ledger tests cover normal return, retained aliases, traps, cancellation,
allocation failures and deliberately added retains/missing frees. Existing typed
and scalar backward controls now exercise both seed representations. Old fold and
phase observers were moved to the shared execution sites. The historical gradient
reference was updated to preserve single-root peers while reversing array results;
its original measured patch remains in the immutable evidence.

Guarded reference tests: 6 + 5 + 5 pass; standalone library-doc generator and
unblessed verification pass (2.20s together). Earlier new-reference control initially
failed because its corruption marker matched both typed entry wrappers; the marker
now targets the shared implementation uniquely, and all six tests pass.

Disk fell to 63.964 GiB and the guard refused formatting. Only the three reproducible
`owned-numeric-checks-6` downloads were removed after digest, audit and all 472
retained-control file checks per host. Receipts stay beside their metadata. The
first lightweight cleanup restored the guard minimum; its sandboxed nice request
was denied, and no compiler/check was run outside the guard. The remaining two
cleanups ran under the guard (0.38s). Last free space: 64.344 GiB.

Focused preparation also passes the three new reference controls, six historical
gradient reference controls, three iteration observer controls and four Clang
phase controls. The primitive inventory reports expected contract changes verified,
including both explicit single-root peers. Cargo formatting passes. The actual
native runner inventory covers all 255 targets; an attempted nonexistent standalone
shard-check filename was corrected to the runner's own metadata/assignment audit.
No Rust build or native implementation test has run locally.

While the first three jobs wait for runners, follow-up edits extend scalar unwind
controls to direct seeds (mixed/invalid/expired roots, allocation failure and
cancellation), plus raw/native invalid/empty F128 seeds. The untimed allocation
suite now has an explicit `gradient-call` comparison and six passing observer
controls. It predicts exactly 11,145 requests / 1,846,744 bytes / 3,184 retains
removed for eight 129/199 solves; these remain unmeasured. Formatting and workflow
syntax pass under the guard (1.77s). The follow-up batch replaces the initial run before any runner starts.

Initial head `6f322d1f9d4ceca01d29ee45163f746d6656a3c9` had no assigned runners.
Runs `41956076516` (focused) and `41956079358` (docs) were cancelled before
execution to keep one expanded batch. No failed or passing implementation result
was discarded. Local roadmap audit passes (2.67s).
