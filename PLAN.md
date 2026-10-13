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
or defaults. Register spills are ordinary lowering; protocol-defined alternatives
are peers. Keep representation choices and limits explicit and justified.
Prefer internal ownership over new language syntax. Compare the interpreter
and native semantics; optimizer oracles must use `FWP_NO_OPT=1` explicitly.

The aim is efficient machine code with few heap allocations, natural numeric
storage, suitable alignment and effective register/cache use. Tracing remains
available. Explicit ARC mode requires checked ownership coverage and a supported
cycle policy; rejection never selects tracing. Prepared branches do not establish
merged support.

| Order | Status and work | Acceptance |
|---|---|---|
| 1 | Done: native macOS ARM/Intel support (#74) | Full platform gates; real collection; interpreter/native agreement; explicit unsupported options |
| 2 | Done: typed ownership and explicit runtime compatibility fallbacks | Accepted merged-source coverage; callback/unwind/resource, alias, GC/reuse and reclamation controls |
| 3 | Done: natural-width contiguous numeric storage, views, aggregate/scalar ABI and alignment | Narrow elements use natural width; fewer copies/boxes; arm64/x86-64 allocation/assembly evidence; ABI/FFI checks |
| 4 | Done: fused numerical loops, blocked matrices, autodiff lifetimes and reusable buffers (#127) | Correct gradients and exceptional cleanup; equivalent C/Rust workloads; fixed floating-point behavior by default |
| 5 | Done: ownership/performance regression evidence | Allocations, live memory, counts and collections alongside timing, hardware/compiler/flags recorded |
| 6 | Done: checked native ARC execution for the proved ownership subset | Supported programs reclaim without collection, including escapes/runtime boundaries; explicit cycle lifetime policy |

## Completed roadmap

Phases 1–6 are accepted on main through PR #128. Native macOS ARM/Intel support,
runtime ownership contracts, packed numeric storage and views, typed aggregate
ABI, fused numerical kernels, blocked matrices, bounded reusable autodiff
workspaces, loop ownership improvements and checked native ARC execution pass
their required gates. The handoff records the tested and merged sources,
all six jobs, documentation and actual merged-source acceptance.

ARC support is explicit: admitted immutable graphs and scoped File owners
reclaim without tracing. Unproved mutable cycles, boxed I128/U128 owners, raw
reverse-mode tapes/pointers and external/deployment boundaries remain rejected.
The retained C/Rust comparisons make no universal speedup or parity claim.
No implementation task remains in this roadmap. Windows, new
deployment interfaces and a new backend remain outside its scope.

## Validation limits

Local focused workloads are serial, low priority, sampled and bounded: 1 GiB
aggregate RSS, target data below 2 GiB, at least 64 GiB free disk and 180 seconds.
Use the fwp guard documented in the handoff. Stop at limits and move work to CI;
do not increase limits. The fun-refactor-specific guard applies to that other
repository. Memory changes need actual GC stress/verification and reuse checks.
Never call skipped, queued, superseded or cancelled runs passing support.

## Completion boundary

Keep supported memory-mode boundaries and original Pipe semantics intact.
Existing tracing-mode features remain available; ARC never switches to tracing
when eligibility fails. Future coverage or performance work must start from the
retained measurements and current handoff rather than an archived next action.

## Completed follow-up: tacit examples and CI repair

PR #130 delivers nine revised programs, matching tutorial excerpts and explicit
`const` explanations. Ordinary macOS integration targets are split between the
existing regular and GC jobs; coverage and limits are preserved. All six jobs
and the documentation audit passed at the final head before squash merge.
The handoff records the source, execution audit and merge evidence.

## Agreed syntax guidance

Keep the current grammar: tacit, curried, data-last functions; application binds
more tightly than pipes; explicit parentheses group nested expressions. Existing
layout still delimits declaration continuations and match arms. Do not add
implicit argument grouping, a colon application operator or indentation-based
argument groups. Keep `const` explicit and `()` as the unit value.

Use short inline callbacks and meaningful names for larger or reusable stages;
do not add names merely to eliminate parentheses. Keep tutorials focused on the
constructs they teach. Grouping proposals are set aside. Performance work belongs in compilation and runtime
representation, with measured evidence, rather than punctuation changes.

## Active follow-up: iteration and record projections

The user accepted this bundle after the prefix/piped syntax discussion. Keep
prefix calls and infix pipes, and keep both `if` and `match`.

- Add `iter.fold`, `iter.each` and `iter.find` as direct iterator consumers.
  Callbacks run in order; `find` does not force the tail after a match.
- Add list `fold-until`: the callback returns `Again state` or `Stop state`;
  exhaustion returns the current state. No implicit finalizer.
- Add `map-accum`: the callback takes state then element and returns
  `(mapped value, next state)`; the result is `(mapped list, final state)`.
- Expand `make { .name }` to `make { name = .name }` in the parser, including
  nominal `make`. Keep nested paths explicitly named and other record forms
  unchanged. Preserve field order and duplicate-field diagnostics.
- Cover empty inputs, callback order/failure, early stopping, long traversal,
  owned values and parser/formatter behavior. Compare raw interpreter/native
  results and run all six CI jobs plus documentation before squash merge.

Update the reference, generated library docs and live handoff in this bundle.
No new runtime primitives, implicit grouping or implicit constant functions.
