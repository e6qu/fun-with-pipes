# Borrowing a channel during a direct call

The [fresh-text program](../../tests/fixtures/channel_transfer_text.fwp) keeps one
channel in a loop. Each iteration calls `exchange`, which creates a string,
sends it, receives it and checks its length. The loop needs the same channel
afterward. Previously, `exchange` acquired another channel owner for that call;
the compiler can now borrow the loop's owner instead.

This is a compiler-internal contract, with no source annotation. The caller keeps
the argument alive through success, failure and cancellation. The
[ownership guide](../ownership.md#borrowing-across-direct-calls) explains the
eligibility rules and the separate consuming convention for generic entries.

## Comparison and method

Compare PR #179's measured source `eecb4b5c` (run `39399972415`) with
`f3e05d27c8f0610f9614b1421f2c7dbedb89c16c`
([passing run 39436111385](https://github.com/e6qu/fun-with-pipes/actions/runs/39436111385)).
The latter is preserved by `roadmap/revision-direct-borrows-f3e05d27`.
Both run the same five programs at 0, 16 and 1024 messages, with three fresh
profiles per input, in checked ARC and tracing modes. The
[protocol](channel-transfer-protocol.md) defines each program and counter.

GCC 13.3.0 compiles at O2, with LTO and floating-point contraction disabled.
The new AMD64 host is an AMD EPYC 9V45; the baseline used an EPYC 7763.
Both ARM64 runs use Neoverse-N2. These are count and binary comparisons between
two fwp revisions: **no elapsed-time or C/Rust comparison was performed**.
Different hosts and fewer count operations do not establish a speedup.

Per additional message, calculated from the difference between 16 and 1024:

| Program | Allocation requests, before → after | Retains, before → after |
|---|---:|---:|
| Fresh text | 1 → 1 | 1 → 0 |
| Fresh function | 2 → 2 | 1 → 1 |
| Shared text | 0 → 0 | 3 → 3 |
| Shared function | 1 → 1 | 4 → 4 |
| Closed function | 2 → 2 | 1 → 1 |

Both architectures and memory modes reproduce these counts. All profiles of
fresh text have zero retains, including setup. Allocation counts, queue retains
and peak charged storage are unchanged. Every ARC profile finishes with zero
charged storage and no collections. Charged storage excludes raw buffers,
allocator metadata, stacks and total process memory.

Zero retains do not mean zero memory-management work. Strings still allocate
and are destroyed; the runtime still has ownership metadata and checks. Function
payloads remain outside this measured source's channel-borrow proof; the
[later handle extension](function-channel-borrows.md) measures that case.
Shared-message parameters
also contain a message that the send consumes, so the whole parameter does not
qualify for borrowing. These remaining costs are visible in the table.

## Actual machine code

The fresh-text exchange's ARC stack frame shrinks from **216 to 40 bytes on
AMD64**, and **224 to 64 bytes on ARM64**. AMD64 counts saved registers but
excludes the return address; ARM64 includes the saved link register. These
figures exclude callees and total task-stack usage.

| Fresh-text binary | AMD64 change | ARM64 change |
|---|---:|---:|
| ARC `.text` section | −1376 bytes | −5264 bytes |
| ARC file size | −4592 bytes | −464 bytes |
| Tracing `.text` section | −1472 bytes | −1184 bytes |
| Tracing file size | −504 bytes | −448 bytes |

The `.text` section includes layout and jump-stub costs as well as function
bodies. ARC function-symbol sizes sum to reductions of 1342 bytes on AMD64 and
1092 on ARM64; the larger ARM64 section reduction must not be presented as that
much removed function logic. The exchange itself shrinks by 341 and 288 bytes,
respectively. Some functions grow: `work` gains 543/416 bytes while its separate
loop helper disappears, reflecting changed inlining. The four other programs'
ordinary binaries are unchanged.

## Validation

Both focused Linux hosts pass 189 checks, with none ignored or filtered:
154 compiler unit tests, 34 integration checks and the explicit measurement test.
All complete logs were audited. The [machine-readable report](channel-direct-borrow-counts-2026-10-20.json)
validates 180 profiles and 20 ordinary binaries, with hashes of generated C,
instrumented binaries and disassembly.

The measured source requires callers to need the same counted storage after
the call, avoiding prolonged last-use input lifetimes. Tests cover independent
aliases, generic entries, failure, cancellation at borrowed-worker entry and an
intentionally leaked-owner control. An ARC channel failure verifies complete
reclamation at O0/O1/O2 with stack placement enabled and disabled.

The same run verifies rejection of runtime handles in compile-time constants,
including nested containers and function captures. Ordinary compile-time file
contents work in both engines; native O0/O2 executables still print the contents
after the input file is removed. The final production matrix includes the broader
ownership coverage and three added Windows targets. Focused Linux success is
not complete platform acceptance; follow the [handoff](../development-state.md).
