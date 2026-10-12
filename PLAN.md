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
Avoid needless wrappers and fallbacks, magic, and unnecessary implicit behavior
or defaults. Register spills
are ordinary lowering; protocol-defined alternatives are peers. Keep necessary
representation choices and limits explicit and justified.
Prefer internal ownership over new language syntax. Compare the interpreter
and native semantics; optimizer oracles must use `FWP_NO_OPT=1` explicitly.

The aim is efficient machine code with few heap allocations, natural numeric
storage, suitable alignment and effective register/cache use. Tracing is the existing memory mode. The explicit ARC mode requires checked
ownership coverage and a supported cycle policy; rejection never selects tracing. Prepared branches do not establish merged support.

| Order | Status and work | Acceptance |
|---|---|---|
| 1 | Done: native macOS ARM/Intel support (#74) | Full platform gates; real collection; interpreter/native agreement; explicit unsupported options |
| 2 | Done: typed ownership and explicit runtime compatibility fallbacks | Accepted merged-source coverage; callback/unwind/resource, alias, GC/reuse and reclamation controls |
| 3 | Done: natural-width contiguous numeric storage, views, aggregate/scalar ABI and alignment | Narrow elements use natural width; fewer copies/boxes; arm64/x86-64 allocation/assembly evidence; ABI/FFI checks |
| 4 | Done: fused numerical loops, blocked matrices, autodiff lifetimes and reusable buffers (#127) | Correct gradients and exceptional cleanup; equivalent C/Rust workloads; fixed floating-point behavior by default |
| 5 | In preparation: broaden ownership/performance regression evidence | Allocations, live memory, counts and collections alongside timing, hardware/compiler/flags recorded |
| 6 | In preparation: checked native ARC execution after coverage | Supported programs reclaim without collection, including escapes/runtime boundaries; explicit cycle lifetime policy |

## Current delivery

Main through PR #127 completes phases1–4. Packed numeric storage and views,
typed worker ABI, fused numerical kernels, guarded blocked matrices and bounded
reusable autodiff workspaces pass all six exact-head jobs, documentation and
actual merged-source acceptance. The scalar-borrow repair preserves in-place
container updates. The handoff records exact source and evidence hashes.
Checked ARC execution remains in preparation until phase6 meets its criteria.

Deliver phases5–6 together: independently owned loop fields, reduced unwind
bookkeeping, immutable descriptors, retained measurements, and checked native
ARC eligibility with physical-reclamation and binary controls. Keep each phase's
acceptance explicit even when sharing one production PR and full CI run.
Windows, new deployment interfaces and a new backend remain deferred.

## Validation limits

Local focused workloads are serial, low priority, sampled and bounded: 1 GiB
aggregate RSS, target data below 2 GiB, at least 64 GiB free disk and 180 seconds.
Use the fwp guard documented in the handoff. Stop at limits and move work to CI;
do not increase limits. The fun-refactor-specific guard applies to that other
repository. Memory changes need actual GC stress/verification and reuse checks.
Never call skipped, queued, superseded or cancelled runs passing support.

## Concrete remaining deliveries

Phase5 broadens regressions across escapes, callbacks, exceptions, retained
resources and array/view paths, recording allocation/live/count/collection data
alongside timing and actual uninstrumented assembly. Phase6 checks explicit
native ARC eligibility: immutable counted graphs and scoped File owners must
reclaim without tracing. Mutable cyclic runtime types, raw pointers/tape tokens,
boxed I128/U128 without counted owners, unchecked native declarations,
unmodeled foreign owners and deployment boundaries outside the proved subset
must be rejected. Neither disabling collection nor successful process exit
establishes reclamation. Preserve unsupported-mode diagnostics and prove missing
frees and forced tracing fail. Review the final source and docs before marking
these criteria complete.
