# Queued callbacks that send service responses

A service method can queue work that will later send a response. The work is a
function retaining the response channel: a **closure**. That retained owner must
be released whether the function runs, is discarded, fails or is cancelled.
These are ownership checks, not timing benchmarks or comparisons with C/Rust.

The compiler checks supported lifetime and cycle rules; automatic reference
counting (ARC) handles shared owners. The tracing selector is removed. Current
O0/O2 tests and the fourteen-field final server report passed
[PR #217's platform gates](../roadmap-history.md#tracing-gc-removal-pr-217).
The recorded measurements below belong to the earlier two-mode implementation.

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

To call `send`, pass `()`, the unit value used when no input data is needed.
Calling it attempts one response send and returns whether the send succeeded.
Creating or queuing the function does not run its body. `Async` permits waiting.
An event queue contains these records, so destroying a queued event must also
release anything its `send` function retains.

The method `reply` receives an integer and a response channel. It converts the
integer to text, makes a function retaining that text and channel, queues the
event, then receives and calls it. For input `3`, the client prints `["3"]`, a
list containing one text response.
`twice` calls the received function twice and produces `["3", "3"]`; the channel
must remain alive for both calls.

The fixture uses `curry` to turn a tuple-taking function into successive
single-argument calls. For example, `send-text (channel, text)` returns the
function that later accepts `()`. `const 1` ignores its input and returns the
capacity `1`. Pipes pass each result to the next operation.
[The ownership guide](../ownership.md#functions-stored-in-channels)
introduces a smaller local-queue example first.

## Required checks and current status

The [client](../../tests/grpc/queued-client.fwp) repeats these nine cases eight
times. For input `3`:

| Method | What happens to the queued work | Printed responses |
|---|---|---|
| `reply` | Receive and call once | `["3"]` |
| `twice` | Receive and call twice | `["3", "3"]` |
| `discarded` | Drop the last queue owner without receiving | `[]` |
| `closed` | Close the queue, then drop its last owner | `[]` |
| `rejected` | Attempt another send to that closed queue | `[]` |
| `failed` | Raise an error, caught by the client | `[]` |
| `cancelled` | Cancel a task blocked sending to a full event queue | `[]` |
| `nested` | Receive the response channel from another retained queue | `["3"]` |
| `peer-cancelled` | Acknowledge holding the callback, then cancel from the client | `[]` |

Closing a queue preserves its existing messages; final owner release destroys
the unreceived work. The cancellation acknowledgement is consumed separately,
so it does not appear in the printed responses. It orders cancellation after
the server has retained the callback. Expected output is checked independently
of the implementation.

The native test compares local and remote raw interpretation with native clients
and servers at O0/O2. Separate measured servers count response channels,
completed calls, finalized streams/connections and
remaining tasks. Allocation and retain counts cover the server's managed runtime
and application values during those requests, starting after listener setup;
they are not counts for closures alone. The final sample follows all 72 calls
and connection teardown.
A retain acquires another counted owner. The counter records operations that
actually increase a count, excluding no-op retains. Requested bytes add up every
allocation request, even when earlier storage has already been freed; peak charge
is the largest simultaneously live allocator charge above the readiness baseline.
Charge includes size-class rounding, so it can exceed the requested object size.
It requires zero live response channels/tasks. The service still listens, so the
test separately identifies its socket-wait storage, allocated lazily after the
readiness baseline. Linux keeps a descriptor table and one wait record; macOS
and Windows keep a polling array. Checks require those objects to belong only
to the listener. No managed allocation charge beyond those actual objects may
remain. There is no fixed byte allowance. These counters exclude OS buffers,
allocator metadata, process memory, stack pools and storage created before the
readiness baseline.

A deliberately broken ARC server omits release of queued values. Response-channel
owners then accumulate; exceeding eight live channels must exit with code 201.
That control runs at both optimization levels. Generated C, executable bytes,
disassembly, symbols, outputs and server counters accompany the focused artifacts.
ARC binaries must exclude collector scan/mark/sweep routines; tracing controls
must retain marking. This does not establish a performance improvement.

The compiled cleanup function, `g_sink_drop`, clears its two owner fields,
releases the stream, then releases the connection. For example, Linux AMD64 O2
calls `g_stream_drop` and jumps to `g_conn_drop`; ARM64 uses `bl` and `b` for
those operations. The final jump reuses the caller's return address. These are
instructions from actual compiled executables, not just inspection of emitted C.
The measured version also checks and decrements the test's live-response counter.

All eight jobs in [focused run 39591489617](https://github.com/e6qu/fun-with-pipes/actions/runs/39591489617)
passed at `0b1d6c115893eb9dc37536b2b3345ccbdcc74155`: six native platforms and
two WebAssembly regression hosts. Every complete log was audited. This includes
the full REST target and its silent-server startup deadline regression. Sharing
three immutable REST executables eliminates four duplicate compilations; tests
still launch independent servers. No wall-time improvement is claimed.

[PR #186](../roadmap-history.md#queued-service-responses-and-bounded-server-startup-pr-186)
also passed all nine final-head production jobs and documentation before merge.

## Measured costs

The [complete report](queued-grpc-responses-2026-10-21.json) records all 24 samples,
compiler versions, artifact digests and hashes of the 84 actual executables,
generated C and disassembly. Every sample completes 72 calls, performs 481
effective retains and releases all response channels, streams, the connection and
child tasks. All 12 deliberately broken ARC builds exit 201 as required.

The following byte counts cover each whole 72-call sample. The peak column keeps
the range across its four ARC/tracing O0/O2 runs; the final column is entirely
the identified live listener storage. Request-related charge is zero afterward.

| Native host | Allocation requests | Requested bytes | Peak charged bytes | Final listener bytes |
|---|---:|---:|---:|---:|
| Linux AMD64 | 902 | 210,304 | 9,216–9,984 | 544 |
| Linux ARM64 | 902 | 514,688 | 27,392 | 544 |
| macOS AMD64 | 901 | 127,344 | 4,928 | 128 |
| macOS ARM64 | 901 | 130,624 | 4,928 | 128 |
| Windows AMD64 | 901 | 161,720 | 5,824–6,592 | 256 |
| Windows ARM64 | 901 | 148,600 | 5,312 | 256 |

For example, Linux ARM64 requests 514,688 bytes cumulatively, but at most 27,392
charged bytes are simultaneously live above readiness. Its 5,296-byte task record
accounts for 381,312 requested bytes across the 72 call tasks. The corresponding
Linux AMD64 task record is 1,584 bytes. Platform layouts therefore matter; these
rows are not equivalent-work performance comparisons between machines.

Linux AMD64 tracing O2 has the lower peak in its range; Windows AMD64 tracing O2
has the higher peak. The other three samples on each host agree. These individual
runs do not isolate the reason for that difference, and do not establish a memory
optimization or a time advantage. Allocation totals, retain counts and final
cleanup agree across all four configurations on each host.

## Reproduce the checks

For the complete focused matrix, dispatch `.github/workflows/numerics.yml` with
`suite=channel-proof` and `native_runner=all`. This checks six native platforms
and preserves two WebAssembly regression jobs. It does not claim that WebAssembly
can host this native gRPC server. Full production acceptance is a separate gate.
