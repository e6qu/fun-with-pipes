# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** finish the array/iteration preparation and its measurement repair,
inspect the native binaries, then publish one substantial PR with the results.
PR #205 is merged at `336692f4329d9f628c05d6a42a7353c1702bdc09`; all ten checks
and 7,158 binary outcomes passed. Its raw commit message is one line, without
body or trailers. Redundant main CI `40048973688` was cancelled. Receipts and
inspection reports remain under `/private/tmp/fwp-float-delivery-*`.

## Current preparation

This branch adds static numeric literal arrays, direct list-style array display,
JSON fusion, String display-copy removal and flat array iterator state. See
[the protocol](measurements/array-text.md) for examples, restrictions and budgets.
Source `dbef97e1a9e843c1ffcfc8806650741782f10487` passes all six native jobs and
complete logs in `40047565887`: every one of the fifteen test targets passes.
The earlier iterator type-loss failure is repaired by projecting typed state
fields directly. Array tests also collect compilation failures across settings.
Actual inspection of all 1,008 focused outcomes and final production CI remain
required. Preserve this passing compiler/runtime code while repairing measurements.

The current output run `40047568819` passes AMD64 but fails ARM64 compiling the
largest checksum input. GCC O2 exceeded the shared 60-second command deadline.
The failed C input is byte-identical to the inspected successful input from
`40045991255` (source `41f6438cf6fb`). This was a compilation timeout before that
input's timing, not an output or lifetime failure. The partial artifact and both
complete logs are retained. Diagnosis: `/private/tmp/fwp-array-timeout-diagnostics`
and `fwp-array-state-output-audit.json`.

The repair separates explicit compilation and execution deadlines: 180 seconds
for CI builds, unchanged 60 seconds for execution. Every build records wall time,
status and diagnostics immediately; timeout handling terminates compiler children.
Four focused controls pass (1.25s), including a real child-process timeout. Local
resource limits are unchanged. See the [measurement protocol](measurements/descent-output-protocol.md).
The compiler/runtime files are unchanged by this repair; publication must verify
that identity before rerunning both measurements.

First measurement run `40045991255` passed both logs and 338 binary inspections.
Largest observed counts: 200 full-output / 199 checksum requests per solve,
zero count increments or retained managed bytes, peak charged bytes 4,352 / 2,560.
CPU models are EPYC 9V45 and Neoverse-N2. The AMD64 3:1 checksum copy control
fails its fixed 2% noise limit and stays inconclusive. Current-source repeats,
static-data/code/stack review and final delivery remain required. Managed memory
excludes static inputs, raw text capacity, runtime metadata and library allocations;
peer buffer counts cover a different scope. No before/after speed or parity claim.

Useful `/private/tmp` receipts and tools:

- `fwp-array-state-repair-{publication,audit}.json`: six native jobs at `dbef97e1`.
- `fwp-array-output-first-results.json`: concise first-run observations; full raw
  reports are in `fwp-array-output-evidence/41f6438cf6fb`.
- `fwp-inspect-array-preparation.py`: inspect 168 outcomes per host.
- `fwp-review-array-layout.py`: save 24 paired O2 layout/code reviews per host;
  manually interpret stack prologues.
- `fwp-inspect-array-output.py`: inspect 169 measurement/control files per Linux
  host. Verify the explicit build deadline and new timing records in repaired runs.

Keep unique failure archives and logs. Prune only inspected duplicate archives
with verified remote originals. Full builds and measurements run on GitHub;
focused local checks use the guard without changing its limits. All seven
[plan](../PLAN.md) areas remain open; JIT is excluded.

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
