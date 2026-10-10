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
jobs and the roadmap documentation audit for the current exact PR head before squash. Supply a single-line subject
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

Main includes #74–#113: native macOS, selected typed container/text/callback
ownership, exact wide reference counts and immediate last-owner reclamation.
Registered unwind cleanup now protects compiler caller/reuse-token references
and runtime application/capture preparation, plus map, selection, zip and fold
unwind cleanup. Loop state/Step owners survive cancellation and payload
preparation; flattened Again records remain unboxed. Original allocation gates
remain intact. Constructor fields and remaining caller references stay protected
before allocation; merged changes passed all exact-head production and documentation gates.
Queue34 is skipped as a duplicate; queue35 is accepted. Deliver queue36 worker
result boxing, then the
remaining ownership work. Exact heads, failures, checks and the sole next action
are in [the handoff](docs/development-state.md); historical platform evidence
and repaired test controls are in [history](docs/roadmap-history.md).

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
