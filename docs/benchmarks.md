# Benchmarks: what is compared, and what fwp costs

There is no single measured “fwp overhead.” The extra time or memory depends on
the program, the implementation used for comparison, compiler settings and the
machine. This page separates two different questions:

1. **How long do these fwp programs take compared with C and Rust programs?**
   The five examples in `bench/` answer this for complete executable runs.
2. **Does a particular fwp optimization reduce work or storage?** The reports
   under `docs/measurements/` usually compare two fwp implementations. Those
   fwp-only comparisons do not measure overhead relative to another language;
   the numerical reports that do include C/Rust are identified separately below.

The measurements below are dated observations. They do not promise the same
ratios on another machine or establish that the whole language is “zero-cost.”

## fwp compared with C and Rust

Each directory in [`bench/`](../bench) contains `main.fwp`, `main.c` and
`main.rs`. The programs must print the same result. The runner builds native
executables with `fwp build -O2`, `cc -O2` and `rustc -O`. After one warmup per
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
The fwp build uses its normal native memory mode, which includes a tracing
garbage collector; this is not a comparison of checked ARC against Rust.
ARC means automatic reference counting, which releases objects when their last
owning reference disappears.

The runner retains the measured executables and source inputs in
`target/bench-evidence`, grouped by source commit and invocation, with a copy of
each invocation's timing report. It separately
emits fwp's generated C after timing, using the same compiler and settings;
that extra emission is outside both execution and reported compilation times.
Both benchmark workflows upload this evidence. Earlier timing-only artifacts
cannot establish what their machine instructions looked like.

### What each program actually does

| Program | Input and work | Important differences between implementations |
|---|---|---|
| `fib` | Compute Fibonacci number 35 with recursive calls | Same recurrence. Compilers can transform calls differently. fwp checks integer overflow; these C and optimized Rust builds do not have the same overflow guarantees. These inputs fit all three. |
| `loop` | Update two integers for 100 million iterations | fwp expresses the loop state as a pair; its compiler can turn that into local variables. C and Rust write the loop directly. Checked arithmetic and generated code can still differ. |
| `map` | Build 500,000 key/value entries, then perform 2 million lookups | All three use contiguous sorted pairs searched by bisection. Sorting implementations and construction costs still differ. This compares complete implementations, not an isolated lookup operation. |
| `pipeline` | Multiply, select even values and sum one million inputs, 20 times | fwp can combine the stages into one traversal without intermediate lists. C explicitly fills arrays; Rust constructs vectors and filters them. Eliminating that work can outweigh language overhead. |
| `strings` | Format two numbers, combine their text and count characters, 2 million times | fwp can calculate some formatted lengths without creating the string. C uses `snprintf` and `strlen`; Rust uses `format!` and byte length. All characters here are ASCII, so the lengths agree. The programs need not perform the same formatting or allocation work. |

A result that is faster than C here does not mean fwp outperforms the best
hand-written C version. Likewise, a slower result does not identify how much
came from reference counting, collection, checks, allocation or the algorithm.
The timing runner does not measure those costs separately.

### Recorded example and overhead

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

The numerical runner hides C/Rust dimensions from compile-time constant
propagation, matching the dimensions fwp reads from array and matrix metadata.
The C output buffer is explicitly disjoint from the input buffers, as in the
generated fwp kernel and Rust's mutable output slice. Each uninstrumented binary
has one warmup process. The current script then rotates C, Rust, tracing fwp and
checked ARC fwp through eight process batches of five samples each. Each
implementation occupies each position twice. Reports retain all forty samples,
batch order and process memory measurements. Both fwp modes are emitted by the
same compiler; the matrix's declared dimensions match the buffers being timed.
Allocation profiles use separate instrumented binaries and are not used for
timing claims. The four-host comparison at `49d35018` passed with this method.
Earlier reports have thirty or fewer samples and only tracing fwp; their
measurements have not been relabeled as new results.

A C harness constructs fwp inputs through its runtime allocation and array-store
helpers, then calls the compiled fwp function directly. The allocation-inclusive
interval includes that harness's construction and cleanup costs; it is not a
complete fwp application's startup time. The kernel interval isolates the scopes
described below. This distinction matters when a kernel approaches C speed but
its surrounding input construction still takes longer.

The [2026-10-12 ownership/numerical report](measurements/ownership-and-arc-2026-10-12.json)
contains a more controlled comparison than the five complete programs above.
These are historical measurements at the source revisions in that report, not
fresh timings of today's compiler. The array workload has 65,537 elements; the
matrix product is 65×67 by 67×63. Each sample runs eight rounds and the table
uses the median (middle value after sorting) of five samples. C/fwp use O2 with floating contraction disabled;
Rust uses optimization level 2. The report records exact commands, CPU models,
compiler versions and source hashes for each host.

**Construction and cleanup included:** the elapsed interval covers allocation,
input filling, computation and release. Ratios compare those complete intervals,
not just arithmetic. Times below are milliseconds for the measured eight rounds.

| Host / workload | C | Rust | fwp | fwp versus C | fwp versus Rust |
|---|---:|---:|---:|---:|---:|
| Linux AMD64 / array | 0.813 | 0.865 | 1.724 | 2.12× (+112%) | 1.99× (+99%) |
| Linux AMD64 / matrix | 0.719 | 0.922 | 0.763 | 1.06× (+6%) | 0.83× (-17%) |
| macOS AMD64 / array | 2.308 | 1.413 | 2.749 | 1.19× (+19%) | 1.95× (+95%) |
| macOS AMD64 / matrix | 1.894 | 1.051 | 5.637 | 2.98× (+198%) | 5.37× (+437%) |
| macOS ARM64 / array | 0.779 | 0.765 | 1.767 | 2.27× (+127%) | 2.31× (+131%) |
| macOS ARM64 / matrix | 0.640 | 0.773 | 1.080 | 1.69× (+69%) | 1.40× (+40%) |

**Calculation-focused intervals:** array timing starts with an existing input and
includes its consumed-owner release; matrix timing starts after allocating and
zeroing the output. These scopes differ, so do not compare array and matrix ratios
as if they measured the same overhead.

| Host / workload | fwp versus C | fwp versus Rust |
|---|---:|---:|
| Linux AMD64 / array | 2.66× (+166%) | 2.60× (+160%) |
| Linux AMD64 / matrix | 1.01× (+1%) | 0.75× (-25%) |
| macOS AMD64 / array | 1.49× (+49%) | 2.21× (+121%) |
| macOS AMD64 / matrix | 3.24× (+224%) | 5.82× (+482%) |
| macOS ARM64 / array | 1.67× (+67%) | 1.69× (+69%) |
| macOS ARM64 / matrix | 1.70× (+70%) | 1.30× (+30%) |

For example, the Linux array calculation took 2.66× the C time, or about 166%
longer, while its construction-inclusive ratio was 2.12×. The macOS Intel matrix
case has a much larger gap than the Linux case. These results rule out a general
C-parity claim. They do not isolate one cause: generated instructions, checks,
ownership, allocation and host/toolchain differences all matter. Later allocation
improvements do not retroactively change these recorded timings.

The paired profiling runs record actual allocations and peak storage separately
from timing; zero counters in uninstrumented timing samples mean counting was
disabled, not that those programs allocated nothing. The two public matrix wrapper
records remain a documented fwp representation cost. Read the metric definitions
below before comparing C/Rust payload bytes with fwp charged storage or process RSS.

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

The [current comparison](measurements/service-context-iteration-2026-10-16.json)
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

### Current numerical comparison and record moves

