# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use automatic
reference counting (ARC) only for necessary sharing. Tracing garbage collection
has been removed. JIT compilation and backward compatibility are excluded.

## Delivered: checked tape capacity calls

[PR #264 is verified and merged](docs/measurements/recording-capacity-delivery-2026-11-06/README.md).
The compiler keeps the checked no-growth path at its caller and shares the
unchanged buffer-growth body. All nine production jobs, docs and complete audits
pass. The merge tree equals the tested tree; the squash message is one line.

Long measured solves improve by 1.86–14.02%. Seventeen of 32 speed targets meet
5%; fifteen remain open, along with one AMD64 identical-copy limit. Allocation,
validation and live-storage counts are unchanged. All compiler comparisons pass;
maximum reported frames are unchanged. These results do not close earlier misses.

## Current group: contiguous tape operation records

PR #267 is merged at `621653b6394f49dc229a2956b6b61476c82c9aac` with the same tree
as its tested head. All nine production jobs, documentation and the
[focused artifact audit](docs/measurements/tape-record-checks-2026-11-06/README.md)
pass. Implementation and focused correctness are complete. Runtime/compiler
[measurements](docs/measurements/tape-record-results.md) are complete: all 32
long-case speed targets remain unmet; all 14 compiler-cost comparisons pass.
The [complete runtime audit and detailed memory/peer tables](docs/measurements/tape-record-time-2026-11-07/README.md)
are complete. [All 48 original measured images are verified](docs/measurements/tape-record-images-2026-11-07/README.md). The [complete production-log audit](docs/measurements/tape-record-delivery-2026-11-07/README.md)
also passes. The required 5% layout speedup is not established.

The shared-access group (#265–#266) is merged. All four runtime sessions and
archive audits are complete; 30 of 32 long-case targets remain open, alongside
two AMD small-case regressions and one inconclusive copy comparison. All 48
original images reproduce exactly. The compiler-change production run passed
all nine jobs; [its complete artifact audit is verified and retained](docs/measurements/recording-context-delivery-2026-11-06/README.md).
#266's merged-source CI also passes all nine jobs and docs.

The [new experiment](docs/measurements/tape-operation-records.md) stores each
numeric tape operation's parents and weights together. The [source investigation](docs/measurements/recording-context-next-layout.md)
identifies four columns, two allocations and growth-time column moves. Saved
large-case phases locate most derivative work in recording and reverse traversal;
they do not prove a cache problem or a layout speedup.

| Step | Concrete work | Required result |
|---|---|---|
| 1 | Delivered in #267: numeric records and typed parent pairs with explicit owners. | 24-byte numeric and 8-byte parent records, checked operation capacities, unchanged arithmetic and failure order. |
| 2 | Verified: allocation, moving-growth, cleanup and wasm32 probes. Keep as regression coverage. | Interpreter/native parity, exact ownership on return/trap/cancellation, negative controls and complete target audits. |
| 3 | Verified: retain candidate/reference storage, runtime and compiler costs, including all missed targets. | Frozen sources; unchanged representative inputs/flags/limits; report absolute C/Rust costs and preserve all misses. |
| 4 | Verify measured binaries, final platforms and documentation, including carried repairs. | Nine final-head production jobs, docs and complete audits pass; verify squash tree and one-line message. |

Keep the completed shared-access measurements unchanged. Its numeric-call and
loop scopes remain enabled in both versions. [The handoff](docs/development-state.md)
records exact source/run identities and the current next action.

## Current performance experiment: eliminate tape work for local objectives

The user requested meaningful performance gains and permits language/API changes.
Keep this work in PR #269 with the pending evidence repairs. The
[structured derivative experiment](docs/measurements/local-derivatives.md)
is frozen at `524524bd3`: expose each two-coordinate objective term and use
existing `Dual` arithmetic locally, without a global reverse tape or handwritten
derivative. The initial implementation is a fixture, not a public API.

1. Check endpoints, empty/singleton inputs, aliases, nonlinear derivatives and
   traps against the unoptimized interpreter on GCC ARM64/AMD64 and Clang ARM64.
2. Compare full solves with ordinary reverse AD, handwritten fwp lists/arrays,
   C and Rust using the same driver. Require 20% long-case gains, <=2% small-case
   regression and <=2% identical-copy variation; retain all misses and costs.
3. If qualified, promote the structured operation with clear examples and
   regression coverage. Otherwise inspect the actual costs before choosing a
   compiler or representation change. Do not publish an unproven performance API.
4. Complete final-head platform/doc gates and retained audits before merging.

This is a structured algorithm for neighboring interactions, not a promise of
zero-storage derivatives for arbitrary programs. Existing `grad` semantics remain
unchanged. [The source investigation](docs/measurements/tape-record-next-work.md)
explains why direct comparison within fwp is necessary.

## Earlier measurements

[Earlier unmet comparisons](docs/measurements/unmet-comparisons.md) retain every
failed timing limit, small-case regression and inconclusive identical-copy
result, with source evidence and investigation notes. None is relabeled as a
pass. Keep them as evidence while pursuing the substantial current experiment;
do not spend more sessions tuning the appearance of old measurements.

Broader ARC minimization needs an explicit alias/lifetime boundary and measured
costs. Count-free arbitrary sharing, universal stack storage and automatic
reclamation of every owning cycle are not goals.
[Swift comparisons](docs/measurements/swift-allocations.md) distinguish allocator
traffic from fwp-managed storage. Swift ARC operation counts remain unmeasured;
RSS and elapsed time cannot supply those counts.

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
