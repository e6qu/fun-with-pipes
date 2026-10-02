# Services: one program, two deployments

An fwp program can be compiled as **one executable** (a "fat" binary
holding every module; not to be confused with `fwp build --fat`, which
holds one copy per CPU level), in which its modules call each other's
functions directly, or as **separate executables** that call each other
over gRPC. The source is the same in both builds; only the
build command differs. You can write, test and debug a system as one
program, then deploy parts of it as services when the need arises (to
scale a part on its own, to isolate it, to call it from another language)
and go back just as easily.

```
$ fwp build shop.fwp -o shop                    # one executable
$ fwp build shop.fwp --service inventory --service pricing -o out
$ ls out                                        # three executables
inventory  pricing  shop
```

[Tutorial 14](tutorials/14-services/README.md) walks through a small
example. The same exported functions can also be command-line programs
and REST endpoints; [interfaces.md](interfaces.md) compares the three. The shop in [`examples/services`](../examples/services/main.fwp)
splits into two services, one of which calls the other.

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
| `fwp run --service m... app.fwp [args]` | runs `main` in the interpreter, calling the named modules remotely |
| `fwp serve --service n... app.fwp m [--listen addr]` | serves module `m` with the interpreter; its calls to the modules named by `--service` are remote |
| `fwp proto app.fwp [--service m]...` | prints the `.proto` file of the named services (by default, of every imported module that exports functions) |

To serve the exported functions of a file on their own, without a program
around them, use `fwp build --grpc` or `fwp serve --grpc`
([grpc.md](grpc.md)); a split build's servers and clients are the same
gRPC servers and clients, with the streaming, deadlines, metadata,
reflection and health checking that page describes.

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
[tls.md](tls.md#grpc).

`<M>` is the module name in upper case with every other character
replaced by `_`: `inventory` is `FWP_SERVICE_INVENTORY`, `shop.billing` is
`FWP_SERVICE_SHOP_BILLING`. The variable is read at each call, so a
process can be pointed elsewhere without rebuilding.

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

A function can be served when it is exported, has a monomorphic type and
at least one parameter, and every parameter, its result and its `Error`
type can be encoded: numbers, `Bool`, `String`, `Bytes`, `Duration`,
records, tuples, `()`, variants, `List`, `Array`, `Set`, `Map` and
`Option`, in any combination. An `Iterator` result or parameter and a
final `Channel` parameter are streams ([grpc.md](grpc.md#streaming)).
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

## The wire format

Calls are [gRPC](https://grpc.io/docs/what-is-grpc/) calls over HTTP/2
cleartext with prior knowledge (h2c), or over TLS with ALPN `h2` for
`tls://` addresses ([tls.md](tls.md#grpc)): any gRPC client and server can
take part, given the `.proto` file (or server reflection).

- **Names.** The package is `fwp`, a module `inventory` is the service
  `Inventory` (`shop.inventory` is `ShopInventory`), and a function
  `unit-price` is the method `UnitPrice`. The path of a call is
  `/fwp.Inventory/UnitPrice`. `# grpc:` lines in the module change them
  ([grpc.md](grpc.md#names)).
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
then every failure is raised as one ([grpc.md](grpc.md#errors-and-status-codes)).

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
- **For other clients** protobuf's compatibility rules apply, and they do
  not send the fingerprint. Field numbers come from declaration order, so
  appending a field to a record keeps old clients working (they ignore the
  new field, and the server reads its default when old clients omit it);
  inserting, removing or reordering fields, or renaming a function or a
  module, breaks them. Regenerate the `.proto` with `fwp proto` and treat
  it as the published contract.

## Transport details

- HTTP/2 framing, SETTINGS, PING, WINDOW_UPDATE, RST_STREAM, GOAWAY and
  CONTINUATION frames, and flow control in both directions. fwp peers
  advertise large windows (1 GiB) and replenish the connection window as
  they read; they respect whatever windows the other side advertises.
- HPACK with the static and dynamic tables and Huffman decoding. fwp
  encodes headers as literals without indexing, which every decoder
  accepts and which needs no encoder state.
- Messages are uncompressed; a compressed message is rejected.
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

- No compression; see [grpc.md](grpc.md#limitations) for the limits of
  the gRPC implementation, and [tls.md](tls.md#limitations) for those of
  TLS.
- Native servers allocate from the bump heap and never free (see
  [design](design.md)), so a long-running native service grows with the
  data it handles. Interpreted servers free memory.
- A trap inside a task spawned by a served function stops the server (a
  trap in the function itself is reported to the caller).
- Services need the native target; WebAssembly programs cannot call them.
