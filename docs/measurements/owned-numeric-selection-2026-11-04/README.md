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
