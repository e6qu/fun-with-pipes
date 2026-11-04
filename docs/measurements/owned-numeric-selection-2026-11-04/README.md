# Consuming operations missing from complete solves

The first implementation passes its isolated ownership tests, but does not select
both operations in real gradient solves. [Saved source and IR](source.zip), from
both GCC hosts at `b8404dbb`, show:

| Complete solve | Consuming array map | Consuming coordinate zip |
|---|---|---|
| Current-only loop | Absent | Absent |
| History followed by last | Absent | Present in `descend` |

[Review identities and hashes](review.json) bind these files to the native CI
artifacts. No timing or whole-solve allocation result has been accepted.

Two restrictions cause the gap:

- The gradient producer remains a call expression inside `array.map`. Temporary
  locals seen in emitted C are introduced later, during ownership preparation.
  The new selection pass requires a direct local too early in the pipeline.
- The current-only loop returns `Again (remaining, coordinates)`. The pass
  excludes calls nested inside record/variant fields, even though constructing
  those values consumes their fields. This excludes the entire update expression.

The [selection extension](../owned-numeric-updates.md#selection-extension-before-timing)
is frozen before its implementation. It admits returned array owners and owned
constructor fields without moving evaluation or widening ordinary-call argument
handling. Full-solve regression checks must require both actual consuming calls;
the existing input-packing check alone cannot establish that.

## What the passing tests did establish

[Run 41907057111](https://github.com/e6qu/fun-with-pipes/actions/runs/41907057111)
passes on GCC ARM64/AMD64 and Clang ARM64. Per host: 282 unit tests (four
existing ignored), 103 integration tests in eighteen targets, ten new ownership
probes, 660 native images and 671 saved statuses. All full/target logs and compiler
diagnostics were audited. The isolated fixtures select both operations and pass
alias, failure, cancellation and physical-release controls.

Retained evidence:

| Host | Audit and source identities | Actual logs, C, images and statuses |
|---|---|---|
| GCC ARM64 | [Audit](safety/arm/audit.json), [job](safety/arm/job.json), [artifact](safety/arm/artifact.json) | [Controls](safety/arm/controls.zip), [full log](safety/arm/job.log.gz), [retained hashes](safety/arm/retained-files.json) |
| GCC AMD64 | [Audit](safety/amd/audit.json), [job](safety/amd/job.json), [artifact](safety/amd/artifact.json) | [Controls](safety/amd/controls.zip), [full log](safety/amd/job.log.gz), [retained hashes](safety/amd/retained-files.json) |
| Clang ARM64 | [Audit](safety/mac/audit.json), [job](safety/mac/job.json), [artifact](safety/mac/artifact.json) | [Controls](safety/mac/controls.zip), [full log](safety/mac/job.log.gz), [retained hashes](safety/mac/retained-files.json) |

Each audit inventories every original artifact file. Each smaller controls archive
retains the new native probes, all target logs, complete-solve source/IR/C and the
isolated selection fixture. This passing run does **not** prove the later repair;
the new complete-solve checks must reject this source, as the table above shows.
