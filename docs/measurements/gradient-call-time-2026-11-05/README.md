# Gradient-call storage: speed and memory

Three-coordinate solves with 199 or 1,999 updates take **14.3–25.2% less time**
than the same source with these four changes disabled. The 33- and 129-coordinate
cases improve by only 0.5–3.6%, missing the 5% target in all sixteen comparisons.
AMD64 session 2's zero-update current case is **2.18% slower**, beyond the 2% limit.

All identical-copy, allocation, cleanup, raw-storage and stack limits pass.
Verified storage reductions are retained under the accepted policy, with all
**17 timing misses open**. No timing session was rerun. Process memory is not
consistently lower, and these results do not establish parity with C or Rust.

## What is compared

- **Candidate:** scoped input borrowing, numeric fold fields, direct backward
  seeds and consumed coordinate scratch. **Reference:** the same source with
  exactly those four changes disabled; earlier optimizations remain enabled.
- **Source:** `d494dd910723303f99992610895d9784968c79e8`, immutable tag
  `roadmap/gradient-call-timing-2026-11-05`. [Contract](../gradient-call-storage.md).
- **Work:** complete Rosenbrock gradient-descent solves, starting from alternating
  −1.2/1.0 coordinates. Each update subtracts 0.001 times the automatic derivative.
  [Worked explanation](../descent-costs.md#what-the-programs-compute).
- **Forms:** current uses a loop; history uses `iterate count descend | last`.
  Both keep only current state after optimization and produce checked outputs.
- **Sampling:** six cases perform 32,768 / 512 / 32 / 4 / 32 / 8 solves per process.
  Two warmup rounds precede 98 balanced measured rounds; each sample sums seven
  fresh processes. A byte-identical candidate copy checks timing variation.
- **Timer:** process launch, repeated solves, output and cleanup. Compilation and
  memory observers run separately. Zero updates still construct and print inputs;
  per-solve times amortize startup and do not describe a standalone invocation.
- **Limits:** at least 5% less time for ≥199 updates, at most 2% slowdown otherwise,
  at most 2% identical-copy variation. Observed copy variation is at most 1.17%.

## Elapsed time

Ratios are candidate / reference: 0.78 means 22% less time; 1.02 means 2% more.
All 33/199 and 129/199 entries miss 0.95. The AMD64 session 2 3/0 current entry
exceeds 1.02. Exact samples and failures are in [the outcomes](verified-outcomes.json).

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 0.98165 | 0.98048 | 1.01150 | 1.02182 |
| 3 / 0 | history | 0.99162 | 0.98759 | 1.01035 | 1.01243 |
| 3 / 1 | current | 0.98841 | 0.98805 | 0.99661 | 0.99440 |
| 3 / 1 | history | 0.99067 | 0.99110 | 0.98150 | 0.98960 |
| 3 / 199 | current | 0.78047 | 0.77843 | 0.82947 | 0.81939 |
| 3 / 199 | history | 0.78639 | 0.79298 | 0.85711 | 0.83470 |
| 3 / 1999 | current | 0.74819 | 0.75719 | 0.81336 | 0.78137 |
| 3 / 1999 | history | 0.75214 | 0.75703 | 0.84219 | 0.81427 |
| 33 / 199 | current | 0.96402 | 0.96420 | 0.98246 | 0.98836 |
| 33 / 199 | history | 0.96486 | 0.96539 | 0.98161 | 0.98046 |
| 129 / 199 | current | 0.99393 | 0.99398 | 0.99156 | 0.99257 |
| 129 / 199 | history | 0.99461 | 0.99523 | 0.98598 | 0.99164 |

The audit establishes those misses; it does not establish their cause. Keep the
zero-update slowdown separate from the larger cases' unmet gain targets. Do not
rerun unchanged samples or attribute the slowdown to machine-code layout without
a source-led diagnostic and a separately declared experiment.

## Allocation traffic and live storage

Managed storage means value storage tracked by the fwp runtime; raw derivative
buffers are counted separately. These counters do not cover all system-library
allocations. For one process running eight 129-coordinate, 199-update solves, both forms and
all four sessions have exactly the same storage counts:

| Measurement | Reference | Candidate |
|---|---:|---:|
| Managed allocation requests | 17,098 | 5,953 |
| Requested bytes over the process | 10,124,960 | 8,278,216 |
| Effective reference-count increments | 3,192 | 8 |
| Peak charged managed bytes | 13,664 | 13,632 |
| Peak raw derivative bytes | 33,904 | 33,904 |
| Final managed / raw bytes | 0 / 0 | 0 / 0 |

The cached seed disappears once per process. Each positive update saves seven
requests, 8N+128 requested bytes and two reference-count increments; the one-time
seed adds one request and 24 bytes. Zero updates have identical counts.
[All 48 comparisons](verified-memory-counts.json), with workspace reuse on/off,
match the independently measured [allocation census](../gradient-call-census-2026-11-05/README.md).
Requested bytes measure traffic, not simultaneously live storage or process RAM.

Peak process RAM for that eight-solve workload, measured separately:

| Session | Current-only reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,832 → 1,824 | 1,764 → 1,760 |
| aarch64-2 | 1,764 → 1,824 | 1,768 → 1,764 |
| x86_64-1 | 2,180 → 2,176 | 2,180 → 2,112 |
| x86_64-2 | 2,416 → 2,304 | 2,308 → 2,412 |

These mixed process-memory observations do not establish a general RAM reduction.
They include runtime, libraries and allocator effects; do not add them to managed
or raw-storage counts. [Exact profiles](largest-process-memory.json.gz) retain
all observations. [Code/stack records](footprints.json) show text-size reductions
of 1,856–7,104 bytes and at most 80 bytes of largest-frame growth, within 128 bytes.
Code size is secondary to speed here.

## C and Rust peers

For the largest workload, current fwp takes 12.68–13.78 times the C time on ARM64
and 17.89–18.76 times on AMD64. Against Rust, ratios are 12.57–13.60 and 16.84–17.61.
These peers compute manual derivatives and reuse two contiguous buffers; fwp
records and reverses derivatives and uses immutable list values. fwp captures
its initial input once, while peer workload bodies initialize their inputs per
solve. Equal outputs do not imply equal allocation or differentiation work.
These ratios measure complete implementations, **not isolated ARC or language overhead**.

## Hosts, settings and audit

[Measurement run 41967904120](https://github.com/e6qu/fun-with-pipes/actions/runs/41967904120)
uses native Neoverse-N2 ARM64 and AMD EPYC 7763 AMD64, with two qualified sessions
each. GCC is 13.3 on ARM64 and 15.2 on AMD64; Rust is 1.99.1. Generated C uses
O2, GNU11, `-fno-fast-math`, `-ffp-contract=off`, LTO off, and explicit architecture
flags. Exact versions, commands, inputs and source hashes are retained.

[Independent audit 41970153152](https://github.com/e6qu/fun-with-pipes/actions/runs/41970153152)
passes. It reconstructs outputs, counters, source/reference edits, raw timing
summaries, compiler/binary identities and frame limits across **5,336 raw-file
records**. [Audit archive](audit.zip) contains every report and complete original
job log. Its artifact digest, auditor job and full log are retained beside it.
Every failed step is explained by the 17 frozen timing limits; there are no
unexplained diagnostics. The original measurement run remains failed.

[Final platform delivery is verified](../../roadmap-history.md#gradient-call-storage-pr-259).
The [allocation census](../gradient-call-census-2026-11-05/README.md#remaining-storage)
and zero-update source/driver investigation were leads at this revision, not
established explanations for the timing results. Subsequent changes have separate
[delivery records](../../roadmap-history.md); [PLAN.md](../../../PLAN.md) owns current goals.
