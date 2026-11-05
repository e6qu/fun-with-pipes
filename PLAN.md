# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use automatic
reference counting (ARC) only for necessary sharing. Tracing garbage collection
has been removed. JIT compilation and backward compatibility are excluded.

## Current work: exact scalar constants

[PR #260 is verified and merged](docs/measurements/packed-pair-delivery-2026-11-05/README.md).
Private pair-buffer reuse reduces allocation; its 34 timing misses remain open
below. The current group targets proved scalar constants without changing
allocation or derivative work.

The implemented group replaces proved immediate scalar values and aliases with exact
bits, avoiding lazy-cache reads. For example, `one` specialized to F64 is exactly
`1.0f64`; it does not need a mutable first-use flag. Arbitrary zero-argument
functions still may allocate, trap or perform effects and keep their behavior.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Share the bounded constant proof | Reuse packed-fold seed analysis; exact scalar types/bits, acyclic aliases and a finite proof budget. |
| 2 | Replace scalar reads and cache entries | Preserve evaluation order, tracing/resource boundaries and owned globals; no runtime tape-check changes. |
| 3 | Verify bits, effects and cache ownership | Interpreter/native agreement, O1/O2 probes, deliberate broken controls, prior packed-fold and cleanup coverage on three hosts. |
| 4 | Measure the complete programs | Unchanged allocation/node counts, parent reconciliation, compiler costs, two qualified runtime sessions per architecture and complete artifact audits. |
| 5 | Deliver the group | Pass nine final-head production jobs plus docs, audit every result and squash merge. |

[The contract](docs/measurements/scalar-constant-lowering.md) was committed at
`4bad4992` before implementation. Source review identified repeated scalar-cache
reads in generated numeric workers; it does not establish their machine cost.
C/Rust peers still use handwritten derivatives, so their whole-program comparison
cannot isolate language or ARC overhead. Keep all previous missed timing goals.
[The handoff](docs/development-state.md) records actual checks and the next action.

Focused native checks, the [allocation/stack audit](docs/measurements/scalar-constant-census-2026-11-05/README.md)
and [compiler-cost audit](docs/measurements/scalar-constant-analysis-2026-11-05/README.md)
pass. [Four runtime sessions](docs/measurements/scalar-constant-time-2026-11-05/README.md)
retain 27 missed speed targets; all other measured limits pass. Complete final
production verification and delivery remain.

## Open performance goals

Allocation reductions do not establish a speedup or lower process RAM. Preserve
all failed limits and inconclusive results. Do not repeat unchanged timings for
a passing result. A comparison with a new reference does not settle an older one.
Declare the source/workload diagnostic before changing code or measurement setup.
Here `3/199` means three coordinates and 199 updates. “Current” returns final
coordinates; “history” produces successive values and selects the last (unused
history can be optimized away). Copy controls compare identical executable bytes.

| Goal and evidence | What remains; next action |
|---|---|
| [Exact scalar constants](docs/measurements/scalar-constant-time-2026-11-05/README.md) | 27 of 32 long-case 5% targets remain open: all 16 ARM64 results; both AMD64 sessions' 3/199 and 3/1999 forms; AMD1 history 33/199 and 129/199; AMD2 history 33/199. Gains are 1.7–6.3%; small-case, copy, storage, stack and compiler limits pass. Inspect objective arithmetic/recording source and saved phase/work counts before selecting another transformation. Keep these original samples; do not rerun unchanged timings. |
| [Private pair reuse](docs/measurements/packed-pair-cleanup-time-2026-11-05/README.md) | The cleanup repair fixes the observed stack excess; all 32 long-case 5% targets remain unmet. AMD64 session 1 one-update current is 2.8315% slower; session 2 zero-update current is 2.2158% slower. Copy controls pass. Diagnose objective evaluation/recording work (73–75% of recorded phase time in the largest diagnostic case) before selecting another speed change. Remaining buffer sizes/lifetime constraints are [explicit](docs/measurements/packed-pair-cleanup-census-2026-11-05/README.md#remaining-storage-and-its-constraints). The first implementation's 23 timing misses remain separately recorded. |
| [Gradient-call storage](docs/measurements/gradient-call-time-2026-11-05/README.md) | Sixteen 33/199 and 129/199 results miss 5%; AMD64 session 2 3/0 current is 2.1822% slower, beyond 2%. All copy controls pass. Three-coordinate long solves improve 14.3–25.2%. The current pair-buffer group addresses one of the [two remaining recording allocations](docs/measurements/gradient-call-census-2026-11-05/README.md#remaining-storage) identified by producer/consumer lifetimes (together 2U requests, 32NU bytes). Separately review the zero-update source/driver path before declaring a new experiment. These are next investigations, not established causes. |
| [Consumed numeric storage](docs/measurements/owned-numeric-time-2026-11-05/README.md) | Four AMD64 5% targets remain open: session 1 3/199 current; session 2 3/199 current/history and 3/1999 current. Observed gains are 3.36–4.76%; copy controls pass. The [gradient-call group](docs/measurements/gradient-call-storage.md) passes focused checks and allocation audits. Compiler/runtime results and final production delivery are verified; a new comparison does not settle these earlier misses. |
| [Packed derivative inputs](docs/measurements/packed-input-time-2026-11-04/README.md) | AMD64 session 1 copy variation is 2.3628% / 2.7833% on 3/199 and 3/1999; session 2 slows 3/1 current by 2.3095%, against 2% limits. [Saved samples](docs/measurements/packed-input-time-2026-11-04/amd64-sample-review.md) establish no cause. Consumed-storage delivery is verified; retain these separate misses. |
| [Final-iteration compiler cost](docs/measurements/final-iteration-analysis-2026-11-04/README.md) | AMD64 field-owner transfer copy variation is 2.043% against 2%; other observed limits pass. Inspect retained sample/setup progression before proposing a new measurement. |
| [Final-iteration runtime](docs/measurements/final-iteration-time-2026-11-04/README.md) | Five history cases miss 5%: ARM64 3/199 and 33/199 in both sessions, plus AMD64 session 1 33/199. AMD64 session 2 slows 3/1 history by 2.79%. Compare small-case source and saved sample progression before selecting a repair. |
| [Identity array maps](docs/measurements/scalar-array-identity-time-2026-11-03/README.md) | All 32 required 5% gains remain unmet; copy controls and small-case regression limits pass. Use remaining allocation sites and lifetime proofs to choose the next reduction. |
| [Direct scalar array calls](docs/measurements/direct-array-time-2026-11-03/README.md) | Sixteen required 5% gains remain unmet. AMD64 session 2 3/1 current has 3.53% copy variation. Inspect source and saved samples before changing the protocol; larger gains do not close these cases. |
| [Gradient-array speed](docs/measurements/gradient-array-time-2026-11-03/README.md) | Every required 5% gain remains unmet; small repeated updates slow roughly 1–2%. PR #253 tested direct callbacks. Keep this original comparison open while measuring the remaining storage costs. |
| [Private index ranges](docs/measurements/range-zip-time-2026-11-03/README.md) | Seven cases improve only 3.97–4.98% against 5%. PR #252 addresses the gradient-list group; other [allocation sites](docs/measurements/range-zip-storage-2026-11-03/README.md#remaining-allocation-sites) need separate lifetime proofs and measured costs. |
| [Scalar buffers](docs/measurements/scalar-map-zip-time-2026-11-03/README.md) | Both ARM64 sessions slow zero-update current by 3.32%; small cases also miss 5%. Saved C changes only the positive-update branch. Diagnose source/driver behavior before attributing a cause; AMD64's small-case misses remain open too. |
| [Callback owners](docs/measurements/callback-owners-2026-11-03/README.md) | Both architectures miss 5% on 3/199 and 3/1999 in both forms; AMD64 33/199 current also misses. AMD64 3/1999 copy variation is 2.12–2.21%. Use saved phase/work counts to select the next change. |
| [AMD64 array consumption](docs/measurements/array-consumption-2026-11-02/README.md) | Large arrays are 4.93–5.23% slower despite passing copy controls; small-array copy controls fail. [Sample progression](docs/measurements/array-sample-positions.md) and [driver comparison](docs/measurements/array-observations-2026-11-02/README.md) establish no ownership repair. Keep the complete driver fixed; account for construction and consumption together. |
| [Small AMD64 matrices](docs/measurements/matrix-columns-2026-11-02/README.md) | Six copy controls fail at 2.6–8.3% against 2%. [Saved samples](docs/measurements/matrix-sample-positions.md) locate mismatch early in processes but establish no cause. Diagnose measurement setup before selecting an optimization. |
| [Derivative speed](docs/measurements/descent-costs.md) | Original 5% limits remain open; typed-owner savings do not settle ordinary F64 Rosenbrock speed. The array-to-list AMD64 copy result is still inconclusive. Preserve its samples rather than rerunning unchanged work. |
| [Numerical kernels](docs/measurements/kernel-baselines.md) | Diagnose timer resolution first. Keep qualified-host, arithmetic-order and identical-copy requirements before accepting a kernel optimization. |
| [Closure construction](docs/measurements/callable-phases.md) | Original Xeon regressions remain open. Freeze qualified work counts before choosing another candidate; a faster result on another CPU does not settle them. |

Broader ARC minimization needs an explicit alias/lifetime boundary and measured
costs. Count-free arbitrary sharing, universal stack storage and automatic
reclamation of every owning cycle are not goals.
[Swift comparisons](docs/measurements/swift-allocations.md) distinguish allocator
traffic from fwp-managed storage. Swift ARC operation counts remain unmeasured;
RSS and elapsed time cannot supply those counts.

## Maintained guarantees and evidence

GC removal, scoped A1–A6 ARC reductions, F1–F3 call/recursion coverage, decimal-count
improvements, D3 derivative accuracy and #236's selected transformations are
verified deliveries. [Ownership](docs/ownership.md), [functional costs](docs/functional-costs.md)
and [history](docs/roadmap-history.md) record their scope. Keep their failure,
cancellation, reuse, application and binary checks as current regression coverage.

The [intermittent Intel compiler abort](docs/measurements/compiler-abort.md) has
no established root cause. Preserve its evidence and diagnose a recurrence from
its input/source path. Passing reruns are not a repair, and speculative
disassembly-led allocator changes are not justified.
