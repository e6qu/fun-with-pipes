# Array and matrix kernels: recorded comparison

The current runner compares one counted fwp implementation with C and Rust.
It retains the workloads and timer boundaries described below, with thirty
uninstrumented samples per implementation: six rotating process batches of five,
so each occupies every position twice. Separate profiles record allocations,
counts, charged bytes and address-space reservation; collector counters are gone.
The paired C experiments now compare two binaries in four alternating batches
(twenty samples each). These comparisons still need new measurement runs on the
collector-free compiler. They do not revise the historical results below.

This is the 2026-10-16 experiment, not a current-revision benchmark. The protocol
and observations below are retained so its ratios have a precise meaning.

[The record-move report](numerical-record-moves-2026-10-16.json)
retains the fwp/C/Rust sample at `a3d8f16e` on Linux/macOS ARM64/AMD64,
plus a separate experiment that restores the removed ownership operations.
All four hosts pass both the [numerical run](https://github.com/e6qu/fun-with-pipes/actions/runs/38817877068)
and [paired experiment](https://github.com/e6qu/fun-with-pipes/actions/runs/38821156704).
These measurements describe that preserved source and settings; later
deliveries have separate [acceptance records](../roadmap-history.md).
Processors, compilers, flags, build commands, source hashes, raw samples and
allocation profiles are retained. Checked ARC binaries exclude tracing symbols.

These are C-hosted kernel measurements, not complete fwp command executions.
The [runner](../../scripts/measure-numerical-kernels.py) links emitted fwp functions
into a measuring harness. The [C](../../tests/fixtures/numerical_bench.c),
[Rust](../../tests/fixtures/numerical_bench.rs) and
[fwp harness](../../tests/fixtures/numerical_bench_native.c) make timer boundaries
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
batches of five samples after one warmup process per implementation. That
historical run has **four** labels: C, Rust, tracing fwp and ARC fwp; each occupies
every process-order position twice. The present GC-free runner has three labels
and six batches instead. Separate binaries
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

[The preceding memory-mode report](numerical-memory-modes-2026-10-15.json)
retains the earlier fixed-size-copy and scheduler-check changes. The
[array-borrow report](numerical-array-borrows-2026-10-15.json)
separately compares invariant array-data access with per-element lookup. These
are historical measurements, not competing current performance claims.
