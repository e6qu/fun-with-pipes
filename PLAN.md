# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: reduce array construction overhead

[PR #244](https://github.com/e6qu/fun-with-pipes/pull/244) passed all nine production
jobs and documentation, then merged as `e70f0e2d`. Its paired-column matrix loop
reduces qualified calculation time by about 33% on ARM64 and 31% for large AMD64.
[History](docs/roadmap-history.md#paired-matrix-columns-pr-244) records its storage,
stack and timing limits. The small AMD64 timing goal stays open below.

The [array construction protocol](docs/measurements/array-construction-costs.md)
now guides one coherent batch. Current materialized source and C-driver paths
allocate once; a fully composed generator/map/fold already allocates zero.
Materialized scalar captures still use generic callback dispatch. Measure its
cost before choosing a compiler change; preserve the composed allocation-free path.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Verify the three current construction paths | Verified: both GCC architectures at O1/O2, exact values, storage and missing-release controls; retained source and binary evidence |
| 2 | Separate construction, consumption and filling costs | Four sessions audited: both ARM64 and AMD64 session 2 pass; AMD64 session 1 retains six failed copy limits; compare source, driver, C and Rust |
| 3 | Select and prove a bounded generator change | If phase evidence justifies it, extend direct calls only to known scalar captures; preserve evaluation/trap order, reuse, partial failure, cancellation and composed fusion |
| 4 | Measure the change against its exact same-source reference | Freeze speed/storage limits before timing; require exact outputs and cleanup, retain all outcomes, report time, allocations, managed memory, RSS, code and stack costs |
| 5 | Deliver the combined batch | Bundle source, regressions, measurements and clear docs; all nine final-head production jobs plus documentation pass and are audited before squash merge |

Use the existing array ownership tests for capture/reuse/failure cases. Focused
production-compiler checks precede timing; run the full platform matrix after the
batch is ready. Avoid adding syntax, new allocation paths or compatibility layers.
If the measurement does not justify specialization, retain that finding and
choose the next source-level cost explicitly, without claiming an unproved gain.

## Open performance goals

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
