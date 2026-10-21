# Session handoff

## Next action

Next: publish `task-cancellation-stack` for focused native and WebAssembly
validation. This is an isolated preparation in `/private/tmp/fwp-task-cancellation`;
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
hashes and host/toolchains. Run `wasm-hosts` separately for actual JSPI/Asyncify
execution. No native build, benchmark or full suite runs locally.

## Checks and publication

All local checks use `python3 scripts/local-guard.py COMMAND...` from the root
worktree. `rustfmt --edition 2021 --check` passed for the three changed tests;
`python3 -m py_compile` passed for the inspector. The native runner's
`Coverage.test_repository_targets_are_assigned_exactly_once` passed. No test
target was added or moved. Native execution and measurements remain pending;
do not claim reduced process memory or faster execution. Run the documentation
audit before publishing and preserve one-line commit messages.

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
