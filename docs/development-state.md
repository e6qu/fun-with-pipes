# Current work

**Next:** implement the [constructor census](measurements/temporary-list-storage.md)
with diagnostic source-site counters and rejection controls. Its protocol anchor
is `roadmap/temporary-list-protocol-2026-11-03`. Run
counts on both native Linux GCC hosts before selecting a compiler storage change.
Keep the entire census, selected improvement, verification and docs in one PR.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `temporary-list-storage`.
  The primary checkout is untouched.
- Base: verified PR #249 squash `46af240b8c540746b942b687b416cd52f6a91f9e`.
  Tested source `6ca3c41106d78f8251d3d59e3750470a3c270f68`, tag
  `roadmap/callback-owner-final-2026-11-03`; identical tree
  `ce8dab3adb4fca4643cd600286233ebf11d884bc`.
- Count baseline: `5af0366c0c1ad91feeb08ddbd42a035858b635e4` and
  [all 96 verified observations](measurements/numeric-input-checks-2026-11-03/verified-counts.json.gz).
  No dependency on an older fwp compiler or API is needed.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Publish protocol; implement and verify constructor-site census |
| 2 | Pending | Select and freeze a bounded storage change from measured callers |
| 3 | Pending | Implement with native semantic, alias, failure and cleanup controls |
| 4 | Pending | Grouped measurement, final platform gates and verified squash |

## Evidence guiding this batch

The largest single solve has 154,952 shared-constructor requests out of 156,943
allocations. Saved C shows input-index lists, derivative input records/list cells,
gradient-result cells, scaled adjustment cells and coordinate-update cells.
All 96 aggregate count formulas match (guarded audit, 0.13s); per-caller counts are
not yet verified. [Protocol and formulas](measurements/temporary-list-storage.md).

A candidate is an eager numeric map used only by zip-with: keep its results in
one buffer, then run zip-with after all map callbacks finish. Do not select it
from aggregate counts alone, assume all lists can become arrays, or change trap
order. Preserve input aliases and failure/cancellation cleanup.

## Previous delivery

[PR #249](roadmap-history.md#numeric-callback-owner-transfers-pr-249) is merged.
All nine production jobs in `41557647177` and docs `41557647102` pass on the exact
tested head; every full job and target log is audited. The raw squash message is
one 56-character line with no body or trailers; its tree equals the tested tree.
[Final gates and retained logs](measurements/callback-owners-2026-11-03/final-gates.json).
Duplicate same-tree main runs `41569903194` and `41569903295` were cancelled.

The original matrix `41554814165` is fully audited. Its only failures were the
same unit-test Clippy lint on four hosts; the fix reuses the test box and expands
early lint to all targets. No production-code repair or timing rerun was needed.
Windows panic output belongs to the successful eight-entry/eight-child cleanup
controls. Explicit ignored measurement/Linux-only checks are not support claims.

Largest solves take 5.2–6.4% less time with 98.7% fewer retains and unchanged
allocation traffic/peak managed storage. Smaller speed/noise goals stay open in
[PLAN.md](../PLAN.md); do not discard them or relax their limits. The compiler-cost
experiment isolates numeric inputs, with field transfers enabled in both builds.

## Local checks and documentation

No local full build, suite or benchmark. Guarded full/target evidence audits pass
in 0.13–0.14s each. `python3 scripts/check-roadmap.py` passes after this plan rewrite (2.90s):
224 document link sets, 106 preparation pairs and four matching roadmap steps.
New target metadata is compressed losslessly; raw archives and failed-job records
are preserved.

`docs/design.md` now corrects stale PR #244 production status and separates passed
compiler-cost checks from open runtime goals. Final #249 evidence, history and
status updates are carried into this branch. Keep immutable failed evidence.

Use `python3 scripts/local-guard.py` serially. Preserve 64 GiB free disk, generated
target data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second limit.
Do not raise or bypass limits; move refused work to GitHub runners.
