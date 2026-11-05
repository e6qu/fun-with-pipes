# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use automatic
reference counting (ARC) only for necessary sharing. Tracing garbage collection
has been removed. JIT compilation and backward compatibility are excluded.

## Current work: reuse the private pair buffer

[PR #259 is verified delivery](docs/roadmap-history.md#gradient-call-storage-pr-259):
all nine production jobs, documentation and complete log audits pass. Its four
changes remove temporary storage around gradient calls. The 17 timing misses
remain open below; allocation savings do not establish speed or process RAM gains.

The next group reuses the numeric input buffer after neighboring records have
been read, instead of allocating a separate pair-result buffer:

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Transfer the private input owner | Keep borrow inference, escape analysis and cleanup consistent with returning the allocation. |
| 2 | Reuse equal-width numeric storage | Preserve eager callback order, immutable aliases and physical allocation charge; other widths allocate. |
| 3 | Verify both storage paths | Both orientations, numeric bits, empty inputs, failure/cancellation, no-reuse and deliberately broken cleanup observers on three focused hosts. |
| 4 | Measure complete work and memory | Exact repeated/fresh allocation counts, phase/overall peaks, compiler costs and two qualified runtime sessions per architecture. Reconcile the allocating reference with the parent before timing. |
| 5 | Deliver the group | Fix all encountered issues, retain full evidence, pass nine final-head production jobs plus docs, audit logs and squash merge. |

Steps 1–3 pass [corrected focused native checks](docs/measurements/packed-pair-cleanup-checks-2026-11-05/README.md).
The [original checks and full audits](docs/measurements/packed-pair-checks-2026-11-05.md)
remain separate from the changed-source verification.
[The contract](docs/measurements/packed-pair-storage.md), frozen before implementation
at `3b7954eef411b7b621d09718ae2aad41e72e744e`, fixes the proof and measurement limits.
[The allocation census](docs/measurements/packed-pair-census-2026-11-05.md) passes
on both architectures, including agreement with saved parent counts. Compiler
cost limits and saved-data audits also pass. Three [runtime sessions](docs/measurements/packed-pair-time-2026-11-05/README.md) expose 23
missed speed targets and one AMD64 stack-budget failure. Apply the
[single-owner cleanup repair](docs/measurements/packed-pair-cleanup-repair.md),
verify stack/storage costs before new timing, then finish production verification.

For a fresh 129-coordinate/199-update solve, observed requests are 727 -> 528
and requested bytes 1,034,366 -> 625,222. Reuse keeps the original capacity until
the fold finishes. Overall peak managed storage does not grow; final storage is zero.
Keep one active PR and all older missed timing goals. The [handoff](docs/development-state.md)
records exact sources, runner requests, failures and the next action.

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
