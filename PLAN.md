# Plan

fwp implements the Pipe Language Compact Specification. [Design](docs/design.md)
records the semantics and implementation. [The handoff](docs/development-state.md)
records current work, exact heads, failures and validation; [the queue](docs/roadmap-queue.md)
records immutable preparation anchors. [History](docs/roadmap-history.md) preserves
prior deliveries and measurements, without supplying new priorities.

## Authorized execution

Complete this roadmap automatically, one focused PR at a time. Fix failing tests;
CI gates merging, not implementation or next-task preparation. Full builds,
tests, benchmarks and large regeneration run on GitHub. Require all six passing
jobs for the current exact PR head before squash. Supply a single-line subject
of at most 80 characters and an empty body, with no trailers or attribution.
Update the handoff and queue after meaningful progress. This authorization
persists across sessions and compactions; no repeat approval is required.

## Direction and acceptance

Preserve tacit, curried, data-last pipes, immutable values, tracked effects,
checked arithmetic and observable evaluation/trap order. Infer ordinary types
strongly; retain explicit generic signatures and compile-time specialization.
Prefer internal ownership over new language syntax. Compare the interpreter
and native semantics; optimizer oracles must use `FWP_NO_OPT=1` explicitly.

The aim is efficient machine code with few heap allocations, natural numeric
storage, suitable alignment and effective register/cache use. Tracing remains a
compatibility fallback until ownership coverage and cycle policy justify an
optional tracing-free mode. Prepared branches do not establish merged support.

| Order | Status and work | Acceptance |
|---|---|---|
| 1 | Done: native macOS ARM/Intel support (#74) | Full platform gates; real collection; interpreter/native agreement; explicit unsupported options |
| 2 | In progress: runtime ownership, borrowed boundaries, text/bytes, closures and exceptional lifetimes | Checked aliases/callbacks/unwind; fewer counts without lost roots or more allocation; immediate reclamation evidence |
| 3 | Pending: natural-width contiguous numeric storage, views, aggregate/scalar ABI and alignment | Narrow elements use natural width; fewer copies/boxes; arm64/x86-64 allocation/assembly evidence; ABI/FFI checks |
| 4 | Pending: fused numerical loops, blocked matrices, autodiff lifetimes and reusable buffers | Correct gradients and exceptional cleanup; equivalent C/Rust workloads; fixed floating-point behavior by default |
| 5 | Pending: broaden ownership/performance regression evidence | Allocations, live memory, counts and collections alongside timing, hardware/compiler/flags recorded |
| 6 | Pending: optional tracing-free execution after coverage | Supported programs reclaim without collection, including escapes/runtime boundaries; explicit cycle lifetime policy |

## Current delivery

Main includes #74–#86: native macOS, primitive contracts, owned leaves/text,
compiled closures, closure cleanup, concrete argument temporaries, stack children,
borrowed synchronous callbacks, map, filter, fold and zip results. Exact merge/run evidence
is in the handoff. Zip passed all six CI `37733658893` gates and merged. Right-fold
is sole PR #87; validate the queue in order after each preceding squash.

Separate evidence has restored baseline root/cache/tutorial fixes and the real
wide-record boxing repair. Its unchanged full allocation test passes on Linux
and both macOS architectures; all six full evidence jobs now pass. Each
sequential PR still needs its own full gates. Keep repairing failures.

Phase 2 remaining audits: borrowed resource metadata roots, reconstructed/untyped
aggregate ownership, general resource discard and teardown, retained callbacks
and cycles. Prepared resource/unwind improvements require sequential full CI.
Finish phase 2 before numeric representation, numerics/autodiff and optional
tracing-free work. Windows, new deployment interfaces and a new backend remain
deferred unless the user changes priorities.

## Validation limits

Local focused workloads are serial, low priority, sampled and bounded: 1 GiB
aggregate RSS, target data below 2 GiB, at least 64 GiB free disk and 180 seconds.
Use the fwp guard documented in the handoff. Stop at limits and move work to CI;
do not increase limits. The fun-refactor-specific guard applies to that other
repository. Memory changes need actual GC stress/verification and reuse checks.
Never call skipped, queued, superseded or cancelled runs passing support.
