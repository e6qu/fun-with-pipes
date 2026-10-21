# Cancellation state on task stacks

This change is under test; it has no accepted performance results yet. Follow
the [session handoff](../development-state.md) for the source and CI runs.

A task can stop while waiting for a channel, another task or a timer. Its runtime
entry function saves a return point with C's `setjmp`. Cancellation first runs
cleanup and then uses `longjmp` to return there. Previously each heap task record
contained this saved state (`jmp_buf`), even the root task, which never uses it.

The candidate keeps that state in a local variable of the task entry function.
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
unoptimized interpreter and a stored expected result.

[The test](../../tests/arc_tasks.rs) generates C once for each of ARC and tracing
mode, at fwp optimization level O1. It reconstructs the old embedded `jmp_buf`
layout in that same generated C. Both compile at native O0 (unoptimized) and O2
(optimized) using the production compiler for the host, with
`-std=gnu11 -ffp-contract=off -w`. The focused workflow disables optimization
across compiled units at the final link (`FWP_LTO=0`), so source length cannot
silently select a different compilation path for one layout. Artifacts record
these settings and the platform link libraries. Both layouts contain identical
allocation hooks; candidate-only lifetime assertions run in separate binaries.

For each pair it reports managed allocation requests, requested bytes, reference
count increments, peak allocator charge, final charge and collection count.
Counting starts after constant initialization and includes task/root creation
through normal runtime teardown. Collection is disabled for these measurements;
both layouts must end with zero managed charge and no collections. The separate
tracing correctness build runs with GC stress and reuse verification enabled.

The comparison also records task-record size/alignment, saved-state size,
executable bytes, sections, generated C, machine code and source hashes on each
native host. Deliberately removing pointer setup must exit with 194; removing
pointer clearing must exit with 195. Normal execution must complete successfully.

This is a storage comparison between two fwp layouts, not a C/Rust language
benchmark. Allocator charge excludes task stacks, allocator metadata, pages and
total process memory. No elapsed-time or resident-memory claim is made here.
Smaller records alone do not prove lower total memory or faster execution.

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
