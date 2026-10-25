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

PR #213 delivered the scoped subscriber and its success/failure/cancellation/
reentry checks on all six native targets. A1's array moves/reuse and G1's entry
matrix were delivered in #212. All final-head production and documentation gates
passed for both. [The handoff](docs/development-state.md) records exact source IDs
and current checks. Native packages cover Linux, macOS and Windows on ARM64 and
AMD64, one binary per target.

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

1. Finish **G2** under the [accepted ownership direction](docs/gc-removal-design.md):
   inferred moves/borrows, count-free unique storage, ARC for sharing, explicit
   weak references and rejection of unproved owning cycles. Specify the weak
   API and six acceptance examples. Current APIs and layouts are replaceable;
   returned functions and partial applications remain supported.
2. Implement **G3** and finish **G4** in the same PR; do not publish or validate
   G3 as a separate completed batch. Include tracing deletion **G5** where
   practical. Reuse the prepared fault
   checks; do not repeatedly expand diagnostics instead of removing tracing.
   Keep existing stress checks until replacement coverage is demonstrated.
   ARC minimization **A2–A6** is distinct from completing GC removal.
3. After GC removal, take the **A2** baseline for the unique-buffer fixture and
   implement **A5**; then use measured costs to order **A3/A4/A6**. General region
   inference and elimination of every count are not prerequisites for deleting GC.
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
| 1 | Remove tracing GC | G1–G5: explicit weak links and checked cycle rules, replacement diagnostics, no collector code or tracing execution mode |
| 2 | Minimize ARC in named unshared paths | A1–A6: count-free unique buffer, bounded scoped workspace and per-fixture budgets; sharing and cleanup preserved |
| 3 | Remove functional and recursion overhead | F1–F3: direct-call/loop coverage and bounded-stack proofs for stated cases |
| 4 | Close measured CPU performance gaps | P1–P3: agreed same-host budgets met without changing arithmetic or trap order |
| 5 | Reduce differentiation cost | D1–D3: derivative correctness and per-size time/storage budgets met |
| 6 | Improve CPU numerical kernels | N1–N2: accuracy, layout and timing budgets met for named kernels |
| 7 | Make comparisons reproducible | B1–B2: repeated baselines, fixed acceptance rules and complete retained evidence |
| 8 | Validate larger programs | V1–V2: the finite application matrix passes its correctness, cleanup and scale requirements |

## 1. Remove tracing GC

**G1 — Delivered in #212.** The [entry/rejection matrix](docs/ownership-admission.md)
maps maintained entries to executed checks and precise raw/optimized rejection
controls. Extend it when adding entries; do not repeat the completed inventory.

