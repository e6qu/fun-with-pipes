# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for needed sharing. JIT is excluded.

## Current delivery

[PR #204](https://github.com/e6qu/fun-with-pipes/pull/204) is open at
`80c89baa53567839dce0599d88f18d5791285943`. Production `40019873535` and docs
`40019873426` are the final-head gates. Require all nine production jobs, docs,
full log audits and 6,966 saved binary files across six native hosts before squash
merge. Use one subject of at most eighty characters and an explicit empty body.
Do not change that tested branch while its gates run.

[PR #203](https://github.com/e6qu/fun-with-pipes/pull/203) is verified merged at
`3e3ebd2717f4d77c8d8331e7df1936768546d1ed`, with all gates and 5,118 saved files
accepted. Its redundant same-tree main CI was cancelled; docs were retained.
[History](roadmap-history.md#tasks-state-and-runtime-call-cleanup-pr-203) records it.

## Independent numerical preparation

**Next:** publish and run the longer output-cost diagnostic in
`/private/tmp/fwp-descent-output`, branch `descent-output-preparation`, based on
#204's source. Initial source `697f0ba6e01a2f24b31ab699452152c7c6e09fb3` and run
`40021659651` passed both Linux jobs, full-log audits and 338 binary inspections.
[The initial report](measurements/descent-output-initial.md) retains five
inconclusive timing rows. The revised protocol explicitly uses 32,768 solves for
3-coordinate 0/1-update cases, and 4,096 for the others. Publish an immutable
source and dispatch `descent-output` with `native_runner=all`. Repeat on matching
CPU models before drawing timing conclusions. Keep one
active PR; combine the accepted diagnostic with related work after #204 merges.

The [protocol](measurements/descent-output-protocol.md) compares unchanged full
output against an external consumer of every result coordinate. It covers fwp
and coordinate-based C/Rust, fresh inputs, all updates and cleanup. Checksum work
replaces output construction, so the difference is not pure formatting time.
No compiler/runtime change or repeatable speed result is claimed. Every memory
checkpoint remains checked and saved; compact summaries hash the complete logs.
Regular Linux CI now includes untimed output/lifetime and observer controls.

Sixty untimed ARM64 controls pass (20.45s), using accepted compiler
`5e17fc10e860b1971ffc9cd9cb57fcb795ccad24` with unchanged compiler/runtime/library
sources. They cover complete output, exact float bits, omitted coordinates,
per-solve memory balances and missing releases. Actual C/Rust/fwp binaries were
inspected. Reports and generated files remain in
`/private/tmp/fwp-descent-output-controls-v2`; the earlier 36-case run is retained.
Review corrected the consumer to read bytes instead of aliasing word-backed
storage as doubles. The shared Rust observer now also supports a checksum report
after the solve loop. All sixteen existing coordinate/edge controls also pass
(5.69s), including omitted releases; receipt
`/private/tmp/fwp-coordinate-controls-output-change.json`.
Local Clang is not GCC acceptance. Benchmarking runs only on GitHub.

The initial GCC runs pass the same controls on both Linux hosts. Inspection
resolved Rust's indirect AMD64 consumer calls through actual ELF relocations;
the first direct-call-only inspection stopped rather than assuming a call target.
An unused Rust buffer disappears in the timed zero-update binary but remains
observable under instrumentation; the report now states this limit. Initial
archives/reports remain under `/private/tmp/fwp-output-evidence/697f0ba6e01a`.
`fwp-output-preparation.json` records the completed initial publication; do not
rerun its publication helper. The revised source has not yet been published.

## Resume records

`/private/tmp/fwp-derivative-array-publication.json` identifies #204. Use
`fwp-audit-derivative-array-final.py`, `fwp-inspect-derivative-array-delivery-builds.py`
and `fwp-merge-derivative-array.py` for exact-head acceptance. Its focused source
`9e9662f93aa5e1f0ebd86b6a31d9396dffe13215` passed Linux AMD64 and both Windows
runs, including 3,483 saved binary files. Intermediate 975/1,045-file inspections
are not claimed. Source tags, logs and failure repairs remain recorded.

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, benchmarks
and suites stay on GitHub. Preserve resource limits and failure evidence. Read
mutation receipts before resuming; never repeat completed publication or merge.

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

The largest measured descent still takes about 10–14 times C/Rust time. Separate
output, indexing, callback and buffer costs before selecting optimizations. An
untimed local review found callback and loop bodies inlined in ARM64 code;
verbose unused generated C is not evidence of execution overhead. Scheduling
models from completed Linux CI logs suggest only about two minutes can be saved
by reordering fixed-duration targets; no runner change or speedup is claimed.
