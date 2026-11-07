# Tape layout: saved runtime evidence

Measurements use source `621653b6394f49dc229a2956b6b61476c82c9aac`,
[run 42369288345](https://github.com/e6qu/fun-with-pipes/actions/runs/42369288345).
[The results](../tape-record-results.md) preserve all 32 missed speed targets.

The original archive audit failed in all four sessions because its observation
reader still required `missing-parent-free`. The record layout instead tests
`missing-operation-free`: deliberately omit releasing the operation buffer and
require observer exit 232. The repaired reader requires the exact control for
the declared layout; it does not accept either label interchangeably.

The saved AMD64 session 1 report is extracted from original artifact
`13573467878`, SHA-256
`184fed117cce0ec8b279993ba61ffb4940dd1987d4ae91fa456de6dbd48c5374`.
The uncompressed report SHA-256 is
`48a5b73d7df2c678699d49804ac33b3913c2a1f155e722715cc6f88fb3fb2d92`.
It passes the repaired report reader and supplies regression tests for missing,
renamed and successful controls, missing images and unreleased storage.

Complete archive re-auditing and retention of all four sessions remain pending.
No timings are being repeated. This report alone is not full artifact acceptance.
