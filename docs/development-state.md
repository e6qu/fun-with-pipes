# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing, prefer
ownership and borrowing, and reserve ARC for necessary sharing. JIT is excluded.

## Accepted work and current delivery

[PR #201](https://github.com/e6qu/fun-with-pipes/pull/201) passed all nine production
jobs, documentation and inspection of 1,986 saved binaries across six native
hosts at `c6ad1aaf6d2f58fa41e11e326fe83ac8a5156f31`. Its verified squash merge is
`c56f85547610b14bd1b8af9a9ad96413f3c494e9`. No delivery PR is open. Checked ARC is the native default;
explicit tracing remains, and all seven roadmap areas remain open.

## Next action

**Next:** publish the combined 38-target focused preparation, audit all Linux and
Windows outcomes and inspect saved binaries. The earlier seven-target source
`84d39476347b55b4b90d1d682c81f866eaa931a6` passed all 35 Linux targets, 179 library
tests, both focused Windows runs and 511 saved images on each of those hosts.
Its source remains preserved; the expanded preparation adds cached values,
escaping functions and temporary containers. No second delivery PR is open.

Worktree `/private/tmp/fwp-cached-value-cleanup`, branch
`cached-value-cleanup-preparation`, is based on that passing source. Compiler and
runtime are unchanged. It adds a coverage control to catch Windows omissions and
selects the previously missing temporary-container target, alongside the four
Windows coverage repairs already prepared. Final-head production acceptance is
still required before merging the eventual grouped delivery.

## Changes and checks

Field selection, pattern matching, returned aliases and temporary reusable
storage now have repeated ARC cleanup checks alongside tracing controls.
Negative cases deliberately omit cleanup or add owners. Erased internal child
types must be rejected in ARC. Reuse checks cover failure, unused cells and a
million-step native tail recurrence. Compiler/runtime behavior is unchanged.
[The guide](measurements/record-cleanup.md) explains the concepts and examples.

Windows was missing match-context, reuse-token, ARC corpus, HTTP/2 body-copy
and temporary-container targets; all five are now selected. Linux's `static_memory` is deliberately
Linux-only; Windows has native `windows_static_memory` checks. An earlier claim
that every shared focused target ran on Windows was too broad and is corrected.
Final Windows execution remains required for the added targets.
The two internal variant tests serialize changes to process-wide generator
options. Combined focused native CI selects 38 related targets, with one macOS
shard per target. Preserve source-program CLI builds and raw-interpreter comparisons.

Guarded local checks use accepted compiler `5e17fc10` with unchanged runtime:

- Field/match source checks: 24 ARM64 binary checks, including eight complete
  O1/O2 programs. `/private/tmp/fwp-field-source-current/results.json`.
- Reuse checks: 22 ARM64 binary checks, including four complete programs and
  six million-step tail cases. `/private/tmp/fwp-reuse-current/results.json`.
- Added call/fold/loop checks: 108 ARM64 binary checks, including twelve complete
  interpreter comparisons. Guard times: loop 18.66s, calls 20.00s, fold 53.66s.
- Returned-alias source: six observations from four O1/O2 binaries; eighteen
  ownership-setting cases. `/private/tmp/fwp-alias-program-current-v2/results.json`.

The first alias helper expected concatenation in the wrong order; raw
interpretation returns `laterlastfirst`. The helper was corrected and rerun;
the repository test already compares with the interpreter. Its failed first
attempt remains preserved. The four original new targets passed their native
cases in the initial focused run. The original seven additions passed their focused run. The new cache/closure/temporary
extensions still require Rust-harness and GCC execution. Complete
cross-platform acceptance remains required on the final delivery source.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Full builds and suites stay on GitHub. Keep all fixed resource limits.

## Resume records

Prior accepted work and current delivery are identified by
`/private/tmp/fwp-collection-publication.json`; its full audit is
`/private/tmp/fwp-collection-final-acceptance.json`.
The seven-target preparation and its accepted focused runs remain recorded in
`/private/tmp/fwp-call-preparation.json` and the matching focused receipts.

Added local checks pass 54 ARM64 binary observations, including cached success,
cached failure, closure aliases, temporary aliases and deliberately omitted
cleanup. Receipts: `/private/tmp/fwp-cached-source-current-v2/initialization-results.json`,
`/private/tmp/fwp-cached-trap-current/results.json` and
`/private/tmp/fwp-closure-temporary-current/results.json`.
The internal cache probe still requires Rust-harness/GCC execution. A first
helper mistook allocator remaining allowance for live bytes; the corrected check
requires restoration to `budget_given`. A second helper assumed trap exit 1;
the interpreter returns 101. Failed attempts remain preserved; only affected
checks were rerun. No product-runtime defect was found by those attempts.

`/private/tmp/fwp-prepare-cached-cleanup.py` and
`/private/tmp/fwp-prepare-closure-temporary.py` COMPLETED; do not rerun them.
Their original tests remain in `/private/tmp/fwp-*-before.rs`.
`/private/tmp/fwp-check-cached-preparation.py` verifies current source/probe
identities, runner controls and docs before publication.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

The largest measured descent case still takes about 10–14 times the C/Rust time.
Fewer allocations alone do not establish parity. Preserve measured controls and
separate callback, indexing, output and buffer costs before selecting changes.
