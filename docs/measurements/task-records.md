# Compact task records

All six native focused jobs passed. The measurements below describe this fixed
program; full production acceptance is still pending. The
[handoff](../development-state.md) records the current delivery checks.

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

## Measured results

The [raw report](task-records-2026-10-21.json) records source
`c10934f5dadf9b57f2d6280589ca95541178667e`, compilers, host CPUs, exact flags,
all counters, executable hashes and machine-code excerpts. Every row below gives
preceding → compact bytes. Native O0 and O2 produce the same allocation counters.

| Host | ARC task record | ARC requested bytes | ARC peak managed charge | Tracing task record | Tracing peak managed charge |
|---|---:|---:|---:|---:|---:|
| Linux ARM64/AMD64 | 352 → 320 | 88,810 → 86,282 | 38,288 → 34,064 | 352 → 328 | 38,288 → 38,288 |
| macOS ARM64/AMD64 | 352 → 320 | 88,810 → 86,282 | 38,288 → 34,064 | 352 → 328 | 38,288 → 38,288 |
| Windows ARM64 | 368 → 336 | 90,074 → 87,546 | 38,288 → 38,288 | 568 → 544 | 55,184 → 55,184 |
| Windows AMD64 | 368 → 336 | 90,074 → 87,546 | 38,288 → 38,288 | 656 → 640 | 63,632 → 55,184 |

ARC saves 32 bytes per record and 2,528 requested bytes in this workload, about
2.8% of all requested storage. Linux/macOS peak managed charge falls about 11%;
Windows ARC stays in the same allocation size class and has no peak reduction.
Tracing requests fall by 1,896 bytes except Windows AMD64, where alignment makes
the saving 1,264 bytes. Its task record remains aligned to 16 bytes; the other
measured records remain aligned to eight.

All combinations still make 1,706 managed allocation requests and 1,069 effective
retains. All counted executions finish with zero managed charge and zero
collections. The eight scheduling flags and thunk flag each shrink from four
bytes to one. ARC stack-marker saves fall from 101 to zero; tracing retains all
101 saves. These changes remove bookkeeping and storage, not task allocation or
shared ownership.

Actual ARM64 task-entry instructions use byte loads/stores (`ldrb`/`strb`);
AMD64 uses byte moves (`movb`). ARC's switch routine omits the call that reads the
stack marker and its write, while the tracing control retains them. Full O0/O2
code and section sizes are retained in the report. At native O2, the ARC
comparison has these mixed code-size results:

| Host | Text section, bytes | Complete executable, bytes |
|---|---:|---:|
| Linux AMD64 | 187,378 → 187,138 | 388,144 → 387,928 |
| Linux ARM64 | 184,924 → 188,972 | 405,168 → 405,112 |
| macOS AMD64 | 231,415 → 231,927 | 328,544 → 328,440 |
| macOS ARM64 | 215,124 → 215,728 | 335,496 → 335,392 |
| Windows AMD64 | 239,206 → 239,078 | 405,504 → 404,480 |
| Windows ARM64 | 213,336 → 213,408 | 372,736 → 372,736 |

The Linux ARM64 compact binary contains 4,080 zero padding bytes in its text
section at addresses `0x35b68` through `0x36b57`, after a short out-of-line
instruction sequence. That padding accounts for most of its larger text section;
it is not 4 KiB of additional executed task instructions. Other instruction
sizes and inlining choices also differ. No elapsed-time budget was tested here;
these mixed sizes are part of the storage tradeoff, not evidence of a speedup.

The native set includes 164 binaries: ten record comparisons/verification
binaries and fourteen cancellation controls on each host, plus ten Windows fiber
binaries on each Windows host. The
[Windows snapshot results](task-cancellation.md#removing-collector-only-windows-arc-copies)
separately measure the inherited change from PR #188.

To reproduce, dispatch `numerics.yml` at the report's immutable source tag with
`suite=task-cancellation` and `native_runner=all`, then use `suite=wasm-hosts` for
WebAssembly. Keep both job logs and uploaded artifacts. These focused checks do
not replace the final PR's nine production jobs and documentation audit.
