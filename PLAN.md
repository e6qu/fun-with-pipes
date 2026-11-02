# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: measure current numerical kernels

PR #242 is completing final production validation. Its numeric callback and
cleanup changes stay unchanged while the remaining gates run; merge only after
all nine jobs and documentation pass. This branch prepares the following batch
without opening a second PR.

The [current comparison](docs/measurements/current-kernel-costs.md#results-november-2-2026)
is measured and independently audited. All result/memory checks pass; four ARM
speed limits and nine AMD copy controls remain unmet. The old roughly 3.3-times-C
AMD array ratio predates typed state and must not describe current overhead.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Freeze current-kernel comparison and finish #242 | Preserve its exact-head CI audit and merge identity; publish the protocol before runner implementation |
| 2 | Built: paired measurement and evidence checks | Same-source reference, exact results, cleanup failures, six-role schedule and damaged-evidence controls pass |
| 3 | Measured: time, memory and code costs | Four sessions and seven prior host/check failures retained; independent audit `41407524129` passes |
| 4 | Publish understandable current costs and deliver | Update plan/docs with concrete remaining gaps; all final production jobs and documentation pass before squash merge |

Reuse existing kernel oracles and native harnesses. No new compiler optimization
is selected. Retain historical failures and make no current-speed claim from old
sources or representation alone.

## Next numerical task: explain the large-matrix gap

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
