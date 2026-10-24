# Implementation plan

Build an ahead-of-time compiled, strongly typed language with simple pipes,
immutable values and predictable memory use. Prefer moves, borrows and direct
values; use automatic reference counting (ARC) only for necessary sharing.
Remove the tracing garbage collector (GC). JIT compilation is excluded.

This is early pre-alpha: source, layouts and calling conventions may change.
Preserve language behavior, not backward compatibility. Keep single-argument,
curried, data-last functions, ordinary type inference, explicit generic signatures,
checked arithmetic, and observable effect/failure order.

## Where we are

PR #210 is merged. Its final revision passed all nine production jobs and the
documentation gate. Native packages cover Linux, macOS and Windows on ARM64 and
AMD64, one binary per target. [The handoff](docs/development-state.md) records
source IDs, the current task and checks still needing review.

**GC removal is incomplete.** Native execution defaults to checked ARC;
accepted programs omit tracing code. Explicit tracing mode and collector-specific
tests still exist. Channel graphs that can own themselves, some retained
callbacks and external lifetimes remain rejected by ARC. An invalid derivative
escaping its task must stay rejected, not become a migration target.

**ARC minimization is incomplete.** Borrowing, moves, direct record/variant
fields, selected stack storage and unique reuse already remove costs. Other
unshared paths still allocate, update counts or check uniqueness. Removing the
collector is not the same as removing these costs. The
[ownership guide](docs/ownership.md) separates implemented rules from proposals.

## Work order

1. Finish the documentation overhaul requested after #210. Reconcile every guide,
   tutorial and status record with source; remove duplicated delivery narratives.
2. Deliver the prepared array sorting/conversion group against current main.
   This is task **A1** below, not a new experiment to repeat from scratch.
3. Complete **G1–G3** before choosing new lifetime APIs or deleting tracing.
   Work on measured ARC costs in parallel with those design/proof tasks.
4. Use **B1** to set per-workload timing budgets before selecting further CPU or
   differentiation optimizations. Keep slower and inconclusive results visible.

The original intermittent Intel macOS compiler abort remains an open defect.
Source lifetime repairs and passing reruns did not establish its cause. Preserve
[the evidence](docs/measurements/compiler-abort.md); diagnose any recurrence from
its source path and input. Do not resume disassembly-led allocator experiments.

## Milestones

A milestone is complete only when its listed tasks and evidence are complete.
The table is an index; the concrete work follows it.

| Step | Milestone | Completion evidence |
|---|---|---|
| 1 | Remove tracing GC | G1–G5: explicit supported/rejected lifetime rules, replacement diagnostics, no collector code or tracing execution mode |
| 2 | Minimize ARC in named unshared paths | A1–A5: per-fixture allocation/count budgets met, sharing and cleanup preserved |
| 3 | Remove functional and recursion overhead | F1–F3: direct-call/loop coverage and bounded-stack proofs for stated cases |
| 4 | Close measured CPU performance gaps | P1–P3: agreed same-host budgets met without changing arithmetic or trap order |
| 5 | Reduce differentiation cost | D1–D3: derivative correctness and per-size time/storage budgets met |
| 6 | Improve CPU numerical kernels | N1–N2: accuracy, layout and timing budgets met for named kernels |
| 7 | Make comparisons reproducible | B1–B2: repeated baselines, fixed acceptance rules and complete retained evidence |
| 8 | Validate larger programs | V1–V2: the finite application matrix passes its correctness, cleanup and scale requirements |

## 1. Remove tracing GC

**G1 — Freeze the supported execution matrix.** Extend the existing admission
records, rather than recounting completed primitive contracts. Use
`tests/arc_corpus.rs`, `tests/wasm_arc.rs`, the library/foreign-callback tests,
and HTTP/gRPC tests to list each maintained entry: executable, command, native
library, synchronous/asynchronous WASI, browser loader and service. For each
rejection record the smallest source example, diagnostic, owner that is missing,
and whether the example is invalid or needs a supported lifetime contract.
Include recursive channel payloads, queued `H2Stream` handles, unknown task or
callback producers, retained C callbacks and managed callback results.
**Done:** every row has an executed check or an explicit rejection test; no
unexpected ARC rejection is accepted merely by counting it.

