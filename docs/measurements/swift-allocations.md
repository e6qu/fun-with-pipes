# Where the comparison programs allocate

The ordinary [Swift comparison](swift-peers.md) measures elapsed time and peak
resident memory (RSS). RSS includes code, stacks and runtime pages; it cannot
show how many objects a program allocates. This separate profile answers that
question at the **native allocator** boundary, with separate fwp managed-heap counters. It has no
accepted results yet.

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
retained binaries. The protocol is part of [plan step 9](../../PLAN.md#9-measurements).

## Profiler verification

Run `41253559042` at `9a2e954e` passes the controls and all profiles on AMD64.
ARM64 records the allocation sizes but no instruction addresses: every stack is
`??`, so attribution fails before any peer result is accepted. This is a failed
observer control, not evidence about fwp or Swift ownership.

The next check pins GNU libunwind 1.8.3 by release SHA-256, records the linked
library and compares direct `unw_backtrace`/`unw_step` probes against the system
library on the same host. It retains syscall diagnostics and both observations.
Only the explicitly selected library is used for profiles; no failed profile
switches automatically to another observer. Both allocation/release controls
must still pass. A newer dependency has not yet been verified to repair this
failure; the current evidence does not identify a particular upstream defect.
