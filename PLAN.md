# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: reduce derivative callback result boxing

[PR #239](docs/roadmap-history.md#numeric-record-zipmap-fusion-pr-239) is verified
and merged. It removes temporary zipped numeric pairs. Larger measured solves
use 5.4–15.6% less elapsed time, but ten timing limits remain unmet. The user
approved retaining the allocation savings with those limits and D2 still open.

The next investigation starts from its [saved candidate counts](docs/measurements/derivative-record-zip-counts-2026-11-01.json.gz).
For 129 coordinates and 199 updates, current-vector form, GCC O2 and workspace
off, forward work still requests 155,420 allocations. Three generated callback
entries box direct numeric results 76,615 times: 25,671 at `f167` and 25,472 each
at `f127` and `f164` in the saved ARM64 C. These are source-specific identifiers,
not public APIs. Other costs include result-list construction and vector updates.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Trace remaining callback boxes to source callers and lifetimes | Explain each of the three entries, its consumers and escape boundary; compare all six cases, current/history forms, GCC O1/O2 and both native hosts using retained evidence |
| 2 | Select a safe transformation and freeze its requirements | Identify removable boxes and necessary result storage; publish exact count, cleanup, code/stack and timing limits before compiler edits; keep previous failed timing limits unchanged |
| 3 | Keep eligible callback results direct through their consumers | Extend existing worker/caller generation where proved safe; preserve effects, eager stage order, traps, aliases, empty inputs and failure/cancellation cleanup; update examples and docs |
| 4 | Verify and deliver one substantial batch | Run affected production-compiler checks, then native count/memory and paired timing comparisons; audit all nine final production jobs and documentation before squash merge |

Steps 1–2 are complete: all 96 saved observations agree on the selected boundary.
[PR #240](https://github.com/e6qu/fun-with-pipes/pull/240) implements the
[frozen selection](docs/measurements/derivative-record-folds.md): keep a known
left-fold accumulator in local numeric fields and leave list-stored results alone.
Step 3 awaits native correctness and cleanup results; step 4 awaits measurements
and final validation. No new allocation saving or speedup is verified yet.
Mapping must still finish before summation when interleaving changes recording
or trap order.

Use focused checks during implementation, then one complete final validation
batch. Reuse saved observations before scheduling measurements. Do not rerun
unchanged noisy timings to seek a pass, or treat count savings as a speedup.

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
