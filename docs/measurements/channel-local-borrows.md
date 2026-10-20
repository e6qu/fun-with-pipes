# Borrow a channel through temporary local names

A channel owner keeps the queue and its C callback's saved data alive. A
temporary name can refer to that same channel without creating another owner
when the compiler proves that the original owner remains needed after the call.
This applies across nested bindings and matches, without changing source syntax.

The [closed-channel program](../../tests/fixtures/channel_transfer_closed.fwp)
creates a function capturing a fresh string on each iteration and attempts to
send it to an already closed channel. Every send must reject the message and
release both allocations. The loop keeps the channel for its next iteration.
Previously, a temporary name inside the send acquired another channel owner.
The compiler now passes the original channel directly to the borrowing operation.

This is a lifetime proof: reading a different tuple field afterward is not
enough. Unknown or consuming calls, escaping aliases and resource-bearing values
keep their existing ownership. Calls, traps and branch decisions stay in order.
The [ownership guide](../ownership.md#borrowing-across-direct-calls) describes
the surrounding contract.

## What changed in the measurements

Compare baseline `37de5ba40970f7729bf735b347527f5628117dc0` from the
[function-channel report](function-channel-borrows.md) with
`b15488ad0edc3780fcec9ed5e03a42092cf213d7` in
[run 39465380125](https://github.com/e6qu/fun-with-pipes/actions/runs/39465380125).
The [protocol](channel-transfer-protocol.md) uses GCC 13.3.0, O2 and no link-time
optimization; inputs are 0, 16 and 1024 messages, with three profiles each in
ARC and tracing modes. ARC means automatic reference counting.
The new hosts are AMD EPYC 7763 and Neoverse-N2; the earlier AMD64 host was
EPYC 9V45. These are operation counts, not a cross-host speed comparison.

Both architectures and memory modes give the same per-message differences
between inputs 16 and 1024:

| Program | Allocation requests, before → after | Retains, before → after |
|---|---:|---:|
| Fresh text | 1 → 1 | 0 → 0 |
| Fresh function | 2 → 2 | 0 → 0 |
| Shared text | 0 → 0 | 3 → 3 |
| Shared function | 1 → 1 | 4 → 4 |
| Closed function | 2 → 2 | 1 → 0 |

A retain increments an ownership count; its matching release decrements it.
The closed case removes that pair. It still allocates the rejected function
and string. Peak accounted storage is unchanged in every case. All ARC profiles
finish with zero charge and no collections. These counters exclude raw buffers,
allocator metadata, stacks and whole-process memory.

The [raw report](channel-local-borrows-2026-10-20.json) audits all 180 profiles,
20 ordinary binaries, generated C and disassembly. The first preparation
`ba0a2f1e` passed its tests but left this loop's count unchanged: its proof did
not include the enclosing match's continuation. The reported result includes
that continuation and is measured from the final preparation above.

## Actual machine code

In the closed case, the executing loop is `fwp_loop_fields10.constprop.0`.
Its ARC frame shrinks from **424 to 344 bytes on AMD64** and **416 to 352 bytes
on ARM64**. AMD64 counts local storage and saved registers, excluding the
return address; ARM64 includes the saved link register. Neither includes callees
or total task-stack memory.

| Closed-function binary | Executable `.text` size change | Whole-file change |
|---|---:|---:|
| AMD64 ARC | −848 bytes | −8280 bytes |
| AMD64 tracing | −784 bytes | −88 bytes |
| ARM64 ARC | −736 bytes | −88 bytes |
| ARM64 tracing | −736 bytes | −88 bytes |

The `.text` section includes alignment padding. Whole-file differences also
include linker layout; the AMD64 ARC file reduction is not 8280 bytes of removed
instructions. The other four programs keep both sizes. Their AMD64 binaries
are identical; their ARM64 binaries also contain changes to error handling
from the cleanup repair below, including separate volatile loads/stores.
No channel timing or C/Rust speed claim follows from these measurements.

## Cleanup and validation

The same batch fixes C fields changed between `setjmp` and `longjmp`, the
runtime's mechanism for returning to an error handler without ordinary returns.
Changed error payload/type fields and task-scope child-list metadata now use
`volatile`, so they remain valid after the jump. Unchanged links stay ordinary
fields. See [the runtime design](../design.md#runtime) for the C rule.

Each Linux host passes 216 checks: 160 compiler tests, 54 integration tests,
the channel measurement and the seven-program benchmark. Full logs are clean.
The new native probe checks normal return, failure and cancellation at O0/O2/O3,
independent aliases, callback-context destruction and deliberately broken
extra-owner/missing-release controls. A separate scope test starts 65 child
tasks, raises an error, and verifies output and cleanup over four repetitions
in ARC and tracing modes. The interpreter provides the output reference.
Final production acceptance is recorded in the [handoff](../development-state.md).

## Timing checks retained with this batch

The [seven-program comparison](local-borrows-benchmarks-2026-10-20.json) retains
all C, Rust and fwp samples. Every benchmark executable is byte-identical to
the earlier focused run on its corresponding architecture. This compiler
change therefore does not explain timing differences for those binaries.

For equivalent decimal counting, this session's C/Rust/fwp medians are
**12.974/14.790/18.655 ms on EPYC 7763** and
**13.766/14.527/14.285 ms on Neoverse-N2**. fwp takes 43.8%/3.8% more time
than C and 26.1% more/1.7% less than Rust respectively. AMD64's fwp samples
split between 14.293–14.955 ms and 22.356–22.666 ms; no samples are discarded.
The CPU model differs from the earlier AMD64 run. A repeat with saved binaries
and child CPU measurements is in progress; these six samples do not establish
a stable overhead budget. [The integer-text report](integer-text.md) explains
the workload, checked arithmetic, memory and measurement limits.
