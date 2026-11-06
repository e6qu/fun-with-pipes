# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use automatic
reference counting (ARC) only for necessary sharing. Tracing garbage collection
has been removed. JIT compilation and backward compatibility are excluded.

## Delivered: checked scalar append inlining

[PR #263 is verified and merged](docs/measurements/recording-inline-delivery-2026-11-06/README.md).
The compiler inlines the existing checked derivative-recording body. Validation,
allocation and cleanup are unchanged. All nine production jobs, documentation
and complete artifact/log audits pass; the merged tree matches the tested tree.

Long measured solves use 2.26–8.12% less elapsed time. Thirteen of 32 results meet
the frozen 5% target; 19 remain open. Small-case and copy limits pass. Allocations
and live storage are unchanged; maximum reported frame growth is 16 bytes on
ARM64 and zero on AMD64. One compiler-time copy control remains inconclusive.

## Current group: checked capacity calls

A derivative tape stores operations for the backward pass. Its buffers often
already have room for the next operation. The [saved native reports](docs/measurements/recording-inline-images-2026-11-06/README.md)
show that the capacity routine still requires a separate call in this case.
This is an observed call cost, not an established cause of earlier timing misses.

The [frozen contract](docs/measurements/recording-capacity.md) keeps the checked
no-growth path at the caller and shares the existing growth body. It preserves
both numeric and typed recording, bounds, allocation order and failure recovery.
The same-source reference reconstructs the previous runtime byte for byte.

[Focused native checks](docs/measurements/recording-capacity-checks-2026-11-06/README.md)
and complete audits pass. The [memory census](docs/measurements/recording-capacity-census-2026-11-06/README.md)
confirms unchanged work/storage and maximum frames. All 14
[compiler-cost comparisons](docs/measurements/recording-capacity-analysis-2026-11-06/README.md)
pass. [Runtime](docs/measurements/recording-capacity-time-2026-11-06/README.md)
shows 1.86–14.02% less elapsed time, with 17/32 long-case targets met. Fifteen
speed targets and one AMD64 copy control remain open; no timing was repeated.
The [audit repair](docs/measurements/recording-capacity-audit-repair-2026-11-06/README.md)
is verified by [116 tool tests](docs/measurements/recording-capacity-repair-controls-2026-11-06/README.md).
[Native verification](docs/measurements/recording-capacity-images-2026-11-06/README.md)
reproduces all 48 measured images and confirms capacity inlining. Next: final
production/documentation gates, complete audits and verified squash merge.

| Step | Concrete work | Required result |
|---|---|---|
| 1 | Retain PR #263 delivery and freeze the capacity-call change. | Verified merge tree/message, source safety proof and fixed comparison/limits before production edits. |
| 2 | Implement the checked gate, growth/failure controls and complete measurement tools. | Byte-exact reference reconstruction; clean format/lint; all focused GCC ARM64/AMD64 and macOS Clang checks plus complete artifact audits. |
| 3 | Run the combined memory, compiler and runtime comparison; verify native inlining. | All six cases and both forms; fixed qualified-host sessions, unchanged memory/work checks, compiler costs, original image hashes and complete audits. Retain every miss. |
| 4 | Deliver the complete group. | All nine final-head production jobs and docs pass; complete logs/artifacts audited; squash merge and actual tree/message verified. |

Run each qualified timing session once. Keep every older missed limit below;
a new reference cannot settle an earlier failed comparison. C/Rust peers use
handwritten derivatives, so their whole-program ratios do not isolate language
or ARC overhead. [The handoff](docs/development-state.md) records the exact next
action, source identities, current jobs and unresolved findings.

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
| [Capacity runtime](docs/measurements/recording-capacity-time-2026-11-06/README.md) | Fifteen three-coordinate long results miss 5%; only AMD2 3/1999 history meets it. All 16 larger-coordinate results pass. AMD2 3/1999 current has 2.2188% identical-copy variation against 2%, so that timing is inconclusive. All small-case limits pass. [Saved samples](docs/measurements/recording-capacity-time-2026-11-06/copy-review.json) show identical images and balanced positions, but the copy gap reverses between the two 49-round halves (1.02979 then 0.99344). Source/driver review must precede a new diagnostic; no cause or unchanged rerun is justified. Native inlining is verified; complete final delivery before choosing the next transformation. |
| [Scalar append runtime](docs/measurements/recording-inline-time-2026-11-06/README.md) | 19/32 long-case targets miss 5%: both architectures’ 3/199 and 3/1999 forms in both sessions, plus AMD64 history 33/199 in session 1 and 129/199 in both. Long gains are 2.26–8.12%; small-case/copy limits pass. Native inlining and final delivery are verified. The current capacity-call group follows the saved source/compiler review; its new comparison does not close these misses. No unchanged timing reruns. |
| [Scalar append compiler time](docs/measurements/recording-inline-analysis-2026-11-06/README.md) | AMD64 zero-update reference copies differ by 2.0494%, above 2%; all observed time/RSS ratios are below 1.05. Saved samples rise later in all four copies; copy identity and position are partly confounded. Preserve this inconclusive result. A future diagnostic must separate those factors; do not rerun unchanged timings for a pass. |
| [Recording lookup runtime](docs/measurements/recording-lookup-time-2026-11-06/README.md) | All 32 long-case 5% targets remain unmet. ARM64 ranges from 0.14% slower to 2.33% faster; AMD64 current-result cases slow by 1.13–3.90%, while history ranges from 0.40% slower to 1.80% faster. Small-case and copy limits pass. Lookup counts fall 8→3 per pair/update; allocations, live storage and reported frames stay unchanged. [Source and GCC review](docs/measurements/recording-call-analysis-2026-11-06/README.md) is complete; append-body inlining is delivered with its own separately recorded results. Preserve the original timings; the slowdown has no established cause. |
| [Recording lookup compiler time](docs/measurements/recording-lookup-analysis-2026-11-06/README.md) | AMD64 large callback worker is inconclusive: identical candidate copies differ by 2.854%, above 2%. All observed time/RSS ratios are below 1.05. Saved samples show later timings rising for all four copies; the two-order schedule partly confounds copy identity and position. Preserve the original failure. A future diagnostic must separate those factors before changing the setup; do not rerun unchanged timings for a pass. |
| [Exact scalar constants](docs/measurements/scalar-constant-time-2026-11-05/README.md) | 27 of 32 long-case 5% targets remain open: all 16 ARM64 results; both AMD64 sessions' 3/199 and 3/1999 forms; AMD1 history 33/199 and 129/199; AMD2 history 33/199. Gains are 1.7–6.3%; small-case, copy, storage, stack and compiler limits pass. Inspect objective arithmetic/recording source and saved phase/work counts before selecting another transformation. Keep these original samples; do not rerun unchanged timings. |
| [Private pair reuse](docs/measurements/packed-pair-cleanup-time-2026-11-05/README.md) | The cleanup repair fixes the observed stack excess; all 32 long-case 5% targets remain unmet. AMD64 session 1 one-update current is 2.8315% slower; session 2 zero-update current is 2.2158% slower. Copy controls pass. Diagnose objective evaluation/recording work (73–75% of recorded phase time in the largest diagnostic case) before selecting another speed change. Remaining buffer sizes/lifetime constraints are [explicit](docs/measurements/packed-pair-cleanup-census-2026-11-05/README.md#remaining-storage-and-its-constraints). The first implementation's 23 timing misses remain separately recorded. |
| [Gradient-call storage](docs/measurements/gradient-call-time-2026-11-05/README.md) | Sixteen 33/199 and 129/199 results miss 5%; AMD64 session 2 3/0 current is 2.1822% slower, beyond 2%. All copy controls pass. Three-coordinate long solves improve 14.3–25.2%. Delivered pair-buffer reuse addresses one of the [two remaining recording allocations](docs/measurements/gradient-call-census-2026-11-05/README.md#remaining-storage) identified by producer/consumer lifetimes (together 2U requests, 32NU bytes). Separately review the zero-update source/driver path before declaring a new experiment. These are next investigations, not established causes. |
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
