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
2. **A6 is verified in #221.** The [parser workspace](docs/parser-workspace.md)
   passes all nine production jobs, docs, focused native/WASI checks and four
   audited [measurement sessions](docs/measurements/parser-workspace.md). The G2
   repair passes both analysis hosts with unchanged limits. Parsing is faster
   than previous fwp, but allocated bytes rise and the C/Rust gap remains.
   **F1–F3 are verified in #222:** preserve the measured call costs, weak-handle
   frame rules and restricted scalar mutual loops. Remaining State `each`
   allocations are explicit in the report; functional syntax is not universally free.
3. Preserve **G2**'s [analysis budgets](docs/measurements/ownership-analysis.md)
   and measure the new region-selection work separately. Further precision needs
   a named example and a cost comparison, not more diagnostic scaffolding.
4. **B1/P1's two CPU baselines and their B2 integrity checks are verified
   in #223.** Six audited sessions establish matching
   Neoverse-N2 and EPYC 7763 pairs. [Frozen limits](docs/measurements/cpu-baselines.md)
   retain all observations and reject silent budget resets. **P2/P3's selected
   decimal-counting change is verified in #225**, including arithmetic, timing,
   code and stack tradeoffs. Proceed to D1–D3; broader B1/B2 coverage for A/D/N
   remains open.

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

**A6 is verified in #221.** One invocation of the
[parser workspace](docs/parser-workspace.md) owns aligned blocks; internal
integer/link nodes need no individual counts. Success, parse failure, nested
calls, cancellation and escaping-link rejection are covered. Repeated parses
restore the live-storage baseline. Measurements retain increased allocated bytes,
unchanged peak storage and the remaining C/Rust gap. Strings/tokens keep their
ordinary owners. This proves one scoped workspace, not a universal region system;
D2 may extend the approach to AD after measuring that workload.

## 3. Functional calls and recursion

**F1–F3 are verified in #222.** [Calls and recursion](docs/functional-costs.md)
owns the eight paired call fixtures, lifetime rules, actual allocation/stack
observations and accepted mutual-loop decision. All nine final-head production
jobs, docs and both G2 hosts pass; the merged tree matches that tested head.

F1 keeps exact known-call cost expectations alongside necessary unknown-call
controls. Some constructs still allocate: State `each` remains per-element.
F2 admits weak metadata and proved plain captures without discarding observable
cleanup. Strong resources, tasks and unknown captures keep their restrictions.
F3 accepts only matching scalar pairs; the longer O0/O2 measurements meet the
frozen limits, including visible slower results versus ordinary calls. Arbitrary
resource frames, foreign calls and all recursion are not constant-stack promises.

## 4. CPU performance

**P1 — Repeated CPU gaps are verified in #223.** The
[frozen CPU baseline](docs/measurements/cpu-baselines.md) covers checked `loop`
and `text-length` peers in six audited sessions. On the selected hosts, the loop
is about 14.4–14.5% slower than Rust on ARM64 and 39–40% slower on AMD64.
Character counting is about 92–95% slower than C on ARM64 and 106–107% slower
on AMD64. These complete-program timings include startup and cleanup; both fwp
programs report zero managed allocation requests and retains. The cause of the
remaining gaps is not established. All alternative-host results stay visible.
Also preserve the [parser comparison](docs/measurements/parser-workspace.md):
31/511/8,191-node balanced trees and a 127-node left-nested tree against its
explicit C/Rust peers. Tokenization and construction remain measurable costs;
keep owned-token versus borrowed-token differences explicit when selecting a fix.
**Done:** repeated comparable baselines distinguish a persistent gap from noise.

