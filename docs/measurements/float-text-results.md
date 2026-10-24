# Float printing: repeated results

Reusing already-rounded digits passes the predeclared speed screen for the largest
numerical descent input on both Linux architectures: at least 5% less elapsed
time in two independent runs on matching CPU models, with both identical-copy
controls within 2%. This is an improvement over the previous fwp formatter.
The complete programs still take substantially longer than their C/Rust peers.

The [protocol](float-text.md) explains the optimization and every measured input.
Each solve creates a vector, applies explicit gradient formulas, and prints every
result. It does not build an automatic-differentiation tape. Only the formatter
body differs between the old and new fwp binaries; their output must match the
raw interpreter byte for byte. C/Rust use equivalent formulas and reuse buffers,
but use their own float printers. Ratios compare complete implementations.

Timing includes process start, input creation, arithmetic, captured output and
cleanup. It excludes compilation, correctness checks and separate memory probes.
Each program has four warmups and 48 samples. The two shortest inputs repeat
32,768 solves per process; other inputs repeat 4,096. GCC uses O2 and baseline
architecture instructions without fast math, floating contraction or link-time
optimization. Rust uses O2, a generic CPU, checked overflow and no link-time
optimization. The [raw record](float-text-2026-10-24.json) preserves exact commands,
compiler versions, CPU descriptions, every sample and binary hashes.

## Elapsed time and noise

The largest input has 129 coordinates and 199 updates per solve. Times below are
median milliseconds for the complete 4,096-solve process. Reduction compares the
new formatter with the previous formatter, not with C or Rust.

| Host / CPU / run | Previous fwp ms | New fwp ms | C ms | Rust ms | Reduction |
|---|---:|---:|---:|---:|---:|
| AMD64 / 9V74 / 1 | 2752.67 | 1958.43 | 206.84 | 196.86 | 28.9% |
| ARM64 / Neoverse-N2 / 1 | 3910.62 | 2658.34 | 373.17 | 322.45 | 32.0% |
| AMD64 / 7763 / 2 | 3913.78 | 2846.79 | 281.96 | 267.29 | 27.3% |
| ARM64 / Neoverse-N2 / 2 | 3911.14 | 2659.34 | 373.60 | 323.99 | 32.0% |
| AMD64 / 7763 / 3 | 3894.83 | 2836.02 | 279.63 | 253.20 | 27.2% |

