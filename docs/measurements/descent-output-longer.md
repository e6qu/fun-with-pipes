# Repeated output-cost measurements

For the largest numerical input, replacing ordinary output with a consumer of
every result coordinate takes about 7.7% of the original fwp time on AMD64 and
7.9% on ARM64. Both independent runs pass the predeclared noise controls for
this input on matching CPU models. This points to output construction and float
printing as useful optimization targets; it does not measure formatting alone
or establish a compiler speed improvement.

## Programs and timing

Each solve creates its input vector, performs Rosenbrock gradient-descent updates
using explicit derivative formulas, then consumes every final coordinate. No
automatic-differentiation tape is used. Compare ordinary printing with a shared
external C consumer that checks finite values, computes a checksum and prints
one line per process. fwp ordinarily builds an output list and text; C/Rust print
their buffers directly. The checksum adds work, so this difference is not pure
arithmetic time or isolated output time. [The protocol](descent-output-protocol.md)
defines the formulas, correctness controls, flags and memory scopes.

The 3-coordinate inputs with 0 or 1 update repeat 32,768 solves per process; the
other four inputs repeat 4,096. Each executable has four warmups and 48 samples,
with balanced positions and ordered adjacent pairs inside each eight-sample
block. Timing includes process start, inputs, arithmetic, captured output and
cleanup. It excludes compilation, validation and memory observation. Every timed
output is checked. The [initial 512-solve result](descent-output-initial.md)
remains recorded, including its five inconclusive rows.

