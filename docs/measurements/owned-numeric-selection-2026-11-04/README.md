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

## Extension verification and the old zip assertion

[Run 41914912241](https://github.com/e6qu/fun-with-pipes/actions/runs/41914912241)
tests repair `9f8ec909` on the same three hosts. All pass 285 units (four existing
ignored), twelve complete-program checks and seven isolated consuming entries
plus the retained-input exclusion. Both real gradient forms now reach both
consuming operations. The new temporary-result and earlier-field ownership probes
also pass, including failure/cancellation and allocation counts.

Each job still fails one older integration test. It requires the borrowing zip
helper's generated-C comment, but every eligible call in its fixture now consumes
the list. It stops before compiling that example, so this is missing coverage,
not a demonstrated value or cleanup failure. The other 102 integrations pass.

The repair adds a later input read and returned alias to preserve an explicit
borrowing case. It also requires consuming helpers for both zip argument positions,
checks that excluded inputs select neither kind, and saves generated code/results
before representation assertions. Raw/optimized interpreters, native O1/O2,
stack settings, output order and final cleanup remain checked. Compiler and runtime
code are unchanged by this test repair.

All eighteen target logs and full logs per host were audited; there are no other
warnings or failures. All 656 produced native images and 667 statuses were checked.
Four image/status pairs are absent because the old assertion stopped that test.

| Host | Failed-run audit | Retained controls and full log |
|---|---|---|
| GCC ARM64 | [Audit](repair-checks/arm/audit.json) | [Controls](repair-checks/arm/controls.zip), [log](repair-checks/arm/job.log.gz) |
| GCC AMD64 | [Audit](repair-checks/amd/audit.json) | [Controls](repair-checks/amd/controls.zip), [log](repair-checks/amd/job.log.gz) |
| Clang ARM64 | [Audit](repair-checks/mac/audit.json) | [Controls](repair-checks/mac/controls.zip), [log](repair-checks/mac/job.log.gz) |

These failed runs do not authorize measurements. The repaired checks must pass
on all three hosts first; no allocation or timing result has been accepted.

## Native checks pass; an older fixture needs formatting

[Run 41917699225](https://github.com/e6qu/fun-with-pipes/actions/runs/41917699225),
source `8fa9f890`, passes all 285 units (four ignored), 103 integrations,
complete-program selection and ownership probes on every host. The corrected
zip example exercises borrowing and both consuming positions and agrees with
both interpreters at native O1/O2 and both stack settings. All eighteen target
logs, 660 native images, 671 statuses and compiler diagnostics per host are audited.

All three jobs fail only fixture formatting. The newly checked older fixture
contains this existing definition:

```fwp
subtract = fn y -> fn x ->
    let printed = (y, x) | echo
    in x - y
```

The formatter puts that short expression on one line:

```fwp
subtract = fn y -> fn x -> let printed = (y, x) | echo in x - y
```

The repair matches all three saved formatter outputs byte for byte. No arithmetic,
evaluation order, assertion or compiler/runtime code changes. Both fixtures also
pass a bounded local formatting check using #257's verified macOS ARM64 package;
its formatter/parser sources match this branch. This is a development check,
not a build dependency on an earlier fwp compiler.

| Host | Failed-job audit | Passing native controls and complete log |
|---|---|---|
| GCC ARM64 | [Audit](format-checks/arm/audit.json) | [Controls](format-checks/arm/controls.zip), [log](format-checks/arm/job.log.gz) |
| GCC AMD64 | [Audit](format-checks/amd/audit.json) | [Controls](format-checks/amd/controls.zip), [log](format-checks/amd/job.log.gz) |
| Clang ARM64 | [Audit](format-checks/mac/audit.json) | [Controls](format-checks/mac/controls.zip), [log](format-checks/mac/job.log.gz) |

These remain failed jobs. The formatted source must pass the complete grouped
verification before the allocation census or timing starts.
