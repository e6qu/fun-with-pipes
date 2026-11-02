# Current materialized array construction

The source-built fwp array is much slower to construct than the same array built
by the C driver. Two qualified ARM64 sessions reproduce the difference. Separate
instrumented runs place almost all source-construction time in filling, which
includes callback dispatch and checked arithmetic. They do not isolate dispatch
from those other operations.

## What runs

For `count` 65,537 or 262,145, construct each element as
`(((index + round) % 19) - 9) / 4.0`, then multiply each element by 3, add 1 and
sum in order from `-0.0`. Release the array after consumption. Each sample repeats
this for rounds 0 through 7; exact result bits must agree.

- **fwp source:** compiled `array.generate` followed by compiled map/map/fold.
- **fwp driver:** C calls the fwp allocator/stores, then the same compiled reduction.
- **C:** `malloc`, direct stores, ordered calculation and `free`.
- **Rust:** collected `Vec<f64>`, ordered calculation and destruction.
- The fully composed fwp program already eliminates its array. It remains a
  separate correctness/storage control, not a timing peer here.

[The frozen protocol](../array-construction-costs.md#next-measurement-materialized-construction-phases)
specifies hosts, flags, sampling and controls. Source: `f05e25f8`; GCC 13.3 on
Neoverse N2 and GCC 15.2 on EPYC 7763, four CPUs, C O2, contraction off and no LTO.
The compiler itself is Rust O1 with assertions; the Rust peer uses O2.

## Qualified ARM64 results

Times below are microseconds per array, using session 1. Divide each median round
total by 160 arrays (four processes × five samples × eight calculations).
The inclusive timer covers construction, consumption, checksum and cleanup;
process startup, printing and shutdown are outside it.

| Elements | Implementation | Construction µs | Consumption µs | Inclusive µs |
|---:|---|---:|---:|---:|
| 65,537 | fwp source | 960.0 | 41.0 | 1,001.0 |
| 65,537 | fwp driver | 133.6 | 39.3 | 173.0 |
| 65,537 | C | 87.7 | 40.6 | 128.3 |
| 65,537 | Rust | 57.5 | 40.9 | 98.5 |
| 262,145 | fwp source | 3,823.4 | 166.1 | 3,989.7 |
| 262,145 | fwp driver | 512.2 | 157.5 | 670.0 |
| 262,145 | C | 354.8 | 161.4 | 516.3 |
| 262,145 | Rust | 232.1 | 164.2 | 396.4 |

Across both sessions, source construction takes **7.16–7.48 times the fwp driver**,
**10.78–10.95 times C** and **16.47–16.70 times Rust**. Inclusive source time is
7.73–7.80 times C and 10.06–10.16 times Rust. Both independent-copy controls pass
for all three timers and both sizes; the largest mismatch is 1.96% against 2%.

In separately instrumented source builds, filling accounts for over 99% of
construction. Allocating/initializing storage takes roughly 3 µs for the smaller
array and 29–31 µs for the larger one. These are diagnostic phase observations:
extra timers and counters can alter code and must not replace ordinary timings.

## Memory, code and stack

- All materialized implementations allocate once per array. C/Rust request exactly
  `8 × count` payload bytes; fwp requests eight additional header bytes.
- Both fwp paths have zero effective retains and non-final releases, one final
  release check per array, and zero final live managed storage. Peak charge is
  524,304 or 2,097,168 bytes. This is not process RSS.
- Separate session-1 source RSS observations are about 2.25/3.68 MiB on ARM64 and
  2.78/4.21 MiB on AMD64. These include the runtime and process overhead.
- Source/driver `.text` sizes are 60,828/60,316 bytes on ARM64 and 66,626/66,114 on
  AMD64. Whole-program Rust/C sizes include different support code; size alone
  does not explain speed.
- GCC reports source/driver `main` frames of 320/352 bytes (`static`) on ARM64 and
  320/368 bytes (`dynamic,bounded`) on AMD64. These are individual function frame
  estimates, not maximum call-stack measurements. Full reports retain every entry.

## AMD64 limits and remaining session

Session 1 completes exact results, storage and missing-release controls. Six
copy limits fail: five for 65,537 elements and driver construction for 262,145.
Mismatches range from 2.11% to 8.94%. Its timings are retained but not accepted as
qualified performance results. Do not rerun this completed session for a pass.
Session 2 is still awaiting the declared CPU; rejected hosts stop before building.

[Index](index.json) links jobs, artifact identities and compressed reports/logs.
The reports retain every warmup and sample; file manifests retain raw file hashes.
`check-array-construction-time.py` audited the original complete archives against
source, compiler flags, exact outputs, cleanup controls and reconstructed totals.
The archives also contain binaries and generated C. [Rejected hosts](rejected-hosts.json)
remain part of the experiment. No production compiler optimization is included yet.
