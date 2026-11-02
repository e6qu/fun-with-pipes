# Frozen requirements

These requirements precede compiler edits. The original text is retained by
`roadmap/derivative-temporary-storage-protocol-2026-11-02`; see the
[baseline](baseline.md) and [current results](README.md).

- Select a known, uncaptured map or zip-with callback returning a flat record of
  immediate numeric fields, followed by a known left fold with a direct numeric
  worker. Prove the mapped collection has one consuming use and no escaping alias.
  Initially exclude dynamic/captured callbacks, nested/resource-bearing records,
  boxed wide numbers, shared/escaping mapped lists and right folds.
- Preserve each input and seed evaluation point, map-before-fold order, callback
  counts, arithmetic, traps and effects. Recording operations are allowed; they
  must retain their order. Preserve existing input ownership preparation unless
  a separate proof and count control establishes a borrowing change.
- Use explicitly owned temporary storage with checked size arithmetic. Keep its
  allocations in the existing managed observer. Account for input scratch arrays,
  any length traversal, header, capacity and padding. Do not move allocations into
  an unmeasured allocator or introduce hidden preparation.
- Retain source owners and temporary storage through every throwing call. Verify
  empty/singleton/long inputs, unequal zip inputs, retained input aliases, effects,
  distinct map/seed/fold traps, cancellation, allocation failure during mapping
  and final result creation. Deliberately omit physical buffer release and require
  the memory check to fail. Keep existing fold-unwind and derivative regressions.
- Compare raw and optimized interpretation with native GCC/Clang O1/O2. Inspect
  generated C and native images to verify the selected representation; timings
  cannot prove ownership or allocation removal.

For `d` coordinates and `u` updates, let `p = (d - 1) * u`. In every nonzero
baseline case/mode, remove at least `2*p - u` managed requests and `32*p - 8*u`
requested bytes. These bounds allow one eight-byte-header buffer with two
eight-byte fields per result, while retaining both existing input scratch arrays:

```text
Before: n result records × 24 bytes + n list cells × 24 bytes
After:  one buffer, 8 + n × 16 bytes
Saving: 2n − 1 requests; 32n − 8 requested bytes, per update
```

Require no increase in effective retains or peak managed charge; final managed
and raw storage remain zero. Zero-update counts and all tape/workspace counters
must remain unchanged. Preserve all outputs and derivative operation counts.
Report actual buffer sizes, live charge, code size and static frames; largest
static-frame growth must not exceed 128 bytes. Code size is supporting evidence,
not a substitute for runtime and memory results.

After correctness/count checks, use a same-source reference disabling only this
selection. Freeze its exact patch. Reuse the [record-fold paired timing protocol](../derivative-record-folds.md#requirements-frozen-before-compiler-edits):
all six inputs, both forms, 98 rounds, seven processes per role, existing solve
counts and two qualified sessions per architecture. Keep the entire driver
identical between candidate/reference. Identical copies must differ by at most
2%; candidate/reference must be at most 1.02 everywhere and at most 0.95 for
cases with at least 199 updates. Retain every failure/inconclusive comparison;
do not repeat completed noisy sessions to seek a pass. Earlier D2 limits remain
open regardless of this candidate's result. Complete final production gates only
after the implementation, controls and report form one substantial batch.
