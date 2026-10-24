# Benchmarks: what is compared, and what fwp costs

There is no single measured “fwp overhead.” The extra time or memory depends on
the program, the implementation used for comparison, compiler settings and the
machine. This page separates two different questions:

1. **How long do these fwp programs take compared with C and Rust programs?**
   The examples in `bench/` answer this for complete executable runs.
2. **Does a particular fwp optimization reduce work or storage?** The reports
   under `docs/measurements/` usually compare two fwp implementations. Those
   fwp-only comparisons do not measure overhead relative to another language;
   the numerical reports that do include C/Rust are identified separately below.

The measurements below are dated observations. They do not promise the same
ratios on another machine or establish that the whole language is “zero-cost.”

Early one-off allocation probes are archived with their original compiler setup:
[derivative scopes](https://github.com/e6qu/fun-with-pipes/blob/27a3e009b83e28f06130a5d686a3196b9934e53f/scripts/measure-ad-scope-allocations-complete.py),
[list callbacks](https://github.com/e6qu/fun-with-pipes/blob/27a3e009b83e28f06130a5d686a3196b9934e53f/scripts/measure-list-callback-allocations-complete.py),
and [typed state](https://github.com/e6qu/fun-with-pipes/blob/27a3e009b83e28f06130a5d686a3196b9934e53f/scripts/measure-typed-state-allocations-complete.py).
Their results remain historical evidence; these scripts are no longer maintained
commands. Current comparisons name ARC or tracing explicitly.

The [application acceptance suite](application-acceptance.md) names the larger
programs, current checks and remaining measurement gaps. The first
[word-frequency baseline](measurements/wordfreq.md) records a 3.29–3.52× ARC/C
time ratio for its larger input on two Linux hosts, with the implementation
differences stated explicitly. The [unchanged-text candidate](measurements/unchanged-text.md)
removes copies and reports paired old/new costs without hiding the remaining gap.
The [string-map comparison](measurements/string-map-ownership.md) then moves
unique string owners through normalization: larger-case ARC is 6.2–7.7% faster
than its paired fwp baseline, while still taking 2.57–3.05× the C time.
The [descent comparison](measurements/ad-application.md) measures saved history
versus current weights and separates managed storage, raw tape buffers and
process memory. The [four-way derivative baseline](measurements/descent-peers.md)
compares fwp AD, explicit fwp derivatives and explicit C/Rust implementations.
It identifies substantial remaining AD and representation costs without calling
the whole difference compiler overhead. The subsequent
[packed-array comparison](measurements/packed-descent.md) removes most allocation
requests but leaves counted ownership work and a 3.34–3.40× C-time gap in its
largest case; its small zero-update AMD64 control is slower.
The [array-owner move](measurements/array-owner-moves.md) halves those retains
without increasing allocation requests or managed peak. Its revised protocol
balances predecessor programs and includes byte-identical controls; timings remain
inconclusive, and ARM64 uses a 16-byte larger callback frame.
The [borrowed-capture comparison](measurements/array-capture-descent.md) removes
all remaining retains in those packed descent cases, with unchanged allocation
counts and managed peak. Its largest case takes 2.33–2.38× C time; the report
preserves noisy controls, slower cases and slightly larger instruction sections.
The [helper-call diagnostic](measurements/descent-call-costs.md) compares unchanged
generated C with hinted and forced inlining. Neither reaches its predeclared 5%
speed target on both hosts; it does not justify a compiler inlining rule.
The [direct-call comparison](measurements/direct-call-entries.md) removes unused
generic adapters, shrinking largest-case instructions by 18–19% without changing
allocation/count profiles. Timing remains inconclusive, including slower cases.
The [repeated-work protocol](measurements/descent-batch-protocol.md) diagnoses
startup noise with complete repeated solves and two identical-code controls.
Its [initial result](measurements/descent-batches.md) exposes a larger full-solve
gap: the largest case takes 9.81–12.00× C time and 12.30–17.13× Rust time.
Different formula evaluation, buffers and formatting remain part of that ratio.

The [callback-local comparison](measurements/callback-locals.md) removes another
function record and generic entry while preserving the allocation/count budgets.
The [between-solve checks](measurements/descent-observers.md) verify zero live
storage at every checkpoint and demonstrate why final-only checks are insufficient.
The [matched-formula comparison](measurements/coordinate-work.md) adds coordinate-based
C/Rust peers while retaining the original edge-based programs. Its largest case
takes 10.40–13.69× C time and 11.86–14.07× Rust time; formula arrangement does not
close the gap. Per-solve probes also check actual C/Rust buffer releases. The
report preserves one failed timing control and explains the different memory scopes.
The [output-cost protocol](measurements/descent-output-protocol.md) compares
ordinary printing with a shared consumer of every result coordinate. Its
[initial result](measurements/descent-output-initial.md) passes correctness and
binary inspection but has five inconclusive timing rows. The
[longer repetitions](measurements/descent-output-longer.md) pass repeated controls
for nine of twelve input/host pairs, including the largest on both architectures;
three AMD64 pairs remain inconclusive. The protocol explains why the checksum
variant is not pure arithmetic time.
The [float-text comparison](measurements/float-text-results.md) reuses rounded
decimal digits while preserving exact output. Matching-model repetitions pass
the predeclared speed screen on both architectures. The report retains all
inputs, C/Rust gaps, unchanged allocation counts and increased stack/code size.

The current [array/text group](measurements/array-text.md) removes temporary lists,
String copies and initial iterator tuples. Its [allocation and binary results](measurements/array-native-results.md) and [complete
C/Rust comparisons](measurements/array-output-results.md) are separate evidence: fewer heap requests alone do not prove
a timing gain. [PR #206](roadmap-history.md#array-output-storage-and-startup-stack-pr-206)
passed final delivery checks. The reports retain source identities, noisy rows
and the startup-stack repair.

## Choose the question first

| Question | Read | What the number means |
|---|---|---|
| How much slower/faster than C or Rust? | [Complete programs](#fwp-compared-with-c-and-rust), [arrays/matrices](#numerical-kernels-and-record-moves), [derivative descent](measurements/descent-peers.md), [hashing](#repeating-the-allocation-and-borrowing-changes-together), [vector lanes](#fixed-size-lane-calculations-against-c-and-rust) | Ratio against the named C/Rust implementation for that input and timing boundary |
| Did a compiler change help? | [Iteration](#list-iteration-compared-with-its-previous-definition), [derivatives](#paired-autodiff-metadata-allocations), [HTTP functions](#fixed-function-values-in-the-http-server), [maps](#larger-maps-exposed-a-storage-layout-problem) | New fwp / baseline fwp; not overhead against another language |
| How much ownership work does a channel exchange need? | [Method and baseline](measurements/channel-transfer-protocol.md), [matched payloads](measurements/channel-variant-moves.md), [direct-call borrowing](measurements/channel-direct-borrows.md), [function channels](measurements/function-channel-borrows.md) | Allocations, retains and actual binary/frame sizes; no execution-time or C/Rust comparison |
| Can task records use less heap storage? | [Saved CPU state in task stacks](measurements/task-contexts.md) | Matched fwp layouts: managed bytes, process memory, complete-process time and actual binary/static sizes |
| Can cancellation state use the active stack? | [Cancellation-storage comparison](measurements/task-cancellation.md) | Six-host fwp layout comparison: managed bytes, retained owners, entry-frame and executable sizes; no timing or process-memory claim |
| Can scheduler metadata be smaller? | [Task flags and ARC stack markers](measurements/task-records.md) | Six-host matched fwp layouts: 32 fewer bytes per ARC task, unchanged allocation/retain counts, allocator-dependent peak savings; no timing claim |
| Can task creation avoid redundant ownership work? | [Callback transfer](measurements/queued-task-handles.md) | Same generated C with/without five restored retain/release pairs: 10 → 5 retains, unchanged allocations/bytes; six native hosts, no timing claim |
| Can immediate task-result matches avoid boxes? | [Await fields](measurements/task-await-fields.md) | Same generated C with and without temporary option boxes: 134 → 100 allocation requests, 544 fewer requested bytes, unchanged retains and peak storage; no timing claim |
| How much does grouped integer counting cost? | [Controlled CPU comparisons](measurements/integer-counting.md) | Paired old/new fwp, matched C/Rust, explicit CPU placement and all samples |
| Can checked multiplication preserve numeric bounds? | [Checked-product comparison](measurements/checked-products.md) | Actual compiler output, per-CPU C/Rust gaps, dynamic-input controls and O0/O1 costs |
| What does integer-text elimination save? | [Direct character counting](measurements/integer-text.md) | Native results and allocation controls; time against C/Rust counting versus formatting |
| Does storage release correctly? | [Clients](#memory-used-by-complete-remote-stream-clients), [servers](#server-memory-after-completed-remote-calls), [C results](#returning-owned-values-to-c-callers), [failure cleanup](#cleanup-after-failed-map-and-set-operations) | Allocation/count/live-byte checks; most contain no timing benchmark |
| How do I reproduce it? | [Running comparisons](#running-comparisons) | Select the exact source, suite, control and host; retain raw evidence |

Every result below is tied to its recorded revision. Historical reports explain
why a change was made; they are not measurements of the latest checkout.
“Four hosts” means Linux/macOS × ARM64/AMD64; “six native hosts” also includes
Windows × ARM64/AMD64. Actual CPU models and compiler versions are in each report.

**Reading an overhead figure:** divide fwp time by the named baseline time.
`1.25×` means 25% more time; `0.80×` means 20% less. A ratio of medians and a
median of paired ratios are different statistics; use the method stated for that
report. Elapsed time includes waiting to run; child CPU time sums user/system
processing time. Neither alone identifies the cause of a gap. Allocation-count
percentages are not time percentages.

## Self-tail recursion compared with an explicit loop

`scripts/measure-tail-recursion.py` compares two current fwp programs: a recursive
countdown lowered by the compiler and the same countdown written with `loop`,
`Again` and `Stop`. Each starts at the requested positive integer, subtracts one
until zero, prints zero and exits. This is an abstraction-cost comparison within
fwp, not a C/Rust baseline or a test of arbitrary recursive algorithms.

Run it on a GitHub Linux runner with explicit compiler/tool paths, iteration count,
sample count, subprocess timeout and output directory. The focused language job
selects one million iterations, eight samples per variant and both O0/O2 under
tracing/checked ARC. It records the CPU, compiler version, exact commands and
runtime settings. Timings cover fresh-process startup, the countdown, printing,
output capture and teardown; compilation and profiling are excluded. Run order
alternates each round. Ratios are recursive median / explicit-loop median;
extra time is `(ratio - 1) × 100%`. Constant function-entry/scheduler costs may
still differ; small timing differences need repeat measurements.

Separate profiles compare 1,000 iterations with the full count. They count
managed allocation requests, retain operations, allocator-charged peak bytes and
remaining charge after teardown. The check requires equal allocation counts and
peak charge at both sizes, with zero final charge; it does not measure process
RSS or external library memory. Each actual executable is disassembled and saved
with generated C and compiler stack-use estimates. Those estimates are per
function, not a measured aggregate peak. Whole-file sizes include debug data.
Deep O0/interpreter execution checks separately verify that eligible recursive
calls do not accumulate call frames. [Accepted recursion checks](roadmap-history.md#mixed-tail-recursion-pr-171)
record the tested scope; these checks do not establish general speed or
zero-allocation results.

The mixed-recursion regression fixture is separate from this countdown benchmark.
It checks results and cleanup with both tail and ordinary recursive calls, using
200,000 tail steps and smaller raw-interpreter references. Retained C, binaries
and disassembly support inspection; these tests do not measure elapsed-time
improvement, stack bytes or parity with C/Rust. Ordinary recursive calls retain
their stack cost, and frame reuse can prevent local objects from using stack
storage. Neither cost is quantified by the countdown comparison.

## fwp compared with C and Rust

Each directory in [`bench/`](../bench) contains `main.fwp`, `main.c` and
`main.rs`. The programs must print the same result. The runner builds native
executables with `fwp build --gc MODE -O2`, the explicitly selected `CC -O2`,
and `rustc -O`. `FWP_BENCH_OWNERSHIP` must name `arc` or `tracing`; there is
no implicit measurement mode. `CC` must name the compiler and `FWP_LTO=0`
keeps generated C in one source file without link-time optimization.
Production CI selects checked ARC, matching the
language's current native default. The scalar-text historical comparison explicitly
selects tracing. After one warmup per
executable, it measures six runs each and reports the median: the average of
the two middle times after sorting. Execution order rotates C/Rust/fwp,
Rust/fwp/C and fwp/C/Rust, twice. “Native” means machine code;
this comparison does not time the fwp interpreter.

The clock covers **process startup, input construction, calculation, allocation
and printing**. It excludes compilation. It is not a measurement of just the
inner calculation, startup alone or peak memory. The report separately records
one compilation time and the executable file size for each implementation.
Compilation includes tool startup and linking; it excludes building the fwp
compiler itself. Binary sizes include differing runtime and linking choices.
The report names its memory mode and build flags. Older snapshots below use
tracing; they are not checked-ARC measurements and do not become such when the
runner changes. Do not infer an ARC speedup from different runs or hosts.
ARC means automatic reference counting, which releases objects when their last
owning reference disappears.

The runner retains the measured executables and source inputs in
`target/bench-evidence`, grouped by source commit and invocation, with a copy of
each invocation's timing report. It separately
emits fwp's generated C after timing, using the same compiler and settings;
that extra emission is outside both execution and reported compilation times.
Both benchmark workflows upload this evidence. Earlier timing-only artifacts
cannot establish what their machine instructions looked like.

The focused `benchmark-comparison` suite also measures peak process memory with
GNU time in three separate runs of each actual timed executable. Separate fwp
binaries count managed allocations, retain operations and charged live storage;
these exclude raw buffers, stack storage and allocator metadata. Each instrumented
program is paired with an intentional unreleased allocation that the observer
must detect. Their timings are not used. Saved C, binaries, observations and
stack reports permit inspection; those stack reports describe the instrumented
images, not the original timed programs. C/Rust allocation counts are not measured.

### What each program actually does

| Program | Input and work | Important differences between implementations |
|---|---|---|
| `fib` | Compute `fib(35)`, with `fib(0)=0`, `fib(1)=1`, otherwise `fib(n-1)+fib(n-2)` | Same recurrence. Compilers can transform calls differently. fwp checks integer overflow; these C and optimized Rust builds do not have the same overflow guarantees. These inputs fit all three. |
| `loop` | Start `(i, sum)=(100000000, 0)`; add `(i*3)%7`, decrement `i`, stop at zero | fwp expresses the loop state as a pair; its compiler can turn that into local variables. C and Rust write the loop directly. Checked arithmetic and generated code can still differ. |
| `map` | Build `(key(i), i)` for `i=0..499999`, where `key(i)=(i*7919)%1000003`; sum 2 million lookups using the same key formula, missing values as zero | All three use contiguous sorted pairs searched by bisection. C uses `qsort`, Rust `sort_unstable_by_key`, fwp its map builder; construction/sorting costs differ. This compares complete implementations, not an isolated lookup operation. |
| `range-set` | Build the distinct keys `0..999999`, then compute FNV-1a over the canonical set encoding: unsigned LEB128 count followed by eight little-endian bytes per key | All three start with ordered keys and need no sorting. C uses a heap buffer, Rust a vector, fwp a set. Hash multiplication wraps modulo 2^64 in all three. Optimizers may remove storage or combine loops; inspect retained binaries before claiming equal allocations. Runtime startup, allocation, hashing and output are timed together; the report explicitly names its ARC or tracing mode. |
| `pipeline` | For `0..999999`, multiply by 3, keep even results and sum; sum 20 rounds | fwp can combine the stages into one traversal without intermediate lists. C explicitly fills arrays; Rust constructs vectors and filters them. Eliminating that work can outweigh language overhead. |
| `strings` | For `i=0..1999999`, concatenate decimal `i`, decimal `3*i` and `#`; sum text lengths | fwp can calculate some formatted lengths without creating the string. C uses `snprintf` and `strlen`; Rust uses `format!` and byte length. All characters here are ASCII, so the lengths agree. The programs need not perform the same formatting or allocation work. |
| `text-length` | The same input, fwp pipeline and result as `strings`; C and Rust count decimal digits in groups of 16, 8, 4, 2 and 1, without formatting text | This compares fwp's elimination of temporary text against handwritten counting. All three check multiplication and sums for overflow; the inputs fit. The C/Rust failure messages differ and are not exercised. Startup, output, scheduling and remaining ownership work are still included; matching algorithms do not establish equal machine instructions. |

A result that is faster than C here does not mean fwp outperforms the best
hand-written C version. Likewise, a slower result does not identify how much
came from reference counting, collection, checks, allocation or the algorithm.
The timing runner does not measure those costs separately.
The [integer-text report](measurements/integer-text.md) records the first
two-host direct-counting comparison and its raw samples. Older six-program
measurements do not include this new peer comparison.

### Current ARC baseline

The [two-host ARC comparison](measurements/arc-comparison.md) records all seven
programs, samples and inspected executables on AMD EPYC 9V45 and Neoverse-N2.
It preserves slower loop and text-length results and explains unequal arithmetic
guarantees. It is a descriptive baseline, not a measured ARC speedup.

The [checked-arithmetic experiment](measurements/checked-bounds-protocol.md)
tests whether return expressions preserve useful bounds. Its screen is fixed
before results; it does not change the compiler.

### Historical tracing example and overhead

The [2026-10-18 report](measurements/complete-programs-2026-10-18.json) records
source `7c2b5638881cea6b476997b333aa61006dba1381` and this passing
[benchmark job](https://github.com/e6qu/fun-with-pipes/actions/runs/39092728270/job/117572692192).
It ran on a Linux AMD64 runner with four logical CPUs reporting an AMD EPYC 7763,
GCC 13.3.0 and Rust 1.99.1. All three map implementations use sorted pairs.
These are six-run medians, with samples rounded to 0.001 ms in the saved report.
[PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165) records
full acceptance after the Windows failures in that development run were repaired.

| Program | C | Rust | fwp | Extra fwp time versus C | Extra fwp time versus Rust |
|---|---:|---:|---:|---:|---:|
| `fib` | 20.310 ms | 29.174 ms | 13.427 ms | −33.9% | −54.0% |
| `loop` | 94.445 ms | 125.738 ms | 127.146 ms | +34.6% | +1.1% |
| `map` | 382.480 ms | 311.772 ms | 423.266 ms | +10.7% | +35.8% |
| `pipeline` | 27.546 ms | 15.063 ms | 24.033 ms | −12.8% | +59.6% |
| `strings` | 167.595 ms | 166.028 ms | 198.031 ms | +18.2% | +19.3% |

Use `(fwp time / baseline time − 1) × 100%`. For example, `127.146 / 94.445`
is about `1.346×`, or 34.6% longer than the C loop. A negative percentage means
less elapsed time. Always name the baseline: the same fwp loop is only about
1.1% longer than Rust in this run. Do not average these into a language-wide
score: each program has the comparison limits described above.

The map gap includes constructing and sorting its input, as well as lookups;
it cannot identify how much time comes from temporary lists or reference counts.
The pipeline's fwp samples range from 20.737 to 36.057 ms, so its median is not a
stable regression threshold. The report retains all 90 elapsed samples, 15
compilation times and 15 binary sizes. It has no allocation or memory-use counts,
and does not measure checked ARC. Separate ownership reports below provide those
measurements for their stated workloads. No speedup over an older fwp revision
is claimed from this single runner's comparison.

The runner writes `target/bench.md`, the GitHub job summary and a downloadable
`benchmarks` artifact. It reports both ratios and percentages, all six samples,
the source commit, OS/architecture, compiler versions and Linux/macOS CPU details.
Rotating order reduces systematic order bias, but shared-runner load still
affects results. Timing is reported, not used as a pass/fail threshold. Output
disagreement is a failure.

## Numerical workloads compared with C and Rust

Use the [latest recorded numerical comparison](#numerical-kernels-and-record-moves)
for the array and matrix results. It separates calculation time from construction
and cleanup, and compares both tracing and checked ARC against C and Rust.
“Latest recorded” names a dated report, not a new measurement of today's checkout.

The earlier [2026-10-12 report](measurements/ownership-and-arc-2026-10-12.json)
used five samples and tracing mode only. For example, its Linux AMD64 array
calculation took 2.66 times the C time; Intel macOS matrix calculation took
3.24 times C. Its raw times and memory profiles remain available, but its old
compiler and smaller sample count make it unsuitable as the current baseline.

Code-size reports distinguish the whole executable from its `.text`/`__text`
section, which contains machine code and padding. A section byte total is not a
decoded instruction count. Historical numerical JSON records call this total
`instructionBytes`; new records use `textSectionBytes`. Keep old measurements
under their original source identity instead of rewriting them as new data.

## Understanding memory measurements

The more focused reports also count memory operations. These quantities answer
different questions:

- **Allocation requests:** how often code asks for memory. Fewer requests do not
  necessarily mean fewer bytes or less elapsed time.
- **Cumulative requested bytes:** add the sizes of all requests, including
  requests to grow the same block. This is neither peak memory nor copied bytes.
- **Peak live payload:** the largest amount of requested program data held at
  once. It excludes the allocator's bookkeeping and temporary copies inside
  reallocation. It is not the process's full resident memory reported by the OS.
- **Managed storage:** language objects tracked by the runtime. Some reports
  count numerical tape buffers separately. Separate peak values may occur at
  different times and must not be added as a measured simultaneous peak.
- **Retains/releases:** updates to owning references. **Collections:** runs of
  the tracing garbage collector. Zero collections in one tested program is not
  proof that every program can avoid collection.

A *control* is a deliberately changed implementation used for comparison. For
example, disabling one optimization in the current compiler isolates that
optimization better than comparing unrelated compiler releases. It still does
not reproduce every cost of an earlier release.

## List iteration compared with its previous definition

`each` calls a supplied function for every list element and returns `()`, meaning
no result. Its previous definition used `map`, which builds a list of results,
then discarded that list. The replacement walks the input with `fold`, keeping
only a running value of `()`. Both must perform the same calls in the same order.

The comparison counts elements using integer state:

```fwp
main = range 0 3 | run-state 0 (each (const (add 1) | modify)) | .1 | echo
```

`|` sends a result to the next function. `range 0 3` produces three integers.
`const (add 1)` ignores each integer and supplies the increment function to
`modify`, which updates the current state. `run-state 0` starts that state at zero
and returns `(result, final-state)`. Positions start at zero, so `.1` selects the
final count and `echo` prints `3`.

[`measure-list-each.py`](../scripts/measure-list-each.py) compares both definitions
at 10,000, 100,000 and 1,000,000 elements on Linux runners. It records seven samples
in alternating order after a warmup. Timing includes process startup, input
construction, updates, printing and cleanup. Both use the same C compiler and
`-O2`, with tracing disabled and ordinary freeing enabled. The report also records
peak process memory, build commands/times and binary sizes. Separate 32/128-element
tests count allocations without contaminating timed executables with counters.

The [accepted comparison](measurements/service-context-iteration-2026-10-16.json)
at `20f0f5f0` passes the focused checks on all six native hosts. At one million
elements, the Linux medians are:

| Host | Previous definition | Current definition | Less elapsed time | Peak memory, previous/current |
|---|---:|---:|---:|---:|
| AMD64 | 56.93 ms | 27.30 ms | 52.1% | 79,216 / 37,648 KiB |
| ARM64 | 66.70 ms | 32.80 ms | 50.8% | 77,496 / 35,632 KiB |

Separate instrumented runs show one fewer allocation and 32 fewer requested
bytes per element: a 24-byte result node and eight bytes of temporary array space.
The input list still allocates. Actual binaries contain checked increments with
no per-element callback dispatch in the counting loop. Finding the current state
owner and conditional cleanup still cost work; this is not a zero-cost state claim.

The [earlier comparison](measurements/service-context-iteration-baseline-2026-10-16.json)
retains the initial regression: removing the result list alone made the million-
element program 16.6% slower on AMD64 and 11.8% slower on ARM64. Specializing the
known callbacks and keeping their captured values outside loops resolved that
regression. These comparisons are between fwp definitions, not against C/Rust.
They establish results for this workload and these runners, not every use of `each`.

To reproduce the six-host service and iteration measurements, dispatch
`.github/workflows/numerics.yml` with `suite=context-owners` on the source branch.
The tests upload counts, generated C, executables, environment details and Linux
timing samples. Once all six native jobs pass,
[`collect-service-measurements.py`](../scripts/collect-service-measurements.py)
checks the run and creates the report. Supply its exact commit with `--head`,
the workflow number with `--run`, a download directory with `--artifacts`, a
report path with `--output`, and `--capture-requests 1 --each-comparison` for the
current implementation. It uses authenticated `gh`; it does not run downloaded
executables. Local collection goes through the repository's resource guard.

## Measurement report index

### Linux task storage

The [task-context guide](measurements/task-contexts.md) compares two fwp layouts
on named AMD64/ARM64 Linux hosts. A 32-task program still performs 227 allocations
and 159 retains, while peak managed charge falls from 54,592 to 25,024 bytes on
AMD64 and 206,656 to 29,248 on ARM64. Saved CPU state moves into existing child
stacks and root static storage. It still occupies memory and reduces usable stack
space. Process-memory reductions are smaller than these managed-byte reductions;
short-process timings are mixed. The [raw report](measurements/task-contexts-2026-10-21.json)
retains 144 samples, exact compiler settings, binary/code/static sizes and a
separate 72-call service comparison. These measurements compare fwp layouts,
not fwp overhead against C/Rust.

### Cancellation state and Windows ARC fibers

The [cancellation guide](measurements/task-cancellation.md) compares embedded heap
return buffers with buffers borrowed from active entry frames. At the preserved
source, all six hosts make 1,706 allocation requests and 1,069 retains. Heap
records and peak managed charge shrink, while entry frames grow. Actual binary
sizes include unchanged and larger results. The report names the workload,
compiler settings and stack-cost calculation; it makes no timing claim.
The related Windows collector-snapshot removal passed repaired native checks
in [PR #189](roadmap-history.md#compact-task-records-and-repaired-native-validation-pr-189).
Its separate controls must not be inferred from the cancellation measurements.

### Numerical kernels and record moves

[The record-move report](measurements/numerical-record-moves-2026-10-16.json)
retains the fwp/C/Rust sample at `a3d8f16e` on Linux/macOS ARM64/AMD64,
plus a separate experiment that restores the removed ownership operations.
All four hosts pass both the [numerical run](https://github.com/e6qu/fun-with-pipes/actions/runs/38817877068)
and [paired experiment](https://github.com/e6qu/fun-with-pipes/actions/runs/38821156704).
These measurements describe that preserved source and settings; later
deliveries have separate [acceptance records](roadmap-history.md).
Processors, compilers, flags, build commands, source hashes, raw samples and
allocation profiles are retained. Checked ARC binaries exclude tracing symbols.

These are C-hosted kernel measurements, not complete fwp command executions.
The [runner](../scripts/measure-numerical-kernels.py) links emitted fwp functions
into a measuring harness. The [C](../tests/fixtures/numerical_bench.c),
[Rust](../tests/fixtures/numerical_bench.rs) and
[fwp harness](../tests/fixtures/numerical_bench_native.c) make timer boundaries
inspectable. C/Rust dimensions are hidden from compile-time constant propagation
to match fwp's runtime metadata loads. C and emitted fwp C use
`-O2 -ffp-contract=off`; Rust uses `-C opt-level=2`.

The array workload reduces 65,537 elements eight times. Round `r=0..7` fills
index `i` with `((i+r)%19 - 9)/4` as F64, maps `x*3 + 1` with separate operations,
and sums left to right starting at negative zero. Its kernel time includes
consuming and releasing the input, but excludes input allocation and filling.
The matrix workload multiplies 65×67 by 67×63 matrices eight times using tiles
of width 32. Its kernel timer starts after output allocation and zeroing and
covers only multiplication and accumulation. Left matrix elements use the same
fill formula as the array; right elements
use `((i+r)%13 - 6)/8`. Output starts at zero. Allocation-inclusive time includes
input/output construction, computation, result-bit checksumming and cleanup;
printing the sample report, process startup and runtime initialization are outside.
C, Rust and fwp use the same inputs, ordered arithmetic and algorithms; multiply and add remain separate operations.
The C reference marks fresh output non-aliasing (`restrict`); generated fwp C can
communicate different alias information to its C optimizer. Equal mathematical
work does not imply identical optimization information or machine instructions.
Forty uninstrumented samples per implementation come from eight rotating process
batches of five samples after one warmup process per implementation; every
implementation occupies each process-order position twice. Separate binaries
collect allocation counts and memory;
profiling overhead is excluded from timings. Compilation and process startup
are outside these timers. No stable regression threshold is inferred from shared
runner timings.

A ratio of 2 means twice the elapsed time, or 100% extra time; 1.02 means 2% extra.

| Host / workload | Tracing / C kernel | ARC / C kernel | ARC / Rust kernel | ARC / C allocation-inclusive |
|---|---:|---:|---:|---:|
| Linux AMD64 / array | 3.060 | 1.045 | 1.052 | 1.843 |
| Linux ARM64 / array | 2.447 | 0.991 | 0.988 | 1.656 |
| macOS AMD64 / array | 1.478 | 0.998 | 1.736 | 1.853 |
| macOS ARM64 / array | 1.665 | 1.000 | 0.999 | 2.233 |
| Linux AMD64 / matrix | 1.234 | 1.831 | 1.257 | 2.069 |
| Linux ARM64 / matrix | 0.973 | 0.980 | 0.746 | 1.126 |
| macOS AMD64 / matrix | 0.951 | 0.948 | 0.883 | 1.205 |
| macOS ARM64 / matrix | 1.011 | 0.998 | 0.747 | 1.247 |

The ARC array kernel is close to C for these inputs, but input construction and
cleanup make its complete calculation 66–123% slower than C. Intel macOS array
execution is also about 74% slower than Rust. The Linux AMD64 ARC matrix kernel
takes about 83% more time than C; its allocation-inclusive calculation takes
about 107% more. These remaining costs must be investigated. Near-C kernel time
on another host does not establish language-wide zero overhead.

Both fwp modes finish with zero live charged bytes and no collections. Each
array sample allocates eight inputs and performs no retains. Eight matrix
products allocate forty objects versus twenty-four in C/Rust: fwp still creates
two input wrapper records per product. They request 811,648 bytes in total and
peak at 101,392 charged bytes, which includes allocator size-class rounding but
excludes allocator metadata. Process resident memory is recorded separately;
reserved address space is not physical live storage.

The compiler now transfers fields from uniquely owned records, including a
selected field whose flattened parent is immediately discarded. Shared parents
still retain the children they share. In this matrix workload the moves remove
all twenty-four retains and twenty-four nonfinal releases; release checks fall
from fifty-six to sixteen. Allocation counts and final storage do not change.
This establishes reduced bookkeeping, not elimination of all ownership cost.

The separate paired experiment compiles the same emitted C twice: once with
moves and once with the former count operations restored. It holds the matrix
arithmetic and allocation counts fixed and asserts both sets of operation counts.
Each binary gets forty samples in rotating order. The control restores traffic
for these nonfailing inputs; it is not an old compiler build and does not reproduce
obsolete retain-overflow cleanup scaffolding.

| Host | ARC moved / retained kernel | ARC moved / retained allocation-inclusive | Tracing moved / retained allocation-inclusive |
|---|---:|---:|---:|
| Linux AMD64 | 0.710 | 0.694 | 0.875 |
| Linux ARM64 | 1.008 | 1.006 | 0.999 |
| macOS AMD64 | 0.965 | 0.984 | 0.971 |
| macOS ARM64 | 0.997 | 0.985 | 0.998 |

This run shows a substantial AMD64 Linux gain, small Mac gains and a small Linux
ARM64 slowdown. It does not establish a portable speedup or C/Rust parity.
The kernel timer excludes the record conversions, so a changed kernel timing
cannot be read as time spent in those operations alone: generated-code layout,
cache state and runner variation also matter. A preceding AMD64 numerical run
used Xeon 8370C; the current cross-language run used 8573C. Its absolute times
cannot isolate record moves. Keep the slower current C/Rust result alongside
the paired result when selecting the next optimization.

[The preceding memory-mode report](measurements/numerical-memory-modes-2026-10-15.json)
retains the earlier fixed-size-copy and scheduler-check changes. The
[array-borrow report](measurements/numerical-array-borrows-2026-10-15.json)
separately compares invariant array-data access with per-element lookup. These
are historical measurements, not competing current performance claims.

### Matrix output experiment: not adopted

[Two four-host runs](measurements/matrix-output-alias-2026-10-16.json) test whether
explicitly telling the C compiler that fresh matrix output cannot overlap either
input improves generated code. The inputs may still overlap each other. The
candidate places the identical loop in an always-inlined function with that
output-pointer promise; binary inspection confirms no additional function call.
The shipped runtime remains unchanged.

On Linux AMD64, the ARC kernel shrinks from 387 to 303 instructions and its
explicit stack reservation from 472 to 376 bytes. Instructions addressing the
stack fall from 115 to 89; this includes local storage accesses, not just register
spills. Both variants still use the same two-lane floating-point multiply/add
sequence. Output hashes, forty allocations, zero retains/nonfinal releases,
sixteen release checks and zero final charged bytes agree.

Smaller code did not give a dependable timing improvement. These ratios compare
the candidate with the existing generated code, including allocation and cleanup:

| Linux AMD64, EPYC 7763 | ARC candidate / existing | Tracing candidate / existing |
|---|---:|---:|
| First run | 1.194 | 1.528 |
| Repeat run | 0.883 | 1.207 |

Each ratio uses forty uninstrumented samples in rotating order with separate
memory profiles. The other three hosts changed by roughly ±3% across the two
runs. The inconsistent ARC result and repeated tracing slowdown do not justify
adoption. The retained report includes both runs, hardware, flags, samples and
actual AMD64 kernel instructions. It remains evidence for future diagnosis,
not an optimization claim or a new runtime layer.

### Earlier cleanup and derivative measurements

The [earlier ownership/performance report](measurements/ownership-performance-2026-10-15.json)
records `f42d6226`, its operation-count checks and sustained derivative experiment.
Its different sample count is preserved rather than used as the new timing baseline.

The fused reduction allocates no intermediate storage, performs no retains and
registers no cleanup per element for the tested 0/1/7/129/257-element inputs at
O1/O2 on all four hosts. Previously, the ARM macOS baseline registered one cleanup
per element. Generated instructions confirm a scalar reduction loop; the ARM
macOS loop holds its index and accumulator in registers and has no cleanup call
in its body. Remaining bounds/view checks and ordinary load/multiply/add work
are visible. This does not establish vectorization or zero overhead. The timing
method changed between baseline and candidate, so no isolated optimization
speedup is claimed.

The sustained derivative case repeats a 4,096-element calculation 512 times.
It compares paired metadata storage with separate allocations in otherwise
equivalent generated fwp code. With workspace reuse enabled, paired metadata
needs 14 allocation requests versus 28 and explicitly moves 48,384 bytes while
growing. Final managed storage is zero in both variants. Median whole-process
time is about 1.5–2.0% lower on Linux, 1.6% higher on Intel macOS and 4.7% higher
on ARM macOS. Eight alternating samples per variant balance execution order;
shared-runner noise remains. Fewer allocation requests are established; a
portable speed improvement is not. The numerical memory-mode comparison above
does not settle this derivative regression; its diagnosis remains active work.

The first two historical reports below include C/Rust numerical baselines; the other listed
experiments primarily compare fwp implementations. Their raw reports retain inputs,
source revisions, machine/compiler details, settings, timings and measured
allocation counters. Some also retain generated C and disassembly: the actual
machine instructions used to check whether an intended transformation occurred.
A check of instructions is evidence about that compiled example, not all programs.

### Earlier compiler and memory experiments

| Report | What is compared or checked | What it can establish |
|---|---|---|
| [Numerical kernels](measurements/numerical-kernels-2026-10-12.json) | Equivalent array and matrix computations in fwp, C and Rust | Earlier calculation and allocation-inclusive timings, storage and generated instructions; not a vendor-library comparison |
| [Memory and checked ARC](measurements/ownership-and-arc-2026-10-12.json) | Later fwp/C/Rust array/matrix timings plus fwp reference-counting eligibility and reclamation checks | Historical cross-language ratios and scoped lifetime proof; not a universal collector-free mode |
| [Native platforms and memory](measurements/native-ownership-2026-10-13.json) | fwp iterator processing with/without selected compiler transformations, plus reused versus fresh derivative buffers | Allocation differences for those inputs; reused buffers can still leave allocations for result values |
| [Constructed values and numeric workers](measurements/reconstruction-and-workers-2026-10-13.json) | fwp direct array/state paths and 128-bit arithmetic, with the comparison settings recorded per case | Where temporary objects or indirect calls are removed |
| [Wide numbers and records](measurements/wide-records-2026-10-14.json) | fwp I128/U128/F128 and mixed records at direct versus general-purpose call boundaries | Representation and allocation costs at those boundaries |
| [Iterator producers](measurements/iterate-producer.json) | Direct fwp iterator state versus the recorded producer control | Whether per-step iterator objects are avoided in the eligible chain |
| [Checkpointed derivatives](measurements/checkpoint-2026-10-14.json) | fwp derivative calculation over 4,096 steps, storing checkpoints every 16, 32 or 64 steps | Less recorded history can cost more recomputation, managed storage, allocations and time; all measured storage was reclaimed |

A *numeric worker* is compiler-generated code specialized to a numeric type.
A *general-purpose boundary* may need a separately allocated object to carry
that value; this is called boxing. An *iterator producer* supplies the next
value, and a *consumer* processes it. The compiler combines eligible producer
and consumer chains to avoid temporary iterator objects. Arbitrary delayed
functions need not benefit from the same transformation.

### Derivative-recording terms

Automatic differentiation computes how outputs change with inputs. In reverse
mode, fwp records operations and then walks backward through them. The recording
is called a **tape**. Each operation stores references to its inputs (*parents*)
and local derivative weights. A **seed** gives a chosen output its initial
backward weight. Accumulated backward derivatives are called **adjoints**.

A **VJP**, or vector-Jacobian product, combines output derivatives using supplied
weights. “Identity VJP” below differentiates the unchanged input; “mapped VJP”
differentiates an elementwise transformation. A **nested gradient** computes a
derivative of a derivative. A **workspace cache** retains released numeric
buffers for a later calculation, within a fixed memory budget.

## Numeric backward prefix

[This historical comparison](measurements/ad-prefix-2026-10-14.json) uses the
same reference-counted fwp program on both sides. The control scans and reserves
space for the full recorded history; the changed version stops at the last node
that can contribute to the requested result. Both record 12,291 nodes, but only
the three original inputs receive output seeds in this particular test.

Peak tape payload falls from 491,648 to 393,344 bytes: 98,304 bytes less, or about
20%. The backward pass skips 12,288 irrelevant operation nodes. Allocation
requests stay at 38. Managed-object counters are unchanged. Seven complete-process
timing samples show no consistent speedup across the four Linux/macOS hosts.
This establishes less storage and scanning for the test, not faster forward
recording or a reduction relative to another language. Workspace reuse was off.

## Operation-only autodiff metadata

[This PR #138 snapshot](measurements/ad-operations-2026-10-15.json) compares two
fwp capacity policies. The control reserves parent/weight entries for original
inputs as well as operations. The changed version stores that extra information
only for operations, because inputs do not need it. It predates the paired-buffer
change below; its allocation counts are historical.

| Test | Peak tape bytes, control → changed | Allocation requests, control → changed |
|---|---:|---:|
| Identity VJP, 4,096 inputs | 131,176 → 32,872 | 6 → 2 |
| Mapped VJP, 4,096 inputs | 262,248 → 163,944 | 10 → 30 |
| Nested gradient, 256 inputs | 28,920 → 16,632 | 19 → 21 |

The tradeoff is visible: smaller starting buffers save space but can need more
growth requests. The nested case also reduces managed-object storage; the raw
report separates those counters. Timings do not show a consistent general
speedup. The control changes reserved capacity, not every earlier implementation
detail. All measured final storage is released, with no tracing collections.

## Autodiff registry growth

The runtime keeps a table of active tapes, called a **registry**.
[This comparison](measurements/ad-registry-2026-10-15.json) runs identical fwp
batches. The control grows that table by one entry per request; the changed
version doubles capacity, capped at the existing limit.

| Simultaneous tapes | Table allocation requests, control → changed | Peak table bytes, control → changed |
|---|---:|---:|
| 1 | 1 → 1 | 104 → 104 |
| 256 | 256 → 9 | 26,624 → 26,624 |
| 257 | 257 → 10 | 26,728 → 53,248 |
| 4,096 | 4,096 → 13 | 425,984 → 425,984 |

Doubling makes fewer requests but can reserve unused space: 26,520 extra live
bytes at 257 tapes. The table is already included in tape-storage totals.
Cumulative requested table bytes at 4,096 tapes fall from 872,628,224 to 851,864;
this does not measure physical copying. Managed counters are unchanged, final
measured storage is zero, and timings support no general speedup claim.

## Autodiff registry search

[This comparison](measurements/ad-search-2026-10-15.json) changes where fwp starts
looking for an available registry entry. The control starts at entry zero each
time. The new version remembers the first entry that might be available; that
remembered position is a **cursor**.

| Simultaneous tapes | Occupied/unavailable entries revisited by control | Revisited with cursor |
|---|---:|---:|
| 1 | 0 | 0 |
| 257 | 32,896 | 0 |
| 4,096 | 8,386,560 | 0 |
| 16,384 | 134,209,536 | 0 |

The counter measures those visits, not every CPU instruction. Creating tapes in
order avoids repeated scans in this test; arbitrary free gaps can still require
a search. The cursor costs eight static bytes and no new heap allocation.
Allocation counts and live-storage measurements are identical between versions.

For 16,384 tapes, median complete-process times over seven samples are:

| Host | Restart-at-zero control | Cursor version |
|---|---:|---:|
| Linux AMD64 | 164.802 ms | 10.681 ms |
| Linux ARM64 | 166.837 ms | 8.686 ms |
| macOS ARM64 | 144.215 ms | 12.551 ms |
| macOS Intel | 197.902 ms | 24.284 ms |

This large case is much faster; small cases are not consistently faster. These
are fwp-versus-fwp results, not overhead relative to C. The control retains the
new cursor-maintenance code and changes only its search start. All measured
storage is reclaimed with no tracing collections.

## Paired autodiff metadata allocations

[The PR #141 report](measurements/ad-metadata-2026-10-15.json) compares the same
fwp programs at `24620ead` with a control using the accepted `09f1a029` tape
runtime. Everything outside that runtime section is identical. Previously each
parent array and each numeric-weight array had its own allocation. Now the two
parent arrays share one block, and the two numeric-weight arrays share another.
The contents still occupy separate, aligned regions inside their blocks.

All four Linux/macOS hosts report:

| Test | Reuse released buffers? | All tape allocation requests, control → paired | Same peak tape bytes | Bytes explicitly moved by paired growth |
|---|---|---:|---:|---:|
| Identity VJP, 4,096 inputs | Either | 2 → 2 | 32,872 | 0 |
| Mapped VJP, 4,096 inputs | Either | 30 → 16 | 163,944 | 48,384 |
| 16 mapped VJPs of 4,096 inputs | No | 465 → 241 | 163,944 | 774,144 |
| 16 mapped VJPs of 4,096 inputs | Yes | 30 → 16 | 163,944 | 48,384 |
| Replay of 4,096 operations | Either | 30 → 16 | 131,184 | 48,384 |
| Nested gradient, 256 inputs | Either | 21 → 12 | 16,632 | 5,376 |

Requests specifically for parent/weight arrays halve; total tape requests also
include other storage, so their totals do not necessarily halve. Requested bytes,
peak payload and managed-object counters are unchanged. Final measured storage
is zero, with no tracing collections.

The extra cost is moving initialized data inside the resized blocks. The table
counts those explicit moves, not copying inside the system allocator. The
control has no explicit moves but its reallocations can still copy data. The
512 KiB workspace budget and 24 numeric metadata bytes per operation are unchanged.
Actual 32-bit WebAssembly checks verify request arithmetic without attempting
gigabyte allocations. Machine-instruction inspection confirms the intended two
numeric growth calls instead of four, while ordinary stack storage remains.

That report used seven alternating process samples after one warmup for each
version/cache setting. For the 16-VJP test, the median milliseconds were:

| Host | Reuse off, control → paired | Reuse on, control → paired |
|---|---:|---:|
| Linux AMD64 | 15.828 → 16.052 | 15.369 → 15.358 |
| Linux ARM64 | 25.037 → 25.004 | 24.523 → 24.796 |
| macOS ARM64 | 26.679 → 29.444 | 30.679 → 37.041 |
| macOS Intel | 62.244 → 55.340 | 50.887 → 57.204 |

Some cases are slower. For example, macOS ARM64 with reuse takes about 21% longer
in this sample (`37.041 / 30.679 − 1`). The accepted result is fewer allocator
requests with the same payload size, not a general speedup. The report records
raw samples, CPU/compiler information, flags and verified file hashes.

The current runner uses eight alternating samples, placing each version first
four times. It also includes 512 repeated derivative calculations so process
startup contributes less to the measured interval. The shorter cases remain as
controls. New results must reproduce a slowdown before assigning it to metadata
layout; changing the workload or sampling method alone is not a compiler speedup.

### Repeating the longer derivative comparison

[The four-host repeat](measurements/ad-metadata-repeat-2026-10-16.json)
uses compiler revision `48aa61dc` and the same separate-allocation tape control
from `09f1a029`. Both execute the same ARC program. The longer case performs 512
VJPs, each mapping multiplication by two over 4,096 F64 inputs with unit seeds;
it sums the resulting derivatives to `4194304.0`. A VJP computes derivatives
weighted by those seeds. This remains fwp versus fwp, with no C/Rust comparison.

After one warmup, eight samples alternate the execution order. The clock includes
process startup, input construction, derivatives and printing; compilation and
allocation profiling are separate. Both variants use `-O2 -ffp-contract=off`.
The report retains every sample, hardware/compiler details, verified source and
binary hashes, and actual ARM64/AMD64 instructions.

| Host | Paired/control time, reuse off | Paired/control time, reuse on |
|---|---:|---:|
| Linux AMD64 | 0.985 | 0.986 |
| Linux ARM64 | 0.987 | 0.985 |
| macOS ARM64 | 1.086 | 1.058 |
| macOS Intel | 0.960 | 1.020 |

A ratio above one is slower: ARM macOS takes 8.6% more time without reuse and
5.8% more with reuse in this run. The previous short-workload slowdown is not a
portable speed conclusion; the longer test still warrants investigation.

For all four hosts, paired storage reduces tape allocation requests from 14,849
to 7,681 without reuse and from 30 to 16 with reuse. Peak tape payload remains
163,944 bytes. Both variants make 25,184,777 managed allocation requests for
805,720,218 requested bytes and 10,492,416 retains; peak charged managed storage
is 840,888 bytes. These separate peaks need not occur simultaneously. Final tape
and charged managed storage are zero, with no tracing collections. These counts
exclude allocator metadata and OS reservations. Avoiding language-level temporary
values remains substantial work beyond reducing tape allocations.

In the retained ARM macOS binary, the append function has 198 instructions
versus 253 in the control; both backward functions have 374. Linux AMD64 counts
are 239 versus 296 for append and 399 for both backward functions. The report
also counts stack-address instructions without labeling them all as register
spills. Smaller append code has not established a dependable speed improvement.
The following controlled layout experiment leaves production behavior unchanged.

### Interleaving recorded operation pairs

[The layout trial](measurements/ad-layout-2026-10-16.json) changes only generated
experimental C. Each operation has two parent indices and two derivative weights.
Current storage keeps each side in its own region of a shared block; the trial
places each operation's pair together. It keeps the two allocation blocks, their
sizes and arithmetic order, and avoids moving second regions when capacity grows.
Production runtime storage is unchanged.

The same six derivative workloads run under ARC with reuse off/on, using the
same flags, eight alternating samples and separate profiling as above. Output,
allocation counts, requested bytes, peak/final memory and zero collections agree.
For 512 mapped VJPs, explicit growth copies fall from 24,772,608 bytes to zero
without reuse, or from 48,384 to zero with reuse. This excludes copying performed
internally by the system allocator. Managed allocation costs remain unchanged.

| Host | Interleaved/current time, reuse off | Interleaved/current time, reuse on |
|---|---:|---:|
| Linux AMD64 | 1.012 | 1.012 |
| Linux ARM64 | 1.001 | 1.010 |
| macOS ARM64 | 0.930 | 0.938 |
| macOS Intel | 1.005 | 0.986 |

The sustained case is 7.0%/6.2% faster on ARM macOS in this run, with mixed results
elsewhere. Short cases also vary: ARM macOS's single mapped VJP without reuse is
31.1% slower. These process timings include startup and output; absolute times
from separate runner executions should not be compared as if hardware load were
identical. Repeat promising results before selecting a new runtime layout.

Native instructions also show a tradeoff. On ARM macOS, append shrinks from 198
to 182 instructions but backward grows from 374 to 384. On Linux AMD64 the counts
are 239 to 207 and 399 to 412. The report retains both function disassemblies.
These counts alone explain neither the speed differences nor their cause. The
[allocation-site investigation](#where-derivative-allocations-occur) attributes
the much larger managed allocation count to actual calls instead of assuming
tape layout is the dominant cost.

## Selecting invariant array data once

A slice may store an address into another array. The compiler now selects that
address before a loop when it proves the same F64 array survives every step.
This removes repeated representation checks; it does not reorder the sum or
fuse multiplication and addition. The actual AMD64 loops keep the address and
accumulator in registers and process four elements per loop iteration, with
ordered scalar multiply/add and no stack traffic inside that arithmetic loop.

[Four-host results](measurements/numerical-array-borrows-2026-10-15.json) use the
same 65,537-element workload, forty samples and memory-mode method described
above. A ratio above 1 means fwp took longer in that run.

| Host | Tracing / C | Checked ARC / C | Checked ARC / Rust |
|---|---:|---:|---:|
| Linux AMD64 | 1.05 | 1.01 | 1.00 |
| Linux ARM64 | 2.48 | 1.00 | 0.98 |
| macOS AMD64 | 1.45 | 0.98 | 1.74 |
| macOS ARM64 | 1.66 | 1.00 | 1.01 |

All allocation profiles match the preceding report. These samples do not isolate
a precise optimization gain: on Intel macOS ARC time fell 7.5% while both C and
Rust times rose about 33%. On Linux AMD64 tracing matrix time rose about 11%,
but the old and new matrix executables are byte-identical. The report records
those hashes and retains the slower measurements.

The separate `array-borrow` evidence suite recompiles the verified emitted C on
one host, then compares its cached read with the existing per-element selection.
It changes only the generated load expressions and verifies result hashes and
allocation profiles. Both memory modes use identical C flags, separate profiles
and forty samples with rotated process order. That experiment compares two fwp
implementations; the table above compares fwp with C and Rust. Two complete
four-host runs are retained in the report. Below, each pair is the first and
second run's cached/per-element kernel-time ratio; below 1 means faster.

| Host | Checked ARC | Tracing |
|---|---:|---:|
| Linux AMD64 | 1.00 / 0.99 | 0.76 / 0.86 |
| Linux ARM64 | 0.96 / 0.97 | 1.00 / 1.00 |
| macOS AMD64 | 0.70 / 0.71 | 0.96 / 1.00 |
| macOS ARM64 | 0.97 / 1.02 | 1.05 / 1.01 |

The Intel macOS ARC improvement repeats. ARM macOS ARC changes direction, and
tracing is slightly slower in both runs; its generated loop removes address
selection without adding stack spills, but still reloads length around the
compiler's root-liveness fences. The experiments do not establish a universal
gain or a stable ARM macOS penalty. Outputs and allocation profiles match;
the report keeps all raw samples, including allocation-inclusive timings and
slower cases. No local timings were used.

## Running comparisons

Full benchmarks run on GitHub runners. For the native Linux C/Rust comparison:

```sh
CC=gcc FWP_LTO=0 FWP_BENCH_OWNERSHIP=arc cargo test --release --test bench benchmarks -- --ignored --exact --nocapture
```

It writes the report to standard output, `target/bench.md` and the `bench` job
summary. The `benchmark-comparison` focused suite runs this checked-ARC comparison
on native Linux AMD64/ARM64 with GCC. Both it and production CI inspect the actual
C/Rust/fwp binaries with the [binary reviewer](../scripts/inspect-benchmark-binaries.py),
check input hashes and timing summaries, and require checked-ARC
fwp images to exclude tracing scans. The inspection does not execute downloaded
binaries or turn these descriptive timings into a speed guarantee.
[Corruption controls](../scripts/test-benchmark-evidence.py) must reject a wrong
memory label, wrong machine architecture, object file and missing timing sample. The per-change experiments have their own scripts and explicit controls:

| Comparison | Runner command |
|---|---|
| Iterator processing | `python3 scripts/measure-iteration.py --help` lists the supported controls |
| Table growth | `python3 scripts/measure-ad-registry.py --comparison growth --output OUTPUT` |
| Table search | `python3 scripts/measure-ad-registry.py --comparison search --output OUTPUT` |
| Paired buffers | `python3 scripts/measure-ad-metadata.py --output OUTPUT` |

For remote reproduction, push the source branch and dispatch the appropriate
suite from [numerics.yml](../.github/workflows/numerics.yml), for example:

```sh
gh workflow run numerics.yml --ref YOUR_SOURCE_BRANCH -f suite=numerical
```

Record the resulting run URL and full source SHA. Confirm the run actually used
that SHA and all required native jobs completed. Download its artifacts; preserve
raw samples, source inputs, compiler commands, generated C and measured binaries.
The report's `source`/`source_revision` (some use `compilerSource`) identifies
code; `run`/`run_url` identifies evidence. Host entries contain the environment,
variants and samples. Schemas differ by suite; use its collector's `--help` and
supply the exact run/head rather than guessing the baseline. Run collectors
locally through `python3 scripts/local-guard.py`; compilation and benchmarking
stay on runners. Historical artifacts can expire, so committed JSON summaries
are retained; a missing original artifact must be reported, not reconstructed
and passed off as the original measurement.

A reproducible result needs this record:

| Field | Example of the required precision |
|---|---|
| Question and baseline | “New fwp / old fwp with separate map buffers,” not “language overhead” |
| Inputs and work | 500,000 entries plus 2,000,000 lookups; include construction/sorting rules |
| Semantics | Checked integer arithmetic? Ordered floating sums? Same outputs and failure behavior? |
| Builds | Full source SHA, flags, memory mode, C/Rust compiler versions, generated-source/binary hashes |
| Machine | OS, architecture, actual CPU model, available CPUs and relevant runner constraints |
| Timer | Exact start/end, units, warmups, repeats, order, and statistic; state whether startup/cleanup are included |
| Memory | Which allocator/counter, when reset/read, peak versus final, and excluded storage |
| Result | Raw samples and named ratios, including slower cases; code-size/stack observations when relevant |
| Interpretation | What changed, what remains, and whether the data can distinguish the claimed effect |

For a new claim, state both implementations, inputs, algorithms, compiler settings,
hardware, timing boundary and memory-counter scope. Keep raw samples and inspect
whether the generated program really does the work being claimed. Report slower
cases and extra storage too. Correct output is required; noisy shared-runner
elapsed times are not pass/fail thresholds. [Delivery history](roadmap-history.md)
records which source versions completed the required tests.

## Where derivative allocations occur

An allocation-site profile records the native instruction that requested each
piece of managed storage. This explains what creates temporary objects; it does
not measure how long that instruction takes. This baseline predates direct
numeric mapped-array construction; its counts identify the costs that motivated
that later optimization. The
[four-host report](measurements/ad-allocation-sites-2026-10-16.json) compares
ordinary aggregate profiling against a diagnostic build with two allocation
functions deliberately kept out of line. Requests, requested bytes, retains and
peak/final memory agree exactly between both builds on every host. Raw
interpretation supplies expected outputs. Initial constants are excluded.

The workload computes 512 reverse derivatives of a function that doubles each
of 4,096 inputs. All four hosts record 25,184,777 managed requests, 805,720,218
requested bytes and 10,492,416 retains. Peak charged storage is 840,888 bytes;
final charged storage and collections are zero. Native symbols and debug
locations attribute the main requests as follows:

| Construction | Requests | Share of all requests |
|---|---:|---:|
| List nodes holding mapped results | 10,490,368 | 41.65% |
| Index/value pairs and list nodes for zip | 4,194,304 | 16.65% |
| Reverse-number multiplication records | 4,194,304 | 16.65% |
| Integer range list nodes | 2,101,760 | 8.35% |
| Array-to-list result nodes | 2,097,152 | 8.33% |
| Initial reverse-number records | 2,097,152 | 8.33% |

These are allocated objects, not necessarily distinct system malloc calls. The
report retains individual native sites, language signatures where available,
source/binary hashes, compiler commands and host details. Both variants are fwp;
this establishes no C/Rust parity or timing improvement. It points to list
intermediates as an optimization target before further tape-layout work.


## Building numeric arrays without temporary list nodes

**Comparison:** the same fwp compiler with mapped-array combining off/on, in
tracing and ARC modes. `map f | array.from-list` normally builds a result list;
the optimized path stores numeric results directly, preserving callback order.
Known callbacks call directly. There is no C/Rust baseline in this experiment.

**Work and method:** direct work doubles 4,096 F64 elements, builds an array and
sums it, 128 times. The derivative case computes 512 gradients over 4,096 inputs;
a small control differentiates a first-element square twice over 256 inputs.
Builds use `-O2 -ffp-contract=off`, with other fusion and workspace reuse enabled.
After one warmup, eight alternating whole-process samples include startup,
inputs, calculation and output. Compilation and allocation profiles are separate.

The [main report](measurements/mapped-arrays-2026-10-16.json) retains both final-code
runs and an earlier indirect-callback implementation. Compare enabled/disabled
within each revision. Counts agree across four Linux/macOS hosts and both modes:

| Workload | Managed requests, disabled → enabled | Retains, both | Peak charged bytes, disabled → enabled |
|---|---:|---:|---:|
| Direct numeric | 532,996 → 8,708 | 256 | 300,312 → 294,920 |
| Repeated derivative | 25,184,777 → 23,087,625 | 10,492,416 | 840,888 → 840,888 |
| Nested derivative | 4,415 → 4,414 | 2,109 | 60,096 → 60,096 |

The two final-code runs roughly halve direct numeric elapsed time; ARC derivative
time falls 6–11%. Intel macOS traced derivatives are 7%, then 2%, slower, with
overlapping ranges. A [16-sample CPU repeat](measurements/mapped-array-cpu-2026-10-16.json)
reuses the verified binaries and measures child user+system time alongside elapsed
time. That slowdown does not repeat: traced derivative CPU ratios are 0.904–0.925.
Tiny nested cases remain mixed, including 6.8%/8.9% more CPU on ARM macOS in
tracing/ARC. Earlier slower samples remain in the reports.

Profiles exclude initial constants; final managed/tape storage is zero.
Retains and derivative peak storage do not improve. Actual ARM64/AMD64 binaries
retain vector doubling instructions, but this does not measure cache misses or
prove that every callback is faster.

## Mapping numeric pairs without building a temporary zip

**Comparison:** identical fwp programs with `FWP_ZIP_MAP=0` versus `1`, in tracing
and ARC. `xs | zip ys | map f` stops at the shorter list. For known numeric
callbacks, the optimized path avoids intermediate pairs and zip list nodes.

**Work:** 128 lists of 4,096 products `x * (x + 1)`, kept before summing;
512 derivatives over 4,096 inputs; and a twice-differentiated square over 256
inputs. **Method:** `-O2 -ffp-contract=off`, one warmup, eight alternating
whole-process samples. Startup, inputs and output are included; compilation and
profiles are separate. Other fusion and workspace reuse remain enabled.

[Four-host results](measurements/zip-maps-2026-10-16.json):

| Workload | Managed requests, disabled → enabled | Retains, disabled → enabled | Peak charged bytes, disabled → enabled |
|---|---:|---:|---:|
| Direct products | 2,106,373 → 1,057,669 | 524,672 → 384 | 17,208,584 → 17,077,512 |
| Repeated derivative | 23,087,625 → 18,892,809 | 10,492,416 → 8,395,264 | 840,888 → 840,888 |
| Nested derivative | 4,414 → 3,901 | 2,109 → 1,853 | 60,096 → 60,096 |

The [16-sample repeat](measurements/zip-map-cpu-2026-10-16.json) reuses verified
binaries and adds child CPU time. Direct-work CPU ratios are 0.519–0.655 and
derivative ratios 0.788–0.822 (enabled/disabled). ARM macOS nested ARC remains
slightly slower: 1.5805 → 1.6075 ms CPU, with overlapping samples.
Normal traced direct work collects twice in both variants; other cases collect
zero times. Profiles finish with zero managed/tape storage, but derivative peak
memory is unchanged. ARM64 direct products use vector multiply; AMD64 uses
unrolled scalar multiply. This compares fwp transformations, not C/Rust speed.

## Hashing values without constructing their encoded bytes

**Work:** build integers `0..N-1` in an array, hash `(iteration, array)` repeatedly,
and XOR the results. Small: 16 integers × 4,096 hashes. Large: 4,096 integers ×
1,024 hashes. The changing iteration prevents reuse of one hash. All implementations
encode identical little-endian I64 fields and lengths and use FNV-1a, a
noncryptographic XOR/multiply fingerprint with arithmetic modulo 2^64.

**Comparison:** [fwp tracing, ARC, buffered-hash ARC, C and Rust](measurements/structural-hash-2026-10-16.json).
C/Rust know this schema directly; fwp uses runtime type descriptions. Streaming
feeds encoded bytes into the hash without allocating the complete byte buffer.
The interpreter's buffered path independently checks output.

**Method for this hash series:** optimization level 2, one warmup, ten rotating
whole-process samples unless a repeat states otherwise. Times include startup,
input construction, hashing and printing. Reports retain elapsed and child CPU
time, hardware, compiler flags and source/binary hashes. Compilation, allocation
profiles and process peak memory are separate. These initial ARC CPU ratios use
references measured alongside fwp:

| Host | Small / C | Small / Rust | Large / C | Large / Rust | Small / buffered fwp | Large / buffered fwp |
|---|---:|---:|---:|---:|---:|---:|
| Linux AMD64 | 1.670 | 1.542 | 1.044 | 1.044 | 0.318 | 0.165 |
| Linux ARM64 | 1.824 | 1.660 | 1.033 | 1.029 | 0.350 | 0.160 |
| macOS ARM64 | 1.435 | 1.236 | 1.016 | 1.012 | 0.553 | 0.285 |
| macOS AMD64 | 1.475 | 1.328 | 1.018 | 1.012 | 0.374 | 0.079 |

Streaming removes 12,288/11,264 hash-buffer growth requests for small/large work,
and 256/65,536 peak temporary bytes. The original surrounding fwp programs still
make 12,309/7,173 managed requests and 12,288/3,072 retains. C/Rust count one
application array allocation, excluding startup/printing internals; fwp counters
can include output values, so their allocation scopes differ.

[Binary evidence](measurements/structural-hash-code-2026-10-16.json) confirms a
recursive hash visitor with no encoder/allocator call in its inspected body.
All measured owned storage releases. The following reports address surrounding
pipeline costs; this initial table does not describe the final compiler.

### Keeping captured computations outside a fused hash loop

**Change:** keep the captured array outside the known callback loop, then combine
mapping and XOR reduction without interleaving observable traps or effects.
The [post-fusion report](measurements/hash-pipelines-2026-10-16.json) uses the
same hash inputs and method above. Counts match on four hosts in tracing and ARC:

| Workload | Managed requests, before → after | Retains, before → after | Peak charged bytes, before → after |
|---|---:|---:|---:|
| Small array | 12,309 → 4,114 | 12,288 → 4,096 | 295,112 → 656 |
| Large array | 7,173 → 5,122 | 3,072 → 1,024 | 163,848 → 163,848 |

Final charged storage is zero. At this revision each hash still allocates a tuple
and retains its array; range input still builds a list. ARC CPU overhead versus
C in this run is 22–48% for small inputs and roughly −0.2% to +3.3% for large
inputs. These are simultaneous C comparisons, not a before/after speedup measured
across different runners. The paired repeat below isolates the revision change.

### Repeating both hash pipeline revisions together

**Comparison:** verified pre/post-fusion fwp binaries with C/Rust beside them,
using the same hash workloads. The [paired report](measurements/hash-pipeline-cpu-2026-10-16.json)
uses twelve balanced whole-process samples, forward/reverse order, and separate
profiles that reproduce original counts. Ratios below mean after/before:

| Host | Small ARC CPU / elapsed | Large ARC CPU / elapsed | Large tracing CPU / elapsed |
|---|---:|---:|---:|
| Linux AMD64 | 0.902 / 1.077 | 0.995 / 0.998 | 0.996 / 0.996 |
| Linux ARM64 | 0.759 / 0.788 | 1.002 / 1.002 | 0.998 / 0.999 |
| macOS ARM64 | 0.807 / 0.838 | 0.995 / 1.002 | 1.019 / 1.021 |
| macOS AMD64 | 0.811 / 0.895 | 0.999 / 0.999 | 1.028 / 1.023 |

Small ARC CPU time falls everywhere, but Linux AMD64 elapsed time rises from
2.325 to 2.505 ms. Large traced macOS medians also rise, with overlapping samples.
In this repeat, large Intel macOS ARC takes 1.327 times C and 1.404 times Rust,
a larger gap than the first report. Neither run establishes portable parity.

### Intermediate stack placement experiment

The [partial experiment](measurements/hash-stack-intermediate-2026-10-16.json)
puts nonescaping hash tuples on the stack. Only Linux/macOS ARM64 completed;
the other queued jobs were cancelled when the combined experiment replaced it.
It reduces small/large managed requests from 4,114/5,122 to 18/4,098; array retains
remain 4,096/1,024. This is not four-host acceptance.

The subsequent [direct-range report](measurements/hash-range-arrays-2026-10-16.json)
constructs input arrays without range lists. All four hosts then report two
requests: the array and printed result. Small/large requested bytes are
165/32,805; peak charged bytes are 144/32,776; final charge is zero. Retains are
unchanged. Both reports use the hash workloads/method above, including slower
large macOS samples; measurements from separate runs do not isolate a speedup.

### Borrowing temporary fields without counting them

**Comparison:** post-fusion fwp versus stack tuples, direct range arrays and
borrowed fields. A borrow uses the array while its existing owner keeps it alive;
the temporary tuple needs no additional owner. The [four-host report](measurements/hash-borrowed-fields-2026-10-16.json)
uses the same hash programs and timing method above:

| Workload | Managed requests, post-fusion → current | Retains, post-fusion → current | Peak charged bytes, post-fusion → current |
|---|---:|---:|---:|
| Small array | 4,114 → 2 | 4,096 → 0 | 656 → 144 |
| Large array | 5,122 → 2 | 1,024 → 0 | 163,848 → 32,776 |

Two allocations hold input and output; final charge is zero. The inspected ARM64
loop keeps the array pointer, iteration and accumulator in registers across the
hash visitor call and has no allocation or retain/release call. The recursive
visitor still has its own stack and type-description work.

In this run small ARC CPU overhead versus C is 19–34%; large macOS gaps reach
10% on ARM64 and 22% on AMD64. The next paired runs compare old/new binaries on
the same machines, rather than attribute different-run times to the compiler.

### Repeating the allocation and borrowing changes together

**Comparison:** verified post-fusion baseline versus the combined borrowing
change, beside C/Rust. [Two paired runs](measurements/hash-borrowed-cpu-2026-10-16.json)
use twelve balanced rotating whole-process samples each and separate profiles.
All current profiles reproduce two requests, zero retains and zero final charge.
Small Linux and Intel macOS CPU medians fall in both repeats; large-input changes
are generally small. First-run macOS ARC slowdowns reverse in the repeat, with
overlapping ranges. Large Intel macOS tracing is 6.5% slower in the second run.

These are the second run's current ARC CPU ratios against C/Rust:

| Host | Small / C | Small / Rust | Large / C | Large / Rust |
|---|---:|---:|---:|---:|
| Linux AMD64 | 1.381 | 1.178 | 1.020 | 1.015 |
| Linux ARM64 | 1.373 | 1.237 | 1.028 | 1.024 |
| macOS ARM64 | 1.144 | 0.979 | 1.043 | 1.050 |
| macOS AMD64 | 1.216 | 1.097 | 1.059 | 1.022 |

For example, small Linux ARM64 work still takes 37.3% more CPU than C, despite
removing the targeted allocations and retains. Startup, input construction,
printing and generic hash traversal remain in the measured interval.

### Numeric hash specialization

Hashing turns a value's encoded bytes into a 64-bit fingerprint. The compiler
can emit a loop for known numeric types instead of asking a general runtime
visitor for each element's type. This preserves the bytes and hash result;
`FWP_TYPED_HASH=1/0` selects specialized/general traversal for comparison.

The current [initial report](measurements/numeric-hashing-2026-10-20.json) and
[repeat](measurements/numeric-hashing-repeat-2026-10-20.json) measure source
`0bb385ab`, including the C aliasing repair and direct integer output. The
[older initial](measurements/numeric-hashing-2026-10-19.json) and
[older repeat](measurements/numeric-hashing-repeat-2026-10-19.json) preserve the
pre-repair samples. Those earlier Clang results did not expose the GCC defect
and are not acceptance evidence for the repaired compiler.

Each program builds one I64 collection containing `0..N-1`, repeatedly hashes
`(iteration, collection)` and combines results with XOR. The iteration prefix
changes each hash. All versions encode the same eight-byte integers and unsigned
LEB128 length (a variable-length integer encoding).

| Case | Elements | Hashes per process |
|---|---:|---:|
| Small array | 16 | 4,096 |
| Large array | 4,096 | 1,024 |
| Ordered set | 65,536 | 64 |

C/Rust store the same ordered keys in an array/vector; no version sorts them.
The initial run compares specialized tracing/ARC, general ARC, C/Rust, and a
separate general-ARC control that constructs an encoded byte buffer. That slower
buffered control does not stand in for general traversal. All fwp variants
explicitly enable array/collection fusion and direct integer output.

One warmup precedes twelve balanced rotating/reversed samples. The repeat reuses
the exact saved specialized ARC, general ARC and C/Rust executables: two warmups,
then 24 balanced samples, 1,152 timed executions in total. Both include startup,
input construction, hashing and output. Compilation and instrumented allocation
profiles are separate. Child CPU is processor time charged to the program; wall
time also includes waiting for the host. Raw reports retain both, with compiler
versions/commands, hardware, RSS, profiles and binary hashes. Builds use O2 and
C `-ffp-contract=off`.

Each cell below is **initial / repeated child-CPU median**, specialized ARC divided
by general ARC. For example, 0.968 means 3.2% less CPU. This compares fwp with fwp.

| Host and processor | Small array | Large array | Set |
|---|---:|---:|---:|
| Linux AMD64, Xeon 8573C / EPYC 9V74 | 0.863 / 0.996 | 0.998 / 0.994 | 0.991 / 1.001 |
| Linux ARM64, Neoverse N2 | 0.954 / 0.925 | 0.968 / 0.968 | 0.987 / 0.986 |
| macOS ARM64, virtual Apple M1 | 0.895 / 0.983 | 0.987 / 0.964 | 0.940 / 0.987 |
| macOS AMD64, Core i7-8700B | 0.946 / 0.948 | 0.968 / 0.853 | 0.994 / 0.926 |

Linux AMD64 changed processor between runs; within each run every variant uses
the same host. Do not compare absolute times across those processors. Repeated
Linux ARM64 large-array/set results are faster in all 24 pairs with separated
ranges. Other ranges overlap. AMD64 sets are 0.11% slower in the repeat, with
12 of 24 pairs faster: 37.776–38.376 ms versus 37.806–38.211 ms. That result is
inconclusive. Initial ARM macOS small-case wall time is 3.8% higher despite a
lower CPU median; its repeated wall median is 3.0% lower. Keep both observations.

Remaining **repeated CPU overhead against C / Rust** is:

| Host | Small array | Large array | Set |
|---|---:|---:|---:|
| Linux AMD64 | +28.1% / +13.5% | +1.7% / +1.3% | +1.5% / +1.2% |
| Linux ARM64 | +32.1% / +18.3% | +0.7% / +0.5% | +0.8% / +0.5% |
| macOS ARM64 | +15.8% / −1.5% | +2.3% / +1.7% | +0.7% / −1.1% |
| macOS AMD64 | +17.5% / −0.8% | +2.8% / +1.5% | +3.6% / −1.0% |

Negative overhead means a lower observed fwp median; overlapping samples do not
establish superiority or parity. These are costs of these programs on these
runners, not an overhead percentage for the language. The separate million-key
[PR #173 production baseline](measurements/range-set-peers-2026-10-19.md) and
[final PR #174 results](measurements/numeric-output-peers-2026-10-20.md)
use GCC and tracing, with different workloads. Their percentages cannot be
subtracted from this table. Both retain all six production benchmark programs.

The final PR #174 report uses AMD EPYC 7763, GCC 13.3 and Rust 1.99.1. It times
whole processes, including startup, input construction and output, with one
warmup and six rotating samples per implementation. Median fwp extra time against
C / Rust is +38.3% / +3.9% for the arithmetic loop, −11.9% / +8.5% for the map,
−41.7% / +13.1% for the pipeline, +5.9% / +7.1% for the range set, and
+15.7% / +16.5% for strings. Work and arithmetic guarantees differ as explained
in that report; these are observations, not isolated costs of the language.
The [pre-repair report](measurements/numeric-hash-pre-repair-peers-2026-10-19.md)
remains historical evidence. Its loop/map timing ranges overlap the final run;
the pipeline median returned from 26.089 ms to 17.258 ms. Keep the raw samples
when assessing changes rather than selecting one favorable median.

Specialized and general ARC profiles now match at **one managed allocation**,
zero retains and zero charge after cleanup. Small/large/set programs request
136 / 32,776 / 524,296 bytes and peak at 144 / 32,776 / 524,296 bytes. This is
the input buffer; direct integer printing removes the earlier second request.
C/Rust count one application buffer of 128 / 32,768 / 524,288 bytes. fwp's extra
eight requested bytes store length; charged storage can include rounding.
Counters exclude allocator metadata and libc output storage. Hash bodies add
no allocation or retain/release operation; deliberate added operations must fail
the corresponding tests. This does not establish zero whole-process heap use.

The collector inspects 96 correctness binaries and 48 measured fwp binaries.
Specialized ARC executable code sections are 1,432–1,952 bytes smaller than
general ARC. The inspected Linux ARM64 set loop has no calls or stack accesses;
AMD64 saves one register around the function, outside the element loop. The
caller still builds a stack tuple and calls once per hash. Eight dependent
FNV-1a byte steps per key remain; removing type dispatch cannot remove them.

The [output report](measurements/integer-output-2026-10-20.json) inspects another
144 binaries from the same 456-test native run. For its small print-then-trap
example, ARC/O2 code sections shrink by 3,536–3,712 bytes across the six hosts.
ARM macOS reserves 112 bytes for the whole main-thread frame, including startup;
the formatter's 24-byte buffer is not a whole-frame or whole-program bound.
ARC binaries exclude tracing functions, but runtime initialization remains.

To reproduce, run `hash` and `hash-costs` at one source revision. After they pass,
`hash-report` takes their `evidence_run` / `costs_run` IDs and `source_revision`.
It checks complete tests, saved-file hashes, sample balance, medians and actual
binary sections/tracing symbols. `integer-output-report` uses the same test run
and inspects the direct/ordinary output binaries. `hash-specialization-repeat`
uses the completed cost run as `evidence_run` and the same source revision.
Inspect saved assembly before claiming that a loop avoids calls or stack spills.

Acceptance requires identical canonical results, no allocation/count traffic
inside hashing, and unchanged ARC profiles versus general traversal. Target
lower time on the large array and set without a reproducible small-case
regression. Overlapping results require investigation; retain slower samples,
C/Rust gaps and code-size costs. A passing collector does not replace full
production acceptance.

## CPU tensor output storage

**Comparison:** previous versus direct-output fwp executors, with only that runtime
section replaced in the control. **Work:** multiply 8,193 F64 values (their indices)
by 0.5; check every result and the ordered sum. Input construction is outside the
counter interval. The [six-host report](measurements/owned-values-and-kernels-2026-10-16.json)
measures allocation/cleanup, not time or overhead against C/Rust.

| Elementwise output cost | Previous executor | Prepared executor |
|---|---:|---:|
| Temporary native allocation requests | 3 | 2 |
| Peak temporary native bytes | 69,648 | 4,104 |
| Managed result-array requests | 1 | 1 |
| Native storage remaining after the call | 0 | 0 |

Writing directly into the result removes a 65,544-byte temporary and its full
copy. Input-pointer tables, workspace and the result remain. Separate peaks for
four workers cannot be added into a simultaneous peak. Native counters exclude
managed results, allocator metadata, thread stacks and process resident memory.
Actual ARC binaries use packed double multiplication but still load/store
workspace and copy completed chunks. [PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
records acceptance.

## Fixed-size lane calculations against C and Rust

A **lane** is one position in `Vec[N, F64]`; see the
[example](../examples/vector-lanes.fwp). **Work:** fill lanes with the iteration
index, multiply by 0.5, sum lanes left to right, then sum iteration results.
Four lanes use 32,768 iterations; 64 lanes use 8,192. Values are exact for these
inputs, and output matches raw interpretation. C/Rust use fixed stack arrays
that optimization may remove; fwp uses ordinary vector/list abstractions and
checks the final optional integer conversion.

**Method:** O2, no fast math or multiply-add contraction. The
[baseline](measurements/vector-lanes-2026-10-16.json), [direct-dot stage](measurements/vector-direct-intermediate-2026-10-16.json)
and [scalar-splat stage](measurements/vector-scalar-splats-2026-10-16.json) each
use one warmup and sixteen balanced whole-process samples (elapsed and child CPU).
Startup, construction, arithmetic, conversion and printing are included.
Compilation, allocation profiles and process-memory sampling are separate.

Baseline `6be8f245` makes 262,147/65,539 managed requests for four/64 lanes.
Direct-dot `3577ba37` removes product vectors and list intermediates but still
builds two input vectors per iteration: 131,074/32,770 requests. Final `b1a34ea0`
removes those vectors when only the dot consumes them: two output/conversion
requests total, 40 requested bytes, 48 peak charged bytes, zero retains/final
charge. C/Rust count zero application heap requests in their narrower calculation
scope; this excludes their startup/printing internals.

The [paired run](measurements/vector-paired-2026-10-16.json) compares the same
baseline/final binaries and C/Rust on each host, with one warmup and twelve
balanced orders. Ratios are final ARC child CPU time divided by the named reference:

| Host | Four lanes / before | Four lanes / C | Four lanes / Rust | 64 lanes / before | 64 lanes / C | 64 lanes / Rust |
|---|---:|---:|---:|---:|---:|---:|
| Linux AMD64 | 0.161 | 1.954 | 1.576 | 0.313 | 1.432 | 1.311 |
| Linux ARM64 | 0.116 | 1.517 | 1.251 | 0.241 | 0.878 | 0.937 |
| macOS ARM64 | 0.327 | 1.230 | 0.996 | 0.416 | 1.070 | 0.855 |
| macOS AMD64 | 0.270 | 1.134 | 1.027 | 0.504 | 1.043 | 0.904 |

Linux AMD64 four-lane work is 83.9% faster than old fwp but still takes 95.4%
more CPU than C. The comparison covers the whole change, not each optimization
separately. Inspected ARM64 calculation loops have no calls, loads or stores;
independent iterations use vector instructions, then ordered scalar additions.
That is static code evidence, not a cache-miss or dynamic-spill measurement.

## Storage for received stream values

**Comparison:** separate source/result fields (`00c09cdc`) versus one shared
storage word (`4c26f21f`) in a received stream position. **Work:** queued messages
with 16-character strings; consume 1/32/128 values, reread each position, stop
halfway, or keep the first position while consuming the rest. Both versions
include the same shared-reader repairs. Collection is disabled for counting.
The [preceding](measurements/remote-stream-shared-2026-10-16.json) and
[compact](measurements/remote-stream-compact-2026-10-17.json) reports cover six hosts:

| Measurement | Separate source/result fields | Shared storage word |
|---|---:|---:|
| Bytes per position, aligned to 8 bytes | 24 | 16 |
| Managed allocation requests per received value | 4 | 4 |
| Requested bytes per received value | 89 | 81 |
| Bytes charged after allocator rounding, per value | 112 | 96 |
| Fixed setup bytes charged | 720 | 704 |
| Bytes charged after consuming 128 values, including setup | 15,056 | 12,992 |

This measures fwp storage, not elapsed time or C/Rust overhead. Socket I/O, raw
codec buffers, allocator pages and process memory are excluded. At this historical
stage clearing C references still leaves the cache charged without collection;
[last-owner cache cleanup](#memory-used-by-complete-remote-stream-clients) later
fixes that. Actual binaries confirm the saved result moves from offset 16 to 0.
Reproduce with `suite=stream-owners` and `scripts/collect-stream-measurements.py`;
use its `--help` for the required baseline, run and source arguments.

## Stack use when releasing wrapped chains

**Comparison:** recursive wrapper cleanup in `70e36523` versus loop cleanup in
`aea7d6df`. Each record owns a five-byte string and an optional next record; a
second shape adds a tuple/string wrapper. Test 64/1,024/16,384 links with aliases
to the root, middle record or wrapper, then release every owner. Tracing is off.

The [six-host report](measurements/wrapped-chain-cleanup-2026-10-17.json) samples
a stack address at each cleanup entry. The span between highest/lowest addresses
measures growth, not total stack storage; instrumentation can change frame sizes.
O2 results:

| Native target | Previous span, 64 links | Previous span, 1,024 links | Largest new span, through 16,384 links |
|---|---:|---:|---:|
| Linux AMD64 | 2,048 | 32,768 | 16 |
| Linux ARM64 | 3,072 | 49,152 | 32 |
| macOS ARM64 | 4,096 | 65,536 | 0 |
| macOS AMD64 | 3,072 | 49,152 | 0 |
| Windows AMD64 | 4,096 | 65,536 | 0 |
| Windows ARM64 | 3,072 | 49,152 | 0 |

All measured allocations free. Restoring recursive cleanup must exceed the stack
bound. Ordinary Linux binaries show cleanup loops with fixed 24-byte AMD64 and
64-byte ARM64 frames, excluding callees and the AMD64 incoming return address.
Zero sampled span means the address stayed fixed, not zero stack use. The report
also retains O1 results, hashes and candidate toolchains; baseline environment
metadata is only in CI logs. No elapsed time or C/Rust comparison was collected.
Use `suite=chain-cleanup` and `scripts/collect-chain-measurements.py`.

## CI compiler build cost

The [CI profile comparison](measurements/ci-compiler-profiles-2026-10-16.json)
compares two builds of the same fwp revision, `c81b0c9f`, on each runner. Rust
optimization level 0 is the baseline; level 1 is the candidate. Both retain debug
assertions and overflow checks. The inputs are the complete `linalg_ownership`
and `arc_tasks` test targets, with unchanged generated-C flags and cases. This
measures time spent building the compiler and running tests, not fwp program
speed against C or Rust.

Each profile has a separate build and cache, one warmup, and two measured samples
in order 0/1/1/0. The table uses median whole-test elapsed time; initial builds are
reported separately. A ratio below 1 means less elapsed time for these tests.

| Runner | Build at level 0 / 1 | Tests at level 0 / 1 | Test ratio, 1 divided by 0 | Extra initial build cost |
|---|---:|---:|---:|---:|
| Linux AMD64, 4 logical CPUs | 18.80 / 45.43 s | 49.90 / 40.16 s | 0.805 | 26.63 s |
| Intel macOS, 4 logical CPUs | 108.93 / 267.13 s | 132.92 / 99.27 s | 0.747 | 158.20 s |

Level 1 reduces test elapsed time by about 19.5% and 25.3% in this comparison,
while costing more to build. Child-process CPU ratios are 0.833 and 0.783.
Both profiles pass every selected test. Two samples do not characterize runner
noise, predict the complete CI gate, or establish memory savings. Physical CPU
models, host contention and resident memory were not sampled. The report retains
compiler versions, artifact build settings, executable hashes, samples and log
hashes; the workflow retains the complete logs.

## Memory used by complete remote-stream clients

**Work:** a native client receives integers 1..N from an interpreted loopback
HTTP/2 server. N is 64, 1,024 or 16,384. Clients either sum the stream, keep the
first iterator and reread its first value after summing, or consume only 32
values. For N=64 they print `2080`, `(2080, [1])` and `528`.

**Method for client memory reports:** three fresh processes per case; O2;
collection off, freeing on. Counts start after constant setup and finish after
entry/cached-value cleanup, before runtime shutdown. They include managed
requests, bytes and retains, not raw wire buffers, allocator pages, TLS/OS state,
server memory or total process memory. These are memory checks, with **no timings
or C/Rust baseline**. Ordinary native/raw interpreter outputs must agree first.
Reports with forced connection closure say so; that changes the transport work.

The [baseline](measurements/remote-client-memory-baseline-2026-10-17.json),
`456f2dbd`, leaves 64 managed bytes per consumed integer. The
[cache-owner change](measurements/remote-client-cache-ownership-2026-10-17.json),
`886dad3b`, releases each position's saved values after its last reader:

| Native client | Baseline final charge, 16,384 values | Candidate final charge, each tested size | Candidate one-pass peak, each tested size |
|---|---:|---:|---:|
| Linux AMD64 | 1,055,296 bytes | 6,480 bytes | 6,832 bytes |
| Linux ARM64 | 1,068,352 bytes | 19,536 bytes | 19,888 bytes |
| macOS AMD64 | 1,051,296 bytes | 2,480 bytes | 2,832 bytes |
| macOS ARM64 | 1,051,296 bytes | 2,480 bytes | 2,832 bytes |
| Windows AMD64 | 1,052,448 bytes | 3,632 bytes | 3,984 bytes |
| Windows ARM64 | 1,052,064 bytes | 3,248 bytes | 3,600 bytes |

At every tested size, one-pass peak and final charge are constant. Keeping an
old iterator intentionally keeps history until released. At 16,384 values,
retains rise from 16,385 to 81,921: cleanup gains cost extra bookkeeping.
Five managed allocations per additional integer remain. These are single-call
results; repeated calls and unread transport queues need their own tests.

Alias, cancellation, failure and deliberately missing-release controls accompany
the profiles. Use `suite=stream-clients`,
`scripts/collect-stream-client-measurements.py` and, for static code evidence,
`scripts/inspect-stream-client-binaries.py`. The collectors inspect artifacts;
they do not execute downloaded binaries locally.

### Moving captured values instead of retaining them again

A closure carries values for a later call. Consuming its only owner can move
those captures; a shared closure must preserve them for other callers.
The [six-host report](measurements/remote-client-capture-moves-2026-10-17.json)
compares cache ownership with capture moves at `afd7d460`, using the identical
clients and counting boundary above. Three processes agree:

| Received integers | Original tracing-dependent cache | Explicit cache ownership | Cache ownership plus capture moves |
|---|---:|---:|---:|
| 64 | 65 | 321 | 194 |
| 1,024 | 1,025 | 5,121 | 3,074 |
| 16,384 | 16,385 | 81,921 | 49,154 |

At 16,384 values, moves remove about 40% of the new ownership path's retains,
but still leave about three times the tracing-dependent baseline's count traffic.
Final charge is unchanged and one-pass peak falls 64 bytes per host. Retained
histories still preserve older values. Actual AMD64/ARM64 code tests uniqueness
and skips capture retention only on that branch; dispatch and stack storage
remain. No timing was measured. Collector option `--capture-moves` checks this
comparison against the cache-owner report.

## Memory left behind by repeated remote calls

**Work:** repeat the same 64-value remote call in one process for 1/16/256
batches. Full readers sum to 2,080; partial readers take 32 values and sum to 528.
Retained readers make two calls per batch, keeping the first iterator until a
reread: batch output 4,161. Three processes per case reuse one connection.
The client counting boundary/exclusions above apply.

The [baseline](measurements/repeated-remote-baseline-2026-10-17.json), `ac95632b`,
leaves 240 extra managed bytes per call on all six hosts. Full/retained readers
free queued messages, but partial readers leave 609 raw message bytes per call
in these samples: 155,904 after 256 calls. Queue occupancy can vary with scheduling.
Pooled connections and their I/O tasks are still live at the final sample;
their fixed storage is not a demonstrated leak. This identifies per-call
retention without measuring execution time.

### Releasing finished requests and unread messages

The [six-host request-owner report](measurements/remote-request-ownership-2026-10-17.json)
compares `ac95632b` with `997b23a9` on those identical repeated clients.
The connection's active list, reader and sender own the request. Releasing a
reader discards unread messages; it does not cancel an unfinished remote call.

Final charge becomes constant: 6,240 bytes Linux AMD64, 19,296 Linux ARM64,
2,240 either Mac, 3,392 Windows AMD64 and 3,008 Windows ARM64. Every request and
message releases, including the partial reader's previously retained 155,904
message bytes. Allocation counts are unchanged; one retain per call is added.
The 232-byte request header uses existing padding for its new flag.

Alias, failure and cancellation controls check every owner. The report measures
memory/counts, not time. Connections still needed separate cleanup at this
revision. Use `suite=stream-repeat` and
`scripts/collect-repeated-client-measurements.py` with the baseline report.

### Moving a selected field instead of retaining it again

**Comparison:** request cleanup at `997b23a9` versus `d7a161d1`, with the same
repeated-call programs and counters. Consuming a uniquely owned record can
transfer its selected owned field; shared records retain the field instead.
The [six-host report](measurements/remote-projection-moves-2026-10-17.json) records:

| After 256 batches, on every measured platform | Request cleanup alone: count increments | With compiler transfer | Reduction |
|---|---:|---:|---:|
| Full reads, 256 calls | 66,562 | 50,178 | 24.6% |
| Partial reads, 256 calls | 41,986 | 33,794 | 19.5% |
| Retained readers, 512 calls | 116,226 | 99,586 | 14.3% |

Allocation requests, bytes and final charge are unchanged; every request/message
releases. Actual AMD64/ARM64 code skips field retention on the unique path.
Other count lookups, result storage and dynamic calls remain. These percentages
are reductions in retain counts, not elapsed-time overhead.

### Memory after closing connections and finishing their I/O tasks

**Changed workload:** measurement hooks now close each connection and wait for
its reader/writer tasks before the next call. Keep the same full/partial/retained
clients, 64 integers, 1/16/256 batches and three processes. Ordinary interpreter
references still use pooling for output checks, so they do different transport
work. Compare revisions only with the same closure hooks.

In the [six-host baseline](measurements/closed-remote-baseline-2026-10-17.json),
`4103b0a0`, sockets close and tasks finish, but their records remain allocated:

| Platform | Connection allocation, charged bytes | Two I/O task allocations, charged bytes | Additional remaining bytes per connection |
|---|---:|---:|---:|
| Linux AMD64 | 320 | 3,584 | 3,904 |
| Linux ARM64 | 320 | 12,288 | 12,608 |
| macOS AMD64 and ARM64 | 320 | 1,280 | 1,600 |
| Windows AMD64 | 320 | 2,048 | 2,368 |
| Windows ARM64 | 320 | 1,792 | 2,112 |

Counts stop after task draining and cached-value cleanup, before runtime shutdown.
Collection is off; freeing is on. Stack pools, raw buffers, allocator/TLS/OS state,
server/process memory and time are excluded. Empty task lists alone do not prove
that task records were freed; retained binaries confirm the missing release paths.

### Freeing closed connections and finished tasks

The [six-host comparison](measurements/closed-remote-ownership-2026-10-17.json)
compares `4103b0a0` with `3a773a85`, using the same forced-close workload.
Connections gain explicit owners; finished internal I/O tasks free directly
after removal from scheduler lists and stacks.

| Platform | Before: remaining managed bytes after 256 full reads | After: remaining bytes at 1, 16 or 256 batches |
|---|---:|---:|
| Linux AMD64 | 1,001,216 | 1,792 |
| Linux ARM64 | 3,233,792 | 6,144 |
| macOS AMD64 and ARM64 | 410,240 | 640 |
| Windows AMD64 | 607,232 | 1,024 |
| Windows ARM64 | 541,568 | 896 |

The constant remainder matches one still-live root-task allocation. Every
connection/request/message releases. Allocation requests are unchanged, but
sharing adds three retains per connection: 50,178 → 50,946 for 256 full reads,
about 1.5% more. Task disposal adds no task count updates. These are counting
costs, with no elapsed-time or C/Rust comparison. Failure, cancellation and
missing-release controls pass. Use `suite=connection-repeat` for this workload.

### Memory retained by client inputs after sending finishes

**Work:** 1/16/256 remote calls, three processes each, with forced connection
closure/task draining. Four inputs test distinct lifetimes: sum integers 1..64
(output 2,080); uppercase `word-1`..`word-64` (total length 439); keep and reread
those strings (878); or offer 64 integers while the server returns only the
first three ×10 (60). Early completion sends a scheduling-dependent input count.

The [six-host baseline](measurements/sender-input-baseline-2026-10-17.json),
`f6ebb2e9`, already frees connections, requests and received messages but leaves
input/sender storage. Each additional complete synchronous call leaves 7,104
managed bytes; bidirectional/retained calls leave 11,952–17,456 depending on host.
Actual binaries show unowned iterator advancement and missing sender input cleanup.
The client-memory counter boundaries/exclusions apply; there is no timing
comparison. Ordinary output checks use pooling and cannot substitute for these
forced-close ownership measurements.

### Input owners and moves: bounded memory with measured count costs

The [six-host final report](measurements/sender-input-ownership-2026-10-17.json),
`06f3ac6f`, uses those same clients and forced-close hooks. Final managed charge
is constant for every tested size/mode: 1,792 bytes Linux AMD64; 6,144 Linux ARM64;
640 either Mac; 1,024 Windows AMD64; 896 Windows ARM64. Those totals match the
still-live root-task category. All transport/sender owners release.

An [initial Linux probe](measurements/sender-input-ownership-probe-2026-10-17.json)
bounded memory by retaining each continuation (the function producing the next
iterator node). The final compiler moves a unique node's continuation instead;
shared nodes preserve it. At 256 complete-input calls:

| Input mode | Original baseline | First ownership probe (Linux AMD64) | Final owners and moves | Extra versus baseline |
|---|---:|---:|---:|---:|
| Synchronous | 17,922 | 66,818 | 18,946 | 1,024 (+5.7%) |
| Bidirectional | 150,274 | 280,578 | 184,322 | 34,048 (+22.7%) |
| Retained original input | 181,762 | 344,834 | 248,578 | 66,816 (+36.8%) |

Allocation counts stay unchanged. Sender records request eight more bytes each,
within the same allocator size class. Early completion can consume different
input counts, so its deltas are not equal-work comparisons. Runtime uniqueness
checks and shared counts remain; the percentages above are **count overhead,
not time overhead**. [PR #159](roadmap-history.md#streamed-input-cleanup-and-continuation-moves-pr-159)
records acceptance. Use `suite=sender-repeat`.

## Server memory after completed remote calls

**Work:** four loopback service operations: greet a 64-character name (71-character
response); return integers 1..64 (sum 2,080); sum 64 received integers (2,080);
or send `tick 1`..`tick 64` through a channel (total length 439). A channel passes
values between computations; this one writes to the remote client.

**Method for this server series:** 1/16/256 calls on one connection; three fresh
servers per case; native O2; collection off, freeing on. Counters start after
listener/routing/root setup and finish after client disconnect and task retirement,
with the listener still open. A measurement-only listener wake retires the last
finished stack. Revisions must use this same boundary. Raw wire buffers, stack
pools, allocator/TLS/OS metadata, process memory and elapsed time are excluded.
There is **no C/Rust baseline**. Native/interpreted responses must agree.

The [six-host baseline](measurements/server-call-baseline-2026-10-17.json),
`06432959`, leaves these managed bytes after 256 calls:

| Platform | Greeting | Returned iterator | Sent iterator | Output channel |
|---|---:|---:|---:|---:|
| Linux AMD64 | 721,248 | 2,486,624 | 1,753,440 | 971,104 |
| Linux ARM64 | 1,844,064 | 3,609,440 | 2,876,256 | 2,093,920 |
| macOS ARM64 or AMD64 | 423,488 | 2,188,864 | 1,455,680 | 673,344 |
| Windows AMD64 | 522,560 | 2,287,936 | 1,554,752 | 772,416 |
| Windows ARM64 | 489,536 | 2,254,912 | 1,521,728 | 739,392 |

On Linux AMD64 each additional call leaves 2,800/9,696/6,832/3,776 bytes for the
four operations. Binaries show unfreed task/job records and unowned method/result
calls. The [fixture guide](../tests/fixtures/server-memory/README.md) explains the
programs. The following stages repair different owners; these old counts are
not the accepted compiler's remaining leaks.

### Freeing finished server tasks and keeping argument slots on the stack

The [six-host storage report](measurements/server-call-storage-2026-10-17.json)
compares `06432959` with `e6455c0d`, using the server method above. It frees
finished job/task records and puts temporary method arguments on the stack.
Each call saves one allocation and 24 requested heap bytes; retains are unchanged.

At 256 calls Linux final charge becomes 119,648/1,885,024/1,151,840/369,504 bytes
for greeting/returned stream/sent stream/output channel. macOS/Windows are 544
bytes lower. Memory still grows per call: method values and transport owners
remain unfinished at this stage. The one-argument helper uses 48 more stack
bytes, a measured heap/stack tradeoff, not a whole-program stack bound.

### Freeing method arguments and results: Linux measurement

The [Linux AMD64 intermediate report](measurements/server-method-values-linux-2026-10-17.json)
compares `e6455c0d` with `48ccd3d9` on the same server workloads. Typed cleanup
owns method arguments/results through errors and cancellation; methods receive
arguments directly, without a temporary function object. At 256 calls:

| Workload | Storage change | With argument/result cleanup |
|---|---:|---:|
| Greeting | 119,648 | 62,304 |
| Returned iterator | 1,885,024 | 62,304 |
| Sent iterator | 1,151,840 | 62,304 |
| Output channel | 369,504 | 365,408 |

Greeting/returned/sent streams still leave 240 extra bytes per call. Greetings
add one retain per call; received streams fall from 253 to 128. Every call saves
one allocation/eight bytes, with an additional allocation/24 bytes saved for sent
iterators. This stage covers one host; the following report extends the work.

### Freeing server values and output channels on all six hosts

The [six-host report](measurements/server-values-2026-10-17.json), `855fe3d1`,
compares against storage stage `e6455c0d` using the same method. It adds owned
method values and output channels that borrow each sent value. After 256 calls,
all four workloads leave 62,304 managed bytes on Linux and 61,760 elsewhere.
That is still **240 extra bytes per call**; request ownership is not yet fixed.

Against the original server baseline, each greeting/returned-stream call saves
two allocations; each sent-stream/channel call saves three. Requested-byte
savings are 32/32/56/32. Retains per call change from 0/64/253/0 to 1/64/128/64.
These are counts, not timings. The channel send loop still retains its channel
on each iteration, motivating the next borrowing change.

### Freeing server requests and borrowing fold captures

The [six-host report](measurements/server-borrows-2026-10-17.json), `8ed65cc7`,
compares the same four programs with `855fe3d1`. Requests and connections gain
explicit last-owner cleanup. Known fold callbacks borrow captured values kept
alive by the enclosing call, avoiding per-iteration count traffic.

| Native hosts | Previous stage, after 256 calls | With request/connection owners and borrowing |
|---|---:|---:|
| Linux ARM64 and AMD64 | 62,304 bytes | 544 bytes |
| macOS ARM64 and AMD64 | 61,760 bytes | 0 bytes |
| Windows ARM64 and AMD64 | 61,760 bytes | 0 bytes |

The old per-call growth disappears at all counts/repetitions. Allocation requests
and bytes are unchanged from the preceding stage. Retains still pay for sharing:

| Workload | Previous stage, retains per call | Combined change, retains per call |
|---|---:|---:|
| Greeting | 1 | 3 |
| Returned integer stream | 64 | 66 |
| Received integer stream | 128 | 132 |
| Output channel sending 64 texts | 64 | 4 |

There is also one retain per connection. Borrowing removes 64 retain/release
pairs per channel call. Actual Linux loops keep the channel in a register through
sends; other ownership/stack work remains. Instruction sections grow by
2,536 AMD64 / 2,352 ARM64 bytes. No speedup follows from counts or code size alone.

A separate 32,000-call Linux ARM64 test originally exposed RSS growth from
17,104 to 49,420 KiB, despite the managed-counter improvements. The complete
repair passes the unchanged 8 MiB limit with five 8,136 KiB samples.
[PR #160](roadmap-history.md#server-cleanup-and-borrowed-fold-values-pr-160)
records full acceptance. Use `suite=server-repeat`.

### Remote services without tracing and with fewer field retains

The [six-host report](measurements/remote-arc-field-moves-2026-10-17.json)
compares tracing code with collection disabled (`8ed65cc7`) against checked ARC
plus unique record-field moves (`efaab358`). Both use the same four server
workloads, inputs, O2 builds and counting boundary. ARC binaries omit tracing
scan/mark/sweep routines; all 216 memory rows match for allocations, bytes and
peak/final charge. Final charge remains 544 bytes Linux, zero elsewhere.

Moving a greeting record's string reduces retains from three to two per call;
other workloads keep 66/132/4 retains, plus one per connection. At 256 greetings,
769 retains become 513. This saves bookkeeping without removing message storage.
Instruction sections nevertheless grow 2.9% AMD64 / 3.4% ARM64, partly because
ARC ownership checks inline repeatedly. The later shared-check experiment below
addresses this cost. File-size jumps also include alignment padding.

The separate 32,000-call RSS test reports constant 16,084 KiB AMD64 and 8,144 KiB
ARM64. These process samples differ from managed counters and are not peak bounds.
No elapsed-time or C/Rust comparison was made.
[PR #161](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
records acceptance; use `suite=server-arc`.

### HTTP clients without tracing

**Comparison:** the same fwp HTTP client in tracing and checked ARC, source
`8770c03e`. **Work:** 1/16/256 sequential HTTP/2 requests to an interpreted
loopback server, consuming each body and summing status 200. One connection is
reused; test cleartext/TLS, three fresh client processes each. O2, separate
floating multiply/add rounding. [Six-host report](measurements/http-client-owners-2026-10-17.json).

Counts run after constant setup through entry/cached-value cleanup, before
runtime shutdown. Collection is disabled and freeing enabled in both modes.
They include iteration, options/URL handling and responses, not just transport.
All 216 rows match between modes. Each additional call costs **237 managed
allocations and 543 retains**. Final charge is constant; pooled connections/tasks
can still be alive:

| Native host | Final managed bytes | Peak managed bytes |
|---|---:|---:|
| Linux AMD64 | 6,368 | 9,392 |
| Linux ARM64 | 19,424 | 22,448 |
| macOS AMD64 | 2,368 | 5,392 |
| macOS ARM64 | 2,368 | 5,392 |
| Windows AMD64 | 3,520 | 6,544 |
| Windows ARM64 | 3,136 | 6,160 |

Raw wire buffers, TLS/OS/allocator state, server memory and process RSS are
excluded. No time was measured. ARC removes tracing symbols in 24 inspected
binaries, but the larger comparison client's code grows 11.1–14.1% through
repeatedly inlined ownership checks. This is code size, not measured cache cost.
Windows cancellation-probe header order was repaired before
[PR #162 acceptance](roadmap-history.md#http-client-owners-and-complete-connection-keys-pr-162).
Use `suite=http-clients` and `scripts/inspect-http-client-binaries.py`.

### HTTP server ownership and memory

**Comparison:** the same [server](../tests/web/server.fwp) in tracing and ARC,
`cd4f0b06`. **Work:** 1/16/256 sequential HTTP/2 `GET /hello` requests from a
native ARC client, then one HTTP/1.1 shutdown request and task draining. Three
fresh servers per count/mode/transport; cleartext and TLS; O2 with
`-ffp-contract=off`. [Six-host report](measurements/http-server-owners-2026-10-17.json).

Counters cover post-constant setup through main/cached-value cleanup, before
runtime shutdown, with collection off/freeing on. The original server costs
about 899 allocations and 2,318 retains per additional call; background work
causes small fractional slopes. Final charge stays constant:

| Host | Final managed bytes | Peak cleartext / TLS bytes | Largest RSS increase after warm-up |
|---|---:|---:|---:|
| Linux AMD64 | 1,792 | 19,824 / 19,840 | 2,048 KiB |
| Linux ARM64 | 6,144 | 45,936 / 45,952 | 44 KiB |
| macOS AMD64 | 640 | 12,464 / 12,480 | 192 KiB |
| macOS ARM64 | 640 | 12,464 / 12,480 | 128 KiB |
| Windows AMD64 | 1,024 | 14,896 / 14,912 | 60 KiB |
| Windows ARM64 | 896 | 14,128 / 14,144 | 16 KiB |

RSS (resident memory; Windows working set) is sampled separately in ordinary
servers after five batches of 4,096 requests, first batch warmup. Connection
replacement occurs at the normal 1,000-request limit. Every later sample stays
under 8 MiB growth. These are samples, not peak bounds; managed counters exclude
raw/TLS/OS storage and stack pools. No throughput baseline was collected.

All 36 inspected ARC binaries exclude tracing symbols; 24 tracing controls retain
them. Fixed-function storage below later reduces per-call costs.
[PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records acceptance. Use `suite=http-server-memory`.

### Keeping one copy of the ownership check

**Comparison:** identical ARC generated C with the ownership check inlined at
call entries versus one `noinline` copy of that existing helper. No check is
removed. The [two-host report](measurements/entry-check-code-costs-2026-10-17.json),
`e5bc8531`, uses Clang 18.1.3, O2, `-ffp-contract=off`, EPYC 7763 AMD64 and
Neoverse-N2 ARM64 (four virtual CPUs each). Instruction sections:

| Program | AMD64: copied → one check function | ARM64: copied → one check function |
|---|---:|---:|
| Integer loop | 18,194 → 15,938 bytes (−12.4%) | 16,780 → 14,828 bytes (−11.6%) |
| Numeric pipeline | 19,938 → 17,266 bytes (−13.4%) | 18,700 → 16,348 bytes (−12.6%) |
| Sorted map | 26,802 → 22,994 bytes (−14.2%) | 25,068 → 21,676 bytes (−13.5%) |
| HTTP client | 1,611,138 → 1,406,258 bytes (−12.7%) | 1,533,404 → 1,340,124 bytes (−12.6%) |
| HTTP server | 6,098,930 → 5,260,322 bytes (−13.8%) | 5,768,796 → 4,977,916 bytes (−13.7%) |

HTTP programs are compiled for size only. The loop/pipeline/map inputs are those
in the complete-program comparison; C checks output but is **not timed** here.
One warmup then six alternating whole-process samples give these one-copy/copied
elapsed ratios:

| Program | AMD64 elapsed ratio | ARM64 elapsed ratio |
|---|---:|---:|
| Integer loop | 1.016 | 1.000 |
| Numeric pipeline | 0.933 | 0.993 |
| Sorted map | 1.020 | 0.975 |

Separate instrumented builds record zero check executions in these workloads;
timing differences therefore do not isolate check execution cost. Instrumentation
can affect compilation. No allocations, live-memory or RSS counters were collected.
The accepted result is smaller code, not a general speed gain. Use `suite=entry-checks`.

## Fixed function values in the HTTP server

A function value can carry earlier arguments, called **captures**. If every
capture is itself a fixed function without captures, the compiler stores one
record in program storage instead of rebuilding it per request.

**Comparison:** the same ARC server before/after this change, `a141efd4` versus
`01ae40da`, then a paired repeat at `85988056` rebuilding the saved baseline C.
The [report](measurements/fixed-functions-2026-10-18.json) retains source/binary
hashes, hardware and every sample. Counts use the preceding HTTP workload:
1/16/256 `GET /hello` calls, three processes, cleartext/TLS. Slopes are the
256-call median minus the 16-call median, divided by 240; background work is included.

| Per additional HTTP request | Baseline | Candidate | Change |
|---|---:|---:|---:|
| Managed allocation requests | About 899 | About 722 | About 19.7% fewer |
| Actual reference-count increments | About 2,318 | About 1,901 | About 18.0% fewer |
| Allocations for classified fixed function records | 177 | 0 | 177 removed |
| Payload bytes for those records | 3,808 | 0 | 3,808 removed |

Both Linux hosts/transports agree. The tradeoff is 331 static records occupying
7,592 bytes and 618 startup address stores. Net data grows 5,240 bytes; code
shrinks 1.7% AMD64 / 1.4% ARM64. Final managed charge remains constant.

**Timing:** six fresh processes per version/transport, alternating order; 1,024
warm-up calls then 8,192 timed calls. The clock includes client startup, request/
response/network/server work; excludes compilation, server startup, warmup and
shutdown. Table entries are medians of six paired current/baseline ratios.
Clang 18.1.3, O2, `-ffp-contract=off`; EPYC 7763 and Neoverse-N2:

| Transport | AMD64 elapsed ratio | ARM64 elapsed ratio | AMD64 startup ratio | ARM64 startup ratio |
|---|---:|---:|---:|---:|
| Cleartext | 0.936 | 0.958 | 1.009 | 1.020 |
| TLS | 0.943 | 0.950 | 0.951 | 0.983 |

Request elapsed time falls about 4–6% in this run. Startup separately measures
spawn to listening announcement (roughly 1.4–2.3 ms cleartext, 4.2–5.7 ms TLS),
including loader/listener work; it does not isolate the address stores.
Six-host memory checks also pass, with at most 2 MiB sampled post-warmup RSS
growth. This is fwp versus older fwp, with **no C/Rust timing baseline**.
[PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records acceptance; use `suite=fixed-functions`.

## Generated REST and MCP server memory

REST exposes functions as HTTP endpoints; MCP exposes them as tools over HTTP or
standard input. The [six-host report](measurements/server-entries-2026-10-18.json)
compares tracing/ARC at `8dfc014d`, including the exact-number JSON repair.
An earlier lossy-number implementation would not be equivalent work.

**Work:** [record/alias/error fixtures](../tests/fixtures/server_entries.fwp).
Standard-input MCP cycles produce eight replies, including invalid requests;
notifications produce none. HTTP cycles make three requests (copy, alias, caught
error), followed by normal shutdown. Test 1/16/128 cycles, three fresh HTTP servers
per mode/count/transport; REST cleartext/TLS and MCP cleartext. Outputs match raw
interpretation. Builds use O2 and separate floating multiply/add rounding.

Counters cover post-constant setup through normal cleanup, including shutdown/
background work. Collection off, freeing on. Slopes between 16 and 128 cycles
are per additional reply/request, not isolated primitive costs:

| Workload | Managed allocations per additional reply/request | Reference-count increments |
|---|---:|---:|
| MCP standard input, eight-reply mix | 237.375 | 457.625 |
| REST HTTP/TLS, three-request mix | about 874.3–874.5 | about 2,426–2,427 |
| MCP HTTP, three-request mix | about 796.3–796.6 | about 1,969–1,970 |

Standard-input modes finish with zero counted bytes. A no-free control leaves
58,400/897,680/7,164,304 bytes, demonstrating detection of missing cleanup.
HTTP final charge is constant at the root-task totals: Linux AMD64/ARM64
1,792/6,144; macOS 640; Windows AMD64/ARM64 1,024/896 bytes.
Ordinary servers separately handle five batches of 1,024 cycles (15,360 requests),
sampling RSS after 100 ms settling. Largest post-warmup growth is 2 MiB; the limit
stays 8 MiB. These samples are not memory peaks.

Managed counters exclude raw/TLS/OS/allocator state and client memory. All 18
inspected ARC files omit tracing; 24 tracing controls retain it. **No time was
measured**, and these are not C/Rust overhead ratios.
[PR #164](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164)
records acceptance. Use `suite=server-entries`.

## WebAssembly task and browser-loader ownership

**Comparison:** JSPI (engine-supported suspension) versus Asyncify (rewritten
code that saves/restores execution state), plus deliberately broken cleanup
controls. The [report](measurements/wasm-host-owners-2026-10-18.json), `2e47a412`,
runs real wasm32 modules on Linux AMD64/ARM64. The browser loader is exercised
under Node, not actual browser engines.

**Work:** 16 rounds of tasks/channels, strings, repeated waits, returned values,
errors, cancellation and task-local state. O1/O2 ordinary/counting modules must
match raw interpretation, through WASI and the browser loader. Clang 18.1.3,
Binaryen 132, Node 24.21.0, `-ffp-contract=off`, 32 MiB main stack.
These recorded sizes describe that revision's fixture. The current fixture also
tests nested channel queues; its new checks do not update these historical sizes
or establish a speed comparison.

At shutdown, allocation/free-ledger totals and count entries must return to at
most the initialized baseline. Omitting task-state cleanup leaves 16 buffers /
2,048 bytes; omitting scheduler shutdown leaves 67,109,088 bytes, mostly 64 pooled
1 MiB task stacks. Both controls fail as required. The report inspects 72 modules,
including 32 broken controls, and retains exports, section sizes and hashes:

| Same task program, ordinary O2 build | Module file bytes | Code-section bytes |
|---|---:|---:|
| JSPI | 577,618 | 366,064 |
| Asyncify | 724,240 | 522,427 |

Asyncify adds 25.4% file bytes and 42.7% code bytes for this program. Names are
included in both. No elapsed-time or C/Rust comparison was collected.
Ordinary modules initially declare 32.0625 MiB memory; instrumentation adds
256 KiB static storage. Each task requests 1 MiB stack, with up to 64 completed
stacks pooled until cleanup. Asyncify also grows a 16 MiB-plus-one-page workspace.
Freed blocks are reusable but WebAssembly memory capacity does not shrink.
JavaScript promises, stacks, strings and host RAM are outside these counters.
Use `suite=wasm-hosts`; [PR #164](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164)
records production acceptance.

## Returning owned values to C callers

A C caller releases an owned fwp result with `fwp_release_NAME`, including all
fields of a returned record. For example, `greet("c")` returns a string released
with `fwp_release_greet(result)`. See [C interop](tutorials/09-c-interop/README.md).

**Check, not timing benchmark:** [six-host report](measurements/library-results-2026-10-18.json),
`d6d36961`. After warmup, 256 call batches read/return strings and aliases,
compute a derivative and run a pipeline. Static/shared linking, O1/O2 and
derivative-buffer reuse off/on make eight configurations. Shared hosts load/call/
unload three times. Outputs match interpretation; all 96 shutdown observations
have zero counted bytes/collections. Twenty-four inspected ARC libraries omit tracing.

| Measured call | Additional retains | Intermediate record allocations |
|---|---:|---:|
| Return the copied input string unchanged | 0 | 0 |
| Return two fields sharing the copied input string | 1 | 0 |

Two shared fields need one additional owner. Eligible result fields pass directly,
avoiding an intermediate record box; other calling conventions may still box.
Counts exclude initial count creation/release. Read-only input strings still copy.
Four missing-cleanup/extra-allocation/extra-retain controls per host fail as required.
Windows export/toolchain repairs prevent accidentally calling the system's different
`norm` function (25 instead of 5). No C/Rust speed was measured; counted bytes
exclude allocator capacity and host RAM. [PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records acceptance. Use `suite=library-results`.

## Cleanup after failed map and set operations

**Check, not timing benchmark:** partial results must free when a map callback,
allocation or retain fails, while independently held inputs remain valid.
A reproducer with 32 caught failures left 2,048 bytes before the repair and zero
afterward. The [six-host report](measurements/map-failures-2026-10-18.json),
`af834f8c`, covers 22 conversion/insertion/removal/update/set/callback operations.

Inject failures at each of 108 allocation/retain points (110 with reuse poisoning).
Six configurations combine O1/O2 with ARC, stressed tracing and stressed tracing
plus reuse verification. Callbacks changing strings to integers and vice versa
must match interpretation and clean up by result type. All 66 focused tests pass;
48 saved binaries include tracing-presence controls. Missing partial-map or first
scratch-array cleanup must fail the probe. ARC shutdown charge is zero.

Counts exclude allocator capacity/process RAM; binary sizes identify the tested
files, not a claimed code-size improvement. No elapsed-time/C/Rust comparison
was made. [PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records acceptance; `scripts/summarize-map-failures.py` audits the artifacts.

## Building numeric maps and sets without temporary lists

### Compact set storage: measured allocation size

Sets need one key per entry; the former map-shaped layout also reserved an
unused value word. The [six-host report](measurements/compact-sets-2026-10-19.json)
checks the compact layout at `a6dd7609` on Linux, macOS and Windows, each on
ARM64/AMD64. This is a storage check, not a before/after timing comparison.

For 4,096 distinct inline integer keys, the final container requests 32,776 bytes
(`8 + 8*n`). The previous layout's formula gives 65,544 bytes (`8 + 16*n`).
The probe measures the new requests at 0, 1, 7, 257 and 4,096 keys in ARC/tracing
at O0/O2; empty sets make no request. Allocator headers, rounding, construction
scratch and separately allocated keys are additional. Maps still store both
keys and values, even when every value is `()`.

All 41 focused tests passed on each host, with none ignored. The report audits
144 actual binaries, their formats, sections and tracing symbols. Inspected O2
Linux AMD64 and macOS ARM64 set-copy loops use eight-byte key spacing; the ARM
loop also uses paired vector copies for larger inputs. This establishes the
representation, not optimal register allocation or a speed advantage over C.
[PR #172](roadmap-history.md#compact-set-storage-pr-172) records full production
acceptance, including WASI execution.

### Direct integer range sets

`range 0 n | set.from-list` builds the distinct integers from zero through
`n - 1`. Ordinary construction allocates a list and two scratch buffers before
the final set; direct construction writes already sorted keys into that set.
Both preserve the same values. [The design](design.md#constructing-integer-range-sets-directly)
limits this transformation to inline integer ranges consumed immediately.

The [six-host report](measurements/range-sets-2026-10-19.json), measured at
`7901a576`, confirms these construction requests for 4,096 keys:

| Construction | Allocation requests | Total requested bytes | Final container bytes |
|---|---:|---:|---:|
| Ordinary list, scratch and set | 4,099 | 196,624 | 32,776 |
| Direct set | 1 | 32,776 | 32,776 |

These counts agree at O0/O2 in ARC and tracing modes on all six hosts. They exclude
startup/output, allocator headers and rounding; ARC charge returns to baseline
after releasing each result. Zero keys make no requests in either version.

The runner measurement compares the same fwp program with `FWP_MAP_BUILD=0/1`,
at 32, 4,096 and 65,536 keys. It hashes every key, checks output against raw
interpretation and records eight whole-process timing samples per version.
Construction, hashing, startup and output are included. Separate instrumented
executables count allocations and memory. This is fwp versus fwp, not a C/Rust
baseline. Timings use ARC/O2, Clang 18.1.3 on Linux, Apple Clang 17 on macOS and
Clang 23.1.3 on Windows. At 65,536 keys:

| Host / CPU | Ordinary median | Direct median | Direct / ordinary |
|---|---:|---:|---:|
| Linux AMD64 / Xeon 8573C | 6.389 ms | 2.515 ms | 0.394 |
| Linux ARM64 / Neoverse N2 | 5.190 ms | 1.788 ms | 0.345 |
| macOS ARM64 / virtual M1 | 6.084 ms | 3.660 ms | 0.602 |
| macOS AMD64 / i7-8700B | 19.501 ms | 10.608 ms | 0.544 |
| Windows AMD64 / EPYC 7763 | 17.768 ms | 13.373 ms | 0.753 |
| Windows ARM64 / Cobalt 100 | 17.450 ms | 14.505 ms | 0.831 |

Linux/macOS sample ranges are separated at this size; Windows ranges overlap.
At 32 keys, ratios span 0.945–1.047 with overlapping ranges, including four slower
medians. Do not generalize the larger-input gain to small programs. The
[earlier Linux run](measurements/range-sets-linux-2026-10-19.json) on an EPYC 7763
also had a slightly slower 32-key median.

Including output, 65,536 keys use 2 allocation requests / 524,322 requested bytes,
versus 65,540 requests / 3,145,770 bytes. Peak charged storage falls from 3,670,032
to 524,296 bytes. Both versions have zero measured retains, final charge and
collections. These are managed-storage counts, not process RAM.

All 264 focused tests passed with none ignored. The audit inspected 228 binaries,
including 48 range-set allocation probes. In O2 ARC probes, Linux AMD64 `e0`
uses packed integer addition and vector stores (`0x4b60` onward); ARM macOS `_e0`
uses vector addition and paired stores (`0x100002140` onward). Neither filling loop
calls a function or accesses the stack; scalar tails handle leftover keys.
The surrounding function still allocates and manages its result owner. This is
evidence for these loops, not universally optimal registers or zero heap use.
[PR #173](roadmap-history.md#direct-integer-range-sets-pr-173) records passing
production and documentation checks for this change.

### Mapped lists: accepted earlier measurements

**Work:** construct a set or map from a range of integers reduced modulo 257,
so there are at most 257 distinct keys. The set prints its size; the map stores
the original integers and prints the last value for key 5. Duplicates keep the
last value. Inputs are compiled constants, including 32 and 65,536 elements.

**Comparison:** the same fwp compiler/program with `FWP_MAP_BUILD=0` versus `1`;
this is not C/Rust overhead. The [six-host report](measurements/collection-joined-storage-2026-10-18.json),
`b8700990`, includes direct known callbacks, eliminated temporary lists/tuples,
and joined key/value buffers. Checked ARC, native O2, no tracing/reuse poisoning.
Eight samples per variant use recorded randomized order. The whole-process timer
includes startup, callback work, construction, sorting, deduplication, final query
and output; compilation/profiling are separate. All 576 elapsed samples are saved.

For 65,536 inputs, ratio means optimized/ordinary elapsed median:

| Native host | Set: ordinary / optimized ms | Time ratio | Map: ordinary / optimized ms | Time ratio |
|---|---:|---:|---:|---:|
| Linux AMD64 | 7.319 / 3.788 | 0.518 | 9.512 / 3.983 | 0.419 |
| Linux ARM64 | 6.728 / 2.950 | 0.438 | 9.481 / 3.334 | 0.352 |
| macOS ARM64 | 9.646 / 6.677 | 0.692 | 10.402 / 8.009 | 0.770 |
| macOS AMD64 | 16.093 / 9.119 | 0.567 | 22.236 / 11.269 | 0.507 |
| Windows AMD64 | 17.129 / 13.772 | 0.804 | 20.067 / 14.200 | 0.708 |
| Windows ARM64 | 18.052 / 14.649 | 0.812 | 19.769 / 15.203 | 0.769 |

Set requests fall 131,077 → 4; map requests 196,614 → 5. Peak counted bytes fall
4,718,600 → 1,053,696 for sets and 6,815,752 → 2,102,272 for maps. Retains, final
charge and collections are zero. Counters exclude allocator capacity/process RAM.
At 32 inputs ratios span 0.861–1.078 with overlapping ranges: no consistent gain.
Temporary storage still grows with input length. The measured revision stored
unused value slots in final sets; the current compact-set change removes those
slots, but these historical timings do not measure that change. Small integers
still occupy full words. See [current validation](development-state.md) and the
[storage contract](ownership.md#compact-set-storage).

All 78 focused tests and 120 binary checks pass, including allocation failure,
callback error/cancellation and alias preservation. [PR #166](roadmap-history.md#numeric-map-and-set-construction-pr-166)
records full acceptance. [Actual loop inspection](measurements/collection-set-code-2026-10-18.json)
finds SIMD on AMD64 and scalar pairs on ARM64, without calls/stack accesses in
the selected direct-call loops; entry frames and sorting still cost storage/work.

Earlier stages remain separately identified: [initial construction](measurements/collection-build-baseline-2026-10-18.json),
[map code](measurements/collection-build-code-2026-10-18.json),
[set buffers](measurements/collection-set-storage-2026-10-18.json), and
[direct calls](measurements/collection-build-direct-2026-10-18.json).
Their different-run absolute timings do not isolate each change's benefit.
Use `suite=collection-build`, then `collection-report` to audit its artifacts.

### Larger maps exposed a storage-layout problem

**Work:** the maintained map program builds 500,000 distinct entries and makes
two million queries. Keys are `(index * 7919) % 1000003`; input is scrambled,
then sorted. It prints the built size before querying. “Sorted pairs” in older
reports describes final storage, not presorted input.

**Comparisons:** construction off/on; separate versus joined key/value buffers;
and complete fwp/C/Rust implementations beside one another. Always name which
pair is being compared. The [initial report](measurements/large-map-construction-2026-10-18.json)
finds 1,500,009 → 8 allocation requests and 56,000,040 → 24,000,040 peak counted
bytes, but AMD64 traced elapsed time rises 8.3% for complete work and 36.4% for
construction-only work. Fewer allocations did not imply faster execution.

**Method:** ordinary complete-program and construction-only timers cover separate
whole processes. They cannot isolate query time by subtraction. Diagnostic builds
instead time actual construction/sort/query intervals inside the same program;
instrumentation changes code and is excluded from ordinary timings. Reports keep
raw samples, order, hardware, flags, binary hashes and separate profiles.
Joined/separate ordinary comparisons use 24 fresh processes per variant with
rotating order (six appearances in each position); phase diagnostics use 16.
Replays validate and rerun saved binaries without rebuilding, and retain their
own order/sample counts. Do not pool different CPUs or diagnostic/ordinary times.

The joined-layout repair puts related lanes in one allocation, including scratch,
and removes two requests. Results from controlled runs/replays:

| Evidence | Observation and limit |
|---|---|
| [First storage run](measurements/large-map-storage-2026-10-18.json) | Xeon 8573C sorts both layouts quickly, but joined full-work tracing is 4.6% slower. This host cannot verify the original slow EPYC sorting fix. |
| [Phase comparison](measurements/large-map-storage-phases-2026-10-18.json) | EPYC 9V74 old sorting takes 99–108 ms in slow cases; joined takes 14–22 ms across both observed address-bit values. Full-work joined/separate ratios: 0.905 tracing, 0.768 ARC. ARM64 ratios: 0.951/1.069, with broad overlapping ARC ranges. |
| [Two AMD64 repeats](measurements/large-map-storage-repeats-2026-10-18.json) | EPYC 7763 ratios 0.920/0.840; EPYC 9V45 1.007/0.990 with overlapping ranges. Neither answers the Xeon result. |
| [First four replays](measurements/large-map-replay-2026-10-18.json) | EPYC hosts: tracing 0.761–0.929, ARC 0.770–0.928. Construction gains repeat. |
| [Second four replays](measurements/large-map-replay-two-2026-10-18.json) | Xeon 8573C tracing slowdown repeats at 4.4%, despite faster construction. Instrumented phase timing changes the result; it does not invalidate the ordinary slowdown. |

The address correlation suggests a layout-sensitive sorting cost, not a proved
CPU-cache mechanism. Query/sort instructions match after resolving addresses;
identical instructions do not imply identical cache placement or time.

In the phase report's same-run complete-program comparison, fwp/C ratios are
0.918 tracing and 0.954 ARC on EPYC, 0.992/0.962 ARM64. Against Rust they are
1.110/1.154 and 1.073/1.041: **4–15% more time than Rust**. Different sorting
implementations and overflow rules remain; this is not isolated language overhead.

The six-host joined-layout run initially timed out rebuilding the compiler on
Intel macOS. Reusing the already-built integration-test compiler fixes that
redundancy without changing coverage or limits. Replacement `39108116774` passes;
[the report](measurements/collection-joined-storage-2026-10-18.json) audits all
120 binaries. PR #166 left the Xeon timing issue unresolved; the later
[matching-host comparison](#rechecking-the-original-xeon-slowdown) verifies its
repair in the combined compiler.

The PR #166 compiler makes 2,000,001 retains in this workload. A
[hand-edited borrowing prototype](measurements/large-map-borrow-prototype-2026-10-18.json)
is explicitly not compiler acceptance: Xeon 6973P-C combined tracing remains
1.4% slower than the old separate/retained layout. The actual compiler change
below replaces that experiment with a checked lifetime proof.
Integer-equality hoisting (8–9% slower on ARM64) and the earlier standalone split
initialization experiment (more code without a clear gain) were rejected.
Use `suite=large-map`, `map-storage` and `map-replay` for the storage comparisons.

### Compiler-proved cached map reads

**Comparison:** the saved `93cb93a0` compiler output, which retains the cached map
on every query, versus actual `774d838c` compiler output with proved borrowing.
[Five-host results](measurements/cached-map-borrows-2026-10-18.json) come from
[run 39112673197](https://github.com/e6qu/fun-with-pipes/actions/runs/39112673197).
This is fwp versus an earlier fwp compiler, not a C/Rust overhead measurement.

**Work and timing:** the same 500,000-entry map and two million queries described
above. For each revision, tracing/ARC and separate/joined layouts give eight
variants. The separate layout is an explicit measurement transformation of C;
the borrow comes from the compiler. All variants are compiled on the same host
with GCC 13.3, `-O2 -std=gnu11 -ffp-contract=off`, then run as 24 fresh processes
each in rotating order (three appearances per position). Wall time includes
startup, construction, queries, output and teardown; compiler build time is
excluded. Separate instrumented executions count allocations and retains and are
excluded from timing. Reports retain every sample, command, source/binary hash,
CPU description, section size and profile. Eighty ordinary/profile binaries were
audited across the five jobs.

On the joined layout, median borrowed/retained time ratios are 0.958–0.982:
**1.8–4.2% less elapsed time** on EPYC 7763, EPYC 9V45 and Neoverse N2.
Retains fall from 2,000,001 to 1; allocation requests and peak counted bytes are
unchanged, and final counted bytes remain zero. This removes bookkeeping rather
than map storage. These hosts do not establish an Intel result or resolve the
Xeon 8573C regression.

PR #167 integrated this compiler and also removed an unnecessary heap box when
returning a tuple or variant after the borrow. These prepared measurements predate
that repair. [Delivery history](roadmap-history.md#interactive-tools-and-cached-map-borrows-pr-167)
records production acceptance; the later matching-host measurements below cover
the integrated compiler. Reproduce with `suite=map-borrow`, `evidence_run=39106005017`, and
`source_revision=93cb93a0f717b317814ecfc162de0c2f516dbfbd`; the workflow compiles the
current branch and uses the saved baseline sources, checking identical inputs,
outputs, counts and binary identities before recording times.


The [integrated compiler results](measurements/cached-map-integrated-2026-10-18.json)
from [run 39125883230](https://github.com/e6qu/fun-with-pipes/actions/runs/39125883230)
use `085626f3`, including the direct-result repair. The same protocol above yielded
60 passing focused checks and 80 audited executable/profile records. This adds
Intel evidence, without substituting a different processor for the original
Xeon 8573C regression.

Each ratio is new elapsed time divided by the named baseline time; below 1 is
faster. “Joined” keeps both revisions' map layout joined and isolates borrowing.
“Combined” compares joined/borrowed against separate/retained, so includes both
changes. “Separate” isolates borrowing with the older separate layout.

| CPU / sample | Tracing joined | ARC joined | Tracing combined | ARC combined | Tracing separate |
|---|---:|---:|---:|---:|---:|
| AMD EPYC 7763 64-Core Processor / 2 | 0.9638 | 0.9686 | 0.8868 | 0.7518 | 1.0647 |
| AMD EPYC 7763 64-Core Processor / 4 | 0.9571 | 0.9641 | 0.7957 | 0.7361 | 0.8793 |
| Intel(R) Xeon(R) 6973P-C / 1 | 0.9357 | 0.9376 | 0.9688 | 0.9305 | 1.0387 |
| Intel(R) Xeon(R) Platinum 8370C CPU @ 2.80GHz / 3 | 0.9170 | 0.8835 | 0.9685 | 0.9034 | 1.0630 |
| Neoverse-N2 / 1 | 0.9801 | 0.9601 | 0.9562 | 0.9609 | 0.9319 |

The joined tracing medians on Xeon 8370C fell from 381.575 to 349.890 ms,
and on Xeon 6973P-C from 405.236 to 379.191 ms. Retains again fall from
2,000,001 to 1, with unchanged allocation requests, peak charged memory and
zero final charge. Separate-layout tracing borrowing is slower on both Intel
samples and one EPYC sample. Count savings therefore do not establish a general
timing win. That run did not include the original Xeon 8573C. The matching-host result
below completes this specific comparison.


### Rechecking the original Xeon slowdown

[Run 39128516933](https://github.com/e6qu/fun-with-pipes/actions/runs/39128516933)
measured actual compiler `e1fb8ba3` with the same program, toolchain flags,
24-sample rotating order, timing boundary and saved baseline described above.
The [raw reports](measurements/cached-map-xeon-2026-10-18.json) retain all samples,
binary/source hashes, compiler commands, section sizes and allocation profiles.
All five jobs passed 12 focused checks each; 80 ordinary/profile binaries were
audited. This run includes the **Xeon Platinum 8573C** from the original regression.

On that processor, retained joined storage took **392.915 ms** versus
**376.889 ms** for retained separate storage: the old slowdown reproduced at
**4.25%**. Compiler-proved borrowing with joined storage took **366.810 ms**:
**6.64% less time** than retained joined storage and **2.67% less** than the old
separate-storage baseline. This resolves the measured full-map regression for
this program on the named model. It does not prove every map shape or processor
benefits, nor identify a single microarchitectural cause for the old penalty.

The same ratios used in the preceding table remain below 1 when faster:

| CPU / sample | Tracing joined | ARC joined | Tracing combined | ARC combined | Tracing separate | ARC separate |
|---|---:|---:|---:|---:|---:|---:|
| AMD EPYC 7763 64-Core Processor / 1 | 0.9607 | 0.9650 | 0.7349 | 0.8797 | 0.8118 | 1.1570 |
| AMD EPYC 7763 64-Core Processor / 4 | 0.9689 | 0.9619 | 0.7341 | 0.8967 | 0.8879 | 0.9855 |
| AMD EPYC 9V45 96-Core Processor / 3 | 0.9639 | 0.9738 | 0.9664 | 0.9528 | 0.9842 | 0.9555 |
| INTEL(R) XEON(R) PLATINUM 8573C / 2 | 0.9336 | 0.9288 | 0.9733 | 0.9336 | 1.0468 | 0.9461 |
| Neoverse-N2 / 1 | 0.9849 | 0.9864 | 0.9880 | 1.0174 | 0.9566 | 1.0313 |

Borrowing improves the maintained joined layout in both memory modes on every
host in this run. Some comparisons with the older separate layout are slower:
Xeon separate/tracing is 4.68% slower, one EPYC separate/ARC sample is 15.70%
slower, and Neoverse combined/ARC is 1.74% slower. Preserve those distinctions:
the change removes repeated ownership bookkeeping, not every layout/cache cost.
Retains fall from 2,000,001 to 1 with unchanged allocations, peak charged bytes,
and zero final charge. These are fwp revision comparisons; they say nothing by
themselves about remaining overhead against equivalent C or Rust.

Resampling the same 24 Xeon rounds 10,000 times gives a 95% percentile interval
of **0.9659–0.9882** for the combined new/old median-time ratio. Each resample
keeps the paired variants from a round together. This estimates uncertainty
within this runner's sample; it does not cover differences between machines or
future runs. The raw report records the seed, method and intervals for all three
Xeon comparisons. The old slowdown's interval remains above one, and the new
program's interval below one.

A repeat at `f957980a`, [run 39129855448](https://github.com/e6qu/fun-with-pipes/actions/runs/39129855448),
passed all five jobs and 60 focused checks. All 80 ordinary/profile binaries and
their generated C match the earlier same-architecture artifacts byte for byte.
Two further Xeon 8573C samples put the joined-borrowed/old-separate tracing ratio
at **0.9731** and **0.9702**: 2.69% and 2.98% less process time. This repeats the
named repair with identical machine code, rather than measuring another compiler
optimization. [All repeat samples and profiles](measurements/cached-map-repeat-2026-10-18.json)
are retained. Joined borrowing is faster in both modes on all five samples;
separate-layout borrowing remains slower on both Xeon tracing samples (4.83%
and 3.65%) and EPYC 9V74 tracing/ARC (8.29% and 4.65%).
