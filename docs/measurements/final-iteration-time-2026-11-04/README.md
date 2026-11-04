# Final iteration values: runtime and memory

For the 129-coordinate, 199-update history-form workload, peak managed storage
falls from **838,688 to 19,360 bytes (97.7% less)** in all four sessions. Runtime
improves **5.1–5.9%**. Each solve saves 400 allocation requests, 11,192 requested
bytes and 399 retains. Raw derivative-buffer storage is unchanged.

**Six timing limits remain open:** five larger-case gains miss 5%, and AMD64
session 2's one-update history case is 2.79% slower, exceeding its 2% limit.
Retain the verified reductions under the accepted policy without calling these
misses passes. No completed timing session was repeated.

## What is compared

- **Source:** `bb5433b688c26c60f0b2561a59420deb0f0e95ed`, tag
  `roadmap/final-iteration-measurement-2026-11-04`. The reference restores
  `last = reverse | head` and disables only unused iteration-history removal.
  Both compilers contain count-validation, cleanup and earlier ownership repairs.
- **Work:** complete Rosenbrock gradient-descent solves, starting with alternating
  −1.2/1.0 coordinates and subtracting 0.001 times each automatic derivative per
  update. [The workload explanation](../descent-costs.md#what-the-programs-compute)
  introduces the function and derivatives.
- **Current source:** an explicit loop keeps the latest coordinate vector.
  **History source:** `iterate count descend | last` requests intermediate values,
  then returns the last one. With 199 updates, the reference builds 200 states
  and a reverse copy. The candidate keeps only the current state. Both print the
  same final vector; “history” labels the source form, not candidate storage.
- **Repetitions:** 32,768 / 512 / 32 / 4 / 32 / 8 solves per process for the six
  coordinate/update pairs below. Two warmup rounds precede 98 balanced measured
  rounds; each sample sums seven fresh process runs.
- **Timer:** process launch, solves, formatting/output and cleanup. Compilation,
  instrumentation and evidence checks are separate. Zero updates still construct
  and print the initial vector; they do not isolate startup.
- **Hosts/settings:** two native sessions each on four-vCPU Neoverse N2 ARM64 and
  EPYC 7763 AMD64; GCC 13.3.0 / 15.2.0, Rust 1.99.1. Generated C uses
  `-O2 -std=gnu11 -fno-fast-math -ffp-contract=off -UFWP_NO_REUSE -fstack-usage -w`,
  with `-march=armv8-a` / `-march=x86-64` respectively and `-lm -lpthread -ldl`.
  Generation sets `FWP_LTO=0`, `FWP_AD_WORKSPACE=1`, `FWP_PACKED_ARRAYS=1`,
  `FWP_STACK=1` and `FWP_ARRAY_FUSION=1` on both sides.
  Commands and reference sources are retained.
  [The contract](../final-iteration-storage.md) defines every acceptance limit.

## Elapsed time

Ratios divide candidate by reference: 0.95 means 5% less time; 1.01 means 1% more.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 1.00046 | 0.99989 | 1.00095 | 1.00632 |
| 3 / 0 | history | 0.96540 | 0.96706 | 0.97294 | 0.96969 |
| 3 / 1 | current | 0.99908 | 0.99858 | 0.99979 | 1.00379 |
| 3 / 1 | history | 0.99602 | 0.99562 | 1.01625 | 1.02790 |
| 3 / 199 | current | 1.00140 | 1.00239 | 0.99244 | 0.99637 |
| 3 / 199 | history | 0.95598 | 0.96096 | 0.93370 | 0.94980 |
| 3 / 1999 | current | 1.00169 | 0.99910 | 0.98384 | 0.98771 |
| 3 / 1999 | history | 0.93271 | 0.92921 | 0.90950 | 0.91278 |
| 33 / 199 | current | 1.00066 | 1.00042 | 1.00104 | 0.99974 |
| 33 / 199 | history | 0.95151 | 0.95121 | 0.95133 | 0.94372 |
| 129 / 199 | current | 1.00014 | 1.00039 | 0.99846 | 1.00717 |
| 129 / 199 | history | 0.94879 | 0.94794 | 0.94133 | 0.94412 |

Missed 5% gains: 3/199 history in both ARM64 sessions; 33/199 history in both
ARM64 sessions and AMD64 session 1. AMD64 session 2's 3/1 history ratio exceeds
1.02. All identical-copy checks and other runtime limits pass.
[Exact failed limits](verified-outcomes.json) retain every value. These results
alone do not identify the small-case regression's cause; further diagnosis must
use the saved source/sample evidence before selecting another change.

## Allocation traffic and live memory

Net savings per history-form solve agree across all four sessions and both
workspace settings. Current-form counts are unchanged.

| Coordinates / updates | Removed requests | Fewer requested bytes | Fewer retains |
|---|---:|---:|---:|
| 3 / 0 | 2 | 48 | 1 |
| 3 / 1 | 4 | 104 | 3 |
| 3 / 199 | 400 | 11,192 | 399 |
| 3 / 1999 | 4,000 | 111,992 | 3,999 |
| 33 / 199 | 400 | 11,192 | 399 |
| 129 / 199 | 400 | 11,192 | 399 |

These are complete-program observations, including surrounding generated code.
The [isolated scalar ownership probe](../final-iteration-storage-2026-11-03/README.md#verified-allocation-counts)
returns an option to its caller and has its own measured totals; do not substitute
its allocation formula for this workload's net savings.

For **one process running eight 129/199 solves**, including driver and output:

| Cost | Current reference → candidate | History reference → candidate |
|---|---:|---:|
| Managed allocation requests | 635,354 → 635,354 | 638,562 → 635,362 |
| Requested bytes | 24,937,632 → 24,937,632 | 25,027,296 → 24,937,760 |
| Retain operations | 7,968 → 7,968 | 11,168 → 7,976 |
| Peak managed bytes | 19,360 → 19,360 | 838,688 → 19,360 |
| Final managed bytes | 0 → 0 | 0 → 0 |

Raw derivative-buffer peaks remain 33,904 bytes; final raw storage is zero.
[All 48 count comparisons](verified-memory-counts.json) reconcile with workspace
reuse enabled and disabled. Allocation traffic counts requests over time; peak
managed bytes count simultaneously live fwp storage. Neither is process RSS.

GNU time separately observes peak resident process memory, including libraries,
runtime and output. These are individual observations, not repeated RSS timings:

| Session | Current reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,892 → 1,956 | 2,724 → 1,896 |
| aarch64-2 | 1,956 → 1,880 | 2,728 → 1,896 |
| x86_64-1 | 2,416 → 2,180 | 3,012 → 2,308 |
| x86_64-2 | 2,112 → 2,180 | 3,012 → 2,244 |

[Raw profiles and RSS](largest-process-memory.json.gz) retain their separate scopes.
Do not add managed/raw peaks to RSS. The largest compiler-reported frame does not
increase. Native text changes range from −528 to +1,120 bytes.
[Code and frame records](footprints.json) report these costs separately from speed;
a single frame size is not the total active call stack.

## Compiler cost and C/Rust context

[Compiler measurements](../final-iteration-analysis-2026-11-04/README.md) pass nine
of ten timing cases. AMD64 field-owner transfer is inconclusive because identical
copies differ by 2.043%, above 2%. All observed memory ratios meet the 5% limit.

- ARM64, 129/199 current: fwp takes 19.39–19.49 times C’s elapsed time and 19.14–19.17 times Rust’s.
- AMD64, 129/199 current: fwp takes 24.73–26.26 times C’s elapsed time and 23.07–24.90 times Rust’s.

C/Rust use manually derived gradients, different storage and formatting; they do
not record and reverse an automatic-differentiation tape. These ratios compare
algorithms and implementations, not isolated language or ARC overhead. The paired
fwp comparison holds those choices fixed. This batch does not rerun Swift;
[Swift comparisons](../swift-allocations.md) have their own workloads and limits.

## Retained evidence

| Measurement run | Sessions | Passing raw audit | Reports and complete logs |
|---|---|---|---|
| 41729376533 | aarch64-1, aarch64-2 | [41732080777](https://github.com/e6qu/fun-with-pipes/actions/runs/41732080777) | [Reports](arm-audit.zip), [identities](arm-audit-artifacts.json), [job](arm-audit-job.json), [log](arm-audit-job.log.gz) |
| 41730462251 | x86_64-1, x86_64-2 | [41733338891](https://github.com/e6qu/fun-with-pipes/actions/runs/41733338891) | [Reports](amd-audit.zip), [identities](amd-audit-artifacts.json), [job](amd-audit-job.json), [log](amd-audit-job.log.gz) |

All four full logs, 5,336 raw-file records, native image/source/reference identities,
commands, counts and recalculated limits reconcile. Measurement jobs fail their
final timing-acceptance assertions; the raw audits pass.

Two initial AMD64 hosts received Xeon 6975P-C instead of the required EPYC 7763.
[First rejection](host-rejections/41729376533/session-1.json) and
[second rejection](host-rejections/41729376533/session-2.json) retain complete logs,
host artifacts and proof that no build or timing started. Only those untimed
sessions were replaced. Older timing goals retain their original references.
