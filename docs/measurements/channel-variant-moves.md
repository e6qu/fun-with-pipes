# Moving a matched variant's payload

`Some text` is a variant: its constructor says which case it holds, and `text`
is its payload. When a match consumes this value and returns `text`, ownership
can move to the result. Retaining the text and immediately releasing its previous
owner adds work without creating another independently live owner.

The compiler now removes that adjacent retain/release pair when the variant
already exists as local fields and the constructor has one directly bound payload.
It handles ordinary values, records and variants returned by the match. It does
not move fields out of protected resource slots or heap-boxed variants through
this rule. Existing aliases keep their owners. Failure-cleanup plans keep their
original expression nodes and scopes.

## What was measured

Compare PR #178's measured source `7a0c93ef` (run `39396074107`) with `eecb4b5c11246e6b9223bd7eda84f7857daeef30`
([run 39399972415](https://github.com/e6qu/fun-with-pipes/actions/runs/39399972415)). The same five sequential channel programs run at 0, 16 and 1024
messages, with three fresh profiles per input, in ARC and tracing modes.
Hosts: AMD EPYC 7763 and Neoverse-N2, GCC 13.3.0, O2, LTO disabled,
floating-point contraction disabled. The [protocol](channel-transfer-protocol.md)
defines each program, counted operation and excluded memory cost.

This compares two fwp revisions. It measures counts and inspects actual native
binaries; it does not measure elapsed time or an equivalent C/Rust implementation.
Fewer count operations alone do not establish a speedup or parity with C/Rust.

Per additional message, using the difference between inputs 16 and 1024:

| Program | Allocation requests, before → after | Retains, before → after |
|---|---:|---:|
| Fresh text | 1 → 1 | 2 → 1 |
| Fresh function | 2 → 2 | 2 → 1 |
| Shared text | 0 → 0 | 4 → 3 |
| Shared function | 1 → 1 | 6 → 4 |
| Closed function | 2 → 2 | 1 → 1 |

Both architectures and memory modes have these operation-count changes.
The shared-function program moves both the received callback and the subsequent
optional string result, removing two pairs. Queue retains, allocation counts and
peak charged storage stay unchanged. All ARC profiles finish with zero charged
storage and no collections. Charged storage excludes raw buffers, allocator
metadata, stacks and total process memory.

The fresh-text and fresh-function cases still acquire a channel owner when the
loop calls the exchange function; the loop keeps its own channel for the next
iteration. Removing that remaining retain would need a checked borrowing contract
across the call and its failure paths. This change does not establish that contract.
Shared messages also keep queue, loop and captured-value ownership costs.

## Machine code and stack frames

Ordinary ARC binaries change as follows:

| Program | AMD64 `.text` bytes | ARM64 `.text` bytes | File bytes, AMD64 / ARM64 |
|---|---:|---:|---:|
| Fresh text | −320 | +3840 | −48 / −16 |
| Fresh function | +400 | −3776 | −40 / −64 |
| Shared text | −800 | −656 | −4184 / −88 |
| Shared function | −416 | −288 | −72 / −80 |
| Closed function | 0 | 0 | 0 / 0 |

ARM64 fresh text adds a 4096-byte load/branch stub and padding region; its actual
function bytes fall by 268. ARM64 fresh function removes such a region while its
function bytes grow by 308. These are measured layout differences, not uniform
code-size improvements. AMD64 fresh-function function bytes grow by 404. Its
unchanged C implementation of `fwp_apply_owned` compiles to 434 more bytes, with
changed closure-cleanup calls and inlining; the exchange function itself shrinks
by 275 bytes. Do not infer runtime performance from these size changes.

Fresh-function exchange frames fall from 328 to 248 bytes on AMD64 and from 320
to 256 on ARM64. Shared-function frames fall from 392 to 328 on AMD64 and 368 to
320 on ARM64. AMD64 includes saved registers but excludes the return address;
ARM64 includes the saved link register. These are individual frames, excluding
callees and total task-stack peaks.

Tracing `.text` deltas for fresh text, fresh function, shared text and shared
function are −320, +336, −800 and −208 bytes on AMD64; −256, +320, −4736 and −160
on ARM64. The AMD64 fresh-function file grows by 4056 bytes. Closed functions are
unchanged. Preserve these increases alongside the count savings.

## Correctness and acceptance

Both focused Linux jobs pass all 21 checks, none ignored or filtered.
[The audited report](channel-variant-move-counts-2026-10-20.json) records all 180
samples and 20 ordinary binaries, their C and disassembly. The passing run
reproduces every count and code hash inspected above. Broader native/WebAssembly
ownership checks and final production acceptance remain required; follow the
[handoff](../development-state.md).

The first focused run failed because only the scalar test function was reachable
from its entry point; the compiler correctly omitted the other two functions.
The repaired fixture makes all three result forms reachable and keeps the
three-move assertion. Its native probe checks unique/shared owners and final
release at O0/O2, with GC stress, GC verification and optional reuse poisoning.
A deliberately added owner must fail the count check. Existing queue cases cover
failure after receiving a function, cancellation and undrained captures.
