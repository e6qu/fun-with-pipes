# Checking memory after every solve

A program can release everything at exit while retaining unnecessary storage
between requests. This check observes storage after each of 512 complete numerical
solves. Both managed values and raw derivative storage must be empty at every
checkpoint, before the next solve starts.

[Run 39816523757](https://github.com/e6qu/fun-with-pipes/actions/runs/39816523757)
passes on Linux AMD64 and ARM64. Every checkpoint is zero for both fwp variants
and all six inputs. All 104 executable images were independently inspected,
including eight deliberately delayed-release controls. The
[raw evidence](descent-observers-2026-10-22.json) preserves every observation,
output/source/binary hash, sample, command, instruction and frame record.

The largest-case machine code also retains the repeated work. C and Rust place
input allocation, numerical updates, output and deallocation inside the outer
512-solve loop. fwp calls its complete numerical entry 512 times; AMD64 unrolls
two calls per loop iteration. Saved instruction excerpts and Rust allocation
relocations establish that these loops recompute the result rather than reprint
one cached result.

## Why the negative controls matter

For 33 coordinates and 199 updates, each compiler has two extra executables.
Both allocate an owned string before the loop and release it at final cleanup.
The observed version exits with status 225 immediately after the first solve,
because that string is still live. The final-only version completes all 512
solves and reports zero final storage. It demonstrates the hole in a final-only
check; it is an expected passing control, not accepted lifetime behavior.

The largest case retains the initial run's exact profile: 235,008 allocation
requests, 111,065,600 requested bytes, zero retains and collections, and a
7,200-byte managed peak. Raw storage is zero throughout this explicit derivative
program. This does not establish bounded memory for arbitrary autodiff graphs.

## Timing remains a separate question

The [protocol](descent-batch-protocol.md) preserves the initial comparison's
512 fresh solves, full output, four warmups and 48 balanced samples. Observers
and negative controls are excluded from timing. It rebuilds the saved adapter-only
compiler output, **not** the later callback-local compiler. The
[initial report](descent-batches.md) explains the mathematical work, buffer,
checked-access and formatting differences. These ratios compare complete
implementations, not isolated language overhead.

AMD64 used EPYC 7763 and ARM64 used Neoverse N2, matching the initial repeated
run's CPU models. Both use GCC 13.3.0
and Rust 1.99.1 at O2 with baseline CPU settings, no fast-math, no floating
contraction and no Rust LTO. Ratios divide the new median by the named peer.
Both identical-copy controls must be within 0.98–1.02.

| Host | Coordinates-updates | New / old | Old / identical | New / identical | New / C | New / Rust |
|---|---|---:|---:|---:|---:|---:|
| x86_64 | 3-0 | 1.2053 | 0.9444 | 0.9961 | 2.097 | 1.358 |
| x86_64 | 3-1 | 0.9883 | 1.0053 | 0.9932 | 9.681 | 6.651 |
| x86_64 | 3-199 | 0.9969 | 0.9908 | 1.0130 | 5.837 | 6.265 |
| x86_64 | 3-1999 | 1.0054 | 0.9341 | 0.9863 | 2.401 | 4.144 |
| x86_64 | 33-199 | 0.9950 | 1.0049 | 0.9991 | 11.511 | 15.020 |
| x86_64 | 129-199 | 0.9899 | 0.9983 | 0.9971 | 12.048 | 17.345 |
| aarch64 | 3-0 | 0.9715 | 1.0251 | 1.0002 | 1.655 | 1.460 |
| aarch64 | 3-1 | 1.0123 | 0.9997 | 0.9982 | 9.871 | 8.480 |
| aarch64 | 3-199 | 1.0069 | 0.9982 | 1.0018 | 6.920 | 6.885 |
| aarch64 | 3-1999 | 0.9907 | 1.0003 | 1.0005 | 3.668 | 4.693 |
| aarch64 | 33-199 | 1.0024 | 1.0000 | 0.9998 | 9.702 | 10.608 |
| aarch64 | 129-199 | 1.0004 | 1.0000 | 1.0001 | 9.820 | 12.333 |

AMD64's 3×0 and 3×1999 inputs and ARM64's 3×0 input fail the timing controls.
The largest ARM64 new/old ratio is effectively unchanged in both independent
runs; AMD64 is about 1% lower in both, comparable to its control variation.
These results do not establish a useful speed improvement from the adapter-only change.
The remaining computation, bounds-check, allocation and output costs need
separate measurements; these observer results establish cleanup, not speed.
