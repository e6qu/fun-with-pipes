# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: move derivative weights into the tape

[PR #237](docs/roadmap-history.md#typed-derivative-owners-and-documentation-pr-237)
passed all nine production jobs and documentation. It removed temporary typed
recording records and redundant adjoint owners. Recording still retains each
weight before the caller drops its owner. The next change transfers those owners
instead, and removes the recording argument record from both scalar and typed APIs.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Close the merged batch and freeze the recording contract | Preserve #237 evidence; document argument order, ownership, failure and count requirements before implementation |
| 2 | Pass recording arguments directly and move typed weights | Update library, interpreter, C generation and runtime together; preserve arithmetic, evaluation and trap order |
| 3 | Verify ownership transfers and update callers/docs | Raw/native results, aliases, inactive nodes, growth, stale/mixed nodes, failure and cancellation pass; inventory and measured owner counts agree |
| 4 | Verify and deliver the complete batch | Focused GCC/Clang O1/O2 checks, evidence audit, nine exact-head production jobs and documentation pass before squash merge |

The [recording protocol](docs/measurements/derivative-recording-moves.md) defines
specific acceptance. A 256-operation chain must create no recording argument
records with stack promotion either enabled or disabled. Typed recording must
perform zero weight retains: each weight enters with one owner, which moves to
the tape or is released when no node is recorded. Shared caller aliases keep
their separate owners. Failure before publication releases both incoming owners.

No new syntax, public optimization switch, compatibility wrapper or implicit
conversion is needed. Functions remain curried and single-argument. Update
manual recording examples and frozen-inventory exceptions explicitly. Retire
the old current-source record-allocation comparison when its representation no
longer exists; retain its historical results and acceptance checker.

The [focused results](docs/measurements/derivative-recording-moves.md#focused-results)
pass steps 2–3, including the repaired arithmetic allocation regression. Step 4
still requires the full final-head matrix and merge.

Full builds and suites run on GitHub after the batch is complete. Local checks
use the unchanged resource guard. Audit every failing job/target before batching
repairs. Keep one active PR; squash with one subject of at most 80 characters and
an empty body after every final-head gate passes. Counts alone prove no speedup.

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
