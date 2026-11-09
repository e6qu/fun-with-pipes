# Actual fwp parser storage

**Both native hosts pass at O1 and O2.** The largest input makes 24,628 heap
allocations, but only 44 allocate tree-region blocks. Peak charged storage occurs
during tokenization, before the tree exists. Reducing tree-node ownership alone
therefore does not remove this parser's main allocation costs.

## What the numbers mean

The [protocol](../parser-heap-events.md) runs the real parser through its ordinary
owning entry and worker thread. An independent address ledger checks allocation,
resize and release events against runtime live/peak counters. Region-node events
check that each node fits, aligned, inside its still-live block.

The caller's input/runtime baseline is measured before parsing and excluded from
the peak columns below. **Requested** is the byte count passed to the allocator;
**charged** includes small-allocation size-class rounding, but uses request size
for large allocations. Neither includes unused allocator pages, metadata or
reserved virtual addresses. Regions subdivide their heap blocks; do not count
nodes again as separate heap allocations.

All four builds (two architectures × O1/O2) give these values, in **bytes**:

| Input | Heap allocations | Peak requested | Peak charged | Input/runtime baseline | Region blocks / bytes | Node bytes / unused payload |
|---|---|---|---|---|---|---|
| 31 nodes | 98 | 1,398 | 1,744 | 80 | 2 / 768 | 616 / 104 |
| 511 nodes | 1,546 | 21,591 | 28,624 | 1,280 | 6 / 12,032 | 10,216 / 1,672 |
| 8,191 nodes | 24,628 | 345,958 | 458,704 | 18,319 | 44 / 167,680 | 163,816 / 2,808 |
| 127 left-nested nodes | 390 | 5,374 | 7,120 | 320 | 4 / 3,840 | 2,536 / 1,208 |

For the largest input, the 167,680 region bytes comprise 163,816 node bytes,
1,056 header bytes (44 × 24) and 2,808 unused payload bytes. All blocks are freed;
all parser allocations return to the caller's initial baseline.

## Where allocation happens

For the 8,191-node input, the raw events show:

| Phase | Allocations | Total requested bytes | Total charged bytes | Releases |
|---|---|---|---|---|
| Tokenize | 16,393 | 411,430 | 524,176 | 11 |
| Build tree | 8,235 | 331,496 | 364,256 | 24,573 |
| Evaluate tree | 0 | 0 | 0 | 0 |
| Release region | 0 | 0 | 0 | 44 |

These totals are allocation **traffic**, not simultaneous live storage. Of the
8,235 tree-building allocations, 44 are region blocks; the other 8,191 still need
source-level attribution before selecting an optimization. Actual address reuse
occurs in every input (8,192 reused addresses for the largest); it does not remove
allocation calls or make their storage stack-based.

[C/Rust's corresponding peak requested bytes](../parser-native-allocator-2026-11-09/README.md)
reach 425,984 on the largest input, including observed resize overlap. fwp's
345,958 requested bytes are lower, but its 458,704 charged bytes use a different
accounting boundary from C/Rust's 434,192 owned libc chunk bytes. Do not turn those
unlike quantities into a precise memory-overhead ratio. fwp also owns token
strings while C/Rust borrow input slices. [Ordinary RSS and mapping observations](../parser-process-accounting-2026-11-09/README.md)
remain the process-level comparison; this diagnostic run supplies no speed or RSS
result.

## Verification and retained records

Source `823791751`, tag `roadmap/parser-heap-events-2026-11-09`,
[run 42682917578](https://github.com/e6qu/fun-with-pipes/actions/runs/42682917578):

| Host | Job / artifact |
|---|---|
| AMD64 | `129381983810` / `13702983607` |
| ARM64 | `129381984032` / `13704330690` |

Each passes ten builds, eight ordinary/observed result pairs, eight wrong expected
results and 24 actual missing-release or broken-observer controls. GCC 13.3 uses
O1/O2, explicit architecture targets and no LTO. Complete native logs contain no
warnings/errors. [Documentation passes](https://github.com/e6qu/fun-with-pipes/actions/runs/42682924250),
job `129381997520`.

All eight traces and 24 failures reconstruct per host. The original missing-event
diagnostic was an empty assertion; the reader now names the missing resize-source
allocation, and all three fault classes are checked against their exact cause.
The native output and generated source are unchanged by that diagnostic repair.

[File hashes](files.json) cover complete compact text records and job logs.
[Results](summary.json) retain raw-run identities and original/new diagnostic text.
The bounded download stopped before one duplicate generated source per host;
reapplying the retained instrumentation reproduces its original manifest hash
exactly. No limit was raised and no native run repeated. Original binaries remain
in the named GitHub artifacts.