[The record-move report](measurements/numerical-record-moves-2026-10-16.json)
retains current fwp/C/Rust results at `a3d8f16e` on Linux/macOS ARM64/AMD64,
plus a separate experiment that restores the removed ownership operations.
All four hosts pass both the [numerical run](https://github.com/e6qu/fun-with-pipes/actions/runs/38817877068)
and [paired experiment](https://github.com/e6qu/fun-with-pipes/actions/runs/38821156704).
These component measurements precede the combined delivery's final acceptance.
Processors, compilers, flags, build commands, source hashes, raw samples and
allocation profiles are retained. Checked ARC binaries exclude tracing symbols.

The array workload reduces 65,537 elements eight times. Its kernel time includes
consuming and releasing the input, but excludes input allocation and filling.
The matrix workload multiplies 65×67 by 67×63 matrices eight times using tiles
of width 32. Its kernel timer starts after output allocation and zeroing and
covers only multiplication and accumulation. Allocation-inclusive time includes
input construction, computation and cleanup. C, Rust and fwp use the same inputs,
ordered arithmetic and algorithms; multiply and add remain separate operations.
Forty uninstrumented samples per implementation come from eight rotating process
batches after warmup. Separate binaries collect allocation counts and memory;
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
| [Memory and checked ARC](measurements/ownership-and-arc-2026-10-12.json) | Later fwp/C/Rust array/matrix timings plus fwp reference-counting eligibility and reclamation checks | The cross-language ratios above and scoped lifetime proof; not a universal collector-free mode |
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

[The current four-host report](measurements/ad-metadata-repeat-2026-10-16.json)
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

Full benchmarks run on GitHub runners. The C/Rust comparison command is:

```sh
cargo test --release --test bench benchmarks -- --ignored --exact --nocapture
```

It writes the report to standard output, `target/bench.md` and the `bench` job
summary. The per-change experiments have their own scripts and explicit controls:

| Comparison | Runner command |
|---|---|
| Iterator processing | `python3 scripts/measure-iteration.py --help` lists the supported controls |
| Table growth | `python3 scripts/measure-ad-registry.py --comparison growth --output OUTPUT` |
| Table search | `python3 scripts/measure-ad-registry.py --comparison search --output OUTPUT` |
| Paired buffers | `python3 scripts/measure-ad-metadata.py --output OUTPUT` |

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

`map f | array.from-list` first applies `f` to each list element, then creates an
array from those results. When the results are inline numbers, the candidate
compiler can store them in temporary numeric storage and pack the array directly.
It preserves callback order and runs every callback before allocating the array.
This avoids allocating a list node for each result. Known callbacks still compile
to direct calls; choosing a function at runtime still requires an indirect call.

The [four-host report](measurements/mapped-arrays-2026-10-16.json) compares the same
compiler, program, inputs and native settings with this transformation disabled
and enabled. Both sides are fwp; these results do not measure overhead against C
or Rust. Native compilation uses `-O2 -ffp-contract=off`, other array optimizations
and derivative workspace reuse stay enabled. One warmup precedes eight samples
with alternating run order. Timing includes process startup, input construction,
calculation and output. Compilation and allocation profiling are separate.
Hardware, compiler commands, binary sizes, source/binary hashes and every sample
are in the report.

Three workloads check different uses:

- Direct numeric work doubles 4,096 F64 list elements, constructs an array and
  sums it, repeating 128 times. The printed total is 2,146,959,360.
- Repeated differentiation computes 512 reverse derivatives of a function that
  doubles 4,096 inputs. The printed total is 4,194,304.
- Nested differentiation squares the first value of a 256-element input, then
  differentiates twice and sums the result. It prints 2 and provides a control
  with little eligible work.

The following ratios are enabled time divided by disabled time for the revision
that preserves known direct callbacks. A ratio of 0.5 means half the elapsed
time; a ratio above 1 means slower. Tracing is the normal collector mode; ARC
uses checked reference counting without tracing.

| Host | Direct tracing / ARC | Derivative tracing / ARC | Nested tracing / ARC |
|---|---:|---:|---:|
| Linux AMD64 | 0.535 / 0.519 | 0.927 / 0.923 | 0.983 / 0.993 |
| Linux ARM64 | 0.473 / 0.498 | 0.934 / 0.889 | 0.965 / 0.913 |
| macOS ARM64 | 0.533 / 0.542 | 0.974 / 0.943 | 1.010 / 1.008 |
| macOS AMD64 | 0.514 / 0.276 | 1.070 / 0.918 | 0.906 / 0.966 |

An independent repeat uses the same generated sources and records the same
allocation counts on every host:

| Host | Direct tracing / ARC | Derivative tracing / ARC | Nested tracing / ARC |
|---|---:|---:|---:|
| Linux AMD64 | 0.492 / 0.517 | 0.918 / 0.919 | 0.887 / 1.001 |
| Linux ARM64 | 0.470 / 0.496 | 0.892 / 0.919 | 0.967 / 0.918 |
| macOS ARM64 | 0.581 / 0.533 | 0.983 / 0.909 | 0.896 / 1.003 |
| macOS AMD64 | 0.476 / 0.471 | 1.019 / 0.895 | 0.986 / 1.124 |

Intel macOS has large timing variation in the first run: disabled direct ARC
samples range from 30 to 117 ms, while enabled samples range from 14 to 18 ms.
The repeat narrows these to 29–30 and 14 ms. Its traced derivative median is
still 2% slower, compared with 7% in the first run; both runs have overlapping
samples. The tiny nested case changes from 3% faster to 12% slower in ARC.
A [separate four-host diagnostic](measurements/mapped-array-cpu-2026-10-16.json)
reuses those verified binaries, with one warmup and 16 alternating samples. It
measures both elapsed time and child CPU time (user plus system processing time),
which helps distinguish computation from time spent waiting to run. Profiles are
separate rebuilt binaries, with the normal collector and with collection disabled.
Both profiles match the earlier allocation counts exactly; all hosts report zero
collections and zero final managed/tape storage. Collection activity therefore
does not explain the earlier Intel result.

For repeated differentiation, the diagnostic reports:

| Host | Tracing elapsed / CPU ratio | ARC elapsed / CPU ratio |
|---|---:|---:|
| Linux AMD64 | 0.925 / 0.925 | 0.925 / 0.925 |
| Linux ARM64 | 0.919 / 0.919 | 0.927 / 0.927 |
| macOS ARM64 | 0.898 / 0.904 | 0.873 / 0.881 |
| macOS AMD64 | 0.913 / 0.917 | 0.944 / 0.951 |

The Intel traced slowdown does not repeat with these same binaries. Direct
numeric CPU ratios range from 0.433 to 0.497 across the hosts and memory modes.
Tiny nested results remain mixed, including 6.8%/8.9% more CPU time in tracing/ARC
on ARM macOS. This supports adopting the transformation for its measured
allocation savings and substantial-work improvements; it does not prove every
small call is faster. Keep the earlier slower samples in the record.

The report also retains the first implementation, which used indirect callback
calls. Compare enabled/disabled within each revision; do not pool measurements
from different revisions. Across both final-code runs, ARC direct numeric work
improves and ARC repeated differentiation uses 6–11% less elapsed time. That is
specific to these inputs and hosts, not a general language-speed claim.

Allocation profiles agree across all four hosts and both memory modes:

| Workload | Managed requests, disabled → enabled | Retains, both | Peak charged bytes, disabled → enabled |
|---|---:|---:|---:|
| Direct numeric | 532,996 → 8,708 | 256 | 300,312 → 294,920 |
| Repeated derivative | 25,184,777 → 23,087,625 | 10,492,416 | 840,888 → 840,888 |
| Nested derivative | 4,415 → 4,414 | 2,109 | 60,096 → 60,096 |

Managed requests count runtime objects, not necessarily system malloc calls.
Initial constants are excluded. Profiles disable collection to check cleanup;
final charged memory, tape storage and collections are zero. The traced timings
use the normal collector. Fewer requests do not establish lower derivative peak
memory or less reference-count traffic: neither changes here.

Actual ARM64 and AMD64 disassembly retains vectorized floating-point doubling in
the known-callback loop (`fadd.2d` and `addpd`, respectively). Selected function
bodies and stack-address instructions are retained. Those counts exclude callees,
and the initial implementation moved work into another function, so they are not
total instruction counts or proof of fewer spills. Remaining array reductions
can still use indirect calls. Full semantic/platform acceptance is recorded in
the handoff, separately from these measurements.

## Mapping numeric pairs without building a temporary zip

`xs | zip ys | map f` pairs corresponding elements, stops at the shorter list and
applies `f` to each pair. For known callbacks and inline numeric inputs, the
compiler can pass both numbers directly without constructing the intermediate
pairs and list. Returned values still need their ordinary storage. Existing
fold/array consumers get their own optimization first.

[The four-host comparison](measurements/zip-maps-2026-10-16.json) uses the same fwp
compiler, source, inputs and memory mode with `FWP_ZIP_MAP=0` and `1`. Other array
fusion and derivative workspace reuse stay enabled. These are two fwp variants,
not comparisons against C or Rust. Native compilation uses `-O2 -ffp-contract=off`.
One warmup precedes eight alternating whole-process samples, including startup,
input construction, calculation and output. Compilation and allocation profiles
are measured separately; the report retains hardware, commands, hashes and sizes.

Direct work forms 128 lists of 4,096 products `x * (x + 1)`, retaining the result
lists before summing them. Repeated differentiation computes 512 reverse
derivatives over 4,096 inputs. A nested control differentiates a first-element
square twice over 256 inputs; it has much less eligible work.

Ratios below are enabled elapsed time divided by disabled time. Below 1 is
faster; above 1 is slower. Tracing uses its normal collector; checked ARC has no
tracing collector.

| Host | Direct tracing / ARC | Derivative tracing / ARC | Nested tracing / ARC |
|---|---:|---:|---:|
| Linux AMD64 | 0.616 / 0.605 | 0.828 / 0.825 | 1.033 / 0.951 |
| Linux ARM64 | 0.632 / 0.595 | 0.791 / 0.769 | 0.990 / 0.999 |
| macOS ARM64 | 0.733 / 0.621 | 0.710 / 0.793 | 1.045 / 1.030 |
| macOS AMD64 | 0.624 / 0.569 | 0.784 / 0.741 | 0.956 / 1.012 |

All four hosts and both modes agree on the allocation profiles:

| Workload | Managed requests, disabled → enabled | Retains, disabled → enabled | Peak charged bytes, disabled → enabled |
|---|---:|---:|---:|
| Direct products | 2,106,373 → 1,057,669 | 524,672 → 384 | 17,208,584 → 17,077,512 |
| Repeated derivative | 23,087,625 → 18,892,809 | 10,492,416 → 8,395,264 | 840,888 → 840,888 |
| Nested derivative | 4,414 → 3,901 | 2,109 → 1,853 | 60,096 → 60,096 |

Requests count managed objects, not necessarily system allocations. Profiles
exclude initial constants and disable collection to verify counted cleanup;
final charged memory and derivative tape storage are zero. Fewer requests do
not reduce derivative peak memory here. Tiny nested timings remain mixed.

Actual Linux ARM64 disassembly contains vector `fmul` inside the direct product
loop. Linux AMD64 uses unrolled scalar `mulsd`. Known callbacks inline into that
loop. The report retains selected generated and machine-code bodies; these are
not total dynamic instruction counts or evidence about register spills. Full platform acceptance is recorded in
[history](roadmap-history.md).

[A separate repeat](measurements/zip-map-cpu-2026-10-16.json) reuses the verified
binaries, taking sixteen alternating samples of elapsed and child CPU time
(user plus system CPU). It rebuilds allocation profiles separately with the
normal collector and collection disabled. The normal traced direct workload
collects twice in both variants on every host; other profiles collect zero times.
All allocation, retain, peak and final-storage measurements match the original
profiles. The repeated CPU ratios are:

| Host | Direct tracing / ARC | Derivative tracing / ARC | Nested tracing / ARC |
|---|---:|---:|---:|
| Linux AMD64 | 0.631 / 0.616 | 0.822 / 0.817 | 0.960 / 1.001 |
| Linux ARM64 | 0.628 / 0.596 | 0.799 / 0.789 | 0.985 / 0.978 |
| macOS ARM64 | 0.655 / 0.591 | 0.804 / 0.813 | 0.989 / 1.017 |
| macOS AMD64 | 0.544 / 0.519 | 0.810 / 0.788 | 0.987 / 0.944 |

The macOS ARM64 nested ARC case remains slightly slower: median CPU increases
from 1.5805 to 1.6075 ms, and elapsed time from 2.2604 to 2.3205 ms. CPU samples
overlap (disabled 1.456–2.220 ms, enabled 1.463–2.322 ms). This test has little
eligible work, and the repeat does not establish a benefit there. Adoption rests
on substantial direct/derivative workloads and reduced ownership traffic; it
does not promise a speedup for every program.

## Hashing values without constructing their encoded bytes

`hash` computes a deterministic U64 fingerprint from a value's typed binary
encoding. FNV-1a combines each byte with XOR and multiplication modulo 2^64;
it is not a cryptographic hash. The native implementation feeds those bytes directly into
the running fingerprint instead of allocating a complete encoded byte buffer.
The interpreter keeps its independent buffered implementation as a reference.

[The four-host comparison](measurements/structural-hash-2026-10-16.json) measures
fwp tracing, checked ARC, ARC with only the old hash buffer restored, and direct
C and Rust implementations. Each builds one array containing integers 0 through
N-1, hashes `(iteration, array)` repeatedly, then XORs the fingerprints. Including
the changing iteration prevents reuse of a single hash. Small work hashes 16
integers 4,096 times; large work hashes 4,096 integers 1,024 times. All encode the
same little-endian I64 fields and array length, using identical wrapping hash
arithmetic. C/Rust know that schema directly; fwp uses ordinary pipes and runtime
type descriptions. Their outputs agree with raw interpretation.

All use optimization level 2. After one warmup, ten rotating whole-process
samples include startup, input construction, hashing and printing. Compilation,
allocation profiles and uninstrumented process peak memory are recorded separately.
CPU time means child user plus system time; elapsed time also includes scheduling.
The report retains both, hardware, compiler versions, flags, hashes and all samples.
These are small process measurements on shared runners, not universal speed claims.

The table reports checked ARC CPU time divided by each reference's CPU time.
A ratio of 1.67 means 67% extra CPU time. Below 1 means less time. The last two
columns compare the same fwp program with its former encoded-byte buffer.

| Host | Small / C | Small / Rust | Large / C | Large / Rust | Small / buffered fwp | Large / buffered fwp |
|---|---:|---:|---:|---:|---:|---:|
| Linux AMD64 | 1.670 | 1.542 | 1.044 | 1.044 | 0.318 | 0.165 |
| Linux ARM64 | 1.824 | 1.660 | 1.033 | 1.029 | 0.350 | 0.160 |
| macOS ARM64 | 1.435 | 1.236 | 1.016 | 1.012 | 0.553 | 0.285 |
| macOS AMD64 | 1.475 | 1.328 | 1.018 | 1.012 | 0.374 | 0.079 |

On every host, streaming removes all allocation requests inside the hash itself.
The old buffer makes 12,288 growth requests for small work and 11,264 for large
work, requesting 1,835,008 and 134,152,192 bytes cumulatively. Peak temporary
capacity falls from 256 / 65,536 bytes to zero. Cumulative requested capacity is
not simultaneously live memory or allocator-internal storage.

Before callback fusion, the full fwp programs make 12,309 / 7,173 managed requests and 12,288 / 3,072
retains, with 295,112 / 163,848 peak charged bytes. These numbers are unchanged
by streaming: input construction, tuple/list intermediates and output remain.
C/Rust use one application array allocation of 128 / 32,768 bytes. C counts its
explicit successful malloc; Rust measures allocator calls while that array lives.
Those counts exclude stdio and allocator internals; fwp managed counters can
include output values. All measured owned storage returns to zero. The profile
disables collection to check cleanup; ordinary traced timing keeps it enabled.

[Retained machine-code evidence](measurements/structural-hash-code-2026-10-16.json)
identifies binaries, C source, disassembly and WASI modules by SHA-256. The selected
Linux ARM64 hash visitor has a 96-byte stack frame and XOR/multiply instructions;
its six calls recurse into the visitor, with no encoder or allocator call.
This is one static function body, not proof of no spills or zero runtime overhead.
The small-work gap points toward remaining pipeline storage and dispatch costs;
the large-work CPU gap is about 1–4% on these hosts. Full delivery acceptance is
tracked in the handoff separately from these focused measurements.

### Keeping captured computations outside a fused hash loop

The compiler recognizes hash and bitwise reduction as total operations:
valid inputs produce results without language traps or callbacks. It computes the
known callback's captured array once, before input evaluation, then combines the
map and fold into one loop. Effects and distinguishable traps still prevent
interleaving. This uses existing syntax and preserves eager capture timing.

[The post-fusion report](measurements/hash-pipelines-2026-10-16.json) repeats the
same two programs, compiler settings and C/Rust work described above. All four
hosts agree on these ownership measurements in tracing and ARC modes:

| Workload | Managed requests, before → after | Retains, before → after | Peak charged bytes, before → after |
|---|---:|---:|---:|
| Small array | 12,309 → 4,114 | 12,288 → 4,096 | 295,112 → 656 |
| Large array | 7,173 → 5,122 | 3,072 → 1,024 | 163,848 → 163,848 |

Final charged storage is zero. Allocation profiles run separately with collection
disabled. At that measured revision, generated C still allocates a tuple per hash and retains its captured
array field; input `range | array.from-list` also builds list nodes. Hash itself
allocates nothing. A borrowed argument is not automatically nonescaping: its
contract must separately prove that it cannot be retained before stack placement
is safe. The following experiments address those measured costs.

The following CPU ratios compare checked ARC against references measured beside
it in this post-fusion run. They do not compare absolute times from different
runners. The paired repeat below compares both compiler revisions on each host.

| Host | Small / C | Small / Rust | Large / C | Large / Rust |
|---|---:|---:|---:|---:|
| Linux AMD64 | 1.427 | 1.238 | 1.021 | 1.020 |
| Linux ARM64 | 1.476 | 1.322 | 1.033 | 1.031 |
| macOS ARM64 | 1.218 | 1.150 | 0.998 | 1.029 |
| macOS AMD64 | 1.231 | 1.149 | 1.023 | 1.019 |

For example, small Linux ARM64 work takes about 48% extra CPU against C and 32%
against Rust. Large results are close to the references in these samples, but a
ratio near 1 is not a universal parity claim. Process startup, input construction
and printing are included, and measured absolute times vary between runner
invocations. The original reports retain all samples, hashes, build cost and
memory scopes so those limitations remain visible.

### Repeating both hash pipeline revisions together

[The paired report](measurements/hash-pipeline-cpu-2026-10-16.json) runs the
verified before/after binaries together with the same C/Rust references on each
host. Twelve samples balance execution position and forward/reverse ordering.
Times include process startup, input construction and printing; compilation and
allocation profiles run separately. Source, binary and assembly hashes must
match the original reports, and separate profiles must reproduce their counts.

Each entry below is after / before. Below 1 means less time; above 1 means more.
CPU time counts the child process's work; elapsed time also includes waiting.

| Host | Small ARC CPU / elapsed | Large ARC CPU / elapsed | Large tracing CPU / elapsed |
|---|---:|---:|---:|
| Linux AMD64 | 0.902 / 1.077 | 0.995 / 0.998 | 0.996 / 0.996 |
| Linux ARM64 | 0.759 / 0.788 | 1.002 / 1.002 | 0.998 / 0.999 |
| macOS ARM64 | 0.807 / 0.838 | 0.995 / 1.002 | 1.019 / 1.021 |
| macOS AMD64 | 0.811 / 0.895 | 0.999 / 0.999 | 1.028 / 1.023 |

Small ARC CPU time falls on every host, but Linux AMD64 elapsed time rises from
2.325 to 2.505 ms while CPU time falls from 2.017 to 1.818 ms. This is a real
observed elapsed-time regression, not evidence of a CPU regression. Large traced
macOS medians also rise. Their CPU sample ranges overlap: ARM64 before/after
50.510–65.098 / 56.172–64.862 ms, AMD64 74.629–177.625 / 78.872–199.014 ms.
These samples do not establish a repeatable large-input improvement or regression;
retain them when assessing subsequent changes instead of discarding slow runs.

The same repeat puts small ARC CPU overhead against C at 87%, 48%, 10% and 29%
on Linux AMD64, Linux ARM64, macOS ARM64 and macOS AMD64 respectively. Against
Rust the corresponding ratios are 1.708, 1.303, 0.956 and 1.170. Large ARC / C
ratios are 1.014, 1.036, 1.031 and 1.327; ARC / Rust ratios are 1.026, 1.032,
0.999 and 1.404. The Intel Mac gap is substantially wider than the first run's
near-parity result. Hardware and timing variability are retained in the report;
neither run justifies a general claim of parity. The following experiments address tuple allocations, array retains and input
list construction while retaining these earlier samples for comparison.

### Intermediate stack placement experiment

[The partial stack report](measurements/hash-stack-intermediate-2026-10-16.json)
isolates the new nonescape proof for hash before direct range-array construction.
ARM64 Linux and macOS completed; the remaining queued jobs were canceled when the
combined experiment superseded this revision. This is not four-host acceptance.
Both completed hosts reduce small managed requests from 4,114 to 18 and large
requests from 5,122 to 4,098. Retains remain 4,096 / 1,024 and peak charged storage
remains 656 / 163,848 bytes; final charged storage is zero. The array input still
needs temporary range list nodes in this intermediate revision.

The retained ARM64 code writes the tuple into stack slots, while the hot loop
still increments the array reference count and calls its typed release. The
main-thread stack frame is 304 bytes, including initialization and cleanup; this
does not measure dynamic register spills. Raw C/Rust timings remain in the partial
report, including slower large macOS samples. Compare the combined revision on
all four hosts and repeat verified binaries together before claiming a speedup.

[The direct-range report](measurements/hash-range-arrays-2026-10-16.json) then
adds packed integer array construction without temporary range list nodes. All
four hosts agree on two managed allocation requests for both workloads: array
storage and the printed result. Small requested/peak bytes are 165 / 144; large
requested/peak bytes are 32,805 / 32,776. Final charged storage is zero. The
references count their single application array allocation; their allocator and
printing scopes still differ as described above. This is not a claim of only two
allocations in the whole operating-system process.

Array retains remain 4,096 / 1,024 at this revision. Small ARC / C CPU ratios are
1.387, 1.405, 1.192 and 1.210 on Linux AMD64/ARM64 and macOS ARM64/AMD64; ARC / Rust
ratios are 1.296, 1.247, 1.097 and 1.071. Large ARC / C ratios are
1.027, 1.027, 1.038 and 1.009; ARC / Rust ratios are 1.026, 1.025, 1.029 and 0.964.
These are simultaneous comparisons within this run, not before/after speedup
claims across different runner invocations. The following field-borrowing work
targets those remaining counts and requires its own semantic and timing evidence.

### Borrowing temporary fields without counting them

[The four-host borrowed-field report](measurements/hash-borrowed-fields-2026-10-16.json)
combines stack tuples, direct range arrays and field borrowing. A borrow uses the
array while its existing owner keeps it alive, so building a temporary hash tuple
needs no additional reference. It preserves the same values and hash bytes as the
programs above. Every host reports these counts in tracing and checked ARC modes:

| Workload | Managed requests, post-fusion → current | Retains, post-fusion → current | Peak charged bytes, post-fusion → current |
|---|---:|---:|---:|
| Small array | 4,114 → 2 | 4,096 → 0 | 656 → 144 |
| Large array | 5,122 → 2 | 1,024 → 0 | 163,848 → 32,776 |

The two requests hold the input array and printed result; final charged storage
is zero. The hash loop allocates no managed objects and performs no reference
increments. These claims apply to these programs, not every fwp program or every
system allocation. C/Rust still count only their one application array allocation.

The retained ARM64 loop stores the tuple in stack slots and calls the hash visitor.
The array pointer, iteration and XOR accumulator occupy registers across that
call. The loop has no allocation or retain/release call. The recursive hash
visitor still uses runtime type descriptions and its own stack; this excerpt
is not a measurement of dynamic register spills or cache misses.

CPU ratios against references measured in this run are:

| Host | Small / C | Small / Rust | Large / C | Large / Rust |
|---|---:|---:|---:|---:|
| Linux AMD64 | 1.295 | 1.083 | 1.027 | 1.026 |
| Linux ARM64 | 1.341 | 1.193 | 1.028 | 1.024 |
| macOS ARM64 | 1.207 | 0.997 | 1.099 | 1.087 |
| macOS AMD64 | 1.192 | 1.046 | 1.220 | 1.230 |

For example, small Linux ARM64 work still uses about 34% extra CPU time against
C and 19% against Rust. Large macOS gaps are wider than in the direct-range run:
about 10% against C on ARM64 and 22% on AMD64. These separate runner invocations
do not isolate the compiler change's timing effect. The paired comparisons below investigate that difference; lower counts alone
cannot justify a speedup or parity claim.

### Repeating the allocation and borrowing changes together

[Two paired runs](measurements/hash-borrowed-cpu-2026-10-16.json) execute the same
verified post-fusion baseline and current binaries beside C/Rust. Each run uses
twelve balanced rotating whole-process samples, with separate normal/off
collection profiles. Every current profile reproduces two requests, zero retains
and zero final charged storage. Both runs retain all raw timing samples.

Each entry below gives first-run / second-run CPU ratios of current to baseline.
Below 1 means less CPU time; above 1 means more. These compare the complete batch,
not the isolated contribution of any one transformation.

| Host | Small ARC | Large ARC | Small tracing | Large tracing |
|---|---:|---:|---:|---:|
| Linux AMD64 | 0.909 / 0.910 | 0.989 / 0.996 | 0.909 / 0.988 | 0.995 / 0.993 |
| Linux ARM64 | 0.934 / 0.919 | 0.992 / 0.993 | 0.921 / 0.912 | 0.995 / 0.994 |
| macOS ARM64 | 1.032 / 0.918 | 0.983 / 1.000 | 0.926 / 0.905 | 0.966 / 0.989 |
| macOS AMD64 | 0.935 / 0.967 | 1.008 / 0.997 | 0.991 / 0.946 | 0.993 / 1.065 |

The first small ARM macOS ARC median rises from 3.496 to 3.609 ms CPU and 5.398 to
5.620 ms elapsed. Its CPU ranges overlap: 2.870–5.811 ms before and 2.854–5.987 ms
after. The repeat reverses that result: 2.168 to 1.991 ms CPU and an elapsed ratio
of 0.949. The first large Intel macOS ARC CPU/elapsed ratios of 1.008/1.013 become
0.997/0.971 in the repeat. These observations do not establish repeatable macOS
regressions, but neither do they promise that every program becomes faster.
Large-input changes are generally small; small Linux and Intel macOS CPU medians
fall in both runs. The array and tuple storage reduction is reproducible.

Remaining current ARC/C and ARC/Rust CPU ratios in the second run are:

| Host | Small / C | Small / Rust | Large / C | Large / Rust |
|---|---:|---:|---:|---:|
| Linux AMD64 | 1.381 | 1.178 | 1.020 | 1.015 |
| Linux ARM64 | 1.373 | 1.237 | 1.028 | 1.024 |
| macOS ARM64 | 1.144 | 0.979 | 1.043 | 1.050 |
| macOS AMD64 | 1.216 | 1.097 | 1.059 | 1.022 |

Startup, input construction, printing and generic hash traversal remain part of
fwp's measured cost. The compiler has removed the targeted intermediate objects
and count traffic, not every difference from handwritten code. Hardware, compiler
flags, binary sizes, profiles and raw samples remain in the linked reports.

## CPU tensor output storage

A CPU tensor kernel evaluates a description of arithmetic over arrays. The
[owned-value and kernel report](measurements/owned-values-and-kernels-2026-10-16.json)
compares the previous fwp executor with the prepared executor that writes directly
into its result array. Both process 8193 F64 (64-bit floating-point) values equal to their indices,
multiply each by 0.5, and check the complete output and ordered sum. Inputs already
exist when counting starts. This is a comparison between two fwp runtime
implementations; it measures allocation and cleanup, not time or overhead against
C/Rust. Only the executor is replaced in the baseline probe, not the whole compiler.

The probe counts the executor's directly allocated temporary buffers as native
storage. It counts the result array, allocated through fwp's value allocator, as
managed storage. For one worker, all six native OS/architecture targets report:

| Elementwise output cost | Previous executor | Prepared executor |
|---|---:|---:|
| Temporary native allocation requests | 3 | 2 |
| Peak temporary native bytes | 69,648 | 4,104 |
| Managed result-array requests | 1 | 1 |
| Native storage remaining after the call | 0 | 0 |

The change removes one 65,544-byte temporary output and its full copy. The result
array remains, along with an input-pointer table and arithmetic workspace. The
native-byte counter excludes managed objects, allocator metadata, thread stacks
and resident process memory. Four-worker observations vary with how many workers
overlap; separate peaks must not be added as if they occurred simultaneously.
Reductions still allocate block sums and preserve their addition order.

The retained reference-counted (ARC) probe binaries use packed double multiplication on ARM64 and
AMD64, but still load/store arithmetic workspace and copy each completed chunk.
That is evidence of vector instructions, not register-only execution or C/Rust
parity. The report retains C, binary and disassembly hashes, failure controls and
the separate Windows library-test repair. [PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
records the passing combined production delivery.

## Fixed-size lane calculations against C and Rust

A lane is one position in `Vec[N, F64]`; the introductory
[lane example](../examples/vector-lanes.fwp) explains construction and optional
length checks. [The owned-vector baseline report](measurements/vector-lanes-2026-10-16.json)
measures repeated dot products: fill every lane with the iteration index, multiply
each by 0.5, sum lanes left to right, then sum iteration results. Four-lane work
uses 32,768 iterations; sixty-four-lane work uses 8,192. Every value is exactly
representable for these inputs, and outputs match raw interpretation.

The C/Rust sources express the same arithmetic with fixed stack arrays and weights
constructed once. Their compilers may eliminate those arrays. At baseline revision `6be8f245`, fwp makes
three vectors per iteration and materializes input and result lists. The comparison
measures that abstraction cost; it does not pretend both programs allocate the
same structures. fwp also checks optional final integer conversion; the reference
casts are valid for these inputs but do not implement general optional conversion.

All builds use optimization level 2, without fast math or multiply-add contraction.
One warmup/process-memory sample precedes sixteen balanced rotating wall/child-CPU
samples. Timing includes startup, construction, arithmetic, conversion and printing.
Compilation and allocation profiles are separate. Both normal and disabled tracing
profiles have zero collections here; the reported costs are not collection pauses.
The report retains hardware, versions, flags, raw samples, build costs, binary sizes,
peak process memory and verified source/binary/assembly identities.

The table gives baseline checked ARC CPU time divided by the reference's CPU time.
For example, 11.200 means 11.2 times the C time, or about 1,020% extra CPU time.

| Host | Four lanes / C | Four lanes / Rust | Sixty-four lanes / C | Sixty-four lanes / Rust |
|---|---:|---:|---:|---:|
| Linux AMD64 | 10.863 | 8.812 | 3.280 | 3.252 |
| Linux ARM64 | 11.200 | 9.187 | 3.647 | 3.898 |
| macOS ARM64 | 2.921 | 2.554 | 2.223 | 1.749 |
| macOS AMD64 | 4.500 | 3.959 | 2.056 | 1.844 |

At that baseline, every host and fwp mode agrees on the ownership profiles:

| Workload | Managed requests | Cumulative requested bytes | Peak charged bytes | Retains / final charged bytes |
|---|---:|---:|---:|---:|
| Four lanes | 262,147 | 7,340,080 | 2,359,304 | 0 / 0 |
| Sixty-four lanes | 65,539 | 13,631,536 | 589,832 | 0 / 0 |

These are managed requests, not necessarily OS allocations. C has no explicit
application heap allocation; Rust's allocator counter observes zero calls during
calculation. Those reference scopes exclude startup and printing internals. Their
three declared arrays occupy 96 or 1,536 source-level bytes, but that is not a
measured stack-frame size: optimization can remove them.

Baseline generated fwp C calls splat twice and multiplication once for each mapped input,
then releases all three vectors. The retained Linux ARM64 multiply loop uses
scalar F64 multiplication and handles array representation in the loop; the C
reference keeps calculations in registers and contains vector `fmul`/`fadd`
instructions. No dynamic spill/cache claim follows from those excerpts. These were the measured costs targeted by the following changes; they are not
a description of the final scalar-splat implementation. General zero-cost lane
abstraction and C/Rust parity remain unfinished.

The [intermediate direct-dot report](measurements/vector-direct-intermediate-2026-10-16.json)
retains all four hosts at `3577ba37`, after list fusion, direct F64 storage access
and removal of the product vector. Requests are 131,074 / 32,770, peak charged
storage is 128 / 1,312 bytes, and retains/final charged storage are zero for
four/sixty-four lanes. Two splat arrays and wrappers still account for four
requests per iteration. The code excerpts show the direct range loop and these
two calls; the complete artifacts retain their compiled instructions.

Its checked ARC CPU time is still 4.611 / 2.072 times C on Linux AMD64,
5.902 / 1.910 on Linux ARM64, 2.193 / 1.690 on ARM macOS and 1.785 / 1.411 on
Intel macOS. These ratios compare implementations within each run. Comparing
CPU time with the earlier run does not establish a paired speedup. The final revision below removes those splats when their sole use is that dot.

The [final scalar-splat report](measurements/vector-scalar-splats-2026-10-16.json)
records revision `b1a34ea0` on all four hosts. Both workloads now use **two managed
requests total**, 40 requested bytes, 48 peak charged bytes, zero retains and zero
final charged storage. These requests belong to final result conversion/output;
the calculation loop no longer constructs lists, arrays or vector wrappers.
C/Rust still report zero application heap requests in their narrower calculation
scope. This does not imply fwp startup or printing uses no system allocation.

The [paired comparison](measurements/vector-paired-2026-10-16.json) then runs the
same baseline and final binaries together on each host, with matching C/Rust
references. One warmup precedes twelve balanced orders. Artifact identities and
collector-off profiles reproduce the original runs. This measures the complete
compiler revision change; it does not isolate each transformation.

Each entry is a CPU-time ratio: final checked ARC divided by the stated reference.
A ratio of 0.161 means about 83.9% less CPU time than before; 1.954 means about
95.4% extra CPU time compared with C. Whole-process timings include startup and
output, which matter especially for the short four-lane workload.

| Host | Four lanes / before | Four lanes / C | Four lanes / Rust | 64 lanes / before | 64 lanes / C | 64 lanes / Rust |
|---|---:|---:|---:|---:|---:|---:|
| Linux AMD64 | 0.161 | 1.954 | 1.576 | 0.313 | 1.432 | 1.311 |
| Linux ARM64 | 0.116 | 1.517 | 1.251 | 0.241 | 0.878 | 0.937 |
| macOS ARM64 | 0.327 | 1.230 | 0.996 | 0.416 | 1.070 | 0.855 |
| macOS AMD64 | 0.270 | 1.134 | 1.027 | 0.504 | 1.043 | 0.904 |

All four hosts improve relative to the baseline in this paired run, while the
C/Rust gaps vary by workload and host. Raw wall/CPU samples and their order remain
in the report; these two small programs do not establish universal parity.

The retained ARM64 calculation loops hold state in registers, with no calls,
loads or stores inside the selected loop bodies. Vector instructions compute
independent iteration values; scalar additions combine those values in the
original order. Setup and output remain outside those loops. The actual C,
assembly and binary identities are recorded; this is static code inspection,
not a measurement of cache misses or dynamic register spills.

## Storage for received stream values

A remote iterator saves each received value so another reader of the same
position gets that value again. An unread position needs a receive source; a
completed position needs its saved result. The compact representation gives these
two alternatives the same storage word instead of reserving space for both.

The [preceding fwp representation](measurements/remote-stream-shared-2026-10-16.json)
at `00c09cdc` and [compact fwp representation](measurements/remote-stream-compact-2026-10-17.json)
at `4c26f21f` receive queued Protocol Buffer messages containing 16-character
strings. Both versions already include the shared-reader and description-lifetime
repairs. Tests consume 1, 32 and 128 values, read every position twice, stop half
way, or retain the first position while consuming the sequence. Collection is
disabled for the allocation counts. Separate runs check collector stress,
verification, cancellation and reuse.

All six native hosts report these storage costs:

| Measurement | Separate source/result fields | Shared storage word |
|---|---:|---:|
| Bytes per position, aligned to 8 bytes | 24 | 16 |
| Managed allocation requests per received value | 4 | 4 |
| Requested bytes per received value | 89 | 81 |
| Bytes charged after allocator rounding, per value | 112 | 96 |
| Fixed setup bytes charged | 720 | 704 |
| Bytes charged after consuming 128 values, including setup | 15,056 | 12,992 |

The four allocations hold the decoded string, next position and two result
wrappers. The position itself is one third smaller; requested bytes per received
value fall by about 9%. Use the two revisions above to compare the same receive
work with the shared-reader and description-lifetime repairs present in both.

These are fwp-to-fwp memory measurements, not timing or C/Rust comparisons.
Socket I/O, connection pooling, raw message/codec buffers, allocator pages and
total process memory are excluded. The reports retain actual compiler and CPU
details, layouts, counts and binary hashes. Actual AMD64 and ARM64 test and service
binaries read the completed value from the same word used by an unread source;
the cached-value load moves from offset 16 to offset 0. Combining receive-storage
and reader cleanup also reduces the receive function's stack frame: the O2 test
uses 344 rather than 360 bytes on AMD64 and 336 rather than 368 on ARM64; the O1
service client uses 216 rather than 232 bytes on AMD64 and 240 rather than 272 on
ARM64. AMD64 figures include saved registers and exclude the incoming return
address; ARM64 figures include its saved registers. These are static observations
of the retained binaries, not timing results. Smaller storage alone does not
establish faster execution.

Clearing C references still leaves the measured cache storage charged with
collection disabled. Explicit native last-owner destruction remains unfinished.
To reproduce, dispatch the `stream-owners` evidence suite, then run
[`collect-stream-measurements.py`](../scripts/collect-stream-measurements.py)
through the local guard with `--run`, exact `--head`, `--artifacts`, `--baseline`
and `--output`. The baseline is the passing preceding-representation report above.
The collector checks jobs, named tests, artifact revisions and matching inputs
before recording the differences; it does not execute downloaded binaries.

## Stack use when releasing wrapped chains

Releasing a value means giving up its ownership; its final owner also releases
its children. A record that contains an optional next record is a simple chain.
Previously, cleanup called one function for the record and another for the
optional wrapper at every link. The new compiler follows these links in a loop.
It stops when another owner still needs a node or wrapper.

The [retained comparison](measurements/wrapped-chain-cleanup-2026-10-17.json)
compares fwp at `70e36523` with `aea7d6df`. Each record owns a five-byte string and
an optional next record. Both versions free every measured allocation with
tracing disabled. This compares two fwp cleanup implementations; it measures
neither elapsed time nor a speed gap against C or Rust.

A small observer samples a stack address whenever a generated cleanup function
starts. The difference between its highest and lowest addresses shows stack
growth. It is not total stack usage: zero means the sampled address stayed the
same, and instrumentation can change frame sizes. These are the O2 byte spans:

| Native target | Previous span, 64 links | Previous span, 1,024 links | Largest new span, through 16,384 links |
|---|---:|---:|---:|
| Linux AMD64 | 2,048 | 32,768 | 16 |
| Linux ARM64 | 3,072 | 49,152 | 32 |
| macOS ARM64 | 4,096 | 65,536 | 0 |
| macOS AMD64 | 3,072 | 49,152 | 0 |
| Windows AMD64 | 4,096 | 65,536 | 0 |
| Windows ARM64 | 3,072 | 49,152 | 0 |

O1 results and every sample remain in the report. The candidate also checks a
chain whose optional value holds a tuple of another string and the next record.
Each shape runs at 64, 1,024 and 16,384 links, retaining either no alias, the root,
a middle record or a middle wrapper; the tuple case retains a tuple too. All
memory must be reclaimed after the final alias is released. Restoring the old
recursive cleanup bodies must exceed the stack bound.

Actual language programs are compared with the raw interpreter, then checked
under collector stress, reuse verification and count-only storage mode. Static
inspection of the uninstrumented Linux binaries shows fixed Link-cleanup frames
of 24 bytes on AMD64 and 64 on ARM64, with backward branches through the chain.
The AMD64 figure excludes the caller's return address; ARM64 includes its saved
registers. Calls into ordinary release helpers still have their own frames.

The reports retain source revisions, C files, binaries, instruction excerpts,
hashes and candidate CPU/compiler details. The baseline did not separately record
its CPU/compiler metadata; its CI logs and binaries remain available. Construction
cost, total process memory and cleanup allocation requests are not separately
measured. This change leaves the node allocations and reference counts in place.
It does not establish explicit ownership for native remote-stream caches.

Reproduce with the `chain-cleanup` evidence suite and
[`collect-chain-measurements.py`](../scripts/collect-chain-measurements.py), supplying
both runs and exact heads, an artifact directory and an output file. Use the local
guard for collection; builds and native executions belong on CI. The original
source is preserved by `evidence/wrapped-chain-baseline-20261017`.

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

A complete client receives a stream from a running service, constructs the
language's iterator values and consumes them. The
[baseline report](measurements/remote-client-memory-baseline-2026-10-17.json)
at `456f2dbd` measures that path on all six native targets. The server sends the
integers from 1 through the requested count over a real loopback HTTP/2 connection.
The server uses the interpreter; its memory is outside the client counters.

Three client programs request 64, 1,024 or 16,384 integers. The first sums the
whole stream. The second also sums it, but retains the original iterator until
it reads the first value again. The third consumes only the first 32 values.
For 64 requested values, their outputs are respectively `2080`, `(2080, [1])`
and `528`. The pair in the second output contains the sum and a one-element list
holding the reread value. Raw unoptimized interpretation and ordinary compiled
clients must agree with those expected results before collecting measurements.

Separate instrumented clients run three times per case with collection disabled
and physical freeing enabled. Counters start after constant initialization and
stop after the entry function and cached top-level values are cleaned up. They
count managed allocation requests, requested bytes and managed value retains,
and sample allocator-charged storage after each allocation. A retain adds an
owner to an already-counted value; this counter does not cover separate transport
reference counts. Native clients use `-O2` through the recorded compiler revision's
usual C compilation path. Compiler versions, CPU details, source, generated C,
binaries and all samples are retained.

Here is the charged storage remaining after entry cleanup for the first client:

| Native client | 64 values | 1,024 values | 16,384 values |
|---|---:|---:|---:|
| Linux AMD64 | 10,816 bytes | 72,256 bytes | 1,055,296 bytes |
| Linux ARM64 | 23,872 bytes | 85,312 bytes | 1,068,352 bytes |
| macOS AMD64 | 6,816 bytes | 68,256 bytes | 1,051,296 bytes |
| macOS ARM64 | 6,816 bytes | 68,256 bytes | 1,051,296 bytes |
| Windows AMD64 | 7,968 bytes | 69,408 bytes | 1,052,448 bytes |
| Windows ARM64 | 7,584 bytes | 69,024 bytes | 1,052,064 bytes |

All three repetitions agree on these hosts. Remaining managed storage grows by
64 bytes per consumed integer, even without deliberately retaining an earlier
iterator. Each additional integer causes five allocation requests totaling about
104 requested bytes; the changing length of the command-line count adds a small
fixed difference. The retained-iterator case has the same remaining storage at
this final sampling point. The partial reader's measured managed storage stays
fixed as the requested count increases.

These observations identify missing cache destruction with collection disabled;
they do not show a leak under ordinary collection or establish bounded total
memory for partial readers. The counters exclude raw network/message buffers,
allocator metadata/pages, total process memory and server memory. The final
sample precedes whole-runtime shutdown. No execution timings or C/Rust comparison
are included. Generated C from that baseline also shows the missing ownership:
`GrpcCell`, the internal type for a remote stream position, was not counted,
and tuple cleanup did not release its cell field.

To reproduce, dispatch `numerics.yml` with `suite=stream-clients`, then use
[`collect-stream-client-measurements.py`](../scripts/collect-stream-client-measurements.py)
through the local guard. Supply the workflow number, exact source revision,
artifact directory and report path through `--run`, `--head`, `--artifacts` and
`--output`. It requires all six native jobs, the startup-deadline regression,
the client measurement, matching source identities and every expected sample.
It never executes downloaded binaries.

The [cache-ownership report](measurements/remote-client-cache-ownership-2026-10-17.json)
compares that baseline with `886dad3b`, which passes focused ownership checks on
all six native hosts. Full production acceptance is tracked in the
[delivery history](roadmap-history.md). Both revisions run the same clients and inputs.
The candidate gives a stream position responsibility for its cached values;
releasing the final owner releases the cache without waiting for collection.

| Native client | Baseline final charge, 16,384 values | Candidate final charge, each tested size | Candidate one-pass peak, each tested size |
|---|---:|---:|---:|
| Linux AMD64 | 1,055,296 bytes | 6,480 bytes | 6,832 bytes |
| Linux ARM64 | 1,068,352 bytes | 19,536 bytes | 19,888 bytes |
| macOS AMD64 | 1,051,296 bytes | 2,480 bytes | 2,832 bytes |
| macOS ARM64 | 1,051,296 bytes | 2,480 bytes | 2,832 bytes |
| Windows AMD64 | 1,052,448 bytes | 3,632 bytes | 3,984 bytes |
| Windows ARM64 | 1,052,064 bytes | 3,248 bytes | 3,600 bytes |

Final managed charge is constant across 64, 1,024 and 16,384 values in all three
modes, and all three repetitions agree. The 64-byte-per-value retained growth is
removed. The one-pass peak is also constant. Keeping an earlier iterator still
keeps its history until released, so that mode's peak grows with the sequence.
These are single-call clients, not evidence for unlimited repeated calls in one
process or bounded unread network queues.

There is a bookkeeping cost: at 16,384 values, the one-pass client's effective
retains rise from 16,385 to 81,921, about five times as many. Each additional
integer still allocates five objects requesting about 104 bytes. No timing or
C/Rust speed comparison is included. The capture-transfer comparison below
reduces these retains; wrapper references and allocations remain optimization
work. Ownership alone is not a zero-cost claim.

Independent controls release chains through 16,384 positions, preserving aliases
to positions, optional results and tuples. All counted allocations release after
the final owner, without collection. Deliberately recursive cleanup and omitted
source release must fail. Collector stress, memory-reuse poisoning and decoder
success/error/trap controls also pass. Across all hosts, instrumented cleanup
stack-address span is at most 592 bytes and does not grow with chain length.
Ordinary Linux client binaries show backward branches and fixed cache-cleanup
frames: 24 bytes on AMD64, excluding the incoming return address, and 64 bytes on
ARM64 including saved registers. These figures exclude helper-call frames.

For a candidate ownership comparison, pass the retained baseline report with
`--baseline-report` to the collector. This also requires passing cache-owner and
callback-failure controls, the primitive contract audit, exact release counts
and bounded stack samples. It checks that final managed charge stays constant
across sizes, and that one-pass peak charge does too. Retaining an earlier
iterator intentionally keeps its history until that reference is released.

Use [`inspect-stream-client-binaries.py`](../scripts/inspect-stream-client-binaries.py)
with `--artifacts`, an explicit LLVM `--objdump` executable and `--clients unique
retained` to save static disassembly and fingerprints. It inspects the ordinary
compiled clients, without executing downloaded programs. A backward branch can
confirm a cleanup loop; count saved registers and stack adjustments separately
when reporting a function's frame. Helper calls have their own frames. Samples
of stack-address variation do not measure total stack storage.

### Moving captured values instead of retaining them again

A closure is a function carrying values for a later call. When a call consumes
its only owner, those captured values can move into the callee or a new partial
application. The old closure then releases its own storage without releasing
the transferred values. Shared closures still need separate references.

[The capture-transfer report](measurements/remote-client-capture-moves-2026-10-17.json)
at `afd7d460` passes all six native jobs in
[the focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/38996238360).
It compares the cache-ownership revision with the
same native clients, inputs, compiler settings and measurement boundaries above.
For the one-pass client, every host reports these retain counts; three separate
processes agree:

| Received integers | Original tracing-dependent cache | Explicit cache ownership | Cache ownership plus capture moves |
|---|---:|---:|---:|
| 64 | 65 | 321 | 194 |
| 1,024 | 1,025 | 5,121 | 3,074 |
| 16,384 | 16,385 | 81,921 | 49,154 |

At 16,384 integers, moving captures removes about 40% of the new ownership
implementation's retains. It still performs about three times the original
tracing-dependent implementation's retains. Moving a continuation's stream
position also avoids an artificial second owner, allowing that read to move its
cached result. Remaining wrapper references and five allocations per additional
integer are still optimization work. No timing or C/Rust comparison is included.

Final charged storage stays at the cache-ownership values in the preceding table,
constant across sizes and all three modes. One-pass peak drops another 64 bytes
on every host: 6,768 bytes on Linux AMD64, 19,824 on Linux ARM64, 2,768 on either
Mac, 3,920 on Windows AMD64 and 3,536 on Windows ARM64. Retained histories still
keep earlier values alive until the iterator is released. Connections and raw
message queues remain outside this complete ownership claim.

Independent controls cover unique/shared closures, partial/full calls, normal
returns, language errors and traps. They require zero capture retains for the
unique cases and exactly the necessary typed retains for shared ones, with no
remaining managed storage. Deliberately restoring capture duplication or stealing
shared captures makes the controls fail. Existing unwind, cancellation, scalar-bit
and reference-counter overflow tests remain in the native selection.

The actual Linux AMD64 and ARM64 binaries branch on ownership count one, clear
the consumed closure's capture count and skip the capture-retain callback. Shared
paths still call it. Dynamic dispatch, argument copying and stack storage remain;
this is not a claim that dynamic calls use registers alone. Cache cleanup still
uses a backward branch with fixed frames of 24 bytes on AMD64 (excluding the
incoming return address) and 64 bytes on ARM64 (including saved registers).
Helper-call frames are separate.

To collect this comparison, use `--baseline-report` with the cache-ownership
report and add `--capture-moves`. The collector requires all six native jobs at
the exact source revision, the capture controls and their 12 cases at both
optimization levels. The report retains source identities, raw samples, binary
hashes and reviewed instruction evidence. Full production acceptance is recorded
separately in the handoff.

## Memory left behind by repeated remote calls

A remote call asks another process to run a function. Several calls can share
one network connection, but each call needs its own request state and queued
response messages. To distinguish a reusable connection pool from per-call
growth, this measurement repeats calls in one client process with collection
disabled and ordinary physical freeing enabled.

The baseline is fwp `ac95632b` (tag
`evidence/repeated-remote-baseline-20261017`), before explicit client-stream
ownership. [The report](measurements/repeated-remote-baseline-2026-10-17.json)
preserves all six passing native jobs, hardware/compiler descriptions and raw
per-call checkpoints. It compares different call counts in this same fwp
implementation; there is no C/Rust comparison or elapsed-time claim.

Each call returns integers 1 through 64 from an interpreted loopback server.
A full reader sums them to 2,080; a partial reader sums the first 32 to 528.
The retained-reader case sums two calls while keeping the first iterator alive,
then rereads its first value, giving 4,161 per batch. It makes two calls per
batch; the other cases make one. Each process runs 1, 16 or 256 batches, with
three measured processes per case. Raw unoptimized interpretation and ordinary
compiled output agree before instrumented execution.

On all six platforms, one connection is reused and remaining managed storage
grows by 240 bytes for every additional call. No stream object is finalized.
Full and retained readers free every queued message. Partial readers leave 609
requested message bytes per call in these samples, including message headers and
the trailing byte, for 155,904 bytes after 256 calls. Scheduling can change queue
occupancy; these raw bytes are separate from the managed totals below.

| Platform | Managed bytes after 1 full call | After 256 full calls |
|---|---:|---:|
| Linux AMD64 | 6,480 | 67,680 |
| Linux ARM64 | 19,536 | 80,736 |
| macOS AMD64 and ARM64 | 2,480 | 63,680 |
| Windows AMD64 | 3,632 | 64,832 |
| Windows ARM64 | 3,248 | 64,448 |

Counters start after constant initialization and end after root execution,
joining its child tasks and releasing cached values, before whole-runtime
shutdown. Reusable connections and detached I/O tasks are still live at this
point; their remaining storage is not a demonstrated leak.
Other raw buffers, allocator pages, TLS/operating-system storage and server or
whole-process memory are excluded. This baseline identifies the request storage
addressed by the following comparison. It does not establish bounded memory or
collector-free remote execution. Connection and retained callback ownership
remain open.

### Releasing finished requests and unread messages

[The request-ownership report](measurements/remote-request-ownership-2026-10-17.json)
compares baseline `ac95632b` with `997b23a9`, preserved by tag
`evidence/remote-request-ownership-20261017`. All six native jobs passed in
[the focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/39000228402).
It uses the same clients, inputs, output checks and sampling boundaries above.

Each request now has explicit owners: the connection's active-request list,
its reader and any sender still using it. Releasing the reader discards unread
messages. It does not cancel the remote operation; an unfinished request stays
on the active list until completion or connection failure. The last owner frees
the request. Keeping an earlier iterator still preserves its cached values.

| Platform | Baseline managed bytes after 256 full calls | New managed bytes after 1, 16 or 256 calls |
|---|---:|---:|
| Linux AMD64 | 67,680 | 6,240 |
| Linux ARM64 | 80,736 | 19,296 |
| macOS AMD64 and ARM64 | 63,680 | 2,240 |
| Windows AMD64 | 64,832 | 3,392 |
| Windows ARM64 | 64,448 | 3,008 |

The new final totals are constant in every measured mode and repetition,
including retained readers with two calls per batch. Every created request and
queued message is released. The partial reader no longer leaves the baseline's
155,904 queued-message bytes after 256 calls. These raw message bytes are separate
from the table's managed storage. Scheduling may change how many messages are
constructed before a reader stops.

This adds one reference-count increment per call, with unchanged managed
allocation requests and requested bytes in these clients. The request header
remains 232 bytes with 8-byte alignment on all six hosts: the new flag occupies
existing padding at offset 228. Removing an unused sender encoder field leaves
a 40-byte sender structure; allocator rounding means this alone is not a measured
heap saving. These measurements compare two fwp implementations, without elapsed
timing or a C/Rust comparison. At that revision, connections and callback graphs
still needed tracing; the later ownership measurements below cover their release.

Native controls cover aliases, final owners, completion, reset, connection death,
sender cancellation, retries, decoder errors and failed allocation. Deliberately
omitting each owner's release or finalizer removal must fail. Ordinary execution,
collector stress and memory-reuse poisoning pass. Existing Windows connection
fixtures now select the required platform API before including system headers.

Actual Linux binaries show unread-source cleanup calling request release before
freeing the source. Queued messages release in a loop. That helper's frame is
24 bytes on AMD64, excluding the incoming return address, and 32 bytes on ARM64,
including saved registers. The last-owner request path removes its collector
finalizer, cleans metadata and frees raw storage; it uses 8 and 32 frame bytes,
respectively. Callee frames are additional. Existing cache-chain cleanup still
uses fixed 24/64-byte frames. Dispatch, count lookups and argument storage remain.

Collect the comparison with `collect-repeated-client-measurements.py`, supplying
the exact run/head, artifact directory, output path and `--baseline-report`.
It requires all six native jobs, matching outputs, complete request/message
release and constant final managed storage. Binary inspection is static;
downloaded programs are not executed locally. Full production acceptance is
recorded separately in the [delivery history](roadmap-history.md).


### Moving a selected field instead of retaining it again

[The combined report](measurements/remote-projection-moves-2026-10-17.json)
compares request cleanup at `997b23a9` with `d7a161d1`, preserved by
`evidence/remote-projection-moves-20261017`. All six native jobs passed in
[the focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/39001772549).
The clients, inputs and measurement boundaries are the same as above.

A heap record is a container allocated separately from the current function's
local variables. When the compiler consumes a record with exactly one field
needing counted ownership, it now checks whether that record has one owner.
If so, it transfers the field and frees the empty container. A shared record
still retains the selected field before giving up its own reference, preserving
other readers. No new syntax or layout fields are needed.

| After 256 batches, on every measured platform | Request cleanup alone: count increments | With compiler transfer | Reduction |
|---|---:|---:|---:|
| Full reads, 256 calls | 66,562 | 50,178 | 24.6% |
| Partial reads, 256 calls | 41,986 | 33,794 | 19.5% |
| Retained readers, 512 calls | 116,226 | 99,586 | 14.3% |

Allocation requests, requested bytes and final managed storage are unchanged
in every case. Every request and queued message releases. Compared with the
original baseline before either change, full reads fall from 66,306 to 50,178
count increments: request cleanup adds one increment per call, while compiler
transfers remove more. There is no elapsed-time or C/Rust comparison.

Actual Linux machine code confirms the transfer on AMD64 and ARM64. The unique
path frees the container and skips the shared path's field increment and parent
release. The iterator helper uses a 168-byte AMD64 frame, excluding its incoming
return address, and a 192-byte ARM64 frame including saved registers. These are
observed frame sizes, not a measured reduction or whole-program stack bound.
Callee frames are additional. Count-table lookups, cleanup records, dynamic calls,
result allocations and an earlier payload increment remain. The report retains
binary/source fingerprints and reviewed instruction locations; downloaded
programs were not executed locally.

The combined run also checks construction failure and long names in the service
TLS-settings cache. Those tests establish cleanup correctness; this client
workload does not measure a general heap saving from that separate fix. Full
production acceptance remains recorded in the [delivery history](roadmap-history.md).

### Memory after closing connections and finishing their I/O tasks

A reusable connection is intentionally kept alive for another call. To measure
storage left after that connection is no longer usable, this separate workload
closes it and waits for its reader and writer tasks to finish before opening the
next one. A task is a computation scheduled on the runtime's event loop; finishing
its work and releasing its task record are separate operations.

[The closed-connection baseline](measurements/closed-remote-baseline-2026-10-17.json)
uses `4103b0a0`, preserved by `evidence/closed-remote-baseline-20261017`.
[All six native jobs passed](https://github.com/e6qu/fun-with-pipes/actions/runs/39002767125).
It measures the same full, partial and retained-reader programs, 64 response
integers, 1/16/256 batches and three processes per case described above.
Only the instrumented clients force connection closure. Ordinary native and raw
interpreter runs establish matching output using normal connection pooling;
they do different transport work. Revision comparisons must use the same
connection-closing instrumentation, not compare this with the pooled workload.

All sockets close, both I/O tasks finish, and every request and queued message
releases. Nevertheless, managed storage grows with the number of closed
connections. Here are the allocation categories and observed additional remaining
bytes per connection; allocator-charged bytes include allocation-size rounding.

| Platform | Connection allocation, charged bytes | Two I/O task allocations, charged bytes | Additional remaining bytes per connection |
|---|---:|---:|---:|
| Linux AMD64 | 320 | 3,584 | 3,904 |
| Linux ARM64 | 320 | 12,288 | 12,608 |
| macOS AMD64 and ARM64 | 320 | 1,280 | 1,600 |
| Windows AMD64 | 320 | 2,048 | 2,368 |
| Windows ARM64 | 320 | 1,792 | 2,112 |

The category counters record cumulative allocations, not live-object identities.
Their sums match the measured growth. Static review of actual Linux binaries
also shows why these objects remain: connection release closes the transport
without freeing the connection record, and scheduler cleanup skips task-record
release for these uncounted I/O tasks. The source and binary fingerprints and
instruction locations are retained in the report. Task layouts differ by host:
Linux uses glibc's saved-context structure, macOS uses the runtime's own register
save layout, and Windows uses native fibers. The measurements do not compare
scheduling speed or justify changing those implementations without validation.

Counters stop after the final connection closes, I/O tasks finish and cached
values release, before whole-runtime shutdown. Collection is disabled and
physical freeing enabled. Stack pools, other raw buffers, TLS/OS/allocator
metadata, server/process memory and timing are excluded. Empty task lists alone
do not prove their record storage was freed. The following comparison tests explicit
connection/task ownership against this baseline. Neither report establishes
checked ARC or speed parity with C/Rust.

### Freeing closed connections and finished tasks

[The ownership comparison](measurements/closed-remote-ownership-2026-10-17.json)
uses `3a773a85`, preserved by `evidence/closed-remote-ownership-20261017`.
[All six focused native jobs passed](https://github.com/e6qu/fun-with-pipes/actions/runs/39007195648).
It compares the same connection-closing workload with `4103b0a0` above.
The connection record now has owners for the pool, active callers and background
I/O tasks. Its last owner frees its metadata and storage. Each client I/O task
has one scheduler owner and releases its record without task reference-count
updates, after its stack and scheduler links have been removed.

| Platform | Before: remaining managed bytes after 256 full reads | After: remaining bytes at 1, 16 or 256 batches |
|---|---:|---:|
| Linux AMD64 | 1,001,216 | 1,792 |
| Linux ARM64 | 3,233,792 | 6,144 |
| macOS AMD64 and ARM64 | 410,240 | 640 |
| Windows AMD64 | 607,232 | 1,024 |
| Windows ARM64 | 541,568 | 896 |

The final totals are constant across all measured sizes, repetitions and modes,
including readers retained across another call. Every created connection,
request and queued message releases, with no collection. The fixed remainder
matches one root-task allocation, which is still live at sampling; allocation
category counters alone do not identify every live object. These are bytes
charged by the runtime allocator, not pages returned to the operating system.
The exclusions and different transport work of interpreter references remain
exactly as described above.

Managed allocation requests and requested bytes are unchanged in every case.
Connection sharing adds three reference-count increments per connection: at
256 full reads, the total increases from 50,178 to 50,946 on every host, about
1.5%. Retained mode creates two connections per batch and adds 1,536 increments
at 256 batches. Task disposal itself adds no task count updates. This trades
some connection bookkeeping for immediate storage reclamation; it does not
establish zero overhead or faster execution. There are no elapsed timings or
C/Rust comparisons in this report.

Actual Linux machine code confirms last-owner connection cleanup and direct
unique-task freeing on AMD64 and ARM64. The task cleanup path skips the shared
path's reference-count lookup. Its frames remain 8 bytes on AMD64, excluding
the incoming return address, and 32 bytes on ARM64, including saved registers.
Transport release uses 40/48 bytes, unchanged from the baseline; the new
last-storage-owner helper uses 8/32 bytes. Callee frames are additional; these
are observed function frames, not whole-program stack bounds. Scheduler work,
policy branches, allocator bookkeeping and shared-connection counts remain.
The report retains reviewed instruction locations and source/binary fingerprints;
downloaded executables were inspected statically, not run locally.

Native controls cover shared readers, construction failure, cancellation,
library unload, missing last-owner releases and disabled physical freeing.
Eighteen injected fatal-allocation cases verify the error, exit code and prior
buffered output. The final delivery additionally preserves the existing
recoverable server TLS protocol-list allocation error and adds its regression
check; that server-startup path is outside the measured client workload.
Final production acceptance is tracked in [the delivery history](roadmap-history.md).
This comparison predates the input-owner work accepted in PR #159 and the server
ownership measurements below. It establishes the client connection rules for
that revision; later ownership work has its own evidence.


### Memory retained by client inputs after sending finishes

A client can send an iterator, a sequence produced one value at a time, to a
remote function. A synchronous call finishes sending before waiting for its
result. A bidirectional call sends and receives concurrently, using a separate
sender task. Both paths must release the input values after they are no longer
needed, while preserving any copy the program still holds.

[The sender baseline](measurements/sender-input-baseline-2026-10-17.json)
uses `f6ebb2e9`, retained by `evidence/sender-input-baseline-20261017`.
[All six native jobs passed](https://github.com/e6qu/fun-with-pipes/actions/runs/39009268395).
This is fwp measured before the input-ownership change, with the preceding
connection and I/O-task cleanup already present. It establishes the remaining
memory problem; it is not a comparison against C or Rust.

Each process makes 1, 16 or 256 calls, with three processes per case. Four
programs exercise different input lifetimes:

- Synchronous: send integers 1 through 64 and receive their sum, 2,080.
- Bidirectional: send `word-1` through `word-64`, receive uppercase strings and
  sum their lengths, giving 439.
- Retained input: run the same uppercase call, then read the original input
  again. Both length totals add to 878; retaining the original must preserve it.
- Early completion: offer 64 integers, but the server returns only the first
  three multiplied by ten. Their sum is 60. The actual number of inputs sent
  varies with scheduling and is recorded, rather than assumed to be three.

Measurement hooks close each connection and wait for its reader, writer and
sender tasks before the next call. All connections, requests and received
messages release, yet managed memory still grows. The table gives allocator-
charged bytes, including size-class rounding, after 256 calls.

| Platform | Synchronous inputs | Bidirectional or retained inputs |
|---|---:|---:|
| Linux AMD64 | 1,820,416 | 3,356,416 |
| Linux ARM64 | 1,824,768 | 4,474,880 |
| macOS AMD64 and ARM64 | 1,819,264 | 3,060,352 |
| Windows AMD64 | 1,819,648 | 3,159,040 |
| Windows ARM64 | 1,819,520 | 3,126,144 |

Each additional synchronous call leaves 7,104 bytes on every host. The other
complete-input modes leave 11,952–17,456 bytes per additional call, depending
on the platform. These totals include input storage and finished sender/task
records; cumulative allocation categories do not prove individual live-object
identities. Early-completion totals vary with the amount of input produced.

Actual Linux AMD64 and ARM64 binaries show remote entries marking the input
shared, iterator advancement using an unowned call, and sender cleanup releasing
the connection and request without freeing its input or sender record. The
report retains source/binary fingerprints, reviewed instruction locations and
function-frame sizes. Those frames differ between architectures and include
neither callee frames nor a whole-program stack bound. No speed claim follows
from this inspection.

Generated clients use `-O2`. The report records hardware, C/Rust toolchains,
source, output references, allocation requests/bytes, reference-count increments,
peak and final managed bytes, input counts and raw checkpoints. Collection is
disabled and physical freeing enabled. Counters run from after constant setup
to after cached-value cleanup and task draining, before whole-runtime shutdown.
Stack pools, other raw buffers, TLS/OS/allocator metadata, server/process memory
and elapsed time are excluded. Ordinary native and interpreter runs check the
outputs using normal pooling; their transport work differs from the measured
clients. A future ownership comparison must use the same closing hooks and
account for variable input work in early completion. This baseline establishes
neither checked ARC support nor zero overhead.


### Input owners and moves: bounded memory with measured count costs

[The final comparison](measurements/sender-input-ownership-2026-10-17.json)
uses `06f3ac6f`, tag `evidence/sender-input-ownership-20261017`.
[All six native jobs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/39013126818).
It uses the same four clients and closing hooks as the baseline above, at
1/16/256 calls with three fresh processes per case. Final managed storage is
constant across every size and mode, including early server completion:

| Platform | Remaining managed bytes |
|---|---:|
| Linux AMD64 | 1,792 |
| Linux ARM64 | 6,144 |
| macOS ARM64 or AMD64 | 640 |
| Windows ARM64 | 896 |
| Windows AMD64 | 1,024 |

These totals match the platform's root-task storage category; allocation
categories alone do not identify individual live objects. All measured
connections, requests and queued messages are released, and every sender and
connection task finishes. Collection stays disabled throughout. The initial
[Linux ownership probe](measurements/sender-input-ownership-probe-2026-10-17.json)
already bounded memory, but retained every continuation for its call. A
continuation is the function producing the next iterator node. The final change
moves that function from an exclusively owned node; shared nodes preserve it
for older readers.

The three complete-input modes make the same number of allocation requests as
the original baseline on every host. A background sender requests 48 instead of
40 bytes, still occupying the same 48-byte allocator class: at 256 calls this
adds 2,048 requested bytes without extra allocation requests. Synchronous
requested bytes are unchanged. Reference-count increments at 256 calls are
identical across the six final hosts:

| Input mode | Original baseline | First ownership probe (Linux AMD64) | Final owners and moves | Extra versus baseline |
|---|---:|---:|---:|---:|
| Synchronous | 17,922 | 66,818 | 18,946 | 1,024 (+5.7%) |
| Bidirectional | 150,274 | 280,578 | 184,322 | 34,048 (+22.7%) |
| Retained original input | 181,762 | 344,834 | 248,578 | 66,816 (+36.8%) |

These are operation counts, not elapsed-time overhead. Moving unique
continuations removes much of the first ownership version's count traffic;
ownership still costs more count operations than the version that retained
storage for tracing. Early completion can consume different numbers of inputs,
so its allocation/count deltas are not equal-work comparisons.

Actual Linux ARM64 and AMD64 binaries show count-one tests, field clearing
before owned continuation application, and borrowed calls that preserve shared
nodes. Elements remain in registers across lookahead (`rbx`/`rbp` on AMD64,
`x20`/`x23` on ARM64); cursor state and cleanup records also use stack storage.
The synchronous entry reserves 1,144 bytes on AMD64 and 1,168 on ARM64;
background sender frames use 392 and 560 bytes. AMD64 figures exclude the
incoming return address; ARM64 includes saved registers. Callee frames add to
these totals. Count-one tests still read allocation metadata; this is not
compile-time-only ownership.

The report preserves raw allocation, storage, count and completion tables,
source/binary/disassembly fingerprints, hardware/toolchains and manual binary
reviews. Failure, cancellation, retained-alias, GC-stress and reuse controls pass
in the focused matrix. [PR #159 acceptance](roadmap-history.md#streamed-input-cleanup-and-continuation-moves-pr-159)
also includes all nine production jobs and documentation. Task stack pools, other raw buffers,
TLS/OS/allocator metadata, server/process memory and timing remain excluded.
This does not establish checked ARC for remote calls, zero-cost abstractions or
speed parity with C/Rust.


## Server memory after completed remote calls

Client measurements exclude the service process. This
[server baseline](measurements/server-call-baseline-2026-10-17.json) measures
that process directly at `06432959`, tag `evidence/server-call-baseline-20261017`,
with [all six native hosts passing](https://github.com/e6qu/fun-with-pipes/actions/runs/39014733093).
It precedes server ownership changes. The four clients ask the server to:

- Return a greeting for a 64-character name; the response length is 71.
- Return integers 1 through 64 as an iterator; the client sums them to 2,080.
- Sum 64 integers sent by the client, also giving 2,080.
- Send `tick 1` through `tick 64` through an output channel; the client sums
  their string lengths to 439. A channel sends values between computations;
  this service channel writes through the network instead of a local queue.

Each native server receives 1, 16 or 256 calls over one reused connection, with
three fresh processes per case. Matching client output is checked against both
an interpreted and an ordinary native server. Collection is off, physical
freeing is on and native C compilation uses `-O2`. Counters start after listener,
routing and root-task setup. Per-call samples follow serving-task removal;
final samples require every call and spawned task to finish and the client
connection to close. The listener remains open. A measurement-only wake of the
existing listener lets the scheduler retire the last finished task's stack;
it adds no task or connection. Future comparisons must use that same boundary.

Despite completed calls and tasks, remaining managed storage grows with call
count. At 256 calls the baseline retains these bytes in every repetition:

| Platform | Greeting | Returned iterator | Sent iterator | Output channel |
|---|---:|---:|---:|---:|
| Linux AMD64 | 721,248 | 2,486,624 | 1,753,440 | 971,104 |
| Linux ARM64 | 1,844,064 | 3,609,440 | 2,876,256 | 2,093,920 |
| macOS ARM64 or AMD64 | 423,488 | 2,188,864 | 1,455,680 | 673,344 |
| Windows AMD64 | 522,560 | 2,287,936 | 1,554,752 | 772,416 |
| Windows ARM64 | 489,536 | 2,254,912 | 1,521,728 | 739,392 |

On Linux AMD64, each additional call leaves 2,800 / 9,696 / 6,832 / 3,776 bytes
for these four modes. Connection/request finalizers do not run. Task and job
allocation categories help locate the cost, but cumulative category counters
do not identify individual remaining objects. Actual Linux ARM64/AMD64 machine
code confirms that traced task records skip physical disposal, job cleanup
releases peer/status text without freeing the job, and method/response-iterator
application still uses the unowned call path. The report retains instruction
reviews, source/binary/disassembly fingerprints and compiler/hardware details.

This baseline motivates server lifetime work; it does not prove a fix. Raw
request/wire buffers, stack pools, TLS/OS/allocator metadata, whole-process
memory and elapsed time are excluded. There is no C/Rust comparison or speed
claim. The later [accepted remote-call delivery](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
adds the necessary callback/channel, failure, cancellation and cycle checks for
its supported ARC subset. The [fixture guide](../tests/fixtures/server-memory/README.md)
explains this historical baseline's workload notation.

### Freeing finished server tasks and keeping argument slots on the stack

[The storage comparison](measurements/server-call-storage-2026-10-17.json)
uses `e6455c0d`, retained as
`evidence/server-call-storage-windows-20261017`, against the `06432959` baseline
above. [All six native hosts pass](https://github.com/e6qu/fun-with-pipes/actions/runs/39018276989).
Both versions run the same four fwp programs, inputs and sampling boundary.
This compares fwp before and after a memory-management change; it does not compare
fwp with C or Rust and does not measure elapsed time.

Each call has a job record holding its service context and a task record used by
the scheduler. The new version frees both when their last users finish, including
background senders that still need the context. It also frees finished connection
I/O tasks. Temporary slots used to pass method arguments now live on the serving
task's stack. This removes one allocation and 24 requested heap bytes per call
in every measured case, with unchanged reference-count increments. At 256 calls,
Linux performs 2,310 / 66,566 / 84,230 / 50,950 allocations for the four workloads;
macOS and Windows perform three fewer. Each total is 256 below its baseline.

Final managed bytes after 256 calls are identical across all three repetitions:

| Platform | Greeting | Returned iterator | Sent iterator | Output channel |
|---|---:|---:|---:|---:|
| Linux ARM64 or AMD64 | 119,648 | 1,885,024 | 1,151,840 | 369,504 |
| macOS or Windows, either architecture | 119,104 | 1,884,480 | 1,151,296 | 368,960 |

All sizes leave less storage than the baseline, but storage still grows with
calls. Decoded values, returned iterators, connections, requests and channel
contexts need further ownership work. These numbers do not establish that a
server can run without tracing collection.

Actual Linux ARM64 and AMD64 instructions confirm the argument slots use the
stack. For these one-parameter methods, the call helper needs 48 more stack bytes
than the baseline: 16 more fixed bytes and 32 bytes for the aligned argument
slots. That is this helper's frame, not peak task stack usage. Instructions also
confirm that unscoped internal tasks bypass reference-count operations and that
job cleanup clears borrowed task pointers before freeing the job. Tasks retained
by a scope have two owners and keep the existing shared policy.

The same exclusions as the baseline apply: raw buffers, stack pools, allocator
metadata, operating-system/TLS storage, total process memory and timing are not
measured. The report retains all 18 raw tables, compiler/hardware details and
source/binary/instruction fingerprints. Downloaded binaries were inspected
without executing them locally. Full production acceptance is tracked in the
[session handoff](development-state.md).


### Freeing method arguments and results: Linux measurement

[The method-value comparison](measurements/server-method-values-linux-2026-10-17.json)
measures `48ccd3d9` against the storage change above, using the same programs,
inputs and measurement boundary. [The Linux AMD64 run passes](https://github.com/e6qu/fun-with-pipes/actions/runs/39020484780).
This intermediate result covers only Linux AMD64. The combined server comparison below extends coverage to all six native hosts;
production acceptance is recorded in [history](roadmap-history.md).

Generated cleanup functions now release each argument and result according to
its concrete type. Stack records protect them during decoding, method execution,
encoding, errors and cancellation. A returned iterator keeps its current value
alive while advancing and encoding it. A unique iterator moves its continuation;
a shared iterator preserves it for another reader. Methods receive their already
collected arguments directly, removing a temporary function object.

With collection off and physical freeing on, all three repetitions give these
final managed bytes after 256 calls:

| Workload | Storage change | With argument/result cleanup |
|---|---:|---:|
| Greeting | 119,648 | 62,304 |
| Returned iterator | 1,885,024 | 62,304 |
| Sent iterator | 1,151,840 | 62,304 |
| Output channel | 369,504 | 365,408 |

The first three still grow by 240 bytes per call. Channels and transport records
need further work; this is not a claim that services no longer need collection.
Every call removes one allocation and eight requested bytes; sent iterators
remove a second allocation and another 24 bytes. Reference-count increments are
mixed: greetings add one per call, sent iterators fall from 253 to 128, and the
other two workloads are unchanged. Necessary shared owners still have a cost.

Actual AMD64 instructions confirm direct method entry and stack-based cleanup
records. The method-dispatch helper uses 16 fewer fixed stack bytes; its caller
uses 32 more. These are individual frame sizes, not peak stack consumption.
Unique-iterator detection still reads runtime metadata. Tests include aliases,
partial decoding, encoding failures, cancellation and deliberately broken cleanup;
ordinary interpreted/native behavior also matches with reuse explicitly disabled.

This compares two fwp versions, without elapsed-time or C/Rust measurements.
The same excluded memory categories as the baseline apply. The report retains
three raw tables and source, binary and instruction fingerprints. It establishes
a memory improvement for these workloads, not zero runtime overhead.


### Freeing server values and output channels on all six hosts

[The combined report](measurements/server-values-2026-10-17.json) uses
`855fe3d1`, tag `evidence/server-values-combined-20261017`.
[All six native hosts pass](https://github.com/e6qu/fun-with-pipes/actions/runs/39022416616),
including cleanup, aliases, cancellation, collection stress, reuse checks and
ordinary interpreter/native comparisons with reuse explicitly enabled or disabled.
This is an intermediate stage of PR #160. The report compares identical programs
and inputs with storage revision `e6455c0d`; the original baseline is `06432959`.
The following section adds complete request/connection owners and callback borrowing.
These are fwp version comparisons, without elapsed-time or C/Rust measurements.

Typed cleanup now frees method arguments, results and errors. Returned iterators
keep each value alive while advancing and encoding it. Native output channels
borrow sent values; their callback payload shares one allocation with the channel,
whose header remains 96 bytes. Partial construction, errors and cancellation
release acquired owners. Methods receive their arguments directly without a
new function object for each call.

After 256 calls, every workload leaves 62,304 managed bytes on either Linux host
and 61,760 on macOS/Windows, in all repetitions. For example, Linux AMD64 changes
from the original server baseline as follows:

| Workload | Before this delivery | Combined change |
|---|---:|---:|
| Greeting | 721,248 bytes | 62,304 bytes |
| Returned iterator | 2,486,624 bytes | 62,304 bytes |
| Sent iterator | 1,753,440 bytes | 62,304 bytes |
| Output channel | 971,104 bytes | 62,304 bytes |

At this stage every workload still grows by **240 bytes per call** on every host.
Requests and connections still need owners. This does not establish bounded
long-running server memory or remote checked ARC support.

This stage removes two allocations per greeting/returned-iterator call
and three per sent-iterator/output-channel call. Requested bytes fall by 32, 32,
56 and 32 per call respectively. Reference-count increments per call change from
0 / 64 / 253 / 0 to **1 / 64 / 128 / 64**. Those are count costs, not time ratios.

Actual ARM64 and AMD64 instructions confirm direct method entry, stack argument
slots and borrowed native sends. The channel loop still duplicates its channel
reference once per send, identifying a further compiler borrowing improvement.
Compared with the storage change, the method-dispatch helper uses 16 fewer fixed
stack bytes on both architectures; its caller uses 16 more on AMD64 and 64 more
on ARM64. Both callers still need 32 dynamic argument bytes for these methods.
These frame sizes exclude callees and are not peak task-stack measurements.

The report retains 18 raw tables, instruction reviews, source/binary fingerprints,
hardware and compiler settings. Counters use the baseline's collection-off,
physical-freeing-on boundary. Raw network buffers, task stack pools, TLS/OS and
allocator metadata, whole-process memory and timing remain excluded. Full PR
acceptance is recorded in [history](roadmap-history.md).

### Freeing server requests and borrowing fold captures

[The six-platform report](measurements/server-borrows-2026-10-17.json) records
`8ed65cc7`, tag `evidence/server-borrows-controls-20261017`, from
[the passing focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/39029223789).
It compares the identical four fwp programs with the preceding `855fe3d1` stage.
Both versions serve 1, 16 or 256 calls over one connection, with three fresh
processes per case. Streams have 64 elements. This is a comparison of fwp versions,
not fwp against C/Rust, and it does not measure elapsed time.

A request stores one call's messages and status; a connection holds the socket and
information shared by calls. Explicit owners now release those records after the
last task or retained iterator/channel finishes. A closed socket can safely have
users that still need its record. Known fold callbacks also borrow captures:
values supplied earlier and kept for later calls. The enclosing call keeps them
alive, avoiding repeated reference-count updates inside the loop.

The final managed-storage counter is constant at every call count and repetition:

| Native hosts | Previous stage, after 256 calls | With request/connection owners and borrowing |
|---|---:|---:|
| Linux ARM64 and AMD64 | 62,304 bytes | 544 bytes |
| macOS ARM64 and AMD64 | 61,760 bytes | 0 bytes |
| Windows ARM64 and AMD64 | 61,760 bytes | 0 bytes |

Every measured request and connection finalizes. The old 240-byte increase per
call disappears. Allocation requests and requested bytes are unchanged from the
preceding stage: storage now frees sooner. Compared with the original `06432959`
baseline, the complete change still removes two allocations per greeting/returned
stream and three per sent stream/output channel, saving 32 / 32 / 56 / 32 requested
bytes per call. These are cumulative allocation costs, separate from live memory.

Reference counting still pays for independent owners. A retain is one increment
of a value's owner count; the following figures count those increments:

| Workload | Previous stage, retains per call | Combined change, retains per call |
|---|---:|---:|
| Greeting | 1 | 3 |
| Returned integer stream | 64 | 66 |
| Received integer stream | 128 | 132 |
| Output channel sending 64 texts | 64 | 4 |

The combined version also adds **one retain per connection**. Before callback
borrowing, complete connection ownership needed 68 retains per channel call;
borrowing removes 64 per-message retain/release pairs. For 256 calls that is
17,409 down to 1,025 retains. It does not remove sharing between independently
live parser, task and channel owners.

Actual ordinary Linux binaries keep the channel in `rbx` on AMD64 and `x19` on
ARM64 through the send loop, with no channel retain/drop per iteration. The
callback body is inlined. Its caller's frame grows from 200 to 280 bytes on AMD64
(excluding the incoming return address) and from 240 to 336 on ARM64. The loop no
longer calls the separate callback with its old 184/208-byte frame. Other callees
still have frames; this is not a bound on total stack use. Parser/connection
lifetime protection adds 16/32 bytes to the reader frame.

Compared with `855fe3d1`, machine-code/text sections grow by 2,536 bytes on AMD64
and 2,352 on ARM64; data and zero-initialized storage are unchanged. Ordinary
binary files grow from 322,056 to 326,328 bytes on AMD64 and from 307,376 to
307,544 on ARM64. File growth includes layout/alignment effects and differs from
code growth. No timing benefit follows from these sizes or count reductions alone.

Counters start after listener/routing/root setup and end after client disconnect
and task retirement, with the listener still open. Tracing is disabled and
physical freeing enabled. Raw network buffers, task-stack pools, OS/TLS/allocator
metadata and whole-process memory are excluded. All 18 raw tables, environment
records, source/binary fingerprints and instruction reviews are retained.

The preceding partial implementation failed the separate Linux ARM64 production
check: resident memory grew from 17,104 to 49,420 KiB over 32,000 calls. That test
covers more than the managed counter and keeps its 8 MiB growth limit. The combined
implementation passes it: the focused ARM64 probe records five samples of
8,136 KiB, and all final production jobs pass. [History](roadmap-history.md) records
PR #160 acceptance. Short bounded measurements do not prove complete GC removal,
remote checked ARC, or C/Rust parity.

### Remote services without tracing and with fewer field retains

[The six-host report](measurements/remote-arc-field-moves-2026-10-17.json) records
`efaab358`, tag `evidence/remote-arc-platform-fixes-20261017`, from
[all eighteen passing focused jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39037037021).
The accepted baseline is `8ed65cc7`, retained in the preceding server-borrows
report. The baseline contains tracing code, disabled for these measurements;
ARC excludes that code. Both versions physically free released storage.

The comparison uses the same four fwp client/server programs as the accepted
server-ownership baseline. Counters measure work and managed storage inside the
server, with the same 1/16/256 calls, three repetitions and
64-element streams. The new clients and servers are compiled with `--gc arc`;
actual binaries exclude the scan, mark and sweep routines used by tracing
collection. The compiler also transfers fields from a uniquely owned record
when a compiled function can receive those fields directly.

A retain increments a value's owner count. For one greeting, the old entry
acquired another owner for the name string even though it consumed the record
holding that string. The new entry moves that owner. A shared record still
supplies an independent owner so its other users remain valid.

| Workload | Baseline retains per call | ARC with field transfer |
|---|---:|---:|
| Greeting | 3 | 2 |
| Returned stream of 64 integers | 66 | 66 |
| Received stream of 64 integers | 132 | 132 |
| Output channel sending 64 texts | 4 | 4 |

Across all 216 memory rows (36 per host), allocation requests, requested bytes,
peak managed storage and final managed storage match the baseline. The final
counter is constant at 544 bytes on Linux and zero on macOS/Windows after every
call count. Every request and connection finalizes.

Both versions also have one retain per connection. At 256 greetings, the count
falls from 769 to 513. Server allocation requests and requested bytes stay unchanged;
this saves count operations rather than removing the record or message storage.

The ordinary Linux binaries show the transfer directly. AMD64 keeps the record
in RBX and the field in R14; ARM64 uses X19 and X20. The unique-record branch clears
the old field slot and skips the shared-path retain. The compiled function body
is inlined. Its fixed greeting-entry frame is 184 bytes on AMD64, unchanged from
the baseline, and 192 on ARM64 instead of 208. AMD64 figures include saved
registers and exclude the incoming return address; both exclude callee frames.
The channel loop still borrows its channel throughout its 64 sends. Its fixed
frame is 264/320 bytes on AMD64/ARM64, 16 fewer than the baseline on each.

Removing tracing does not make these executables smaller:

| Ordinary server | Baseline text bytes | ARC and field transfer text bytes | Baseline file bytes | New file bytes |
|---|---:|---:|---:|---:|
| Linux AMD64 | 261,813 | 269,499 | 326,328 | 330,096 |
| Linux ARM64 | 246,445 | 254,875 | 307,544 | 372,736 |

Text grows by 7,686 bytes (2.9%) on AMD64 and 8,430 bytes (3.4%) on ARM64.
Some generic function entries inline ownership-contract checks in ARC mode.
The field-transfer change adds 368/328 text bytes compared with ARC without that
change. ARM64's larger file-size jump mostly reflects padding: its writable
segment moves to the next 64 KiB file boundary while retaining the same virtual
address. The report preserves the actual segment layouts. There is no measured
speed, total-stack or cache-use benefit implied by these sizes.

The separate Linux 32,000-call resident-memory test keeps its 8 MiB growth bound.
After warm-up and each 8,000-call batch, AMD64 reports
[16084, 16084, 16084, 16084, 16084] KiB and ARM64
[8144, 8144, 8144, 8144, 8144] KiB. These whole-process samples are distinct from
the managed-storage counters.

Counters begin after listener/routing/root setup and end after disconnect and
task retirement while the listener remains open. They exclude raw network
buffers, task-stack pools, allocator/OS/TLS metadata and elapsed time. This is an
fwp implementation comparison, not an overhead measurement against C or Rust.

The report retains eighteen raw tables, source/binary fingerprints, environment
records and actual instruction reviews. Separate server/client cleanup jobs,
real calls, typed iterator-scope checks and deliberate missing-owner controls all
pass. The split preserves the original 25-minute job limit. The fixture repairs
exercise a nonblocking accept retry and configure Windows probe output explicitly;
[history](roadmap-history.md) records full production acceptance.

### HTTP clients without tracing

[The six-host report](measurements/http-client-owners-2026-10-17.json) compares
**current fwp tracing and checked ARC clients**, using the same source at
`8770c03e`, tag `evidence/http-client-memory-20261017`. It does not compare with C,
Rust or an earlier compiler. All six hosts passed the HTTP comparisons and memory
measurement steps in [the focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/39052834580).
Both Windows jobs separately exposed a cancellation probe's header-order error.
The repaired full suites pass on [AMD64](https://github.com/e6qu/fun-with-pipes/actions/runs/39054383589)
and [ARM64](https://github.com/e6qu/fun-with-pipes/actions/runs/39054388163);
[PR #162](roadmap-history.md#http-client-owners-and-complete-connection-keys-pr-162)
records passing final production acceptance.

The [measurement client](../tests/web/repeated-client.fwp) sends 1, 16 or 256
sequential HTTP/2 requests to an interpreted loopback server. Each response has
status 200; the client receives and releases its body, adds the status, and prints
200 times the request count. It reuses one connection. Both cleartext and TLS
(encrypted transport) are measured, with three fresh client processes per case.
Unoptimized interpretation and ordinary native execution check the result before
counted runs. Native builds use `-O2` and separate floating multiply/add operations.

An allocation request asks for managed storage. A retain increments an owner's
reference count. The counters include the full high-level client: iteration,
environment reads, request/options construction, URL parsing, connection selection
and response storage. They do not isolate transport overhead. Both modes have
collection disabled and physical freeing enabled; all 216 rows match between
modes for allocations, requested bytes, retains and peak/final managed storage.

Each additional call costs **237 managed allocations and 543 retains**. Startup
adds 35 allocations for cleartext or 74 for TLS, with two further allocations on
Linux; corresponding retain offsets are 49 and 149 on every host. These remain
substantial costs to reduce. No execution time is measured.

Counters begin after constant initialization and end after entry execution and
cached-value cleanup, before whole-runtime shutdown. Pooled connections and I/O
tasks can still be live. Final storage is constant at every request count; the
peak below is reached by 16 calls and remains unchanged at 256:

| Native host | Final managed bytes | Peak managed bytes |
|---|---:|---:|
| Linux AMD64 | 6,368 | 9,392 |
| Linux ARM64 | 19,424 | 22,448 |
| macOS AMD64 | 2,368 | 5,392 |
| macOS ARM64 | 2,368 | 5,392 |
| Windows AMD64 | 3,520 | 6,544 |
| Windows ARM64 | 3,136 | 6,160 |

These allocator counters do not identify each live object. They exclude raw
network buffers, TLS/OS/allocator metadata, server memory and process RSS.
Constant managed storage does not establish a bound for those excluded categories.
The final sample differs from earlier server experiments that close every
connection before sampling; their final-byte counts should not be compared directly.

Static inspection covers 48 actual native binaries: the larger HTTP comparison
client at O1/O2, and ordinary/instrumented repeated-call clients at O2, in both
memory modes on six hosts. All 24 ARC binaries omit tracing scan/mark/sweep
symbols; the 24 tracing builds retain positive controls. No downloaded binary
was executed locally. [The inspection script](../scripts/inspect-http-client-binaries.py)
records file hashes, sections and disassembly using explicit LLVM tool paths.

The following code sizes are for the **larger comparison client**, which also
checks HTTP/1.1, compression, streamed bodies and concurrent calls:

| Linux O2 client | Tracing instruction bytes | ARC instruction bytes | Extra code |
|---|---:|---:|---:|
| AMD64 | 1,412,178 | 1,611,058 | 198,880 (14.1%) |
| ARM64 | 1,344,860 | 1,533,372 | 188,512 (14.0%) |

ARC code sections grow by 11.1–14.1% across all six hosts. Code used to call
functions through function values repeatedly inlines ARC's ownership checks.
On Linux AMD64, 532 common entries grow by 204,649 instruction bytes in total;
one internal entry handling seven prepared values grows from 126 to 1,057 bytes. Other removed/changed code
also affects the total. The checks remain necessary unless a proof or different
code arrangement preserves their guarantees. This size result does not measure
execution time or instruction-cache misses.

The actual Linux HTTP entry keeps its key and transport in registers, with an
ordinary request-pointer spill on AMD64. Request owners and their cleanup records
occupy stack slots. Its fixed frame is 664 bytes on AMD64 and 720 on ARM64 in both
modes, including saved registers, excluding callees and AMD64's incoming return
address. The report retains instruction details and every binary's file/code size.
This delivery establishes specific ownership behavior and remaining costs; it
does not establish zero-cost networking abstractions or complete GC removal.

### HTTP server ownership and memory

[The six-host report](measurements/http-server-owners-2026-10-17.json) compares
**the same fwp server in tracing and checked ARC modes**, at `cd4f0b06`, preserved
by `evidence/http-server-memory-20261017`. This is a memory comparison, not a
speed measurement against C, Rust or an older fwp implementation. All six native
[server-memory jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39063863085)
passed. [PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records full functional and production acceptance.

The [server](../tests/web/server.fwp) answers sequential HTTP/2 `GET /hello`
requests from an ordinary native ARC client. The client consumes and releases
each response body and sums status 200. Each measured server handles 1, 16 or
256 calls, then one HTTP/1.1 shutdown request and drains its tasks. There are
three fresh servers per count, mode and transport, including TLS encryption.
Native builds use `-O2`, ordinary compiler optimization and
`-ffp-contract=off`. Hardware, compilers and flags are retained in the report.

An allocation request asks for managed storage; a retain increments a reference
count. Counters begin after constant initialization and end after main and cached
value cleanup, before whole-runtime shutdown. Collection is disabled and physical
freeing enabled in both modes. Final storage stays constant across counts;
cleartext/TLS peak storage differs by 16 bytes:

| Host | Final managed bytes | Peak cleartext / TLS bytes | Largest RSS increase after warm-up |
|---|---:|---:|---:|
| Linux AMD64 | 1,792 | 19,824 / 19,840 | 2,048 KiB |
| Linux ARM64 | 6,144 | 45,936 / 45,952 | 44 KiB |
| macOS AMD64 | 640 | 12,464 / 12,480 | 192 KiB |
| macOS ARM64 | 640 | 12,464 / 12,480 | 128 KiB |
| Windows AMD64 | 1,024 | 14,896 / 14,912 | 60 KiB |
| Windows ARM64 | 896 | 14,128 / 14,144 | 16 KiB |

RSS is resident set size, the process memory currently held in physical RAM
(Windows reports its working set). These separate samples use ordinary,
uninstrumented servers: five batches of 4,096 requests, with the first as warm-up.
The default 1,000-request connection limit exercises connection replacement.
Every later sample stays less than 8 MiB above the first. Managed counters exclude
raw network buffers, TLS/OS/allocator metadata and stack pools; RSS includes more
of the process but is sampled, not a peak-memory bound.

The additional-call cost is approximately **899 managed allocations and 2,318
retains**. Background work is included: slopes between the 16- and 256-call
medians range from 899 to 899.13 allocations and 2,318 to 2,318.46 retains.
These costs remain substantial; bounded storage does not make the abstraction
free. Compared with completed samples before the socket scheduler repair, its
small reusable event array adds 128 peak managed bytes on macOS and 256 on
Windows. It replaces periodic 10 ms retries with readiness waits; the unfinished
earlier runs are not a throughput baseline.

[Static inspection](../scripts/inspect-http-server-binaries.py) covers 60 saved
binaries: ordinary O1/O2 comparison servers, ordinary/instrumented O2 memory
servers, and ordinary/counted memory clients. All 36 ARC binaries exclude tracing
scan/mark/sweep routines; 24 tracing binaries retain positive controls. Downloaded
executables are inspected as data, never run locally. The O2 server instruction
sections are smaller in ARC on each host, for example 5,260,322 versus 5,266,290
bytes on Linux AMD64. Separate ownership-check counters record zero entries for
this workload; instrumentation can change compilation, so those are not ordinary
machine-call frequencies. The following experiment isolates the code-placement
change against the older ARC arrangement.

### Keeping one copy of the ownership check

A runtime check rejects counted values that escape through a call without an
ownership contract. ARC previously let the C compiler copy this check into many
entries used to call function values. The [two-host experiment](measurements/entry-check-code-costs-2026-10-17.json)
compares that arrangement with one shared copy of the **same check**. It adds
`noinline` to the existing helper; it removes no check and adds no wrapper.
The source is `e5bc8531`, tag `evidence/http-server-costs-20261017`; both jobs in
[the experiment](https://github.com/e6qu/fun-with-pipes/actions/runs/39059315375) passed.
The runtime change is accepted in
[PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163).

Both variants use identical checked-ARC generated C, Clang 18.1.3, `-O2` and
`-ffp-contract=off`. Linux AMD64 uses an AMD EPYC 7763 runner; Linux ARM64 uses
Neoverse-N2. Each runner reports four virtual CPUs. Actual downloaded binaries,
inspected without executing them locally, have these instruction-section sizes:

| Program | AMD64: copied → one check function | ARM64: copied → one check function |
|---|---:|---:|
| Integer loop | 18,194 → 15,938 bytes (−12.4%) | 16,780 → 14,828 bytes (−11.6%) |
| Numeric pipeline | 19,938 → 17,266 bytes (−13.4%) | 18,700 → 16,348 bytes (−12.6%) |
| Sorted map | 26,802 → 22,994 bytes (−14.2%) | 25,068 → 21,676 bytes (−13.5%) |
| HTTP client | 1,611,138 → 1,406,258 bytes (−12.7%) | 1,533,404 → 1,340,124 bytes (−12.6%) |
| HTTP server | 6,098,930 → 5,260,322 bytes (−13.8%) | 5,768,796 → 4,977,916 bytes (−13.7%) |

These are instruction bytes, not complete executable sizes or measured cache
misses. The report also records file sizes, fingerprints and the larger inputs'
remaining code. HTTP binaries were compiled for size only in this experiment;
the separate HTTP suites check execution, cleanup and memory.

The numerical inputs are the same loop, pipeline and map workloads described at
the top of this page. After one warmup, six fresh processes per variant alternate
order. Times include startup, computation, allocation, output and shutdown;
compilation is excluded. C verifies output only. These ratios compare **two fwp
variants**, with the single-function variant divided by the copied-check variant; above 1 is slower:

| Program | AMD64 elapsed ratio | ARM64 elapsed ratio |
|---|---:|---:|
| Integer loop | 1.016 | 1.000 |
| Numeric pipeline | 0.933 | 0.993 |
| Sorted map | 1.020 | 0.975 |

Separate instrumented processes recorded zero check executions for all three
numerical workloads in both variants on both hosts. Their timing differences do
not measure the cost of executing the check and do not establish a speedup or
parity with C/Rust. Instrumentation can also prevent elimination or inlining;
these counts are not ordinary machine-call profiles. This experiment records no
allocation, live-memory or RSS counters. The selection is a measured code-size
reduction, with correctness and server-memory acceptance tracked separately.

## Fixed function values in the HTTP server

A function value can store the operation to call and arguments already supplied.
Those stored arguments are its captures. The compiler avoids
rebuilding such a record when every capture is itself a fixed function with no
captures. It puts one record in program storage and initializes its addresses at
startup. Runtime strings, requests and other captured data keep ordinary owners.

This experiment compares **the same fwp HTTP server before and after that compiler
change**, using checked ARC and an ordinary native client. It does not compare
fwp with C or Rust. The [baseline profile](https://github.com/e6qu/fun-with-pipes/actions/runs/39066197415)
at `a141efd4` and [candidate profile](https://github.com/e6qu/fun-with-pipes/actions/runs/39067651911)
at `01ae40da` both pass on Linux AMD64 and ARM64. Each transport, cleartext and
TLS, uses three fresh processes at each of 1, 16 and 256 sequential `GET /hello`
requests. The client consumes and releases every response body and sums status
200; ordinary native and interpreted servers verify the same outputs.

Counters start after constant initialization and end after the main program and
cached-value cleanup. They include the stop request, timers and other background
work. The figures below subtract the 16-request median from the 256-request
median and divide by 240. Small fractional differences from background work are
rounded here; the saved artifacts keep every sample. Payload bytes exclude
allocator overhead, sockets, TLS internals and OS storage.

| Per additional HTTP request | Baseline | Candidate | Change |
|---|---:|---:|---:|
| Managed allocation requests | About 899 | About 722 | About 19.7% fewer |
| Actual reference-count increments | About 2,318 | About 1,901 | About 18.0% fewer |
| Allocations for classified fixed function records | 177 | 0 | 177 removed |
| Payload bytes for those records | 3,808 | 0 | 3,808 removed |

These results agree on both architectures and transports. Remaining calls may
still check whether a value has a count, even when no count is incremented.
Final measured managed storage stays constant across request counts: 1,792 bytes
on AMD64 and 6,144 on ARM64, in both revisions. This interval excludes constant
initialization and whole-runtime disposal; the totals are not process memory.

Static inspection of the ordinary saved ELF binaries found 331 function records,
each aligned to eight bytes, totaling 7,592 bytes on either architecture. Their
generated initialization contains 618 address stores. The net `.data` section
increase is 5,240 bytes because other emitted data also changes. The `.text`
instruction section falls from 5,260,322 to 5,171,106 bytes on AMD64 (1.7%), and
from 4,977,916 to 4,909,500 on ARM64 (1.4%). These are section sizes, not cache-miss
or elapsed-time measurements. Binaries were inspected as data, not run locally.

The [paired comparison](https://github.com/e6qu/fun-with-pipes/actions/runs/39068684995)
at `85988056` repeats those counts and rebuilds the baseline server from its saved
C on the same runner. Both servers use the same current native client, Clang
18.1.3, `-O2`, `-ffp-contract=off` (separate multiplication/addition rounding)
and no additional optimization while linking compiled files. The AMD64 runner has an AMD EPYC 7763;
ARM64 uses Neoverse-N2. The [complete report](measurements/fixed-functions-2026-10-18.json)
keeps hardware, source and binary fingerprints, all samples and scope statements.

Each transport uses six fresh processes per server version, alternating which
version runs first. After 1,024 warm-up calls, the measured client makes 8,192
calls. Elapsed time includes that client's startup, response processing, network
and server work; it excludes compilation, server startup, warm-up and shutdown.
Each sample pair produces a current/baseline ratio; the table takes the median
of those six ratios. Below 1 means the current server took less time.

| Transport | AMD64 elapsed ratio | ARM64 elapsed ratio | AMD64 startup ratio | ARM64 startup ratio |
|---|---:|---:|---:|---:|
| Cleartext | 0.936 | 0.958 | 1.009 | 1.020 |
| TLS | 0.943 | 0.950 | 0.951 | 0.983 |

These runs show about 4–6% less elapsed time for this workload. They do not
establish a general speedup or C/Rust parity. Startup measures process spawn
through the listening announcement: its medians were about 1.4–2.3 ms for
cleartext and 4.2–5.7 ms for TLS. OS, loader and listener work are included, so
these noisy startup ratios do not isolate the cost of the 618 address stores.
RSS samples after warm-up and the measured batch are retained, but are not peak
memory measurements.

The unchanged [six-host memory workload](https://github.com/e6qu/fun-with-pipes/actions/runs/39068696985)
also passes at `85988056`: Linux, macOS and Windows on both architectures.
Each host has 36 managed-memory rows, 20 persistent-server RSS samples through
20,480 calls per case, and 48 separate ownership-check rows. Final managed storage
stays constant across request counts; the largest post-warm-up RSS increase is
2 MiB, within the unchanged 8 MiB bound. Static inspection verifies actual
function-record bytes and alignment in all twelve ordinary server binaries,
including tracing controls. Linux startup instructions additionally match all
618 captured addresses. No downloaded binary was executed locally.
[PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records final production acceptance.

## Generated REST and MCP server memory

REST exposes exported functions as HTTP endpoints; MCP exposes them as tools over
HTTP or standard input. This [six-host report](measurements/server-entries-2026-10-18.json)
compares **tracing and checked ARC at the same fwp source**, `8dfc014d`, retained
by `evidence/server-entries-20261018`. All 18 memory jobs in
[the runner suite](https://github.com/e6qu/fun-with-pipes/actions/runs/39078070919)
pass. [PR #164](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164)
records the functional repairs and passing final production acceptance. These measurements contain the exact-number
JSON repair; the earlier lossy-number baseline is not equivalent work.

The [server fixture](../tests/fixtures/server_entries.fwp) copies records, returns
two aliases of a record, succeeds or raises a caught error, and supports normal
shutdown. MCP standard-input cycles produce eight replies covering these cases,
invalid arguments, malformed JSON and an unknown method; notifications produce
no reply. Runs use 1, 16 and 128 cycles. Both freeing modes finish with zero
counted bytes on every host. A deliberately non-freeing tracing control leaves
58,400, 897,680 and 7,164,304 bytes, proving that this workload detects retention.

HTTP cycles make three pooled HTTP/2 requests: copy a record, return duplicate
aliases, and raise a caught error. An ordinary native ARC client prints every
status and body; both ordinary and counted native servers must match a raw
interpreter's responses. REST runs with and without TLS encryption; MCP uses
plain HTTP. Each mode/transport/count has three fresh server processes at
1, 16 and 128 cycles, followed by a normal HTTP/1.1 shutdown request.

Counters cover startup after constant initialization through normal cleanup,
including background work and the shutdown request. Collection is disabled and
counted freeing enabled in both compared modes. The table gives the difference
between the 16- and 128-cycle samples divided by the additional replies/requests;
HTTP uses median counters. These averages are not isolated primitive costs.

| Workload | Managed allocations per additional reply/request | Reference-count increments |
|---|---:|---:|
| MCP standard input, eight-reply mix | 237.375 | 457.625 |
| REST HTTP/TLS, three-request mix | about 874.3–874.5 | about 2,426–2,427 |
| MCP HTTP, three-request mix | about 796.3–796.6 | about 1,969–1,970 |

Tracing and ARC have the same count levels, with small differences from background
work in some HTTP samples. Excluding tracing does not eliminate these allocations
or reference-count operations. Requested payload bytes, peaks and raw samples
are retained in the report. Managed counters exclude raw transport/TLS/OS storage,
allocator metadata and client memory.

Separate ordinary servers handle five batches of 1,024 cycles, or 15,360 requests
per case. A fresh client handles each batch; the 1,000-request connection limit
also exercises replacement. After the client exits and 100 ms settling, Linux
VmRSS, macOS RSS or Windows WorkingSet64 measures resident process memory. The
first sample warms caches; later samples must stay less than 8 MiB higher.
These are settled samples, not process-memory peaks.

| Host | Final managed HTTP bytes, both modes | Largest sampled increase after warm-up |
|---|---:|---:|
| Linux AMD64 | 1,792 | 2,048 KiB |
| Linux ARM64 | 6,144 | 80 KiB |
| macOS ARM64 | 640 | 128 KiB |
| macOS AMD64 | 640 | 200 KiB |
| Windows AMD64 | 1,024 | 120 KiB |
| Windows ARM64 | 896 | 0 KiB |

The report retains hardware and compiler output for every job. Builds use native
`-O2` with separate floating multiplication/addition rounding: Clang 18.1.3 on
Linux, Apple Clang 17 on macOS and LLVM-MinGW Clang 23.1.3 on Windows. No elapsed
time was measured, so this is neither a speedup claim nor a C/Rust overhead comparison.

Inspection reads all 42 saved executable files: native architecture, section sizes
and tracing symbols. All 18 ARC files exclude tracing; all 24 tracing controls
retain it. MCP uses the same executable for HTTP and standard input, so separately
saved copies can be identical. Each file's artifact path and fingerprint are
recorded. Downloaded binaries were inspected as data and never executed locally.


## WebAssembly task and browser-loader ownership

The [module report](measurements/wasm-host-owners-2026-10-18.json) covers source
`2e47a412`, retained by tag `evidence/wasm-host-names-20261018`, in
[run 39084443415](https://github.com/e6qu/fun-with-pipes/actions/runs/39084443415).
Both Linux hosts, AMD64 and ARM64, execute actual 32-bit WebAssembly modules.
The generated browser loader runs under Node. These checks establish loader
behavior in that engine; actual browser engines have not been measured here.

A task is a computation that can wait while another task runs. JavaScript Promise
Integration (JSPI) lets the engine suspend its WebAssembly execution stack. Asyncify rewrites
the module so it can save and restore that stack itself. Both mechanisms run
the same 16 rounds of task/channel operations: captured strings, repeated waits,
returned values, scoped errors, cancelled senders/receivers and task-local state.
Ordinary and measured O1/O2 modules must print the raw interpreter's results.
Each mechanism runs through both WASI and the generated browser loader.

The measured modules track actual C allocation/free calls and reference-count
entries. At shutdown, live allocations, requested bytes and count entries must
not exceed the initialized baseline. Every measured case passes. Two controls
prove that the check detects missing cleanup:

- Omitting the completed task's state snapshot leaves 16 state buffers, or
  2,048 bytes, after 16 rounds. This reproduces the repaired 128-byte-per-round
  leak. Saving the current state pointer before switching tasks lets the task's
  destructor release the right buffer.
- Omitting scheduler shutdown leaves its root record and 64 pooled 1 MiB task
  stacks: 67,109,088 extra requested bytes in these builds.

Separate checks retain output strings across sequential and concurrent calls,
start another call from an output callback, and throw from a callback while a
parent task is suspended. Exact JSON numbers and the child-task example produce
their goldens. Host exceptions, including RangeError and non-error values,
propagate unchanged without calling the failed output callback again. A tiny
recursive module separately verifies real WebAssembly stack-overflow reporting.

The report inspects 72 saved modules, including 32 deliberately broken controls.
It records byte fingerprints, exports, memory declarations, code/other sections
and producer metadata. Corresponding files are identical between the two host
architectures. Downloaded modules were inspected as data, never executed locally.

| Same task program, ordinary O2 build | Module file bytes | Code-section bytes |
|---|---:|---:|
| JSPI | 577,618 | 366,064 |
| Asyncify | 724,240 | 522,427 |

For this program, Asyncify adds about 25.4% to file size and 42.7% to the code
section. This compares two fwp execution mechanisms, with no C/Rust baseline
or elapsed-time measurement. The commands use `--target=wasm32-wasi`, O1/O2,
`-ffp-contract=off` and a 32 MiB main stack. The saved toolchain records identify
Clang 18.1.3, Binaryen 132 and Node 24.21.0. Asyncify preserves internal function
names for stack traces and binary inspection; both file sizes include names.
Producer strings inside a linked module can also name compilers used for its
libraries, so they are recorded separately from the invoking compiler.

Memory costs remain substantial. Ordinary modules declare 513 initial 64 KiB
pages, or 32.0625 MiB. The allocation ledger adds four pages (256 KiB) of static
measurement storage. A task requests 1 MiB for its C locals; at most 64 completed
stacks are pooled until command cleanup. Asyncify also grows a 16 MiB plus one
page workspace. Returning allocations to the allocator permits reuse; it does
not shrink the WebAssembly memory's capacity. These counts exclude JavaScript
continuation stacks, instances, promises and strings, and do not measure host
resident RAM. Their host engine still has its own memory management. Eliminating
remaining allocation/count traffic and reducing these storage costs remain work.

## Returning owned values to C callers

A C caller can receive a string or a record containing strings from an fwp
library and release that result explicitly. For example, `greet("c")` returns
an owned string; `fwp_release_greet(result)` releases it. A record's release
function releases all of its string fields together, including two fields that
share the same allocation. [C interop](tutorials/09-c-interop/README.md) introduces
the interface and caller obligations.

The [six-host report](measurements/library-results-2026-10-18.json) uses source
`d6d36961f532167beec8a116b35462906ba1cc6f`, retained by
`evidence/library-results-20261018`, and
[run 39090619574](https://github.com/e6qu/fun-with-pipes/actions/runs/39090619574).
All 90 focused tests pass on Linux, macOS and Windows, each on ARM64 and AMD64,
with no failures or skips. [PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records the separate passing production gate.

The measured program performs 256 repeated call batches after warmup. It reads
strings, returns aliases and records, computes a derivative (a function's slope),
and runs a function pipeline. Eight configurations per host combine static or
shared linking, C optimization levels O1/O2 and an enabled or disabled cache for
derivative temporary storage. A shared host loads, calls and unloads its library
three times. Outputs match the interpreter; all 96 shutdown observations report
zero counted bytes and zero collections. Inspection of the 24 actual ARC
libraries finds internal runtime symbols and no tracing scan/mark/sweep functions.

| Measured call | Additional retains | Intermediate record allocations |
|---|---:|---:|
| Return the copied input string unchanged | 0 | 0 |
| Return two fields sharing the copied input string | 1 | 0 |

A retain acquires another owning reference. The second call needs one because
both fields own the same string. When a compiled function already returns
separate record fields and takes whole argument values, the C entry now reuses
those fields directly. It previously allocated and unpacked a temporary record.
Other calling conventions can still allocate record boxes. Counts above exclude fresh count initialization and
release work. Input strings still copy, even for calls that only read them;
proving when those copies can be replaced by borrowing remains work.

Failure checks cover embedded NUL conversion, partial acquisition of shared
fields, traps and unload. Four deliberately broken variants per host must fail:
omitting a temporary box release, omitting a host result release, adding a record
allocation, or adding an unnecessary retain. The report verifies all 24 controls.

Separate C and Rust callers use default library mode and check the public
interface. Windows DLL export tables now include `norm`, and both saved Windows
C hosts import it from `libgeom.dll`. Before the repair, `norm` existed inside the
DLL but was omitted from its public exports; the host used Windows' different
function and returned 25 instead of 5. Explicit exports and matching Rust
LLVM-MinGW targets fix both discovered Windows interop failures.

These checks measure fwp ownership and allocations; no elapsed-time comparison
with C or Rust was collected. Counted bytes exclude allocator capacity and host
resident memory. ARC library sizes include test instrumentation; C and Rust
host sizes reflect different runtimes and static/shared linking. Reproduce the
data-only inspection with `scripts/summarize-library-results.py --artifacts DIR
--audit AUDIT --llvm-bin DIR --record-results direct --output FILE`. The collector
never executes downloaded binaries.

## Cleanup after failed map and set operations

Maps associate keys with values; sets keep distinct keys. A map callback can
fail after producing earlier values. Those partial results and temporary arrays
must be released when the error is caught, while independently held input values
remain usable. Acquiring another owning reference (a retain) or allocating storage
can also fail midway through construction.

A small fwp reproducer repeated 32 caught map callback failures. Before this
repair, counted live storage grew by 2,048 bytes after warmup, or 64 bytes per
failure. The repaired program returns to zero counted bytes. This compares two
versions of fwp; it does not compare elapsed time with C or Rust.

The [six-host report](measurements/map-failures-2026-10-18.json) records source
`af834f8c67c6c5b7d543615755feeb0a85e81c87` and
[run 39093309107](https://github.com/e6qu/fun-with-pipes/actions/runs/39093309107).
All 66 focused tests pass on Linux, macOS and Windows, each on ARM64 and AMD64,
without skips. [PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records full delivery acceptance.

Each host tests 22 operations, including conversion, insertion, removal, update,
set operations and map callbacks. Instrumentation deliberately fails each
allocation or retain in turn: 108 failure points per ordinary configuration and
110 when storage reuse verification poisons released objects. Six configurations
combine C optimization levels O1/O2 with checked ARC, stressed tracing, and
stressed tracing with reuse verification. Aliases must survive these failures.
Callbacks that change strings into integers or integers into strings must also
agree with the interpreter and clean up according to their result type.

The report inspects all 48 saved native executables as data. Their internal
runtime names are present; checked-ARC binaries exclude tracing scan/mark/sweep
functions, while tracing controls retain them. Checked-ARC callback runs report
zero counted bytes at shutdown. Removing either the partial-map owner or the
first scratch-array cleanup makes the probe fail, confirming that the test can
detect those missing releases.

Counted bytes exclude allocator capacity and process resident memory. Instrumented
binary sizes are recorded for identification, not as a code-size improvement.
No C/Rust timing comparison or claim of free reference counting follows from
these cleanup checks. Reproduce the data-only inspection with
`scripts/summarize-map-failures.py --artifacts DIR --audit AUDIT --head SOURCE
--llvm-bin DIR --output FILE`; it never executes downloaded programs.

## Building numeric maps and sets without temporary lists

A set stores distinct keys. A map stores a value for each key; when input keys
repeat, the last value survives. Here, a range supplies integers from zero up to
the input count. The mapped function takes each integer modulo 257, producing
at most 257 distinct keys. The set prints its size; the map stores the original
integers as values and prints the last value for key 5.

The [current six-host report](measurements/collection-joined-storage-2026-10-18.json)
uses source `b87009905b26071be33b93c4ecf3277265a52488` and successful evidence run
`39108116774`. It compares the **same fwp program and
compiler**, with numeric construction combining enabled and disabled through
`FWP_MAP_BUILD`. The optimized path removes the range list, mapped list and
eligible key/value tuples, and calls known functions directly. These are fwp
comparisons, not measurements of overhead relative to C or Rust.

All programs use checked ARC, native O2 and disabled tracing/reuse poisoning.
Inputs are compiled constants. Time includes process startup, construction,
the mapped function, sorting, deduplication, the final query and output;
compilation is recorded separately. Eight samples per variant use recorded
randomized order. The report retains hardware, compiler settings, all 576 elapsed
samples, allocation counts, counted storage and actual executable sizes.

For 65,536 inputs, the observed medians are:

| Native host | Set: ordinary / optimized ms | Time ratio | Map: ordinary / optimized ms | Time ratio |
|---|---:|---:|---:|---:|
| Linux AMD64 | 7.319 / 3.788 | 0.518 | 9.512 / 3.983 | 0.419 |
| Linux ARM64 | 6.728 / 2.950 | 0.438 | 9.481 / 3.334 | 0.352 |
| macOS ARM64 | 9.646 / 6.677 | 0.692 | 10.402 / 8.009 | 0.770 |
| macOS AMD64 | 16.093 / 9.119 | 0.567 | 22.236 / 11.269 | 0.507 |
| Windows AMD64 | 17.129 / 13.772 | 0.804 | 20.067 / 14.200 | 0.708 |
| Windows ARM64 | 18.052 / 14.649 | 0.812 | 19.769 / 15.203 | 0.769 |

The ratio is optimized time divided by ordinary time: 0.518 means about 48.2%
less elapsed time in that run. At 32 inputs, ratios range from 0.861 to 1.078;
every paired sample range overlaps, including apparent slowdowns. There is no
consistent small-input gain. Startup was not timed separately, and these shared-runner measurements
do not establish a universal performance threshold.

At 65,536 inputs, set allocation requests fall from 131,077 to four and map
requests from 196,614 to five. All cases have zero retains, final counted bytes
and collections. On every host, peak counted storage falls from 4,718,600 to
1,053,696 bytes for sets and from 6,815,752 to 2,102,272 for maps. These counters
measure managed storage, excluding allocator capacity and process resident
memory. Sets still store unused value slots in their final container; small
integers occupy full words, and temporary storage grows with input length.

All 78 focused tests pass without skips. The report inspects 120 actual binaries,
including deliberately broken cleanup controls. Eight generated builders undergo
all 48 allocation failure points and 64 callback error/cancellation exits per
configuration, while independent input aliases survive. A historical
[focused machine-code review](measurements/collection-set-code-2026-10-18.json)
compares the actual Linux set executables before and after direct calls.
The old loops invoke general function dispatch and access stack slots per item.
The new AMD64 loop computes four items with SIMD instructions; ARM64 computes
two with scalar instructions. Both use registers and direct key-buffer stores,
with no calls or stack accesses inside the inspected loops.

The AMD64 entry-function frame remains 216 bytes; ARM64 grows from 256 to 272
bytes. The previous extra builder frame, 120 bytes on AMD64 and 144 on ARM64,
is no longer on the known-call construction path. These frames include saved
registers and runtime startup/output work, exclude callees and the AMD64 return
address, and do not bound total stack use. Both executable files shrink by
32 bytes. General dispatch remains elsewhere; sorting, final container storage
and runtime startup still have costs. These observations apply to these
constant-input programs, not every callback or function.

The [initial optimization report](measurements/collection-build-baseline-2026-10-18.json)
at source `488d1822` and its [map-loop review](measurements/collection-build-code-2026-10-18.json)
precede the set improvements. The [set-storage report](measurements/collection-set-storage-2026-10-18.json)
at `8fcd7486` removes two unused value buffers, reducing optimized set requests
from six to four and peak counted storage from 2,102,304 to 1,053,712 bytes.
It still uses general set callback dispatch. Each earlier report separately
passes 78 tests and inspects 120 binaries. Different runs use different machines
and conditions; their absolute timings do not isolate either follow-up's speed
benefit. The current same-source comparison above includes joined map buffers and complete
byte-count guards. The [earlier direct-call report](measurements/collection-build-direct-2026-10-18.json)
preserves the source of the historical loop inspection.

### Larger maps exposed a storage-layout problem

The small construction comparison above has at most 257 distinct keys. The
maintained `map` benchmark instead constructs 500,000 distinct entries and makes
two million lookups. Keys are `(index * 7919) modulo 1000003`; input pairs are
scrambled, and construction sorts them. The program prints the completed map's
size before starting queries. The original raw report's description of "sorted
key/value pairs" refers to the resulting map, not already sorted input; its
correction is recorded alongside the preserved samples.
Its [controlled report](measurements/large-map-construction-2026-10-18.json)
compares construction combining on/off with the same compiler and runner, in
both default tracing and checked ARC. It retains all samples and actual binaries;
C and Rust run alongside complete fwp programs. Construction-only fwp programs
are separate workloads, not isolated lookup measurements.

Allocation requests for complete work fall from 1,500,009 to eight and peak
counted storage from 56,000,040 to 24,000,040 bytes. However, the first AMD64 run
shows 8.3% more complete-work time and 36.4% more construction-only time in
tracing mode. Optimized construction alternates between fast and much slower
processes, including ARC. ARM64 improves. The initial allocation improvement is
therefore insufficient evidence of acceptable performance at this size.

[Separate phase measurements](https://github.com/e6qu/fun-with-pipes/actions/runs/39103286520)
locate the variable AMD64 cost in sorting. All 32 optimized instrumented samples
fall into roughly 19–35 ms or 100–109 ms sorting groups, correlated with a bit in
the buffers' virtual addresses. Allocation and cleanup remain fast. The sorting
instructions themselves match between the original enabled/disabled executables.
This suggests a layout-sensitive cost; it does not establish a particular CPU
cache or address-translation mechanism. Instrumented timings are diagnostic and
are excluded from ordinary benchmark timings.

The repair joins related key/value lanes under one allocation owner, also for
sort scratch, without arbitrary padding. It removes two allocation requests and
keeps sorting, duplicate handling and callback order. Eight focused local tests
pass, including all allocation failures, cancellation, aliases and size-overflow
guards. The [first joined-layout performance run](measurements/large-map-storage-2026-10-18.json)
passes both Linux jobs and all
76 actual binary/sample audits. However, its AMD64 host is Intel Xeon 8573C,
whereas the original slow sorting was on AMD EPYC 9V74. Both layouts sort quickly
on this Xeon, so it cannot establish that the EPYC problem is fixed. Its full-work
tracing median is 4.6% slower with joined storage, despite construction-only
medians improving. This also remains under investigation. The new
same-run comparison reconstructs the original separate-buffer layout explicitly;
its results must justify the repair before merge. Older tables above describe
their recorded sources and must not be relabeled as measurements of this change.
Separate diagnostics compare sorting phases for both layouts and measure actual
construction and query intervals in the same full program. They preserve
evaluation order and do not infer query time by subtracting unrelated processes.

The [follow-up report](measurements/large-map-storage-phases-2026-10-18.json)
reproduces the slow original layout on AMD EPYC 9V74 and verifies that the joined
layout removes those slow sorting cases. The old layout's slow samples take
roughly 99–108 ms; joined samples take 14–22 ms, covering both address-bit values.
Full-work joined/separate medians are 0.905 in tracing and 0.768 in ARC; construction
ratios are 0.394/0.174. Query intervals remain near 273–279 ms and still include
the same reference-count requests. This isolates the large gain to construction;
it is not evidence that query overhead or the separate Xeon regression is fixed.
Both follow-up hosts and all 92 binary/sample checks pass. ARM64 construction is
stable, but its full-work ratios are 0.951 tracing and 1.069 ARC. ARC ranges overlap
widely; 14 of 24 paired rounds are slower and the median paired ratio is 1.020.
Its measured query intervals range roughly 421–502 ms. All sixteen ordinary timed
binaries, generated inputs and profiles match the earlier run byte for byte.
[Two further AMD64 repeats](measurements/large-map-storage-repeats-2026-10-18.json)
preserve another 92 audited binaries and all ordinary/phase samples. On EPYC 7763,
full-work ratios are 0.920 tracing / 0.840 ARC and construction 0.196/0.187; old
sorting again stalls while joined sorting does not. EPYC 9V45 has fast sorting
for both layouts: full-work ratios 1.007/0.990 have overlapping ranges, and
construction ratios are 0.861/0.877. Neither host answers the Xeon question.
The `map-replay` evidence suite repeats the verified executables on four AMD64
runners without rebuilding them. It checks source, hashes and architecture first,
records each actual CPU and keeps separate ordinary and diagnostic samples.
The [first four replays](measurements/large-map-replay-2026-10-18.json) all pass:
three use EPYC 7763 and one EPYC 9V74. Full-work joined/separate ratios range
0.761–0.929 in tracing and 0.770–0.928 in ARC. They confirm construction gains
on these hosts, without resolving the Xeon result.

For the complete workload, the same-run fwp/C ratios are 0.918 tracing and 0.954
ARC on EPYC, and 0.992/0.962 on ARM64. Against Rust, the ratios are 1.110/1.154
on EPYC and 1.073/1.041 on ARM64: fwp still takes 4–15% more time than Rust in
these runs. These compare complete implementations, including different sorting
and overflow guarantees; they are not an isolated language-overhead measurement.

Independent inspection of the actual AMD64 executables finds identical query and
sorting instructions after resolving address differences. Joined storage removes
384 bytes of machine code in each memory mode; the tracing cached-table frame
falls from 104 to 88 bytes, while the ARC frame remains 88 bytes. On ARM64 ARC,
code shrinks by 416 bytes and the cached-table frame falls from 112 to 96 bytes.
These are local frame sizes, not whole-program stack bounds. Code identity does
not imply identical cache placement or elapsed time.

The joined-layout six-host workflow passed all 78 semantic/ownership tests but
did not complete: Intel macOS timed out during an additional release build of
the compiler, before collecting costs. The report correctly rejected that run.
The measurement job now selects the compiler already built by its integration
tests and records its exact path/hash alongside source identity. It still builds
the measured programs at native O2; compiler generation/startup time is outside
those program timings. The 30-minute limit and all test/cost cases remain.
Replacement run `39108116774` passes all six hosts and 78 tests. Its
[report](measurements/collection-joined-storage-2026-10-18.json), collected by
`39109026750`, verifies all 120 actual binaries and allocation/cleanup counts.
The failed run remains recorded; the replacement does not relabel its result.

Two other candidates were rejected: moving integer equality outside the search
is 8–9% slower on ARM64, and separating cached initialization shows no clear
benefit while increasing code size. Neither changes production code. The large
map still performs 2,000,001 retains; reducing that cost needs its own lifetime
proof and measurement.
