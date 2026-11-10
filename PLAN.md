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
| 4 | Complete ownership and peer comparisons | Complete the [buffer, returned-function, weak-registration and parser comparisons](docs/measurements/ownership-peers.md). Separate construction/work/release, ordinary runtime from instrumented counts, managed/native storage from RSS, and actual algorithm differences. Measure ARC operations only with a verified observer; otherwise mark them unmeasured. |
| 5 | Language/tooling usability and compiler cost | Follow the [application and measurement plan](docs/measurements/application-tooling.md). Exercise a numerical application, a CLI/data-processing program and a callback-based service through the documented tools. Fix demonstrated inference/diagnostic/workflow gaps. Measure parsing, typing/specialization, ownership, C emission and C compilation separately on growing inputs; keep errors useful and analysis bounded. Complete the [sustained-load measurements](docs/benchmarks.md#sustained-service-load). Add syntax only for a demonstrated need. |
| 6 | Reduce repeated compiler type-copy work | Borrow inputs while finding unresolved variables and substituting resolved types, under the [frozen contract](docs/measurements/compiler-type-walks.md). Preserve inference, diagnostics, effects and exact C; verify copy reductions on four applications and compiler growth. Require qualified ordinary-build timing and memory results, then all final delivery gates. |

Each milestone preserves earlier behavior and coverage. A smaller executable or
fewer requested operations is evidence, but does not by itself finish a runtime
performance milestone. Working-memory gains and runtime tradeoffs must be explicit.

## Current work: remove measured compiler copies

#270–272 delivered fresh-array stores, captured-map ownership and known array
callbacks with structured-gradient comparisons. Their original noisy or unmet
milestone 1–3 timing acceptance remains open. Do not repeat unchanged measurements
to obtain qualification. #273 completes milestone 4 with its parser cleanup
repair and ownership/peer comparisons; [all delivery gates pass](docs/measurements/ownership-peer-final-gates-2026-11-09/README.md).

#274 completes milestone 5: [all nine production jobs, docs and the complete-log
audit pass](docs/measurements/application-final-gates-2026-11-10/README.md).
It delivers complete application/tool workflows, compiler phase reports, bounded
generic expansion, growing-input measurements and sustained HTTP load checks.
[Measurements](docs/measurements/application-compiler-load-2026-11-10/README.md)
retain all 48 qualifying compiler comparisons and 34 successful HTTP trials.
The later checking subdivisions have unmeasured reporter overhead; they establish
no ordinary-build speedup.

**Milestone 6:** implement the [selected borrowing candidate](docs/measurements/compiler-type-walks.md).
The [exact counters](docs/measurements/compiler-type-copies-2026-11-10/README.md)
match on both architectures: each complete application makes roughly 804,000–810,000
type-node copies while searching for unresolved variables, and 469,000–471,000
while substituting resolved types. Borrow the existing input trees and build only
required outputs. Keep row flattening unchanged initially; report remaining copies.

The frozen target is at least 5% less ordinary emit-C time for word counting and
queued callbacks, with numerical/HTTP/growth regressions limited to 2% and peak
RSS growth to 5%. Two sessions per architecture and the existing 2% copy-control
limit distinguish a measured gain from noise. Preserve language behavior and
exact C; no count reduction alone completes timing acceptance. Bundle the compiler
change, profiler/observation repairs, docs and final delivery evidence in one PR.

Continue repairing [AMD64 caller attribution](docs/measurements/compiler-checking.md)
without changing ordinary compiler behavior to accommodate the profiler. Its
missing stacks remain unaccepted; the independent counters are verified.

After this compiler milestone, attribute CPU time in the queued service and HTTP
endpoint to payload construction, queues/channels, protocol work and cleanup.
The 4,096-message service still takes 18.65–20.23 times C's time and 5.12–6.70 times
Swift's, with differing representations and synchronization. Do not call that gap
an ARC cost or choose another optimization before attribution. Keep the experimental
local-pair helper and public gradient API unchanged without representative evidence.

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
