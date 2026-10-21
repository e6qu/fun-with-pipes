# Session handoff

## Next action

Next: require all nine production jobs plus documentation for the final head
of the data-queue capture PR on `prove-data-queue-captures`. Audit every completed
log and fix every failure. Then squash-merge with an explicit one-line subject
under 80 characters and an empty body. Standing authorization remains in effect;
focused checks alone do not authorize merge. Keep one active PR.

PR #184 passed all ten gates and was squash-merged as
`b3401149955ff6e0aaa1d70044b527aec20f2e5f`. Its tested head `0509937311ffd94171da9e2213c387d23e81739a`
and merge have identical trees. The [history](roadmap-history.md#queued-socket-callbacks-and-handler-inference-pr-184)
records acceptance; local receipt `/private/tmp/fwp-184-final-acceptance.json`
verifies the message, parent and tree. Do not repeat that completed delivery.

This checkout is `/private/tmp/fwp-data-queue-captures`, based on that accepted
main commit. All eight focused jobs in
`39578006890` passed at `3e3385c12fda3097b39f901146b4290bb32161e5`; remote tag
`roadmap/revision-data-queues-3e3385c12fda` preserves that source. Only a source
comment, documentation and evidence changed afterward. Final-head production
checks remain required; their IDs will be recorded locally after publication.

## What changed

The ownership analysis tracks known queue creators and unknown sources alongside
functions. A queued callback may capture a data-only queue from `channel.make`,
including through records, lists and nested data queues. Every value sent into a
nested queue is checked. A known outer creator cannot hide an unknown inner owner.
Function-return summaries now preserve queue origins; the first probe exposed
that they previously erased all non-function origins. A full-analysis unit control
covers that repair. First probe audit: `/private/tmp/fwp-data-queue-probe.json`.

Function-bearing captured queues, recursive queue ownership, unknown/native
producers, tasks, HTTP streams, gRPC cells and single-use files retain their
restrictions. No runtime layout, weak-reference API or syntax changes were added.
The [ownership guide](ownership.md#functions-stored-in-channels) includes an
explained example; the [evidence guide](measurements/queued-data-channels.md)
states exactly what the checks measure and exclude.

## Verified checks

The focused matrix covers six native platforms and two Linux WebAssembly hosts.
Every complete log was audited. All 24 native binaries have the expected
architecture, output, generated C and disassembly. ARC excludes collector routines;
tracing controls retain marking. The 64-round fixture verifies normal delivery,
aliases, nested queues, failure, blocked sends and cancellation. Queue counts return
to zero; deliberately omitted releases fail with exit 198.

Both WebAssembly hosts pass WASI/browser-loader execution under Node, with JSPI
and Asyncify at O1/O2. All 64 modules, saved C and successful-run symbol listings
were inspected. Physical-allocation/count-table teardown passes; omitted scheduler
or queue cleanup fails with exit 244. This is not an actual-browser test, speed
benchmark, retain/release count or total-process memory bound.

Local receipts and scripts: `/private/tmp/fwp-data-queue-matrix.json`,
`fwp-audit-data-queue-matrix.py`, `fwp-data-queue-evidence.py`,
`fwp-data-queue-wasi-evidence.py` and `fwp-data-queue-report.py`.
Inspected files and download digests are in `/private/tmp/fwp-data-queue-evidence`;
verified ZIP containers were removed to save space. The report retains artifact
IDs and digests for recovery. The accepted PR #183 macOS compiler also checked
raw interpretation of the fixture and the documentation example. Full builds and
native execution ran on GitHub, not locally.

## Local resources and next investigations

Use `python3 scripts/local-guard.py COMMAND...` for serial local checks. Preserve
64 GiB free disk, target data below 2 GiB, sampled workload RSS below 1 GiB and
the 180-second deadline. Last measured free space was 64.35 GiB. Do not raise limits.
The main handoff records verified cache cleanup, including 388 MiB of byte-identical
older inputs whose canonical copies remain. Current inspected binaries are retained.

The previous full-CI timing review is `/private/tmp/fwp-183-test-duration-review.json`.
Repeated REST server compilation is a possible cycle-time investigation, not a
measured improvement. Research notes are `/private/tmp/fwp-184-next-ownership-notes.md`;
its candidate data-queue scope is now implemented, not a task to repeat. Select the
next ownership gap from maintained programs and explicit producer contracts.

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
