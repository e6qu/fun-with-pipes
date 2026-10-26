# Services: one program, two deployments

Read [tutorial 14](tutorials/14-services/README.md) for the complete runnable
version. A module is a source file; a process is a running executable. A service
is a process that answers requests from other processes. Remote procedure calls
(RPCs) encode function arguments, send them to a service and decode the reply.
Here gRPC carries those calls over HTTP/2, using Protocol Buffers for messages.

Keeping the same source notation does not make a remote call as cheap or reliable
as a local call. It adds encoding, transport, waiting and connection-failure
behavior. A client stub is generated code that performs those steps. The
`shop.fwp` commands below illustrate deployment; the complete checked-in shop
uses `main.fwp` in `examples/services`, with commands in [the example guide](../examples/README.md).

An fwp program can be compiled as **one executable** holding every module, in which its modules call each other's
functions directly, or as **separate executables** that call each other
over gRPC. The source is the same in both builds; only the
build command differs. You can write, test and debug a system as one
program, then deploy parts of it as services when the need arises (to
scale a part on its own, to isolate it, to call it from another language)
and go back just as easily. The first build gives one executable, the
second three:

```
$ fwp build shop.fwp -o shop
$ fwp build shop.fwp --service inventory --service pricing -o out
$ ls out
inventory  pricing  shop
```

[Tutorial 14](tutorials/14-services/README.md) builds a small example both
ways. A module's exported functions are all served, with no `# expose:`
line: that line chooses the interfaces for clients outside the program
(command lines, REST and MCP), which
[interfaces.md](interfaces.md) compares, and has no effect on how the
program is split. The shop in
[`examples/services`](../examples/services/main.fwp) splits into two
services, one of which calls the other.

## The method

1. **A module is the unit of deployment.** A file brought in with
   `import` is a module, and the module's `export`ed functions are its
   service interface. Its other bindings are implementation details.
2. **Write the program as one program.** Callers use the exported
   functions like any others: `"pear" | inventory.item`,
   `attempt (inventory.reserve 2)`, `map pricing.unit-price`. Everything
   is type-checked together, and `fwp run`, `fwp test` and an ordinary
   `fwp build` treat it as one program.
3. **Choose the deployment at build time.** `--service m` makes module `m`
   a separate executable. After type checking, the compiler replaces every
   call from another module to an exported function of `m` with a client
   stub of the same type, and builds a server for `m`'s exported
   functions. Nothing in the source marks a call as remote.

The decision is made in one place, the monomorphizer (`src/mono.rs`),
which resolves every reference to a binding. For a reference from module
`a` to an exported function `f` of a split module `m` (with `a` ≠ `m`), it
produces a function whose body is `Remote { module: m, method: f }` instead
of `f`'s body. A stub is an ordinary function value: it can be partially
applied, passed to `map` or composed, exactly like the function it
replaces. Both backends implement the stub: the interpreter in
`src/services.rs`, the C runtime in `runtime/fwp_rt_grpc.c`.

What is local and what is remote:

| Call | Single executable | Split build |
|---|---|---|
| to an exported function of a split module, from another module | call | gRPC call |
| within a module, including to its own exported functions | call | call |
| to a non-exported function of another module | call | call (the code is compiled into the caller) |
| to an exported constant (not a function) | value | value (computed locally; constants are pure) |
| to a module that is not split | call | call |

Services may call other services: in the shop, `pricing.quote-order`
calls `inventory.reserve`, so the pricing server is itself a client of the
inventory server. Splitting a subset is fine: with only
`--service inventory`, pricing is compiled into the main executable.

## Commands

| Command | What it does |
|---|---|
| `fwp build app.fwp --service m [--service n]... [-o dir]` | builds `dir/app` (the main program) and `dir/m`, `dir/n` (servers; a dotted module name `a.b` gives `a-b`). `-o` defaults to the current directory. `-O`, `--fat` and `--emit-c` apply to each executable |
| `fwp run --service m... app.fwp [args]` | runs `main` (compiled and cached, or interpreted with `--interp`), calling the named modules remotely |
| `fwp serve --service n... app.fwp m [--listen addr]` | serves module `m` (compiled and cached, or interpreted with `--interp`); its calls to the modules named by `--service` are remote |
| `fwp proto app.fwp [--service m]...` | prints the `.proto` file of the named services (by default, of every imported module that exports functions) |

