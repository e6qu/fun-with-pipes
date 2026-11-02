# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: measure current numerical kernels

PR #242 is completing final production validation. Its numeric callback and
cleanup changes stay unchanged while the remaining gates run; merge only after
all nine jobs and documentation pass. This branch prepares the following batch
without opening a second PR.

The old AMD64 array slowdown predates typed floating-point loop state in #227.
Establish current costs and isolate that existing transformation with a same-source
word-state reference. The [protocol](docs/measurements/current-kernel-costs.md)
fixes workloads, settings, controls and decision rules before measurements.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Freeze current-kernel comparison and finish #242 | Preserve its exact-head CI audit and merge identity; publish the protocol before runner implementation |
| 2 | Build the paired measurement and evidence checks | Same-source reference, exact results, cleanup failures, six-role schedule and damaged-evidence controls pass |
| 3 | Measure time, memory and code costs | Both sessions on both qualified architectures retained; audit every result, control and failed threshold |
| 4 | Publish understandable current costs and deliver | Update plan/docs with concrete remaining gaps; all final production jobs and documentation pass before squash merge |

Reuse existing kernel oracles and native harnesses. No new compiler optimization
is selected. Retain historical failures and make no current-speed claim from old
sources or representation alone.

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
