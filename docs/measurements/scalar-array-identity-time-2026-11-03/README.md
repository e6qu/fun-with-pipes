# Runtime cost of removing identity array copies

The change removes **one array allocation per update** in all four sessions.
A 129-coordinate, 199-update solve requests **206,960 fewer bytes**. Automatic reference-counting
(ARC) operations, peak managed storage and raw derivative storage are unchanged in these programs.
For the largest current-only process, this removes about 0.25% of allocation
requests and 6.2% of requested bytes. Most allocation work remains.

**The 5% speed goal is not met:** all 32 required gains are missed. Keep the
verified allocation reduction under the accepted policy, with speed goals open.
No completed timing session was repeated for a better result.

## What is compared

- **Compilers:** frozen source `beddd406153f1976fed00847292207bff9053e22`,
  tag `roadmap/scalar-array-identity-measurement-2026-11-03`. The reference
  disables only F64 identity array-map removal. Both include the same scalar
  bit-preservation repair and all earlier optimizations.
- **Work:** complete Rosenbrock gradient-descent solves from alternating
  −1.2/1.0 coordinates, with step size 0.001 and automatic derivatives.
  **Current** keeps only the latest vector. **History** builds `iterate count
  descend`, retains intermediate vectors, then takes `last`. For 199 updates,
  history builds 200 states; both forms print the same final vector.
- **Repetitions:** each process repeats 32,768 / 512 / 32 / 4 / 32 / 8 solves
  for the six coordinate/update pairs below. Two warmup rounds precede 98
  balanced measured rounds; each sample sums seven fresh process runs.
- **Timer:** process launch, solves, formatting/output and cleanup. Compilation,
  allocation instrumentation, output checking and evidence writes are separate.
  [Compiler time and memory](../scalar-array-identity-analysis-2026-11-03/README.md)
  pass their separate limits.
- **Hosts:** two native sessions each on four-vCPU Neoverse N2 ARM64 and
  EPYC 7763 AMD64; GCC 13.3.0 / 15.2.0 and Rust 1.99.1. Generated C uses O2
  with the frozen architecture, arithmetic and workspace settings. All commands
  are retained; [the contract](../scalar-array-identities.md) defines the limits.

