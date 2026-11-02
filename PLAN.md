# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: remove temporary derivative owners

[PR #248](docs/roadmap-history.md#packed-temporary-numeric-records-pr-248) is verified
and merged. It reduces temporary allocations; its failed zero-update timing goal
remains open. The next grouped batch targets reference-count operations left in
those callbacks. [Measured sites](docs/measurements/derivative-owner-transfers.md)
account for 76,416 of 77,411 retains in the largest saved solve; that is an
opportunity, not a promised reduction or speedup.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Move complete groups of already-separated field owners | Published selection/protocol; GCC/Clang O1/O2 direct/boxed/shared, failure/cancellation and broken-cleanup controls; remove at least one retain per differentiated pair |
| 2 | Remove unnecessary callback input owners | Freeze the numeric-leaf or borrowed-call proof before implementation; preserve input lifetime, callback order and owning entries that still need owners |
| 3 | Verify the combined costs and compiler work | All 96 count observations; attribute savings to exact sites; no managed/raw storage growth, zero final storage; bounded analysis and measured compilation costs |
| 4 | Measure whole-solve performance | Same-source reference, fixed drivers, two qualified sessions per architecture; preserve 2% copy/regression and 5% large-case limits, all samples and failures |
| 5 | Deliver the complete batch | One substantial PR with code, controls, evidence and clear docs; all nine exact-head production gates and documentation; audited logs and verified one-line squash |

Step 1's first native checks exposed an index tied to the wrong expression tree.
The repair uses the exact emitted body and passes both native GCC/Clang suites
and all 96 count audits. It removes exactly one retain per differentiated pair.
Step 2 passes all 96 count and exact-site audits. The repaired local-callee
fixture passes the short source/IR/native selection probe. Complete its focused
GCC/Clang checks on both hosts, then run the prepared compiler and runtime experiments. Run focused checks while
implementing; complete the full platform matrix once the related batch is ready.

## Open performance goals

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
