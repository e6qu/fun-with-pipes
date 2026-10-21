# Queued callbacks that send service responses

A service method can queue work that will later send a response. The work is a
function retaining the response channel: a **closure**. That retained owner must
be released whether the function runs, is discarded, fails or is cancelled.
These are ownership checks, not timing benchmarks or comparisons with C/Rust.

## Two channel implementations

`channel.make` creates a local queue with a stated capacity. A served gRPC
method instead receives a channel whose sends write response messages to its
network stream. gRPC is the request/response protocol used by
[split programs](../services.md). Both channels implement the same operations;
their storage and ownership differ.

The compiler already tracks local queue creators. This extension also recognizes
the response channel created by the service runtime. It owns a stream and a
connection, neither of which owns language callbacks. A queued closure retaining
that channel therefore cannot create a cycle through those transport owners.
Arbitrary external channels remain unknown, even if their types are identical.
No runtime layout, implicit cleanup policy or language syntax changes.

## What the example does

The complete [service fixture](../../tests/grpc/queued.fwp) defines an event:

```fwp
Event = { send: () -> Bool ! {Async} }
```

`send` is a function waiting for unit, written `()`. Calling it attempts one
response send and returns whether the send succeeded. `Async` permits waiting.
An event queue contains these records, so destroying a queued event must also
release anything its `send` function retains.

The method `reply` receives an integer and a response channel. It converts the
integer to text, makes a function retaining that text and channel, queues the
event, then receives and calls it. The client's output for input `3` is `["3"]`.
`twice` calls the received function twice and produces `["3", "3"]`; the channel
must remain alive for both calls.

The fixture uses `curry` to turn a tuple-taking function into successive
single-argument calls. For example, `send-text (channel, text)` returns the
function that later accepts `()`. `const 1` ignores its input and returns the
capacity `1`. Pipes pass each result
to the next operation. [The ownership tutorial](../ownership.md#functions-stored-in-channels)
introduces a smaller local-queue example first.

## Required checks and current status

The [client](../../tests/grpc/queued-client.fwp) repeats nine cases eight times:
normal/repeated sends, undrained and closed queues, rejected sends, caught errors,
cancellation of a blocked local send, nested queues and cancellation by the
remote caller. In the last case the server first acknowledges holding the queued
callback. Only then does the client cancel; an arbitrary delay is not the ordering
guarantee. Expected output is checked independently of the implementation.

The native test compares local and remote raw interpretation with native clients
and servers, under checked ARC and tracing at O0/O2. Ordinary tracing servers use
collection stress and verification. Separate measured servers disable collection
and count response channels, completed calls, finalized streams/connections and
remaining tasks. The final sample follows all 72 calls and connection teardown.
It requires zero live response channels/tasks. The service still listens, so the
test separately identifies its socket-wait storage, allocated lazily after the
readiness baseline. Linux keeps a descriptor table and one wait record; macOS
and Windows keep a polling array. Checks require those objects to belong only
to the listener. No managed allocation charge beyond those actual objects may
remain. There is no fixed byte allowance. These counters exclude OS buffers, allocator
metadata, process memory and stack pools.

A deliberately broken ARC server omits release of queued values. Response-channel
owners then accumulate; exceeding eight live channels must exit with code 201.
That control runs at both optimization levels. Generated C, executable bytes,
disassembly, symbols, outputs and server counters accompany the focused artifacts.
ARC binaries must exclude collector scan/mark/sweep routines; tracing controls
must retain marking. This does not establish a performance improvement.

The initial compiler prototype passed Linux checks at
`867cc9a1889d948fa0002c82736c2aa79d305c35`. The first eight source cases also matched
the accepted compiler's raw interpreter locally; the expanded 72-call fixture
also passes raw interpretation. Early integration checks exposed an incompatible
ARC diagnostic setting and an incomplete measurement baseline: Linux's live
listener accounted for 544 bytes after request cleanup. The corrected native
checks and remote-cancellation addition are still awaiting full validation; consult
[the handoff](../development-state.md) before treating them as supported.

For the complete focused matrix, dispatch `.github/workflows/numerics.yml` with
`suite=channel-proof` and `native_runner=all`. This checks six native platforms
and preserves two WebAssembly regression jobs. It does not claim that WebAssembly
can host this native gRPC server. Full production acceptance is a separate gate.
