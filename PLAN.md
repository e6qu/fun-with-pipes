# Project roadmap

Build a language with simple pipes, immutable values, strong types and useful
inference. Compile ahead of time through C. Prefer direct values, moves, borrows
and storage reuse; count necessary sharing. JIT and backward compatibility are
excluded. The [design limits](docs/design-limits.md) define what we do not promise.

## Where we are

- Tracing GC removal is verified on Linux, macOS and Windows, each on ARM64/AMD64.
- Known calls, selected records/arrays and scoped workspaces avoid many temporary
  allocations and ownership operations. These are bounded proofs, not a promise
  that every abstraction or every uniquely used value has no runtime cost.
- Types/effects, `let`/`fn`, infix arithmetic, macros, recursion lowering, REPL,
  notebook, debugger and Python inspection tools are implemented. Keep the syntax
  steady unless a concrete program establishes a meaningful limitation.
- PR #269 removed temporary numeric inputs. Its largest local-derivative case is
  56–59% faster than reverse AD, but still takes 4.2–5.7 times handwritten C's time.
  The helper remains experimental; three timing controls remain inconclusive.
  [Results](docs/measurements/computed-numeric-time-2026-11-07/README.md).
- Merged PR #270 shows 26–31% less large-array computation on
  ARM64, but AMD64 timing acceptance remains open. [All original limits and
  memory/compiler costs](docs/measurements/fresh-array-costs-2026-11-08/README.md)
  are retained; the candidate is not a completed milestone.
- [The new phase comparison](docs/measurements/loop-array-peers-2026-11-08/README.md)
  finds no comparable checked-loop computation gap: qualified large-loop cases
  take 18–20% less time than C on ARM64 and roughly the same on AMD64. The largest
  ARM64 local-derivative case still takes 2.47× C and 4.98× Rust. These are
  single-session peer results; most AMD64 array/derivative controls fail.

[The handoff](docs/development-state.md) records exact sources, checks and the
single next action. [Ownership](docs/ownership.md) records contracts;
[history](docs/roadmap-history.md) and [measurements](docs/measurements/README.md)
record delivered work and original observations.

## Milestones

Work through these in order, one substantial PR at a time. Later proofs and
numerical targets must be frozen against their measured starting points before
implementation; do not invent a universal language-overhead target.

| Step | Milestone | Concrete completion evidence |
|---|---|---|
| 1 | Shared loop/array costs and complete documentation refresh | Attribute the checked-loop and array/derivative gaps; deliver a reusable improvement selected from those costs, with the measurement contract below. Review all tracked docs and 24 tutorials, remove stale directions/repetition, repair navigation, and pass the final production/docs/audit gates in the same PR. |
| 2 | Broader ownership and representation coverage | Extend a common lifetime or representation proof to at least two distinct application patterns exposed by milestone 1. Cover local/escaping closures, records and shared inputs as appropriate. Preserve trap/cancellation cleanup and count necessary sharing; report time, allocations, live memory and compiler scaling. |
| 3 | Structured autodiff usable beyond one objective | Compare ordinary reverse AD, local forward AD and existing tensor operations on a neighboring-pair objective, independent per-element loss, and a dense coupled objective. Specify supported operations and effects. Add a public structured operation only with correctness, lifetime and measured-benefit evidence; preserve general `grad`, nested differentiation and F128 precision. |
| 4 | Complete ownership and peer comparisons | Update relevant Swift/C/Rust comparisons for buffers, returned functions, weak subscriptions and parser workspaces. Separate construction/work/release, ordinary runtime from instrumented counts, managed/native storage from RSS, and actual algorithm differences. Measure ARC operations only with a verified observer; otherwise mark them unmeasured. |
| 5 | Language/tooling usability and compiler cost | Exercise a numerical application, a CLI/data-processing program and a callback-based service through the documented tools. Fix demonstrated inference/diagnostic/workflow gaps. Measure parsing, typing/specialization, ownership, C emission and C compilation separately on growing inputs; keep errors useful and analysis bounded. Add syntax only for a demonstrated need. |

Each milestone preserves earlier behavior and coverage. A smaller executable or
fewer requested operations is evidence, but does not by itself finish a runtime
performance milestone. Working-memory gains and runtime tradeoffs must be explicit.

## Active implementation: captured scalar array maps

