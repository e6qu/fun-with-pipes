# Current work

**Next:** implement the four-part [gradient-call storage contract](measurements/gradient-call-storage.md),
starting with the direct scoped callback and its borrow proof. Freeze the contract
tag before code. Batch all four parts into one PR before focused runner validation;
run final production only after the complete group is ready.

Branch: `gradient-call-storage`, worktree `.worktrees/owned-numeric-updates`.
No open delivery PR yet. Other dirty worktrees and the primary checkout are unrelated.

## Roadmap status

| Step | Status | Evidence or remaining work |
|---|---|---|
| 1 | Pending | Direct derivative scope, word worker convention, caller-owned input proof. |
| 2 | Pending | Numeric fold fields and bounded constant seed proof. |
| 3 | Pending | Explicit single-root scalar/owned-weight backward peers. |
| 4 | Pending | Consume exclusive 64-bit gradient scratch; protect other layouts/aliases. |
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
Neither reduction is implemented or measured yet.

Scratch review: `../gradient-work/owned-numeric-remaining-storage/`, especially
`scoped-call-design.md`, `inspection.json` and `source-predictions.json`.
The worker needs an explicit word-valued borrowed convention; removing a retain
alone is unsafe. Keep AD admission, graph edges, caller ownership through unwind
and matching callee cleanup. Constant seed proof must explicitly admit concrete
F64 zero/one intrinsics; arbitrary user-defined zero remains evaluated normally.
Single-root peers need separate scalar/owned-weight layout and callback proofs.
Scratch reuse requires 64-bit pointer-free storage and a separate owner from
independently allocated scratch. Freeze exact reference edits before timing.

## Local checks and resources

All checks use `python3 scripts/local-guard.py`; full builds/suites run on runners.
Premerge ten-gate verification: 0.65s. Merge/tree/message verification: 1.61s.
Delivery evidence retention: 0.13s. Final log audits: Linux AMD64/cache reconciliation
5.05s, Windows ARM64 136.57s, Windows AMD64 142.81s; other results are retained.

Last free space: 64.596 GiB. Full Windows downloads were removed only after
verifying all 157 retained logs and archive digests; final collection keeps the
retirement receipts. Preserve 64 GiB; do not redownload audited full archives.
Scratch: `../gradient-work/owned-numeric-platforms-258-final`.
The merged #257 worktree was archived with its dirty handoff/patch before removal;
other dirty worktrees remain untouched.
