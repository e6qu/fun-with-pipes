# Project roadmap

Build a language with simple pipes, immutable values, strong types and useful
inference. Compile ahead of time through C. Prefer direct values, moves, borrows
and storage reuse; count necessary sharing. JIT and backward compatibility are
excluded. The [design limits](docs/design-limits.md) define what we do not promise.

## Where we are

- #271 delivers runtime scalar-capture map reuse with all native gates passing.
  Both largest applications use 84–94% less computation; noisy controls leave the
  [combined timing target open](docs/measurements/captured-map-repaired-2026-11-08/README.md).

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
| 1 | Shared loop/array costs and complete documentation refresh | Attribute the checked-loop and array/derivative gaps; deliver a reusable improvement selected from those costs, under the [shared-cost contract](docs/measurements/shared-loop-array-costs.md). Review all tracked docs and 24 tutorials, remove stale directions/repetition, repair navigation, and pass the final production/docs/audit gates in the same PR. |
| 2 | Broader ownership and representation coverage | Extend a common lifetime or representation proof to at least two distinct application patterns exposed by milestone 1. Cover local/escaping closures, records and shared inputs as appropriate. Preserve trap/cancellation cleanup and count necessary sharing; report time, allocations, live memory and compiler scaling. |
| 3 | Structured autodiff usable beyond one objective | Compare ordinary reverse AD, local forward AD and existing tensor operations on a neighboring-pair objective, independent per-element loss, and a dense coupled objective. Specify supported operations and effects. Add a public structured operation only with correctness, lifetime and measured-benefit evidence; preserve general `grad`, nested differentiation and F128 precision. |
| 4 | Complete ownership and peer comparisons | Update relevant Swift/C/Rust comparisons for buffers, returned functions, weak subscriptions and parser workspaces. Separate construction/work/release, ordinary runtime from instrumented counts, managed/native storage from RSS, and actual algorithm differences. Measure ARC operations only with a verified observer; otherwise mark them unmeasured. |
| 5 | Language/tooling usability and compiler cost | Exercise a numerical application, a CLI/data-processing program and a callback-based service through the documented tools. Fix demonstrated inference/diagnostic/workflow gaps. Measure parsing, typing/specialization, ownership, C emission and C compilation separately on growing inputs; keep errors useful and analysis bounded. Add syntax only for a demonstrated need. |

Each milestone preserves earlier behavior and coverage. A smaller executable or
fewer requested operations is evidence, but does not by itself finish a runtime
performance milestone. Working-memory gains and runtime tradeoffs must be explicit.

## Current work: structured autodiff

#270 delivered the documentation refresh and fresh F64 stores. #271 extended
array ownership to runtime sensor calibration and pixel adjustment. Both pass
all delivery gates; [#271's receipt](docs/measurements/captured-map-delivery-2026-11-08/README.md)
records the tested/merged tree. Their original noisy or unmet timing targets
remain open. Do not repeat unchanged timings to obtain a pass or treat fewer
allocations as proof of a timing target.

Milestone 3 now compares complete gradients for three functions:

- **Neighbors:** each term depends on two adjacent inputs. Local forward AD can
  visit just the terms that affect a coordinate.
- **Independent loss:** each term uses one input; existing `derivative` and
  `array.map` already express this without another wrapper.
- **Dense coupling:** every matrix row uses every input. Locality offers no
  equivalent shortcut; retain general reverse and forward AD.

[The comparison contract](docs/measurements/structured-autodiff.md) defines the
formulas, method limits, input/output boundaries, correctness and measurement
requirements. Validate the examples and freeze exact observations before timing.
Select a reusable compiler/library improvement from the results; freeze its
acceptance before implementing it. A public operation needs more than one useful
formula and a demonstrated advantage. Preserve general `grad`, nested AD and F128.
Bundle the improvement, measurements, tutorials and incidental fixes in one PR.
Use focused checks while working, then one complete final-head matrix and audit.

## Earlier contracts

The [shared loop/array contract](docs/measurements/shared-loop-array-costs.md) and
[captured-map contract](docs/measurements/captured-array-maps.md) retain original
limits and evidence. Their completed implementation tasks are not an active queue.
[Results](docs/measurements/README.md) distinguish verified delivery from timing
acceptance. Remaining loop-state boxes and payload retains are measured costs,
not a mandate to optimize them before the next representative workload.

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
