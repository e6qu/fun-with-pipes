# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: investigate matrix calculation costs

[PR #243](https://github.com/e6qu/fun-with-pipes/pull/243) publishes the completed
current-kernel comparison. Keep its final head unchanged during production
validation and merge only after all nine jobs and documentation pass. This
independent branch prepares the matrix work; do not open a second PR.

The [matrix protocol](docs/measurements/matrix-calculation-costs.md) selects the
paired-column loop after exact GCC diagnostics. Focused safety checks precede
timing; no speed improvement is accepted yet.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Publish source findings and diagnostic protocol | Retain the preparation before runner edits; preserve #243's final-head checks |
| 2 | Inspect current generated C with production GCC | Original binaries reproduce byte for byte; all outputs/cleanup agree; both architectures and all compiler diagnostics audited |
| 3 | Select and prove one bounded source change | Freeze exact reference and timing scope; pass alias, arithmetic, shape, failure and cancellation probes |
| 4 | Measure both matrix sizes and retain every outcome | Two sessions per declared architecture, independent copy controls, time/memory/code/frame costs and all failed limits |
| 5 | Publish the coherent batch and verify delivery | Readable results and plan updates; full final-head matrix/docs pass before squash merge |

## Matrix acceptance

The qualified 257×259 by 259×255 case takes about 65% more calculation time than
C on AMD64 and 6% more on ARM64. Zero effective retains and near-payload storage
make this a computation investigation, not an unspecified ARC-removal task.

1. Compare `fwp_p_matrix_mul_f64` in `runtime/fwp_rt_kernel.c` with the exact C/Rust
   peers. Inspect emitted source, loop bounds, address calculations and scheduler
   polls. Identify a causal source difference; do not infer a repair from disassembly.
2. Freeze one bounded candidate and its same-source reference before timing.
   Preserve increasing inner-index multiplication/addition order, no contraction,
   legal byte-copy access, input aliasing, shape checks and cancellation cleanup.
   No new allocator, wrapper, scratch matrix or backend is assumed necessary.
3. Extend `blocked_matrix` and its existing native probes for that change. Require
   raw-interpreter/native O1/O2 agreement, empty/odd sizes, shared/sliced inputs,
   invalid shapes, exceptional floating-point values and deliberate unwind failures.
4. Measure both matrix sizes and full construction-through-cleanup on both declared
   architectures, with independent copies and frozen work counts. Require at least
   5% less large-matrix calculation time on AMD64, no case/scope more than 2% slower,
   and no allocation/retain/peak-storage increase. Failed controls remain evidence;
   revise the measurement design explicitly before any new experiment.
5. Bundle the proven change, regressions and readable costs into one PR. If no safe
   candidate meets the rules, retain the rejected result and choose a different
   source-level cause; do not ship a speculative optimization as a speed improvement.

ARM64 array allocation-through-cleanup costs 24–31% more than C despite a fast
reduction loop. This includes a C driver's fwp-runtime calls, not source-compiled
`array.generate`. After the matrix task, compare both input-construction paths
and separate filling from allocator/cleanup time in a declared measurement before
selecting any compiler change.

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
