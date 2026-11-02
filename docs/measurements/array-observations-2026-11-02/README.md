# How the benchmark driver changes array timings

**Complete:** four native sessions and all raw archives are independently audited.
Driver changes alter timing without changing array storage or numerical work.
Small AMD64 copy controls remain inconclusive; original performance limits stay open.

The [previous experiment](../array-consumption-2026-11-02/README.md) added explicit
preparation and extra measurements. Even when preparation was set to zero, its
early consumption timings differed from the original benchmark. This experiment
separates those two changes. It changes **benchmark drivers**, not the compiler,
language or runtime.

## What runs

A driver is the C program that constructs arrays, calls the compiled fwp function,
times the calls and prints the results. Each version runs the same numerical work:

| Driver | Extra CPU/fault measurements | Preparation code |
|---|---|---|
| Original | None | Absent |
| Observed | CPU clocks around consumption; page faults and context switches around each sample | Absent |
| Preparation-capable, zero | Same observations | Present, always invoked with explicit argument `0` |

The last version still parses its argument, reads preparation clocks and prints a
preparation record. It allocates no preparation array and performs no preparation
reductions. Its larger C translation unit can also affect compilation of the
numerical code; this comparison does not isolate one particular call or instruction.

Each version runs two fwp implementations: current fwp and the reference using
the callback-selection rule from before [PR #245](../../roadmap-history.md#direct-numeric-array-callbacks-pr-245).
The reference is **also fwp**, not C, Rust or Swift. Every executable has a second,
byte-identical copy to check measurement stability.

For each input size, 65,537 and 262,145 elements:

1. A fresh process runs five samples. Each sample constructs and consumes eight
   arrays, with round numbers 0 through 7.
2. Element `i` in round `r` is `(((i + r) % 19) - 9) / 4`, computed in the declared
   floating-point order. Consumption multiplies each element by 3, adds 1, then
   sums from left to right starting at `-0.0`; result checks and destruction
   remain unchanged.
3. Each measured round runs four fresh processes for each of the 12 roles
   (two implementations × three drivers × two copies).
4. Two warmup rounds precede 24 measured rounds. Every role occupies every process
   position twice. No sample or completed noisy session is discarded.

For example, the first three elements in round 0 are `-2.25, -2, -1.75`.
Their transformed values are `-5.75, -5, -4.25`, which sum to `-15`. The benchmark
uses the full declared sizes, not this three-element illustration.

For one role, a measured round covers 4 × 5 × 8 = **160 arrays**. Reported per-array
costs divide the median of 24 complete round totals by 160. Sample-position costs
use all 96 measured processes and divide each sample's time by eight. These are
separate summaries; subtracting two medians is not a paired measurement.

## Timing boundaries and memory

[Clock, page-fault and memory terms](../../terminology.md#why-extra-measurements-can-change-a-benchmark)
explain why these observations measure different things.

| Quantity | Included work |
|---|---|
| Construction wall time | Allocation, filling and the existing construction barrier |
| Consumption wall time | The compiled reduction and its ownership cleanup |
| Enclosing-work wall time | Eight construction/consumption pairs, result hashing and intervening measurement calls |
| Consumption CPU time | CPU time around the consumption wall-clock pair; unavailable in the original driver |
| Faults/context switches | Changes across one complete sample; unavailable in the original driver |
| Process RSS | One separate whole-process peak reading per role; not an allocation count |

Process startup and sample printing are outside the workload timers. Whole-process
command durations are retained separately. No clock-cost estimate is subtracted.
Missing original CPU/fault observations are absent, not zero.

Separate profiling executables check one allocation per array, zero effective
retains during measured work, bounded live storage and zero storage after cleanup.
Deliberately omitting the actual array destructor must fail; failed wall clocks
must fail in every driver, and failed CPU clocks must fail in both observed drivers.
All controls finish for both sizes before the first warmup process starts.

The [frozen protocol](../array-observation-boundaries.md) specifies native CPUs,
GCC versions, O2 flags, the 180-second process deadline and unchanged 2% copy limit.
An identical-copy failure makes that comparison inconclusive. It is retained as a
measurement result; it is not permission to change a limit or rerun for a pass.

## Results

The tables show percent change in elapsed time across the two copies. Positive
means more time; negative means less. These are driver comparisons, not compiler
speedups. **Current-fwp small AMD64 driver comparisons remain inconclusive** because
at least one relevant copy control fails; the reference copies pass. ARM64 and large AMD64 copy controls pass.

### Adding observations to the original driver

| Host/session | Elements | fwp implementation | Construction | Consumption | Enclosing work |
|---|---:|---|---:|---:|---:|
| ARM64/1 | 65,537 | fwp | -0.08 to +0.23% | +0.00 to +0.43% | +0.67 to +0.79% |
| ARM64/1 | 65,537 | reference | -0.52 to +0.94% | +0.13 to +0.14% | -0.34 to +1.05% |
| ARM64/1 | 262,145 | fwp | -0.36 to -0.16% | -0.27 to -0.16% | +0.35 to +0.46% |
| ARM64/1 | 262,145 | reference | -0.58 to +0.09% | -0.10 to +0.02% | -0.46 to +0.19% |
| ARM64/2 | 65,537 | fwp | -0.05% | -0.04 to +0.38% | +0.67 to +0.72% |
| ARM64/2 | 65,537 | reference | +0.54 to +1.12% | -0.15 to +0.10% | +0.67 to +1.23% |
| ARM64/2 | 262,145 | fwp | -0.30 to -0.18% | -0.21 to +0.04% | +0.37 to +0.46% |
| ARM64/2 | 262,145 | reference | -0.39 to +0.12% | +0.05 to +0.35% | -0.28 to +0.22% |
| AMD64/1 | 65,537 | fwp | -2.92 to +1.30% | -1.36 to +0.58% | -1.33 to +1.95% |
| AMD64/1 | 65,537 | reference | -0.33 to +0.59% | -0.23 to +0.04% | -0.01 to +0.73% |
| AMD64/1 | 262,145 | fwp | -2.00 to +1.38% | -1.34 to +0.21% | -1.43 to +1.50% |
| AMD64/1 | 262,145 | reference | -0.02 to +0.22% | -0.01 to +0.06% | +0.04 to +0.27% |
| AMD64/2 | 65,537 | fwp | -7.23 to +2.13% | -5.74 to +0.39% | -5.94 to +2.87% |
| AMD64/2 | 65,537 | reference | +0.15 to +0.97% | -0.09 to +0.14% | +0.31 to +1.23% |
| AMD64/2 | 262,145 | fwp | +0.10 to +1.83% | +0.43 to +0.55% | +0.51 to +1.89% |
| AMD64/2 | 262,145 | reference | +0.10 to +0.28% | -0.03 to +0.03% | +0.18 to +0.32% |

### Adding the complete zero-preparation driver

| Host/session | Elements | fwp implementation | Construction | Consumption | Enclosing work |
|---|---:|---|---:|---:|---:|
| ARM64/1 | 65,537 | fwp | -3.07 to -2.85% | +5.02 to +5.11% | -1.24 to -1.09% |
| ARM64/1 | 65,537 | reference | -0.13 to +0.25% | -0.10 to -0.03% | -0.13 to +0.22% |
| ARM64/1 | 262,145 | fwp | -2.36 to -2.33% | +5.18 to +5.37% | -0.75 to -0.73% |
| ARM64/1 | 262,145 | reference | +0.19 to +0.46% | +0.03 to +0.09% | +0.17 to +0.44% |
| ARM64/2 | 65,537 | fwp | -3.04 to -2.80% | +4.52 to +5.39% | -1.26 to -1.12% |
| ARM64/2 | 65,537 | reference | -1.64 to +0.01% | -0.04 to +0.10% | -1.57 to -0.01% |
| ARM64/2 | 262,145 | fwp | -2.41 to -2.30% | +5.14 to +5.18% | -0.79 to -0.72% |
| ARM64/2 | 262,145 | reference | -0.45 to +0.23% | -0.37 to -0.19% | -0.43 to +0.21% |
| AMD64/1 | 65,537 | fwp | +10.71 to +13.99% | -12.40 to -9.54% | +4.66 to +7.42% |
| AMD64/1 | 65,537 | reference | -1.26 to -1.15% | +2.92 to +3.47% | -1.04 to -0.84% |
| AMD64/1 | 262,145 | fwp | +12.98 to +15.21% | -4.37 to -3.29% | +7.96 to +9.77% |
| AMD64/1 | 262,145 | reference | -0.11 to -0.01% | +0.81 to +0.99% | -0.04 to +0.06% |
| AMD64/2 | 65,537 | fwp | +12.69 to +18.63% | -10.34 to -8.28% | +5.82 to +10.75% |
| AMD64/2 | 65,537 | reference | -0.67 to +0.01% | +2.49 to +2.80% | -0.42 to +0.15% |
| AMD64/2 | 262,145 | fwp | +12.26 to +13.03% | -3.79 to -3.53% | +7.67 to +8.02% |
| AMD64/2 | 262,145 | reference | -0.42 to -0.22% | +0.59 to +0.79% | -0.37 to -0.17% |

### Identical-copy controls

Largest percentage difference across both fwp implementations and all available
time scopes for that driver. The frozen limit is **2%**. Raw reports retain each
individual failed limit: eight in AMD64 session 1, five in session 2, all for the
small array. These failures are not dropped when reporting the driver effects.

| Host/session | Elements | Original | Observed | Preparation-capable, zero |
|---|---:|---:|---:|---:|
| ARM64/1 | 65,537 | 1.07% | 0.39% | 0.27% |
| ARM64/1 | 262,145 | 0.38% | 0.29% | 0.08% |
| ARM64/2 | 65,537 | 0.27% | 0.85% | 0.82% |
| ARM64/2 | 262,145 | 0.41% | 0.20% | 0.59% |
| AMD64/1 | 65,537 | 2.30% | 6.76% | 3.69% |
| AMD64/1 | 262,145 | 1.64% | 1.78% | 0.19% |
| AMD64/2 | 65,537 | 6.00% | 3.86% | 1.36% |
| AMD64/2 | 262,145 | 1.94% | 0.42% | 0.90% |

For the large AMD64 array, the first-copy consumption medians in microseconds
per array show the early-sample pattern. These are positions 1 through 5 in a
process, not five independent sessions. All other positions/copies are in
[all-roles.csv](all-roles.csv).

| Session | Driver | Sample 1 | Sample 2 | Sample 3 | Sample 4 | Sample 5 |
|---|---|---:|---:|---:|---:|---:|
| 1 | original | 273.27 | 255.85 | 248.07 | 246.54 | 246.74 |
| 1 | observed | 278.19 | 253.48 | 247.75 | 247.15 | 246.07 |
| 1 | preparation-zero | 250.60 | 249.10 | 246.54 | 246.76 | 246.62 |
| 2 | original | 274.48 | 255.11 | 248.15 | 247.50 | 246.90 |
| 2 | observed | 275.34 | 254.98 | 247.81 | 247.14 | 246.63 |
| 2 | preparation-zero | 252.26 | 247.54 | 247.74 | 246.57 | 246.30 |

Adding observations alone retains the early large-AMD64 pattern. The complete
zero-preparation driver changes it, but also makes construction slower: current
fwp consumes about 3.3–4.4% faster while enclosing work takes 7.7–9.8% longer.
On ARM64, the same driver change instead makes consumption about 4.5–5.4%
slower. Unchanged source-level numerical operations do not guarantee unchanged
compiled timing. These data identify a driver effect, not its exact CPU or
compiler mechanism and not a runtime safety defect.

## Storage and driver costs

Every version, implementation, size and session has the same managed counts.
Each row below is **one sample of eight arrays**. Peak storage is not divided
by eight: only one array is live at a time. Effective retains and non-final
releases are zero; final live storage is zero. Each sample has eight instrumented
release checks. Zero preparation performs no allocation or owner operation.

| Elements per array | Requests/sample | Requested bytes/sample | Peak managed bytes | Allocator chunk high-water bytes |
|---:|---:|---:|---:|---:|
| 65,537 | 8 | 4,194,432 | 524,304 | 589,824 |
| 262,145 | 8 | 16,777,344 | 2,097,168 | 2,162,688 |

The runtime reserves 68,761,485,312 virtual address bytes, including its metadata
reservation; this is **not committed RAM**. Separate whole-process RSS and
compiled driver costs follow. Ranges include both implementations and sessions;
RSS also includes each identical copy. These are diagnostic executables, not
production application size estimates. GCC reports fixed (`static`) ARM64 main
frames and AMD64 `dynamic,bounded` frames; neither is whole-program stack use.

| Host | Driver | RSS, small array (MiB) | RSS, large array (MiB) | Instruction bytes | Main frame bytes |
|---|---|---:|---:|---:|---:|
| ARM64 | original | 2.168 to 2.309 | 3.668 to 3.809 | 60732 to 60828 | 272 to 320 |
| ARM64 | observed | 2.184 to 2.309 | 3.668 to 3.809 | 60956 to 60988 | 608 to 656 |
| ARM64 | preparation-zero | 2.246 to 2.309 | 3.742 to 3.809 | 62332 to 62460 | 736 to 768 |
| AMD64 | original | 2.590 to 2.777 | 4.090 to 4.277 | 66498 to 66626 | 288 to 320 |
| AMD64 | observed | 2.594 to 2.781 | 4.094 to 4.281 | 66946 to 67074 | 624 to 640 |
| AMD64 | preparation-zero | 2.594 to 2.719 | 4.094 to 4.281 | 68418 to 68546 | 752 to 768 |

## Evidence and decision

All four full native archives and job logs pass independent audit. Four rejected
AMD64 hosts stopped at CPU qualification before compilation. Their reports and
logs remain in [index.json](index.json); no completed session was repeated.

| Session | Run / job | Artifact | Full local audit |
|---|---|---|---|
| ARM64/1 | [41483622413 / 125408109437](https://github.com/e6qu/fun-with-pipes/actions/runs/41483622413/job/125408109437) | `13160584315` | Pass, 4.51s |
| ARM64/2 | [41483622413 / 125408109314](https://github.com/e6qu/fun-with-pipes/actions/runs/41483622413/job/125408109314) | `13162246109` | Pass, 4.56s |
| AMD64/1 | [41483622413 / 125408109605](https://github.com/e6qu/fun-with-pipes/actions/runs/41483622413/job/125408109605) | `13162735018` | Pass, 4.63s |
| AMD64/2 | [41487610457 / 125421960114](https://github.com/e6qu/fun-with-pipes/actions/runs/41487610457/job/125421960114) | `13163836448` | Pass, 4.82s |

The [96-role table](all-roles.csv) retains absolute times, every consumption
sample position, all CPU/fault observations, managed counts, RSS, instruction
bytes and main frames. The [compact replay](../../../scripts/check-array-observation-records.py)
checks every raw sample and counter and regenerates that table exactly. Full
source, control and binary checks are performed by the
[native-archive auditor](../../../scripts/check-array-observations.py).

Measured source: `d1f18ff74727a62cffa85506fc912597a8a3d7e6`, tag
`roadmap/array-observation-runner-2026-11-02`. Native controls and exact result
bits pass for every driver before timing. Compact write/check replay passes
(2.96s / 3.13s guarded). This focused evidence does not replace final platform CI.

- Close this driver diagnostic without changing production ownership or adding
  hidden preparation. Additional clocks and preparation support are part of a
  different benchmark program, even when the reported numerical operations match.
- Keep PR #245's original timing failures and all 13 new small-AMD64 copy failures
  open. New diagnostic timings do not retroactively meet old acceptance rules.
- Future optimization comparisons must keep the complete driver identical across
  candidate/reference and report construction, consumption and enclosing work
  together. A faster consumption interval alone is insufficient.
