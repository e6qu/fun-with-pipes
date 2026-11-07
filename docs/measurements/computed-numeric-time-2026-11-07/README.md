# Local automatic derivatives after removing temporary input records

Long solves with passing copy controls take **48–65% less elapsed time** than
ordinary reverse AD. The largest case takes **56–59% less time** in all four
sessions. The compiler removes all 407,552 extra temporary-record allocations
identified in the [first prototype](../local-derivative-time-2026-11-07/README.md).

A copy control runs byte-identical executables under two names; a difference
above 2% marks that timing comparison uncertain.

**Overall timing acceptance remains open.** Three sessions pass every limit.
AMD2's 3-coordinate/199-update copy control differs by 2.08%, above the frozen
2% limit. Its speed ratio is recorded but inconclusive. No session was repeated.
The [new public interface remains experimental](../local-derivatives.md#decision).

Source `8b24da94a4e54c023f5e4b2341896d97dff092b9`,
[producer 42417868388](https://github.com/e6qu/fun-with-pipes/actions/runs/42417868388).
Both ARM sessions use Neoverse-N2 and GCC 13.3; both AMD sessions use EPYC 7763
and GCC 15.2. All hosts expose four processors. Rust is 1.99.1. C uses `-O2`,
no fast math, no floating-point contraction, no LTO, and `armv8-a`/`x86-64`.

## What is compared

- **Local forward AD:** evaluate each neighboring pair with `Dual` numbers,
  which carry values and derivatives, then write coordinate updates into an array.
  No derivative formula is handwritten and no global tape is recorded.
- **Ordinary reverse AD:** record the objective's operations, walk backward to
  calculate derivatives, then update coordinates. Both fwp forms use this compiler.
- **Handwritten fwp arrays/lists, C and Rust:** explicit analytic derivatives.
  C/Rust reuse mutable buffers; fwp retains immutable value semantics. Arithmetic,
  allocation and formatting work differ, so ratios do not isolate language overhead.

The [frozen protocol](../local-derivatives.md#frozen-measurement) defines all six
inputs. Each session has 98 balanced rounds and two warmups, with seven processes
per label per round. Timing includes launch, repeated solves, full output and exit;
compilation and storage observers are separate. Each output matches its own
unoptimized interpreter exactly and the analytic oracle within `1e-10`.

## Elapsed time

Local forward AD time divided by ordinary reverse AD time; 0.43 means about
57% less elapsed time. Long-case acceptance requires at most 0.80, while
zero/one-update cases allow at most 1.02.

| Coordinates / updates | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| 3 / 0 | 1.0104 | 1.0110 | 1.0005 | 0.9920 |
| 3 / 1 | 0.9785 | 0.9765 | 0.9687 | 0.9598 |
| 3 / 199 | 0.5074 | 0.5201 | 0.4796 | 0.4756* |
| 3 / 1999 | 0.4208 | 0.4189 | 0.3542 | 0.3615 |
| 33 / 199 | 0.4393 | 0.4431 | 0.4469 | 0.4440 |
| 129 / 199 | 0.4326 | 0.4383 | 0.4175 | 0.4149 |

`*` Inconclusive because identical copies differ by 2.08%.

Largest case, **milliseconds per solve**, amortized from each round's seven
processes × eight solves. These are not standalone-startup measurements:

| Session | Local AD | Reverse AD | Handwritten fwp arrays | C | Rust |
|---|---:|---:|---:|---:|---:|
| ARM1 | 0.910 | 2.103 | 0.847 | 0.215 | 0.220 |
| ARM2 | 0.923 | 2.105 | 0.853 | 0.216 | 0.221 |
| AMD1 | 1.081 | 2.590 | 1.032 | 0.200 | 0.216 |
| AMD2 | 1.068 | 2.575 | 1.041 | 0.187 | 0.203 |

Local AD is 2.6–8.1% slower than handwritten fwp arrays here. It still takes
4.2–5.7 times C's elapsed time. Much of the remaining gap is shared by both fwp
array programs; these results do not identify its cause or establish C parity.

## Allocation and live memory

One largest-case process performs eight solves. Counts agree across all hosts:

| Program | Managed requests | Managed bytes requested | Peak managed bytes | Peak raw tape bytes |
|---|---:|---:|---:|---:|
| Original local prototype | 409,297 | 11,470,416 | 8,736 | 0 |
| Repaired local AD | 1,745 | 1,689,168 | 8,736 | 0 |
| Handwritten fwp arrays | 1,745 | 1,689,152 | 8,736 | 0 |
| Ordinary reverse AD | 4,361 | 5,005,064 | 11,584 | 33,888 |

All have eight retains and zero final live managed storage. The repaired local
form matches the handwritten array request/retain count on **all six cases**,
with no larger managed peak and no tape activity. Its largest process requests
16 more bytes than the handwritten array form; it is not allocation-free.

Requested bytes measure traffic, not simultaneous live memory. Managed and raw
peaks are separate observations and must not be added as a measured total.
Largest-case process RSS is 1,445,888–1,794,048 bytes for local AD and
1,806,336–2,228,224 for reverse AD; these single RSS observations are separate
from repeated timing samples and include more than fwp-managed storage.

The saved local-edge C function takes **four `double` arguments**, replacing two
heap `Dual` inputs. The counter difference is exactly
`2 × 128 edges × 199 updates × 8 solves = 407,552` requests. Arithmetic and input
evaluation order are unchanged; no language syntax or calling semantics changed.

## Code and stack costs

Largest-case local AD has 29,788 instruction bytes on ARM and 31,794 on AMD,
versus reverse AD's 42,700 and 44,658. Executables are 76,112/62,440 bytes versus
143,360/88,576 bytes. Performance, rather than file size, remains the objective.

The largest reported C frame is 2,240 bytes on ARM and 2,192 on AMD; reverse AD
uses 2,256/2,192. These are individual compiler-reported frames, not whole-thread
peak stack measurements. Rust frame sizes were not collected.

## Complete evidence

[costs.csv](costs.csv) contains all 144 peer rows, amortized times, ratios,
allocation counters, RSS, instruction/executable bytes and C frames.
[index.json](index.json) identifies the original reports, artifact digests and
full job logs. All four observation audits pass, including exact allocation
parity. The sole runtime job failure is its declared copy-control limit.
[Compiler costs](../computed-numeric-analysis-2026-11-07/README.md) retain two
additional inconclusive copy controls; all 5% compiler time/RSS limits pass.

[Complete observation archives](complete/README.md) retain every original process
record and native image after a separate passing audit; no timings were repeated.
