# Current work

**Next:** publish the stale remaining-storage guide repair and monitor the
replacement final production/docs runs for [PR #257](https://github.com/e6qu/fun-with-pipes/pull/257).
The previous production run `41861223201` at `ee3a80a7` will be superseded:
seven jobs are queued, Windows compiler checks are running, and no failure is
reported. Cancel it after replacement publication to avoid redundant long tests.
Keep the compiler and measurement sources unchanged. Audit every final-head
full/target log before squash merge; preserve the three accepted open timing goals.

Worktree `.worktrees/packed-derivative-inputs`, branch `packed-derivative-inputs`.
Immutable measurement tag `roadmap/packed-input-measurement-2026-11-04` points to
`5f63ea1a9a7fb7a6bc1068bbd84c4224c176b106`. The pushed delivery commit contains
only evidence/docs and an explicit workflow-selection guard; compiler, runtime,
library, tests and build inputs still match the verified source below.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve selection, ownership and frozen measurement contracts |
| 2 | Verified | Preserve audited three-host compiler/cleanup coverage |
| 3 | Verified | Measurements and every outcome audited; three AMD64 timing goals remain open |
| 4 | In progress | Evidence published and PR ready; final production/docs running; then verify squash/tree |

## Verified implementation and measurements

The group exposes known objectives inside existing derivative scopes and packs
private numeric inputs into one buffer. Input preparation, neighboring-pair
mapping and folding stay separate, eager stages. Public values remain immutable.

- [Correctness run 41840527818](measurements/packed-input-checks-2026-11-04/README.md),
  source `ba23c6ea7226c31f626839530035e717f3ce05c7`: GCC ARM64 `126610608861`,
  GCC AMD64 `126610609022`, Clang ARM64 `126610608502`. Each passes 277 units
  (four existing ignored), contracts, twelve selections, 93 integrations and
  34 new probes. All 642 native images and 655 saved statuses per host audited.
- [Compiler comparison 41849392317](measurements/packed-input-analysis-2026-11-04/README.md),
  source `5f63ea1a`: ARM64 `126641316888`, AMD64 `126641317260`. Seven inputs,
  336 scheduled commands and four untimed live-work checks per host. Maximum
  time/RSS increases 4.32%/0.82%; copy variation 1.42%. All limits pass.
- Documentation `41849320036` / `126641046022` passes at `5f63ea1a`. Full log
  audited: runner target errors, deliberate panic and timeouts are expected controls.
- [Runtime 41853137417](measurements/packed-input-time-2026-11-04/README.md), same
  frozen source: ARM64 `126654538623` / `126654538896` pass. AMD64
  `126654538700` / `126654538572` retain three timing failures below. All four
  hosts qualify; all storage/count/cleanup/stack limits pass.
- Independent audit `41856724419` / `126667266463` passes. All four full logs and
  5,336 raw-file records reconcile; archives, identities and every outcome retained.

Observed savings per update with N coordinates: 2N+1 requests, 40N+24 requested
bytes and three retains. All 48 comparisons agree across hosts and workspace
reuse on/off. Largest solve saves 51,541 requests and 597 retains; peak managed
storage falls 19,360 → 15,232 bytes. Raw storage is unchanged; final storage zero.
Qualified longer solves take 14.5–23.1% less time. Process RAM does not consistently
fall, and manual-gradient C/Rust remain substantially faster.

## Open timing outcomes

- AMD64 session 1: 3/199 and 3/1999 identical-copy variation is 2.3628% / 2.7833%
  against 2%. Those cases are inconclusive.
- AMD64 session 2: 3/1 current is 2.3095% slower against 2%.
- [Saved-sample diagnosis](measurements/packed-input-time-2026-11-04/amd64-sample-review.md)
  establishes no cause or justified compiler repair, sample removal or warmup
  change. Preserve all three failures. The accepted policy retains verified
  reductions while timing goals stay open; it does not relabel failures as passes.

## Local checks and repairs

Focused checks/collection use `python3 scripts/local-guard.py`; full builds and
suites stay on GitHub. Limits unchanged; last disk observation was 67 GiB free.

- Repaired ineffective compiler-cost fixtures before timing: all 64 calls are
  reachable, runtime input keeps specialization live, and the large helper is
  checked as shared rather than described as an oversized rejected wrapper.
- New workflow repair includes `packed-input-time` in the existing invalid
  runner/session rejection guard. Valid measurements are unchanged. Lint: 6.02s.
- Compiler retention: 1,072 raw records per host, 1.80s; docs log audit: 0.13s.
- Runtime collection/full-log audit: 4.33s; report/footprint audit: 0.48s;
  48 memory comparisons and exact savings formula: 0.24s. Saved-sample inspections:
  8.02s/8.56s. No new timings or local native suite.
- Final staged roadmap check: 271 link sets, 106 immutable preparation pairs and
  four steps pass (2.66s); whitespace checks pass. No core changes since measurement.

A final source review found stale status in `remaining-gradient-storage.md`:
it still called input packing unfrozen and #256 delivery unfinished. The repair
replaces obsolete proposals with current evidence and concrete coordinate-reuse
proof requirements, and labels the earlier input review as historical. No compiler
or benchmark source changed; no completed measurement is repeated.

Scratch helpers live in `../gradient-work`: `collect-packed-input-runtime.py`,
`retain-packed-input-time.py`, `summarize-packed-input-memory.py` and
`collect-matched-option-platforms.py` (adapt paths/source for final gates).
Do not overwrite retained outcomes or rerun timings. Leave dirty primary/older
worktrees alone; this branch owns current work.

## Preserved history

[Earlier failed preflights and repairs](measurements/packed-input-selection-2026-11-04/README.md)
retain all causes and logs. Contract `cc425aba`, binding proof `3ccc9bf2` and
pre-delivery history `db7ae09c` remain reachable through their immutable roadmap
tags. Never move them. [PR #256](roadmap-history.md#matched-optional-results-pr-256)
merged as `cfb6dcc4223e281188cf6159e0623368501e2294`, tree equal to tested `81bce309`.
Its nine production jobs/docs and squash message are verified; redundant same-tree
main runs were cancelled. No further #256 validation is needed.