PR #270 delivered the documentation refresh and fresh F64 output stores. All nine
production jobs, docs and the [complete audit](docs/measurements/fresh-array-delivery-2026-11-08/README.md) passed. The original AMD64 timing acceptance stays open.
The user's merge retains the improvement without declaring that target met.

The next substantial PR extends the existing consuming-map proof to callbacks
with scalar captures: runtime sensor calibration and pixel adjustment. Bundle
selection/ownership changes, failure and alias controls, measured runtime/memory
costs and documentation. [The selection and measurement contract](docs/measurements/captured-array-maps.md)
defines exclusions and acceptance before collecting results. This begins step 2's
broader proof coverage while step 1's unresolved timing result remains visible.

[Repaired captured-map results](docs/measurements/captured-map-repaired-2026-11-08/README.md)
pass correctness, cleanup and complete observation audits in four native sessions.
Both largest applications qualify at 84–94% less computation with 199 fewer
array allocations per 199 updates. No qualified regression remains, but noisy
controls leave combined timing acceptance open. Final production delivery is next.
[Initial results](docs/measurements/captured-map-initial-2026-11-08/README.md) and
their original limits remain unchanged. The loop still allocates 400 small state/
step boxes and performs 200 payload retains; array reuse does not eliminate them.

## Retained contract: shared loop and array costs

Bundle implementation, incidental repairs, evidence and the entire documentation
refresh into one normal PR. Publish when the batch is ready; do not use draft
status to suppress CI. Use focused checks while implementing and one complete
final-head matrix after the batch is ready.

[The first diagnostic](docs/measurements/shared-loop-array-costs.md) tests whether
array callback boundaries hide useful loop information from the C optimizer.
It selects further work; it is not a completed compiler improvement.

| Work | Scope and decision |
|---|---|
| A. Establish costs | Start from merged #269. Inspect the saved checked-loop C and the saved local/manual-array programs. Measure equivalent C/Rust/fwp computation separately from input construction, output and teardown. Use the checked loop at 0/16/1,000,000/100,000,000 iterations; F64 map/fold at 0/16/65,537/262,145 elements; and derivative descent at 3/33/129 coordinates with 199 updates, plus 0/1-update controls. Retain the existing exact arithmetic and output oracles. |
| B. Choose the compiler change | Identify actual extra work in source/generated C and corroborate it with phase/work measurements. Consider calls, representation, repeated checks, copies and construction; do not assume ARC, register pressure or cache misses are the cause. Freeze the chosen transformation, affected workloads and correctness exclusions before implementing it. |
| C. Verify benefit | Aim for at least 10% less uninstrumented computation time on two affected nontrivial inputs, in two sessions on each native ARM64/AMD64 host. Qualified guard cases must not regress more than 2%. Preserve identical-copy controls; noise makes a comparison inconclusive. Record whole-program time separately, allocations, live storage, RSS, code/stack costs and compiler time/RSS. An inconclusive or missed target remains open rather than becoming a pass. |
| D. Refresh all documentation | Review every tracked Markdown document and all tutorial source/output copies. Explain concepts before examples, state inputs/results and prerequisites, replace repetitive prose with useful tables/diagrams, remove obsolete next actions and link to one authoritative explanation. Update generated library guides through source comments/generators. Preserve raw observations, original acceptance contracts and source identities; historical evidence is not an active backlog. |
| E. Deliver together | Compare raw interpretation and native results, effects and first failures. Use production GCC/Clang settings for focused checks. Run nine final-head native production jobs, documentation and complete log/artifact audits; fix every encountered issue before delivery. Squash with one line <=80 characters and an empty body. |

If an investigated change misses its target, retain the result and choose the
next change from evidence within this milestone. Do not repeat unchanged timings
to obtain a pass, relax old limits after seeing results, or substitute count savings
for a speed claim. Keep prior successful gates stable while remaining jobs run.

## Maintained guarantees and evidence

Keep GC absence, weak expiration/reuse, alias preservation, resource cleanup,
failure/cancellation, arithmetic/rounding order, inference/effects and native
packaging coverage. Restricted self/mutual tail calls do not imply constant stack
for arbitrary recursion. Unique storage can be on the heap; no-count is not no-heap.

[Earlier missed comparisons](docs/measurements/unmet-comparisons.md) preserve their
original outcomes. They do not require repeating old experiments or completing
abandoned hypotheses. The [Intel compiler abort](docs/measurements/compiler-abort.md)
has no established cause; preserve and diagnose any recurrence rather than treating
successful reruns as a repair.
