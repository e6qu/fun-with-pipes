# Current work

**Next:** finish reviewing all original measurements, verify the shared-empty-input
repair, then measure the changed implementation and bundle code, evidence and docs in
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
| 2 | In progress | Captured-scalar map selection/cleanup passes focused native checks; measurements and final platform delivery pending. |
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

## Current verification

[The contract](measurements/captured-array-maps.md#verification-before-delivery)
retains both failed runs and their causes. All three complete job logs and eight
native target results were reviewed in each run.

Compiler source `0c704421f9ebb8ab88aed2980170aead302e7a87` fixes the missed callback
bindings. Run `42470453910`: macOS `128699747181`, AMD GCC `128699747222`, ARM GCC
`128699747316`. Each passes formatting/Clippy, all 13 ownership unit tests and six
native targets. Captured export selection and ordinary O1 cleanup/reuse now work.
Two test assumptions still fail identically on all hosts:

- `mapped_array_construction` demands a map marker in optimized main. The repair
  explicitly compiles exported functions with runtime arguments for selection;
  ordinary main still verifies raw/optimized/native values, effects and traps.
- `zip_unwind_ownership` expects leak status 90 from a missing-input-owner mutant.
  The alias-count check correctly rejects it first with status 248. Require 248;
  keep the independent physical-allocation ledger and missing-suffix control.

Test/auditor repair `46ac4cf383c614aceb715675aba71e2b85416a4f` is published.
Focused run `42471671589`: ARM GCC `128703672142`, macOS Clang `128703672177`, AMD
GCC `128703672234`. All three pass formatting/Clippy, 13 ownership unit tests and
all eight native targets (47 tests per host). All nine analysis-size observations
per host meet the frozen visit bound. Complete logs contain no compiler warnings
or errors. Docs run `42471674968`, job `128703678444`, also passes. Compiler code
is unchanged from `0c704421f`.

The measurement driver also now requires the ordinary ABI entry to have the same
function ID as the named `measure` worker. Its control rejects a neighboring
four-argument function, instead of accepting the first matching signature. All
four local measurement-control tests pass after that repair.
Measurement run `42472528452` uses source
`025016fbedfcac2127619e4a053415aa83b9d6b0` and focused evidence `42471671589`.
Its complete focused audit passes, job `128706453822`. The
[retained audit](measurements/captured-map-checks-2026-11-08/README.md) verifies
eight targets, 382 probe outcomes and native images on each host with no issues.
Artifact `13614402438` has locally verified SHA-256
`29391978968f75b6661d09b049290f8152e51afb7692127366c598fcb9822de6`.

Session 2 passes on ARM (`128711666641`) and AMD (`128711666605`), including all
48-case reconstruction audits. Both session 1 jobs are still collecting separate
memory/compiler observations (`128711666600` / `128711666753`). AMD2's largest
exclusive 199-update cases qualify at 93% less sensor and 91% less pixel work;
many other AMD2 controls are inconclusive. ARM2 has qualified shared empty
one-update regressions of 3.77% (sensor) and 4.45% (pixels). Preserve these results.

The prepared repair returns an ordinary empty array's existing owner without
allocation, cleanup scopes or writes, including shared inputs and no-reuse builds.
Empty views keep independent output so they release potentially large backing
storage. The existing physical-free/alias checks now require this exact behavior.
This source change is not yet natively verified. No acceptance limit changes;
new timings must compare this changed implementation, not rerun unchanged cases.
Final delivery still needs nine production jobs and docs on the exact final PR
head. No PR is open yet.

Superseded run `42466992494` was cancelled before native tests. Duplicate
post-merge CI `42465665987` was cancelled only after checking its tree equals
fully audited #270. Its nine logs contain no failed test results; Windows panic
messages are the explicit scheduler panic controls. Neither cancellation verifies
the new implementation.

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

All local checks use `python3 scripts/local-guard.py`. Disk space has fluctuated
across the 64 GiB reserve; stopped when refused, resumed small checks after it
recovered above 81 GiB. The current test repairs pass full Rust formatting and
the four measurement controls locally. Full builds, native suites, benchmarks
and large evidence generation remain on runners.
