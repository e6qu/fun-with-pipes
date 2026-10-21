# Session handoff

## Next action

Next: validate the batched cancellation-test repair on all six native hosts and
both WebAssembly hosts. `/private/tmp/fwp-task-cancellation-publication.json`
records the published source and focused run IDs for `task-cancellation-stack`.
This is an isolated preparation in `/private/tmp/fwp-task-cancellation`;
PR #187 remains the sole active delivery. Do not open another PR until it merges.

PR #187 tests `81bb3efa8e3f2cc5f3dd9f0ae9952709088c2905` in production run
`39613713414` and documentation run `39613713402`. Documentation passed;
production is running. Use `/private/tmp/fwp-audit-187-final.py` through the guard,
fix every failure and use `/private/tmp/fwp-merge-187.py` only after all ten gates
pass. The root worktree retains its handoff and merge receipt paths. Do not restart
its healthy final-head CI for a preparation or a documentation-only update.

## Cancellation-state preparation

Each task previously embedded a C `jmp_buf`, which saves the return point for
cancellation. The candidate stores it in the still-active task entry frame and
borrows its address. It clears the address before joining children or finishing;
the root never uses this buffer. There is no extra allocation or runtime policy.
Saved bytes move onto child stacks; they are not eliminated. See the
[comparison guide](measurements/task-cancellation.md) for the lifetime argument,
program, measurement scope and limits.

`arc_tasks` compares the old embedded layout with the candidate at native O0/O2,
in ARC and tracing builds. It records requested/charged bytes, retains, native
record alignment and generated C/binaries. Both comparisons disable collection.
Separate correctness builds enable tracing stress/reuse checks; omitted pointer
setup/clearing must fail with distinct statuses. Native runs are bounded and
reaped on timeout. Retained-handle, scoped cleanup and WebAssembly JSPI/Asyncify
checks also reject pointers that survive their task frame.

Focused suite `task-cancellation` covers all six native hosts with their production
C compilers. It also runs task/scope, library-unload and static-budget checks;
Linux installs strace before checking mapping budgets. `inspect-task-cancellation.py`
verifies each binary's native architecture and records real disassembly, sections,
hashes and host/toolchains. The existing `wasm-hosts` run checks actual
JSPI/Asyncify execution. No native build, benchmark or full suite runs locally.

The WebAssembly helper review also found unchecked return-state table growth.
The published repair checks capacity/byte overflow, allocation failure and
identifier exhaustion, with exact-diagnostic WASI tests. The earlier preparation
runs were cancelled while queued; `/private/tmp/fwp-task-cancellation-prior-probe.json`
records their states. The guide records the pointer-width identifier limit explicitly.

## Focused failures and repair

All six native jobs at `1fd972ac14d0b16ab59b14975debbc6f8ef98b05` failed;
complete logs are audited in `/private/tmp/fwp-task-cancellation-acceptance.json`.
The native causes are an invalid ARC reuse-verification setting, synthetic tasks still
using the old embedded buffer, and missing TLS dependencies in the focused job.
The binary inspector correctly rejected the incomplete comparison.

Local repairs in `/private/tmp/fwp-task-cancellation` set reuse verification only
for tracing, update all 18 synthetic cancellation sites to borrow live local
buffers, and install native macOS/Windows TLS dependencies. The worker-preparation
test also now uses legal nested `setjmp` conditions. The focused workflow adds all
14 affected test targets with production Rust optimization/check settings.
The storage comparison explicitly disables link-time optimization for both layouts
and records compiler flags, preventing source-size-dependent compilation choices.
Formatting and whitespace checks passed for the nine changed Rust files through
the local guard. Native execution of these repairs remains pending. The WebAssembly suites passed
their actual WASI/JSPI/Asyncify checks; their native `arc_tasks` step hit the same
invalid ARC setting. Both full logs were reviewed. Publish the repairs together
and rerun both focused suites before accepting measurements.
PR #187 remains unaffected with four accepted gates and no reported failures.

## Checks and publication

All local checks use `python3 scripts/local-guard.py COMMAND...` from the root
worktree. `rustfmt --edition 2021 --check` passed for the three changed tests;
`python3 -m py_compile` passed for the inspector. The native runner's
`Coverage.test_repository_targets_are_assigned_exactly_once` passed. No test
target was added or moved. Native execution and measurements remain pending;
do not claim reduced process memory or faster execution. The documentation audit
passed 79 link sets, 106 immutable pairs and seven roadmap areas.
Publication receipt: `/private/tmp/fwp-task-cancellation-publication.json`.
Do not restart healthy focused runs merely to publish a status update.

After focused acceptance, inspect all saved binaries and measurements, fix any
failures, then rebase onto PR #187's verified squash merge. Update the report and
handoff, publish one substantial PR and require all nine production jobs plus
documentation for its exact final head before squash merge.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
