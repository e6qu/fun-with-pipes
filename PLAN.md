# Implementation plan

Build an ahead-of-time compiled, strongly typed language with simple pipes,
immutable values and predictable memory use. Prefer moves, borrows and direct
values; use automatic reference counting (ARC) only for necessary sharing.
Tracing garbage collection (GC) is removed. JIT compilation is excluded.

This is early pre-alpha: every API, layout and calling convention may change.
Builds must not require a previous fwp version or self-hosting. Preserve agreed
language behavior; backward compatibility is not a goal. Keep single-argument,
curried, data-last functions, ordinary type inference, explicit generic signatures,
checked arithmetic, and observable effect/failure order.

## Where we are

**GC removal is verified in PR #217.** Tracing selection, root discovery, marking
and sweeping are removed. All nine production jobs, documentation and both
analysis-budget hosts passed; the merged tree matches the tested tree. Native
packages cover Linux, macOS and Windows on ARM64 and AMD64. Unproved owning cycles
remain rejected; weak links and independently owned workers provide explicit
alternatives. [Delivery history](docs/roadmap-history.md#tracing-gc-removal-pr-217)
records the source, checks and repairs.

**ARC minimization is incomplete.** Borrowing, moves, direct record/variant
fields, selected stack storage and unique reuse already remove costs. Other
unshared paths still allocate, update counts or check uniqueness. Removing the
collector is not the same as removing these costs. The
[ownership guide](docs/ownership.md) separates implemented rules from proposals.

## Work order

1. **A1–A5 are verified.** Deliveries #212, #218, #219 and #220 removed the
   selected array-copy, callback, temporary-owner and key-box costs. Preserve
   their [ownership measurements](docs/measurements/README.md), failure controls
   and actual-binary evidence. This does not make all containers count-free.
2. **A6 is current:** finish the [parser workspace](docs/parser-workspace.md).
   Its lifetime transformation passes focused native/WASI checks. Complete the
   [measured comparison](docs/measurements/parser-workspace.md), direct cancellation
   and compiler-budget controls in one batch, then run the full platform matrix. Include the guard-test fixture repair
   discovered after #220; [the handoff](docs/development-state.md) records it.
3. Preserve **G2**'s [analysis budgets](docs/measurements/ownership-analysis.md)
   and measure the new region-selection work separately. Further precision needs
   a named example and a cost comparison, not more diagnostic scaffolding.
4. Use **B1** to set per-workload timing budgets before further CPU or derivative
   optimizations. Keep slower and inconclusive results visible.

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

**G1–G5 are verified.** Entry/cycle rules, weak channels, retained C callbacks,
replacement ownership diagnostics and collector deletion shipped through #217.
Preserve the [admission matrix](docs/ownership-admission.md),
[six boundary contracts](docs/gc-removal-design.md#six-implementation-examples),
[cleanup/binary checks](docs/ownership-diagnostics.md) and
[G2 analysis budgets](docs/measurements/ownership-analysis.md).
[Delivery history](docs/roadmap-history.md#tracing-gc-removal-pr-217) owns the source
IDs, repairs and passing gates. These are maintained guarantees, not open tasks.

## 2. Minimize ARC in named unshared paths

**A1 is verified in #212.** [List-to-array moves and array-sort reuse](docs/measurements/array-sort-ownership.md)
remove the measured copying/count costs while preserving aliases and cleanup.
**A2 is verified in #218.** [The residual-cost report](docs/measurements/arc-residual-costs.md)
accounts for effective retains/releases in channels, cached maps, word frequency,
packed descent and local/shared arrays. Use its named owners to select changes;
preserve source IDs and distinguish code/stack costs from execution speed.

**A3 is verified in #218/#220.** Known scalar array callbacks avoid no-op count
attempts. Scalar record reads and known sort callbacks remove two temporary owners
per distinct word in the [word-frequency cases](docs/measurements/sort-key-ownership.md).
Required shared owners, evaluation order and exceptional cleanup remain tested.

**A4 is verified in #220.** [Contiguous integer/string sort keys](docs/measurements/inline-sort-keys.md)
remove one box and another temporary owner per distinct word. Exact budgets,
alignment, alias/failure/cancellation controls, binary/stack observations and two
independent timing runs passed. Isolated sorting and cleanup took 49–56% of the
previous fwp path's time on the measured hosts; this is not whole-program or
C/Rust parity. All nine final-head production jobs, docs and G2 passed.

**A5 is verified in #219.** The [restricted local-array path](docs/measurements/unique-array-storage.md)
proves one owner for the whole lifetime, allocates no count slots and frees storage
directly. Failure/cancellation, alias/capture/unknown-call rejection, weak-channel
type controls, actual WASI allocation and native binary checks passed. Preserve
these controls; broader element types, local transfers and loops need their own
lifetime proof and measured costs before this representation is extended.

**A6 — Give one workspace a region lifetime.** Follow the concrete
[parser-workspace contract](docs/parser-workspace.md). Use a recursive parser that builds
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
Also preserve the [parser comparison](docs/measurements/parser-workspace.md):
31/511/8,191-node balanced trees and a 127-node left-nested tree against its
explicit C/Rust peers. Tokenization and construction remain measurable costs;
keep owned-token versus borrowed-token differences explicit when selecting a fix.
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

Bundle related roadmap work. During implementation, run only checks justified by a changed
contract, a specific defect or an unresolved concern; do not repeat passing suites
after every edit or launch full CI for intermediate commits. Write the required
tests alongside the implementation, even when their broad execution is deferred.

After the implementation batch is complete, perform one consolidated local
validation, then the full final-head CI matrix. Local checks
remain serial and resource-guarded; record checks that cannot fit the limits and
run those on GitHub rather than bypassing the guard. Batch all known repairs
before repeating affected checks and required final gates.
Follow [AGENTS.md](AGENTS.md) and
[Contributing](CONTRIBUTING.md): all nine final-head production jobs plus the
documentation gate must pass. Memory claims also need the relevant failure,
cancellation, reuse and actual-binary evidence. A merge is not proof that every
roadmap milestone is complete. Full builds and measurements run on GitHub;
the consolidated local checks use `scripts/local-guard.py` without raising its
limits. Local resource limits do not waive final CI coverage.
