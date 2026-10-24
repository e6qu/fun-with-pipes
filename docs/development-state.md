# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** finish PR #205 at `51c295e02a8037f985fe9f662b8e1000fcd97798`; preserve its final
head while production `40037426686` and docs `40037426647` complete. Seven of ten
gates passed at the last audit. Both macOS architectures passed 2,346 saved binary
outcomes. Linux AMD64 passed its full log audit; its binary inspection is next.
Use the primary checkout's handoff and `/private/tmp/fwp-float-delivery-*` receipts
for exact acceptance progress. Merge only after all ten gates and 7,158 inspections.

## Next grouped delivery

This branch adds static numeric literal arrays, direct list-style array display,
JSON fusion, String display-copy removal and flat array iterator state. See
[the protocol](measurements/array-text.md) for examples, restrictions and budgets.
No new performance or allocation claim is accepted until the focused native jobs,
actual binary review and final production delivery pass.

Preparation `41f6438cf6fb04137aa8b97a05deb460df4702e3`, native run `40045988997`,
exposed a type-loss bug in the new iterator state: reconstructing an array/index
record before projecting a field lost the record's type. ARC rejected it; tracing
C generation panicked. The repair reads the typed state fields directly. Array
checks now collect compiler failures across configurations instead of stopping at
the first one. Existing allocation and iterator cases cover the regression.

A local reproduction uses the actual IR declarations, type functions and old/new
state projections. It reproduces both unknown old field types and verifies the
repaired array, index, accumulator, two counters and String capture (1.40s).
Its first two diagnostic-harness attempts had Rust lifetime errors; those were
fixed in the harness. This bounded check does not replace compilation/native CI.
Receipt: `/private/tmp/fwp-iterator-state-type-check.json`.

All six complete logs are audited in `/private/tmp/fwp-array-cost-repair-audit.json`.
Each host has the same four failures in two targets; the other thirteen targets
pass. Both output measurement logs and their controls also pass, recorded in
`fwp-array-cost-output-audit.json`; binary inspection remains outstanding. Earlier failure audits:
`fwp-array-preparation-audit.json`, `fwp-array-repair-audit.json`,
`fwp-array-borrow-repair-audit.json`. Keep their unique archives and logs.
The prior compiler's output-script repairs passed eighteen local Clang controls;
GCC and the new transformations remain native CI responsibilities.

Output measurement `40045991255` tests the same published source. Its fixed
protocol uses six inputs, 48 samples, four warmups and 2% identical-copy checks.
Report full output and checksum separately against C/Rust, including startup,
actual allocation/live storage, static data and code/stack costs. Static input
initialization remains once per process inside total timing. Predicted largest
counts (200 full / 199 checksum) are not accepted measurements. Do not infer a
speed improvement from earlier runs on different hardware.

Prepared inspectors in `/private/tmp`:

- `fwp-inspect-array-preparation.py`: 168 outcomes per native host.
- `fwp-review-array-layout.py`: 24 paired O2 code/layout reviews per host;
  manually interpret prologues for stack cost.
- `fwp-inspect-array-output.py`: 169 files per Linux host, including coordinate
  omission and between-solve lifetime controls.

Keep one PR active. After #205 merges, bundle these changes, every verified repair
and readable results in the next substantial PR. Full builds and benchmarks run
on GitHub; focused local checks use the guard without changing its limits.
All seven [plan](../PLAN.md) areas remain open; JIT is excluded.

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