Runs [1](https://github.com/e6qu/fun-with-pipes/actions/runs/40024299907) and
[2](https://github.com/e6qu/fun-with-pipes/actions/runs/40024303916) used source
`a948b7478278a6ee8c5b81cfaf6e8272e96bf935`. Both AMD64 hosts used AMD EPYC 7763;
both ARM64 hosts used Neoverse-N2. GCC uses O2 and the architecture baseline,
without floating contraction, fast math or link-time optimization. Rust uses
O2, a generic CPU, checked overflow and no link-time optimization. Exact compiler
versions, commands, host details, all samples and binary hashes are in the
[raw record](descent-output-longer-2026-10-23.json).

## Results and remaining noise

A fwp/peer ratio of 2 means twice the elapsed time, or 100% extra time. C/Rust
reuse two numerical buffers; fwp uses immutable arrays. These ratios compare
complete implementations, not isolated language overhead. The checksum/full
column compares the two fwp variants. Both identical-copy ratios must be within
0.98–1.02; otherwise the entire row is marked inconclusive.

| Host / run | Coordinates-updates | Full fwp/C / fwp/Rust | Checksum fwp/C / fwp/Rust | Checksum/full fwp | Identical full / checksum | Controls |
|---|---|---:|---:|---:|---:|---|
| AMD64 / 1 | 3-0 | 2.88 / 1.72 | 2.22 / 2.32 | 0.071 | 0.9798 / 1.0878 | Inconclusive |
| AMD64 / 1 | 3-1 | 29.64 / 17.97 | 2.26 / 2.30 | 0.007 | 0.9938 / 1.0142 | Pass |
| AMD64 / 1 | 3-199 | 9.13 / 7.44 | 2.37 / 2.35 | 0.199 | 1.0023 / 1.0086 | Pass |
| AMD64 / 1 | 3-1999 | 3.09 / 2.82 | 2.20 / 2.24 | 0.688 | 0.9995 / 0.9976 | Pass |
| AMD64 / 1 | 33-199 | 15.52 / 15.50 | 2.29 / 2.27 | 0.082 | 0.9945 / 0.9978 | Pass |
| AMD64 / 1 | 129-199 | 13.82 / 13.51 | 1.94 / 2.01 | 0.077 | 0.9975 / 1.0018 | Pass |
| ARM64 / 1 | 3-0 | 2.22 / 2.38 | 1.92 / 2.16 | 0.064 | 1.0000 / 0.9949 | Pass |
| ARM64 / 1 | 3-1 | 26.06 / 24.81 | 2.12 / 2.25 | 0.006 | 1.0000 / 0.9966 | Pass |
| ARM64 / 1 | 3-199 | 10.26 / 9.17 | 2.85 / 2.83 | 0.193 | 0.9997 / 1.0005 | Pass |
| ARM64 / 1 | 3-1999 | 3.99 / 3.61 | 3.02 / 3.07 | 0.717 | 0.9997 / 1.0001 | Pass |
| ARM64 / 1 | 33-199 | 10.93 / 11.86 | 1.47 / 1.45 | 0.089 | 1.0000 / 0.9997 | Pass |
| ARM64 / 1 | 129-199 | 10.56 / 12.15 | 1.24 / 1.24 | 0.079 | 1.0003 / 0.9999 | Pass |
| AMD64 / 2 | 3-0 | 2.87 / 1.74 | 2.29 / 2.47 | 0.074 | 1.0048 / 0.9984 | Pass |
| AMD64 / 2 | 3-1 | 29.07 / 17.81 | 2.47 / 2.56 | 0.008 | 1.0012 / 1.0506 | Inconclusive |
| AMD64 / 2 | 3-199 | 8.95 / 7.29 | 2.34 / 2.33 | 0.197 | 0.9971 / 0.9573 | Inconclusive |
| AMD64 / 2 | 3-1999 | 3.11 / 2.83 | 2.20 / 2.24 | 0.679 | 1.0135 / 0.9852 | Pass |
| AMD64 / 2 | 33-199 | 15.46 / 15.55 | 2.29 / 2.27 | 0.082 | 0.9986 / 0.9951 | Pass |
| AMD64 / 2 | 129-199 | 13.98 / 14.42 | 1.93 / 2.01 | 0.077 | 1.0031 / 1.0001 | Pass |
| ARM64 / 2 | 3-0 | 2.22 / 2.35 | 1.86 / 2.10 | 0.065 | 0.9992 / 0.9952 | Pass |
| ARM64 / 2 | 3-1 | 25.87 / 24.73 | 2.10 / 2.24 | 0.006 | 1.0000 / 1.0083 | Pass |
| ARM64 / 2 | 3-199 | 10.18 / 9.09 | 2.83 / 2.81 | 0.193 | 1.0001 / 1.0004 | Pass |
| ARM64 / 2 | 3-1999 | 3.99 / 3.57 | 3.02 / 3.07 | 0.717 | 1.0000 / 1.0000 | Pass |
| ARM64 / 2 | 33-199 | 10.91 / 11.78 | 1.47 / 1.45 | 0.089 | 1.0001 / 1.0009 | Pass |
| ARM64 / 2 | 129-199 | 10.54 / 12.15 | 1.24 / 1.24 | 0.079 | 0.9998 / 1.0000 | Pass |

Twenty-one of twenty-four rows pass. Nine of twelve input/host pairs pass in both
runs: all ARM64 inputs and the 3-coordinate/1,999-update, 33-coordinate and
129-coordinate AMD64 inputs. AMD64 inputs 3–0, 3–1 and 3–199 each fail a control
in one run, so their repeated timing comparisons remain inconclusive. Longer
processes reduced but did not eliminate short-case noise; no threshold was relaxed.
Do not use these three pairs to set performance budgets or accept an optimization.

For the largest input, full output still takes 13.82–13.98 times C and
13.51–14.42 times Rust time on AMD64, and 10.54–10.56 times C and
12.15 times Rust time on ARM64. The checksum versions still take about 1.93/2.01
times C/Rust on AMD64 and 1.24/1.24 on ARM64. Removing ordinary output therefore
does not eliminate the remaining numerical/storage overhead.

## Memory and machine-code checks

All four jobs and their complete logs passed. Independent inspection covered
676 actual executables: 109 measurement/control files plus 60 untimed correctness
files per host/run. It checked immutable sources, architecture, instructions,
external consumer calls and absence of tracing scan/mark/sweep code in ARC images.
Consumer calls through AMD64 relocation slots and registers were resolved from
the actual executable. Complete sources, disassembly hashes, code sizes, C stack
reports and process resident-memory observations remain in the raw record.

Each instrumented solve returns managed/raw fwp storage and C/Rust numerical
buffer storage to zero. Omitted-coordinate and missing-release controls fail as
intended. For the largest input, ordinary output requests 459 managed allocations
per solve with a 7,200-byte charged peak; checksum output requests 329 with a
5,408-byte peak. Both have zero retains. These counts describe instrumented
execution, not allocation traces of the timed binaries. C/Rust's buffer-only
counts have a narrower scope; whole-process resident memory is reported separately.

The next candidate [reuses rounded float digits](float-text.md), keeping ordinary
output exactly unchanged. Its own paired comparison and correctness gates must
pass before it is accepted. This diagnostic alone does not approve that change.
