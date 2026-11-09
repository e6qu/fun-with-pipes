# What scalar Swift closures allocate

Both native Linux ARM64 and AMD64 profiles observe **one 24-byte native allocation
per scalar closure** in this program. Normal release leaves zero factory-attributed
bytes at exit. These are allocator-requested bytes, not total physical heap use,
process RAM or a count of ARC retains/releases.

## Program and scope

The existing separately compiled Swift factory returns either `a + x` or
`2 * (a + x)`, capturing one integer. Its caller constructs 4,096 closures, calls
each 16 times, then destroys them; it repeats that batch 256 times. That gives
1,048,576 closures and 16,777,216 calls per process. Every result contributes to
a checked checksum.

The profile keeps the existing factory/caller and clocks, changing only the final
print to the checksum. It uses Swift 6.4.2, `-O`, whole-module optimization,
debug information and separate factory/caller compilation. No class is added to
stand in for the captured integer. Profile duration is not a speed measurement.

Heaptrack records native allocations and their caller stacks. We attribute stacks
containing `returnedMake`, and separately retain all process stacks/totals. On
each host, allocator release/omission controls and the selected libunwind 1.8.3
stack-walking controls pass before interpreting profiles. Direct `mmap` storage,
allocator headers, rounding, reserved pages and stack memory are outside these
requested-byte observations.

## Observations

Both kinds and both repetitions agree on each architecture:

| Variant | Factory allocations per process | Factory bytes at process heap peak | Factory bytes left at exit |
|---|---:|---:|---:|
| Ordinary release | 1,048,576 | 98,304 (96 KiB) | 0 |
| Deliberately omitted release | 1,048,576 | 25,165,824 (24 MiB) | 25,165,824 |

The control removes closure-slot deinitialization but still deallocates the raw
slot array. It leaks actual captured contexts, preserving arithmetic output.
The leaked byte count divided by the observed allocation count is 24. Ordinary
peak attribution is 4,096 × 24. These per-stack bytes are sampled at the global
heap peak; they are not a separately sampled maximum for each stack.

The [earlier fwp/C/Rust comparison](../returned-callables.md) reports a 16-byte
fwp managed payload request and inline C/Rust captures. That fwp number excludes
separate count-table and arena storage. Comparing it directly with Swift's native
request is not a total-memory ratio. Existing phase timings retain their own
sources and failed controls; this profile changes no timing acceptance result.
ARC operation counts remain unmeasured.

## Verification and failure history

[Run 42580332788](https://github.com/e6qu/fun-with-pipes/actions/runs/42580332788)
uses source `96e2bf43aa2f500e17c747cb87cadd0177d683b1`, retained by immutable tag
`roadmap/swift-scalar-closures-2026-11-09`. AMD64 passed on attempt 1; ARM64 passed
on attempt 2. The first ARM job stopped before profiling because the pinned
libunwind download returned HTTP 504. Only that failed job was rerun; the AMD
observations were not replaced. Subsequent workflow code adds bounded transient
retries for the same URL and SHA-256, with no alternate library or skipped check.

[Artifact identities](artifacts.json), all three full archives and full job logs
are retained here. Their SHA-256 digests match GitHub's metadata, including the
failed setup. The archives include raw traces, stacks, sources, executable hashes,
commands, controls and manifests. Setup logs also contain an absent optional C++
manpage warning and libtool's normal install-time relink notice; neither is a
program/compiler failure. Both complete passing logs were reviewed.

The two [record-rejection tests](../../../scripts/test-swift-closure-records.py)
reject missing attribution, ineffective omission controls and invalid counts.
[The retained-report audit](../../../scripts/check-swift-closure-report.py)
reconstructs allocation summaries and release checks from archived raw stacks.
[The remaining comparison work](../ownership-peers.md) covers returned buffers,
weak-operation/service costs and parser memory boundaries.
