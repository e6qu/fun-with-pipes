# Checking memory ownership without tracing

An owner keeps an allocation alive. A retain adds an owner; a release gives one
up. Removing tracing GC requires checks that catch lost owners, premature release
and unsafe storage reuse without a collector keeping the affected objects alive.
This is the diagnostic work in [plan G4](../PLAN.md#1-remove-tracing-gc).

## Native live-allocation ledger

The [test helper](../tests/support/ownership_ledger.rs) adds an address table to
generated C used by the native ARC tests. It records allocation and free events,
then removes entries when storage is freed. It neither delays a free nor keeps a
history of dead allocations. Production programs do not contain this test helper.

The ledger observes all three native allocation paths: initialized objects,
mutable runtime buffers and pointer-free storage. It handles the fast and slow
initialized-object paths without counting the same allocation twice. Native static
pool allocation uses these same paths and is checked too. Here “static” means a
bounded pool, not that every value lives on the call stack.

| Fault | What the ledger checks | Deliberately broken control |
|---|---|---|
| Allocator publishes a live address twice | An allocation cannot already be in the table | Register the same live address twice; status 201 |
| Duplicate or invalid free | Free must name the start of a live allocation | Double free and interior-pointer free; status 202, before touching the allocator |
| Count operation on released storage | Heap count operations require a live allocation address | Retain, drop and final-release operations after free; status 203 |
| Shared storage selected for reuse | A positive reuse decision requires one live counted owner | Change each uniqueness check to accept two owners; status 204 before destructive reuse |
| Missing release | No live allocations remain at final cleanup | Leave an allocation live; status 205 |
| Diagnostic table exhausted | The explicitly supplied capacity is enforced | Fill the 64-entry probe table; status 206, without disabling observation |
| Free recorded but storage not returned | Existing byte accounting must also return to baseline | Remove the allocator's physical-free body; status 207 in the probe |

[The native probe](../tests/arc_execution.rs),
`native_ownership_ledger_detects_bad_events_without_retaining_storage`, runs at
O1/O2 with dynamic allocation and a static pool. Eight and 1,024 rounds exercise
small/large objects, zero-size requests, freed-address reuse and hash collisions.
Deleting one table entry must not hide a colliding live entry; opaque test keys
also exercise a collision chain wrapping across the table boundary. Every completed
round restores its initial live-allocation count.

The ordinary [ARC execution tests](../tests/arc_execution.rs) and
[golden-program corpus](../tests/arc_corpus.rs) use the same ledger alongside their
existing output and byte-balance checks. The corpus's table has 1,048,576 slots
(8 MiB on the six native targets), an explicit test-only capacity. Exhaustion
fails the test and needs investigation. The small diagnostic probe has 64 slots.
These are validation costs, not measurements of an ordinary fwp binary.

The CI artifacts under `ownership-evidence/arc/record-ownership/ownership-ledger`
retain the probe's C, executable, output, error and status for each case. Current
platform validation is recorded in [the handoff](development-state.md).

### Limits

An address table cannot distinguish an old pointer from a new allocation at the
same address. It also cannot observe an arbitrary raw memory read. Therefore this
ledger is not a complete stale-borrow detector or a replacement for every old
poisoning test. Compiler lifetime checks, alias/output comparisons and the existing
failure/cancellation tests remain necessary. Raw C pointers keep their documented
manual lifetime obligations.

The native ledger does not track OS descriptors, task-stack mappings, allocator
metadata allocated outside the managed heap, or WebAssembly's allocation table.
Their own release checks remain required. The byte ledger and live-address table
are complementary: a missing free can leave an address live, while a recorded free
with a broken allocator can leave storage charged after its address was removed.

## Which collector checks need replacement?

The [inventory command](../scripts/inventory-memory-diagnostics.py) records every
textual mention of the five settings below in tracked compiler/runtime source,
tests, scripts and workflows. CI saves `memory-diagnostics.json` in the existing
`ownership-inventory-*` artifacts, with source revision, file hashes and line text.
It checks the requested revision against the checkout. Comments, disabled settings
and runtime-selected values remain visible; a mention is not proof of coverage.

| Setting/control | Purpose today | Work before deletion |
|---|---|---|
| `FWP_GC_STRESS` | Collect frequently to expose lost roots during allocation/suspension | Keep the semantic inputs and error/cancellation cases; map each to compiler ownership checks, native allocation/byte checks, or its external/WASI owner test. Values of `0` merely disable stress. |
| `FWP_GC_VERIFY` | Compare a minor trace against a complete trace | Retire mark/age consistency checks with the collector. Preserve any independent lifetime, alias and cleanup assertions in the same tests. |
| `FWP_REUSE_VERIFY` | Copy and poison storage instead of reusing/freeing it | Retain current controls until their alias/lifetime cases have ownership-based fault tests. The new live-allocation/reuse checks cover the faults above but not arbitrary stale reads. |
| `FWP_GC` | Select/disable collector behavior in a generated tracing runtime | Remove the selector with tracing; preserve tests proving physical reclamation and zero collections. Disabling collection alone is not GC removal. |
| `FWP_GC_STATS` | Print allocation, reclamation, collection and process-memory observations | Preserve allocation/live-byte observations in the collector-free reporting path. Update consumers and their malformed/missing-evidence tests together. |

Some checks test only collector implementation details. For example,
`tests/reuse.rs::large_and_small_objects_obey_collection_age` checks large-object
age bits. It stays while that collector exists; a collector-free runtime does not
need an age-bit replacement. In contrast, the golden alias/reuse programs in the
same file describe language behavior and must remain covered.

## Remaining concrete work

1. Classify the inventory's positive controls by defect and owner boundary.
   Distinguish enabling a check from setting it to zero, and preserve dynamic
   settings until their actual test cases have been reviewed. Do not bulk-delete
   matching lines or treat an inventory count as a coverage claim.
2. Finish the reuse/borrow replacement matrix. Start with
   `tests/borrowed_callbacks.rs`, `tests/reuse_token_ownership.rs`,
   `tests/variant_alias_ownership.rs` and `tests/stack_ownership.rs`: record which
   missing capture, wrong child owner, stale borrow or duplicate destruction each
   mutation catches. Add the missing faults before retiring poisoning coverage.
3. Complete the separate boundaries: `tests/wasm_arc.rs` already has missing-free,
   count-table and scheduler controls; library/foreign callback tests check copied
   inputs and scoped captures; file/socket/task tests must observe actual resource
   release. A zero native byte balance cannot substitute for these checks.
4. Only after that mapping and all native/WASI gates pass, replace the old
   workflow settings and remove collector-only assertions with the collector.
   Keep the [cycle-policy decision](ownership-admission.md#contract-work-before-collector-deletion)
   separate: better diagnostics do not admit an unproved owning cycle.
