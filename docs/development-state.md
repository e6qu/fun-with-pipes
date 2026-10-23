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

**Next:** complete the [formatter candidate](measurements/float-text.md) checks
and publish its focused native/measurement preparation while #204 finishes.
Worktree `/private/tmp/fwp-float-format` is based on longer diagnostic source
`a948b7478278a6ee8c5b81cfaf6e8272e96bf935`. That source is already published under
`roadmap/preparation-output-longer-a948b7478278`; runs `40024299907` and
`40024303916` are underway. Do not repeat publication. Initial source
`697f0ba6e01a2f24b31ab699452152c7c6e09fb3` and run
`40021659651` passed both Linux jobs, full-log audits and 338 binary inspections.
[The initial report](measurements/descent-output-initial.md) retains five
inconclusive timing rows. The revised protocol explicitly uses 32,768 solves for
3-coordinate 0/1-update cases, and 4,096 for the others. Compare independent
runs on matching
CPU models before drawing timing conclusions. Keep one
active PR; combine the accepted diagnostic with related work after #204 merges.

The [protocol](measurements/descent-output-protocol.md) compares unchanged full
output against an external consumer of every result coordinate. It covers fwp
and coordinate-based C/Rust, fresh inputs, all updates and cleanup. Checksum work
replaces output construction, so the difference is not pure formatting time.
The diagnostic does not change the runtime. No repeatable speed result is claimed. Every memory
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
rerun its publication helper. Both initial ZIPs were pruned after inspection,
digest checks and verification of unexpired GitHub originals.

The formatter candidate changes only `fwp_format_g`: reuse rounded digits for
fixed output, retain integer/scientific paths. Twelve local ARM64 generated-C
cases pass at O1/O2, including raw-interpreter output, tracing stress and
deliberately changed digits/boundaries. The precision probe checked 119,768
values and 1,017,484 precisions. Reports remain in
`/private/tmp/fwp-float-native-v1/results.json`. This patches the exact function
in accepted compiler output; it does not compile the changed Rust harness.
The `float-text` workflow must build/test all six native hosts. Its paired
Linux benchmark requires 2% noise controls and a repeated 5% reduction for the
largest case on both architectures, while reporting every other case and stack/
code-size costs. No timing improvement is established.
Eight untimed numerical binaries also passed (8.39s), including identical
formatter memory observations and native C/Rust buffer cleanup. The new workflow,
Rust formatting and documentation checks pass; full builds remain on GitHub.
Receipt: `/private/tmp/fwp-float-measurement-v1/results.json`.

Formatter preparation `5476466183f7adc663d54dc69118fdb69225f8f8` is published
under `roadmap/preparation-float-text-5476466183f7`. Run `40027402138` checks six
native hosts and measures Linux; `40027406689` repeats only Linux measurements.
Both Linux and both macOS correctness jobs passed complete-log audits. Windows
AMD64 and ARM64 failed the new summary's LF-only assertion despite zero numerical
mismatches and zero canary failures; all three other test targets passed on each.
Every completed target and failed job has been audited. The repair parses exactly
one line, accepting platform line endings,
and saves every O1/O2 corruption case before reporting collected failures.
Publish the checked repair. Runtime and measurement sources remain
unchanged; preserve the active measurements. `float-text-checks` reruns correctness
without repeating benchmarks. Failure evidence is retained in `/private/tmp`.

Both longer output runs passed complete-log audits and all 676 binary inspections.
The [report](measurements/descent-output-longer.md) records matching AMD EPYC 7763
and Neoverse-N2 models, all samples and three inconclusive AMD64 pairs. Nine of
twelve pairs pass both runs' controls. All four downloaded ZIP caches were pruned
only after inspection, digest checks and verification of unexpired remote originals.

For #204, macOS ARM64 regular/stress, benchmarks and docs have passed full-log
audits; all 1,161 macOS ARM64 files passed independent inspection (26.14s).
Both local ZIPs were pruned after verifying remote originals. Six other native
jobs were still running at the last audit. Never treat a subset as delivery.

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
