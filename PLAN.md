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
jobs and the roadmap documentation audit for the current exact PR head before
squash. Supply a single-line subject of at most 80 characters and an empty body,
with no trailers or attribution.
Keep the roadmap run going through queued CI: monitor results, fix failures
and prepare independent work until every phase meets its exit criteria.
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

Main includes #74–#119: native macOS ARM/Intel support and selected ownership,
last-owner reclamation and unwind protections. Queue33 and35–41 are accepted;
queue34 is a verified duplicate delivered in #107. Deliver queue42 record
updates on the actual PR119 squash, then finish ownership queues43–112.
[The handoff](docs/development-state.md) gives exact heads, checks and the sole
next action. Prepared work still requires final rebases and full CI.

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
