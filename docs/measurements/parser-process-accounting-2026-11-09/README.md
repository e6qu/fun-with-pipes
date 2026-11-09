# Parser process memory and kernel accounting

**All parser observations and controls pass on native Linux ARM64/AMD64.**
This adds kernel accounting to the [earlier RSS/checkpoint experiment](../parser-entry-cleanup-2026-11-09/README.md).
It does not measure temporary allocations inside a resize.

Each process parses one balanced prefix-expression tree of 31, 511 or 8,191
nodes, or one left-nested tree of 127 nodes. This is a benchmark parser, not the
fwp compiler's parser. C/Rust borrow token slices; fwp owns token strings and
stores proved tree nodes in region blocks. [Protocol and controls](../parser-process-memory.md).

## Largest input: ordinary process RAM

GNU time records three ordinary processes per implementation. These include
input, libraries and runtime startup, with no diagnostic checkpoints.

| Native host | C peak RSS, KiB | Rust peak RSS, KiB | fwp peak RSS, KiB |
|---|---:|---:|---:|
| AMD64 | 2,020 | 2,480–2,548 | 2,444–2,696 |
| ARM64 | 1,644 | 2,132–2,144 | 2,060 |

On this ARM64 case, fwp uses 416 KiB more peak resident memory than C, about 25%.
AMD64 fwp readings overlap Rust's range and exceed C's by 424–676 KiB. These
small-process totals do not isolate allocator or ARC overhead. All other inputs
and original readings remain in [the reconstructed summary](summary.json).

## What the mapping snapshots add

Separate diagnostic processes stop before tokenization, after tokenization,
after construction, after traversal and after cleanup. Two processes per case
retain all five raw snapshots. The table shows the largest case after construction:

| Host / implementation | Mapped address space, KiB | Accountable extent (`ac`), KiB | No-reservation extent (`nr`), KiB | Resident pages, KiB |
|---|---:|---:|---:|---:|
| AMD64 C | 3,028 | 716 | 0 | 2,176 |
| AMD64 Rust | 3,568 | 748 | 0 | 2,668–2,672 |
| AMD64 fwp | 68,266,812 | 1,049,168 | 67,149,888 | 2,664–3,056 |
| ARM64 C | 2,600 | 696 | 0 | 1,776–1,784 |
| ARM64 Rust | 3,140 | 736 | 0 | 2,292–2,308 |
| ARM64 fwp | 68,266,448 | 1,049,152 | 67,149,888 | 2,272–2,696 |

- **Mapped** means address ranges, including inaccessible reservations. About
  64 GiB of fwp's total is inaccessible; it is not resident RAM.
- **Accountable** sums mappings carrying the kernel's `ac` flag. fwp has one
  1 GiB writable/accountable anonymous mapping already at the first checkpoint,
  with only 8 KiB resident. Its size matches the generated worker's explicit
  1 GiB pthread stack request; no stack-address trace was collected. Heap and
  metadata reservations use `MAP_NORESERVE` and incremental write permission.
- **No reservation** sums the kernel's `nr` extents. Neither this number nor the
  accountable total promises that physical memory will be available later.
- **Resident** counts pages present at that diagnostic stop. These are different
  executions/builds from the ordinary peak-RSS table; do not combine them.

Both hosts ran kernel `7.0.0-1017-azure`, overcommit mode 0, ratio 50 and
`overcommit_kbytes=0`. The observer did not change host policy. System-wide
`CommitLimit` and `Committed_AS` are saved separately; their changes cannot be
assigned to this process on a shared runner. [Accounting calibration](../parser-mapping-accounting-2026-11-09/README.md)
establishes the flag interpretation. No per-process guaranteed-memory figure is claimed.

After parser cleanup, C/Rust's accountable extents return to their starting
values. fwp's allocator retains its mapped pages for reuse, so its mapping/RSS
snapshots need not shrink when owners are released. Ownership and exact release
are checked separately; an unchanged mapping alone proves neither a leak nor
successful destruction.

## Verification and evidence

Source `6d1608c4f`, tag `roadmap/parser-process-memory-accounting-2026-11-09`;
[native run 42673573956](https://github.com/e6qu/fun-with-pipes/actions/runs/42673573956), attempt 3:

| Host | Job | Artifact |
|---|---|---|
| ARM64 | `129352636403` | `13698813587` |
| AMD64 | `129352636561` | `13698454128` |

Each host passes six parser ownership tests, primitive inventory, allocation/frame
checks, 36 RSS processes, 24 parser checkpoint sequences, 24 wrong-result controls,
48 invalid arguments, eight interpreter checks and seven changed-evidence controls.
The last two controls corrupt policy values while consistently updating hashes
and journals, requiring rejection of the policy itself.

[Docs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42673580483),
attempt 3, job `129352646215`. Complete native logs have no compiler warnings or
errors. The first two attempts of each workflow failed with GitHub internal server
errors before any job started; no parser observation was discarded.

The local reconstruction verifies all 195 raw snapshots per host, including
wrong-result and mapping controls, and hashes 559 manifest-listed text records.
Each compact archive retains all 598 text evidence files: sources, commands,
snapshots, policy files, reports and corruption controls. Original native binaries
remain in the identified GitHub artifacts and were checked by the runner audit.
[Archive identities](files.json) and complete logs are retained here.

**Remaining:** connect allocator-internal events to real C/Rust/fwp allocations,
including temporary old/new storage and mapped/retry paths. These snapshots are
not a transient peak or a maximum dynamic-stack measurement.
