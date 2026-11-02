# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: reduce temporary derivative allocations

[PR #247](docs/roadmap-history.md#benchmark-driver-comparison-pr-247) is verified
and merged. Its benchmark-driver diagnostic is complete; original timing goals
remain open. No compiler/runtime change followed from that diagnostic.

[PR #248](https://github.com/e6qu/fun-with-pipes/pull/248) replaces eligible temporary mapped numeric-record lists with
one owned buffer. Mapping still finishes before folding, and seed evaluation
stays at its source position. See [design and boundaries](docs/design.md#temporary-mapped-numeric-records)
and [results](docs/measurements/derivative-temporary-storage-2026-11-02/README.md).

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Freeze the source baseline, selection and acceptance rules | Fresh counts; published protocol before compiler edits; same-source reference disables only the selected lowering |
| 2 | Implement packed temporary storage | Prove one consuming use; preserve map/seed/fold order, callback owners, effects, arithmetic and traps |
| 3 | Verify semantics, cleanup and measured storage | Interpreter/native comparisons; GCC/Clang O1/O2; empty/unequal inputs, aliases, excluded cases, traps, cancellation, allocation failures and deliberately missing destruction; all 96 count observations |
| 4 | Complete and audit the paired measurements | Two native sessions per architecture; unchanged drivers; all samples, rejected hosts, failures, C/Rust comparisons, RSS and code/stack costs retained |
| 5 | Deliver implementation, controls, evidence and docs together | One PR; all nine exact-head production jobs and documentation pass; audit every log, then verify the one-line squash merge |

Steps 1–3 pass focused native Linux verification. Each architecture passes 40
GCC/Clang tests. The largest current-only solve uses 51,143 fewer managed requests
and 4,064 fewer peak managed bytes; reference-count increments do not increase.

Step 4 is fully audited: all four sessions and four rejected hosts are retained.
Both ARM64 sessions and AMD64 session 1 pass. AMD64 session 2 retains a 2.024%
zero-update history regression against the 2% limit. Every case with at least
199 updates uses 5.1–14.2% less time; all identical-copy controls pass. Retain the
verified reductions and leave the failed timing goal open, as in prior deliveries.
Complete the PR's full final matrix. Fewer allocations do not
establish C/Rust parity or complete D2.

## Open performance goals

The next grouped compiler batch is the
[derivative owner-transfer investigation](docs/measurements/derivative-owner-transfers.md).
Its audited sites account for 98.7% of retains in the largest measured solve.
Freeze separate field-move and callback-borrowing proofs before implementation;
then check exact counts, failure cleanup, compiler cost and paired timings.
This preparation does not change PR #248's head or close its remaining gates.

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
