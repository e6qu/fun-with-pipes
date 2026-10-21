# Session handoff

## Next action

Next: finish the task-cancellation and Windows ARC storage group on
`task-cancellation-stack` in `/private/tmp/fwp-task-cancellation`. There is no PR
for this preparation yet. Keep one active delivery PR: #187 is still waiting for
its last Linux gate at `81bb3efa8e3f2cc5f3dd9f0ae9952709088c2905`.
Its nine other gates passed; `/private/tmp/fwp-merge-187.py` rechecks all ten,
merges with the authorized one-line subject and empty body, and verifies the
resulting message, parent and tree. Do not reset healthy CI for a status edit.

## Accepted focused evidence

Cancellation return state now lives in the active task entry frame. The record
borrows its address and clears it before retirement; retained handles cannot
retain a stale stack pointer. WebAssembly return-table growth now checks
allocation failure, arithmetic bounds and identifier exhaustion.

Source `b37f5948d07128455a76e177f66448240bb47389` passed six native jobs in
run `39625011684` and two WebAssembly jobs in `39625018036`. Immutable tag:
`roadmap/revision-task-cancellation-b37f5948d071`.
The [comparison](measurements/task-cancellation.md) explains inputs, counters,
stack costs and limits; its raw report preserves all results. All 84 native
binaries and 224 WebAssembly module headers were inspected; the latter include
24 executed return-state controls. All complete job logs were audited.
These are focused results, not final-head production acceptance.

Earlier failures were fixed across all jobs: invalid ARC reuse verification,
18 synthetic tasks with obsolete embedded buffers, and missing native TLS test
dependencies. A synthetic worker test now uses legal nested setjmp conditions.
The old failed audit remains in `/private/tmp/fwp-task-cancellation-failed-1fd972ac14d0.json`.

## Additional Windows change under test

Windows ARC now omits the collector-only register buffer and stack marker, plus
snapshot/clearing work at each fiber switch. Tracing keeps them. New probes check
pointer/floating registers, stack contents, rounding, repeated fiber teardown and
host ownership at O0/O1/O2, with a restored-snapshot fault control. A matched
O0/O2 ARC task comparison counts heap costs, snapshots and switches. Both native
Windows hosts must execute these tests and retain all ten new actual binaries.
The focused workflow also runs existing Windows root and static-memory tests.
No execution result or cost for this addition is accepted yet.

The Windows production workflow now includes task-handle and timer-order checks
and removes one duplicated loop-unwind invocation without losing coverage.

## Validation and delivery

Use `python3 scripts/local-guard.py COMMAND...` for serial focused checks.
Formatting passed; native execution stays on GitHub. Preserve 64 GiB free disk,
2 GiB generated target, 1 GiB sampled workload RSS and the 180-second deadline.
No local native build, benchmark or full suite has run.

Publish the added Windows work and run both focused matrices. Audit every job
and fix all failures; inspect actual Windows binaries and update the comparison.
After #187 merges, rebase this group onto its verified merge and open one PR.
Require all nine production gates plus documentation on the final head before
squash merge. Use a single-line subject of at most 80 characters and an empty body;
verify the actual commit message, sole parent and tested tree.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open. These changes reduce task
heap storage and unnecessary collector work; they do not finish tracing removal,
eliminate ARC, prove a general speedup or establish C/Rust performance parity.
The next ownership work must preserve failure/cancellation cleanup and measure
representative programs before choosing an optimization.

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
