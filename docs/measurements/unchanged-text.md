# Avoiding copies when text stays unchanged

`"already lower" | lower` has the same bytes as its input. The compiler can
transfer the input's owner to the result instead of allocating another string.
The same applies to trimming with nothing to remove and replacement with no
match, an empty pattern or identical pattern/replacement bytes.

This change covers `lower`, `upper`, `trim`, `trim-start`, `trim-end` and `replace`.
Changed results still allocate a copy; another reference to the original keeps
its bytes. The consumed input stays protected until the result is acquired, so
failure and cancellation release it. No language syntax or implicit conversion
is added. [Primitive contracts](../primitive-ownership.md#string-transformations)
explain which argument owns the source.

## Comparison and acceptance

The [word-frequency application](../../examples/wordfreq.fwp) lowercases each
word and removes commas and periods before counting and ranking. The
[protocol](../application-acceptance.md#testing-unchanged-string-ownership) names
both inputs and sets count requirements before measurement: fewer allocation
requests/bytes, no more retains or managed peak storage, and zero final charge.

Candidate `67b684506bb4a7220ed56aec82c45a6c44b09fb0` is retained as
`roadmap/revision-owned-text-67b684506bb4`. Both Linux GCC jobs pass in
[run 39694262883](https://github.com/e6qu/fun-with-pipes/actions/runs/39694262883).
[Full data](unchanged-text-2026-10-22.json) retains all samples, inputs, commands,
hardware/compiler details and independent inspection of twelve measured binaries
and 24 ownership controls. Native O0/O2 tests compare raw/optimized interpretation,
ARC and stressed tracing. Separate missing trap/cancellation owners must fail.
WASI and final platform acceptance are tracked in the [handoff](../development-state.md).

The baseline is the saved generated C from
`74263bccf8e2e67865e1863e2c04a296a97877bb`. Both versions are compiled with the
same GCC O2 flags and disabled LTO in the same runner session. The C/Rust peers
are unchanged. Twenty-four samples after two warmups rotate and reverse six
variants: C, Rust, old/new ARC and old/new tracing. Timing covers each whole
process, including reading, computation, printing and cleanup. Compilation,
input generation, memory instrumentation and RSS sampling are separate.

The AMD64 runner is EPYC 9V74; ARM64 is Neoverse N2. Do not compare these times
directly with the [initial baseline](wordfreq.md), which ran on different runner
sessions and an older AMD CPU model. The old/new ratios below are paired within
one session. A faster fwp version still has overhead against the named peers.

| Host | Words | Old ARC ms | New ARC ms | New / old | C ms | Rust ms | New ARC / C | New ARC / Rust |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| AMD64 | 4,096 | 2.530 | 2.290 | 0.905× | 1.128 | 1.473 | 2.03× | 1.55× |
| AMD64 | 65,536 | 27.413 | 22.576 | 0.824× | 8.604 | 12.627 | 2.62× | 1.79× |
| ARM64 | 4,096 | 3.110 | 2.762 | 0.888× | 1.427 | 1.878 | 1.94× | 1.47× |
| ARM64 | 65,536 | 33.883 | 28.075 | 0.829× | 10.185 | 13.261 | 2.76× | 2.12× |

Large-case ARC medians fall about 17–18%; tracing medians fall about 20–23%.
ARC still takes **162–176% more time than C** and **79–112% more than Rust**.
The peers combine normalization into one pass, while fwp expresses three; their
layouts, allocation growth and sorting also differ. These ratios compare whole
implementations, not an isolated compiler tax. A repeat run using the same
binaries is being prepared; no general timing budget is established yet.

## Allocations, live storage and code

Both hosts and both memory modes reproduce these counts. Retains are unchanged:
8,650 for the small input and 138,250 for the large one.

| Words | Old requests | New requests | Old requested bytes | New requested bytes | Old peak managed bytes | New peak managed bytes |
|---|---:|---:|---:|---:|---:|---:|
| 4,096 | 24,865 | 15,583 | 668,304 | 490,854 | 557,064 | 487,176 |
| 65,536 | 397,353 | 248,807 | 10,692,144 | 7,852,294 | 8,912,904 | 7,794,440 |

The larger input removes 148,546 requests (about 37%), without added count
traffic. Final managed charge is zero throughout. ARC never collects. The old
tracing run collects once for the large input; the new one does not, so its timing
improvement includes avoiding that collection. Counters exclude raw buffers,
allocator metadata and stacks. Separate single-process RSS samples fall by about
1.1 MB for ARC on each host; those are not repeated retained-memory measurements.

Whole executable size is unchanged: ARC 102,240 bytes on AMD64 and 152,720 on
ARM64. Inspecting the ELF code section reveals a change hidden by file padding:
ARC `.text` falls from 48,978 to 48,338 bytes on AMD64 and 48,492 to 47,836 on
ARM64. Tracing code also shrinks, by 464 and 528 bytes respectively. Stack-frame
estimates remain to be collected; smaller code and fewer allocations alone do
not establish lower stack use.

Unchanged transformations require no new string allocation or retain at the
primitive boundary. This is a specific ownership result, not a claim that the
complete word-frequency pipeline is allocation-free. Shared inputs, changed
strings, list nodes and counting storage retain their necessary costs.
