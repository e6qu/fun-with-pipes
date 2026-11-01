# Where the comparison programs allocate

The ordinary [Swift comparison](swift-peers.md) measures elapsed time and peak
resident memory (RSS). RSS includes code, stacks and runtime pages; it cannot
show how many objects a program allocates. This separate profile answers that
question at the **native allocator** boundary, with separate fwp managed-heap
counters. Both native architectures pass the observer controls; the results
below describe allocation traffic, not elapsed time or individual ARC operations.

The Linux profiler [heaptrack](https://github.com/KDE/heaptrack) records allocation
calls and their call stacks. Swift's [allocation guide](https://www.swift.org/documentation/server/guides/allocations.html)
explains the connection between Swift object allocation and the native allocator.
A call stack identifies the chain of functions that requested storage. It does
not count every reference-count increment or decrement.

## Programs and measurement scope

Use the existing `bench/pipeline` and `bench/map` sources, in fwp, Swift, C and
Rust. Keep both profiling runs for each language on native Linux ARM64 and AMD64.
Do not time these instrumented runs or present their duration as normal speed.

| Program | Input and work | Differences that affect the comparison |
|---|---|---|
| Pipeline | Twenty rounds over one million integers: multiply by three, select even results, sum | Swift/Rust build eager collections each round; C reuses two arrays across rounds; fwp may fuse the stages |
| Ordered map | Build 500,000 key/value pairs and perform two million searches | Retain each peer's actual representation and sorting/lookup implementation; allocator traffic is not an isolated ARC cost |

Build optimized programs with the ordinary comparison's flags, plus debug
information for source attribution: GCC O2, no fast math or contraction, no LTO;
Swift `-O -whole-module-optimization`; Rust `-O`, no LTO. Specify native target
and baseline CPU explicitly. Record source, compiler, CPU, package versions and
binary hashes. Require equal output from all four implementations before profiling.

Each whole-process profile includes startup, the calculation, printing and
shutdown. Retain the compressed trace, complete command output, allocation stacks
and these three exact stack sums:

- **Allocation calls:** calls observed at the allocator boundary. These are not
  fwp managed-object requests; a pool can serve many objects from one allocation.
  Direct `mmap` storage, including fwp’s managed heap, is outside this boundary.
- **Peak heap bytes:** requested bytes live at the process's maximum tracked heap
  use. This excludes allocator metadata and is different from RSS. Stack entries
  partition that global peak; do not sum separate per-function peak times.
- **Unfreed exit bytes:** tracked bytes still allocated when the process exits.
  Runtime caches may remain here; the label alone does not prove a program leak.

For fwp, also run the existing managed request/byte/retain observer twice. It
starts after constants initialize and ends before runtime teardown; require zero
final charge and repeatable counts. Report these separately from native allocator
traffic. Neither peak includes all process memory; never add peaks sampled at
different times or describe fwp's malloc-only total as its complete heap use.

Preserve both native observations even if their counts differ. Report the responsible
stacks and explain representation/algorithm differences before claiming a cause.
The top ten stacks are a summary; the raw trace and complete stack tables remain
available. No timing acceptance follows from these profiles, and they do not
settle the older [closure construction regressions](callable-phases.md).

## Controls and reproduction

Before profiling the peers, a C control makes three independently visible
allocations of 1 MiB, 1 MiB + 1 and 1 MiB + 2 bytes. All three coexist. Require
three calls and exactly 3,145,731 bytes at their peak. Normal execution frees all;
a deliberately omitted final release must leave exactly 1,048,578 bytes attributed
to that control. Missing allocations or a hidden omitted release fail the job.
The report reader also rejects incomplete stacks and inconsistent summary counts.

Dispatch `swift-allocations` in `.github/workflows/numerics.yml`. The runner uses
`scripts/profile-swift-allocations.py collect`, then `audit`. Auditing verifies
every retained file hash, recomputes totals from stacks, checks both controls and
compares benchmark sources with the recorded Git commit. It never executes the
retained binaries. The protocol is part of [measurement requirements](../../PLAN.md).

## Profiler verification

Run `41253559042` at `9a2e954e` passes the controls and all profiles on AMD64.
ARM64 records the allocation sizes but no instruction addresses: every stack is
`??`, so attribution fails before any peer result is accepted. This is a failed
observer control, not evidence about fwp or Swift ownership.

Run `41254571983` at `a33c8ba9` passes both architectures after pinning GNU
libunwind 1.8.3 by release SHA-256. It records the linked
library and compares direct `unw_backtrace`/`unw_step` probes against the system
library on the same host. It retains syscall diagnostics and both observations.
Only the explicitly selected library is used for profiles; no failed profile
switches automatically to another observer.

Both allocation/release controls
pass. The standalone unwinding probes also pass with the old system library,
so they do not reproduce heaptrack's missing-frame failure. At `9d47a5fc`, run `41256208614` compares full heaptrack controls with both
libraries on each host. AMD64 passes with both. ARM64 again loses the control
stack with the system library, while the selected library reports all three
allocations and the deliberately unfreed 1,048,578 bytes.

This reproduces the
integration problem but does not identify a particular upstream defect. Unneeded
core-dump, remote-process and setjmp observer libraries are excluded from this
build; they are unrelated to in-process allocation tracing. Their implementation
warnings no longer appear.

## Observed allocations

At `a33c8ba9`, both samples on each architecture agree. The hosts are Intel
Xeon 6973P-C and ARM Neoverse-N2, with GCC 13.3, Rust 1.99.1, Swift 6.4.2,
heaptrack 1.5.0 and the selected libunwind 1.8.3. These are allocation profiles,
not new timing results; use [the ordinary measurements](swift-peers.md) for elapsed
time and RSS with their recorded source/hosts.

| Program | Language | Native allocation calls | Peak tracked bytes, AMD64 | Unfreed exit bytes, AMD64 |
|---|---|---:|---:|---:|
| Pipeline | C | 4 | 16,077,824 | 4,096 |
| Pipeline | Rust | 31 | 8,074,276 | 548 |
| Pipeline | Swift | 460 | 14,563,007 | 5,551 |
| Pipeline | fwp | 3 | 78,160 | 4,096 |
| Ordered map | C | 4 | 16,073,728 | 4,096 |
| Ordered map | Rust | 12 | 8,075,300 | 548 |
| Ordered map | Swift | 85 | 12,075,743 | 8,005,815 |
| Ordered map | fwp | 6 | 80,209 | 6,145 |

ARM64 has the same call counts. Swift peak/exit totals are eight bytes larger
for the pipeline and 24 bytes larger for the map; the other totals match.

fwp's separate managed observer reports zero requests, bytes or retains for the
fused pipeline. For the map it reports four requests, 24,000,032 requested bytes,
one retain, 16,000,008 peak charged bytes and zero final bytes. **The native fwp
columns omit this storage.** The map therefore does not use only 80 KB, and fewer
allocation calls do not imply lower peak memory than Swift. Do not add the two
independently sampled peaks.

The largest Swift pipeline stack accounts for 360 array-buffer growth allocations;
two further array-buffer stacks account for twenty each. Rust's largest pipeline
stack accounts for twenty vector allocations; consuming filtering can reuse the
mapped vector's capacity. C allocates its reusable work buffers once.

These
algorithm/collection choices explain much of the traffic difference; they do
not measure the cost of one ARC retain/release. Swift's map stores its table in
a top-level variable; the roughly 8 MB still present at process exit must not be
called a demonstrated leak. The independent omitted-release control verifies
the observer's ability to detect a deliberately unreleased allocation.

## Retained evidence

The [raw archive](swift-allocations-2026-11-01.tar.xz) contains both architectures,
all command/output records, generated sources, binaries, allocation stacks,
compressed heaptrack traces, managed-heap profiles and both unwinder controls.
Measured source: `9d47a5fcfb5c9342d9fca9da2a8c162f5ac1d38c`; original run
`41256208614`, independent retention audit `41257220044`. The immutable tag
`roadmap/swift-allocations-2026-11-01` preserves that source after squash merge.
Archive SHA-256: `8690b2516204c1b40a86a9211ae72f77fbd229482db43d61ae76da8c264169e5`.
The documentation check recomputes both reports from these files without running
saved executables. It also preserves the failed ARM system-library control;
selecting a working observer does not erase that observation.
