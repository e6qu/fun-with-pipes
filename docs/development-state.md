# Current work

**Next:** audit grouped [native checks 41907057111](https://github.com/e6qu/fun-with-pipes/actions/runs/41907057111)
at `b8404dbb`, then run the untimed whole-solve allocation census before freezing
measurement source. GCC ARM64 `126844449792`, GCC AMD64 `126844449282` and
Clang ARM64 `126844449700` are running. Batch every failure into one repair;
no compiler or runtime timings have started.

The first run's [failures and passing controls](measurements/owned-numeric-preflight-2026-11-04/README.md)
are retained: both GCC hosts pass 282 units (four ignored), 103 integrations and
ten new ownership probes, but fail fixture formatting. Repair `b8404dbb` matches
both saved formatter outputs. Every target log and all 660 image architectures
per host were audited. The first Clang job never acquired a runner; its capacity
diagnostics are retained. The new run includes an actual compiler-cost fixture
that rejects dead consuming helpers and checks a retained-input exclusion.

The measurement driver and reference are published. Five reference, ten
compiler-driver, 22 budget, eighteen raw-evidence and twelve grouped-evidence
controls pass serially (28.66s); workflow lint passes (7.18s); tracked roadmap
links pass (273 sets, 2.77s). The census is prepared with five negative controls passing; workflow lint,
those controls and roadmap checks pass together in 9.21s. It runs no timing samples: both compiler
variants, all six cases, both result forms and both workspace settings must
match the exact allocation prediction and preserve aliases/cleanup.

Keep [PR #257](https://github.com/e6qu/fun-with-pipes/pull/257) at `519fc966`.
All six executed production jobs and docs pass; the three unexecuted macOS jobs
were retried once the first attempt completed. Attempt 2 jobs: Intel ownership
`126845864825`, ARM ownership `126845865096`, ARM regular `126845865460`.
Audit completed full logs and preserve carried-forward passing gates. Do not
open a second PR or merge until every final-head gate passes.

Preparation worktree `.worktrees/owned-numeric-updates`, branch
`owned-numeric-updates`, starts at `519fc96670b0db90ebe0f68e1263ccf85d2cf4f1`.
The delivery worktree `.worktrees/packed-derivative-inputs` owns #257's live
handoff and collector output. The roadmap table below still describes #257;
the next group is implemented in preparation, with native verification pending.

Contract `1c5e6a66`, pushed tag `roadmap/owned-numeric-updates-protocol-2026-11-04`,
precedes code. Both private consuming entries, bounded last-use selection and
protected reuse are implemented. Tests cover alias roots/shared ancestors and
tails, array views, unequal lengths, overflow, F32/F64 bits, traps, cancellation,
allocation failure, exact allocation counts, physical frees and broken observers.
Existing borrowed cleanup tests now read input lengths after zipping, so they
continue exercising the borrowed operations explicitly.

Focused checks: Rust formatting 1.88s; workflow lint 6.48s; native runner coverage
and failure controls 21/21, 8.25s; roadmap links/anchors 4.27s; five packed-reference
controls 0.37s. The first gradient-reference check failed five of six controls
because an unnecessary interpreter branch changed the historical patch context.
Private consuming entries now explicitly reject interpreter execution (they are
introduced only in native lowering); all six controls pass, 0.60s. No historical
patch or evidence was rewritten. Source review also moved the new C finish helper
after its owner-type declaration before publication. Full builds/tests remain on GitHub.

Final [production 41861939596](https://github.com/e6qu/fun-with-pipes/actions/runs/41861939596)
and [docs 41861939765](https://github.com/e6qu/fun-with-pipes/actions/runs/41861939765)
use exact head `519fc96670b0db90ebe0f68e1263ccf85d2cf4f1`. All six executed jobs and docs have audited full logs: 257 integration target
logs per Linux host, 131 for Intel regular, and 57 main plus 155 additional
targets per Windows host. Attempt-1 collection took 151.04s and exited nonzero
only for the three unexecuted macOS gates. Retry identities remain distinct.
Collector output: `../gradient-work/platforms-257`. Keep cancellation diagnostics;
no runner means no native coverage. Leave unrelated primary-checkout changes alone.

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
suites stay on GitHub. Limits unchanged. Disk reached 65 GiB free; removed 778,568,743 bytes of
duplicate #256 downloads after checking all 157 retained logs per Windows host
against their hashes. An initial cleanup assertion assumed the newer target
count and stopped before deleting anything; the corrected check compares exact
file inventories. Current #257 and next-group evidence is preserved.

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
