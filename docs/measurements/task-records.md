# Compact task records

This change is under test. No measured memory or speed improvement is accepted
yet. The [handoff](../development-state.md) records the active source and checks.

A task is a computation that can pause while other tasks run. Its heap record
stores scheduling state, owners, results and links to its parent and children.
Flags such as “ready” and “cancelled” each hold a true/false value. They previously
occupied C integers; the candidate stores them as individual C boolean bytes and
places the thunk-ownership flag beside the others. Pointers and numeric fields
retain their natural alignment. These are bytes, not packed bit fields requiring
shared-word updates. Scheduling still happens on one runtime thread.

The candidate also omits the saved stack marker from checked ARC task records.
That marker exists to help tracing GC scan suspended stacks. ARC does not scan
roots, so its switches no longer capture it. Tracing retains the field and write.
The live-task list remains in both modes: shutdown and cancellation need it even
without a collector. The runtime still owns actual task stacks and CPU contexts.

## Comparison and limits

The test in [arc_tasks.rs](../../tests/arc_tasks.rs) emits the fixed
[task/channel program](../../tests/fixtures/task_channel_ownership.fwp) once per
memory mode at fwp O1. It reconstructs the preceding integer flags and stack
marker in that same generated C, then compiles each layout at native O0 and O2.
The focused runner explicitly disables link-time optimization. Both layouts use
the same counters and must reproduce the raw interpreter's stored output.

The workload includes 65 string-producing jobs, repeated awaits, cancelled tasks,
state, nested data queues and two 64-round channel construction loops. Counters
start after constant initialization and end after runtime teardown. They record:

- Managed allocation requests and unrounded requested bytes, including later frees.
- Effective retain operations; moves and borrows do not count as retains.
- Peak live managed charge, including small-allocation size-class rounding; final
  charge and collection count must both be zero in the counted runs.
- Task size/alignment, flag sizes and executed saves of the tracing stack marker.

Tracing correctness runs separately with collection stress and reuse checks.
Existing task-handle, timer, cancellation, register-root, static-stack and library
unload checks remain. Native artifacts retain generated C, executables, hashes,
output, exit status, machine code, sections and host/compiler details. The Windows
fiber checks also rerun the preceding PR's repaired line-ending assertion.

This compares two fwp runtime layouts, not fwp with C or Rust. Smaller requested
sizes may remain in the same allocator size class. Managed charge excludes stack
mappings, allocator metadata and total process memory. The experiment does not
measure elapsed time, cache misses or resident memory. Allocation counts and
necessary shared-owner retains may remain unchanged; actual results must say so.
