# Direct array calls with numeric captures

Calling a known callback directly removes per-element function dispatch. Both
ARM64 sessions pass all frozen limits: **84.5–84.9% less construction time** and
**81.2–81.6% less total time** than the same compiler with this selection rule
disabled. Allocation and managed-storage costs are unchanged.

AMD64 does **not** pass the combined timing goal. Both sessions meet construction
and total-time goals, but consumption is slower and some identical-copy controls
fail. Keep those limits open; retain the verified call reduction and ARM64 gains.

## What is compared

Build an array of 65,537 or 262,145 values. Element `index`, for round 0 through 7,
is `(((index + round) % 19) - 9) / 4.0`. Then multiply each element by 3, add 1,
sum in order from `-0.0` and release the array.

| Implementation | Construction | Consumption |
|---|---|---|
| Candidate fwp | Compiled `array.generate`; direct known callback | Compiled map/map/fold and release |
| Reference fwp | Same source/compiler, with only scalar-capture selection disabled | Same source reduction and release |
| C | `malloc` and direct stores | Ordered loop and `free` |
| Rust | Collected `Vec<f64>` | Ordered loop and destruction |

Both fwp builds preserve checked integer arithmetic and cleanup. C/Rust run the
same bounded inputs, but their construction code and runtime differ; this is not
an equal-instruction comparison. Independent byte-identical copies of both fwp
executables check timing variation. The composed, allocation-free fwp program is
covered by [safety checks](../scalar-array-safety-2026-11-02/README.md), not timed
as though it materialized an array.

[The frozen protocol](../array-construction-costs.md#selected-next-change-known-scalar-captures)
fixes two sessions per architecture, two warmup and 18 measured rounds, four fresh
processes per role/round, and five samples of eight calculations per process.
Hosts: Neoverse N2/GCC 13.3 and EPYC 7763/GCC 15.2, four CPUs, Rust 1.99.1.
Generated C and C peers use O2, baseline architecture, contraction off and no LTO;
the Rust peer uses O2. Both fwp compilers use Rust O1 with assertions.

- **Construction:** allocation and filling, ending after a materialization barrier.
- **Consumption:** map/map/fold and array release.
- **Total:** construction, consumption, checksum and surrounding loop work.
- Startup, printing and shutdown are outside these timers. Allocation profiles,
  RSS observations and binary inspection are separate runs.

## ARM64 elapsed time

Microseconds per array from session 1: divide each median round total by 160 arrays.
These are ordinary timings, without allocation counters or extra phase clocks.

| Elements | Implementation | Construction µs | Consumption µs | Total µs |
|---:|---|---:|---:|---:|
| 65,537 | Candidate fwp | 144.92 | 39.41 | 184.35 |
| 65,537 | Reference fwp | 956.94 | 41.13 | 998.12 |
| 65,537 | C | 87.58 | 40.67 | 128.46 |
| 65,537 | Rust | 57.62 | 40.94 | 98.56 |
| 262,145 | Candidate fwp | 596.09 | 158.07 | 754.41 |
| 262,145 | Reference fwp | 3,851.65 | 168.41 | 4,019.87 |
| 262,145 | C | 355.38 | 161.87 | 517.51 |
| 262,145 | Rust | 232.04 | 164.98 | 397.27 |

Across both sessions, candidate construction still takes **1.65–1.68 times C**
and **2.52–2.57 times Rust**. Total time is **1.44–1.46 times C** and
**1.87–1.90 times Rust**. This change narrows the gap; it does not establish parity.
Every independent-copy limit passes; the largest mismatch is 1.32% against 2%.

## AMD64 failed limits

Both sessions finish exact-output, allocation and cleanup checks. The timing
reports retain these failures against the unchanged limits:

| Session | Failed copy controls | Consumption versus reference |
|---|---|---|
| 1 | Small-array consumption: 4.50% mismatch | 14.99% slower small; 4.93% slower large |
| 2 | Small-array construction/consumption/total: 7.25% / 5.64% / 6.61% mismatch | 11.51% slower small; 5.23% slower large |

Copy variation may be at most 2%; consumption may be at most 2% slower. The
large-array copy controls pass in both sessions, so the large consumption
regression cannot be dismissed by the failed small-array controls.

The [generated-source difference](amd64-generated-change.diff) changes the
constructor and adds its direct-call loop; consumption C is unchanged. That is a
source-level observation, not a diagnosis of the elapsed-time difference. Do not
infer an unsafe runtime operation or add speculative workarounds. Diagnose this
cost separately while preserving the overall gains and every original limit.

## Memory, code and stack

- Candidate and reference allocate once per materialized array: `8 × count + 8`
  bytes, including an eight-byte fwp header. C/Rust request `8 × count` bytes.
- Both fwp builds perform zero effective retains/non-final releases and one final
  release check per array. Peak managed charge is 524,304 / 2,097,168 bytes;
  final live charge is zero. The candidate does not reduce those storage costs.
- Both have allocator chunk high-water marks of 589,824 / 2,162,688 bytes and
  reserve 68,761,485,312 virtual bytes. Reserved address space is not physical RAM.
- Separate ARM64 session-1 candidate/reference RSS observations are 2.31/2.17 MiB
  for the smaller array and 3.81/3.75 MiB for the larger one. AMD64 session-2
  observations are 2.59/2.59 and 4.21/4.15 MiB. These include process/runtime costs;
  neither a single RSS difference nor requested bytes proves total memory savings.
- Candidate/reference `.text` sizes are 60,732/60,828 bytes for small ARM64,
  60,796/60,828 for large ARM64, and 66,498/66,626 for AMD64. Different runtimes
  make whole-program C/Rust size a separate comparison, not a speed explanation.
- GCC reports candidate/reference `main` frames of 288/320 bytes for small ARM64
  and 272/320 for large ARM64 (`static`); AMD64 is 288/320 (`dynamic,bounded`).
  These are individual-frame estimates, not maximum call-stack measurements.

## Evidence and next work

Source `f8a558daa42fc07930f7a93870b6dcbcf2580bb3` is retained as
`roadmap/scalar-array-timing-2026-11-02`. The reference build changes only the
recorded selection clause, and saves its patch, compiler and source identities.
[Focused safety](../scalar-array-safety-2026-11-02/README.md) passed before timing.

[Index](index.json) records sessions, original artifacts, reports and full logs.
Raw-file audits reconstruct both programs, flags, every sample, cleanup control,
binary identity and failed limit. Compact reports retain all samples; manifests
retain hashes for every archived file. Original archives also contain generated
C, both compilers and the measured executables. [Three rejected hosts](rejected-hosts.json)
stopped before building; completed timings were never rerun for a pass.

Keep the AMD64 consumption/noise goals open. Full final-head production checks and
documentation still gate delivery of the compiler change.