**G2 — Set the cycle and retention contract.** Review `src/arc.rs`,
`src/arc_scope.rs` and the channel/foreign interfaces against G1. Write concrete
examples for (a) a queued callback owning its receiving channel, (b) a persistent
subscription, (c) a graph with node deletion, and (d) a C-retained callback.
Specify who unregisters, when active calls finish, and what happens after owner
release, failure and cancellation. Keep channel close's existing queued-message
semantics. Start with independent scopes and non-owning graph IDs. Decide whether
any maintained use case actually requires a public weak handle; weak handles are
not an assumed implementation task. If selected, specify expired-target results
and prevention of reintroducing a strong cycle after acquisition.
**Done:** each example has an agreed accepted form or precise rejection, with
no promise to infer arbitrary foreign lifetimes or reclaim arbitrary ARC cycles.

**G3 — Implement the missing agreed contracts.** For each accepted G2 form, add
its proof in `src/arc_scope.rs`/`src/arc.rs`, ownership operations in
`src/ownership.rs`/`src/rc/`, and runtime teardown where required. Add the smallest
positive and negative tests to the corresponding channel, task, foreign or server
target. Prove that unregister/cancel waits for active users before releasing
captures. Unknown producers stay rejected until their ownership is demonstrated.
**Done:** success, failure, cancellation, reentry and repeated bounded-live work
release the same owners; deliberately omitted cleanup is detected. Invalid
inter-task derivative scopes remain rejected.

**G4 — Replace collector-dependent memory diagnostics.** Inventory each use of
`FWP_GC_STRESS`, `FWP_GC_VERIFY`, reuse poisoning and tracing-only controls in
`runtime/fwp_rt_gc.c`, tests and workflows. For each, identify the defect it detects
and supply an ownership-based check: missing release, stale borrow, invalid reuse,
wrong child ownership or double destruction. Cover native dynamic/static storage,
WASI allocation tables and external handles. Existing ARC allocation ledgers and
failure controls are the starting point, not missing features to reimplement.
**Done:** every replacement detects an intentionally broken implementation;
repeat counts grow while post-operation storage stays at the declared baseline.
Do not replace a diagnostic with permanent poisoned-object retention.

**G5 — Delete tracing.** After G1–G4, remove tracing selection and code from
`src/main.rs`, code generation, runtime allocator/root discovery, host adapters,
CLI help and tests. Keep allocator, stack and resource functions needed without
collection. Update protocols and examples together; no compatibility switch.
**Done:** all maintained targets pass the replacement controls; actual binaries
omit collector roots/marking/sweeping; supported programs retain their outputs,
error order and cleanup. Neither `GC=off` nor rejecting formerly maintained valid
programs counts as removal without an explicitly agreed language restriction.

## 2. Minimize ARC in named unshared paths

**A1 — Deliver prepared list-to-array moves and array-sort reuse.** Integrate the
prepared branch recorded in the handoff; update it for current contracts and CI.
An unshared list prefix transfers elements into the array; the first shared node
and its descendants retain independent owners. Sorting reuses only an eligible
unique array; aliases/views preserve their original contents. Inline 128-bit
sorting must not overwrite a later key. Existing focused six-host checks and
Linux measurements are retained; final integrated delivery still needs validation.
**Done:** the 4,096-word conversion control removes 4,096 retains without extra
allocations or peak charge; sort reuse removes its measured copy request. Preserve
failure/cancellation and bit-pattern controls. Report the measured instruction
and stack growth; do not claim a timing gain from count savings.

**A2 — Account for remaining counts in fixed fixtures.** Use the text/function
channel fixtures, cached-map reads, word frequency and packed descent reports.
For each remaining retain/release identify the owner and source operation in
`src/rc/borrows.rs`, `src/rc/` or `src/cgen.rs`. Classify it as necessary sharing,
a missed move/borrow, or bookkeeping for a still-boxed value. Record allocation,
retain, release, uniqueness-check and live-byte counts separately.
**Done:** a checked table explains every residual count for these fixtures and
names the next removable operation; a blanket “reduce ARC” item is not sufficient.

**A3 — Remove only the identified redundant ownership work.** Implement one
coherent class from A2, covering nested matches, last use, aliases and exceptional
exits. Extend existing direct-call, callback and runtime-call ownership tests.
**Done:** the predeclared per-fixture count reaches its target, live aliases keep
their values, and destruction timing is unchanged. Necessary shared owners remain.

