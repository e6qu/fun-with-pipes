# Implementation plan

Build an ahead-of-time compiled language with simple pipes, immutable values,
strong types and useful inference. Keep ordinary functions single-argument,
curried and data-last. Name inputs and intermediate values when that makes code
clearer. Prefer direct values, moves and borrows; use ARC only for necessary
sharing. Tracing GC is removed. JIT and backward compatibility are not goals.

## Current batch

Implement immutable `let pattern = value in body`, `fn pattern -> body`, named
match patterns, tuple/record destructuring and record-field shorthand. Update
inference, captures, ownership, macros, formatting, diagnostics, tooling and
teaching examples together. A parsed feature is not a delivered feature.

The user authorized all work below. Group related changes into substantial PRs;
run focused checks while implementing and one complete final-head matrix per
finished batch. Do not let unresolved timing noise stop independent compiler work.
[The handoff](docs/development-state.md) records the current action and checks.

## Work and acceptance

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Local names and functions | Scope, evaluation, types, captures and cleanup agree in raw interpretation and native execution |
| 2 | Documentation and tooling | Tutorials introduce each feature; formatter, macros and editor/debugger names preserve its meaning |
| 3 | Known functions without closure overhead | Named/tacit versions use direct calls and avoid environments in the stated nonescaping cases |
| 4 | Borrowing and moves | Named call/field/loop fixtures avoid redundant owners while aliases and failures stay correct |
| 5 | Direct representations | Tuple/record/variant fixtures avoid intermediate boxes across the selected boundaries |
| 6 | Collection pipelines | Selected producer/consumer pipelines eliminate intermediate storage without changing effects or traps |
| 7 | Numerical loops | Selected loops avoid redundant checks/conversions and preserve arithmetic order and exact supported results |
| 8 | Automatic differentiation | Recording, traversal and result costs are measured separately; a selected cost is removed safely |
| 9 | Comparable measurements | Swift/C/Rust work, timing scope, memory, hardware and inconclusive results are explicit and retained |
| 10 | Integrated delivery | All application families and nine production jobs plus documentation pass on the integrated source |

## 1. Local names and functions

- Add strict, nonrecursive `let`: evaluate the initializer once, then its body.
  A binding is immutable and visible only in that body. Nested scopes may shadow
  names; duplicate names in one pattern are errors. Local inference does not
  silently generalize a value into a polymorphic function.
- Add `fn pattern -> body`. It takes one argument. Successive arguments use
  nested functions; tuple arguments stay tuples. Keep tacit definitions unchanged.
- Permit names in match patterns. Existing `_` holes keep forwarding their values
  to the arm body. In fn/let and record-field patterns, `_` discards the input.
  Refutable fn/let patterns are rejected: use `match` for alternatives.
- Add tuple and record destructuring, including nested irrefutable fields.
  Record patterns select named fields; unlisted fields are ignored. Add value
  field shorthand `{ x, y }` with the same meaning as explicit assignments.
- Lift lexical functions with explicit captures; do not move initializer effects,
  duplicate computations, capture forbidden resources or let borrows escape.

Acceptance: executable tests for shadowing, single evaluation, nested/escaping
closures, named and tacit matches, nominal/structural records, monomorphic local
uses, overflow/effect order, resource misuse, failure and cleanup. Compare raw
interpretation and production GCC/Clang native outputs. No implicit input,
constant-function lifting, tuple unpacking, recursion or mutation is introduced.

## 2. Documentation and tooling

Introduce local scope, `in`, named inputs, destructuring and captures before using
them. Keep concise tacit pipelines; rewrite combinator-heavy formulas where names
help. Audit every tutorial and example for assumptions, outdated statements and
source-copy drift. Update generated library docs through their source comments.

Update the parser theory and compilation guides with the actual grammar and
lowering. Extend quote/unquote with hygienic local names, macro expansion,
formatting round trips, lint scope, editor navigation and debugger source names.
Explain why allocations, count operations or intermediate collections remain in
compiler inspection output; distinguish proof rejection from a runtime fallback.

Acceptance: formatting is idempotent and preserves the AST; macros cannot capture
spliced names accidentally; local navigation/rename respects shadowing; tutorial
source copies, links and runnable outputs pass. Remove obsolete directions and
repeated completion narratives; retain reproducibility records and failed results.

## 3. Known calls and captures

