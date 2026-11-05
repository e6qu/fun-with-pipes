# Reusing numeric storage: speed and memory

Solves with at least 199 updates take **3.36–10.50% less elapsed time** against
the same source with this optimization disabled. Four AMD64 results miss the
required 5% gain. Both ARM64 sessions pass every limit. All identical-copy,
small-case regression, allocation, cleanup and stack limits pass.

Verified reductions are retained under the accepted policy, with these four
speed goals open. No completed timing session was rerun. Process RAM is not
consistently lower.

## Comparison and measurement

- **Source:** `07541ff956d582bb9c3936b86261e43fa25b0b2f`, immutable tag
  `roadmap/owned-numeric-measurement-2026-11-05`.
- **Reference:** identical source with only consuming array maps and coordinate
  list reuse disabled. Earlier optimizations remain on; the exact patch changes
  one call in `src/cgen.rs`. [Ownership and limits](../owned-numeric-updates.md)
  were frozen before implementation.
- **Work:** complete Rosenbrock gradient-descent solves, starting from alternating
  −1.2/1.0 coordinates. Each update subtracts 0.001 times the automatic derivative.
  [The worked explanation](../descent-costs.md#what-the-programs-compute) introduces
  the function and its derivative calculation.
- **Forms:** current uses an explicit loop; history uses `iterate count descend | last`.
  Both keep only current state after optimization. Outputs match the reference
  and C/Rust peers.
- **Sampling:** six cases run 32,768 / 512 / 32 / 4 / 32 / 8 solves per process.
  Two warmup rounds precede 98 balanced measured rounds. Each sample sums seven
  fresh processes. A byte-identical candidate copy checks timing variation.
- **Scope:** process launch, solves, output and cleanup. Compilation and profiling
  are separate. Even zero updates construct and print inputs.
- **Limits:** at least 5% less time for ≥199 updates; other cases allow at most
  2% more. Identical-copy variation must be at most 2%.

## Elapsed time

Ratios are candidate / reference: 0.90 means 10% less time; 1.01 means 1% more.
Bold values miss the 5% gain required for their workloads. All remain faster
than their reference; they are not accepted as meeting that stronger target.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 1.00078 | 1.00002 | 0.99890 | 1.00570 |
| 3 / 0 | history | 1.00274 | 1.00001 | 1.00866 | 1.01044 |
| 3 / 1 | current | 1.00302 | 1.00418 | 0.97393 | 1.00396 |
| 3 / 1 | history | 0.99922 | 1.00152 | 1.00077 | 1.00894 |
| 3 / 199 | current | 0.92588 | 0.93213 | **0.96640** | **0.95668** |
| 3 / 199 | history | 0.93669 | 0.93618 | 0.91975 | **0.96231** |
| 3 / 1999 | current | 0.93685 | 0.93198 | 0.94738 | **0.95236** |
| 3 / 1999 | history | 0.93199 | 0.93772 | 0.93900 | 0.93788 |
| 33 / 199 | current | 0.90954 | 0.90895 | 0.92414 | 0.92155 |
| 33 / 199 | history | 0.89564 | 0.89500 | 0.91990 | 0.92802 |
| 129 / 199 | current | 0.91396 | 0.91305 | 0.90992 | 0.91827 |
| 129 / 199 | history | 0.89614 | 0.89575 | 0.92052 | 0.91928 |

[Exact outcomes](verified-outcomes.json) retain all four misses: AMD64 session 1
3/199 current; session 2 3/199 current/history and 3/1,999 current.
No observed copy-control failure explains them. These are measured shortfalls,
not an established compiler correctness bug or a reason to rerun unchanged work.

## Allocation traffic and live storage

For one process running **eight 129-coordinate, 199-update solves**, both forms
and all four sessions give:

| Measurement | Reference | Candidate |
|---|---:|---:|
| Managed allocation requests | 223,026 | 17,098 |
| Requested bytes over the process | 16,684,704 | 10,124,960 |
| ARC retain operations | 3,192 | 3,192 |
| Peak simultaneously live managed bytes | 15,232 | 13,664 |
| Peak raw derivative bytes | 33,904 | 33,904 |
| Final managed / raw bytes | 0 / 0 | 0 / 0 |

That saves **25,741 requests and 819,968 requested bytes per solve**. For N
coordinates and U updates, each solve saves U arrays (`8N+8` bytes each) and
`N × max(U−1, 0)` list cells (24 bytes each). The first coordinate list is shared
with the captured input and must be preserved. Coordinate scratch allocation
remains; this change does not remove every temporary buffer.

[All 48 runtime comparisons](verified-memory-counts.json), with workspace reuse
on/off, exactly match the independent [untimed census](../owned-numeric-census-2026-11-05/README.md).
Retain counts and raw derivative storage are unchanged. Peak managed storage
never grows; final managed/raw storage is zero. Allocation traffic, managed live
bytes and raw buffers are distinct measures, not total process RAM.

GNU time separately observes peak resident process RAM, including runtime,
libraries and output. Largest-case observations, in KiB:

| Session | Current-only reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,892 → 1,768 | 1,956 → 1,764 |
| aarch64-2 | 1,892 → 1,892 | 1,892 → 1,832 |
| x86_64-1 | 2,116 → 2,308 | 2,308 → 2,308 |
| x86_64-2 | 2,180 → 2,180 | 2,308 → 2,180 |

These individual readings do not establish lower process RAM. [Raw profiles and RSS](largest-process-memory.json.gz)
retain their scopes. Maximum reported static frame growth is **16 bytes**, within
the 128-byte limit. Text-size changes range from −128 to +1,184 bytes.
[Footprints](footprints.json) retain every binary/text size and frame observation.

## Hosts and reproducibility

Two qualified sessions per architecture use four available CPUs: Neoverse-N2
ARM64 / EPYC 7763 AMD64, GCC 13.3.0 / 15.2.0, Rust 1.99.1. Compiler builds use
release mode. Generated C uses `-O2 -std=gnu11 -fno-fast-math -ffp-contract=off
-UFWP_NO_REUSE -fstack-usage -w`, explicit `-march=armv8-a` / `-march=x86-64`,
and `-lm -lpthread -ldl`. Generation sets `FWP_LTO=0`, `FWP_AD_WORKSPACE=1`,
`FWP_PACKED_ARRAYS=1`, `FWP_STACK=1`, `FWP_ARRAY_FUSION=1`, `FWP_VRET=1` and
`FWP_FRAME_FIELDS=1`.

- [Original run 41926862701](https://github.com/e6qu/fun-with-pipes/actions/runs/41926862701):
  two passing ARM64 sessions, AMD64 session 2's three missed limits, and the first
  AMD64 session 1 host rejected before building/timing (EPYC 9V74 instead of 7763).
- [Replacement 41927345094](https://github.com/e6qu/fun-with-pipes/actions/runs/41927345094):
  only the missing AMD64 session 1, on the qualified CPU; one missed limit.
- Independent audits [41929272270](https://github.com/e6qu/fun-with-pipes/actions/runs/41929272270)
  and [41929960201](https://github.com/e6qu/fun-with-pipes/actions/runs/41929960201)
  pass. All four complete logs and 5,336 raw-file records reconcile: source,
  reference edits, commands, native images, outputs, counts, timing and limits.
- [Original reports/logs](initial-audit.zip) and [replacement reports/logs](replacement-audit.zip)
  preserve every outcome, including the rejected host. Adjacent artifact/job
  records and compressed audit logs identify the complete original evidence.

## C and Rust comparison

For 129/199 current-form solves, fwp takes 12.76–13.51 times C's elapsed time on
ARM64 and 18.31–19.15 times on AMD64. Against Rust, the ranges are 12.54–13.19 and
17.28–18.03. These are gaps between complete implementations: fwp calculates
derivatives automatically, while C/Rust use handwritten gradients and different
storage. The ratios do not isolate language or ARC overhead and do not establish
parity. This experiment includes no equivalent Swift automatic-derivative peer.

[Native correctness](../owned-numeric-checks-2026-11-05/README.md) and
[compiler costs](../owned-numeric-analysis-2026-11-05/README.md) pass separately.
Final nine-job production CI and documentation are still required for delivery.
Older timing goals keep their own references and remain separate.
