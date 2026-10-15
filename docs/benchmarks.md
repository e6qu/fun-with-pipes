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

### Current tracing and ARC comparison

[The memory-mode report](measurements/numerical-memory-modes-2026-10-15.json)
records revision `49d35018` on Linux/macOS ARM64/AMD64, including processor,
compiler, build commands, forty raw timing samples per implementation and
separate allocation profiles. All four jobs in
[the evidence run](https://github.com/e6qu/fun-with-pipes/actions/runs/38782635990)
passed. Both fwp memory modes are actual checked compiler builds; ARC binaries
exclude tracing symbols. Numerical inputs and ordered arithmetic match C/Rust.

These ratios compare only the kernel: array reduction includes consuming/freeing
its input; matrix multiplication starts after output allocation and zeroing.
Allocation-inclusive time and resident memory are recorded separately. A ratio
of 2 means twice the elapsed time, or 100% extra time; 1.02 means about 2% extra.

| Host / workload | Tracing fwp / C | ARC fwp / C | ARC fwp / Rust |
|---|---:|---:|---:|
| Linux AMD64 / array | 2.63 | 1.04 | 1.03 |
| Linux ARM64 / array | 2.45 | 1.02 | 1.03 |
| macOS AMD64 / array | 1.40 | 1.39 | 2.43 |
| macOS ARM64 / array | 1.68 | 1.00 | 1.00 |
| Linux AMD64 / matrix | 1.06 | 1.10 | 0.88 |
| Linux ARM64 / matrix | 0.96 | 0.97 | 0.74 |
| macOS AMD64 / matrix | 3.62 | 3.51 | 3.69 |
| macOS ARM64 / matrix | 1.85 | 1.79 | 1.37 |

ARC brings the array kernel near C/Rust time on three hosts, but Intel macOS
still has a substantial gap. Matrix timing changes little between modes. Both
fwp modes finish with zero live charged bytes and no collections. Each eight-round
array sample allocates eight inputs, performs zero retains and releases each
input once. Matrix samples use forty fwp allocations versus twenty-four in
C/Rust because the two matrix wrapper records are also allocated each round;
they perform twenty-four retains and matching nonlast releases. These costs
remain work, not a language-wide zero-overhead result.

Linux ARM64 assembly keeps array length outside the ARC loop, while the tracing
loop reloads it. Intel macOS's timed blocked matrix loop is scalar: compiler
diagnostics identify the platform's fixed-size `memcpy` expansion as a barrier
to vectorization. A candidate uses compiler copy intrinsics and removes runtime
scheduler ticks when the program has no tasks/services. Local instruction
inspection confirms vector multiply/add and removal of that scheduler call;
full candidate validation and same-method timing are pending.

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
