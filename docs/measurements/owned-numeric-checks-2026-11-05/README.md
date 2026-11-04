# Consumed numeric storage: native verification

[Run 41920964943](https://github.com/e6qu/fun-with-pipes/actions/runs/41920964943)
passes on GCC ARM64/AMD64 and Clang ARM64 at source
`07541ff956d582bb9c3936b86261e43fa25b0b2f`. Immutable measurement tag:
`roadmap/owned-numeric-measurement-2026-11-05`.

Each host passes **285 unit tests** (four existing ignored), **103 integrations**
across eighteen targets, twelve complete-program checks and fixture formatting.
Every full/target log, all 660 native image architectures and all 671 saved
statuses were audited. No unexpected diagnostic remains.

| Host | Job | Audit | Retained native controls and logs |
|---|---|---|---|
| GCC ARM64 | 126893053080 | [Verified results](arm/verified.json), [full inventory](arm/audit.json) | [Controls](arm/controls.zip), [full log](arm/job.log.gz) |
| GCC AMD64 | 126893053575 | [Verified results](amd/verified.json), [full inventory](amd/audit.json) | [Controls](amd/controls.zip), [full log](amd/job.log.gz) |
| Clang ARM64 | 126893053536 | [Verified results](mac/verified.json), [full inventory](mac/audit.json) | [Controls](mac/controls.zip), [full log](mac/job.log.gz) |

Each controls archive retains all target logs, the new ownership probes, the
borrowing/consuming order example, real-program source/IR/C and formatter output.
Each host's `retained-files.json` verifies the retained bytes; `artifact.json`
identifies the complete original artifact. The inventories hash every original file.

## What the checks establish

- Both complete gradient forms reach consuming array maps and coordinate zips.
  An unused helper definition does not count as selection.
- Seven exported fixtures call their consuming entries. A later input read keeps
  the borrowing operation; ordinary-call arguments and anchored bodies stay excluded.
- Temporary array results transfer their owner. Earlier record fields keep their
  own owners, even without an outside alias to expose an incorrect reuse.
- Exclusive arrays and list prefixes reuse storage. Views, shared roots, shared
  ancestors and tails preserve aliases. Both zip argument positions, empty inputs
  and unequal lengths produce the expected values.
- Native O1/O2 behavior agrees with raw and optimized interpreters. Floating-point
  bit patterns and eager callback/output order remain checked.
- Traps, cancellation, checked overflow and injected allocation failures release
  inputs, partial results and scratch storage. Disabled reuse still passes.
- Deliberately corrupted values fail with status 241; deliberately missing cleanup
  fails with status 90. Ordinary probes succeed and leave the physical-owner ledger empty.

The [documentation gate](https://github.com/e6qu/fun-with-pipes/actions/runs/41920859686)
also passes at this source. Its [identity/audit](docs-job.json) and
[full log](docs-job.log.gz) retain the three expected negative-runner diagnostics.

## Repairs and remaining acceptance

[Earlier results](../owned-numeric-selection-2026-11-04/README.md) retain the missing
complete-program selection, outdated borrowing assertion and old fixture layout.
They were fixed together with explicit regression checks; failed runs were not
relabeled or discarded.

These checks establish behavior and isolated reuse counts. They do not establish
whole-solve allocation savings, speed or all-platform delivery. The separate
[allocation census now passes](../owned-numeric-census-2026-11-05/README.md). The
[contract](../owned-numeric-updates.md) still requires compiler/runtime comparisons
and nine final production jobs plus documentation.
