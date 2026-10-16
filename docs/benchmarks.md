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

This accepted [PR #141 benchmark job](https://github.com/e6qu/fun-with-pipes/actions/runs/38728631817/job/116400593825)
ran on Linux AMD64 on 2026-10-15 at `f31f7b66`. Its old output rounded times to
whole milliseconds and did not record CPU/compiler versions or raw samples.
The percentages below are therefore **approximate**, calculated from those
rounded times. Treat them as an example of how to read a comparison, not a
precise hardware baseline.

That historical Rust map used `BTreeMap`. The current benchmark uses sorted
pairs to match C and fwp; do not attribute differences from this old table solely
to compiler improvements.

| Program | C | Rust | fwp | Extra fwp time versus C | Extra fwp time versus Rust |
|---|---:|---:|---:|---:|---:|
| `fib` | 15 ms | 25 ms | 11 ms | −27% | −56% |
| `loop` | 83 ms | 110 ms | 111 ms | +34% | +1% |
| `map` | 315 ms | 251 ms | 361 ms | +15% | +44% |
| `pipeline` | 28 ms | 12 ms | 13 ms | −54% | +8% |
| `strings` | 110 ms | 129 ms | 166 ms | +51% | +29% |

Use `(fwp time / baseline time − 1) × 100%`. For example, `111 / 83` is about
`1.34×`, or 34% longer than the C loop. A negative percentage means less elapsed
time. Always name the baseline: that same fwp loop is only about 1% longer than
the Rust result in this run. Do not average these percentages into a language-wide
score: the programs do different work and have different comparison limitations.

The runner writes `target/bench.md`, the GitHub job summary and a downloadable
`benchmarks` artifact. It reports both ratios and percentages, all six samples,
the source commit, OS/architecture, compiler versions and Linux/macOS CPU details.
Rotating order reduces systematic order bias, but shared-runner load still
affects results. The historical table above used the older shortest-of-three
method; it has not been relabeled as a new measurement.
Timing is reported, not used as a pass/fail
threshold. Output disagreement is a failure.

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
The handoff tracks the next controlled layout experiment; production behavior
is unchanged by that experiment.

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
next investigation attributes the much larger managed allocation count to actual
call sites rather than assuming tape layout is the dominant cost.

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
cargo test --release --test bench -- --ignored --nocapture
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
not total dynamic instruction counts or evidence about register spills. Full
platform acceptance is tracked separately in the handoff.

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
it is not a cryptographic hash. The candidate feeds those bytes directly into
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

The full fwp programs still make 12,309 / 7,173 managed requests and 12,288 / 3,072
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
