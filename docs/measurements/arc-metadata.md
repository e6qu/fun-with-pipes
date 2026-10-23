# ARC allocator metadata and late diagnostic options

Checked ARC programs do not trace the heap. They still need an allocator, which
records each heap page's size class and reference counts. A *mark bitmap* is a
separate set of bits used by tracing to remember which objects survived a
collection. ARC does not need those bits or the associated object-age checks.

This comparison measures the allocator's C structure sizes in the old and
updated fwp runtime. It does not measure elapsed time or process memory, and has
no C/Rust application baseline. Metadata is separate from language values; this
change does not remove their reference counts or alter their alignment.

## Layout and acceptance budget

Before editing, a native ARM64 probe at `4e16d81c` measured 4,648 metadata bytes
per 65,536-byte heap page in both modes. The target is at most 4,128 bytes for ARC,
with tracing unchanged and all ownership/reuse behavior preserved.

| Structure component | Previous ARC | Updated ARC | Tracing, both revisions |
|---|---:|---:|---:|
| Complete page metadata | 4,648 bytes | 4,128 bytes | 4,648 bytes |
| Small-object mark bitmap | 512 bytes | 0 | 512 bytes |
| Inline reference counts | 4,096 bytes | 4,096 bytes | 4,096 bytes |

Removing the bitmap and unused flags/padding saves 520 structure bytes per page.
For example, the metadata structures for a 1 MiB heap with sixteen pages use
8,320 fewer bytes. Operating systems map memory in larger units, so that number
is not a measured reduction in resident memory. ARC also excludes the collector's
native stack-bound lookup. Its byte-count and startup-time effects are not measured.

## Why late environment changes matter

`FWP_REUSE_VERIFY=1` is a tracing diagnostic: it poisons released storage instead
of freeing it so that later mistaken uses are easier to expose. ARC rejects this
setting at startup because permanent retention violates its memory contract.

Previously, several freeing functions read the setting lazily. A host could start
an ARC program with the setting disabled, then change its environment before the
first free. Objects, arrays, file headers and socket headers would then retain
released storage. The repair excludes those diagnostic paths from ARC at
compilation time. Unsupported startup settings still fail; later host environment
changes cannot turn ARC into the poisoned-storage mode.

The native probe allocates an owner, changes the environment after startup, drops
the owner and checks the allocator's remaining byte charge. ARC must return to
its starting charge. Explicit tracing retains storage under the same diagnostic,
which checks that the test actually reaches the behavior being removed from ARC.
The probe also checks small and large allocations, more than 254 shared owners
(which require a wider count), unique reuse and ordinary reclamation.

## Checks and current limits

`tests/native_allocator.rs` builds the real generated C in both modes, with both
dynamic storage and a fixed 1 MiB heap, at O0/O1/O2. Twelve binaries run five cases
each. CI retains their C, executables, output and status in `allocator-metadata/`.
`tests/arc_corpus.rs` also runs each accepted golden program twice from the same
compiled binary: with the ordinary environment and after the late option change.
Both executions must match the interpreter, including output and exit status;
successful returns must satisfy the existing memory ledger.

[PR #199](../roadmap-history.md#checked-native-defaults-and-arc-metadata-pr-199)
passed all nine production jobs and documentation. Each native host contributes
twelve allocator binaries and sixty observations in the
[inspection record](native-default-2026-10-23.json). The checked layout holds on
Linux, macOS and Windows, each on ARM64 and AMD64. ARC excludes the poisoning
helper and collector stack discovery. Windows still legitimately queries stack
bounds for its fiber contexts and static storage; the inspection checks collector
startup rather than banning the OS import globally.

See [ownership](../ownership.md#existing-implementation) for the mode contracts
and [the project plan](../../PLAN.md) for the remaining removal of tracing and ARC
costs. This cleanup is one measured reduction, not completion of either goal.
