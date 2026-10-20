# Borrow a channel through temporary local names

A channel owner keeps the queue and its C callback's saved data alive. A
temporary name can refer to that same channel without creating another owner
when the compiler proves that the original owner remains needed after the call.
This applies across nested bindings and matches, including borrowing operations
inside record fields, without changing source syntax.

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
`62ed104504b9e9a032434223120785e3cc37a47f` in
[run 39469883481](https://github.com/e6qu/fun-with-pipes/actions/runs/39469883481).
The [protocol](channel-transfer-protocol.md) uses GCC 13.3.0, O2 and no link-time
optimization; inputs are 0, 16 and 1024 messages, with three profiles each in
ARC and tracing modes. ARC means automatic reference counting.
The new hosts are AMD EPYC 9V74 and Neoverse-N2; the earlier AMD64 host was
EPYC 9V45. These are operation counts, not a cross-host speed comparison.

Both architectures and memory modes give the same per-message differences
between inputs 16 and 1024:

| Program | Allocation requests, before → after | Retains, before → after |
|---|---:|---:|
| Fresh text | 1 → 1 | 0 → 0 |
| Fresh function | 2 → 2 | 0 → 0 |
| Shared text | 0 → 0 | 3 → 2 |
| Shared function | 1 → 1 | 4 → 4 |
| Closed function | 2 → 2 | 1 → 0 |

A retain increments an ownership count; its matching release decrements it.
Each shared-text and closed-function iteration removes one such pair. The
shared-text program borrows its channel while receiving inside a record-field
calculation; it still needs the existing shared message owners. The closed case
still allocates the rejected function and string. Peak accounted storage is
unchanged in every case. All ARC profiles
finish with zero charge and no collections. These counters exclude raw buffers,
allocator metadata, stacks and whole-process memory.

The [raw report](channel-record-borrows-2026-10-20.json) audits all 180 profiles,
20 ordinary binaries, generated C and disassembly. The first preparation
`ba0a2f1e` passed its tests but left this loop's count unchanged: its proof did
not include the enclosing match's continuation. The reported result includes
that continuation and the record-field extension. The
[intermediate preparation](channel-local-borrows-2026-10-20.json), `b15488ad`,
removed only the closed-function pair. The record-field extension changes no
other allocation, storage or cleanup metrics, or numerical benchmark
executables, relative to that preparation.

## Actual machine code

In the closed case, the executing loop is `fwp_loop_fields10.constprop.0`.
Its ARC frame shrinks from **424 to 344 bytes on AMD64** and **416 to 352 bytes
on ARM64**. AMD64 counts local storage and saved registers, excluding the
return address; ARM64 includes the saved link register. Neither includes callees
or total task-stack memory. The shared-text loop,
`fwp_loop_fields8.constprop.0`, shrinks **552→456 bytes on AMD64** and
**512→432 bytes on ARM64** under the same convention.

| Binary | Executable `.text` size change | Whole-file change |
|---|---:|---:|
| Closed function, AMD64 ARC | −848 bytes | −8280 bytes |
| Closed function, AMD64 tracing | −784 bytes | −88 bytes |
| Closed function, ARM64 ARC | −736 bytes | −88 bytes |
| Closed function, ARM64 tracing | −736 bytes | −88 bytes |
| Shared text, AMD64 ARC | −720 bytes | −80 bytes |
| Shared text, AMD64 tracing | −832 bytes | −88 bytes |
| Shared text, ARM64 ARC | −496 bytes | −80 bytes |
| Shared text, ARM64 tracing | −496 bytes | −88 bytes |

The `.text` section includes alignment padding. Whole-file differences also
include linker layout; the AMD64 ARC file reduction is not 8280 bytes of removed
instructions. The other three programs keep both sizes. Their AMD64 binaries
are identical; their ARM64 binaries also contain changes to error handling
from the cleanup repair below, including separate volatile loads/stores.
No channel timing or C/Rust speed claim follows from these measurements.

## Cleanup and validation

The same batch fixes C fields changed between `setjmp` and `longjmp`, the
runtime's mechanism for returning to an error handler without ordinary returns.
Changed error payload/type fields and task-scope child-list metadata now use
`volatile`, so they remain valid after the jump. Unchanged links stay ordinary
fields. See [the runtime design](../design.md#runtime) for the C rule.

Each Linux host passes 217 checks: 161 compiler tests, 54 integration tests,
the channel measurement and the seven-program benchmark. Full logs are clean.
The new native probe checks normal return, failure and cancellation at O0/O2/O3,
independent aliases, callback-context destruction and deliberately broken
extra-owner/missing-release controls. A separate scope test starts 65 child
tasks, raises an error, and verifies output and cleanup over four repetitions
in ARC and tracing modes. The interpreter provides the output reference.
Final production acceptance is recorded in the [handoff](../development-state.md).

## Timing checks retained with this batch

The [final seven-program comparison](record-borrows-benchmarks-2026-10-20.json) retains
all C, Rust and fwp samples. Every benchmark executable is byte-identical to
the earlier focused run on its corresponding architecture. This compiler
change therefore does not explain timing differences for those binaries.

For equivalent decimal counting, the final C/Rust/fwp medians are
**11.740/12.963/12.660 ms on EPYC 9V74** and
**13.819/14.602/14.311 ms on Neoverse-N2**. That is 7.8%/3.6% more than C
and 2.3%/2.0% less than Rust. Different host models prevent treating this as a
speed improvement over the intermediate run.

The [intermediate comparison](local-borrows-benchmarks-2026-10-20.json) has
C/Rust/fwp medians of
**12.974/14.790/18.655 ms on EPYC 7763** and
**13.766/14.527/14.285 ms on Neoverse-N2**. fwp takes 43.8%/3.8% more time
than C and 26.1% more/1.7% less than Rust respectively. AMD64's fwp samples
split between 14.293–14.955 ms and 22.356–22.666 ms; no samples are discarded.
The CPU model differs from the earlier AMD64 run.

A [repeat of the saved binaries](local-borrows-repeat-2026-10-20.json) uses
24 rounds after two warmups, rotating and reversing C/Rust/fwp execution order.
It measures both process elapsed time and child user-plus-system CPU time.
On EPYC 7763, fwp's median is **53.9% above C in elapsed time and 55.3% above C
in CPU time**; the corresponding Rust gaps are 35.8% and 36.6%. fwp's CPU
samples span 13.597–22.617 ms. The spread therefore cannot be explained solely
by time spent waiting to run. Its cause remains under investigation.

On Neoverse-N2, the repeated gaps are **3.7% elapsed and 3.8% CPU above C**,
and 2.0% elapsed and 1.9% CPU below Rust. fwp CPU samples span
14.111–14.263 ms. These host-specific results do not establish a universal
overhead budget. Both complete job logs and the raw timing, memory and control
artifacts from [run 39468533196](https://github.com/e6qu/fun-with-pipes/actions/runs/39468533196)
are audited. [The integer-text report](integer-text.md) explains the workload,
checked arithmetic and measurement limits.
