# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: reduce remaining temporary list storage

[PR #249](docs/roadmap-history.md#numeric-callback-owner-transfers-pr-249) is
verified and merged. It removes 98.7% of retains in the largest saved solve. It leaves
allocation traffic unchanged: 154,952 of 156,943 requests use the 24-byte
record/list constructor. Its missed timing goals remain open below.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Attribute remaining constructors to their actual callers — verified | All 96 native GCC observations match prior counts/output/work and zero final storage. Constructor controls, reconstructed sources, images and full logs pass. [Evidence](docs/measurements/temporary-list-census-2026-11-03/README.md). |
| 2 | Freeze one storage change supported by those counts — selected | [Contract](docs/measurements/temporary-list-storage.md#selected-storage-change): scalar map buffer consumed by one zip-with; explicit alias, effect and cleanup rules. Predicted reduction: `(d+1)*u` allocations. Publish the same-source reference implementation before measurement. |
| 3 | Implement and verify the selected change | Ordinary/unoptimized interpreter versus native GCC/Clang O1/O2; direct/shared/escaping/empty/unequal-length inputs; failure, cancellation and allocation controls; exact saved-source counts and cleanup; bounded compiler analysis. |
| 4 | Measure and deliver the whole batch | Fixed complete-driver comparison and qualified hosts; compiler time/RSS, managed/raw storage, RSS, code/frame costs; preserve 2% copy/regression and 5% speed limits. One substantial PR, all nine exact-head production gates plus docs, audited logs and verified one-line squash. |

The census verifies that `grad ... | map scale` creates `d*u` adjustment-list
cells used only by `zip-with sub`. Replace those cells with a private numeric
buffer and remove zip's extra input copy, preserving eager callback order and
input aliases. The [frozen contract](docs/measurements/temporary-list-storage.md)
defines selection, cleanup and count predictions. Do not interleave the stages.

Use saved evidence and focused checks during development. Run one grouped final
measurement/validation after the implementation and its controls are ready.
Do not rerun unchanged noisy timings or change acceptance limits for a pass.

## Open performance goals

- **Callback-owner timings.** [The complete report](docs/measurements/callback-owners-2026-11-03/README.md)
  retains every outcome. Both architectures miss 5% on 3/199 and 3/1999 in both
  forms; AMD64 33/199 current also misses it. AMD64 3/1999 copy variation is
  2.12–2.21%, so that comparison is inconclusive. Keep the verified count
  reductions and larger-case speed gains, following the accepted policy; do not
  relabel missed limits as passed. Diagnose remaining allocation/work costs and
  the noisy case from saved phase/sample evidence before choosing another change.

- **AMD64 array consumption.** The original large-array copy controls pass,
  but consumption is 4.93–5.23% slower; small-array copy limits also fail.
  [Sample analysis](docs/measurements/array-sample-positions.md) and the
  [completed preparation diagnostic](docs/measurements/array-consumption-2026-11-02/README.md)
  preserve those failures. The [driver comparison](docs/measurements/array-observations-2026-11-02/README.md)
  separates observation changes from the complete preparation-capable driver. It
  justifies no ownership change and does not resolve original timing acceptance.
  Keep the entire driver fixed for future candidate/reference comparisons and
  report construction, consumption and enclosing work together.
- [Small AMD64 matrix timing](docs/measurements/matrix-columns-2026-11-02/README.md):
  six identical-copy failures remain at 2.6–8.3% against the frozen 2% limit.
  [Retained-sample analysis](docs/measurements/matrix-sample-positions.md) locates
  much of the mismatch in early within-process samples, without establishing its
  cause. Declare a setup/sample-progression diagnostic before changing the timing
  protocol. Do not repeat unchanged timings or
  infer a runtime safety bug from these timing differences. ARM64 and large AMD64
  gains do not settle this separate case.
- [D2 derivative speed](docs/measurements/descent-costs.md): original 5% limits
  remain open. Typed-owner count reductions do not settle the ordinary F64
  Rosenbrock timings. The array-to-list change's AMD64 copy control also remains
  inconclusive; do not repeat unchanged noisy runs for a pass.
- [N1/N2 numerical kernels](docs/measurements/kernel-baselines.md): preserve
  qualified-host, arithmetic-order and identical-copy requirements. Diagnose
  measurement resolution before accepting an optimization on those cases.
- [Closure construction](docs/measurements/callable-phases.md): retain the original
  Xeon regressions; another CPU does not settle them. Freeze qualified work counts
  before selecting a new candidate.
- Broader ARC minimization needs specific escaping/alias boundaries and measured
  costs. There is no goal of count-free arbitrary sharing, universal stack storage
  or automatic reclamation of all owning cycles.
- [Swift comparisons](docs/measurements/swift-allocations.md) measure allocator
  traffic and selected fwp-managed storage separately. Individual Swift ARC
  operations remain unmeasured. Do not infer them from RSS or elapsed time.

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
