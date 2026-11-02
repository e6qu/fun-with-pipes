# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: direct calls through numeric record bindings

#240/#241 implement direct numeric fold accumulators. [Their measured results](docs/measurements/derivative-record-folds.md)
show allocation reductions and 5.8–7.8% faster larger solves. The user merged #241
with its missed speed/size limits still open. Its full production matrix exposed missing test roots and a callback-unwind
leak; repair both in this batch and audit the remaining jobs. A merge alone is not verification.

The next concrete gap is source-form dependent code generation: tuple
destructuring hides a known call behind field bindings, while equivalent explicit
projections allow a direct numeric worker. Fix that local simplification without
changing function stages or retaining escaping records longer.
[Scope and requirements](docs/measurements/numeric-callback-bindings.md) define the
proof, excluded values and exact checks before implementation.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Confirm the source/IR boundary and record requirements | Retain the indirect-call example and freeze the local binding proof before compiler changes; record #241 merge and unresolved limits |
| 2 | Expose known calls through safe record-field bindings | Preserve binding/argument order and ownership/resource guards; repair cleanup installed after inline callback execution; keep global purity and constructor stages |
| 3 | Verify semantics, counts and cleanup together | Tuple/named-record cases, aliases, empty inputs, effects, rejected shapes, exact final-box counts, failure/cancellation and omitted-release controls pass on native GCC/Clang |
| 4 | Complete platform validation and delivery | Audit #241 full CI, repair all encountered issues, update docs and pass all nine final-head production jobs plus documentation before squash merge |

Reuse saved evidence and existing probes. Run focused checks during implementation,
then one final full matrix for the complete batch. No new timing run is needed for
an allocation/call-removal claim; earlier noisy or failed timings remain evidence.

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
