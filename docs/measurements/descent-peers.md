# Derivative descent compared with explicit C and Rust

This experiment asks how much of the measured descent cost remains when a
programmer supplies the derivative, and how that program compares with C/Rust.
It is a baseline, not a new compiler optimization or a claim of zero overhead.
[All samples and inspected binaries](descent-peers-2026-10-22.json) are retained.

## Same numerical problem, four implementations

A gradient contains the objective's derivative with respect to each coordinate.
Each update subtracts 0.001 times that gradient. All four programs use the
Rosenbrock objective from [tutorial 20](../tutorials/20-autodiff-and-devices/README.md),
start from alternating −1.2/1.0 coordinates, run the same number of updates and
print the complete final vector. For example, three coordinates start at
`[-1.2, 1.0, -1.2]`; one update gives approximately `[-0.9844, 0.208, -0.76]`.
The zero-update control returns the initial vector.

| Implementation | Derivative calculation | Storage |
|---|---|---|
| fwp AD | `grad rosenbrock` records arithmetic and walks its derivative tape backwards | Immutable lists, typed owners and reusable raw tape buffers; checked ARC |
| fwp explicit | Programmer-written derivative formula | Immutable lists and intermediate pairs/lists; checked ARC |
| C explicit | The same derivative formula | Two reusable contiguous buffers |
| Rust explicit | The same derivative formula | Two reusable contiguous vectors |

The [fwp](../../tests/fixtures/descent_explicit.fwp),
[C](../../tests/fixtures/descent_explicit.c) and
[Rust](../../tests/fixtures/descent_explicit.rs) sources make those differences
visible. fwp AD versus fwp explicit measures the complete cost difference between
those program forms. fwp explicit versus C/Rust includes representation, allocation
and formatting differences. Neither ratio isolates pure compiler overhead.
C manually bounds its loops; Rust retains language bounds and overflow checks.

A separate Python derivative checks every output component with absolute and
relative tolerance 1e-10. Reverse AD can round differently from the explicit
formula. Each native fwp form must match its own unoptimized interpreter exactly;
every timed executable must repeat its own full output exactly.

## Method and results

Source `018581d6c0711b6a0eba81ed9fdb3e7c41973576`, tag
`roadmap/revision-descent-peers-018581d6c071`, passed both Linux jobs in
[run 39755925964](https://github.com/e6qu/fun-with-pipes/actions/runs/39755925964).
The hosts were AMD EPYC 9V45 and ARM Neoverse-N2, with GCC 13.3.0 and Rust 1.99.1.
All programs use O2 and no link-time optimization. C disables fast-math and fused
multiply-add; Rust uses its generic CPU target and enabled overflow checks.
Inputs and update counts are compile-time constants in every variant.

Two warmups precede 24 fresh-process samples per executable. Rotating and
reversing order gives every implementation every position equally. Times include
process startup, initialization, descent, full output and teardown. Compilation,
interpretation and memory profiles are excluded. Zero-update time includes
initialization and output; subtracting it does not establish pure computation
cost. The table gives medians in milliseconds; complete samples and compile
commands are in the linked data.

| Host | Coordinates | Updates | fwp AD ms | fwp explicit ms | C ms | Rust ms |
|---|---:|---:|---:|---:|---:|---:|
| AMD64 | 3 | 0 | 0.855 | 0.803 | 0.616 | 0.771 |
| AMD64 | 3 | 1 | 0.855 | 0.876 | 0.584 | 0.741 |
| AMD64 | 3 | 199 | 1.436 | 0.897 | 0.609 | 0.796 |
| AMD64 | 3 | 1999 | 6.047 | 1.382 | 0.587 | 0.769 |
| AMD64 | 33 | 199 | 6.708 | 1.502 | 0.598 | 0.788 |
| AMD64 | 129 | 199 | 22.867 | 4.086 | 0.641 | 0.893 |
| ARM64 | 3 | 0 | 1.090 | 1.235 | 0.744 | 0.948 |
| ARM64 | 3 | 1 | 1.236 | 1.151 | 0.807 | 1.014 |
| ARM64 | 3 | 199 | 1.972 | 1.149 | 0.725 | 0.916 |
| ARM64 | 3 | 1999 | 9.941 | 2.338 | 0.876 | 1.134 |
| ARM64 | 33 | 199 | 11.119 | 2.504 | 0.844 | 1.071 |
| ARM64 | 129 | 199 | 39.896 | 6.082 | 0.880 | 1.125 |

For 129 coordinates and 199 updates, fwp AD takes **5.60×/6.56×** the fwp
explicit time on AMD64/ARM64. Even the explicit fwp form takes **6.38×/6.91×**
C time (538%/591% extra) and **4.58×/5.40×** Rust time (358%/440% extra).
fwp AD takes 35.68×/45.36× C time, but that includes general differentiation
work that the C program does not perform. Small cases are dominated by whole-
process costs and show mixed AD/explicit ordering; they do not establish an AD
speed advantage. Hardware differs from earlier descent reports, so absolute
times across those reports must not be treated as a compiler speedup.

## Memory and what to investigate next

Both hosts report these counts for 129 coordinates and 199 updates:

| fwp form | Managed allocation requests | Requested bytes | Retains | Peak managed charge | Peak raw derivative storage |
|---|---:|---:|---:|---:|---:|
| AD | 1,103,785 | 31,360,398 | 868,436 | 26,288 | 33,904 |
| Explicit | 206,891 | 6,983,565 | 51,342 | 21,824 | 0 |

An allocation request is a call to fwp's allocation interface, not necessarily
an operating-system allocation. Managed request/retain counters start after
constant initialization and continue through program cleanup; raw counters track
tape registries, parent indices, local derivatives and adjoints. They do not
measure every process allocation. A retain adds a counted owner. Requested bytes
accumulate across the run, while a peak is storage live at one instant. Both
managed and raw ledgers reach zero after teardown, with no collections. The AD
case retains 33,904 raw bytes between updates: 104 registry bytes and 33,800 bytes
of workspace. Separate uninstrumented process-memory observations are in the
data; their peaks include other storage and must not be added to these peaks.
No C/Rust allocation-count parity is claimed.

All **72 actual native executables** were independently inspected: 48 timed
images and 24 untimed memory profiles. Source/binary hashes, architectures,
disassembly and ARC tracing-code exclusion were checked. Repeated profile
checkpoints reconstruct their original hashes exactly.

The next optimization should address intermediate numerical storage and repeated
ownership work, while preserving arithmetic order and derivative recording.
The explicit fwp control shows that removing the derivative tape alone cannot
close the measured gap. Investigate packed-array iteration alongside the list
forms, record a workload-specific acceptance budget before changing the compiler,
and repeat timing baselines before treating small differences as regressions.
This finite experiment does not settle arbitrary nesting, long-running retention
or C/Rust parity for the language.
