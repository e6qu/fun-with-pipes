# Runtime effect of removing temporary callback owners

The largest solve takes **5.2–6.4% less time** with unchanged allocation traffic
and peak managed storage. The complete speed requirement does **not** pass:
smaller solves miss the 5% target, and one AMD64 case fails its noise control.
Keep the verified reductions and leave these timing goals open, following the
user's existing direction. Original limits and failed samples are unchanged.

## Programs and timing

- **Candidate:** `d903126f53545098519a36960c5704eb3fcdc8f0` with complete-field moves
  and numeric callback inputs. **Reference:** the same source with only those
  two transformations disabled. Both keep packed temporary record storage.
- Both minimize Rosenbrock's function from alternating -1.2/1.0 coordinates,
  using the same automatic derivatives and `0.001` step size. **Current** keeps
  only the latest vector; **history** keeps every vector. Each prints the complete
  final vector. [Input formula and count definitions](../derivative-owner-transfers.md#what-is-measured).
- Each sample sums seven fresh processes per role. Each process repeats
  32,768 / 512 / 32 / 4 / 32 / 8 solves for the six table rows, respectively.
  Timing includes process launch, repeated solves, output and teardown; it
  excludes compilation, instrumentation, output checking and evidence writes.
  Startup is amortized, so zero-update time is not a pure startup measurement.
- Two warmup rounds, then 98 balanced rounds; seven roles include candidate and
  reference current/history programs, an identical candidate copy, and C/Rust
  peers. Two independent sessions per architecture. No unchanged reruns.
- Native four-vCPU Linux: Neoverse-N2 with GCC 13.3.0, and EPYC 7763 with GCC
  15.2.0; Rust 1.99.1. Generated C uses `-O2 -std=gnu11 -fno-fast-math
  -ffp-contract=off -UFWP_NO_REUSE -fstack-usage`, with `-march=armv8-a` or
  `-march=x86-64`. Full commands and settings remain in each report.

## Elapsed-time change

Percentages compare candidate with reference. Negative means less time.
Ranges cover both sessions; they are not confidence intervals.

| Coordinates / updates | ARM64 current | ARM64 history | AMD64 current | AMD64 history |
|---|---:|---:|---:|---:|
| 3 / 0 | +0.30% to +0.40% | -0.29% to -0.29% | -2.58% to -1.98% | -0.50% to +0.54% |
| 3 / 1 | -0.11% to +0.07% | -0.09% to -0.07% | -2.36% to -0.90% | -1.33% to +0.22% |
| 3 / 199 | -3.58% to -3.55% | -3.13% to -3.01% | -4.10% to -3.79% | -2.80% to -0.40% |
| 3 / 1999 | -3.99% to -3.60% | -3.21% to -3.13% | -2.99% to -2.37% | -2.41% to -0.68% |
| 33 / 199 | -6.64% to -6.62% | -6.28% to -6.24% | -4.47% to -4.38% | -6.64% to -6.33% |
| 129 / 199 | -6.41% to -6.39% | -6.32% to -6.29% | -5.64% to -5.38% | -5.18% to -5.18% |

Failed requirements:

- Both architectures: 3/199 and 3/1999 miss the required 5% improvement in both
  current and history forms.
- AMD64: 33/199 current also misses 5% (4.38–4.47% less time).
- AMD64: 3/1999 current has **2.12% and 2.21% identical-copy variation** (limit 2%).
  Treat its candidate/reference timing as inconclusive, despite a lower median.
- All remaining copy controls and the 2% regression limits pass. The 129/199
  cases pass 5% on both hosts; ARM64 33/199 and AMD64 33/199 history also pass.

## Memory, code and external peers

[Single-solve counts](../derivative-owner-transfers.md#results-and-source-attribution)
remove 76,416 of 77,411 retains in the largest case, with unchanged allocations,
requested bytes, managed/raw peak storage and zero final storage. The runtime
harness repeats solves and has its own retained input and output work: its
129/199 current profile records 1,254,642 allocations, 43,035,488 requested bytes,
22,208 peak managed bytes and zero final managed bytes per eight-solve process.
Do not compare those totals directly with a single-solve count.

Whole-process RSS is separate. In that repeated current-only case:

| Host | Candidate peak RSS | Reference peak RSS | Instruction bytes, reference → candidate | Largest static frame |
|---|---:|---:|---:|---:|
| ARM64 | 1,892 KiB | 1,896–1,960 KiB | 47,084 → 45,260 | 2,240 bytes, unchanged |
| AMD64 | 2,180–2,308 KiB | 2,120 KiB | 50,354 → 48,274 | 2,208 bytes, unchanged |

RSS includes code, stacks, allocator pages and libraries; it is not just the
managed heap. The AMD64 RSS increase is visible here even though managed-storage
counts do not grow. Every case passes the frozen 128-byte static-frame growth
limit. Static frames are not a bound on the whole call stack.

The C/Rust peers compute derivatives explicitly and reuse two contiguous buffers;
fwp records and reverses derivatives. For 129/199 current, fwp takes **24.2–24.7×
C time and 24.1–24.6× Rust time on ARM64**, and **29.7–30.1× C / 28.2–28.5× Rust
on AMD64**. Inputs, update counts and checked output agree, but differentiation,
allocation, initialization and formatting strategies differ. These ratios show
the remaining workload gap; they do not isolate language overhead. This batch
does not establish parity with C/Rust. [Swift measurements](../swift-allocations.md)
remain a separate comparison.

## Verification and original outcomes

All four sessions pass output, derivative-work, allocation, cleanup and binary
checks. Runner-side audits verify 1,334 measurement files and five reference
files per session, reconstruct the exact source changes and recalculate the
original failures. A separate four-report check validates schedules, qualified
hosts, common source hashes, raw samples and acceptance decisions.

| Evidence | Timing run | Independent audit |
|---|---|---|
| [Original sessions and rejected host](original/index.json) | [41550970017](https://github.com/e6qu/fun-with-pipes/actions/runs/41550970017) | [41553716035](https://github.com/e6qu/fun-with-pipes/actions/runs/41553716035), passes |
| [AMD64 session 2 replacement](replacement/index.json) | [41551538083](https://github.com/e6qu/fun-with-pipes/actions/runs/41551538083) | [41553965234](https://github.com/e6qu/fun-with-pipes/actions/runs/41553965234), passes |

The original AMD64 session 2 received EPYC 9V74 and was rejected before building
or timing. Only that untimed session was replaced. No timed result was discarded.
The indexes link complete job logs, reports, source/image hashes, every original
failure and artifact download identities. Audit logs: [original](original/audit.log.gz),
[replacement](replacement/audit.log.gz). An audit passing means the evidence is
consistent, not that its failed speed targets have passed.

[Compiler-cost results](../numeric-input-analysis-2026-11-03/README.md) pass their
separate 5% time/RSS and 2% copy limits. All nine production jobs and documentation
passed before the [verified #249 merge](../../roadmap-history.md#numeric-callback-owner-transfers-pr-249);
[gate identities and logs](final-gates.json) retain the evidence.
