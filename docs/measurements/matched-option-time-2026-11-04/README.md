# Matched optional results: time and memory

Removing the temporary `Some(value)` box saves **one allocation request, 16
requested bytes and one retain per history-form solve**. Peak managed storage
and raw derivative-buffer storage are unchanged. Current-form counts are unchanged.
These observations agree across four sessions and both workspace settings.

All frozen runtime, copy-control, memory-count and stack limits pass.
Passing a regression limit does not establish a speedup: several larger cases
are slower. The table below retains every ratio. No completed timing was repeated,
and older comparisons keep their separate unresolved goals.

## Work, reference and timing

- **Source:** `82963531dddb6d9a5f32ec26657dc220736f4055`, immutable tag
  `roadmap/matched-option-measurement-2026-11-04`.
- **Reference:** the same source with only the three matched-option selections
  disabled. Both compilers preserve earlier history removal and lifetime repairs.
  The reference changes two conditions in `src/cgen.rs`; runtime code is identical.
- **Program:** complete Rosenbrock gradient-descent solves, starting with alternating
  −1.2/1.0 coordinates, subtracting 0.001 times each automatic derivative per update.
  [The workload explanation](../descent-costs.md#what-the-programs-compute) introduces
  the function and derivatives.
- **Forms:** current uses an explicit loop; history uses `iterate count descend | last`.
  Both compilers now keep only current numeric state. “History” labels the source,
  not retained storage. The candidate returns the matched result as fields;
  the reference constructs its optional wrapper. Outputs agree exactly.
- **Samples:** 32,768 / 512 / 32 / 4 / 32 / 8 solves per process for the six cases
  below. Two warmup rounds precede 98 balanced measured rounds; each sample sums
  seven fresh processes. Two identical copies per implementation check variation.
- **Timer:** launch, solves, output and cleanup. Compilation and instrumentation
  are separate. Zero updates still construct and print the initial vector.
- **Limits:** every candidate/reference time ratio ≤1.02; identical-copy variation
  ≤2%; no added managed requests, requested bytes or retains; final storage zero;
  reported frame growth ≤128 bytes. This small boundary change has no 5% speed promise.

## Native hosts and settings

Two sessions each use four available CPUs on Neoverse N2 ARM64 and EPYC 7763
AMD64, with GCC 13.3.0 / 15.2.0 and Rust 1.99.1. Generated C uses
`-O2 -std=gnu11 -fno-fast-math -ffp-contract=off -UFWP_NO_REUSE -fstack-usage -w`,
`-march=armv8-a` / `-march=x86-64`, and `-lm -lpthread -ldl`.
Generation explicitly sets `FWP_LTO=0`, `FWP_AD_WORKSPACE=1`,
`FWP_PACKED_ARRAYS=1`, `FWP_STACK=1`, `FWP_ARRAY_FUSION=1`, `FWP_VRET=1` and
`FWP_FRAME_FIELDS=1`. The [contract](../matched-option-fields.md) fixes the comparison.

## Elapsed time

Ratios divide candidate by reference: 0.99 means 1% less time; 1.01 means 1% more.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 0.99992 | 1.00170 | 0.99937 | 1.00540 |
| 3 / 0 | history | 0.98872 | 0.98782 | 0.97750 | 0.98482 |
| 3 / 1 | current | 1.00057 | 0.99997 | 0.97804 | 0.98952 |
| 3 / 1 | history | 0.99754 | 1.00011 | 0.96769 | 0.97856 |
| 3 / 199 | current | 0.99406 | 0.99253 | 1.00181 | 1.00496 |
| 3 / 199 | history | 0.99967 | 0.99554 | 1.01946 | 1.01202 |
| 3 / 1999 | current | 1.00183 | 1.00138 | 0.98749 | 1.00062 |
| 3 / 1999 | history | 1.00147 | 1.00751 | 1.00376 | 1.01789 |
| 33 / 199 | current | 1.00063 | 1.00045 | 1.00667 | 1.00585 |
| 33 / 199 | history | 1.01543 | 1.01561 | 1.01572 | 1.01104 |
| 129 / 199 | current | 1.00053 | 0.99989 | 1.00939 | 0.99708 |
| 129 / 199 | history | 1.01256 | 1.01296 | 1.01690 | 1.01854 |

[Recalculated outcomes](verified-outcomes.json) preserve every acceptance result.
Small timing differences do not identify an ownership bug or their hardware cause.

## Allocation traffic and live memory

For **one process running eight 129-coordinate, 199-update solves**, including
its driver and output:

| Cost | Current reference → candidate | History reference → candidate |
|---|---:|---:|
| Managed allocation requests | 635,354 → 635,354 | 635,362 → 635,354 |
| Requested bytes | 24,937,632 → 24,937,632 | 24,937,760 → 24,937,632 |
| Retain operations | 7,968 → 7,968 | 7,976 → 7,968 |
| Peak managed bytes | 19,360 → 19,360 | 19,360 → 19,360 |
| Final managed bytes | 0 → 0 | 0 → 0 |

Raw derivative-buffer peaks remain 33,904 bytes; final raw storage is zero.
[All 48 count comparisons](verified-memory-counts.json) agree with workspace reuse
on/off. The one-request/16-byte/one-retain saving applies to every tested
history-form solve, including zero updates; managed peaks are unchanged in every
case. Requests count traffic over time, while peak storage counts simultaneously
live bytes. Neither is process RAM.

GNU time separately measures resident process memory, including runtime,
libraries and output. These are individual observations, not repeated RSS timings:

| Session | Current reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,892 → 1,892 | 1,960 → 1,896 |
| aarch64-2 | 1,956 → 1,892 | 1,896 → 1,960 |
| x86_64-1 | 2,180 → 2,180 | 2,244 → 2,112 |
| x86_64-2 | 2,116 → 2,180 | 2,308 → 2,180 |

[Raw profiles and RSS](largest-process-memory.json.gz) retain their separate scopes.
Do not add managed/raw peaks to RSS. Maximum compiler-reported frame growth is
16 bytes; native text changes range from -1,792 to +0 bytes.
[Code/frame records](footprints.json) report these costs separately from speed;
one frame is not the complete active stack.

## Compiler cost and C/Rust context

[Compiler-cost checks](../matched-option-analysis-2026-11-04/README.md) pass all ten
cases and their noise controls. They time the compiler through C emission, not
these programs.

- ARM64, largest current-form solve: fwp takes 18.09–18.71× C time and 17.96–18.49× Rust time.
- AMD64, largest current-form solve: fwp takes 24.37–25.32× C time and 22.86–23.75× Rust time.

C/Rust use manually derived gradients, different storage and formatting; they do
not record and reverse an automatic-differentiation tape. These ratios compare
whole implementations, not isolated language or ARC overhead. The paired fwp
comparison holds those choices fixed. This batch has no Swift derivative peer;
[Swift comparisons](../swift-allocations.md) cover different workloads.

## Evidence

| Measurement run | Sessions | Passing raw audit | Reports and full logs |
|---|---|---|---|
| 41811658838 | aarch64-2, aarch64-1, x86_64-2 | [41814391372](https://github.com/e6qu/fun-with-pipes/actions/runs/41814391372) | [Reports](initial-audit.zip), [identities](initial-audit-artifacts.json), [job](initial-audit-job.json), [log](initial-audit-job.log.gz) |
| 41814521814 | x86_64-1 | [41817009801](https://github.com/e6qu/fun-with-pipes/actions/runs/41817009801) | [Reports](amd1-audit.zip), [identities](amd1-audit-artifacts.json), [job](amd1-audit-job.json), [log](amd1-audit-job.log.gz) |

All four full logs and 5,336 raw-file records reconcile: sources, reference edits,
commands, native images, outputs, counts and recalculated limits. Four
[wrong-CPU hosts](rejected-hosts/README.md) stopped before building/timing; only
those unmeasured sessions were replaced. No completed result was discarded.
