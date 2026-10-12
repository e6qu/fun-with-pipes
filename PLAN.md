# Plan

fwp implements the Pipe Language Compact Specification. [Design](docs/design.md)
records the semantics and implementation. [The handoff](docs/development-state.md)
records current work, exact heads, failures and validation; [the queue](docs/roadmap-queue.md)
records immutable preparation anchors. [History](docs/roadmap-history.md) preserves
prior deliveries and measurements, without supplying new priorities.

## Authorized execution

Complete this roadmap automatically, one coherent bundle PR at a time. Group
related prepared changes to reduce cycle time; preserve their original tests
and run full CI once for each final bundle head. Fix failing tests;
CI gates merging, not implementation or next-task preparation. Full builds,
tests, benchmarks and large regeneration run on GitHub. Require all six passing
jobs and the roadmap documentation audit for the current exact PR head before
squash. Supply a single-line subject of at most 80 characters and an empty body,
with no trailers or attribution.
Keep the roadmap run going through queued CI: monitor results, fix failures
and prepare independent work until every phase meets its exit criteria.
Update the handoff and queue after meaningful progress. This authorization
persists across sessions and compactions; no repeat approval is required.
Apply the boy scout rule: fix issues and bugs encountered in this repository,
including those outside the current roadmap item. Preserve regression controls,
record the evidence and include coherent fixes in the next bundle. This does
not change the phase order or defer a failing check as unrelated.

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
| 2 | Done: typed ownership and explicit runtime compatibility fallbacks | Accepted merged-source coverage; callback/unwind/resource, alias, GC/reuse and reclamation controls |
| 3 | In progress: natural-width contiguous numeric storage, views, aggregate/scalar ABI and alignment | Narrow elements use natural width; fewer copies/boxes; arm64/x86-64 allocation/assembly evidence; ABI/FFI checks |
| 4 | Pending: fused numerical loops, blocked matrices, autodiff lifetimes and reusable buffers | Correct gradients and exceptional cleanup; equivalent C/Rust workloads; fixed floating-point behavior by default |
| 5 | Pending: broaden ownership/performance regression evidence | Allocations, live memory, counts and collections alongside timing, hardware/compiler/flags recorded |
| 6 | Pending: optional tracing-free execution after coverage | Supported programs reclaim without collection, including escapes/runtime boundaries; explicit cycle lifetime policy |

## Current delivery

Main through PR #125 completes phase2's documented ownership model.
All177 remaining runtime declarations explicitly retain compatibility fallback;
tracing-free execution remains phase6. Resource and network queue anchors are
accepted and archived. Checked allocation/kernel boundaries and current CI
pass the exact final head and actual merged-source audit. The handoff records
those proofs and the actual base for phase3.

Next deliver natural-width numeric arrays, checked owner-retaining views and
typed worker ABI layouts in one coherent bundle. Preserve existing type inference,
Pipe semantics, ownership and trap order. Then complete phases4–6. Windows,
new deployment interfaces and a new backend remain deferred.

## Validation limits

Local focused workloads are serial, low priority, sampled and bounded: 1 GiB
aggregate RSS, target data below 2 GiB, at least 64 GiB free disk and 180 seconds.
Use the fwp guard documented in the handoff. Stop at limits and move work to CI;
do not increase limits. The fun-refactor-specific guard applies to that other
repository. Memory changes need actual GC stress/verification and reuse checks.
Never call skipped, queued, superseded or cancelled runs passing support.

## Concrete remaining deliveries

For phase3, implement descriptors and typed loads/stores for naturally packed
I8/U8, I16/U16, I32/U32 and F32 arrays; preserve I64/U64/F64 semantics. Carry
those descriptors through producers, consumers, copies, equality/hash, text/JSON,
SIMD and FFI. Views retain their backing storage and enforce bounds and alignment.
Validate exact bytes, size/alignment and arm64/x86-64 generated assembly,
including ABI boundaries. Treat F16 and128-bit formats explicitly rather than
claiming unverified platform support.

For phase4, preserve floating-point evaluation order while fusing eligible loops
and blocking matrices; retain the existing contraction policy. Reuse autodiff
workspaces with scoped owners and reentrancy/cancellation controls. Compare
equivalent C/Rust workloads with source, compiler, hardware and memory metadata.

Phase5 broadens those regressions across escapes, callbacks, exceptions, retained
resources and array/view paths, recording allocation/live/count/collection data
alongside timing. Phase6 defines and checks tracing-free eligibility and rejects
unsupported runtime boundaries or cycles; disabling collection alone is not
evidence. Supported programs must reclaim escaped values and external resources
without collection under the documented cycle policy.