**G2 — Specify the accepted ownership direction.** Reject unproved owning cycles;
do not use Swift-style strong-cycle leaks as the reclamation policy. Write the
six examples in [the design contract](docs/gc-removal-design.md#six-implementation-examples):
(a) a callback owning its queue,
(b) a persistent subscription, (c) graph deletion/reuse, (d) C-retained callbacks,
(e) returned partial applications, and (f) recursive parser/autodiff workspaces.
Specify cleanup on release/failure/cancellation. Define weak target identities,
expiration, acquisition versus final release, and rules for storing acquired
owners. Scope-limited access alone does not prevent a store recreating a cycle.
Measure current analysis time, IR size, summary updates and specialization count
at N/2N/4N before increasing precision. Use the
[design and removal sequence](docs/gc-removal-design.md) as the accepted direction,
not evidence of implemented APIs.
**Done:** a written weak contract covers target types, acquisition, expiration,
release ordering, reuse and concurrency; all six examples have explicit expected
behavior; the analysis baseline and numeric regression budgets are recorded.
No promise to infer arbitrary foreign lifetimes or reclaim arbitrary ARC cycles.

Delivered G2–G3 subset (#213): [the cycle contract](docs/ownership.md#cycle-and-retention-contract)
and [lesson 24](docs/tutorials/24-subscriptions/README.md) specify a streaming,
task-owned subscriber using existing primitives. `tests/arc_tasks.rs` now checks
failure, active/unstarted cancellation, reentry, repeated awaits and per-round
reclamation, with deliberately broken cleanup controls. All nine production jobs
and documentation passed. The tracing-only queue/task/stream decisions in
[the admission matrix](docs/ownership-admission.md) remain separate unfinished work.

**G3 — Implement weak references and the boundary contracts.** The first
[weak-channel implementation](docs/weak-channels.md) is in the current preparation,
with tests written but integrated validation pending. First complete
one complete weak path in the interpreter and native runtime: live/expired
acquisition, final release, metadata release and address reuse. Synchronize only
where permitted sharing requires it. Then cover the six G2 examples and all
remaining admission rows. Add proof rules in `src/arc_scope.rs`/`src/arc.rs`,
ownership operations in `src/ownership.rs`/`src/rc/`, and runtime teardown.
Check stores/captures of acquired owners, not just the acquisition's scope.
Prove unregister/cancel waits for active users before releasing captures.
Use finite dependency-driven summaries for any added precision, with the G2
scaling gate; unknown producers remain rejected until ownership is demonstrated.
**Done:** success, failure, cancellation, reentry and repeated bounded-live work
release the same owners; deliberately omitted cleanup is detected. Invalid
inter-task derivative scopes remain rejected.
Weak and counted paths preserve the agreed expiration/effect order; no reused
address revives a dead target, and no control metadata remains after its last user.

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

Current G4 group: [the diagnostic guide](docs/ownership-diagnostics.md) specifies
the live-address ledger, existing byte checks, deliberately broken controls and
remaining gaps. It is applied to the native ARC corpus and dynamic/static probes.
The inventory retains source/hash/line evidence; it is not itself a coverage proof.
The next preparation extends the ledger to callback, reuse-token, variant and
stack-child checks. It adds missing-child and duplicate-destruction controls and
repairs null empty-argument operations in the C runtime. A native ARC file probe
checks actual OS closure, shutdown deregistration and byte reclamation separately.
The diagnostic guide maps
each deliberate fault to its observer; full platform validation remains required.
Next: complete the separate WASI/external-resource mapping, including cancellation
and external callback entry, before removing any collector diagnostics.

**G5 — Delete tracing.** After G1–G4, remove tracing selection and code from
`src/main.rs`, code generation, runtime allocator/root discovery, host adapters,
CLI help and tests. Keep allocator, stack and resource functions needed without
collection. Update protocols and examples together; no compatibility switch.
**Done:** all maintained targets pass the replacement controls; actual binaries
omit collector roots/marking/sweeping; supported programs retain their outputs,
error order and cleanup. Neither `GC=off` nor rejecting formerly maintained valid
programs counts as removal without an explicitly agreed language restriction.

## 2. Minimize ARC in named unshared paths

**A1 — List-to-array moves and array-sort reuse (delivered in #212).** All nine
production jobs and documentation passed on the integrated source. The
[measurement report](docs/measurements/array-sort-ownership.md) records source IDs,
controls, count savings and code/stack costs.
An unshared list prefix transfers elements into the array; the first shared node
and its descendants retain independent owners. Sorting reuses only an eligible
unique array; aliases/views preserve their original contents. Inline 128-bit
sorting must not overwrite a later key. Existing focused six-host checks and
Linux measurements are retained alongside the passing integrated delivery.
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
Include attempted weak creation/acquisition as a control: it must not silently
promote a unique allocation into shared ownership or invalidate the proof.

**A6 — Give one workspace a region lifetime.** Use a recursive parser that builds
and walks an expression graph inside one invocation. The invocation owns the
storage; internal links do not own individual nodes. Return a scalar result or
an explicitly owned copy, never an expired internal link. Add success, parse-error,
nested invocation and cancellation cases, plus rejection of an escaping link.
**Done:** repeated fixed-size parses restore the same live-storage baseline;
internal node links need no reference counts. Report peak retained storage and
construction/traversal/cleanup time against equivalent C/Rust arenas. Preserve
alignment and resource cleanup. This establishes one scoped workspace, not a
universal region system; D2 may extend it to AD after measuring that workload.

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

**B1 — Set budgets before optimizing.** For each A/P/D/N workload run the same
baseline on two independent sessions per named host with identical inputs,
compiler flags and memory mode. Retain at least the protocol's existing sample
count and execution order; include an identical-code noise control. Choose and
record an absolute/relative regression threshold from those results before the
candidate measurement. If the control is unstable, repair the measurement first.
For ownership work use the [four planned comparisons](docs/benchmarks.md#planned-ownership-comparisons)
and measure compiler analysis separately from generated-program execution.
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
ARC for necessary sharing. Explicit weak edges break selected cycles; scoped
regions suit grouped lifetimes. Reject unproved owning cycles and preserve
escaping functions. Neither disabled collection nor permanent retention meets
the objective. The [accepted direction](docs/gc-removal-design.md) owns these
rules; [feasibility limits](docs/design-limits.md) bound the guarantees.

## Delivery and acceptance

G3 and G4 must ship in the same PR. Keep the remaining GC-removal work together
where practical. During implementation, run only checks justified by a changed
contract, a specific defect or an unresolved concern; do not repeat passing suites
after every edit or launch full CI for intermediate commits. Write the required
tests alongside the implementation, even when their broad execution is deferred.

After G4 and all other changes included in the PR are complete, perform one
consolidated local validation, then the full final-head CI matrix. Local checks
remain serial and resource-guarded; record checks that cannot fit the limits and
run those on GitHub rather than bypassing the guard. Batch all known repairs
before repeating affected checks and required final gates. Existing #214
validation can finish independently.
Follow [AGENTS.md](AGENTS.md) and
[Contributing](CONTRIBUTING.md): all nine final-head production jobs plus the
documentation gate must pass. Memory claims also need the relevant failure,
cancellation, reuse and actual-binary evidence. A merge is not proof that every
roadmap milestone is complete. Full builds and measurements run on GitHub;
the consolidated local checks use `scripts/local-guard.py` without raising its
limits. Local resource limits do not waive final CI coverage.
