# Runtime cost of direct scalar array calls

All four original sessions and raw-data audits are complete. The larger 33/199
and 129/199 cases take **4.8–5.2% less time on ARM64** and **5.5–8.1% less on
AMD64**. Allocation, ARC and managed/raw storage counts are unchanged.

The full performance contract is **not met**: 16 required 5% gains are missed,
and one identical-copy comparison exceeds its noise limit. Keep the verified
work reduction under the accepted policy, with those goals open. No completed
timing session was repeated to obtain a pass.

## What is compared

- **Two fwp compilers:** frozen source `e649da78c41dab8fa6f191d7670b1efba79811b0`,
  tag `roadmap/scalar-array-map-measurement-2026-11-03`. The reference disables
  only direct calls to closed scalar array-map callbacks. Both keep all prior
  gradient-array/storage optimizations and run identical programs.
- **Work:** complete Rosenbrock gradient-descent solves, starting from alternating
  −1.2/1.0 coordinates with step size 0.001. Both use automatic derivatives and
  print the final vector. **Current** retains only the latest vector; **history**
  builds `iterate count descend`, retains intermediate vectors, then takes `last`.
  For 199 updates, history builds 200 states; both forms return the same last state.
- **Repetitions:** each process repeats 32,768 / 512 / 32 / 4 / 32 / 8 solves for
  the six coordinate/update pairs below. Two warmup rounds precede 98 balanced
  measured rounds. Each sample sums seven fresh process runs.
- **Timer:** process launch, all solves, formatting/output and cleanup. Compilation,
  allocation instrumentation, output checking and evidence writes are separate.
  [Compiler time and memory](../direct-array-analysis-2026-11-03/README.md) have
  their own report.