Use paired named/tacit fixtures: a scalar formula, a local callback used by a
fold, a returned scalar-capturing function and a function that captures a string.
Extend specialization through lexical bindings where needed. Evaluate captures
once at construction; remove nonescaping environments and indirect calls when
proved. Escaping values keep the owners they require.

Acceptance: identical output/traps, no extra allocation/count operations for the
nonescaping forms, bounded escaping storage and zero live growth after teardown.
Measure construction, invocation and release separately when claiming speed.

## 4. Borrowing and moves

Select call-site costs from the existing owner profiles. Extend borrowing through
local aliases, record fields and known calls; move a last-used owner rather than
retain/release it. Include one loop-carried owner, a retained caller alias and a
failure between argument evaluations. Keep analysis bounded and measure compiler
cost on the existing [analysis fixtures](docs/measurements/ownership-analysis.md).

Selected new cases in `tests/fixtures/functional_costs.fwp` are `local-alias`,
`local-owner-loop` and `local-loop-alias`, at inputs 0, 32 and 128. The first
reads one dynamically created String through two names and a known reader; the
loops carry that String, with/without a caller alias. Require zero retains for
the first two and at most one for the retained-alias case, independent of trip
count. Report all allocations, bytes, applications and boxes as well. Existing
`compiler_call_liveness` controls cover failure between argument evaluations and
cancellation. Freeze these requirements before collecting the new observations.

Acceptance: state exact count reductions per fixture, preserve shared aliases,
reject use-after-consume and forbidden resource duplication, and prove physical
cleanup on normal, error and cancellation paths. Fewer counts alone is no speed claim.

## 5. Direct representations

Extend existing scalar replacement across local destructuring, known calls and
immediately inspected Option/Result returns. Cover a numeric tuple, a nominal
record, a record containing a String and a returned variant. Inspect emitted C
and actual binaries; generic entry points may still require a boxed value.

The same fixture selects `local-tuple`, `local-record`, `local-text-record` and
`local-variant`, each called with 0, 32 and 128. Require no intermediate box,
retain or dynamic application. Numeric cases must allocate nothing; the String
case may allocate only its output from `show` (one request, nine header/terminator
bytes plus the decimal length). All paths return scalars and restore live storage.
Native probes use the actual generated entries at O0/O2; preserve C and binaries.

Acceptance: no intermediate box on the selected direct paths, valid child owners,
unchanged bit patterns and failure order. Record stack and code costs, prioritizing
execution time and working memory over executable size.

## 6. Collection pipelines

Extend current fusion/direct iteration through named callbacks and local bindings.
Cover generated-array/fold, map/filter/consumer and stateful range iteration.
Add controls for a reused collection, an unknown callback, early stopping and two
stages that may fail differently. Do not interleave eager stages without a proof
that observable behavior stays unchanged.

`local-map-filter` in the same fixture adds one, keeps even values and sums them
from a named range. At 0/32/128 require no allocations, boxes, retains or runtime
applications. The existing named generated-array and State-range pairs cover the
other two paths. `tests/local_bindings.rs` adds reused-list, eager callback-output
and different-trap controls; numeric-array tests cover unknown callbacks, aliases
and early failure. Reconnecting a named producer must retain the existing fusion
proof, including the stricter rule for an early-stopping consumer.

Acceptance: eliminated intermediate requests/bytes in the eligible fixtures;
callback count/order, first failure, empty inputs, aliases and cleanup preserved.
Keep [existing failed timing controls](docs/measurements/buffer-current.md).

## 7. Numerical loops

Selected next change: traverse a numeric array directly when `array.to-list`
feeds known map/filter/fold callbacks. Keep floating conversions and reduction
order; remove the intermediate list, not arithmetic. At lengths 0, 1, 129 and
4,096, a mapped-list result must remove at least one 24-byte list cell per input
versus the same compiler with array fusion disabled. The
[array traversal protocol](docs/measurements/array-list-traversal.md) fixes all
measurement settings before the candidate runs. A scalar fold must construct
no element list. Keep input aliases, slices, empty arrays, callback traps and
mixed-stage failure order. The matrix implementation stays under its existing
exact-result controls; no matrix speed claim follows from this list removal.

Inspect the selected map/reduce and matrix workloads for repeated shape/bounds
checks, boxed loop state, generic conversions and unnecessary data movement.
Extend existing typed workers and contiguous traversal where evidence identifies
remaining work. Vectorize independent work only when valid; do not reassociate
floating reductions or remove checked overflow to obtain a better benchmark.

