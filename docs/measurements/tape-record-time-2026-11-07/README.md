# Tape layout: runtime and memory

All 32 long-case comparisons miss the frozen 5% speed target. The complete
archive reader now verifies all four original sessions and preserves every miss.
No timings were repeated. [The contract](../tape-operation-records.md) fixes
sources, inputs, flags and limits; [the overview](../tape-record-results.md)
shows each session's speed range and compiler costs.

## What the numbers measure

The candidate stores each numeric operation in one 24-byte record. The reference
uses the old parent/weight columns. Both use compiler source
`621653b6394f49dc229a2956b6b61476c82c9aac`. The only changed code is tape storage.

Each program solves the same Rosenbrock gradient-update problem. Inputs are
3 coordinates with 0, 1, 199 or 1,999 updates, and 33 or 129 coordinates with
199 updates. Current returns final coordinates; history selects the last value
from successive results. The compiler can remove unused history.

- Timing sums seven fresh processes per program per round, including launch,
  calculation and output collection. There are two warmups and 98 balanced rounds.
- Each process performs a fixed number of solves. Microseconds per solve below
  equal the median round total divided by seven and that repetition count.
  This is amortized process time, not an isolated arithmetic-kernel timer.
- C/Rust peers use handwritten derivatives; fwp uses automatic differentiation.
  Ratios include that algorithmic difference, representation/runtime work and
  process overhead. They do not isolate ARC cost or language overhead.
- RSS is a separate whole-process measurement, including libraries and allocator
  pages. It is not the sum of fwp's live-object and raw-buffer counters.
- Managed allocation counts and raw tape/workspace counts come from separate
  instrumented processes. Each count covers all solves in that process.

## Largest case: 129 coordinates, 199 updates

Each process performs eight solves. Times are microseconds per solve. Ratios
above 1 mean fwp takes longer than the handwritten derivative peer.

| Session / CPU | fwp | Old layout | C | Rust | fwp/C | fwp/Rust |
|---|---:|---:|---:|---:|---:|---:|
| ARM 1 / N2 | 2095.20 | 2158.40 | 207.83 | 213.22 | 10.08 | 9.83 |
| ARM 2 / N2 | 2071.01 | 2136.61 | 195.03 | 195.41 | 10.62 | 10.60 |
| AMD 1 / 7763 | 2581.16 | 2649.22 | 191.60 | 203.79 | 13.47 | 12.67 |
| AMD 2 / 9V74 | 2132.25 | 2175.49 | 157.81 | 177.71 | 13.51 | 12.00 |

Thus this workload still takes roughly 10–13.5 times C's time, despite the small
improvement versus the old fwp layout. These are matched within-session ratios;
the two AMD sessions use different approved CPUs.

Whole-process peak RSS, KiB (1,024 bytes):

| Session | fwp | Old layout | C | Rust |
|---|---:|---:|---:|---:|
| ARM 1 / N2 | 1764 | 1828 | 1376 | 1636 |
| ARM 2 / N2 | 1956 | 1760 | 1368 | 1636 |
| AMD 1 / 7763 | 2176 | 2112 | 1544 | 2156 |
| AMD 2 / 9V74 | 2108 | 2220 | 1544 | 2248 |

RSS moves in both directions. The layout does not establish a process-memory
reduction. [All 48 case/form/session rows](costs.csv) retain absolute times,
ratios, RSS, managed/raw allocation traffic, live peaks and code/stack sizes.

## Allocation and live storage

For the current-result form, these instrumented counts agree across all four
sessions. The reusable workspace is enabled. Raw requests include registry,
operation/parent/weight buffers and adjoints; they are totals per process.

| Coordinates / updates | Solves per process | Raw requests, old → new | Peak raw bytes, old → new | Managed requests (unchanged) | Peak managed bytes (unchanged) |
|---|---:|---:|---:|---:|---:|
| 3 / 0 | 32768 | 0 → 0 | 0 → 0 | 65539 | 1048704 |
| 3 / 1 | 512 | 4 → 3 | 1792 → 1776 | 3587 | 16656 |
| 3 / 199 | 32 | 4 → 3 | 1792 → 1776 | 12899 | 1296 |
| 3 / 1999 | 4 | 4 → 3 | 1792 → 1776 | 16015 | 400 |
| 33 / 199 | 32 | 8 → 5 | 8560 → 8544 | 13889 | 3904 |
| 129 / 199 | 8 | 12 → 7 | 33904 → 33888 | 4361 | 11584 |

Numeric payload remains 24 bytes per operation. Combining the buffers halves
numeric growth requests, but the registry/workspace already reuses them across
updates. The 16-byte raw-peak reduction is bookkeeping, not a payload reduction.
Managed allocation/retention traffic is unchanged. Managed and raw peaks occur
at independently measured times; adding them does not give process RSS.

For 129/199, disabling the workspace changes raw requests from 17,513 to 9,553
for eight solves; it does not change managed counts or arithmetic results.
Both workspace settings finish with zero managed and raw storage. The large
zero-update managed peak reflects a batch of 32,768 solves, not one solve.

The largest reported compiler stack frame is unchanged: 2,256 bytes on ARM64
and 2,192 on AMD64. Instruction bytes decrease by 160–384 and 224–448 respectively;
file sizes are in the CSV. Smaller code does not close the speed target.

## Evidence and audit repair

Producer: [42369288345](https://github.com/e6qu/fun-with-pipes/actions/runs/42369288345).
The [repaired audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42388963241)
verified every original archive, command, sample, output, storage profile,
source/reference transformation, executable/section/stack record and control.
[The index](index.json) retains every artifact identity and all acceptance misses;
[summary metadata](summary-artifact.json) identifies the retained reports and logs.
All four decompressed report hashes and four complete job-log hashes pass local
verification. Original measured-image reproduction remains separate.

The first audit expected `missing-parent-free`; the producer now deliberately
omits releasing the operation buffer (`missing-operation-free`, required exit
232). The reader requires an explicit layout and its exact control set. Ten
focused and thirteen historical tests pass; malformed controls and live storage
are rejected. The repaired audit reads the original data without rerunning it.
