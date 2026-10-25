# Checked arithmetic in the benchmark peers

The [seven complete-program comparisons](../benchmarks.md#fwp-compared-with-c-and-rust)
compare fwp with handwritten C and Rust. Previously, most C/Rust peers did not
check signed overflow while fwp did. This preparation makes subtraction,
multiplication and accumulated sums explicit checked operations in all three.
It changes the comparison programs, not the fwp compiler or runtime.

## Contract and remaining differences

The inputs and expected outputs are unchanged. C uses overflow builtins with
`-std=c11 -O2 -ffp-contract=off`; Rust uses `checked_*` with
`--edition=2021 -O`. fwp uses checked ARC, `-O2` and `FWP_LTO=0`.
Fixed loop bounds keep index increments in range. `range-set` deliberately uses
wrapping unsigned hash multiplication; that is part of its algorithm.

For example, the loop's state is an index and an accumulated sum. Each iteration
first subtracts one from the index, then multiplies the old index by three,
then adds its remainder modulo seven to the sum. At the minimum signed integer,
subtraction must fail before multiplication runs. At index zero the loop stops,
including when the sum is already the maximum signed integer.

Sorting algorithms, array/vector construction and text formatting still differ.
Matching arithmetic does not make these identical implementations or isolate
language overhead. C exits and Rust panics on overflow; their diagnostics and
cleanup paths differ. Successful fixed-input timing does not measure those paths.
No timing improvement to fwp can be inferred from making a peer slower.

## Checks and measurements

[`check-benchmark-peers.py`](../../scripts/check-benchmark-peers.py) extracts the
actual C/Rust loop bodies, compiles them at the comparison settings and supplies
51 dynamic inputs around the signed boundaries. An arbitrary-precision integer
oracle checks results and which operation fails first. Removing each of the
three checks must be detected: six broken programs alongside two ordinary ones.
These derived executables are saved but never included in timing samples.
This tests the loop body, not every possible execution of every benchmark.

The C map and pipeline now reject failed allocations. The pipeline releases its
first buffer if allocation of the second fails. Three further derived programs
inject those failures and track outstanding buffers; deliberately removing that
release must leave one buffer and fail the check. This is a cleanup test, not a
whole-process allocation measurement.

Both native Linux architectures must run these controls and all seven output
comparisons. Each complete program gets one warmup and six rotating elapsed
samples. Process startup, input construction, computation, storage and output
are timed; compilation is recorded separately. Three additional runs measure
peak resident memory. Separate fwp images measure managed storage and detect
intentional leaks; their times are excluded. Preserve actual executables,
compiler/CPU metadata, all samples, source hashes and independent binary reviews.

## Native Linux results

Source `31ee015e943517e9e3e24714001a6f2f616a01b7` passes
[run 40084725349](https://github.com/e6qu/fun-with-pipes/actions/runs/40084725349)
on AMD64 (AMD EPYC 9V45) and ARM64 (Neoverse-N2), using GCC 13.3.0 and
Rust 1.99.1. Both complete logs are clean. Independent review covers 92 actual
executables: 42 timed, 28 managed-storage and 22 peer-control images. Every
missing-check, missing-cleanup, leak and corrupted-artifact control is detected.
[PR #210](../roadmap-history.md#collection-cleanup-and-interpreter-shutdown-pr-210) subsequently passed all nine production jobs and documentation.
The user merged it before independent final-head binary review was completed;
the focused reviews above do not claim that missing final review.

These are one session per architecture, with the inputs and timing scope above.
Times are milliseconds. Extra time is `(fwp / peer - 1) × 100%`; negative means
less time. It includes algorithm and runtime differences, not isolated language
cost. [Raw results](checked-peers-2026-10-24.json) preserve all samples, compiler
metadata, binary hashes, sizes, build times and separate memory records.

| Host | Program | C ms | Rust ms | fwp ms | Extra versus C | Extra versus Rust |
|---|---|---:|---:|---:|---:|---:|
| AMD64 | fib | 33.540 | 33.381 | 9.541 | -71.6% | -71.4% |
| AMD64 | loop | 81.851 | 66.535 | 82.432 | +0.7% | +23.9% |
| AMD64 | map | 294.432 | 257.725 | 265.021 | -10.0% | +2.8% |
| AMD64 | pipeline | 14.262 | 12.211 | 8.696 | -39.0% | -28.8% |
| AMD64 | range-set | 9.516 | 9.575 | 9.561 | +0.5% | -0.1% |
| AMD64 | strings | 78.232 | 93.092 | 4.520 | -94.2% | -95.1% |
| AMD64 | text-length | 2.617 | 4.501 | 4.145 | +58.4% | -7.9% |
| ARM64 | fib | 33.830 | 31.249 | 6.843 | -79.8% | -78.1% |
| ARM64 | loop | 175.728 | 113.895 | 130.611 | -25.7% | +14.7% |
| ARM64 | map | 503.888 | 461.074 | 461.456 | -8.4% | +0.1% |
| ARM64 | pipeline | 27.382 | 22.368 | 15.770 | -42.4% | -29.5% |
| ARM64 | range-set | 10.448 | 10.403 | 10.898 | +4.3% | +4.8% |
| ARM64 | strings | 143.587 | 145.226 | 6.252 | -95.6% | -95.7% |
| ARM64 | text-length | 3.095 | 5.641 | 6.000 | +93.9% | +6.4% |

The loop remains 24% slower than Rust on AMD64 and 15% on ARM64. Direct
character counting remains 58%/94% slower than C. The map is within about 3%
of Rust in these sessions, which is not proof of parity across machines or
inputs. The large `strings` advantage comes from fwp eliminating formatting;
`text-length` is the closer comparison. AMD64 pipeline samples span
7.529–14.364 ms, so its median alone is insufficient for a small-change claim.

## Storage and code size

Managed measurements begin after constant initialization and include language
cleanup. On both hosts the map makes four requests totaling 24,000,032 bytes,
with one retain, 16,000,008 peak charged bytes and zero final charge. The set
makes one 8,000,008-byte request; the other five programs make zero managed
requests in that interval. All seven finish at zero additional managed charge.
This excludes raw buffers, stacks, allocator metadata and process startup.

Peak process RSS is the median of three separate runs, in KiB. `C / Rust / fwp`
code bytes are the timed executables' `.text` section sizes; they include
runtime code and section padding. They are not just the calculation loop.

| Host | Program | C RSS | Rust RSS | fwp RSS | Code bytes C / Rust / fwp |
|---|---|---:|---:|---:|---|
| AMD64 | fib | 1640 | 2232 | 1972 | 372 / 242115 / 7954 |
| AMD64 | loop | 1640 | 2024 | 1980 | 473 / 242131 / 11714 |
| AMD64 | map | 16860 | 9840 | 19420 | 665 / 246275 / 14306 |
| AMD64 | pipeline | 14816 | 9872 | 1980 | 489 / 242435 / 12578 |
| AMD64 | range-set | 9424 | 9820 | 10532 | 409 / 242147 / 9746 |
| AMD64 | strings | 1640 | 2156 | 1784 | 425 / 243027 / 12530 |
| AMD64 | text-length | 1640 | 2152 | 1784 | 585 / 242195 / 12530 |
| ARM64 | fib | 1316 | 1688 | 1392 | 436 / 218844 / 7212 |
| ARM64 | loop | 1380 | 1688 | 1648 | 600 / 218780 / 11036 |
| ARM64 | map | 16476 | 9504 | 18168 | 760 / 222508 / 13612 |
| ARM64 | pipeline | 13024 | 9612 | 1652 | 600 / 219036 / 11964 |
| ARM64 | range-set | 9124 | 9316 | 9584 | 536 / 218620 / 9052 |
| ARM64 | strings | 1380 | 1688 | 1396 | 536 / 219740 / 11836 |
| ARM64 | text-length | 1372 | 1684 | 1396 | 600 / 218876 / 11836 |

The raw report also retains compiler stack reports for the separate instrumented
fwp images. They describe individual frames, not maximum stack use, and do not
establish the frames of the original timed executables. C/Rust allocation counts
and full stack high-water marks were not measured.

The [earlier ARC comparison](arc-comparison.md) retains its original peer sources
and arithmetic rules. No fwp compiler/runtime change occurred in this preparation;
different hosts, sessions and peer checks prevent a before/after speedup claim.
The next [ordered-sort experiment](map-order-protocol.md) uses same-session
fwp baselines, identical-copy controls and predeclared acceptance thresholds.
