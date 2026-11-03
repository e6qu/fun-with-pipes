# Current work

**Next:** publish the diagnostic exit-status repair and rerun the
[constructor census](measurements/temporary-list-storage.md) on both native Linux
GCC hosts using the `constructor-census` suite. Its protocol
anchor is `roadmap/temporary-list-protocol-2026-11-03`. Source attribution, count
parsing, native rejection controls and archive reconstruction are implemented;
native execution is not yet verified. Keep census, selected storage improvement,
verification and docs together in draft PR #250.

First census `41572713222`, source `1668a179`, failed on both hosts because an
exit handler overwrote the invalid-site control's status. Both full logs and all
nine completed native compilations per host are audited; no other diagnostic
was found. The synthetic complete control passes. The repair flushes its message
and uses `_Exit` for malformed observer input. [Retained attempt and explanation](measurements/temporary-list-census-2026-11-03/README.md).
Real cases and remaining native controls still need execution.

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
| 1 | In progress | Protocol published and observer implemented; native census and audit remain |
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

No local full build, suite or benchmark. Under `scripts/local-guard.py`:

- `test-constructor-profile.py`: seven controls pass, 0.73s. Corrected its leak
  mutation to match the existing instrumented ownership call before publication.
- `test-ownership-profile.py`: 13 tests pass, 0.13s. Caller detection now handles
  kernel macros and multiline parameters; 22 previously unresolved calls in
  saved C are attributed. All 277 constructor sites have known callers.
- `test-derivative-ownership-profile.py`: 14 tests pass, 13.65s.
- `actionlint .github/workflows/numerics.yml .github/workflows/roadmap.yml`: pass,
  6.46s. No runtime/compiler changes; the runner checks production-tree equality.
- `check-roadmap.py`: 224 link sets, 106 immutable anchors and four steps pass,
  3.00s. The production-source comparison and `git diff --check` pass.

An attempted unittest discovery found zero tests because script names contain
hyphens; direct execution verified them. A subsequent command met the guard's
serialization lock, was refused, and ran successfully after the active check
finished. No limits were bypassed. Draft documentation run `41571171638` passes;
its full log contains only the expected rejected-input/synthetic-panic controls
and retained failed measurement limits. Skipped draft production jobs are not gates.
New #249 target metadata is compressed losslessly; raw archives and failed-job
records are preserved.

`docs/design.md` now corrects stale PR #244 production status and separates passed
compiler-cost checks from open runtime goals. Final #249 evidence, history and
status updates are carried into this branch. Keep immutable failed evidence.

Use `python3 scripts/local-guard.py` serially. Preserve 64 GiB free disk, generated
target data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second limit.
Do not raise or bypass limits; move refused work to GitHub runners.