gRPC is only the transport between the parts of a program: to serve
functions to other clients, expose them as REST endpoints or MCP tools
([interfaces.md](interfaces.md)). [Calls between services](#calls-between-services)
describes streaming, deadlines, metadata and statuses.

A server executable takes one option, `--listen host:port`. It prints
`fwp: service m listening on host:port` on stderr once it accepts
connections; with port 0 the system picks a free port, which the line
reports.

### Addresses

| | Used by | Default |
|---|---|---|
| `FWP_SERVICE_<M>` | clients of `m`, and `m`'s server when `--listen` is not given | the address given at build time with `--service m=host:port`, else `127.0.0.1:50051` |

An address `tls://host:port` (or `grpcs://host:port`) is TLS: clients
connect with TLS and verify the server's certificate, and the server,
which then needs `--tls-cert` and `--tls-key` (or `FWP_TLS_CERT` and
`FWP_TLS_KEY`), listens on `host:port` with TLS. See
[tls.md](tls.md#services).

`<M>` is the module name in upper case with every other character
replaced by `_`: `inventory` is `FWP_SERVICE_INVENTORY`, `shop.billing` is
`FWP_SERVICE_SHOP_BILLING`. The variable is read at each call, so a
process can be pointed elsewhere without rebuilding.

## Building without tracing collection

Native builds check memory lifetimes before generating code. Moves and borrows
avoid ownership work where proved; automatic reference counting (ARC) releases
shared storage when its last owner goes.
An owner keeps a value alive; the last owner releases it. A borrow uses a value
while an existing owner keeps it alive.
Shared values still need reference counts, and message encoding, network buffers
and task stacks still cost memory.

For a program `app.fwp` that imports module `m`, this command produces the client
`out/app` and server `out/m` with the same checked memory mode:

```sh
fwp build app.fwp --service m -o out
```

Use the ordinary listen/address settings above to run them. The compiler rejects
programs whose lifetimes it cannot prove. It does not silently enable tracing.
Focused native tests pass on Linux, macOS and Windows, each on ARM64 and AMD64.
They compare interpreted and compiled calls and check cleanup on failure and
cancellation. [PR #161](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
records passing final production acceptance.

An iterator computes later elements on demand. That makes **when** its next step
runs part of the ownership check. A **handler** supplies a temporary state store
or derivative-recording context to a calculation. A call that sends an iterator
and receives one result consumes its input in the calling task. A call that
streams in both directions uses a background sender that does not inherit the
caller's handlers. Its producer can install a handler inside its own step.
Similarly, the server drains a returned iterator after the method returns; that
iterator cannot use a method-local handler that has already ended.

Received values belong to the caller or its response iterator. A typed send
transfers one reply owner into a queue, or keeps it alive until a native delivery
callback returns and then releases it. A callback that saves the reply must
acquire a separate owner.
Closed channels, failed sends, cancelled calls and caught remote errors release
their completed values. Earlier aliases remain usable. The
[ownership contract](ownership.md#native-executables-and-services) describes the
checks and the remaining limits. HTTP/2 handlers, REST, MCP and browser entries
have separate contracts in the [ownership guide](ownership.md#ownership-boundaries).

## What stays the same, and what changes

Splitting a program keeps its meaning wherever the network allows:

| | Single executable | Split build |
|---|---|---|
| results | | the same values, encoded and decoded exactly (floats bit for bit, `I128`, maps, recursive variants, ...) |
| `Error[E]` | aborts to the nearest `attempt` | the same: the error value is sent back and raised in the caller |
| traps (overflow, division by zero) | the process stops with `fwp: trap: ...` (exit 101) | the caller traps with the same message and exit code; the server logs the trap and keeps serving |
| `exit` inside a served function | the process exits | the server exits; the caller traps because the service is gone |
| latency | a call | a network round trip, plus encoding |
| unreachable service | — | the call traps: `service call inventory.item (127.0.0.1:50051) failed: cannot connect to ...` |

Effects deserve attention, because a split build moves them to another
process:

- **Output.** `print` in a served function writes to the server's stdout,
  not the caller's.
- **State and the environment.** `State[S]` handlers, `args`, environment
  variables, random seeds and files belong to the process that runs the
  code. A served function cannot see the caller's `run-state`; it can only
  see its arguments.
- **Purity is not latency-free.** A function whose type has no effects is
  still a network call when split. It cannot fail with an `Error`, so a
  transport failure is a trap; if a caller must survive a service outage,
  give the function an `Error` effect and handle it.
- **Concurrency.** A remote call waits only in the calling task: other
  tasks run meanwhile, many calls share a connection, and the task's
  deadline and cancellation apply to the call (and travel to the server
  as `grpc-timeout`). A server runs each call in a task of its own, so
  calls run concurrently, and services may call each other in a cycle.
- **`comptime`.** Compile-time code that calls a split module's exported
  function would call the service while compiling; keep such calls out of
  `comptime`.

## The interface rules

A function can be served when it is exported, has a monomorphic type (all parameter/result types are concrete) and
at least one parameter, and every parameter, its result and its `Error`
type can be encoded: numbers, `Bool`, `String`, `Bytes`, `Duration`,
records, tuples, `()`, variants, `List`, `Array`, `Set`, `Map` and
`Option`, in any combination. An `Iterator` result or parameter and a
final `Channel` parameter are streams ([below](#streaming)).
Other functions, resources (`File`), and runtime handles (`Task`,
`Channel`, sockets) cannot cross a process boundary; a split build that
would send one is a compile error naming the function:

```
$ fwp build main.fwp --service lib -o out
main.fwp:2:8: error: `at-one` is served by module `lib`, but values of type `I64 -> I64` cannot be sent to a service
2 | main = lib.at-one (add 1) | echo
  |        ^^^^^^^^^^
```

Exported functions of a split module must also have distinct gRPC method
names (`price-of` and `price.of` would both be `PriceOf`).

## Calls between services

The calls of a split program behave as the calls of one program; this is how the transport carries them.

### Streaming

A stream sends a sequence without collecting every item into one reply first.
`Iterator` pulls values on demand; `Channel` exchanges values with a task. These
types determine the direction of streaming. Closing, cancellation and errors
therefore need rules beyond those of a single ordinary result.

These are curried functions: `A -> B -> R` accepts one argument of type `A`,
then one of type `B`. The remote interface collects those arguments into one
request when the function is fully applied; it does not change the language's
single-argument function model.

Whether a call streams is decided by the function's type:

| Function type | RPC | Messages |
|---|---|---|
| `A -> B -> R` | unary | one request `{arg1, arg2}`, one response `{value}` |
| `A -> Iterator[R]` | server streaming | a response per element |
| `A -> Iterator[Result[R, GrpcError]]` | server streaming | a response per `Ok`; the first `Err` ends the stream with its status |
| `A -> Channel[R] -> ()` | server streaming | a response per value sent to the channel |
| `Iterator[A] -> R` | client streaming | a request `{arg1}` per element |
| `Iterator[A] -> Iterator[R]` | bidirectional | |
| `Iterator[A] -> Channel[R] -> ()` | bidirectional | |

(Element messages follow the rule above: a nominal record element is its
own message.) A client stream must be the function's only parameter
besides an output channel; gRPC has no other request then.

Flow control limits how much data a sender may send before the receiver is
ready for more. Backpressure is the resulting wait: a slow receiver makes its
sender wait rather than letting unsent data grow without a bound.

* **`Iterator[R]` results** suit pure, lazy streams: the server forces
  the iterator one element at a time and sends each as it goes, within
  HTTP/2 flow control, so a slow client slows the computation down and an
  infinite iterator streams until the client cancels.
* **A final `Channel[R]` parameter** suits effectful streams: the function
  sends to the channel (`channel.send`), which sends a message on the
  stream; the stream ends when the function returns. `channel.send` gives
  `False` once the client has gone. Use it when values come from tasks,
  timers, other services or other calls.
* **`Iterator[A]` parameters** are lazy: forcing an element waits for the
  next request message, so a bidirectional function can answer each
  request before the next one arrives. A request that cannot be decoded
  fails the call with `INVALID_ARGUMENT`.
* **`Iterator[Result[R, GrpcError]]` results** are streams that can fail
  part way: the messages are `R`s, and an `Err` ends the stream with its
  status (`OUT_OF_RANGE`, ...) in the trailers. A caller of such a remote
  function gets the same iterator back: its `Ok`s, then, if the stream
  fails (with a status, or because the connection is lost), one `Err`
  with the status, and the end. Nothing traps. `countdown n` streams n,
  ..., 1, then ends with a status, its first `Err`:

  ```fwp
  export countdown : I64 -> Iterator[Result[I64, GrpcError]]
  ```

On the calling side, the same rules apply in the other direction, so a
split program behaves as one program: a remote `A -> Iterator[R]` returns a lazy
iterator that receives as it is forced (a failure before the first element
is raised in the caller; later failures trap, as forcing an iterator
cannot fail: use `Iterator[Result[R, GrpcError]]` for streams that may
fail part way), a remote `A -> Channel[R] -> ()` sends each received value
to the caller's channel (with backpressure) and returns when the stream
ends, and a client stream sends the elements of the caller's iterator.
A bidirectional call sends them from a task of its own while the caller
receives the responses, so requests and responses interleave: the request
iterator may be infinite, or wait for time to pass, and the call ends when
the server ends it. In the [test service](../tests/grpc/greeter.fwp), `firsts`
takes three input values and multiplies each by ten. Thus
`iter.count-from 1 | greeter.firsts` returns an iterator over `10`, `20`, `30`:
the server ends the call after three requests even though its input can keep
producing numbers.

### Reading the same stream in two tasks

An iterator value identifies a position in a sequence. Keeping another reference
to that position preserves the same value: it does not split the sequence between
readers. Received positions are cached, meaning their first received value is
saved for later reads. If two tasks reach an unread position together, one receives
while the other waits for that saved value.

The [shared-stream example](../tests/grpc/shared-stream.fwp) uses the test
service's `greeter.count`, which produces the integers from 1 through its argument.
`iter.fold add 0` sums them, starting at zero. `iter.later` captures the iterator
in a function to run later, and `task.spawn` starts that function in a child task.
In the type below, `Iterator[I64]` is an iterator of integers, `Task[I64]` is a task
whose result is an integer, and `! {Async}` marks task scheduling as an effect.

```fwp
import greeter

start : Iterator[I64] -> Task[I64] ! {Async}
start = iter.later (iter.fold add 0) | task.spawn

main =
    1024
    | greeter.count
    | both start start
    | both (.0 | task.await) (.1 | task.await)
    | echo
```

`both f g` gives the same input to both functions and returns their results as a
pair. Here it starts two sums from the same iterator. Tuple selectors `.0` and
`.1` select the first and second task. `task.await` waits for each, returning
`Some result` on completion or `None` on cancellation. The output is
`(Some 524800, Some 524800)`: each task sums all 1,024 values, and
1,024 × 1,025 ÷ 2 = 524,800.

Cancelling a task that is waiting for another reader does not cancel that reader.
If cancellation interrupts decoding before a value is saved, the received bytes
return to the front of the queue so a surviving reader can still receive them.
Cancelling the task actually receiving a client response can still reset the
remote call. Retaining an earlier position also retains its saved values and
continuations, so sharing an iterator can increase memory use. Native stream
storage has typed owners: a shared position keeps its saved values until its
last reader releases it. The [ownership guide](services.md#reading-the-same-stream-in-two-tasks)
describes its cleanup and measured costs.

### Errors and status codes

| Status | When |
|---|---|
| `OK` (0) | the function returned; or it raised an `Error[E]` (`E` not `GrpcError`), which is in the response's `oneof` and raised again in an fwp caller |
| the error's `code` | the function raised `Error[GrpcError]`: `grpc.fail grpc.not-found "no such book"` (codes outside 1 to 16 are `UNKNOWN`) |
| `INVALID_ARGUMENT` (3) | the request could not be decoded |
| `DEADLINE_EXCEEDED` (4) | the call's deadline passed (below) |
| `FAILED_PRECONDITION` (9) | an fwp caller was built against a different version of the function (the `fwp-fingerprint` of [Versioning](#versioning)) |
| `UNIMPLEMENTED` (12) | no such method |
| `INTERNAL` (13) | the function trapped (`grpc-message: trap: ...`; the server logs the trap and keeps serving), or raised an error the response cannot hold |
| `CANCELLED` (1) | the server cancelled the call |

On the calling side, a function with `Error[GrpcError]` raises every
failure as a `GrpcError`: a non-`OK` status, `UNAVAILABLE` (14) when the service cannot
be reached or the connection is lost, `DEADLINE_EXCEEDED` for
`grpc.with-deadline`. Other calls trap on failures, as
[above](#what-stays-the-same-and-what-changes) describes; a trap on the server traps the caller with the same message.
`lookup` answers `"ghost"` with the status `NOT_FOUND`:

```fwp
export lookup : String -> HelloReply ! {Error[GrpcError]}
lookup = if
    (eq "ghost")
    (grpc.fail grpc.not-found)
    (make HelloReply { message = id })
```


### Settings for a group of calls

`grpc.with-metadata`, `grpc.with-deadline`, `grpc.with-gzip` and `grpc.with-tls`
run a supplied function with temporary settings for its outgoing calls. The
function takes `()` (unit, an input carrying no data). The previous settings are
restored when it returns or fails. Nested metadata scopes add headers; deadlines
keep the earlier limit, and TLS scopes replace the active TLS options. Child
tasks inherit the settings visible when they are created.
This collection of settings is called the task's **request context**.

In the [greeter test service](../tests/grpc/greeter.fwp), `slow n` waits
`n` milliseconds and returns `n`. `const 20 | greeter.slow` is a function: `const 20` ignores its input
and produces `20`, then the pipe passes that number to `greeter.slow`. Passing
this function to a scope helper lets the helper install its settings before the
call happens. `const` produces a constant function; it does not make an already
evaluated expression run later.

### Deadlines and cancellation

A deadline limits how long an operation may take. A duration such as `2s` or
`100ms` specifies seconds or milliseconds. Deadlines use the task machinery of [concurrency.md](concurrency.md):

* **Server.** A call's `grpc-timeout` becomes the deadline of the task
  serving it. When it passes, the task (and every task it started) is
  cancelled at its next suspension point, and the client gets
  `DEADLINE_EXCEEDED`. When the client cancels the call (`RST_STREAM`) or
  its connection closes, the task is cancelled too. The server logs both:
  `fwp: deadline exceeded (in greeter.slow)`,
  `fwp: call cancelled by the client (in greeter.slow)`.
* **Client.** A call made by a task with a deadline (`task.within`,
  `task.deadline`) sends the time left as `grpc-timeout`. When the
  deadline passes, the task is cancelled as anywhere else (`task.within`
  gives `None`), and the call is reset. Deadlines propagate: a server
  that calls other services does so from a task whose deadline is its
  call's.
* **`grpc.with-deadline d f`** gives the calls `f` makes a deadline of
  their own: they fail with `DEADLINE_EXCEEDED` (a `GrpcError`) when it
  passes, and the task goes on.

`greeter.nap` does the same work as `greeter.slow` and permits a `GrpcError`. `task.within` returns `Some result` on success or `None` when it
cancels the task. `attempt` turns a permitted error into an `Err` value, so the
third call can report its deadline error and continue.

These expressions are entries in the [client's `main` list](../tests/grpc/client.fwp):

```fwp
task.within 2s (const 20 | greeter.slow) | echo,
task.within 100ms (const 2000 | greeter.slow) | echo,
()
    | attempt (const (const 2000 | greeter.nap) | grpc.with-deadline 100ms)
    | echo,
```

The first allows two seconds for a 20-millisecond request. The next two allow
100 milliseconds for a two-second request: the second cancels its task, while
the third catches the service-call error. In the third expression, the outer
`const` supplies the callback as a value to `grpc.with-deadline` when `attempt`
runs it; the inner `const 2000` supplies the call's numeric argument.


### Metadata

Metadata are name/value strings carried alongside a request or response.
**Headers** precede the message body; **trailers** follow it with the final
status. For example, a client can send an `x-user` header so the service knows
which user initiated the call. HTTP/2's reserved fields, such as `:method`, are
called pseudo-headers and are kept separate from application metadata.

| Function | What it returns or changes |
|---|---|
| `grpc.metadata ()` | the request headers of the call the task serves, as `(name, value)` pairs with lower-case names (without pseudo-headers and `content-type`, `te`, `grpc-timeout`, `grpc-encoding`, `grpc-accept-encoding`, `fwp-fingerprint`); `[]` outside a call |
| `grpc.header name` | one of them |
| `grpc.with-metadata pairs f` | `f`'s calls send these headers too (names are lower-cased; nested uses add up) |
| `grpc.set-header name value` | add a header to the response of the call being served; it is sent with the first response message, so set it before |
| `grpc.set-trailer name value` | add a trailer, sent with the status |
| `grpc.with-response-metadata f` | run `f`, and the response headers and trailers of the calls it made: `(result, pairs)` |
| `grpc.peer-subject ()` | the subject of the client's certificate, on servers that require them ([tls.md](tls.md)) |

Tasks started by a served function see its call's metadata. Binary
headers (`-bin`) are passed as base64 text, a printable encoding of bytes. Response metadata leaves
out `content-type`, `grpc-status`, `grpc-message`, `grpc-encoding` and
`grpc-accept-encoding`. `tagged` greets with response metadata, a header
and a trailer:

```fwp
export tagged : String -> String ! {Network}
```

In the [test service](../tests/grpc/greeter.fwp), `tagged` prefixes its input
with `"tagged "`, sends the header `x-served-by: greeter`, and adds a trailer
containing the input's length. Thus
`grpc.with-response-metadata (const "Ann" | greeter.tagged)` returns
`("tagged Ann", [("x-served-by", "greeter"), ("x-length", "3")])`: the first
tuple field is the function's result, and the second collects its response
metadata. `Ann` has three characters, which explains the trailer's value.


### Compression

Compression represents message bytes more compactly before sending them.
Both fwp clients and servers accept gzip. `grpc.with-gzip f` enables it for
requests made by the callback `f`; a server also enables it for responses to
a call that uses compressed requests. Messages under 64 bytes are still sent
uncompressed. Each message states whether its bytes are compressed, so both
forms can appear in one call.

A message that expands beyond 64 MiB during decompression is rejected. Asking
for a different message encoding, such as `deflate` or `snappy`, fails with
`INVALID_ARGUMENT`. The header `grpc-encoding: gzip` identifies gzip messages;
`grpc-accept-encoding: gzip` tells the peer that gzip is accepted.

The encoder finds repeated byte sequences and refers back to them (LZ77), then
uses a fixed table of bit codes (fixed Huffman coding). The decoder also handles
the other block forms in DEFLATE, the compression format inside gzip. The
implementations are [Rust](../src/gzip.rs) and
[C](../runtime/fwp_rt_h2.c). This describes their algorithm, not measured speed
or compression-size parity with another implementation such as zlib.


### Concurrency

* A server runs every call in a task of its own, so calls on one
  connection and on different connections run concurrently, and a slow
  call does not hold up a fast one.
* A client keeps one connection per address and multiplexes calls on it:
  each call is an HTTP/2 stream, and a call waits only in its task. Many
  tasks can call one service at once (`task.map` over a list of requests
  makes the calls concurrently).
* Each connection has a reader task, which parses frames and wakes the
  tasks waiting for them (and, on a server, starts the calls), and a
  writer task, which sends what the others queue. Flow control holds a
  sender back when its stream's or the connection's window is used up.
* Native programs run tasks as green threads on an event loop (epoll on
  Linux); the interpreter runs each task on a thread, one at a time.

## The wire format

The wire format is the exact message representation sent over a connection.
A protobuf field has a numeric tag identifying it; a varint uses more bytes for
larger integers. The tables below are for protocol implementers. The type
fingerprint checks compatibility; it is not a cryptographic identity or an
authentication mechanism.

Calls are [gRPC](https://grpc.io/docs/what-is-grpc/) calls over HTTP/2
cleartext with prior knowledge (h2c), or over TLS with ALPN `h2` for
`tls://` addresses ([tls.md](tls.md#services)). The parts of one program
are its only intended clients; `fwp proto` prints the messages to look
at what goes over the wire.

- **Names.** The package is `fwp`, a module `inventory` is the service
  `Inventory` (`shop.inventory` is `ShopInventory`), and a function
  `unit-price` is the method `UnitPrice`. The path of a call is
  `/fwp.Inventory/UnitPrice`. `# grpc:` lines in the module change them
  ([below](#the-wire-format)).
- **Requests.** The arguments of a curried function form its request
  message: `arg1 = 1`, `arg2 = 2`, ... (a `()` argument has no field). A
  single argument of a nominal record type is the request message itself.
- **Responses.** The result is `value = 1` of the response message, or
  the message itself for a nominal record. A function with an `Error[E]`
  effect responds with `oneof result { T value = 1; E error = 2; }`;
  with `Error[GrpcError]`, errors are statuses instead.
- **Metadata.** fwp clients send `fwp-fingerprint` (below). Responses
  carry `grpc-status` and, on failure, `grpc-message`.

### Types

| fwp | protobuf |
|---|---|
| `Bool` | `bool` |
| `I8`, `I16`, `I32`, `Trit` | `sint32` |
| `I64`, `ISize`, `TInt[n]` | `sint64` |
| `U8`, `U16`, `U32` | `uint32` |
| `U64`, `USize` | `uint64` |
| `I128`, `U128` | `bytes`: 16 bytes, little-endian two's complement |
| `F32` (and `F16`, `BF16`) | `float` |
| `F64` (and `F128`) | `double` |
| `String`, `Bytes` | `string`, `bytes` |
| nominal record `T` | `message T`, fields numbered in declaration order |
| structural record, tuple | a message; fields in label order (tuple fields `f0`, `f1`, ...) |
| `()` | an empty message |
| variant type `T = C1 ... \| C2 ...` | `message T { message C1 {...} ... oneof value { C1 c1 = 1; C2 c2 = 2; ... } }`; constructor fields are `f0 = 1`, `f1 = 2`, ... |
| `List[T]`, `Array[T]`, `Set[T]` | `repeated T` (packed for numbers and `Bool`) |
| `Map[K, V]` | `map<K, V>`, or `repeated` entry messages (`key = 1`, `value = 2`) when `K` cannot be a protobuf map key |
| `Option[T]` | `optional T` |

Signed integers use `sint32`/`sint64` (zigzag encoding), which keeps
negative numbers short; values are range-checked on decoding, so a client
cannot send 300 to an `I8` parameter. Where protobuf cannot nest a
`repeated` or `optional` value (a list of lists, an option in a list, a
list in a `oneof`), it is wrapped in a message with a single field
`value = 1` (`ListI64Wrapper`). Message names are built from type names
(`InventoryItem` for `inventory.Item`, `TupleStringI64`,
`ResultI64String`), with a numeric suffix if two would clash.

The encoder follows proto3 conventions (default-valued scalar fields are
omitted, fields are written in number order), and the decoder accepts any
valid encoding: fields in any order, packed or unpacked repeated fields,
unknown fields (ignored), and absent fields (defaults; an absent variant is
an error). Here is part of the `.proto` of the shop
([full file](../tests/services/shop.proto)):

```proto
service Inventory {
  rpc Item(ItemRequest) returns (ItemResponse);
  rpc Reserve(ReserveRequest) returns (ReserveResponse);
}

message InventoryItem {
  string sku = 1;
  string name = 2;
  sint64 stock = 3;
}

message ReserveRequest {
  sint64 arg1 = 1;
  string arg2 = 2;
}

message ReserveResponse {
  oneof result {
    sint64 value = 1;
    InventoryShortage error = 2;
  }
}

message PricingDiscount {
  message NoDiscount {}
  message Percent {
    sint64 f0 = 1;
  }
  oneof value {
    NoDiscount no_discount = 1;
    Percent percent = 2;
  }
}
```

Internally, both backends encode values with the canonical binary encoding
of the [pipe protocol](protocol.md) and transcode it to protobuf with a
schema the compiler derives from the types (`src/protobuf.rs`, which also
writes the schema as integers for the C runtime). The `.proto` file is
generated from the same schema.

### Errors and status codes

| `grpc-status` | Meaning |
|---|---|
| 0 `OK` | the call returned, or raised its `Error` (in the response's `error` field) |
| the error's code | the function raised `Error[GrpcError]` |
| 3 `INVALID_ARGUMENT` | the request could not be decoded |
| 4 `DEADLINE_EXCEEDED` | the call's deadline passed |
| 9 `FAILED_PRECONDITION` | the caller was built against a different interface (fingerprint) |
| 12 `UNIMPLEMENTED` | no such method |
| 13 `INTERNAL` | the function trapped (`grpc-message: trap: ...`) |

Any other failure (a refused connection, a reset stream, an HTTP error)
makes the calling fwp program trap with a message naming the service, the
address and the cause, unless the function's error type is `GrpcError`:
then every failure is raised as one ([above](#errors-and-status-codes)).

## Versioning

Client and server are usually built from the same source in one build, but
they are deployed separately, and an old client can meet a new server.

- **Between fwp programs** the interface is checked exactly. A client sends
  the fingerprint of the function's type and error type (the same 128-bit
  structural fingerprint as the [pipe protocol](protocol.md), over
  module-qualified names and the structure of every type involved) in the
  `fwp-fingerprint` header. If the server's differs, the call fails with
  `FAILED_PRECONDITION`: `interface mismatch: the caller of
  inventory.reserve was built against a different version of it`. There is
  no silent misinterpretation of fields.

## Transport details

These details are for transport implementers. Frames are the bounded pieces of
an HTTP/2 connection; a stream identifies one call. Flow-control windows bound
bytes in flight. HPACK compresses headers using indexed tables and Huffman codes
(shorter bit codes for common symbols). A GOAWAY frame announces connection
shutdown. Application-message gzip compression is separate from header encoding.

- HTTP/2 framing, SETTINGS, PING, WINDOW_UPDATE, RST_STREAM, GOAWAY and
  CONTINUATION frames, and flow control in both directions. fwp peers
  advertise large windows (1 GiB) and replenish the connection window as
  they read; they respect whatever windows the other side advertises.
- HPACK with the static and dynamic tables and Huffman decoding. fwp
  encodes headers as literals without indexing, which every decoder
  accepts and which needs no encoder state.
- Messages may be uncompressed or gzip-compressed under the rules in
  [compression](#compression); unsupported encodings are rejected.
- A client keeps one connection per address and multiplexes calls on it,
  one stream per call. If a reused connection turns out to be closed
  before the server saw the request (a GOAWAY, a refused stream, or a
  connection closed before any response), a unary call is retried once on
  a new connection.
- Each connection has a reader task, which parses frames and wakes the
  tasks waiting for them, and a writer task, which sends the frames they
  queue. A server starts a task per call as soon as its headers arrive,
  so calls run concurrently and a call reads its requests as they come;
  responses are sent within the flow control windows.
- TLS is the system's OpenSSL ([tls.md](tls.md)); everything else is
  fwp's own.

The implementation is written from scratch, in Rust for the interpreter
(`src/h2.rs`, `src/grpc.rs`) and in C for native programs
(`runtime/fwp_rt_h2.c`, `runtime/fwp_rt_grpc.c`, which are included only
in programs that use gRPC). The test suite
checks HPACK against the examples of RFC 7541 and the protobuf transcoder
against golden bytes in both languages, and talks to curl's HTTP/2 client
and, when Go is installed, to Go's HTTP/2 client and server.

## Limitations

- gzip is the only supported message compression. Clients enable it within
  `grpc.with-gzip`; messages below the size threshold remain uncompressed.
- After the first element, a failure of a remote `Iterator[R]` result
  traps in the client, since forcing an iterator cannot raise an error;
  `Iterator[Result[R, GrpcError]]` reports it instead.
- Clients retry a call only when a reused connection turns out to be
  closed before the server saw the request; there is no retry policy, no
  keepalive pinging and no load balancing.
- See [tls.md](tls.md#limitations) for the limits of TLS.
  A service's clients read their TLS options from `FWP_SERVICE_<M>_CA`,
  `_INSECURE`, `_SERVER_NAME`, `_CERT` and `_KEY` ([tls.md](tls.md#services)).
- A trap inside a task spawned by a served function stops the server (a
  trap in the function itself is reported to the caller).
- Services need the native target; WebAssembly programs cannot call them.