**P2 — Repair one measured cost at a time.** The
[proved-bounds experiment](docs/measurements/proved-scalar-bounds.md) rejected both
range-index and character-sum changes: neither meets the fixed improvement rule.
Keep its boundary tests and results; do not repeat those candidates as a speedup.
The [execution-phase diagnostic](docs/measurements/cpu-phases.md) identifies
calculation as the larger measured interval, with visible instrumentation effects
and an inconclusive AMD64 loop control. The [decimal-length report](docs/measurements/decimal-count.md)
rejects the bit-length/table candidate overall: ARM64 improves, AMD64 does not
qualify. The exact threshold tree now meets the frozen timing limits in two independent
sessions per architecture: 33.8–34.8% less text-counting time on ARM64 and
38.6–39.6% less on AMD64. The corrected measurement schedule balances both position
and preceding work; every rejected or inconclusive experiment remains recorded.
It still takes 25.0–26.2% longer than C. Code grows by 496/560 instruction bytes;
stack, readonly data and whole binary size are unchanged. **Verified in #225:**
all nine production jobs and documentation pass; the squash matches the tested
tree. [Delivery evidence](docs/roadmap-history.md#decimal-counting-and-current-derivative-baselines-pr-225)
records the checks and startup repairs. **Next:** D1–D3; the unchanged loop gap
remains explicitly unoptimized.
Keep signed-min handling, all binary/decimal boundaries and checked evaluation
order; record instruction, readonly-data, binary and stack costs. Bundle the
verified startup error-handling fixes and complete rejected measurements. For the persistent gap, separate
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

**D1 — Verified repeated baseline and fixed limits.** Four audited matching-host
sessions at `a31f24c4` cover all six Rosenbrock cases, complete outputs, per-process
samples, managed/raw storage, phase controls, actual binaries and stack reports.
Repeated solves keep identical-copy median variation below 1.66%, within the
predeclared 2% limit. The [report](docs/measurements/descent-costs.md) keeps earlier
noisy and rejected observations, equivalent-work differences and the large
remaining gap to explicit C/Rust derivatives. D2's limits were published before
its candidate. Preserve all observations and do not reset the limits.

**D2 — Deliver the measured eager-capture improvement.** PR #226 retains the
scalar `ad.push` no-escape proof: it removes one 40-byte argument allocation per
recorded operation. Its four paired sessions fail the original whole-solve speed
rule; that failure and every unchanged limit remain in the
[scalar-recording results](docs/measurements/descent-costs.md#scalar-recording-results-allocation-reduction-retained-speed-goal-open).
The user accepted the allocation reduction while leaving D2's speed goal open.

The next [eager-capture change](docs/measurements/eager-captures.md) meets its
separately declared budget in four audited matching-host sessions. It binds
computed arguments once, in their original order, so existing specialization can
remove temporary closures. Updated solves take 13–72% less time than the same
compiler with this transformation disabled; the largest current-result case
still takes 44–58 times the handwritten C derivative's time. Memory, output,
code and stack limits pass. The first rejected AMD host remains recorded.
Full CI exposed a mixed record-return C-generator defect; its repair passes 333
focused tests on each GCC ARM64/AMD64 and Clang ARM64 host. The repaired-source
recheck has one failure: AMD zero-update history is 2.28% slower than its reference
(limit 2%). The emitted C is unchanged. Preserve this failure and diagnose the
[timing variation](docs/measurements/timing-variation.md) before another acceptance run. Group
N1's prepared baseline work in the same PR. Require all nine final-head production
jobs, documentation and both G2 hosts before closing the selected D2 budget.
Preserve failure/cancellation, mixed/stale-node, tape-full and nested-gradient
controls. Do not fold F64 conversion elimination into this change: raw/native NaN
payload differences prevent a bitwise-identity claim. Arbitrary AD is not promised
constant memory or C/Rust parity.

**D3 — Verified in #226.** Analytic, finite-difference, branch-boundary and
checkpoint checks cover F64/F128. The [depth/size report](docs/measurements/ad-depth.md)
records the first three derivatives of `sum(x^4)` for 1/16/128 inputs, against
explicit fwp formulas, with managed/raw storage, code and stack costs. Both Linux
measurement matrices and all final production platforms pass. The
[delivery record](docs/roadmap-history.md#derivative-allocation-and-accuracy-pr-226)
owns source identities and audited gates. No accuracy claim extends beyond the
stated domains/tolerances; no derivative is promised at a discontinuity.

## 6. CPU numerical kernels

**N1 — Establish kernel-specific budgets.** Follow the
[frozen kernel protocol](docs/measurements/kernel-baselines.md). Use the existing 65,537-element
map/reduce and 65×67 by 67×63 matrix comparison, then add 262,145 elements
and 257×259 by 259×255 matrices using the same formulas and eight rounds.
Keep input values, reduction order, precision and output checks identical.
**Done:** B1-quality time, memory and accuracy baselines for both architectures.
Initial and repaired ARM sessions pass. Repaired AMD session 2 fails the small
matrix's identical-code control (3.27–3.49%, limit 2%); no qualified AMD session 1
completed. All evidence remains archived. Complete the timing diagnostic before
accepting the baselines or selecting N2; unchanged reruns are not a repair.

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
