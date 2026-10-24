# Cancellation state on task stacks

The cancellation-storage comparison passed focused checks on all six native
platforms and both WebAssembly runners. The repaired Windows ARC checks also
passed on both architectures in
[PR #189](../roadmap-history.md#compact-task-records-and-repaired-native-validation-pr-189),
which completed all nine production gates and documentation.

A [task](../concurrency.md) is a computation scheduled alongside others. It can
pause while waiting for another task, a timer or a channel (a queue for passing
values). Its runtime entry function saves a return point with C's `setjmp`.
Cancellation first runs
cleanup and then uses `longjmp` to return there. Previously each heap task record
contained this saved state (`jmp_buf`), even the root task, which never uses it.

The implementation keeps that state in a local variable of the task entry function.
The record borrows its address while the function runs and clears it before
joining children and finishing. Retained task handles cannot keep a pointer to
a recycled stack. This removes storage from the heap record; it still occupies
the child stack and leaves less room for other frames. It does not remove task
allocation, shared-handle reference counts or the separate CPU switching state.

The entry function remains active until the child completes, and all cancellation
jumps run on the same runtime thread. Its task pointer is unchanged after
`setjmp`. These are the lifetime and local-variable requirements of
[C11 draft N1570, section 7.13.2.1](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf).
Platform execution is still necessary evidence; a C-level argument alone does
not verify Windows fibers or WebAssembly suspension.

## What the comparison measures

[The fixture](../../tests/fixtures/task_channel_ownership.fwp) combines successful
tasks, cancellation before entry and after suspension, repeated awaits, state,
nested data queues and cleanup after errors. Its output is checked against the
unoptimized interpreter and a stored expected result. The fixed input includes
65 jobs that turn integers into repeated strings, plus two loops that each create
and discard 64 channel groups. For example, awaiting one completed task twice
must return `Some "inputinput"` both times; awaiting a cancelled task returns
`None`. The one-hour sleep is cancelled, so it does not impose a one-hour run.

[The test](../../tests/arc_tasks.rs) generates C once for each of ARC and tracing
mode, at fwp optimization level O1. It reconstructs the old embedded `jmp_buf`
layout in that same generated C. Both compile at native O0 (unoptimized) and O2
(optimized) using the production compiler for the host, with
`-std=gnu11 -ffp-contract=off -w`. The focused workflow disables optimization
across compiled units at the final link (`FWP_LTO=0`), so source length cannot
silently select a different compilation path for one layout. Artifacts record
these settings and the platform link libraries. Both layouts contain identical
allocation hooks; candidate-only lifetime assertions run in separate binaries.

Counting starts after constant initialization and includes task/root creation
through normal runtime teardown. The counters mean:

- **Allocation requests and requested bytes:** calls and unrounded sizes passed
  to fwp's managed allocator during that interval, including storage later freed.
- **Retains:** effective reference-count increments for existing counted owners.
  This does not count moves, borrows, releases or all function calls.
- **Peak/final charge:** live managed storage above the starting charge, using the
  allocator's size classes for small allocations and requested sizes for large
  ones. Peak charge is sampled after allocations;
  final charge is sampled after teardown. Neither is total process memory.
- **Collections:** tracing passes. Collection is disabled for the comparison;
  both layouts must finish with zero charge and zero collections.

The separate tracing correctness build runs with GC stress and reuse verification
enabled: it collects frequently and poisons released storage to expose stale uses.

The comparison also records task-record size/alignment, saved-state size,
executable bytes, sections, generated C, machine code and source hashes on each
native host. Deliberately removing pointer setup must exit with 194; removing
pointer clearing must exit with 195. Normal execution must complete successfully.

This is a storage comparison between two fwp layouts, not a C/Rust language
benchmark. Allocator charge excludes task stacks, allocator metadata, pages and
total process memory. No elapsed-time or resident-memory claim is made here.
Smaller records alone do not prove lower total memory or faster execution.

## Measured storage and stack cost

The [raw report](task-cancellation-2026-10-21.json) preserves source
`b37f5948d07128455a76e177f66448240bb47389`, its immutable tag, toolchains,
outputs and binary hashes. Native run `39625011684` and WebAssembly run
`39625018036` passed. All 84 native binaries were inspected, including their
actual executable headers, entry instructions and saved-buffer addresses.

Every measured layout made **1,706 allocation requests and 1,069 retains**.
Final managed charge and collections were zero. Each table cell gives
**embedded buffer → stack buffer**, in bytes. The counts and heap measurements
agree at O0/O2 in both memory modes. The last column is the ARC O2 entry
function's own stack reservation, including its register saves; it excludes the
AMD64 return address pushed by its caller and is not a whole-task stack peak.

| Native host | Task record | Requested bytes | Peak managed charge | Entry stack reservation |
|---|---:|---:|---:|---:|
| Linux AMD64 | 544 → 352 | 103,978 → 88,810 | 55,184 → 38,288 | 72 → 264 |
| Linux ARM64 | 656 → 352 | 112,826 → 88,810 | 63,632 → 38,288 | 96 → 400 |
| macOS ARM64 | 536 → 352 | 103,346 → 88,810 | 55,184 → 38,288 | 80 → 272 |
| macOS AMD64 | 496 → 352 | 100,186 → 88,810 | 46,736 → 38,288 | 40 → 184 |
| Windows AMD64 | 912 → 656 | 133,050 → 112,826 | 80,528 → 63,632 | 72 → 328 |
| Windows ARM64 | 752 → 568 | 120,410 → 105,874 | 63,632 → 55,184 | 64 → 272 |

For example, the Linux ARM64 record shrinks by 304 bytes while its entry frame
grows by 304. Windows ARM64 also needs an additional saved register and alignment:
its frame grows by 208 bytes for a 192-byte return buffer. These are storage
transfers, not eliminated state. Executable sizes do not uniformly improve:
macOS ARM64 ARC files are unchanged (345,200 bytes at O0; 335,456 at O2), while
its tracing files grow by eight bytes. The raw report includes every file and
section measurement. This experiment establishes no speed or process-memory gain.

## Removing collector-only Windows ARC copies

Windows fibers already preserve the CPU state needed to resume a task. Tracing
builds make an additional register copy so the collector can find pointers in
suspended tasks. ARC does not scan those roots. ARC now omits that extra
buffer, stack marker, capture and clearing from ARC builds, retaining them for
tracing. This is separate from the cancellation buffer measured above.

The new comparison reconstructs the preceding collector snapshot in the same
ARC-generated C and runs the same task fixture at native O0/O2. It records the
allocation counters above, context/task sizes, switch count and snapshot count.
An independent O0/O1/O2 fiber probe keeps pointer and floating-point values live
in specified registers, checks stack contents and per-fiber rounding, and checks
host-owned fiber teardown. Restoring the unwanted snapshot must exit with 211;
normal execution must pass. Existing tracing-root and static-memory tests remain.
Both Windows hosts passed every probe after its exact-byte stdout assertion was
corrected to expect the native C runtime's CRLF line ending. All O0/O1/O2 probes
pass normally and exit 211 when the unwanted snapshot is restored.

The [task-record report](task-records-2026-10-21.json) measures snapshots separately
using the compact layout from PR #189. These are snapshot-restored → ARC-only
bytes, not whole-revision comparisons; do not add their savings to the earlier
table without accounting for its different layout.

| Host | Fiber context | Whole task record | Requested bytes | Peak managed charge |
|---|---:|---:|---:|---:|
| Windows ARM64 | 224 → 24 | 536 → 336 | 103,346 → 87,546 | 55,184 → 38,288 |
| Windows AMD64 | 304 → 24 | 624 → 336 | 110,298 → 87,546 | 55,184 → 38,288 |

Native O0/O2 counts agree: 101 switches remain, snapshot copies fall from 101 to
zero, allocations remain 1,706 and retains remain 1,069. Final managed charge and
collections are zero. AMD64 context alignment changes from 16 to eight bytes;
ARM64 remains eight. The ordinary Windows fiber mechanism still preserves CPU
state; this removes only the collector's extra copy.

Inspected machine code confirms ARC calls `SwitchToFiber` without the additional
`setjmp`, stack-marker capture or register-buffer clearing. The restored control
contains those operations. On AMD64 at O2, the measured ARC switch is a counter
increment, argument load and tail jump to `SwitchToFiber`. These instructions do
not establish a timing improvement; no elapsed-time comparison was made.

## WebAssembly return-state repair

The cancellation review found unchecked table growth in the WebAssembly helper
that records saved return points. Failed allocation could lead to a null-pointer
access, and doubling could wrap the table capacity or byte count. The repair
checks both limits before allocation and stops with a diagnostic if allocation
fails. It also detects exhaustion of the helper's pointer-width identifier counter
before zero or an older identifier can be reused. On wasm32 this counter permits
at most 4,294,967,295 registrations per instance; this is an implementation limit,
not a claim of indefinitely running task workloads.

WASI tests exercise successful growth, forced allocation failure, identifier
exhaustion, zero capacity and both arithmetic bounds. Small substituted limits
test the bounds without requesting huge allocations. The runtime still uses the
real integer limits. Failure tests replace `abort` with a distinctive exit code
and require the exact diagnostic, so an unrelated memory trap cannot pass them.