Runs [1](https://github.com/e6qu/fun-with-pipes/actions/runs/40027402138) and
[2](https://github.com/e6qu/fun-with-pipes/actions/runs/40027406689) initially used
different AMD64 models. Run [3](https://github.com/e6qu/fun-with-pipes/actions/runs/40032008445)
repeats only AMD64; the matching pair below determines repeated acceptance.
All unmatched results remain reported. ARM64 uses Neoverse-N2 in both runs.

- AMD64: AMD EPYC 7763 64-Core Processor, runs 40027406689, 40032008445.
- ARM64: Neoverse-N2, runs 40027402138, 40027406689.

Input labels are coordinates–updates. New/previous below 1 means less elapsed
time. For example, 0.70 means 30% less time. A fwp/C ratio of 9 means nine times
the elapsed time, or 800% extra time. Copy ratios compare byte-identical binaries;
either ratio outside 0.98–1.02 makes that row inconclusive.

| Host / CPU / run | Input | New/previous | New/previous copy ratios | New fwp / C, Rust | Noise controls |
|---|---|---:|---:|---:|---|
| AMD64 / 9V74 / 1 | 3-0 | 0.9128 | 0.9894 / 0.9969 | 2.55 / 1.15 | Pass |
| AMD64 / 9V74 / 1 | 3-1 | 0.6749 | 0.9943 / 1.0008 | 18.05 / 9.03 | Pass |
| AMD64 / 9V74 / 1 | 3-199 | 0.7588 | 0.9865 / 0.9953 | 5.97 / 4.56 | Pass |
| AMD64 / 9V74 / 1 | 3-1999 | 0.9192 | 0.9982 / 1.0016 | 2.58 / 2.34 | Pass |
| AMD64 / 9V74 / 1 | 33-199 | 0.7221 | 0.9997 / 1.0006 | 10.22 / 10.13 | Pass |
| AMD64 / 9V74 / 1 | 129-199 | 0.7115 | 1.0007 / 0.9998 | 9.47 / 9.95 | Pass |
| ARM64 / Neoverse-N2 / 1 | 3-0 | 0.9042 | 1.0000 / 1.0006 | 2.01 / 2.11 | Pass |
| ARM64 / Neoverse-N2 / 1 | 3-1 | 0.6764 | 0.9994 / 1.0001 | 17.53 / 16.68 | Pass |
| ARM64 / Neoverse-N2 / 1 | 3-199 | 0.7328 | 1.0000 / 1.0004 | 7.48 / 6.56 | Pass |
| ARM64 / Neoverse-N2 / 1 | 3-1999 | 0.9081 | 1.0001 / 1.0001 | 3.62 / 3.25 | Pass |
| ARM64 / Neoverse-N2 / 1 | 33-199 | 0.6824 | 1.0001 / 1.0000 | 7.45 / 8.05 | Pass |
| ARM64 / Neoverse-N2 / 1 | 129-199 | 0.6798 | 1.0004 / 1.0001 | 7.12 / 8.24 | Pass |
| AMD64 / 7763 / 2 | 3-0 | 0.9378 | 0.9818 / 0.9912 | 2.73 / 1.65 | Pass |
| AMD64 / 7763 / 2 | 3-1 | 0.7189 | 1.0062 / 0.9995 | 21.42 / 13.01 | Pass |
| AMD64 / 7763 / 2 | 3-199 | 0.7681 | 0.9962 / 1.0036 | 6.98 / 5.71 | Pass |
| AMD64 / 7763 / 2 | 3-1999 | 0.9111 | 0.9947 / 0.9895 | 2.81 / 2.55 | Pass |
| AMD64 / 7763 / 2 | 33-199 | 0.7365 | 0.9994 / 0.9949 | 11.50 / 12.00 | Pass |
| AMD64 / 7763 / 2 | 129-199 | 0.7274 | 0.9995 / 1.0007 | 10.10 / 10.65 | Pass |
| ARM64 / Neoverse-N2 / 2 | 3-0 | 0.9087 | 1.0031 / 1.0009 | 2.01 / 2.09 | Pass |
| ARM64 / Neoverse-N2 / 2 | 3-1 | 0.6767 | 1.0000 / 1.0000 | 17.49 / 16.12 | Pass |
| ARM64 / Neoverse-N2 / 2 | 3-199 | 0.7333 | 0.9998 / 0.9996 | 7.43 / 6.35 | Pass |
| ARM64 / Neoverse-N2 / 2 | 3-1999 | 0.9082 | 1.0001 / 0.9999 | 3.62 / 3.24 | Pass |
| ARM64 / Neoverse-N2 / 2 | 33-199 | 0.6823 | 1.0001 / 1.0003 | 7.44 / 8.03 | Pass |
| ARM64 / Neoverse-N2 / 2 | 129-199 | 0.6799 | 1.0004 / 0.9997 | 7.12 / 8.21 | Pass |
| AMD64 / 7763 / 3 | 3-0 | 0.9514 | 1.0033 / 0.9927 | 2.80 / 1.65 | Pass |
| AMD64 / 7763 / 3 | 3-1 | 0.7160 | 0.9963 / 1.0036 | 21.71 / 12.84 | Pass |
| AMD64 / 7763 / 3 | 3-199 | 0.8325 | 1.0813 / 1.0018 | 7.59 / 6.11 | Inconclusive |
| AMD64 / 7763 / 3 | 3-1999 | 0.8897 | 0.9882 / 1.0209 | 2.80 / 2.54 | Inconclusive |
| AMD64 / 7763 / 3 | 33-199 | 0.7354 | 1.0053 / 1.0001 | 11.54 / 12.02 | Pass |
| AMD64 / 7763 / 3 | 129-199 | 0.7281 | 0.9990 / 1.0012 | 10.14 / 11.20 | Pass |

The third run has two inconclusive smaller AMD64 rows. For 3–199, the new
binary and its identical copy differ by 8.13%; for 3–1,999, the previous binary
and its copy differ by 2.09%. These exceed the fixed 2% limit. Do not use their
apparent gains as repeated evidence or set budgets from them. The largest case
passes in both matching runs. The 3–0 row passes its noise controls and measures
4.9% less time in run 3; the 5% acceptance target applies to the largest case.

## Storage, stack and machine code

The formatter adds no heap storage. Separate instrumentation observes unchanged
fwp allocation counts and live storage for both versions. The largest case makes
459 managed allocation requests per solve, no retains, and reaches 7,200 charged
managed bytes. Every solve ends with zero managed and raw derivative bytes.
C/Rust observations cover their numerical buffers; fwp observations cover its
managed values and derivative storage. Instrumentation can prevent allocation
elimination, and these scopes exclude library-private allocations. They are not
allocation traces of the timed executables. Whole-process resident memory is
recorded separately for every executable.

GCC reports a formatter frame increase from 224 to 256 bytes on AMD64 (bounded
dynamic use) and 208 to 288 bytes on ARM64 (static). Writer frames stay at 720/704
bytes. Largest-program instruction bytes grow 33,010→33,826 and 30,972→31,516.
AMD64 executable size stays 69,184 bytes; ARM64 changes 82,904→82,896 bytes despite
more instruction bytes, because total file size includes alignment and metadata.
Actual disassembly and compiler frame records were reviewed. Individual frame
sizes do not establish total maximum call-stack use. Local Clang ARM64 separately
reports a 240→288-byte formatter frame.

Six native correctness jobs pass at `550ef3157720`, including ordinary/JSON output,
rounding directions, both memory modes and deliberate digit/boundary corruption.
The initial Windows run exposed a summary assertion that required LF instead of
accepting its CRLF line ending; the repaired harness passes on both native Windows
hosts. The first mixed workflow therefore remains failed, although its two timing
jobs passed. Separate repaired correctness evidence preserves that distinction.

Independent inspection checked 72 native correctness images and 600 timing/control
images, including actual architecture, instructions, immutable sources and absence
of tracing scan/mark/sweep code from ARC binaries. Counts describe saved outcomes,
not 672 distinct source programs. The runtime and benchmark sources are identical
across the measurement commits; the later commit only repairs test reporting and
permits selecting the one host that needs repetition. Final delivery still needs
its own complete production matrix and documentation audit.
