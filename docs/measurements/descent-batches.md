# Repeating complete numerical solves

Repeating 512 solves per process exposes a larger remaining fwp/C/Rust gap than
short process runs. In the largest case, the new fwp variant takes **9.81–12.00×
C time and 12.30–17.13× Rust time**. Removing unused call adapters changes these
timings very little. This report supports smaller code, not faster numerical work.

## What runs and what is timed

Each solve starts from alternating −1.2/1.0 coordinates, performs the stated
Rosenbrock gradient updates and prints the complete final vector. See the
[original comparison](descent-peers.md) for the objective and example output.
The [protocol](descent-batch-protocol.md) repeats the entire solve 512 times,
including input construction, allocations, output and cleanup. Runtime startup
and final teardown occur once per process. No result is cached between solves.

This compares the borrowed-capture compiler with the adapter-only compiler
`e681dc447039cd1ce5fbf4a27add9e96f9238275`, plus explicit C/Rust implementations
and byte-identical copies of both fwp binaries. All sources are rebuilt together.
Four warmups precede 48 samples per entry, using balanced six-round ordering.
The timer includes the whole process and all output; compilation and separate
instrumented memory runs are excluded. Dividing by 512 gives amortized full-solve
time, not pure arithmetic time or the startup cost of a standalone program.

The programs compute the same mathematical updates, with different work and
storage. fwp builds immutable arrays and converts lists at its input/output
boundaries; C/Rust reuse two buffers. fwp computes each coordinate independently,
so adjacent coordinates can recompute the same edge residual. C/Rust calculate
that residual once per edge and add its contributions to both coordinates.
Checked index access and formatting also differ. These ratios compare complete
implementations; they do not isolate language or compiler overhead.

[Run 39812251121](https://github.com/e6qu/fun-with-pipes/actions/runs/39812251121)
passes on both hosts at harness source
`b9ff767c5ab3642ac4bc26ae2ae6153f20560d3b`. All 96 native executable images are
independently inspected. [Raw evidence](descent-batches-2026-10-22.json) retains
samples, exact commands, sources/binary hashes, instructions, GCC frame records,
profiles and process memory. AMD64 used EPYC 7763; ARM64 used Neoverse N2. Both
used GCC 13.3.0 and Rust 1.99.1 with O2, baseline CPU settings, no fast-math or
floating contraction and no Rust LTO. AMD64 differs from the preceding short-run
EPYC 9V45 host, so absolute times across those runs are not a matched comparison.

## Every input

Ratios divide the new fwp median by the named peer: 12× C means twelve times its
elapsed time. Each identical-copy ratio divides a binary by its byte-identical
copy; both must be within 0.98–1.02 to pass the variation control. All cases except
AMD64's zero-update input pass those controls in this run. Two independent runs
on matching CPU models are required before claiming a repeatable compiler change.

| Host | Coordinates-updates | New ms/solve | New / old | Old / identical | New / identical | New / C | New / Rust |
|---|---|---:|---:|---:|---:|---:|---:|
| x86_64 | 3-0 | 0.0043 | 0.9475 | 1.0563 | 0.9594 | 1.809 | 1.172 |
| x86_64 | 3-1 | 0.0246 | 1.0013 | 1.0012 | 1.0080 | 8.559 | 5.949 |
| x86_64 | 3-199 | 0.0306 | 0.9882 | 0.9949 | 0.9991 | 5.272 | 5.551 |
| x86_64 | 3-1999 | 0.0765 | 1.0041 | 0.9893 | 1.0102 | 2.365 | 4.061 |
| x86_64 | 33-199 | 0.2705 | 0.9866 | 1.0028 | 0.9923 | 11.154 | 14.505 |
| x86_64 | 129-199 | 1.0009 | 0.9906 | 1.0040 | 1.0023 | 11.998 | 17.132 |
| aarch64 | 3-0 | 0.0038 | 1.0151 | 1.0061 | 1.0167 | 1.671 | 1.424 |
| aarch64 | 3-1 | 0.0227 | 1.0139 | 0.9950 | 1.0026 | 8.770 | 7.462 |
| aarch64 | 3-199 | 0.0292 | 1.0037 | 1.0018 | 0.9997 | 6.587 | 6.432 |
| aarch64 | 3-1999 | 0.0748 | 0.9904 | 1.0006 | 1.0000 | 3.640 | 4.627 |
| aarch64 | 33-199 | 0.2657 | 1.0027 | 0.9998 | 1.0000 | 9.707 | 10.544 |
| aarch64 | 129-199 | 0.9868 | 1.0005 | 0.9998 | 1.0000 | 9.809 | 12.301 |

The largest new/old ratios are 0.9906 on AMD64 and 1.0005 on ARM64. Smaller inputs
include slowdowns; the zero-update AMD64 result is inconclusive. Even stable
controls in one run do not establish a repeatable speed improvement.

## Storage and limits

For 512 complete 129×199 solves, both fwp variants make 235,008 managed allocation
requests for 111,065,600 requested bytes, with zero retains, a 7,200-byte managed
peak and zero final managed/raw storage or tracing collections. Requested bytes
accumulate over all solves; they are not simultaneously live memory or resident
memory. The counts equal 512 times the accepted single-solve profile.

This initial run checks peak and final storage only. The [subsequent observer](descent-observers.md) passes measurements after every
solve and controls that deliberately retain a value until exit. This run does not verify that observer or the later capture-local compiler
changes. Their acceptance is tracked in [the handoff](../development-state.md).
The remaining C/Rust gap needs investigation of computation, checked accesses,
allocation and output costs; smaller instruction sections do not resolve it.
