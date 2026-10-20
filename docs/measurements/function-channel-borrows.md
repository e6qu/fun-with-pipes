# Borrow channels carrying functions

A channel's owner keeps its queued values and any C callback's saved data alive.
A direct call can borrow that owner even when the messages are functions.
The caller must still need the same channel after the call; capture, cycle and
resource-scope restrictions remain separate checks.

In the [fresh-function program](../../tests/fixtures/channel_transfer_function.fwp),
each iteration creates a function holding a string, sends it, receives it and
checks the returned text. The loop keeps the channel for its next iteration.
Borrowing removes an extra channel owner for the exchange; it does not remove
the function or captured string's storage.

## Comparison

The baseline is `f3e05d27` from the
[direct-call report](channel-direct-borrows.md). The new source is
`37de5ba40970f7729bf735b347527f5628117dc0`, tagged
`roadmap/revision-scalar-text-37de5ba4`, in
[passing run 39446896772](https://github.com/e6qu/fun-with-pipes/actions/runs/39446896772).
Both use GCC 13.3.0 at optimization level O2 with link-time optimization disabled,
on AMD EPYC 9V45 and Neoverse-N2 hosts.
These are allocation/count and binary comparisons, **not elapsed-time or
C/Rust comparisons**.

The [protocol](channel-transfer-protocol.md) runs five programs with 0, 16 and
1024 messages, three profiles per input, in automatic reference counting (ARC)
and tracing-GC modes. A retain records another owner; its matching release
removes that owner. Both hosts
reproduce these costs per additional message between 16 and 1024:

| Program | Allocation requests, before → after | Retains, before → after |
|---|---:|---:|
| Fresh text | 1 → 1 | 0 → 0 |
| Fresh function | 2 → 2 | 1 → 0 |
| Shared text | 0 → 0 | 3 → 3 |
| Shared function | 1 → 1 | 4 → 4 |
| Closed function | 2 → 2 | 1 → 1 |

The runtime's peak accounted storage is unchanged; every ARC profile finishes with zero charge
and no collections. These counters exclude raw buffers, allocator metadata and
stacks. Shared-message parameters still include a consumed message. The closed
case is inlined and still creates an owned alias inside its loop. Neither cost
is removed by changing the direct-call convention. The
[local-borrow report](channel-local-borrows.md) measures the subsequent removal
of the closed case's temporary owner.

## Actual binary changes

The fresh-function ARC exchange frame shrinks from 248 to 56 bytes on AMD64
and from 256 to 80 on ARM64. AMD64 includes saved registers but excludes the
return address; ARM64 includes the saved link register. Neither includes callees.

| Fresh-function binary | `.text` change | Whole-file change |
|---|---:|---:|
| AMD64 ARC | −1408 bytes | −4552 bytes |
| AMD64 tracing | −1488 bytes | −4560 bytes |
| ARM64 ARC | −1136 bytes | −400 bytes |
| ARM64 tracing | −5248 bytes | −424 bytes |

The executable-code section (`.text`) includes alignment padding as well as function instructions;
its reduction is not a count of removed function logic. The four other programs'
binaries are unchanged. No runtime speedup follows from these counts alone.

## Validation

The combined run passes 205 tests per host, including destruction of a C
callback's saved data, aliases, calls that consume their inputs, failure,
cancellation, and deliberate leak
controls. Existing queued-function capture, cycle and scope tests still pass.
See [ownership](../ownership.md#borrowing-across-direct-calls) for the contract.

The [raw report](function-channel-borrows-2026-10-20.json) audits all 180 profiles
and 20 ordinary binaries. All 100 saved C/binary/disassembly hashes and every
profile match the earlier channel-only source `d8c62e17`, whose focused run
`39440052683` also passed. The combined source's integer-text lowering does not
change these channel results. Reproduce the audit with
`scripts/summarize-channel-costs.py`; the [handoff](../development-state.md)
tracks the full production matrix.
