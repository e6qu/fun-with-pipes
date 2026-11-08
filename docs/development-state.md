# Current work

**Next:** verify the repaired selection of let-bound scalar callbacks, then run the
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

## Native failure and root repair

Focused run `42468684378` tested `b41752cac9ff12148bbd4bbf0b3cfa2efe913f5e`.
AMD GCC job `128694090277`, ARM GCC `128694090574` and macOS Clang `128694090623`
all completed. Each passed formatting, Clippy, 11 ownership unit tests and six
of eight native targets. The same two checks failed on every host:

- `mapped_array_construction`: the exported captured callback did not select a
  consuming map.
- `zip_unwind_ownership`: the deliberately broken captured-input owner could not
  be injected because no captured consuming worker existed.

All target results and complete job logs were read. Generated source shows why:
production IR binds `Apply(Func, captures)` to a local before calling `array.map`.
The first implementation only handled an inline `Call`; its synthetic unit
fixture used the same wrong form. No runtime measurements were collected.

The repair recognizes actual partial applications and indexes bound callbacks
once. It snapshots captures at their original binding, including computed values,
and passes the saved scalars directly. Other uses retain the original closure;
only fully replaced uses remove it. Parameters, pattern bindings and multiply
bound locals cannot supply an ambiguous origin. New unit cases cover eager
capture placement, another escaping closure use and one binding shared by
1/8/128 maps. The reference disables both captured selection and its added index.
The source edit is ready for focused runner verification; local guard refused
further checks after free space fell to about 60 GiB.

Docs run `42468686384`, job `128694094171`, passes at `b41752cac`; subsequent
cross-link/repair notes still need the next docs gate. Superseded run
`42466992494` was cancelled before native tests. Duplicate post-merge CI
`42465665987` was also cancelled after verifying its tree equals fully audited
PR #270. Its nine logs show no failed test results; Windows panic messages belong
to the explicit scheduler panic controls. Neither cancellation proves this new
implementation correct.

Do not dispatch `captured-maps` measurements until the repaired source passes all
three focused jobs and their complete audit. Pass that new run ID as
`evidence_run`. Final delivery still needs nine production jobs and docs on the
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

All checks run through `python3 scripts/local-guard.py`. Free disk briefly
recovered to about 83 GiB, then fell below 64 GiB again. Further formatting and
control checks were refused; do not bypass the guard. Full builds, native suites,
benchmarks and large evidence generation remain on runners.
