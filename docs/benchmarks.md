# Benchmarks and overhead

A performance result compares **two implementations of stated work**. There is
no single number for “fwp overhead.” A report must say whether it compares fwp
with handwritten C/Rust, two versions of fwp, or one isolated runtime operation.
A faster new fwp build does not establish parity with another language.

## Latest merged-code snapshot: 31 October 2026

PR #233's [production benchmark job](https://github.com/e6qu/fun-with-pipes/actions/runs/41174213818/job/124458289963)
measures `fd19b9e4`, whose tree matches merged `73a6b20d`. Host: Linux AMD64,
AMD EPYC 7763, four available CPUs; GCC 15.2.0, Rust 1.99.1; C/fwp O2 and Rust
optimized, no fwp LTO. One warmup and six rotated runs measure whole processes,
including startup, construction, computation, output and cleanup. Compilation is
excluded. These are a **single CI snapshot**, without identical-code controls or
a second session. They are observations, not stable speed guarantees or an
estimate of language-wide overhead. Detailed inputs are [below](#what-each-program-actually-does).

| Program | C ms | Rust ms | fwp ms | fwp extra time vs C / Rust |
|---|---:|---:|---:|---:|
| Fibonacci, 35 | 48.979 | 44.537 | 15.658 | −68.0% / −64.8% |
| Checked loop, 100 million steps | 126.882 | 107.275 | 158.734 | +25.1% / +48.0% |
| Sorted map, 500,000 pairs / 2 million lookups | 411.124 | 338.409 | 363.642 | −11.5% / +7.5% |
| Map/filter/sum, 20 × 1 million elements | 35.613 | 22.612 | 14.226 | −60.1% / −37.1% |
| Ordered million-key set and hash | 15.183 | 15.400 | 17.563 | +15.7% / +14.0% |
| Format strings then count characters | 146.610 | 156.296 | 6.487 | −95.6% / −95.8% |
| Count characters directly | 3.806 | 7.110 | 5.171 | +35.8% / −27.3% |

The pipeline peers materialize collections that fwp eliminates. In `strings`,
fwp avoids formatting that C/Rust still perform; `text-length` supplies the more
direct comparison. Sorting implementations also differ. These differences belong
to the results; they must not be presented as isolated ARC or dispatch costs.

Three separate GNU-time runs of the same executables measure peak **resident
memory**, the RAM occupied by the process, including runtime and mapped libraries:

| Program | C peak KiB | Rust peak KiB | fwp peak KiB |
|---|---:|---:|---:|
| Fibonacci | 1,544 | 2,040–2,212 | 2,060–2,064 |
| Checked loop | 1,544 | 2,116–2,228 | 2,060–2,192 |
| Sorted map | 16,880 | 9,908–9,980 | 17,688–17,816 |
| Map/filter/sum | 13,316–13,320 | 9,956–9,968 | 2,064 |
| Ordered set/hash | 9,348–9,352 | 9,820–9,976 | 9,868–10,000 |
| Strings | 1,544 | 2,044–2,284 | 2,064–2,192 |
| Direct character count | 1,544 | 2,120–2,244 | 1,680–2,064 |

Separate fwp profiles report zero managed requests/retains for Fibonacci, loop,
pipeline and both character-count programs. The map makes four requests totaling
24,000,032 bytes, peaks at 16,000,008 charged bytes and performs one retain. The
set makes one 8,000,008-byte request with no retains. All seven finish with zero
managed charge; deliberate leaks are detected. These counters exclude raw runtime
buffers, stacks and allocator metadata. **Allocated bytes over time, live payload,
resident RAM and reserved virtual addresses are different measurements.** The
[buffer report](measurements/unique-buffer-peers.md#process-memory-and-virtual-reservations)
records about 65.1 GiB reserved virtually with only 1.5–1.9 MiB resident in its
small diagnostic; the reservation is not that much occupied RAM.

Large remaining gaps are visible in the older, explicitly dated
[parser comparison](measurements/parser-workspace.md) (about 5–9× C/Rust time)
and [automatic derivatives](measurements/eager-captures.md#results) (44–58× the
handwritten C derivative in the largest current-result case). These are not
fresh measurements of #233. Allocation reductions do not erase those gaps or
establish that peak memory fell. The [Swift protocol](#swift-comparison) adds the
closest ownership-model peer without discarding C and Rust.

## Swift comparison

Swift is a required comparison for new ownership/performance work alongside C
and Rust. It uses ARC, but also value types and compiler elimination of ownership
operations; ARC does not imply every operation allocates or changes a count.
See Swift's [ARC guide](https://docs.swift.org/latest/documentation/the-swift-programming-language/automaticreferencecounting/)
and [compiler description](https://www.swift.org/documentation/swift-compiler/).
Use ordinary Swift `Array`, values and escaping closures, without artificial
boxing to imitate fwp. Report differences in algorithms, copying and runtime startup.

The first `swift-peers` suite compares all seven programs on native Linux ARM64
and AMD64, in two independent sessions per architecture. It uses the official
`swift:6.4.2-noble` container, Swift language mode 6, `-O` and whole-module
optimization, checked arithmetic, and explicit native targets. Never use
`-Ounchecked`. C and generated fwp C use GCC O2, disabled floating contraction,
no fast math or LTO; Rust uses optimized builds without LTO. Retain actual CPU,
compiler/target versions, dynamic libraries, sources, generated C and executables.
Compare sessions only when host/toolchain identities match. Container runtime
startup is outside the process timer; each program's runtime startup is inside.

Before measurement, freeze this protocol: two warmup rounds, then 24 measured
rounds of eight labels (each language and its byte-identical copy). Eight-round
blocks balance positions and preceding programs. Every process must return the
same result. Retain every duration/output/status. An identical-copy median ratio
above 1.02 makes that case/session inconclusive; do not drop it, relax the limit
or retry unchanged observations. These establish descriptive baselines, not a
candidate speed budget. Keep three separate peak-RSS runs per ordinary executable.
Swift/C/Rust allocation and ARC-operation counts are **not yet measured** here.
Neither elapsed time nor RSS alone attributes overhead to ARC.

The same suite compiles a Swift closure factory separately from its caller.
It checks both scalar operations from the [callable comparison](measurements/returned-callables.md),
counts 0/1/16/4,096, checked-overflow cases, actual native binaries and Swift's
optimized intermediate code. A separate reference-capture control verifies normal
release and deliberately retained ownership. It does not fabricate allocation
counts for the scalar closure. Swift callable phase timing, allocation/count
instrumentation, weak subscriptions and parser/numerical peers remain required
before broader ownership or numerical parity claims. **The [first four sessions and their artifact audit](measurements/swift-peers.md)
are complete.** Five ARM64 cases pass both sessions’ noise controls; map and
pipeline do not. The two AMD64 sessions use different CPU models and cannot
establish repeated-host results. All observations remain recorded. The `swift-peer-report`
workflow rechecks a completed run and prints timing/RSS rows without executing
its binaries; supply the explicit evidence run and full measured source commit.

Execution time and working memory take priority over executable size. Keep size
and stack costs visible because they can affect caches and memory; a size increase
alone does not establish a slowdown. For the current callable candidate, preserve
the original 17.7% ARM O1 text-budget rejection, but assess its performance and
memory rather than treating the percentage alone as the delivery decision.
Its count reduction is verified; its elapsed-time benefit is still unmeasured.

## Choose the question first

| Question | Evidence | Interpretation |
|---|---|---|
| How long does a complete program take versus C/Rust? | [Seven checked-arithmetic peers](#fwp-compared-with-c-and-rust) | Includes startup, algorithms, storage and output; not isolated compiler overhead |
| Where do the CPU benchmark gaps occur? | [Calculation, startup and output protocol](measurements/cpu-phases.md) | Diagnostic clocks change code; retain ordinary timings and do not infer a speedup from phase observations |
| What do numeric kernels cost? | [Current array and matrix protocol](measurements/kernel-baselines.md) | Separates calculation from construction/cleanup; excludes process startup |
| What does differentiation add? | [Current descent comparison](measurements/descent-costs.md) | Compare automatic and explicit fwp derivatives first; C/Rust use explicit formulas |
| Did an ownership change reduce work? | [Ownership measurements](measurements/README.md#ownership-and-storage) | Paired counts/bytes; a retain saved is not a measured speedup |
| Does a service release completed work? | [API memory](measurements/http-application-memory.md) | Samples between request groups; final process cleanup alone is insufficient |
| Which experiments failed? | [Rejected or inconclusive experiments](measurements/README.md#rejected-or-inconclusive-experiments) | Slower results and noise controls remain part of the evidence |

The [report index](measurements/README.md) lists results and their protocols.
Each result belongs to its recorded revision and host. A merged change does not
refresh an old timing sample. [Delivery history](roadmap-history.md) records merges
and validation; [PLAN.md](../PLAN.md) owns future optimization work.

## Current scripts and historical reports

Current scripts measure one native ownership model. Allocation profiles report
requests, requested bytes, retains, peak managed charge and final managed charge;
they do not print a collection counter. Timed runs remain separate from profiles.
The [application protocol](application-acceptance.md#word-frequency-comparison)
explains how to record a fresh C/Rust baseline or compare a named prior fwp build.

Saved JSON and tables retain their original revisions, modes and observations.
Use the scripts at that revision to reproduce them. Current readers deliberately
reject obsolete schemas; they do not convert old tracing evidence into evidence
for GC removal. The collector-free compiler passed
[integrated validation in PR #217](roadmap-history.md#tracing-gc-removal-pr-217).
That does not refresh historical timings: each report identifies any comparison
that still needs a new measurement run.

## Planned ownership comparisons

These comparisons belong to plan B1/B2. Compiler improvements and their ownership
checks already exist; the table identifies which peer comparisons still need
work. The [ownership direction](gc-removal-design.md) explains the lifetime rules.

| Workload | Existing evidence | Remaining comparison work |
|---|---|---|
| Unique numeric buffer | [C/Rust peer comparison](measurements/unique-buffer-peers.md) covers lengths 0, 16, 4,096 and 262,144, output/cleanup, payload versus metadata, process memory, code and stack; [newer sessions](measurements/buffer-current.md) retain failed controls | Qualify the remaining timing comparisons without retrying unchanged failures. Separate construction/work/release timing from the existing whole-process totals. Preserve [array removal](measurements/generated-array-folds.md) and [State range](measurements/state-range-folds.md) cost checks without treating them as timing acceptance. |
| Returned partial application | [Three-host C/Rust/fwp comparison](measurements/returned-callables.md) separates construction, repeated calls and destruction at O1/O2; fwp uses a 16-byte heap payload, while C/Rust captures are inline | The [phase experiment](measurements/callable-phases.md) adds Swift and measures invocation/whole-call costs; retain the original ARM O1 size rejection. The user merged #234 before timing acceptance. |
| Subscription with weak back-link | [Weak-link semantics](gc-removal-design.md) and lifetime tests cover registration, expiration and cleanup | Add explicit C/Rust registrations with the same active-call and cancellation rules. Measure weak metadata allocation, live/expired acquisition, callback work and teardown separately. |
| Recursive parser workspace | [A6](measurements/parser-workspace.md) already compares all three languages at 31/511/8,191 balanced nodes and 127 left-nested nodes, with phase timings and storage observations | Preserve those results. Complete the broader memory accounting (reserved/committed storage and peer transient peaks) and Rust stack observations before claiming every B1 field; current reported capacities are not process memory. |

Measure construction, useful work and cleanup separately and together at small,
cache-sized and larger inputs. Match checked arithmetic and lifetime behavior;
report representation differences, compiler/flags/host, repeated elapsed times,
allocations, count/weak operations, peak live bytes, committed/reserved memory,
binary size and stack use. Count-instrumented timings are not production timings.
The missing fields above keep these broader comparisons open. Declare each
measurement protocol before execution; retain existing results at their original
revisions instead of presenting them as current-code measurements.

Measure the ownership-analysis pass separately from specialization, C generation
and C compilation on N/2N/4N queues, captures, recursive calls and pipelines.
Record analyzed IR size, summary updates, specialization count, time and memory;
set numerical regression budgets from the baseline before increasing precision.
The [ownership-analysis protocol](measurements/ownership-analysis.md) defines the
current N/2N/4N fixture and separates proof timing from frontend work. External
language benchmarks motivate experiments, not fwp overhead estimates.

## Reuse tests are allocation comparisons

[The reuse tests](../tests/reuse.rs) compare two versions of the same fwp program:
ARC with in-place updates, and identical generated C with `FWP_NO_REUSE` forcing
copies. Both retain/release owners and use C O2. This isolates reuse from tracing
and preserves the same output. It does **not** compare fwp with C or Rust, time
the calculation, or establish language-wide overhead.

| Input and work | Required allocation difference |
|---|---|
| Update a five-field record 1,000,000 times | Copy control >10 MiB; reuse <1 MiB |
| Build a depth-16 tree, increment all nodes ten times, sum | Reuse allocates less than one quarter of copy control |
| Array push / array set / map update fixtures | Copy control >1,000 / 100 / 1,000 MiB; reuse <10 MiB each |

The observation is cumulative allocator-accounted managed bytes, including construction
and updates, reported at process exit. It is not peak live memory: a program can
allocate a gigabyte cumulatively while keeping only a small working set alive.
Separate [bounded-memory tests](../tests/native_memory.rs) retain the long-loop 64 MiB peak
RSS limit and HTTP/REST growth limits of 16 MiB across 20,000 requests. RSS is
whole-process resident memory, including allocator and runtime costs. These are
regression limits, not claims of optimal space or performance.

## Reading a result

Divide fwp time by the named baseline time. `1.25×` means 25% more elapsed time;
`0.80×` means 20% less. Extra time is `(fwp / baseline - 1) × 100%`. Always name
which baseline: fwp can be faster than C and slower than Rust in one workload.
Do not average unrelated ratios into a language-wide score.

A ratio of medians differs from a median of paired ratios. Use the statistic and
execution order stated by the report. Elapsed time includes scheduling delays;
CPU time measures processing time. Neither identifies a bottleneck on its own.
Identical-code controls reveal when measurement variation is too large for the
claimed effect. Compilation, profiling and initialization are included only when
the report's timer explicitly includes them.

## fwp compared with C and Rust

Each directory in [`bench/`](../bench) contains `main.fwp`, `main.c` and
`main.rs`. The programs must print the same result. The runner builds native
executables with `fwp build -O2`, the explicitly selected `CC -std=c11 -O2 -ffp-contract=off`,
and `rustc --edition=2021 -O`. Native fwp uses counted ownership; there is no
tracing mode. `CC` must name the compiler and `FWP_LTO=0`
keeps generated C in one source file without link-time optimization.
After one warmup per executable, it measures six runs each and reports the median: the average of
the two middle times after sorting. Execution order rotates C/Rust/fwp,
Rust/fwp/C and fwp/C/Rust, twice. “Native” means machine code;
this comparison does not time the fwp interpreter.

The clock covers **process startup, input construction, calculation, allocation
and printing**. It excludes compilation. It is not a measurement of just the
inner calculation, startup alone or peak memory. The report separately records
one compilation time and the executable file size for each implementation.
Compilation includes tool startup and linking; it excludes building the fwp
compiler itself. Binary sizes include differing runtime and linking choices.
The report names its memory mode and build flags. Older snapshots may use
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

Production benchmarks and the focused `benchmark-comparison` suite also measure
peak process memory with
GNU time in three separate runs of each actual timed executable. Separate fwp
binaries count managed allocations, retain operations and charged live storage;
these exclude raw buffers, stack storage and allocator metadata. Each instrumented
program is paired with an intentional unreleased allocation that the observer
must detect. Their timings are not used. Saved C, binaries, observations and
stack reports permit inspection; those stack reports describe the instrumented
images, not the original timed programs. C/Rust allocation counts are not measured.

Signed data calculations now use checked 64-bit operations in all three peers.
C uses overflow builtins and Rust uses `checked_*`; fixed input bounds keep
ordinary loop/index increments within range. The hash in `range-set` deliberately
wraps modulo 2^64. Failure messages differ and are outside these fixed-input
timings. The [peer-check protocol](measurements/checked-peers.md) describes dynamic
boundary inputs, failure order and allocation-failure controls. Its [two-host results](measurements/checked-peers.md#native-linux-results) retain
all samples and remaining gaps; dated reports retain their original rules.
Changing a peer does not demonstrate a compiler speedup.

### What each program actually does

| Program | Input and work | Important differences between implementations |
|---|---|---|
| `fib` | Compute `fib(35)`, with `fib(0)=0`, `fib(1)=1`, otherwise `fib(n-1)+fib(n-2)` | Same recurrence. Compilers can transform calls differently. All three check signed subtraction and addition. These inputs fit all three. |
| `loop` | Start `(i, sum)=(100000000, 0)`; while nonzero, compute the decremented index, then `(i*3)%7`, then the new sum, in that checked order | fwp expresses the loop state as a pair; its compiler can turn that into local variables. C and Rust write the loop directly. Checked arithmetic and generated code can still differ. |
| `map` | Build `(key(i), i)` for `i=0..499999`, where `key(i)=(i*7919)%1000003`; sum 2 million lookups using the same key formula, missing values as zero | All three use contiguous sorted pairs searched by bisection. C uses `qsort`, Rust `sort_unstable_by_key`, fwp its map builder; construction/sorting costs differ. This compares complete implementations, not an isolated lookup operation. |
| `range-set` | Build the distinct keys `0..999999`, then compute FNV-1a over the canonical set encoding: unsigned LEB128 count followed by eight little-endian bytes per key | All three start with ordered keys and need no sorting. C uses a heap buffer, Rust a vector, fwp a set. Hash multiplication wraps modulo 2^64 in all three. Optimizers may remove storage or combine loops; inspect retained binaries before claiming equal allocations. Runtime startup, allocation, hashing and output are timed together; the report explicitly names counted ownership. |
| `pipeline` | For `0..999999`, multiply by 3, keep even results and sum; sum 20 rounds | fwp can combine the stages into one traversal without intermediate lists. C explicitly fills arrays; Rust constructs vectors and filters them. Eliminating that work can outweigh language overhead. |
| `strings` | For `i=0..1999999`, concatenate decimal `i`, decimal `3*i` and `#`; sum text lengths | fwp can calculate some formatted lengths without creating the string. C uses `snprintf` and `strlen`; Rust uses `format!` and byte length. All characters here are ASCII, so the lengths agree. The programs need not perform the same formatting or allocation work. |
| `text-length` | The same input, fwp pipeline and result as `strings`; C and Rust count decimal digits in groups of 16, 8, 4, 2 and 1, without formatting text | This compares fwp's elimination of temporary text against handwritten counting. All three check multiplication and sums for overflow; the inputs fit. The C/Rust failure messages differ and are not exercised. Startup, output, scheduling and remaining ownership work are still included; fwp uses exact decimal-threshold comparisons while C/Rust retain grouped division. The [four-session comparison](measurements/decimal-count.md#balanced-results-accepted-measurement) meets its fixed limits but still shows a 25.0–26.2% gap versus C. |

A result that is faster than C here does not mean fwp outperforms the best
hand-written C version. Likewise, a slower result does not identify how much
came from reference counting, checks, allocation or the algorithm.
The timing runner alone does not separate those costs; the companion memory
profiles measure their explicitly defined counters.
The [integer-text report](measurements/integer-text.md) records the first
two-host direct-counting comparison and its raw samples. Older six-program
measurements do not include this new peer comparison.

### Recorded checked-ARC results

The [2026-10-24 checked-peer report](measurements/checked-peers.md) is the
cross-language snapshot with matched signed-overflow checks. Its hosts are AMD
EPYC 9V45 (AMD64) and Neoverse-N2 (ARM64), with GCC 13.3.0 and Rust 1.99.1.
It retains all seven programs, raw samples, code sizes, compilation times and
separate memory observations. It is not a measurement of today's checkout.

These historical rows illustrate why each baseline matters:

| Work | Host | Extra time vs C | Extra time vs Rust |
|---|---|---:|---:|
| 100-million-step checked integer loop | AMD64 | +0.7% | +23.9% |
| Same loop | ARM64 | −25.7% | +14.7% |
| Direct decimal character counting (`text-length`) | AMD64 | +58.4% | −7.9% |
| Same counting work | ARM64 | +93.9% | +6.4% |

For later measured revisions, use the [repeated CPU baseline](measurements/cpu-baselines.md)
and [accepted decimal-counting results](measurements/decimal-count.md). Their
ratios belong to their named hosts and cannot be spliced into the older table.

The `strings` comparison has a large fwp advantage because fwp eliminates
formatting while those C/Rust peers still construct text. `text-length` supplies
the closer handwritten counting comparison. Neither measures arbitrary string
processing. Earlier [ARC observations](measurements/arc-comparison.md) and
tracing snapshots keep their original arithmetic rules; comparing different
sessions does not isolate an ARC or compiler speedup.

## Numerical workloads compared with C and Rust

The [current kernel protocol](measurements/kernel-baselines.md) covers map/reduce
at 65,537/262,145 elements and two matrix products, 65×67 by 67×63 and
257×259 by 259×255. It records exact input formulas, ordered calculations and
separate computation and allocation-inclusive timers. One AMD small-array
identical-copy control differs by 3.08%, above its 2% limit. The overall baseline
is therefore incomplete. Typed loop-state improvements have correctness evidence,
but no accepted numerical speed claim. These peers are not optimized BLAS.

The [current derivative comparison](measurements/descent-costs.md) uses Rosenbrock
descent with 3, 33 and 129 coordinates. Automatic differentiation records arithmetic
and walks the record backwards; an explicit derivative calculates a formula
written by the programmer. Compare those two fwp forms before comparing them
with handwritten C/Rust. Inputs, complete outputs, update counts and memory
observations are retained. [Capture binding](measurements/eager-captures.md)
improves updated solves in its initial sessions, but a repaired-source zero-update
recheck exceeds its 2% regression limit. D2 remains open.

Older reports change list/array storage, borrow captures, repeat solves or replace
printing with a checksum. They are distinct experiments, not successive universal
overhead figures. The [report guide](measurements/README.md#numerical-applications)
keeps those differences and all rejected results explicit.

Benchmark timer failures must stop the program before a timestamp is used.
The kernel and map timers now check `clock_gettime`; the related pipe test helper
uses the same rule. [Executable controls](../scripts/check-measurement-clocks.py)
compile the five actual helpers at O1/O2 and inject valid timestamps, failure with
and without a stored timestamp, and a deliberately missing error check. This
repairs an error path; it does not explain or accept the recorded timing variation.
Historical binaries and observations remain unchanged.

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
- **Retains/releases:** updates to owning references. The final release can
  destroy an object; other releases only remove an owner.
- **Historical collection counts:** runs of the former tracing collector. Current
  fwp has no tracing collector or collection counter; old zeros did not prove
  its absence.

A *control* is a deliberately changed implementation used for comparison. For
example, disabling one optimization in the current compiler isolates that
optimization better than comparing unrelated compiler releases. It still does
not reproduce every cost of an earlier release.
Process resident memory (RSS) includes more than managed values. It can include
stacks, allocator pages, native buffers and loaded libraries; reserved virtual
address space is another quantity again. A decrease in managed charge does not
imply the same decrease in RSS. `0` collections does not prove collector code
is absent. A zero final balance does not prove storage stayed bounded between
operations. These claims need separate observations and binary checks.

## Self-tail recursion compared with an explicit loop

`measure-tail-recursion.py` compares the same fwp countdown written recursively
and with `loop`, `Again` and `Stop`. The focused language job uses one million
iterations, eight samples, O0/O2 and counted ownership. Both print zero.
Timing includes fresh-process startup, calculation, output capture and teardown;
compilation and profiling are excluded. Recursive median divided by explicit-loop
median measures this abstraction's cost within fwp, not C/Rust overhead.

Separate 1,000/full-count profiles require unchanged allocation count and peak
charge with zero final charge. Stack-use estimates describe individual functions,
not aggregate maximum stack. Deep interpreter/O0 tests establish bounded frames
for eligible self-tail transfers; ordinary recursion, resource-bearing frames and
source-debugger execution retain their documented limits. See
[tail calls](design.md#tail-calls-and-recursion).

## Running comparisons

Full benchmarks run on GitHub runners. For the native Linux C/Rust comparison:

```sh
CC=gcc FWP_LTO=0 cargo test --release --test bench benchmarks -- --ignored --exact --nocapture
```

It writes the report to standard output, `target/bench.md` and the `bench` job
summary. The `benchmark-comparison` focused suite runs this checked-ARC comparison
on native Linux AMD64/ARM64 with GCC. Both it and production CI inspect the actual
C/Rust/fwp binaries with the [binary reviewer](../scripts/inspect-benchmark-binaries.py),
check input hashes and timing summaries, and require checked-ARC
fwp images to exclude tracing scans. The inspection does not execute downloaded
binaries or turn these descriptive timings into a speed guarantee.
[Corruption controls](../scripts/test-benchmark-evidence.py) must reject a wrong
memory label, wrong machine architecture, object file and missing timing sample. For remote reproduction, push the source branch and dispatch the appropriate
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
cases and extra storage too. Correct output is required. The descriptive seven-program snapshot sets no
speed acceptance threshold. Dedicated optimization experiments freeze their
limits before measuring a candidate; a failed identical-code control makes the
result inconclusive rather than waiving those limits. [Delivery history](roadmap-history.md)
records which source versions completed the required tests.

## Historical measurements

Older datasets remain under `docs/measurements/` with their source IDs and
original settings. They explain past decisions; they are not a queue of work to
repeat and are not relabelled as current results. Start with the
[measurement index](measurements/README.md), not an old run instruction copied
into a status page. New budgets and required follow-ups are listed in
[the implementation plan](../PLAN.md).

[Generated REST/MCP server memory](measurements/server-entry-memory.md) defines
the request counts, allocation boundaries, resident-memory limits and omitted-free
control. It is a cleanup/space check, not a C/Rust timing comparison.
