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

1. Complete the [Swift comparison](docs/benchmarks.md#swift-comparison) and report
   current execution time and working memory alongside C/Rust. Prioritize those
   over executable size. For the returned-callable candidate, preserve its original
   ARM O1 size-budget failure; measure its timing benefit rather than infer it
   from fewer counts. Keep the hardware protection. Finish the production matrix
   before delivering any runtime change.
2. Resolve D2/N1's failed measurements before claiming numerical speed acceptance.
   Fixed CPU affinity and equal executable names did not resolve the controls.
   Do not rerun unchanged experiments or increase sample counts again.
3. Complete the remaining B1/B2 comparisons and finite V1/V2 application matrix.

[#231's scalar-fold delivery](docs/roadmap-history.md#direct-scalar-folds-and-process-timing-pr-231)
and [#232's array elimination](docs/roadmap-history.md#generated-array-elimination-pr-232)
have verified production gates; their timing acceptance remains open. Three of
four array-removal sessions fail the unchanged copy-control limit. The
[full-buffer comparison](docs/measurements/buffer-current.md) also retains its
25 failed controls out of 48; no workload qualifies in all four sessions.
Do not retry unchanged measurements or turn allocation savings into speed claims. The
[handoff](docs/development-state.md) owns current source IDs and check results.

[State range-list removal](docs/roadmap-history.md#state-range-elimination-pr-233)
is verified and merged in #233: two fixed allocations / 152 bytes, smaller code,
unchanged reported frames and preserved handler/cleanup behavior. No speed claim.

The original intermittent Intel macOS compiler abort remains an open defect.
Preserve [its evidence](docs/measurements/compiler-abort.md); diagnose a recurrence
from its source path and input. Passing reruns did not establish its cause.
Do not resume disassembly-led allocator experiments.

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

**A1–A6 are verified at the scopes below.** Preserve alias, failure, cancellation
and physical-free controls as ownership changes. These results do not make all
containers count-free or close the broader comparison work in B1/B2.

| Task | Delivered change | Evidence and remaining cost |
|---|---|---|
| A1, #212 | Move lists into arrays; reuse uniquely owned arrays for sorting | [Array ownership](docs/measurements/array-sort-ownership.md); shared values retain owners |
| A2, #218 | Attribute remaining counts to named owners | [Residual costs](docs/measurements/arc-residual-costs.md); channels, maps and numerical arrays still share storage |
| A3, #218/#220 | Avoid no-op scalar counts and temporary scalar-read/sort-callback owners | [Sort-key owners](docs/measurements/sort-key-ownership.md); required sharing and cleanup remain |
| A4, #220 | Store integer/string sort keys contiguously | [Inline keys](docs/measurements/inline-sort-keys.md); isolated sort/cleanup savings are not whole-program C/Rust parity |
| A5, #219 | Give restricted local arrays one owner without count slots | [Unique storage](docs/measurements/unique-array-storage.md); broader types/transfers need a new lifetime proof and measurements |
| A6, #221 | Use one aligned workspace for bounded parsing | [Parser workspace](docs/measurements/parser-workspace.md); faster parsing but more allocated bytes, unchanged peak and a remaining C/Rust gap |

Strings and tokens keep ordinary owners in A6. It proves one scoped workspace,
not a universal region system. Preserve [G2's analysis budgets](docs/measurements/ownership-analysis.md);
further proof precision needs a named example and measured compiler cost.

## 3. Functional calls and recursion

**F1–F3 are verified in #222.** [Calls and recursion](docs/functional-costs.md)
records eight paired fixtures, exact allocation expectations, lifetime rules,
stack observations and the accepted restricted scalar mutual-loop transformation.

Known calls avoid selected closure/dispatch costs; unknown calls retain required
owners. The historical State `each` baseline allocates per element;
[range-list removal](docs/measurements/state-range-folds.md), verified in #233,
eliminates that list for the stated known I64 consumer. Weak metadata and proved plain
captures may survive the loop transformation; strong resources, tasks and unknown
captures retain their restrictions. Arbitrary recursion, resource frames and
foreign calls are not promised constant stack space.

## 4. CPU performance

**P1 baselines are verified in #223.** [Six sessions](docs/measurements/cpu-baselines.md)
compare checked loops and text counting on Neoverse-N2 and EPYC 7763 hosts. The
unchanged loop is 14.4–14.5% slower than Rust on ARM64 and 39–40% slower on AMD64.
Its cause remains unproved; it is explicitly unoptimized. These whole-program
timings include startup and cleanup, with zero managed requests and retains.

**The selected P2/P3 decimal-counting change is verified in #225.** Its
[threshold tree](docs/measurements/decimal-count.md) takes 33.8–34.8% less time on
ARM64 and 38.6–39.6% less on AMD64 than previous fwp, while still taking 25.0–26.2%
longer than C. Instruction bytes grow by 496/560; stack, readonly data and whole
binary size stay unchanged. Earlier rejected range/inlining and bit-length/table
experiments remain in their reports; do not revive them as accepted speedups.

For further CPU work, separate calculation, I/O, allocation and dispatch before
selecting a candidate. Check source correctness before inspecting generated C
or machine code. Preserve checked arithmetic, signed-min boundaries and trap
order. P3 requires size/alignment, cache-sensitive traversal, code bytes and stack
costs on both architectures; fewer instructions alone do not establish speed.
Register spills are ordinary allocation decisions. The selected workload must
meet its predeclared B1 budget, with slower results retained.

## 5. Differentiation

**D1 — Verified repeated baseline and fixed limits.** Four audited matching-host
sessions at `a31f24c4` cover all six Rosenbrock cases, complete outputs, per-process
samples, managed/raw storage, phase controls, actual binaries and stack reports.
Repeated solves keep identical-copy median variation below 1.66%, within the
predeclared 2% limit. The [report](docs/measurements/descent-costs.md) keeps earlier
noisy and rejected observations, equivalent-work differences and the large
remaining gap to explicit C/Rust derivatives. D2's limits were published before
its candidate. Preserve all observations and do not reset the limits.

**D2 — Complete the remaining timing requirement.** PR #226 retains the
scalar `ad.push` no-escape proof: it removes one 40-byte argument allocation per
recorded operation. Its four paired sessions fail the original whole-solve speed
rule; that failure and every unchanged limit remain in the
[scalar-recording results](docs/measurements/descent-costs.md#scalar-recording-results-allocation-reduction-retained-speed-goal-open).
The user accepted the allocation reduction while leaving D2's speed goal open.

The [eager-capture change](docs/measurements/eager-captures.md), delivered in
#227, met its separately declared budget in the original four matching-host sessions. It binds
computed arguments once, in their original order, so existing specialization can
remove temporary closures. Updated solves take 13–72% less time than the same
compiler with this transformation disabled; the largest current-result case
still takes 44–58 times the handwritten C derivative's time. Memory, output,
code and stack limits pass. The first rejected AMD host remains recorded.
Full CI exposed a mixed record-return C-generator defect; its repair passes 333
focused tests on each GCC ARM64/AMD64 and Clang ARM64 host. The repaired-source
recheck has one failure: AMD zero-update history is 2.28% slower than its reference
(limit 2%). The emitted C is unchanged. Preserve this failure and diagnose the
[timing variation](docs/measurements/timing-variation.md) before another acceptance run.
All nine final-head production jobs, documentation and both G2 hosts passed
#227; the [delivery record](docs/roadmap-history.md#eager-captures-and-typed-numerical-loops-pr-227)
confirms the merged tree. D2 stays open because the timing rule did not pass.
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
[frozen kernel protocol](docs/measurements/kernel-baselines.md). The four implemented cases are map/reduce over 65,537 and 262,145 elements,
and 65×67 by 67×63 and 257×259 by 259×255 matrix products, each with eight rounds.
Keep input values, reduction order, precision and output checks identical.
**Acceptance:** qualified time, memory and accuracy baselines for both architectures.
The expanded run at `37da7441` completes both sessions on both CPUs. All matrix
and computation-only array controls pass. One AMD small-array allocation-inclusive
control fails at 3.08% (limit 2%); preserve that inconclusive overall result and
investigate it without an unchanged rerun. Audited GCC reports reproduce the
original binaries and show an integer loop accumulator in fwp versus a floating accumulator in C. The typed-state change shipped in #227,
passes its full production and focused bit/ownership checks and removes those conversions in GCC; N1
and N2 acceptance still require every stated control.


**N2 — Optimize the selected kernel.** The typed-state change in #227 passes full
production and focused GCC ARM64/AMD64 and Clang ARM64 checks, without timing acceptance. It gives F32/F64 loop fields native C types
and checks exact bits, nested/mixed owners, preparation failures and cancellation.
The inclusive measurement failure must be resolved and candidate budgets declared
before accepting a speed claim. Further candidates may change loop layout, data
movement or workspace in `src/linalg.rs`, code generation and the corresponding C runtime.
Keep explicit floating-point rules; reassociation/fused operations require an
agreed numerical contract. Extend `tests/linalg_ownership.rs` and kernel controls.
**Acceptance:** accuracy, shape-error order, cancellation and the N1 budgets pass.
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
**Acceptance:** a checked-in table states workload, revision, host, budget, statistic
and treatment of inconclusive results. No invented universal percentage.

**B2 — Enforce the table.** Extend benchmark review scripts to require the named
variants, samples, outputs, toolchains, binary hashes and memory observations;
retain deliberately invalid artifacts as rejection tests. Keep runtime timing,
compilation, startup, process memory and managed counts distinct.
**Acceptance:** missing/changed evidence fails, all slower rows remain visible, and
CI compares against the declared baseline rather than silently resetting it.

## 8. Larger programs

**V1 — Finish the acceptance matrix.** Use the six families in
[application acceptance](docs/application-acceptance.md): word frequencies,
directory reports, text-file tools, a numerical pipeline, derivative descent and
a long-running HTTP/gRPC service. Preserve the listed inputs and add the missing
allocation-failure and scale cases, with expected results from independent checks.
Directory allocation-boundary controls and the current word-frequency baseline
are verified in #228. The [string-result report](docs/measurements/direct-string-results.md)
retains two rejected candidates and a qualifying byte-search candidate: four
sessions show 16.4–19.2% less large-input time and 26,216 fewer managed requests,
with unchanged retains/peak and explicit code/stack costs. Complete delivery
gates and the bundled [file-read failure controls](docs/measurements/file-read-failures.md)
pass in #229; preserve their alias, recovery, cancellation and physical-free checks.

[File-boundary portability](docs/measurements/file-boundary-portability.md) is
verified in #230: both repaired Windows focused runs and the full production
matrix pass, including resource-frame and actual WebAssembly recovery cases.
The [delivery record](docs/roadmap-history.md#file-cleanup-portability-and-measurement-clocks-pr-230)
owns the source and audits. Numerical and integrated application acceptance remain open.
**Acceptance:** each family has explicit platform/memory-mode coverage, failure and
cancellation tests, bounded post-operation storage and a B1 budget where timed.

**V2 — Run and publish the integrated suite.** Validate all six native targets;
run the separately declared WebAssembly subset on its actual hosts. Record skipped
capabilities as gaps. Fix implementation or usability failures in the same work.
**Acceptance:** every V1 row meets its criteria on the integrated source, and tutorials
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
