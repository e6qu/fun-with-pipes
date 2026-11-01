# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: explain the remaining forward derivative costs

[PR #238](docs/roadmap-history.md#direct-derivative-recording-pr-238) is verified
and merged. It removes recording argument records and transfers typed weights.
It does not identify the remaining costs in ordinary F64 gradient calculations.
Earlier timings place most derivative time in forward work, which includes
arithmetic, temporary values and recording. Treating all of it as tape overhead
would select the wrong optimization.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Freeze inputs, accounting boundaries and controls | Publish the [protocol](docs/measurements/derivative-forward-costs.md) before changing measurement code; retain #238 delivery evidence |
| 2 | Extend existing allocation and ownership observers with derivative phases | Six phases plus outside-phase work balance exactly with whole-program counters; retain source locations; missing rows and wrong phases fail |
| 3 | Measure the six Rosenbrock cases on native Linux ARM64/AMD64 | GCC O1/O2, current/history forms and workspace off/on; raw/ordinary/instrumented results agree, all storage is released, artifacts identify source/toolchains |
| 4 | Publish the explanation and select the next bounded change | Report dominant costs with examples and limits; freeze a specific candidate's semantics/count requirements before implementation; group any resulting change and its verification in this PR |

The protocol defines exact inputs and required observations. Reuse the existing
whole-program, ownership-site and derivative-boundary code; do not add a parallel
profiler framework. These are count measurements, not a new timing acceptance rule.
D2 remains open. A measured cost is not proof that it can safely be removed.

Run focused observer controls during implementation. Run native measurements on
GitHub after the observer is complete, then batch affected checks for any selected
compiler/runtime change. Run the full nine-job matrix and documentation once the
whole batch is ready. Audit every failure and completed target before merging.

## Open performance goals

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
