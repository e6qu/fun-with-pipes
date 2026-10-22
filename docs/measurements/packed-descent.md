# Descent with packed arrays instead of intermediate lists

This experiment changes the explicit-derivative fwp program to use contiguous
`Array[F64]` storage. It uses existing language features; it is not a compiler
optimization. For 129 coordinates and 199 updates, it makes **459 allocation
requests instead of 206,891**, with unchanged retain counts. It takes about
**53%/57% less time** than the list version on AMD64/ARM64, while still taking
**3.40×/3.34× C time** and **2.49×/2.76× Rust time**.
[All samples, profiles and inspected images](packed-descent-2026-10-22.json)
are retained, including the slower zero-update AMD64 result.

## What each program computes

All five programs start from alternating −1.2/1.0 coordinates, compute the
Rosenbrock gradient, subtract 0.001 times it per update and print the entire
final vector. The [first comparison](descent-peers.md) introduces the objective,
gradient and four original implementations. For three coordinates, one update
changes `[-1.2, 1.0, -1.2]` to approximately `[-0.9844, 0.208, -0.76]`.

| Program | Derivative and storage |
|---|---|
| fwp AD | Records arithmetic and reverses its derivative tape; immutable lists |
| fwp list | Explicit formula with intermediate pairs and lists |
| fwp packed | The same explicit formula, reading checked indices from an immutable packed array; one new output array per update |
| C | Explicit formula and two reused contiguous buffers |
| Rust | Explicit formula and two reused contiguous vectors |

The [packed source](../../tests/fixtures/descent_packed.fwp) uses
`packed-update-at weights index` to compute one new coordinate. `array.generate`
calls it for each index in order. `packed-descend` builds the whole next vector;
it does not mutate the input. Boundary branches omit an absent previous or next
coordinate; invalid accesses trap. The timed program converts its initial list
to an array and its final array back to a list for output, so those costs remain.

C/Rust reuse buffers while fwp creates new immutable arrays. AD performs extra
work that the explicit formulas do not. These differences, checked indexing and
formatting are part of the measured ratios; they do not isolate compiler overhead.
F64 elements already fit directly in fwp value bits, without individual boxes.

## Measurement protocol

