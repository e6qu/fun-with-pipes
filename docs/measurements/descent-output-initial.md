# Initial output-cost diagnostic

Seven of twelve input/host rows pass both timing controls; five are inconclusive.
The result points toward output construction as a useful optimization target,
but one run does not establish a repeatable timing conclusion. No compiler or
runtime change is measured here.

## What is compared

Each process performs 512 fresh Rosenbrock gradient-descent solves. The derivative
is an explicit formula, not automatic differentiation. Compare ordinary output
with a shared C consumer that reads every result coordinate, checks finiteness,
computes a checksum and prints once. fwp's ordinary output builds a list and text;
C/Rust format their numerical buffers directly. Input creation, arithmetic,
bounds checks, buffers and cleanup remain. The checksum adds work, so this is
neither pure arithmetic time nor an isolated measurement of formatting.

The [protocol](descent-output-protocol.md) describes the formulas, controls and
memory scopes. This initial run uses 512 solves for every input; the revised
protocol lengthens the short cases. Compilation and memory probes are excluded
from timing. Each timed result must preserve its complete output or independently
verified checksum. All observations, commands, hashes, frames and samples are in
the [raw record](descent-output-initial-2026-10-23.json).

## Observed ratios

[Run 40021659651](https://github.com/e6qu/fun-with-pipes/actions/runs/40021659651)
at `697f0ba6e01a2f24b31ab699452152c7c6e09fb3` passed both native jobs and full-log
audits. AMD64 used AMD EPYC 7763; ARM64 used Neoverse-N2. Compiler versions and
full flags are in the raw record. Both C implementations use O2, baseline CPU,
no floating contraction, no fast-math and no LTO. Rust uses O2, generic CPU,
checked integer overflow and no LTO.

A ratio of 2 means twice the peer's time, or 100% extra time. The two final
ratios compare byte-identical fwp executables in full/checksum modes. Both must
lie within 0.98–1.02; a row marked inconclusive fails that predeclared check.

| Host | Coordinates-updates | Full fwp/C | Full fwp/Rust | Checksum fwp/C | Checksum fwp/Rust | Identical full / checksum | Timing controls |
|---|---|---:|---:|---:|---:|---:|---|
| AMD64 | 3-0 | 1.91 | 1.37 | 1.54 | 1.24 | 0.9886 / 1.0630 | Inconclusive |
| AMD64 | 3-1 | 9.96 | 6.94 | 1.45 | 1.15 | 1.0040 / 0.9787 | Inconclusive |
| AMD64 | 3-199 | 6.58 | 5.52 | 1.92 | 1.66 | 1.0046 / 0.9801 | Pass |
| AMD64 | 3-1999 | 3.11 | 2.78 | 2.28 | 2.27 | 1.0077 / 0.9888 | Pass |
| AMD64 | 33-199 | 14.53 | 13.91 | 2.40 | 2.30 | 0.9986 / 1.0118 | Pass |
| AMD64 | 129-199 | 14.56 | 14.93 | 2.08 | 2.11 | 1.0025 / 1.0268 | Inconclusive |
| ARM64 | 3-0 | 1.76 | 1.57 | 1.38 | 1.12 | 0.9636 / 0.9720 | Inconclusive |
| ARM64 | 3-1 | 10.44 | 9.06 | 1.40 | 1.13 | 0.9984 / 0.9629 | Inconclusive |
| ARM64 | 3-199 | 7.44 | 6.49 | 2.26 | 2.08 | 0.9997 / 1.0056 | Pass |
| ARM64 | 3-1999 | 3.77 | 3.36 | 2.88 | 2.87 | 0.9992 / 0.9996 | Pass |
| ARM64 | 33-199 | 10.34 | 10.98 | 1.46 | 1.42 | 1.0000 / 0.9989 | Pass |
| ARM64 | 129-199 | 10.38 | 11.83 | 1.24 | 1.23 | 0.9995 / 1.0003 | Pass |

The largest ARM64 row passes its one-run controls. Its checksum fwp program takes
about 8% of its full-output time, while still taking about 1.24 times the peer
time. That difference includes removed list/text construction and added checksum
work. The largest AMD64 row fails its checksum control; keep its ratios as
inconclusive. Repeat on matching CPU models before stronger conclusions.

## What the checks establish

Independent inspection covered 338 native executable files: 109 measurement and
control files plus 60 untimed correctness files per host. The inspection checked
their actual architecture, instructions, immutable source hashes and external
consumer calls. Rust's indirect AMD64 calls were resolved through the ELF
relocations and loaded registers. ARC images exclude tracing scan/mark/sweep
code. Omitted-coordinate consumers produce different checksums.

Every instrumented solve returns fwp's managed/raw live storage and the peers'
numerical-buffer storage to zero. Missing-release controls fail at the first
checkpoint. The scopes differ: fwp observes managed values, C/Rust observe only
their numerical buffers, and process RSS covers each whole process. Instrumentation
can make allocations observable: the uninstrumented AMD64 Rust zero-update
program removes an unused buffer, while its instrumented counterpart records two.
Profile counts therefore are not allocation traces of the timed executables.

The next run uses explicit per-input repetition counts to reduce short-process
noise, preserving every failed control above. Separately, source review identifies
repeated float-to-text conversion in `runtime/fwp_rt_ops.c`; a candidate must
preserve interpreter/native text, numerical boundaries, stack costs and cleanup
and pass a paired timing protocol before being accepted as an improvement.
