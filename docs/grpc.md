# gRPC

Any exported function is a gRPC method. Its parameters are the request,
its result the response, and its type says whether either is a stream. One
file of exported functions builds into one gRPC server, with server
reflection and health checking, whose `.proto` file `fwp proto` prints. In
the other direction, `fwp proto --import` turns any `.proto` file into an
fwp module of typed client functions and server routes. Calls and servers
run on the task scheduler: a call waits only in its own task, and a server
runs its calls concurrently. Everything is written from scratch, in Rust
for the interpreter and in C for native programs, and the two behave the
same.

```
$ fwp serve --grpc examples/grpc/weather.fwp --listen 127.0.0.1:50052
fwp: service weather listening on 127.0.0.1:50052
$ grpcurl -plaintext 127.0.0.1:50052 list
grpc.health.v1.Health
weather.Weather
$ grpcurl -plaintext -d '{"name": "Oslo", "lat": 60}' 127.0.0.1:50052 weather.Weather/Now
{
  "place": "Oslo",
  "celsius": 6
}
$ grpcurl -plaintext -d '{"arg1": 2, "arg2": {"name": "Oslo", "lat": 60}}' 127.0.0.1:50052 weather.Weather/Forecast
{
  "day": "1",
  "high": 9,
  "low": 2
}
{
  "day": "2",
  "high": 9.5,
  "low": 2.25
}
```

There are three ways in:

* **A file's exported functions as a service** (`--grpc`, this page):
  the functions are the methods, as they are.
* **A module of a larger program as a service** (`--service m`,
  [services.md](services.md)): one program, deployed as one executable or
  split into services that call each other; the calls stay ordinary calls
  in the source.
