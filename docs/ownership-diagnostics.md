# Checking memory ownership without tracing

An owner keeps an allocation alive. A retain adds an owner; a release gives one
up. Removing tracing GC requires checks that catch lost owners, premature release
and unsafe storage reuse without a collector keeping the affected objects alive.
G4 passed all nine production jobs and documentation in [#215](roadmap-history.md#weak-channels-and-retained-callbacks-pr-215).
G5 must preserve these checks when removing collector code.

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

## Borrow, child and reuse fault matrix

The following tests check the owner's lifetime as well as the final program result.
A *child* is heap data held by another value: for example, the text captured by a
function or stored inside `Some`. A stack-resident parent can still own a heap
child, so returning from its C function must release that child.

| Test and boundary | Deliberate fault | Ownership observation |
|---|---|---|
| [Borrowed callbacks](../tests/borrowed_callbacks.rs): captured text | Omit the capture's release | The caller's text still has an extra owner; status 4 |
| Same: typed argument slices | Treat scalar bits resembling an address as an owner | The scalar-shaped input's count changes; status 5 |
| Same: closure/scalar cleanup | Omit the final scalar or function release | Per-round byte balance fails; status 90 |
| Same: duplicate destruction | Destroy the empty partial application twice | The second count operation names a freed allocation; status 203, before metadata access |
| [Reuse tokens](../tests/reuse_token_ownership.rs): failure before reconstruction | Omit the cleanup that releases the emptied outer cell | The live-address table still contains the cell; status 2 |
| Same: normal reconstruction | Omit the completed result's physical free | Per-round byte balance fails; status 90 |
| [Variant aliases](../tests/variant_alias_ownership.rs): transferring an existing payload | Insert an extra retain before the transfer | The supposedly consumed allocation remains live, or the payload count is too high; statuses 3/2 |
| Same: result cleanup | Omit the result's free | Final byte balance or immediate live-address lookup fails; statuses 90/5 for the two probes |
| [Stack children](../tests/stack_ownership.rs): temporary variant or closure | Remove the generated child release after the call | Live allocations remain at program cleanup; status 205 |

The callback, reuse-token and variant probes check every completed round over 32
rounds. Their ARC checks now consult the live-address table when checking whether
an allocation was freed. A zero reference count alone is insufficient: the last
owner can be released while a broken allocator leaves the storage allocated.
The stack-child cases run 8 and 1,024 iterations, with dynamic allocation and a
static pool at O1/O2. Their normal programs must restore both live-address and
physical-byte balances, and match the raw interpreter. Removing the child release
must fail at both sizes. These four test targets use explicitly bounded 65,536-slot
tables (512 KiB on a 64-bit host), outside the managed heap.

Existing tracing/poisoning cases remain alongside these ARC checks. The ordinary
returned-alias program now also runs in ARC. Tests retain C, executable, outputs and
status under `record-ownership/{borrowed_callbacks,reuse_token_ownership,
variant_alias_ownership,stack_ownership}` in the ownership evidence artifacts.
[The handoff](development-state.md) tracks verification of subsequent changes.

### Empty callback argument slices

Applying zero supplied arguments is an internal partial-application operation;
it does not add zero-argument source functions to the language. Its argument slice
may be null. C does not permit pointer arithmetic on null, even adding zero, or a
null argument to `memcpy` merely because the byte count is zero. Cleanup now forms
pointers only for nonempty spans, and partial application copies only nonempty data.

The callback tests enable error-handler cleanup explicitly and exercise the empty
slice. A copy observer rejects an attempted null copy on every native platform.
On Unix hosts, separate Clang pointer-arithmetic sanitizer runs check both cleanup
spans; restoring either old calculation must trigger the sanitizer. These extra
Clang checks supplement the normal production-compiler tests; they do not establish
GCC sanitizer or Windows sanitizer coverage. The runtime fix also applies to WASI,
whose complete tests remain a separate gate.

These are bounded checks for known ownership operations, not a proof that every
possible stale raw read is detected. An address reused for a new allocation can
still hide an old pointer. Keep alias/output comparisons and compiler lifetime
proofs; do not replace them with the table alone.

## File owners: check the OS handle separately

A file value owns both an OS stream and a small heap object describing it.
[The ARC file probe](../tests/file_storage_disposal.rs),
`arc_file_owners_close_descriptors_and_release_storage_each_round`, checks these
separately over 8 and 1,024 rounds at O1/O2. Each round adds and removes 300 aliases,
then drops the last owner. A second file remains live across all rounds. Alternate
rounds close explicitly twice before dropping the value, checking idempotent close.

The test asks the OS whether the original descriptor/handle was closed: `fstat`
on Unix, `GetHandleInformation` on Windows. It also checks that the runtime removed
the file's shutdown registration and restored its heap-byte baseline. Deliberately
omitting close, registration removal, or storage release produces statuses
210, 211, or 212 respectively. Checks stop before a stale registration can revisit
freed storage. Saved artifacts use `record-ownership/file_storage_disposal`.

The separate [unwind probe](../tests/unwind_cleanup.rs),
`owned_unwind_releases_values_files_and_tasks_without_tracing`, checks normal
return, nested language errors, recoverable traps and suspended-task cancellation.
An outer owner must survive an inner unwind; inner owners release in reverse
order. File closure and file-object release have separate observers. Dynamic
and static O1/O2 runs use 8 and 1,024 rounds, restoring both live allocations and
charged bytes each round. Omitting a value free, unwind cleanup, OS close or
file-object release must produce 231, 232, 235 or 236 respectively. The source
file-handler example also compares ARC/tracing output with the raw interpreter.
C, executables, output and status are retained under
`record-ownership/unwind_cleanup`. These tests passed in #215.

## Wide reference counts

Most counts fit in the allocator's byte-sized slot. More than 254 owners require
a separate exact count; saturation must not silently turn a value into an
unreclaimed object. [The ARC probe](../tests/wide_counts.rs),
`arc_wide_counts_release_values_and_metadata_each_round`, creates 601 owners of
small text, a function capturing text, and large text. It verifies the contents
before release, returns to one owner, and finally releases storage. Dynamic and
static O1/O2 runs repeat 8 and 1,024 times.

A separate observer counts actual metadata `malloc`/`free` events, outside the
managed allocation ledger. Removing the metadata free while still decrementing
its logical count must fail with 239. Overflow must trap with 101; failure to
allocate metadata must terminate with 102. Normal rounds return managed bytes,
managed allocations and metadata allocations to baseline. The source-level
high-fanout string/function example now runs in ARC and tracing, with stack
placement enabled and disabled, against the raw interpreter. Sweep/mark-specific
checks remain only for the collector that still exists. Probe artifacts use
`record-ownership/wide_counts`.

## Weak references and external resources

The live-address ledger checks scoped foreign callback
entry, nested calls, suspension/cancellation and copied-input tests in
[foreign_callback_ownership.rs](../tests/foreign_callback_ownership.rs). Existing
physical-byte checks and deliberately missing-release controls remain independent.
Scoped callbacks retain their call-limited contract. The separate
[retained callback API](retained-callbacks.md) adds a unique registration owner
and active-call cleanup. Its test checks physical bytes and allocation
identity through reentry, errors, cancellation and partial construction. Removed
capture/context cleanup, premature destruction and missing active-call completion
have distinct fault controls.

The direct [library input](../tests/library_input_ownership.rs) and
[result](../tests/library_result_ownership.rs) tests also add ARC execution.
Their missing input/field/result release controls and repeated-evaluation control
remain; freed-value checks use allocation identity in ARC. Premature returned
string release is checked before reading its bytes. A deliberately duplicated
release must stop at the ledger with 203. These runs passed in #215.

External-owner probes run in ARC and tracing, with independent fault controls:

| Boundary | Test | Observed fault |
|---|---|---|
| Socket scratch and resolver results | `native_sockets::socket_scratch_is_released_on_cancel_and_allocation_failure` | Omitted unwind releases leave native buffers or resolver results live; status 248 |
| TCP construction and optional results | `native_sockets::tcp_constructor_failures_release_real_descriptors` | Omitted construction/result cleanup leaves a real descriptor or charged storage; status 248 |
| Library-owned files, TLS sessions and transferred handles | `library_resources::unload_closes_owned_files_sessions_and_transferred_http2_handles` | Independent omitted close/free controls identify each resource kind |
| Library unload and suspended tasks | `library_unload::loader_unload_drains_tasks_restores_signals_and_releases_regions` | Omitted heap/stack release, cached-value cleanup, count-table cleanup or host-state restoration fails the corresponding observer |

The last two tests use the real loader and retain their native Windows paths.
Their ARC runs passed in #215. Allocation balance does not substitute for
these OS-resource checks.

[Weak-channel tests](../tests/queued_functions.rs) check final-release ordering,
metadata release, reused addresses and failed acquisition. The fault controls
omit expiration, omit the channel's metadata release, or retain the target before
an allocation that fails. Actual reference-count overflow checks that upgrade
releases its unfinished result cell while preserving the borrowed channel; an
omitted result cleanup must fail with 235. Each control must fail independently.
The same language fixture
is included in dynamic/static native and WASI JSPI/Asyncify execution.

The [WASI physical ledger](../tests/fixtures/wasm_arc_allocations.c) now detects
duplicate addresses even when an earlier slot is empty. Its regression test
checks normal reuse, duplicate registration and duplicate removal on native and
WASI hosts. These checks passed in #215; collector-specific assertions remain
until their implementation is deleted.

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

### Collector-specific tests and retained assertions

This is the deletion map for the mixed collector/ownership test families. Keep
the old assertions until G5 removes their implementation; do not treat a filename
containing `gc` as permission to delete its complete test target.

| Current family | Retire with tracing | Keep without tracing |
|---|---|---|
| [native_allocator](../tests/native_allocator.rs) | Image/stack root discovery, collector-scratch exclusion and forced-major reclamation | First allocation/free without initialization; small/large and static-pool allocation; `counted_metadata_releases_values_and_resources`; ledger missing-physical-free control |
| Retired collector-age tests | Major/minor marking, old-to-young transitions, intentionally unowned shared graphs and age-gated-free comparison | `tasks.fwp` output remains in the ARC corpus; typed array/map/closure child cleanup remains in the array/map/callback fault suites; small/large physical release remains in the native ledger and wide-count probes |
| [wide_counts](../tests/wide_counts.rs) | Sweeping wide entries and automatic promotion to tracing sharing | Exact counts, overflow/allocation failure, actual metadata release and high-fanout outputs described above |
| [reuse](../tests/reuse.rs) | Collection-age assertions and the `FWP_FREE=0` collector-only comparison | Golden aliases remain in `arc_corpus`; record/variant/array/map allocation comparisons remain, using ARC; invalid uniqueness is caught by ledger fault 204 and alias outputs |
| [gc](../tests/gc.rs) | Deliberately disabling both ownership freeing and reuse to require collection | Golden outputs/errors, compiler-failure and artifact-retention controls, long-loop RSS and HTTP/REST/gRPC bounded-memory checks; use ARC for their ordinary runs |
| [channel_cycle_ownership](../tests/channel_cycle_ownership.rs) | Executing an unproved strong recursive queue graph | The same graph remains an explicit admission rejection; `weak_channels.fwp` tests a recursive weak back-edge, close preserving a queued message, live upgrade while its outside owner survives, and expiration after that owner returns |
| Callback, stack-child, variant and reuse-token probes | Poisoned-storage inspection | The fault matrix above: captured owners, child destruction, duplicate destruction, interrupted reconstruction and original semantic outputs |
| Unwind, files, sockets and loaded libraries | Collector rooting/poisoning around resource owners | Actual descriptors/handles, construction errors, nested unwind, cancellation, close-before-free, active callbacks and real library unload, with the independent faults above |
| [WASI ARC](../tests/wasm_arc.rs) | No native root/mark substitute applies | Physical allocations, count-table entries, task stacks/scheduler, host errors and both JSPI/Asyncify paths; omitted free/table cleanup/scheduler release must still fail |

Other semantic/numeric/protocol suites keep their inputs, expected outputs,
error ordering and cleanup assertions. A positive stress/poison setting there
is an execution variant, not an independent language requirement. G5 removes
that variant only after its ARC run passes; a `0` setting is merely disabling a
check. The source inventory retains exact locations, including dynamically
selected settings, so that deletion can be reviewed without guessing from names.

This G5 batch moves record/tree/array/map allocation comparisons and ordinary
loop/HTTP/REST RSS checks to ARC. Both reuse variants keep reference counts;
`FWP_NO_REUSE` disables only in-place updates in the copy control. The numeric
budgets remain unchanged. This measures allocation cost, not elapsed time or
parity with C/Rust. [The handoff](development-state.md) records validation status.

## Allocation report migration (G5 work in progress)

`FWP_ALLOC_STATS=1` replaces the collector report in the deletion branch. Its
fields have explicit units:

```text
fwp allocation: 4096 bytes allocated, 3072 bytes released, 1024 live bytes, 2048 peak live bytes, 65536 heap extent bytes, max RSS 1234 KiB
```

This example means 1,024 bytes remain allocated at shutdown; the largest live
balance was 2,048 bytes. Small allocations charge their full size-class slot;
large allocations charge requested bytes. Heap extent is the high-water address
range occupied by chunks, including unused space. It is neither live payload nor
physical resident memory. RSS covers the whole process, including stacks, native
libraries and allocator metadata. The allocation balance covers only storage
routed through this allocator; separate OS-resource checks remain necessary.

Allocation/release totals accumulate across the process lifetime using floating
point and can round beyond 2^53 bytes. Live/peak balances use exact `size_t`
integers. Use the live balance and independent address ledger for cleanup
assertions; subtracting very large cumulative totals is not an exact leak check.
The strict test parser rejects missing fields, duplicate reports, wrong units
and invalid numbers. Existing historical measurements keep their original schema
and source identity. New measurements must identify this report format.

The allocator/report code and parser probes exist in the unpublished deletion
worktree. Consumer migration and integrated validation are unfinished; see
[the handoff](development-state.md).

## Remaining acceptance

G5 must update allocation-report consumers and workflow settings, remove the
collector-only assertions above and inspect binaries for actual tracing removal.
Preserve all behavioral assertions and broken-ownership controls. An address
ledger cannot catch every stale raw read; compiler lifetime checks and alias/output
comparisons remain necessary. Run all nine production jobs and documentation
against the final commit before merging.
