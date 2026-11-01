# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: remove temporary zipped numeric records

[PR #238](docs/roadmap-history.md#direct-derivative-recording-pr-238) is verified
and merged. It removes recording argument records and transfers typed weights.
It does not identify the remaining costs in ordinary F64 gradient calculations.
Earlier timings place most derivative time in forward work, which includes
arithmetic, temporary values and recording. Treating all of it as tape overhead
would select the wrong optimization.

The phase/source measurements now pass and are audited on both native Linux
architectures. They identify temporary zipped records as a concrete allocation
and ARC cost. Extend existing zip/map fusion to flat records of immediate numeric
fields, including `Rev[F64]`, under the
[frozen acceptance rules](docs/measurements/derivative-forward-costs.md#candidate-acceptance-frozen-before-compiler-edits).

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Freeze inputs, accounting boundaries and controls | Publish the [protocol](docs/measurements/derivative-forward-costs.md) before changing measurement code; retain #238 delivery evidence |
| 2 | Extend existing allocation and ownership observers with derivative phases | Six phases plus outside-phase work balance exactly with whole-program counters; retain source locations; missing rows and wrong phases fail |
| 3 | Measure the six Rosenbrock cases on native Linux ARM64/AMD64 | GCC O1/O2, current/history forms and workspace off/on; raw/ordinary/instrumented results agree, all storage is released, artifacts identify source/toolchains |
| 4 | Remove temporary zipped flat numeric records and verify the batch | Implement the frozen selection, semantic/ownership controls, six-case count comparison and paired timing; complete nine production jobs and documentation before merging |

The protocol defines exact inputs and required observations. Reuse the existing
whole-program, ownership-site and derivative-boundary code; do not add a parallel
profiler framework. These are count measurements, not a new timing acceptance rule.
D2 remains open. A measured cost is not proof that it can safely be removed.

The candidate now passes native Linux ARM64/AMD64 correctness, ownership and all
96 count observations. Its largest current-only solve saves 51,143 allocation
requests and 76,416 effective retains, with lower peak managed memory and no
larger static frame. [Results and limits](docs/measurements/derivative-forward-costs.md#verified-allocation-and-ownership-results)
are explicit. All four completed timing sessions miss the 5% speed target on the
one-update case; AMD64 reports 2.54% and 2.72% zero-update regressions, above the 2%
limit. Every session's saved observations pass independent archive audits.
Diagnostic clocks place all reference forward work at
only 4.4–4.9% of process time in the one-update case, suggesting this selected
change's 5% whole-process target was too aggressive. The clocks perturb execution;
this is evidence about scope, not permission to weaken the target. The zero-update
slowdown remains unexplained. GCC diagnostic run `41337215456` reproduces all
four measured zero-update executables and outputs exactly. Both current-only
optimized entry bodies already omit the derivative loop and match after
generated temporary/cleanup names are accounted for. This supplies no justified
source-level repair and does not establish identical machine code or timings.
These failed requirements remain unmet; retaining the optimization on allocation
evidence alone needs an explicit acceptance decision. The complete production
gates remain open.

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
