# Packed derivative inputs: speed and memory

The grouped optimization removes temporary input records and exposes known
objectives inside their existing derivative scope. In qualified comparisons,
solves with at least 199 updates take **14.5–23.1% less elapsed time**. All measured
allocation and cleanup requirements pass. Three AMD64 timing limits remain open:

- Session 1: identical-copy variation is 2.3628% on 3/199 and 2.7833% on 3/1999,
  above 2%. Those cases are inconclusive, despite favorable measured ratios.
- Session 2: 3/1 current takes 2.3095% more time, above the 2% allowance.

Both ARM64 sessions pass all limits. The accepted policy retains verified
reductions with these three failures explicit; this is not complete timing
acceptance. No completed timing was repeated.

## Comparison and timing

- **Source:** `5f63ea1a9a7fb7a6bc1068bbd84c4224c176b106`, immutable tag
  `roadmap/packed-input-measurement-2026-11-04`.
- **Reference:** the same source with only scoped objective specialization and
  packed-input selection disabled. Runtime, library and earlier optimizations
  are unchanged; the reference edits `src/mono.rs` and `src/cgen.rs`.
- **Work:** complete Rosenbrock gradient-descent solves. Start with alternating
  −1.2/1.0 coordinates; each update subtracts 0.001 times the automatic derivative.
  [The workload explanation](../descent-costs.md#what-the-programs-compute)
  introduces the function and derivative calculation.
- **Forms:** current uses an explicit loop; history uses `iterate count descend | last`.
  Both now keep only current state. “History” names the source form, not live
  storage. Outputs agree exactly with the reference and C/Rust peers.
- **Samples:** the six cases below use 32,768 / 512 / 32 / 4 / 32 / 8 solves per
  process. Two warmup rounds precede 98 balanced measured rounds. Each sample
  sums seven fresh processes; an identical candidate copy checks variation.
- **Timing scope:** process launch, solves, output and cleanup. Compilation and
  instrumentation are separate. Zero updates still construct and print inputs.
- **Limits:** ≥199 updates require at least 5% less time; other cases allow at
  most 2% more. Identical-copy variation must be ≤2%. Count, raw-storage and
  stack requirements are in the [frozen contract](../packed-derivative-inputs.md).

## Hosts and settings

Two sessions each use four available CPUs on Neoverse N2 ARM64 and EPYC 7763
AMD64, GCC 13.3.0 / 15.2.0 and Rust 1.99.1. All hosts pass qualification.
Generated C uses `-O2 -std=gnu11 -fno-fast-math -ffp-contract=off -UFWP_NO_REUSE
-fstack-usage -w`, `-march=armv8-a` / `-march=x86-64`, and `-lm -lpthread -ldl`.
Generation explicitly sets `FWP_LTO=0`, `FWP_AD_WORKSPACE=1`,
`FWP_PACKED_ARRAYS=1`, `FWP_STACK=1`, `FWP_ARRAY_FUSION=1`, `FWP_VRET=1` and
`FWP_FRAME_FIELDS=1`.

## Elapsed time

Ratios divide candidate by reference: 0.80 means 20% less elapsed time.
† marks an inconclusive case because its identical-copy control failed.
Bold marks the missed small-case regression limit.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 1.01070 | 1.01037 | 1.00552 | 1.00003 |
| 3 / 0 | history | 0.99680 | 0.99653 | 0.98858 | 0.98694 |
| 3 / 1 | current | 0.99795 | 1.00032 | 1.00812 | **1.02310** |
| 3 / 1 | history | 0.98696 | 0.98811 | 0.98321 | 0.98857 |
| 3 / 199 | current | 0.84695 | 0.84647 | 0.82044† | 0.85514 |
| 3 / 199 | history | 0.84792 | 0.84461 | 0.81823† | 0.82228 |
| 3 / 1999 | current | 0.83648 | 0.83262 | 0.80971† | 0.79770 |
| 3 / 1999 | history | 0.82870 | 0.82193 | 0.82141† | 0.80796 |
| 33 / 199 | current | 0.77659 | 0.77639 | 0.83135 | 0.82393 |
| 33 / 199 | history | 0.79167 | 0.79109 | 0.81700 | 0.82056 |
| 129 / 199 | current | 0.76861 | 0.76909 | 0.81049 | 0.81261 |
| 129 / 199 | history | 0.77887 | 0.77829 | 0.82379 | 0.82452 |

[Recalculated outcomes](verified-outcomes.json) retain every limit result.
[The saved-sample diagnosis](amd64-sample-review.md) finds no established cause
for the AMD64 misses. Subsets and phase instrumentation do not replace the
original complete-sample result or justify changing warmups.

## Allocation traffic and live storage

For **one process running eight 129-coordinate, 199-update solves**, including
its driver and output, both source forms give the same counts:

| Cost | Reference | Candidate |
|---|---:|---:|
| Managed allocation requests | 635,354 | 223,026 |
| Requested bytes over the process lifetime | 24,937,632 | 16,684,704 |
| Retain operations | 7,968 | 3,192 |
| Peak simultaneously live managed bytes | 19,360 | 15,232 |
| Final managed bytes | 0 | 0 |

Across all 48 comparisons and workspace reuse on/off, each update with N
coordinates saves **2N+1 requests, 40N+24 requested bytes and three retains**.
The complete group exceeds the minimum input-packing prediction of 2N requests
and 40N bytes. For one 129/199 solve, observed savings are 51,541 requests,
1,031,616 requested bytes and 597 retains. Zero-update counts are unchanged.
[The count checks](verified-memory-counts.json) retain all observations.

Raw derivative-buffer profiles are unchanged: the largest case peaks at 33,904
bytes and finishes at zero. Managed storage and raw tape storage are separate.
Neither is total process RAM.

GNU time measures peak resident RAM separately, including runtime, libraries
and output. These individual observations do **not** establish lower process RAM:

| Session | Current-only reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,884 → 1,892 | 1,888 → 1,956 |
| aarch64-2 | 1,956 → 1,888 | 1,896 → 1,888 |
| x86_64-1 | 2,180 → 2,308 | 2,308 → 2,180 |
| x86_64-2 | 2,108 → 2,180 | 2,112 → 2,412 |

[Raw profiles and RSS](largest-process-memory.json.gz) preserve their scopes.
Do not add these different peak measures. Maximum reported static frame growth
is 32 bytes, within 128; text-size changes range from −2,752 to +416 bytes.
[All footprints](footprints.json) retain native binary/text sizes and frame counts.

## Remaining comparison with C and Rust

For 129/199 current-form solves, candidate fwp takes 14.09–14.23 times the C
elapsed time on ARM64 and 18.58–19.39 times on AMD64. Against Rust, the ranges
are 13.94–14.10 and 17.68–18.42. These are complete implementation gaps:
fwp calculates derivatives automatically; C/Rust use manually written gradients
and different storage. The ratios do not isolate language, allocation or ARC
cost, and do not show parity with C/Rust. No equivalent Swift AD peer is measured.

## Evidence and delivery

[Measurement run 41853137417](https://github.com/e6qu/fun-with-pipes/actions/runs/41853137417)
retains the passing sessions and both failed AMD64 jobs. The independent
[audit 41856724419](https://github.com/e6qu/fun-with-pipes/actions/runs/41856724419)
passes: all four full logs and 5,336 raw-file records reconcile, including source,
reference edits, commands, native images, outputs, counts and every failed limit.

- [Reports and complete session logs](initial-audit.zip).
- [Original and complete retained artifact identities](initial-audit-artifacts.json).
- [Audit job](initial-audit-job.json) and [full audit log](initial-audit-job.log.gz).
- [Native correctness](../packed-input-checks-2026-11-04/README.md) and
  [compiler costs](../packed-input-analysis-2026-11-04/README.md) pass their separate
  checks. Final nine-job production CI and documentation remain required.

Older timing goals use different references and remain separate.
