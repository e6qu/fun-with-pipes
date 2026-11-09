# Benchmarks and overhead

A performance result compares **two implementations of stated work**. There is
no single number for “fwp overhead.” A report must say whether it compares fwp
with handwritten Swift/C/Rust, two versions of fwp, or one isolated runtime operation.
A faster new fwp build does not establish parity with another language.

## Read a result

| If the table says… | It establishes… | It does not establish… |
|---|---|---|
| fwp 12 ms; C 10 ms | fwp takes 1.2× the time, or 20% extra, for this case | A universal 20% language overhead |
| 256 fewer allocations | 256 allocation requests were eliminated | A measured speedup or lower peak memory |
| Zero final managed bytes | The observed managed storage was released | Zero process RAM, stack or runtime cache |
| An identical copy varies beyond the limit | This timing session is inconclusive | Permission to discard the result and retry for a pass |

Each report should answer: **which implementations, which input, what timed work,
which host/toolchain, and what difference in behavior or algorithm?** Detailed
[measurement terms](terminology.md#tests-and-measurements) explain ratios and memory.

Extra time is `(fwp time / baseline time - 1) × 100%`. Name the baseline and
statistic: a ratio of medians differs from a median of paired ratios. Elapsed time
includes scheduling delays; CPU time measures processing time. Neither identifies
a cause on its own. Do not average unrelated ratios into a language-wide score.

## Latest complete-gradient comparison

[Known array callbacks](measurements/structured-array-callbacks-2026-11-08/README.md)
compares fwp before and after removing temporary derivative objects, across
neighboring, independent and dense calculations. Both ARM64 sessions show about
91% less computation for the 129-input neighboring gradient and 85% less for
independent loss. AMD64 copy noise leaves its timing acceptance open.

Allocation requests fall from 1,284 to 260 and from 518 to 260 respectively,
including input/output containers. Peak managed storage remains 9,536 bytes;
all owners and raw derivative buffers are released. The report separates
construction, complete-gradient work, release, process RSS and compiler/stack
costs. These are fwp-before/after results, not a new C/Rust/Swift comparison or
a complete iterative solve. [All #272 platform gates pass](measurements/structured-callback-delivery-2026-11-09/README.md).

## Complete callback service

Each call creates 4,096 messages containing 16 integers, delivers them and frees
the service's data. The [four-language comparison](measurements/weak-callback-time-2026-11-09/README.md)
uses ordinary C owners, Rust `Rc`/`Weak`, Swift weak references and fwp channels.
Two sessions per host pass all identical-copy noise controls:

| Host | fwp call time | fwp / C | fwp / Rust | fwp / Swift |
|---|---|---|---|---|
| ARM64, Neoverse N2 | 6.47 ms | 20.22–20.23× | 17.21–17.28× | 5.12× |
| AMD64, EPYC 7763 | 7.78–7.84 ms | 18.65–18.79× | 15.54–15.66× | 6.64–6.70× |

These ratios include construction, delivery and cleanup; 5.12× means 412% extra
time. Representations and synchronization differ, so the gap is not an isolated
ARC cost. The report also retains cancellation, expiration and handled-error
cases, full-process time, allocation profiles, RSS and build costs. fwp's process
RSS is lower than Swift's here but higher than C/Rust's. This is a serial queued
service, not the network throughput/latency experiment below.

## Remaining service load measurements

The native HTTP correctness test runs 64 clients with 200 requests each and
checks shutdown with a request in flight. Its 12,800 successful requests do not
establish throughput, latency or sustained capacity.

Milestone 5 has a [separate measurement contract](measurements/application-tooling.md#sustained-http-load).
Its endpoint, concurrency levels, request windows and error accounting are fixed;
sustained results remain pending. The required evidence is:

- Freeze endpoint work, request/response sizes, keep-alive policy, concurrency
  levels, warmup, measured duration, host limits and baseline source before runs.
- Report completed requests per second and median/p95/p99 request latency at
  each concurrency level, alongside errors and timeouts. Do not omit failures
  from the denominator or mix load-generator time with server computation.
- Measure steady allocation traffic and long-running live storage/RSS; distinguish
  bounded pools and warmed caches from continuing growth.
- Exercise slow readers/writers, backpressure, client disconnects, cancellation
  and shutdown under load. Check partial-response and resource cleanup behavior.
- Set acceptance limits from the stated application and measured starting point;
  retain saturation and inconclusive results. A fixed correctness request count
  is not a substitute for this contract.

## November 7 complete-solve derivative comparison

The [November 7 local-derivative comparison](measurements/computed-numeric-time-2026-11-07/README.md)
uses objectives built from neighboring pairs. The local form computes derivatives
with `Dual` numbers (a value plus its derivative); ordinary reverse AD records
operations and walks that tape backward. Both use the same fwp compiler.

Long local solves with passing controls take **48–65% less time** than reverse AD.
For 129 coordinates and 199 updates, all four sessions show **56–59% less time**:

| Architecture, two sessions | Local AD / C time | Reverse AD / C time |
|---|---:|---:|
| ARM64, Neoverse-N2 | 4.23–4.27× | 9.74–9.77× |
| AMD64, EPYC 7763 | 5.41–5.71× | 12.95–13.76× |

Local AD is also 2.6–8.1% slower than handwritten fwp arrays on this largest case.
C/Rust use handwritten derivatives and reuse buffers; allocation, arithmetic and
formatting differ. These are complete-solve implementation gaps, not isolated ARC
or language overhead. Timings include launch, repeated solves, output and exit.
GCC uses O2 without fast math, floating-point contraction or LTO.

The compiler removes two temporary numeric records per neighboring edge: the
largest eight-solve process drops from 409,297 to 1,745 managed requests. It now
matches the handwritten fwp array request/retain counts, with zero tape storage
and zero live managed storage at exit. This does not make the whole program
allocation-free. The linked report gives byte traffic, live peaks, RSS and stack.

Three runtime sessions pass every limit. One AMD64 small long-case copy control
varies by 2.08%, above the frozen 2% limit, so that timing remains inconclusive.
Two [compiler-cost copy controls](measurements/computed-numeric-analysis-2026-11-07/README.md)
also miss; all 5% compiler time/RSS budgets pass. The local-gradient helper exists
only in an experimental test fixture, not the standard library.
[All final platform gates and the complete audit passed](measurements/computed-numeric-delivery-2026-11-08/README.md).

Earlier [matched-result](measurements/matched-option-time-2026-11-04/README.md)
and [iteration-history](measurements/final-iteration-time-2026-11-04/README.md)
comparisons remain tied to their measured sources; they are not current-code
ratios. No Swift derivative counterpart was measured. The [Swift comparisons](#swift-comparison)
below cover other workloads.

## Recorded whole-program snapshot: PR #269

Source: `e79657624`, same tree as merged `bbcaafea`;
[retained reports and artifact identity](measurements/production-baseline-2026-11-08/README.md).

| Setting | Recorded value |
|---|---|
| Host | Linux AMD64, AMD EPYC 7763, four available CPUs |
| Compilers | GCC 15.2.0, Rust 1.99.1; C/fwp O2, Rust optimized, no fwp LTO |
| Samples | One warmup, six rotated measured runs |
| Timed | Whole process: startup, construction, computation, output, cleanup |
| Excluded | Compilation |
| Qualification | One CI snapshot; no identical-code controls or second session |

These observations are not stable speed guarantees or language-wide overhead.
Inputs and implementation differences are [below](#what-each-program-actually-does).

| Program | C ms | Rust ms | fwp ms | fwp extra time vs C / Rust |
|---|---:|---:|---:|---:|
| Fibonacci, 35 | 48.670 | 44.245 | 15.278 | -68.6% / -65.5% |
| Checked loop, 100 million steps | 128.769 | 106.924 | 159.768 | +24.1% / +49.4% |
| Sorted map, 500,000 pairs / 2 million lookups | 395.800 | 320.880 | 355.184 | -10.3% / +10.7% |
| Map/filter/sum, 20 × 1 million elements | 33.987 | 21.335 | 18.988 | -44.1% / -11.0% |
| Ordered million-key set and hash | 14.458 | 14.659 | 16.634 | +15.0% / +13.5% |
| Format strings then count characters | 145.941 | 155.598 | 4.804 | -96.7% / -96.9% |
| Count characters directly | 3.595 | 6.787 | 4.851 | +34.9% / -28.5% |

The pipeline peers materialize collections that fwp eliminates. In `strings`,
fwp avoids formatting that C/Rust still perform; `text-length` supplies the more
direct comparison. Sorting implementations also differ. These differences belong
to the results; they must not be presented as isolated ARC or dispatch costs.

Three separate GNU-time runs of the same executables measure peak **resident
memory**, the RAM occupied by the process, including runtime and mapped libraries:

| Program | C peak KiB | Rust peak KiB | fwp peak KiB |
|---|---:|---:|---:|
| Fibonacci | 1,544 | 2,168–2,280 | 2,064–2,192 |
| Checked loop | 1,544 | 2,040–2,120 | 2,064–2,192 |
| Sorted map | 16,876–16,880 | 9,852–9,872 | 17,684–17,816 |
| Map/filter/sum | 13,320 | 10,064–10,100 | 2,064 |
| Ordered set/hash | 9,348–9,352 | 9,900–9,976 | 9,744–9,872 |
| Strings | 1,544 | 2,116–2,180 | 2,060–2,064 |
| Direct character count | 1,544 | 2,104–2,164 | 2,064 |

Separate fwp profiles report zero managed requests/retains for Fibonacci, loop,
pipeline and both character-count programs. The map makes four requests totaling
24,000,032 bytes, peaks at 16,000,008 charged bytes and performs one retain. The
set makes one 8,000,008-byte request with no retains. All seven finish with zero
managed charge; deliberate leaks are detected.

These counters exclude raw runtime
buffers, stacks and allocator metadata. **Allocated bytes over time, live payload,
resident RAM and reserved virtual addresses are different measurements.** The
[buffer report](measurements/unique-buffer-peers.md#process-memory-and-virtual-reservations)
records about 65.1 GiB reserved virtually with only 1.5–1.9 MiB resident in its
small diagnostic; the reservation is not that much occupied RAM.

The older [parser comparison](measurements/parser-workspace.md) still records
about 5–9× C/Rust time. The derivative figures above supersede the older
44–58× C snapshot for their recorded sources and hosts; they do not refresh the
parser measurements. Allocation reductions alone establish neither
elapsed time nor peak memory. The [Swift protocol](#swift-comparison) adds the
closest ownership-model peer alongside C and Rust.

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
`-Ounchecked`.

C and generated fwp C use GCC O2, disabled floating contraction,
no fast math or LTO; Rust uses optimized builds without LTO. Retain actual CPU,
compiler/target versions, dynamic libraries, sources, generated C and executables.
Compare sessions only when host/toolchain identities match. Container runtime
startup is outside the process timer; each program's runtime startup is inside.

The frozen sampling rules are:

| Setting | Requirement |
|---|---|
| Warmups | Two rounds |
| Measured rounds | 24; eight labels (four languages and their byte-identical copies) |
| Ordering | Eight-round blocks balance positions and preceding programs |
| Correctness | Same result from every process; retain all durations, outputs and statuses |
| Copy-control limit | Median ratio above 1.02 makes the case/session inconclusive |
| Process memory | Three separate peak-RSS runs per ordinary executable |

Do not discard failures, relax limits or retry unchanged observations for a pass.
These are descriptive baselines, not a candidate speed budget. Timing/RSS cannot
attribute overhead to ARC. The separate [allocation profile](measurements/swift-allocations.md)
measures pipeline/map allocator calls and stacks on both Linux architectures;
fwp's direct mappings have separate managed-storage counters. Individual peer
ARC operations remain unmeasured.

The same suite compiles a Swift closure factory separately from its caller.
It checks both scalar operations from the [callable comparison](measurements/returned-callables.md),
counts 0/1/16/4,096, checked-overflow cases, actual native binaries and Swift's
optimized intermediate code. A separate reference-capture control verifies normal
release and deliberately retained ownership.

The [scalar closure profiles](measurements/swift-scalar-closures-2026-11-09/README.md)
now attribute allocations to the actual factory. [Callable phase timings](measurements/callable-phases.md)
retain the original regressions. [Weak operations](measurements/weak-operation-time-2026-11-09/README.md)
and the [complete service](#complete-callback-service) are measured separately;
ARC-operation counts and broad numerical/ownership parity remain unestablished.
**The [first four sessions and their artifact audit](measurements/swift-peers.md)
are complete.** Five ARM64 cases pass both sessions’ noise controls; map and
pipeline do not.

The two AMD64 sessions use different CPU models and cannot
establish repeated-host results. All observations remain recorded. The `swift-peer-report`
workflow rechecks a completed run and prints timing/RSS rows without executing
its binaries; supply the explicit evidence run and full measured source commit.

Execution time and working memory take priority over executable size. Keep size
and stack costs visible because they can affect caches and memory; a size increase
alone does not establish a slowdown. For the merged borrowed-call change, preserve
the original 17.7% ARM O1 text-budget rejection, but assess its performance and
memory rather than treating the percentage alone as the delivery decision.
The [phase measurements](measurements/callable-phases.md) show faster invocation,
but three AMD64 construction regressions fail the combined acceptance rule.

## Loop and array measurements

[The phase comparison](measurements/loop-array-peers-2026-11-08/README.md) measures
computation, input construction and result release separately. In its qualified
single-session observations, the large checked loop takes 18–20% less computation time
than C on ARM64 and approximately the same on AMD64. This does not contradict an
older whole-process ratio: the timed work and sources differ.

ARM64 large map/folds also take less time than these C/Rust peers, while the
largest local-derivative case takes 2.47 times C and 4.98 times Rust. The peers use
handwritten derivatives and two mutable buffers; fwp produces immutable arrays.
Most AMD64 array/derivative controls fail. The report keeps each ratio's noise
status, exact flags, process RAM and unmeasured peer allocation counts explicit.
[Candidate/reference results](measurements/fresh-array-costs-2026-11-08/README.md)
are separate: ARM64 confirms faster fresh-output stores; cross-platform milestone
acceptance remains open. Neither fewer retains nor a successful audit closes it.

The [captured-map comparison](measurements/captured-array-maps.md) extends
storage reuse to runtime scalar coefficients. It compares sensor calibration and pixel adjustment against a
same-source build disabling only that selection. It checks exclusive, shared and
slice inputs, with construction/work/release timings and separate memory counts.
[Repaired results](measurements/captured-map-repaired-2026-11-08/README.md) show
84–94% less computation on both largest applications in four sessions, 199 fewer
array allocations and roughly half the managed peak storage. No qualified case
regresses; noisy controls leave combined acceptance open. Native safety and
measurement audits pass; [All delivery gates pass](measurements/captured-map-delivery-2026-11-08/README.md).
[Initial results](measurements/captured-map-initial-2026-11-08/README.md) and
earlier unmet targets remain unchanged.

## Choose the question first

| Question | Evidence | Interpretation |
|---|---|---|
| How long does a complete program take versus C/Rust? | [Seven checked-arithmetic peers](#fwp-compared-with-c-and-rust) | Includes startup, algorithms, storage and output; not isolated compiler overhead |
| Where do the CPU benchmark gaps occur? | [Calculation, startup and output protocol](measurements/cpu-phases.md) | Diagnostic clocks change code; retain ordinary timings and do not infer a speedup from phase observations |
| What do numeric kernels cost? | [Current array and matrix comparison](measurements/current-kernel-costs.md) | Separates calculation from construction/cleanup; excludes process startup |
| What does differentiation add? | [Local derivative comparison](measurements/computed-numeric-time-2026-11-07/README.md) | Compare automatic and explicit fwp derivatives first; C/Rust use explicit formulas |
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

## Ownership comparison coverage

These comparisons belong to [the measurement plan](../PLAN.md). Keep measured
costs and limits separate from [the ownership rules](gc-removal-design.md).

| Workload | Verified evidence | Remaining limits |
|---|---|---|
| Numeric buffers | [Unique-buffer totals](measurements/unique-buffer-peers.md) and [returned-buffer phase timings](measurements/returned-buffer-time-2026-11-09/README.md), including Swift, storage release and RSS | Original misses and noisy controls remain visible. No unchanged retries for qualification. |
| Returned partial application | [Construction/call/release phases](measurements/callable-phases.md) and [actual scalar Swift allocations](measurements/swift-scalar-closures-2026-11-09/README.md) | Original ARM acceptance and AMD construction regressions remain open; allocation bytes are not ARC-operation counts. |
| Weak registration and queued service | [Lifetimes, reuse and storage](measurements/weak-operation-verification-2026-11-09/README.md), [isolated timings](measurements/weak-operation-time-2026-11-09/README.md) and [complete service costs](measurements/weak-callback-time-2026-11-09/README.md) | Substantial C/Rust/Swift service gaps need attribution. ARC-operation counts remain unmeasured. |
| Recursive parser workspace | [Earlier timings](measurements/parser-workspace.md), [C/Rust resize overlap](measurements/parser-native-allocator-2026-11-09/README.md), [fwp heap/region events](measurements/parser-heap-events-2026-11-09/README.md) and [actual process accounting](measurements/parser-process-accounting-2026-11-09/README.md) | [Mapped-resize and arena-retry controls pass](measurements/parser-allocator-paths-2026-11-09/README.md). Owned bytes, resident pages and accountable mappings are separate scopes; no whole-stack or universal allocator-internal peak bound. |

Measure construction, useful work and cleanup separately and together at small,
cache-sized and larger inputs. Match checked arithmetic and lifetime behavior;
report representation differences, compiler/flags/host, repeated elapsed times,
allocations, observed count/weak operations, peak live bytes, mapping extents and RSS,
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

## fwp compared with C and Rust

Each directory in [`bench/`](../bench) contains `main.fwp`, `main.c` and
`main.rs`. The programs must print the same result. The runner builds native
executables with `fwp build -O2`, the explicitly selected `CC -std=c11 -O2 -ffp-contract=off`,
and `rustc --edition=2021 -O`. Native fwp uses counted ownership; there is no
tracing mode.

`CC` must name the compiler and `FWP_LTO=0`
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
runner changes.

Do not infer an ARC speedup from different runs or hosts.
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
these exclude raw buffers, stack storage and allocator metadata.

Each instrumented
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

The [current kernel comparison](measurements/current-kernel-costs.md) covers
map/reduce at 65,537/262,145 elements and matrix products of 65×67 by 67×63 and
257×259 by 259×255. It compares current fwp, a same-source compiler using generic
value words for loop state, C and Rust. Calculation and allocation-inclusive
timing are separate; neither includes process startup. These peers are not BLAS.

The [paired-column experiment](measurements/matrix-calculation-costs.md#results-november-2-2026)
changes only the matrix loop: two neighboring outputs are calculated together
without rearranging either sum. Qualified cases use about one-third less time
than scalar fwp, with unchanged managed storage. Small AMD64 copy controls fail;
that case has no accepted speed claim. Its complete data remains in the report.

The [older baseline](measurements/kernel-baselines.md) predates typed loop state.
Its roughly 3.3-times-C AMD64 array result is **not current overhead**. Its failed
3.08% copy control remains part of that historical experiment. Current measurements
must retain their own controls and missed limits; representation alone establishes
no speedup.

The [historical derivative baseline](measurements/descent-costs.md) uses Rosenbrock
descent with 3, 33 and 129 coordinates. Automatic differentiation records arithmetic
and walks the record backwards; an explicit derivative calculates a formula
written by the programmer. Compare those two fwp forms before comparing them
with handwritten C/Rust. Inputs, complete outputs, update counts and memory
observations are retained. [Capture binding](measurements/eager-captures.md)
improves updated solves in its initial sessions, but a repaired-source zero-update
recheck exceeds its 2% regression limit. That original comparison remains unmet.

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
Process resident memory (RSS) includes more than managed values.

It can include
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
fwp images to exclude tracing scans.

The inspection does not execute downloaded
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
code; `run`/`run_url` identifies evidence.

Host entries contain the environment,
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

## Source array construction versus benchmark inputs

The [construction diagnostic](measurements/array-construction-costs.md#diagnostic-results-november-2-2026)
checks the boundary behind the current array timings. C-driver and source-built
materialized F64 arrays each make one workload allocation. In the fully composed
fwp program, existing fusion removes that array: both GCC architectures show zero
workload requests and retains at O1/O2. No elapsed-time claim follows from this
count result; the old materialized-input ratio does not measure composed source.

The [later phase baseline](measurements/array-construction-phases-2026-11-02/README.md)
measures materialized source at `f05e25f8`. In two qualified ARM64 sessions,
construction takes 7.16–7.48 times the fwp C driver and 10.78–10.95 times C.
Separate instrumented builds place over 99% of source construction in filling,
including callback dispatch and checked arithmetic. This is a filling/call cost
despite zero effective retains. Six AMD64 session-1 timing-copy limits fail;
keep those timings inconclusive.

The [direct-call comparison](measurements/scalar-array-captures-2026-11-02/README.md)
now passes both ARM64 sessions: construction takes 84.5–84.9% less time and total
work takes 81.2–81.6% less than the same compiler with scalar selection disabled.
Managed storage is unchanged. Candidate total time still takes 1.44–1.46 times C
and 1.87–1.90 times Rust. AMD64 retains four failed consumption-speed limits and
four failed copy controls; its combined goal remains open. The report includes
absolute times, exact workloads, memory/RSS, code and stack observations.