Source `1827c3bdc427edc84e14e22efce01465799f92c6`, tag
`roadmap/revision-packed-descent-1827c3bdc427`, passes both Linux jobs in
[run 39763694417](https://github.com/e6qu/fun-with-pipes/actions/runs/39763694417).
The CPUs are AMD EPYC 7763 and ARM Neoverse-N2. Both use GCC 13.3.0 and Rust 1.99.1.
C uses O2, the baseline architecture, no fast-math or fused multiply-add; Rust
uses O2, generic CPU, checked overflow and no link-time optimization. fwp uses
checked ARC and bounded derivative-workspace reuse. Exact commands are in the data.

Two warmups precede 40 fresh-process samples per program. Rotating and reversing
all five positions balances execution order. Timing includes startup, input
construction, all updates, full output and teardown; compilation, interpretation
and profiling are excluded. Zero-update time also includes setup and printing,
so it is not a pure startup measurement. All peers are rebuilt and measured in
this run. The earlier AMD64 run used a different CPU; do not compare absolute
times across those runs as evidence of compiler improvement.

Each output agrees with an independent Python derivative within absolute/relative
1e-10 tolerance. Native fwp also matches its own unoptimized interpreter exactly;
every timed program must repeat its own complete output exactly. The original
fwp AD/list forms reproduce their previously recorded managed/raw profiles exactly.

Before measuring, repeated cases (at least 199 updates) were required to make
fewer managed allocation requests with no higher managed peak than the list form.
All cases must end with zero managed/raw charge and no collections. Both hosts
meet these requirements. No timing threshold or universal speedup was promised.

The table gives medians in milliseconds:

| Host | Coordinates | Updates | fwp AD | fwp list | fwp packed | C | Rust |
|---|---:|---:|---:|---:|---:|---:|---:|
| AMD64 | 3 | 0 | 1.222 | 1.287 | 1.410 | 0.931 | 1.121 |
| AMD64 | 3 | 1 | 1.277 | 1.317 | 1.282 | 0.878 | 1.145 |
| AMD64 | 3 | 199 | 2.393 | 1.611 | 1.303 | 0.987 | 1.244 |
| AMD64 | 3 | 1999 | 11.505 | 2.558 | 1.458 | 0.960 | 1.297 |
| AMD64 | 33 | 199 | 12.635 | 2.800 | 1.717 | 0.970 | 1.219 |
| AMD64 | 129 | 199 | 42.439 | 7.189 | 3.393 | 0.997 | 1.363 |
| ARM64 | 3 | 0 | 0.962 | 0.990 | 0.925 | 0.662 | 0.823 |
| ARM64 | 3 | 1 | 1.043 | 1.021 | 0.976 | 0.710 | 0.880 |
| ARM64 | 3 | 199 | 1.849 | 1.043 | 0.951 | 0.647 | 0.769 |
| ARM64 | 3 | 1999 | 9.621 | 1.966 | 1.143 | 0.681 | 0.853 |
| ARM64 | 33 | 199 | 10.905 | 2.222 | 1.312 | 0.667 | 0.843 |
| ARM64 | 129 | 199 | 39.727 | 5.902 | 2.564 | 0.767 | 0.930 |

Packed/list ratios range from 0.47–0.81 on AMD64 and 0.43–0.91 on ARM64 for
repeated cases. The AMD64 zero-update packed form is **9.57% slower** than its
list peer and makes extra conversion allocations. Keep this control: small
programs can spend more on setup/output than they save in numerical work.

## Memory, code size and the next cost

Both hosts reproduce these managed counts for 129 coordinates/199 updates:

| Explicit fwp form | Requests | Requested bytes | Retains | Peak managed bytes |
|---|---:|---:|---:|---:|
| List | 206,891 | 6,983,565 | 51,342 | 21,824 |
| Packed | 459 | 216,925 | 51,342 | 7,200 |

Requests count fwp allocation-interface calls, not necessarily system allocations.
Counters begin after constant initialization and end after cleanup. A retain adds
a counted owner; requested bytes accumulate, while peak bytes are storage live
at one instant. These explicit forms have no raw derivative workspace, and both
ledgers return to zero. Separate uninstrumented process-memory peaks are recorded
for every variant. They include other storage and must not be added to managed
peaks. No C/Rust allocation-count parity or stack-size reduction is claimed.

For the largest case, executable/code-section sizes in bytes are:

| Host | Program | Executable bytes | Code-section bytes |
|---|---|---:|---:|
| AMD64 | c-explicit | 16,224 | 825 |
| AMD64 | fwp-explicit | 92,312 | 49,666 |
| AMD64 | fwp-packed | 83,256 | 41,746 |
| AMD64 | rust-explicit | 4,573,744 | 263,379 |
| ARM64 | c-explicit | 70,640 | 856 |
| ARM64 | fwp-explicit | 151,144 | 47,356 |
| ARM64 | fwp-packed | 84,728 | 40,108 |
| ARM64 | rust-explicit | 4,695,040 | 235,548 |

These are whole images/code sections, including runtime and linked-library code,
not just the numerical loop. They do not measure register spills or peak stack
use. Compile-command times are retained separately. All **96 actual images**
(60 timed executables and 36 untimed profiles) were independently inspected for
architecture, source/binary hashes, disassembly and ARC tracing-code exclusion.

The next measured target is repeated ownership work around captured array reads.
In the largest case, 51,342 retains equal two per coordinate per update. Generated
C duplicates the callback's captured array for its consuming entry, then performs
another duplicate/drop around the final read. The caller already keeps the array
alive through generation. A future compiler change must prove that lifetime for
eligible callbacks, preserve failures/cancellation and keep other call sites safe.
It must not simply remove counts from unknown or escaping callbacks.

Before measuring that change, require fewer retains in the four repeated packed
cases, no additional allocation requests or higher managed peak, and zero final
charge. Recompile this packed baseline with the candidate and C/Rust peers;
report all timings and code/stack costs. These are the next acceptance requirements,
not a claim that a borrowed callback convention is already implemented.