Acceptance: exact supported bit behavior, shape-error order, cancellation and
memory scaling; reference/candidate time on qualified hosts under declared limits.
The original N1/N2 [kernel controls](docs/measurements/kernel-baselines.md) remain
open; new results must not silently replace their failed observations.

## 8. Automatic differentiation

The same array-to-list boundary occurs in `rev._backward-float`: it converts the
numeric adjoint array to a list, then maps `float.convert`. Apply step 7's direct
traversal without deleting the conversion (NaNs and narrower formats matter).
Measure this path at 3, 33 and 129 coordinates, including zero/one/199 updates.
Require unchanged result checks and raw tape storage, complete cleanup, and at
least one fewer list cell per returned coordinate per gradient. Attribute setup,
forward recording, reverse setup/traversal, result array and retirement separately;
the final list conversion lies outside those runtime phases and must be reported
as such. Keep ordinary and instrumented timings separate. The selected change's
timing acceptance is at most 2% regression against its same-source control, with
identical-copy variation at most 2%; failed/noisy cases stay open. This does not
replace D2's original 5% improvement requirement.

For Rosenbrock descent, attribute forward recording, backward traversal, gradient
construction and retirement separately. Compare AD with an explicit derivative
in fwp before interpreting its C/Rust gap as compiler overhead. Preserve history
versus current-result work and the full output/accuracy contracts.

Select a demonstrated removable cost: redundant recording, generic per-node
work or temporary result storage. Freeze input sizes and time/memory limits before
measuring the candidate. Keep nested gradients, stale nodes, tape-full failures,
workspace release and cancellation controls.

Acceptance: correct derivatives within stated tolerances, a demonstrated cost
reduction and complete retained measurements. The original D2 speed requirement
remains open in [descent costs](docs/measurements/descent-costs.md); verified
allocation savings and D3 accuracy are maintained guarantees.

## 9. Measurements

Compare Swift alongside C and Rust. State both implementations, equivalent work,
inputs, compiler flags, timing boundaries, allocations, live/peak memory and
process RSS. RSS is not an allocation count or isolated ARC cost. Add Swift
allocation/ownership attribution where it can be observed reliably; report what
is still unmeasured instead of estimating it from elapsed time.

Preserve the [closure failures](docs/measurements/callable-phases.md) and
[numerical timing diagnosis](docs/measurements/timing-variation.md). A new closure
study needs explicit CPU qualification and work counts frozen using reference-only
calibration before candidate ratios are seen. Keep all order/copy/zero-work
controls. A different CPU cannot settle the original Xeon-specific regression.
Do not repeat unchanged noisy runs, relax limits or discard slower observations.

Acceptance: raw sources, commands, outputs and observations are retained; automated
checks recompute results and reject damaged records. Independently verified cost
reductions may ship with timing acceptance explicitly open, as already authorized.

## 10. Integrated delivery

Complete the finite [application matrix](docs/application-acceptance.md): word
frequencies, directories, text tools, numerical pipelines, derivative descent and
long-running services. Preserve scale, error, cancellation and retained-memory
controls. Name the exact integrated source and supported native/WASM hosts.

Require Linux, macOS and Windows on ARM64/AMD64 through all nine production jobs,
plus documentation, for the final commit. Local checks use the unchanged resource
guard; full suites and benchmarks run on GitHub. Fix every encountered failure.
Squash-merge only after passing gates, with one subject of at most 80 characters,
an empty body and no attribution/trailers. Continue with the next coherent batch.

## Maintained guarantees and evidence

Tracing GC removal, the scoped A1–A6 ARC reductions, F1–F3 call/recursion coverage,
decimal-count improvements and D3 derivative accuracy have verified delivery.
They are not a backlog to implement again. [Ownership](docs/ownership.md),
[functional costs](docs/functional-costs.md) and [delivery history](docs/roadmap-history.md)
record their limits and source identities. GC removal does not imply count-free
containers, universal stack storage, constant-space recursion or C/Rust parity.

The intermittent Intel macOS compiler abort remains an open defect. Preserve
[its evidence](docs/measurements/compiler-abort.md) and diagnose a recurrence from
its input/source path; passing reruns did not establish its cause. Do not resume
speculative disassembly-led allocator changes.
