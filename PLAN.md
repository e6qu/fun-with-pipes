# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use automatic
reference counting (ARC) only for necessary sharing. Tracing garbage collection
has been removed. JIT compilation and backward compatibility are excluded.

## Current performance experiment: eliminate tape work for local objectives

Keep this work in PR #269. The user wants meaningful runtime improvements and
permits language/API changes. Small tape-layout changes did not establish their
required speedups; their [results remain evidence](docs/measurements/tape-record-results.md).

For an objective such as `edge(x0, x1) + edge(x1, x2)`, calculate each pair's
partial derivatives with existing `Dual` arithmetic, without a global tape or
handwritten derivatives. Write coordinate updates into an immutable packed array.
This is a structured algorithm, not a replacement for arbitrary `grad`.

The [first prototype](docs/measurements/local-derivative-time-2026-11-07/README.md)
is 24–31% faster than ordinary reverse AD on the largest input, but misses five
frozen timing limits. It also creates two temporary `Dual` records per edge.
The [source diagnosis and repair contract](docs/measurements/direct-numeric-workers.md)
identify computed arguments as the allocation blocker. Evaluate those arguments
once, in their original order, then pass the numeric fields directly. No new
syntax, function cloning or relaxed arithmetic rules are needed.

| Step | Concrete work | Required result |
|---|---|---|
| 1 | Remove temporary numeric input records through the existing all-callers compiler proof. | Preserve types, shared inputs, scopes, evaluation/trap order and numeric operations. Focused GCC ARM64/AMD64 and Clang ARM64 checks pass. |
| 2 | Measure complete solves with ordinary reverse AD, local forward AD, handwritten fwp arrays/lists, C and Rust. | Exact allocation-request/retain parity with handwritten fwp arrays, no extra managed peak, zero tape activity and zero final live storage. At least 20% faster long cases; at most 2% small-case regression and identical-copy variation. Two sessions per architecture. |
| 3 | Measure compiler costs and decide the public interface from verified results. | Seven representative inputs stay within 5% time/RSS and 2% copy variation. Promote the structured operation with examples only if its frozen runtime contract qualifies; otherwise diagnose the remaining cost without claiming acceptance. |
| 4 | Finish documentation, retain complete evidence and deliver the substantial batch. | Nine final-head native production jobs, docs and audits pass. Squash-merge with a verified one-line subject of at most 80 characters and an empty body. |

The [experiment](docs/measurements/local-derivatives.md) fixes workloads, flags,
hardware, timing scope and decision rules. Keep every missed limit and memory,
code-size and stack cost. Do not repeat unchanged qualified sessions to obtain
passing numbers. [The handoff](docs/development-state.md) has the current action
and exact source/run identities.

## Completed work carried in this PR

- The tape layout and checked capacity-call implementations are merged with
  native production validation. Their timing misses are retained, not relabeled.
- [All four tape-layout runtime archives](docs/measurements/tape-record-time-2026-11-07/README.md)
  pass the corrected release-control audit; all 48 peer/memory rows remain visible.
- [All 48 original images](docs/measurements/tape-record-images-2026-11-07/README.md)
  reproduce byte for byte. [All fourteen compiler-cost comparisons](docs/measurements/tape-record-analysis-2026-11-07/README.md)
  pass, with complete observations retained.
- [The carried production-log audit](docs/measurements/tape-record-delivery-2026-11-07/followup-268/README.md)
  passes. These older gates do not verify the new compiler change.

## Earlier measurements

[Unmet comparisons](docs/measurements/unmet-comparisons.md) preserve earlier speed
misses, small-case regressions and inconclusive copy controls. They are evidence,
not a queue of unchanged reruns. Broader ARC reduction needs a concrete
alias/lifetime proof and measured costs. Count-free arbitrary sharing, universal
stack storage and reclamation of every owning cycle are not goals.
[Swift comparisons](docs/measurements/swift-allocations.md) distinguish allocator
traffic from managed storage; Swift ARC counts remain unmeasured.

## Maintained guarantees and evidence

GC removal, scoped A1–A6 ARC reductions, F1–F3 call/recursion coverage, decimal-count
improvements, D3 derivative accuracy and #236's selected transformations are
verified deliveries. [Ownership](docs/ownership.md), [functional costs](docs/functional-costs.md)
and [history](docs/roadmap-history.md) record their scope. Keep their failure,
cancellation, reuse, application and binary checks as regression coverage.

The [intermittent Intel compiler abort](docs/measurements/compiler-abort.md) has no
established cause. Preserve evidence and diagnose a recurrence from its input
and source path. Passing reruns are not a repair.
