# Current work

**Next:** finish native verification of captured-scalar array maps, then run the
frozen sensor/pixel comparison and bundle implementation, evidence and docs in
one normal PR. [The contract](measurements/captured-array-maps.md) defines safety,
inputs, schedule and acceptance. No performance claim is made yet.

## Workspace

Branch `captured-array-map-reuse`, worktree `.worktrees/recording-capacity-gate`.
Base `f87796b52081889b96859dbd72bf4af9a6726207` is merged PR #270. Preserve unrelated
root-worktree changes. No new PR is open yet.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | #270 delivered fresh F64 stores and refreshed docs/tutorials. ARM64 improves 26–31%; original AMD64 timing acceptance stays open. |
| 2 | In progress | Captured-scalar map selection/cleanup and controls implemented; native verification, measurements and delivery pending. |
| 3 | Pending | Structured differentiation across three objective families; preserve general AD, nesting and precision. |
| 4 | Pending | Current Swift/C/Rust ownership comparisons, phase timings and explicit memory boundaries. |
| 5 | Pending | Three application/tooling paths; compiler phase/scaling costs and demonstrated usability repairs. |

## Verified previous delivery

[PR #270's delivery record](measurements/fresh-array-delivery-2026-11-08/README.md)
retains tested/merged tree identity, all nine production jobs, docs and the passing
complete audit. Production `42445576778`; docs `42445576736`; complete audit
`42466806957`, job `128688101490`, at auditor source
`416ba52854ce8926460fe2c08762f8401152a398`.

The first audit flagged a recovered Intel macOS checkout timeout. The repair
requires a successful identical-command, exact-source retry and retains both
diagnostics. Ten negative/positive controls and actual-log replay pass. The
passing artifact `13612140976` has verified SHA-256
`c822dbbbc30e1f5c721dbe90c1e6610f5087530405d73db314fc1b871fb76a75`.

Keep [original timing misses](measurements/fresh-array-costs-2026-11-08/README.md)
and the [C/Rust comparison limits](measurements/loop-array-peers-2026-11-08/README.md).
CPU pinning did not resolve AMD64 variation; do not repeat unchanged timings to
obtain a pass or treat the user's merge as completing milestone 1.

## Current implementation and checks

The map proof now accepts known partial callbacks whose saved arguments are plain
scalars. A private entry receives captures, then the consumed array. Existing
liveness, uniqueness/view checks and protected cleanup remain. No API change.

Controls cover capture arity/order, excluded representations, bounded analysis,
raw/optimized/native values and effects, shared inputs/views, failures,
cancellation, reuse disabled and deliberately broken cleanup. Added checks cover
F32/F64 payload preservation and computed captures. The benchmark compares an
isolated same-source reference disabling only captured-map selection; closed maps
remain optimized in both. All 48 cases retain exact-result/alias checks, paired
copy timings and separate memory/compiler observations.

Focused run `42468684378` and docs `42468686384` test source
`b41752cac9ff12148bbd4bbf0b3cfa2efe913f5e`. Native jobs: AMD GCC `128694090277`,
ARM GCC `128694090574`, macOS ARM Clang `128694090623`; docs job `128694094171`.
All were queued at the last poll. The superseded run `42466992494` was cancelled:
its Mac runner had only reached dependency fetching, and neither Linux job
started. No native target results were discarded.

Do not measure until these three native jobs and their complete focused audit
pass. Dispatch `numerics.yml`, suite `captured-maps`, evidence run `42468684378`;
the workflow audits it before scheduling the two sessions on each architecture.
It rejects changes to compiler/runtime/library/native tests since the checked
source. Final delivery still needs all nine production jobs and docs on the
exact final PR head. No PR is open yet.

Guarded local checks so far:

- `python3 scripts/test-captured-map-costs.py`: 4 controls pass.
- `python3 scripts/test-borrowed-array-costs.py`: 14 controls pass.
- `python3 scripts/check-measurement-clocks.py --cc clang`: 64 O1/O2 executions
  pass for 8 helpers; GCC verification remains in CI.
- Isolated unchanged production parser/formatter: both native fixtures and both
  measurement programs parse, preserve their AST and format idempotently.
- `cargo fmt --all -- --check`: passes after wrapping the new diagnostic.
- Workflow YAML parsing and 386 Markdown link sets/five roadmap rows pass;
  the link check used the Git index for intentionally sparse historical files.
- Prior audit controls: 10 pass; recovered real checkout log replay passes.

All commands run through `python3 scripts/local-guard.py`. Free disk recovered
from below 64 GiB to about 83 GiB; small guarded checks resumed. Full builds,
native suites, benchmarks and large evidence generation remain on runners.
