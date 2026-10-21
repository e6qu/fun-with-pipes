# Session handoff

## Next action

Next: finish focused validation of the task-cancellation and Windows ARC group
on `task-cancellation-stack` in `/private/tmp/fwp-task-cancellation`, then prepare
its final production PR head. Source `71ef0268ca1a2f279036b4b6e57b81e2c8ad288f` is preserved by tag
`roadmap/revision-task-cancellation-71ef0268ca1a`. Native run `39630720224` and WebAssembly run `39630724707`
check that source. Use `/private/tmp/fwp-audit-task-cancellation.py` through the
local guard; audit every job and inspect actual binaries before accepting results.
The stage-two inspector is `/private/tmp/fwp-inspect-cancellation-stage2.py`.
The current publication and acceptance receipts live under `/private/tmp`.

PR #187 passed all ten gates and squash-merged as `eb9ba7e828a5ab8ef0f7579b7f6fe1263e752c8c`.
Its complete-log receipt `/private/tmp/fwp-187-final-acceptance.json` verifies the
actual message, parent and tree. Do not repeat its merge. The new branch rebases
onto this verified merge; its runtime, compiler, tests, scripts and workflows
must remain identical to the focused source above until any required repair.
The draft PR number and final rebased head are recorded in
`/private/tmp/fwp-task-cancellation-delivery.json` after publication.

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
Keep one delivery PR; the branch is rebased onto the verified #187 merge.
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