- **Hosts/settings:** two native sessions each on four-vCPU Neoverse N2 ARM64 and
  EPYC 7763 AMD64. GCC 13.3.0 / 15.2.0, Rust 1.99.1; generated C uses O2 with
  the frozen architecture/arithmetic/workspace settings. Saved commands retain
  every flag. [Contract](../direct-array-callbacks.md#frozen-performance-comparison).

## Elapsed time

Ratios divide candidate by reference: 0.95 means 5% less time; 1.01 means 1% more.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 1.00794 | 1.00758 | 0.99568 | 1.00005 |
| 3 / 0 | history | 1.00067 | 1.00112 | 0.98007 | 0.98809 |
| 3 / 1 | current | 0.98526 | 0.98508 | 1.00014 | 0.99143 † |
| 3 / 1 | history | 0.99584 | 0.99964 | 0.98938 | 0.99472 |
| 3 / 199 | current | 0.96450 | 0.96461 | 0.97959 | 0.97603 |
| 3 / 199 | history | 0.97192 | 0.97230 | 0.95757 | 0.96266 |
| 3 / 1999 | current | 0.95763 | 0.96008 | 0.97255 | 0.96479 |
| 3 / 1999 | history | 0.96375 | 0.96615 | 0.93504 | 0.94772 |
| 33 / 199 | current | 0.94870 | 0.94952 | 0.92461 | 0.91861 |
| 33 / 199 | history | 0.94903 | 0.94944 | 0.92650 | 0.93305 |
| 129 / 199 | current | 0.94776 | 0.94830 | 0.93381 | 0.93660 |
| 129 / 199 | history | 0.95204 | 0.95189 | 0.94380 | 0.94450 |

† AMD64 session 2's 3/1 current-only case is inconclusive: identical candidate
copies differ by **3.53%**, beyond the frozen 2% limit. The displayed ratio is an
observation, not an accepted improvement. Other identical-copy controls pass.

Every session misses 5% on both 3/199 forms and on 3/1999 current. ARM64 also
misses 5% on 3/1999 history and 129/199 history in both sessions. All observed
zero/one-update candidate/reference ratios stay within their separate 2% bound,
but the noisy one-update case above remains unqualified.
[All 17 failed limits](verified-outcomes.json) preserve exact values.

## Memory and code costs

All 48 case/form/session comparisons have identical managed and raw profiles,
including the checks with derivative-workspace reuse disabled. For one process
running **eight 129/199 solves**, both candidate and reference record:

| Cost | Current | History |
|---|---:|---:|
| Managed allocation requests | 636,946 | 640,154 |
| Requested bytes over the process | 26,593,312 | 26,682,976 |
| Retain operations | 7,968 | 11,168 |
| Peak managed bytes | 19,360 | 838,688 |
| Peak raw derivative-buffer bytes | 33,904 | 33,904 |
| Final managed/raw bytes | 0 / 0 | 0 / 0 |

[Verified counts](verified-memory-counts.json) include the repeated-solve driver
and output. They are not single-solve counts. Managed storage counts fwp-owned
objects; raw storage counts derivative buffers. They do not measure the complete
process. Do not add their peaks to RSS.

GNU time separately records process peak resident memory (RSS), including runtime,
libraries and output:

| Session | Current-only reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,888 → 1,892 | 2,792 → 2,788 |
| aarch64-2 | 1,892 → 1,884 | 2,664 → 2,664 |
| x86_64-1 | 2,116 → 2,412 | 3,080 → 3,008 |
| x86_64-2 | 2,180 → 2,308 | 3,076 → 3,076 |

AMD64 current-only RSS rises by **6–14%** in these individual observations.
This is not a repeated RSS benchmark, and unchanged allocation counts do not
establish unchanged process memory. [Raw RSS and profiles](largest-process-memory.json.gz).

The largest compiler-reported frame grows by at most **64 bytes**, within the
128-byte limit. Text-section changes range from −1,280 to +4,032 bytes.
[All code/frame records](footprints.json) keep these costs separate from speed;
individual frame sizes do not measure total live call-stack use.

## C/Rust context

For 129/199 current-only, fwp's automatic differentiation takes 18.13–19.14 times
C's elapsed time on ARM64 and 23.03–23.50 times on AMD64. Ratios to Rust are
17.93–18.71 and 22.01–22.24. Those C/Rust programs use manually derived gradients,
different storage and different formatting; they do not record or reverse a tape.
These ratios compare implementations and algorithms, not isolated language
or ARC overhead. The paired fwp comparison above holds those choices fixed.
This batch does not rerun Swift; [existing Swift comparisons](../swift-allocations.md)
have their own workloads and limits.

## Original evidence and exact reference recovery

The timing workflow omitted the new reference directory from its artifact-upload
condition. The ordinary audit correctly failed. The original reports retained
source/patch/compiler hashes. Recovery rebuilt the frozen reference and required
**exact byte hashes** before auditing the original data. It did not rerun any
measured program or replace a timing observation. [Failure and repair](../direct-array-callbacks-2026-11-03/evidence-repair/README.md).

| Original measurement run | Sessions | Passing recovery/audit | Retained reports and full logs |
|---|---|---|---|
| 41649285227 | ARM64 1/2 | [41656720253](https://github.com/e6qu/fun-with-pipes/actions/runs/41656720253) | [Archive](arm-recovery.zip), [artifact identities](arm-recovery-artifacts.json), [audit job](arm-recovery-job.json), [audit log](arm-recovery-job.log.gz) |
| 41654861200 | AMD64 1 | [41658007799](https://github.com/e6qu/fun-with-pipes/actions/runs/41658007799) | [Archive](amd1-recovery.zip), [artifact identities](amd1-recovery-artifacts.json), [audit job](amd1-recovery-job.json), [audit log](amd1-recovery-job.log.gz) |
| 41655262486 | AMD64 2 | [41658488279](https://github.com/e6qu/fun-with-pipes/actions/runs/41658488279) | [Archive](amd2-recovery.zip), [artifact identities](amd2-recovery-artifacts.json), [audit job](amd2-recovery-job.json), [audit log](amd2-recovery-job.log.gz) |

All four original job logs, 5,336 raw-file records, commands, native images,
source/reference identities, counts and recalculated limits reconcile. Recovery
records identify their tooling source `80b5f93e` separately from the measured
source. All compiler diagnostics are clean; measurement jobs fail only their
final acceptance assertions.

[Seven rejected hosts](rejected-hosts/index.json) stopped before building or
timing: six EPYC 9V74 and one 9V45 instead of the required EPYC 7763. Their complete
logs, qualification records and artifact digests are retained. They are not
performance observations.

The [remaining-storage review](../remaining-gradient-storage.md) records redundant
same-type conversions, input records and unused iteration history. Those
candidates need their own ownership proof and declared comparison before code
changes; this experiment does not establish their benefit.