* **Any gRPC service from its `.proto` file** (`fwp proto --import`,
  [below](#importing-a-proto-file)): typed clients for services written
  in other languages, and servers of interfaces designed in protobuf.

The same functions are also a command-line program ([cli.md](cli.md)) and
a REST API ([rest.md](rest.md)); [interfaces.md](interfaces.md) compares
the three. [Tutorial 18](tutorials/18-grpc/README.md) walks through an
example, and [`examples/grpc`](../examples/grpc) has a weather service of
exported functions and a chat room built from a `.proto` file.

## Commands

| Command | Result |
|---|---|
| `fwp build app.fwp --grpc [-o server]` | a native gRPC server of the file's exported functions (`-O`, `--fat` and `--emit-c` apply) |
| `fwp serve --grpc app.fwp [--listen addr]` | the same server, interpreted |
| `fwp proto --grpc app.fwp [-o app.proto]` | its `.proto` file |
| `fwp proto --import service.proto [-o gen.fwp]` | an fwp module for the messages and services of a `.proto` file |

A server takes `--listen host:port`; without it, it listens on the address
in `FWP_SERVICE_<APP>` (for `app.fwp`; see [services.md](services.md#addresses)),
else `127.0.0.1:50051`. Port 0 picks a free port. With `--tls-cert file`
and `--tls-key file` (or `FWP_TLS_CERT` and `FWP_TLS_KEY`) it serves over
TLS ([below](#tls)). It writes `fwp: service app listening on host:port`
(`tls://host:port` with TLS) on stderr once it accepts connections.
Besides the program's methods it serves:

* **server reflection** (`grpc.reflection.v1.ServerReflection` and
  `v1alpha`), so `grpcurl` and other tools need no `.proto` file: the file
  descriptor is the same as the `.proto` that `fwp proto --grpc` prints;
* **health checking** (`grpc.health.v1.Health`, `Check` and `Watch`):
  `SERVING` for the server (an empty service name) and its services,
  `NOT_FOUND` (`SERVICE_UNKNOWN` for `Watch`) for others.

## Names

By default a file `weather.fwp` is the service `fwp.Weather`, and a
function `daily-high` is the method `DailyHigh`: its path is
`/fwp.Weather/DailyHigh`. Comment lines change that:

```fwp
# A weather service.
#
# grpc: weather.Weather

# the temperature at a place now
# grpc: Now
export now : Place -> Reading
```

* `# grpc: package.Service` in the file's leading comment (separated by a
  blank line from the first declaration) names the package and service of
  all methods; `# grpc: Service` names a service without a package.
* `# grpc: Method`, `# grpc: Service/Method` or
  `# grpc: package.Service/Method` above an `export` names that method;
  one file can serve several services of one package.

Two functions with the same path are an error, and so is a `.proto` file
with two packages. The annotations apply wherever the file's functions
are served or called: `--grpc` servers, `--service` servers and the client
stubs of split builds.

## Messages

A function's messages are derived from its types, with the mapping of
[services.md](services.md#types): records are messages, variants are
`oneof`s, lists are `repeated`, `Option` is `optional`, and integers are
`sint32`/`sint64` (zigzag). In addition:

| Function | Request message | Response message |
|---|---|---|
| `Place -> Reading` (nominal records) | `Place` itself | `Reading` itself |
| `I64 -> Place -> Day` | `ForecastRequest { arg1 = 1; arg2 = 2; }` | `ForecastResponse { value = 1; }` |
| `() -> String` | `WhoamiRequest {}` (a `()` parameter has no field) | `WhoamiResponse { value = 1; }` |
| `... -> R ! {Error[E]}` | as above | `oneof result { R value = 1; E error = 2; }` |
| `... -> R ! {Error[GrpcError]}` | as above | as without an error: errors are statuses |

A single parameter of a nominal record type is the request message itself,
and so is a nominal record result of a function that cannot fail (or fails
with `GrpcError`). Other functions have `Request`/`Response` messages named
after the method.

## Streaming

Whether a method streams is decided by its type:

| Function type | RPC | Messages |
|---|---|---|
| `A -> B -> R` | unary | one request `{arg1, arg2}`, one response `{value}` |
| `A -> Iterator[R]` | server streaming | a response per element |
| `A -> Channel[R] -> ()` | server streaming | a response per value sent to the channel |
| `Iterator[A] -> R` | client streaming | a request `{arg1}` per element |
| `Iterator[A] -> Iterator[R]` | bidirectional | |
| `Iterator[A] -> Channel[R] -> ()` | bidirectional | |

(Element messages follow the rule above: a nominal record element is its
own message.) A client stream must be the function's only parameter
besides an output channel; gRPC has no other request then.

* **`Iterator[R]` results** suit pure, lazy streams: the server forces
  the iterator one element at a time and sends each as it goes, within
  HTTP/2 flow control, so a slow client slows the computation down and an
  infinite iterator streams until the client cancels.
* **A final `Channel[R]` parameter** suits effectful streams: the function
  sends to the channel (`channel.send`), which sends a message on the
  stream; the stream ends when the function returns. `channel.send` gives
  `False` once the client has gone. Use it when values come from tasks,
  timers, other services or other calls (see the chat room in
  `examples/grpc`).
* **`Iterator[A]` parameters** are lazy: forcing an element waits for the
  next request message, so a bidirectional function can answer each
  request before the next one arrives. A request that cannot be decoded
  fails the call with `INVALID_ARGUMENT`.

Called from fwp, the same rules apply in the other direction, so a split
program behaves as one program: a remote `A -> Iterator[R]` returns a lazy
iterator that receives as it is forced (a failure before the first element
is raised in the caller; later failures trap, as forcing an iterator
cannot fail), a remote `A -> Channel[R] -> ()` sends each received value to
the caller's channel (with backpressure) and returns when the stream ends,
and a client stream sends the elements of the caller's iterator, then
reads the responses.

## Errors and status codes

| Status | When |
|---|---|
| `OK` (0) | the function returned; or it raised an `Error[E]` (`E` not `GrpcError`), which is in the response's `oneof` and raised again in an fwp caller |
| the error's `code` | the function raised `Error[GrpcError]`: `grpc.fail grpc.not-found "no such book"` (codes outside 1 to 16 are `UNKNOWN`) |
| `INVALID_ARGUMENT` (3) | the request could not be decoded |
| `DEADLINE_EXCEEDED` (4) | the call's deadline passed (below) |
| `FAILED_PRECONDITION` (9) | an fwp caller was built against a different version of the function (the `fwp-fingerprint` of [services.md](services.md#versioning)) |
| `UNIMPLEMENTED` (12) | no such method |
| `INTERNAL` (13) | the function trapped (`grpc-message: trap: ...`; the server logs the trap and keeps serving), or raised an error the response cannot hold |
| `CANCELLED` (1) | the server cancelled the call |

On the client side, a function with `Error[GrpcError]` (and every function
of a module from `fwp proto --import`) raises every failure as a
`GrpcError`: a non-`OK` status, `UNAVAILABLE` (14) when the service cannot
be reached or the connection is lost, `DEADLINE_EXCEEDED` for
`grpc.with-deadline`. Other client stubs of split builds trap on failures,
as [services.md](services.md#what-stays-the-same-and-what-changes)
describes; a trap on the server traps the caller with the same message.

```fwp
# a status: NOT_FOUND for "ghost"
export lookup : String -> HelloReply ! {Error[GrpcError]}
lookup = if
    (eq "ghost")
    (grpc.fail grpc.not-found)
    (make HelloReply { message = id })
```

## Deadlines and cancellation

Deadlines use the task machinery of [concurrency.md](concurrency.md):

* **Server.** A call's `grpc-timeout` becomes the deadline of the task
  serving it. When it passes, the task (and every task it started) is
  cancelled at its next suspension point, and the client gets
  `DEADLINE_EXCEEDED`. When the client cancels the call (`RST_STREAM`) or
  its connection closes, the task is cancelled too. The server logs both:
  `fwp: deadline exceeded (in weather.watch)`,
  `fwp: call cancelled by the client (in weather.watch)`.
* **Client.** A call made by a task with a deadline (`task.within`,
  `task.deadline`) sends the time left as `grpc-timeout`. When the
  deadline passes, the task is cancelled as anywhere else (`task.within`
  gives `None`), and the call is reset. Deadlines propagate: a server
  that calls other services does so from a task whose deadline is its
  call's.
* **`grpc.with-deadline d f`** gives the calls `f` makes a deadline of
  their own: they fail with `DEADLINE_EXCEEDED` (a `GrpcError`) when it
  passes, and the task goes on.

```fwp
task.within 2s (const 20 | greeter.slow) | echo,
task.within 100ms (const 2000 | greeter.slow) | echo,
()
    | attempt (const (const 2000 | greeter.nap) | grpc.with-deadline 100ms)
    | echo,
```

## Metadata

| Function | |
|---|---|
| `grpc.metadata ()` | the request headers of the call the task serves, as `(name, value)` pairs with lower-case names (without pseudo-headers and `content-type`, `te`, `grpc-timeout`, `grpc-encoding`, `grpc-accept-encoding`, `fwp-fingerprint`); `[]` outside a call |
| `grpc.header name` | one of them |
| `grpc.with-metadata pairs f` | `f`'s calls send these headers too (names are lower-cased; nested uses add up) |

Tasks started by a served function see its call's metadata. Binary
headers (`-bin`) are passed as their base64 text.

## Concurrency

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

## TLS

Servers and clients speak gRPC over TLS (HTTP/2 with ALPN `h2`, as every
gRPC implementation does), with the system's OpenSSL; h2c stays the
default. [tls.md](tls.md#grpc) has the details.

```
$ fwp serve --grpc examples/grpc/weather.fwp --tls-cert server.pem --tls-key server.key
fwp: service weather listening on tls://127.0.0.1:50051
$ grpcurl -cacert ca.pem localhost:50051 list
grpc.health.v1.Health
weather.Weather
$ SSL_CERT_FILE=ca.pem FWP_SERVICE_WEATHER=tls://localhost:50051 fwp run --service weather examples/grpc/forecast-client.fwp
Ok (weather.Place {lat = 38.7, name = "Lisbon"})
...
```

* **Servers**: `--tls-cert` and `--tls-key` (or `FWP_TLS_CERT` and
  `FWP_TLS_KEY`) for `--grpc` and `--service` servers;
  `grpc.serve-tls (tls.server "cert.pem" "key.pem") address routes` for
  routes.
* **Clients**: the address `tls://host:port` (or `grpcs://host:port`), in
  `FWP_SERVICE_<M>` or as the address of a generated client function or of
  `grpc.open`. The server's certificate must be valid for `host` and
  signed by a CA the system trusts, or one in `SSL_CERT_FILE`.

## Importing a .proto file

```
$ fwp proto --import chat.proto -o chat.fwp
```

makes a module of fwp types, codecs, client functions and server routes.
It is plain fwp built on `lib/protobuf.fwp` and `lib/grpc.fwp`, so both
backends run it, and it is formatted like any other file.

| `.proto` | fwp |
|---|---|
| `message HelloRequest { ... }` | `HelloRequest = { ... }`, with `hello-request.encode`, `.decode`, `.default` and `.codec` |
| a nested `message Point` in `HelloRequest` | `HelloRequestPoint` |
| a message without fields, `google.protobuf.Empty` | `()` |
| `enum Mood { MOOD_UNKNOWN = 0; MOOD_HAPPY = 1; }` | `Mood = \| Mood.Unknown \| Mood.Happy` (the enum's prefix is dropped; unknown numbers read as the first value) |
| `string`, `bytes`, `bool` | `String`, `Bytes`, `Bool` |
| `int32`, `sint32`, `sfixed32` / `int64`, `sint64`, `sfixed64` | `I32` / `I64` |
| `uint32`, `fixed32` / `uint64`, `fixed64` | `U32` / `U64` |
| `float` / `double` | `F32` / `F64` |
| `repeated T` | `List[T]` (numbers packed; packed and unpacked are read) |
| `map<K, V>` | `Map[K, V]` |
| `optional T` | `Option[T]` |
| `oneof shape { ... }` in `Figure` | a field `shape: Option[FigureShape]` with `FigureShape = \| FigureShape.Circle Circle \| ...` |
| a message field | the message (its default when absent); `Option` where messages contain each other |
| a field named like a keyword (`type`) | `type-field` |
| types of other packages (`google.protobuf.Timestamp`) | prefixed with the package's last part: `ProtobufTimestamp` |

The well-known `Empty`, `Timestamp`, `Duration`, `Any` and the wrappers
(`StringValue`, ...) are built in; other imports are read from the
directory of the file. Options, `reserved` and extensions are skipped;
groups are rejected.

For each method `SayHello` of a service `Greeter`:

```fwp
# rpc SayHello(HelloRequest) returns (HelloReply): a call to the service at an address
greeter.say-hello : String -> HelloRequest -> HelloReply ! {Network, Error[GrpcError]}

# the route serving `SayHello` with a function
greeter.say-hello.route : (HelloRequest -> HelloReply ! {Async, IO, Network, FileIO, Error[GrpcError]}) -> GrpcRoute
```

Client functions take the address first. Streaming methods follow the
rules above: a server stream sends its responses to a channel, a client
stream takes an `Iterator`, and a bidirectional call sends the whole
request iterator, then passes the responses to the channel. A record
`GreeterServer` holds an implementation of every method, and
`greeter.routes` turns one into routes for `grpc.serve`:

```fwp
main =
    16
    | channel.make
    | tap (make { 0 = id, 1 = const Nil } | iter.later (loop step) | task.spawn)
    | make chat.RoomServer { post = post, subscribe = subscribe }
    | chat.room.routes
    | grpc.serve (args () | head | option.unwrap-or "127.0.0.1:50051")
```

`grpc.serve address routes` serves until its task is cancelled, with
health checking but without reflection (its routes carry no
descriptors). Importing the `.proto` that `fwp proto --grpc` prints for an
fwp service gives a client of it in any fwp program (the test suite does
this round trip).

## The libraries

`lib/grpc.fwp` ([stdlib.md](stdlib.md#grpc)) has `GrpcError` and the
status codes (`grpc.not-found`, ..., `grpc.fail`, `grpc.code-name`), the
metadata and deadline functions, the typed calls and handlers the
generated modules use (`grpc.unary`, `grpc.server-streaming`, ...,
`grpc.unary-handler`, ...), `grpc.serve` and `grpc.route`, and a
lower-level stream API: `grpc.open address path`, `grpc.send`,
`grpc.close-send`, `grpc.recv` (`None` at the end) and `grpc.cancel`.
`lib/protobuf.fwp` ([stdlib.md](stdlib.md#protobuf)) is the wire format:
`PbCodec`s of every protobuf type, field writers (`pb.field`,
`pb.repeated`, `pb.optional`, `pb.map`, `pb.encode`) and readers
(`pb.decode`, `pb.get`, `pb.get-repeated`, ...).

## Interoperability

The test suite (`tests/grpc.rs`) runs interpreted and native servers
against interpreted and native clients in every combination, and checks
them against:

* **grpcurl** (grpc-go), when installed: listing and describing services
  through reflection, unary and streaming calls with JSON, metadata,
  deadlines, statuses and health checks;
* **Go's HTTP/2 client** (the standard library), when Go is installed:
  every kind of call, with metadata, a deadline and statuses;
* **protoc**, when installed, which must accept the generated `.proto`.

[services.md](services.md#transport-details) describes the HTTP/2 and
HPACK implementation.

## Limitations

* TLS has no client certificates, and clients trust only the system's CA
  certificates or `SSL_CERT_FILE` ([tls.md](tls.md#limitations)).
* No compression: a compressed message is rejected.
* No response metadata: servers send only `grpc-status` and
  `grpc-message`, and clients do not expose response headers or
  trailers.
* Servers of `grpc.serve` routes have no reflection.
* A bidirectional call from an imported client sends all its requests
  before reading responses (fwp-to-fwp calls between split services
  behave the same); a server reads requests and writes responses as
  they come.
* After the first element, a failure of a remote `Iterator` result traps
  in the client, since forcing an iterator cannot raise an error.
* Clients retry a call only when a reused connection turns out to be
  closed before the server saw the request; there is no retry policy, no
  keepalive pinging and no load balancing.
* WebAssembly targets have no sockets: programs that use gRPC are
  rejected for `wasm32-wasi` and `wasm32-browser`.