**A4 — Remove remaining avoidable boxes in those paths.** Measure closure,
record/variant and loop-state boxes at known call sites. Extend direct-field or
stack representation only where size and escape lifetime are proved.
**Done:** the selected allocation disappears in real generated programs, with
no added count traffic or escaped stack address; report code size and stack cost.
This is not a requirement that all unbounded or escaping data live on the stack.

**A5 — Give proved unique heap values an ownership path without counts.**
Removing retains is insufficient if every buffer still carries a count and checks
it at destruction. Start with one variable-size array allocated in a function,
passed only through known non-escaping borrows, then destroyed by that function.
Prove uniqueness for its complete lifetime in the ownership/escape passes; emit
one direct destruction path instead of retain/release and uniqueness operations.
Keep counted representation for values that can actually acquire independent
owners or cross an unproved boundary; do not invent runtime promotion machinery
just to cover more cases. No public ownership annotation is assumed.
**Done:** actual allocated bytes and generated operations show no count slot or
count checks for the named owned-buffer fixture; failure/cancellation still free
it exactly once. Alias, captured and unknown-call controls must not select that
representation. Measure code-size and call-boundary costs before extending it.

## 3. Functional calls and recursion

**F1 — Define the acceptance fixtures.** Cover a composed pipe, partial
application, borrowed callback, captured closure, record/variant result, `each`,
`fold` and state loop. Pair each eligible case with an escaping/unknown-call case.
Use `src/mono.rs`, `src/opt.rs`, `src/cgen.rs` and the existing call-liveness tests.
Record expected direct calls, loops, boxes and necessary dispatch.
**Done:** interpreter/native outputs and effects agree, and each cost claim has
an allocation observation and inspection of the compiled program.

**F2 — Extend self-tail reuse only where cleanup permits.** Eligible direct
self-tail calls already reuse frames in the interpreter and native code, including
O0. Remaining cases include resource/task/channel owners and unknown captures.
For each proposed extension to `src/tailrec.rs`, specify when old owners die and
prove next arguments remain valid. Test swaps, failures, cancellation and deep
recurrence; retain ordinary-recursion and source-debugger controls.
**Done:** bounded call-stack use for the admitted recurrence, with measured heap
and frame costs. Do not mark existing plain-data support as unfinished work.

**F3 — Decide mutual recursion from a measured prototype.** Compare an internal
tagged loop with the equivalent explicit fwp loop for a fixed mutually recursive
pair. Measure dispatch, argument storage and code growth at O0/O2.
**Done:** accept with a lifetime proof and stated budgets, or record rejection
and retain ordinary call semantics. General foreign/unknown tail calls are not
an unconditional constant-stack promise.

## 4. CPU performance

**P1 — Refresh the checked-peer gaps using B1.** The recorded sessions show the
integer loop about 24%/15% slower than Rust on AMD64/ARM64 and direct character
counting about 58%/94% slower than C. These are historical host-specific results,
not current universal overhead. Rerun the actual `bench/loop` and
`bench/text-length` work with matched arithmetic, flags and outputs.
**Done:** repeated comparable baselines distinguish a persistent gap from noise.

**P2 — Repair one measured cost at a time.** For the persistent gap, separate
calculation, input/output, allocation and dispatch with explicit paired controls.
Inspect generated C and machine code for the selected program after checking
source correctness. Change only the proved redundant operation or representation;
do not resurrect rejected checked-arithmetic/inlining shortcuts without new proof.
**Done:** the B1 budget passes on both architectures, checked overflow and failure
order pass boundary tests, and regressions elsewhere remain reported.

**P3 — Check layout tradeoffs.** For each selected representation change, measure
size/alignment, cache-sensitive traversal, register spills, code bytes and stack
frames on ARM64/AMD64. Spilling is a normal allocation decision, not a fallback.
**Done:** the named workload meets its budget; smaller structures or fewer
instructions alone do not establish a speedup.

## 5. Differentiation

**D1 — Refresh and separate descent costs.** Run the existing Rosenbrock cases
at 3/33/129 coordinates and 0/1/199/1,999 updates where defined. Compare fwp AD,
fwp explicit derivatives, and explicit C/Rust implementations. Separate retained
history, list/array construction, derivative recording, reverse traversal and
printing; the C/Rust programs do not perform general AD.
**Done:** each ratio names equivalent work and its differences, with repeated
samples, allocation ledgers and bounded-workspace observations.