Rosenbrock's function sums `100 * (y - x*x)^2 + (1 - x)^2` over adjacent
coordinates `x, y`. A derivative describes how that sum changes with one
coordinate. Each update subtracts `0.001 * derivative` from every coordinate.
Zero updates still construct and print the initial vector; they do not measure
startup alone. [The workload explanation](../descent-costs.md#what-the-programs-compute)
shows the different implementations.

## Elapsed time

Ratios divide candidate by reference: 0.95 means 5% less time; 1.01 means 1% more.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 0.99691 | 0.99752 | 1.00963 | 1.00637 |
| 3 / 0 | history | 1.00163 | 1.00189 | 1.00180 | 1.00617 |
| 3 / 1 | current | 0.99781 | 0.99824 | 1.00143 | 0.99027 |
| 3 / 1 | history | 0.99613 | 0.99640 | 1.00639 | 1.00235 |
| 3 / 199 | current | 0.97779 | 0.98005 | 0.98377 | 0.98024 |
| 3 / 199 | history | 0.98681 | 0.97702 | 0.99482 | 0.99060 |
| 3 / 1999 | current | 0.98246 | 0.97634 | 0.98202 | 0.98217 |
| 3 / 1999 | history | 0.97986 | 0.97598 | 0.97496 | 0.99243 |
| 33 / 199 | current | 0.99808 | 0.99796 | 0.98481 | 0.99260 |
| 33 / 199 | history | 1.00199 | 1.00191 | 0.99627 | 0.98862 |
| 129 / 199 | current | 0.99660 | 0.99656 | 0.99709 | 0.99806 |
| 129 / 199 | history | 0.99739 | 0.99774 | 0.99267 | 0.98776 |

Every session misses 5% on both forms of 3/199, 3/1999, 33/199 and 129/199.
All identical-copy noise checks and the separate 2% zero/one-update regression
limits pass. [All failed limits](verified-outcomes.json) retain exact values.

## Allocation traffic and live memory

The exact reductions per solve agree across all four sessions and both forms:

| Coordinates / updates | Removed requests | Fewer requested bytes |
|---|---:|---:|
| 3 / 0 | 0 | 0 |
| 3 / 1 | 1 | 32 |
| 3 / 199 | 199 | 6,368 |
| 3 / 1999 | 1,999 | 63,968 |
| 33 / 199 | 199 | 54,128 |
| 129 / 199 | 199 | 206,960 |

For **one process running eight 129/199 solves**, including its driver and output:

| Cost | Current reference → candidate | History reference → candidate |
|---|---:|---:|
| Managed allocation requests | 636,946 → 635,354 | 640,154 → 638,562 |
| Requested bytes | 26,593,312 → 24,937,632 | 26,682,976 → 25,027,296 |
| Retain operations | 7,968 → 7,968 | 11,168 → 11,168 |
| Peak managed bytes | 19,360 → 19,360 | 838,688 → 838,688 |
| Final managed bytes | 0 → 0 | 0 → 0 |

Raw derivative-buffer peaks remain 33,904 bytes; final raw storage is zero.
[All 48 count comparisons](verified-memory-counts.json) also reconcile with
workspace reuse disabled. Traffic counts allocations over time; peak managed
bytes count simultaneously live fwp-owned objects. Neither is process RSS.

GNU time separately observes process peak resident memory, including libraries,
runtime and output. These are individual observations, not repeated RSS timings:

| Session | Current reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,888 → 1,892 | 2,728 → 2,664 |
| aarch64-2 | 1,892 → 1,764 | 2,664 → 2,664 |
| x86_64-1 | 2,180 → 2,180 | 3,012 → 3,076 |
| x86_64-2 | 2,416 → 2,112 | 3,204 → 3,076 |

RSS varies in both directions in these observations.
[Raw profiles and RSS](largest-process-memory.json.gz) preserve the distinction.
Do not add managed/raw peaks to RSS. The separate
[slice probe](../scalar-array-identities-2026-11-03/README.md#result-lifetime-and-allocation-traffic)
also shows a cost absent from this gradient workload: returning a small view
can keep a larger backing array alive.

The largest compiler-reported frame does not grow, meeting the 128-byte limit.
Native text sections shrink by 96–4,208 bytes. [All code/frame records](footprints.json) keep these costs separate from
speed; individual frame sizes do not measure total live call-stack use.

## C/Rust context

- ARM64, 129/199 current: fwp takes 18.05–19.04 times C’s
  elapsed time and 17.93–18.70 times Rust’s.
- AMD64, 129/199 current: fwp takes 23.84–25.76 times C’s
  elapsed time and 22.55–23.96 times Rust’s.

C and Rust use manually derived gradients, different storage and formatting.
They do not record and reverse an automatic-differentiation tape. These ratios
compare implementations and algorithms; they do not isolate language or ARC
overhead. The paired fwp comparison holds those choices fixed. This batch does
not rerun Swift; [existing Swift comparisons](../swift-allocations.md) have their
own workloads and limits.

## Evidence

| Measurement run | Sessions | Passing raw audit | Retained reports and complete logs |
|---|---|---|---|
| 41678576958 | aarch64-1, aarch64-2 | [41682284697](https://github.com/e6qu/fun-with-pipes/actions/runs/41682284697) | [Reports](arm-audit.zip), [identities](arm-audit-artifacts.json), [job](arm-audit-job.json), [log](arm-audit-job.log.gz) |
| 41688990925 | x86_64-1 | [41692822388](https://github.com/e6qu/fun-with-pipes/actions/runs/41692822388) | [Reports](amd1-audit.zip), [identities](amd1-audit-artifacts.json), [job](amd1-audit-job.json), [log](amd1-audit-job.log.gz) |
| 41679275708 | x86_64-2 | [41684684676](https://github.com/e6qu/fun-with-pipes/actions/runs/41684684676) | [Reports](amd2-audit.zip), [identities](amd2-audit-artifacts.json), [job](amd2-audit-job.json), [log](amd2-audit-job.log.gz) |

All four original job logs, 5,336 raw-file records, commands, source/reference
identities, native images, counts and recalculated limits reconcile. Measurement
jobs fail only their final speed-acceptance assertions; the raw audits pass.

[6 rejected hosts](rejected-hosts/index.json) stopped before building or timing;
their CPU models differed from the required EPYC 7763. Full logs, qualification
records and artifact digests are retained. They are not performance observations.

[Remaining storage candidates](../remaining-gradient-storage.md) need their own
selection, lifetime proof and measurements. These savings do not close older
timing goals or establish the benefit of another transformation.
