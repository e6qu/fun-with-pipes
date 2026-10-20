# Receiving a message without allocating its wrapper

`channel.recv` returns an `Option`: `Some message` when a message is available,
or `None` when the channel is closed and empty. `option.map f` applies `f` to a
received message and leaves `None` unchanged. For example:

```fwp
texts : I64 -> Channel[String] ! {Async}
texts = channel.make
main = texts 1
    | tap (flip channel.send "hello")
    | channel.recv
    | option.map string.length
    | echo
```

The `1` is queue capacity. `tap` sends while preserving the channel as the pipe's
value; `flip` puts the message before that channel in the send call. The output
is `Some 5`, because `hello` has five characters. The string is the message;
`Some` is a separate result wrapper, not another copy of the string.

The candidate removes that wrapper when the compiler can keep its tag and
payload in local values. The tag distinguishes `Some 0` from `None`; a zero
payload must not be mistaken for an empty result. Whole-value callers keep the
boxed representation. The queued value's existing owner transfers in either
case, and the existing typed variant cleanup releases direct fields on failure.
The runtime's explicit result-form argument selects the representation.

## First measured implementation

[Run 39371671562](https://github.com/e6qu/fun-with-pipes/actions/runs/39371671562)
at `78dc983ef722f598db3513a211bb2fadc9e3dfd4` passes on Linux ARM64 and AMD64.
[The report](channel-receive-counts-2026-10-20.json) audits 180 samples and 20
ordinary binaries. The baseline is the [loop/alias implementation](channel-loop-state.md#calling-known-functions-directly)
at `75da96b8`, run `39366501786`, delivered in PR #176.

Both revisions use the same five sequential programs, inputs 0/16/1024 and three
fresh count profiles per input, in ARC and tracing modes. GCC is 13.3.0, O2,
with LTO disabled; the hosts are AMD EPYC 7763 and Neoverse-N2. Raw interpreter
and ordinary native outputs agree. The [protocol](channel-transfer-protocol.md)
defines the work, counters and exclusions. These are fwp-to-fwp counts, not
elapsed timings or a C/Rust comparison.

Both architectures give the following allocation requests per additional message,
computed from the difference between inputs 16 and 1024:

| Program | Before → after | Retains after (unchanged) |
|---|---:|---:|
| Fresh text | 2 → 1 | 2 |
| Fresh function | 5 → 5 | 3 |
| Shared text | 1 → 0 | 4 |
| Shared function | 3 → 3 | 7 |
| Closed function | 2 → 2 | 1 |

Zero allocations per additional shared-text message does not mean the entire
program allocates nothing: channel setup, its buffer and the shared input still
need storage. Fresh text still needs its own string allocation. The function
cases retain their previous representation and costs. At 1024 messages, sampled
peak charge drops by 16 bytes in both text cases; every ARC profile finishes
with zero charged storage and no collections. Raw buffers, allocator metadata,
stacks and total process memory are outside that charge.

The ordinary ARC binaries' code sections change as follows. File sizes include
linker layout and metadata; neither size measures execution time.

| Program | AMD64 `.text` bytes | ARM64 `.text` bytes | File bytes, AMD64 / ARM64 |
|---|---:|---:|---:|
| Fresh text | −1200 | −1056 | 0 / 0 |
| Fresh function | +64 | 0 | +8 / +8 |
| Shared text | −496 | −480 | −32 / −24 |
| Shared function | +48 | +64 | +8 / +8 |
| Closed function | 0 | 0 | 0 / 0 |

Actual disassembly of the fresh-text program shows the exchange worker's frame
shrinking from 328 to 296 bytes on AMD64 and 320 to 288 on ARM64. The receive
helper grows from 40 to 56 bytes on AMD64 and 64 to 80 on ARM64. AMD64 counts
include saved registers but exclude return addresses; ARM64 counts include saved
registers and the link register. These are individual frames, not total stack peaks.
The first implementation writes the payload through an output pointer. A follow-up
experiment returns a two-word C struct so the target ABI can choose registers;
its results are pending and must not be attributed to this measured revision.

## Ownership and failure checks

Focused ownership run `39371669060` is still running. It covers native targets
and WASI; the measurement result alone does not establish complete cleanup safety.
Tests exercise blocked receive cancellation, close, timed ready/empty receives,
queued functions and failures after calling them. A runtime probe verifies that
direct fields transfer one owner without attempting the injected Option allocation.

Boxed receives must allocate their result before removing the message. If that
allocation fails, the message stays queued for retry. The candidate also repairs
the uncounted tracing path, which previously dequeued first; a forced-failure
regression checks retry there. Full production acceptance remains required before
this candidate is treated as supported.