**D2 — Optimize the measured recording/workspace cost.** Use D1 to choose tape
entries, buffer growth/reuse or recomputation in the AD runtime; keep pure-step
requirements for replay. Extend `tests/ad_tape_scopes.rs` and
`tests/ad_tape_ownership.rs` with failure, cancellation and nested scopes.
**Done:** the selected per-size storage/time budget passes without retaining dead
scopes or changing derivative order. Output storage still scales with output size.

**D3 — Validate precision and nesting.** Test F64/F128 derivatives against
analytic examples and independent numerical checks with stated tolerances. Include
nested gradients, branch boundaries and checkpointed versus uncheckpointed work.
**Done:** documented domains/tolerances and per-depth costs; no derivative is
promised at a discontinuity and no constant-memory promise covers arbitrary AD.

## 6. CPU numerical kernels

**N1 — Establish kernel-specific budgets.** Use the existing 65,537-element
map/reduce and 65×67 by 67×63 matrix comparison, then add 262,145 elements
and 257×259 by 259×255 matrices using the same formulas and eight rounds.
Keep input values, reduction order, precision and output checks identical.
**Done:** B1-quality time, memory and accuracy baselines for both architectures.

**N2 — Optimize the selected kernel.** Change loop layout, data movement or
workspace in `src/linalg.rs`, code generation and the corresponding C runtime.
Keep explicit floating-point rules; reassociation/fused operations require an
agreed numerical contract. Extend `tests/linalg_ownership.rs` and kernel controls.
**Done:** accuracy, shape-error order, cancellation and the N1 budgets pass.
GPU execution and runtime compilation are outside this CPU roadmap.

## 7. Reproducible comparisons

**B1 — Set budgets before optimizing.** For each P/D/N workload run the same
baseline on two independent sessions per named host with identical inputs,
compiler flags and memory mode. Retain at least the protocol's existing sample
count and execution order; include an identical-code noise control. Choose and
record an absolute/relative regression threshold from those results before the
candidate measurement. If the control is unstable, repair the measurement first.
**Done:** a checked-in table states workload, revision, host, budget, statistic
and treatment of inconclusive results. No invented universal percentage.

**B2 — Enforce the table.** Extend benchmark review scripts to require the named
variants, samples, outputs, toolchains, binary hashes and memory observations;
retain deliberately invalid artifacts as rejection tests. Keep runtime timing,
compilation, startup, process memory and managed counts distinct.
**Done:** missing/changed evidence fails, all slower rows remain visible, and
CI compares against the declared baseline rather than silently resetting it.

## 8. Larger programs

**V1 — Finish the acceptance matrix.** Use the six families in
[application acceptance](docs/application-acceptance.md): word frequencies,
directory reports, text-file tools, a numerical pipeline, derivative descent and
a long-running HTTP/gRPC service. Preserve the listed inputs and add the missing
allocation-failure and scale cases, with expected results from independent checks.
**Done:** each family has explicit platform/memory-mode coverage, failure and
cancellation tests, bounded post-operation storage and a B1 budget where timed.

**V2 — Run and publish the integrated suite.** Validate all six native targets;
run the separately declared WebAssembly subset on its actual hosts. Record skipped
capabilities as gaps. Fix implementation or usability failures in the same work.
**Done:** every V1 row meets its criteria on the integrated source, and tutorials
explain the concepts needed to reproduce the supported program.

## Memory direction

Eliminate intermediates first; then use direct values, stack storage, moves and
borrows. Use uniquely owned heap storage for escaping or variable-size data and
ARC for necessary sharing. Neither disabled collection nor permanent retention
meets the objective. Keep [feasibility limits](docs/design-limits.md) explicit.

## Delivery and acceptance

Bundle related tasks into one PR at a time. Follow [AGENTS.md](AGENTS.md) and
[Contributing](CONTRIBUTING.md): all nine final-head production jobs plus the
documentation gate must pass. Memory claims also need the relevant failure,
cancellation, reuse and actual-binary evidence. A merge is not proof that every
roadmap milestone is complete. Full builds and measurements run on GitHub;
local focused checks use `scripts/local-guard.py` without raising its limits.
