# Concurrency, networking and HTTP

## Tasks

Concurrency is structured. `task.spawn` starts a task as a child of the
current one. A task finishes only after all of its children have finished,
and a program's `main` (or a test) waits for every task it started.

`task.await` returns `None` for a cancelled task. The functions are
listed in the [standard library reference](stdlib.md#tasks-and-channels).

A spawned function may perform IO but must handle its own errors, because
`Error` is not among its allowed effects. If a task fails in some other way
(a trap, or `exit`), the whole process stops, as it does in a
single-threaded program.

Cancelling a task cancels its whole subtree. A task notices cancellation
when it next suspends (when it sleeps, waits on a channel, awaits another
task, or waits on a socket) or reaches the end of its time slice (see
[preemption](#preemption)), so a task that only computes is cancelled
too. At that point it unwinds. Cancellation is not an
error, so `attempt` does not catch it. A deadline cancels its task when it
passes, so a deadline set on a task also applies to all of its children.
`task.scope f` waits for the tasks that `f` started; if `f` fails, those
tasks are cancelled first.

Channels are bounded FIFO queues: `channel.send` returns `False` once the
channel is closed, and `channel.recv` returns `None` once it is closed and
empty. A sender that finds the channel full waits, which propagates backpressure.

`loop : (s -> Step[s, r] ! e) -> s -> r ! e` runs a step function in
constant stack space, which suits accept loops and other long-running
processes.

### Runtime

| | interpreter | native |
|---|---|---|
| task | an OS thread; the threads take turns holding a fair baton, so only one evaluates at a time | a green thread (`ucontext`) with its own stack, on one OS thread |
| task, WebAssembly | a fiber that the JavaScript host switches with JavaScript Promise Integration (fwp.wasm, the playground) | a fiber, as in the interpreter (`wasm32-wasi`, `wasm32-browser`) |
| waiting for sockets | `poll` in 50 ms slices, without the baton | non-blocking sockets on an epoll event loop (poll elsewhere) |
| scheduling | preemptive at safe points: a task that used up its slice hands the baton to the next task waiting for it | the same, switching green threads |

A native program in which every task waits forever stops with a
`deadlock` trap, as does any program on WebAssembly.

### Preemption

A task runs until it suspends or until its *slice* ends. The slice is a
count of safe points, not a time: every entry to a function of the
program, and every iteration of `loop`, is a safe point, and after
10000 of them (`FWP_PREEMPT=n` sets another count, `FWP_PREEMPT=0` turns
preemption off) the task:

1. unwinds if it was cancelled or its deadline passed, so that
   `task.within 100ms spin` returns `None` after 100 ms even if `spin`
   never suspends;
2. otherwise lets the tasks that are ready run first (on the native
   backend, also those whose timers passed or whose sockets became ready),
   then continues with a new slice.

A task gets a new slice whenever it starts or resumes after suspending.
Since the slice is counted the same way by the interpreter and by native
programs (where `fwp build` adds a decrement and a branch to the entry of
each function of a program that uses tasks or services, and nothing to
other programs), a program interleaves the same on both, from run to run:
three tasks that each compute and print interleave their lines in one
fixed order. Where tasks also wait for timers or sockets, the order
depends on time, as before. One exception: callbacks of the runtime's own
algorithms, such as the comparisons of a sort, may be called a different
number of times by the two backends.

The cost is small: a native program spends one decrement and a
never-taken branch per function call (no measurable difference on
`fib 35` in two tasks), and switching happens once per slice. The
collector finds the values of a task that is switched out at a safe point
as at any other switch: on its stack and in its saved registers.

Tasks started in a row get their turns in the order they were started,
on both backends (the interpreter's threads take their places in the
queue for the baton when they are started, not when the operating system
first runs them).

On WebAssembly, which cannot switch stacks by itself, tasks need an engine
with JavaScript Promise Integration (JSPI): Chrome and Edge 137 and later,
or node 24 (node 22 with `--experimental-wasm-jspi`); compiled programs built with
`--wasm-async=asyncify` run their tasks in any JavaScript engine. Waiting for a timer suspends
the program on a JavaScript timer, so a page is not kept busy. Sockets
remain unavailable there. The hosts and the details are in the
[reference](reference.md#tasks-on-webassembly).

## Networking

`tcp.listen`, `tcp.accept`, `tcp.accept-for`, `tcp.connect`, `tcp.read`,
`tcp.read-for`, `tcp.write`, `tcp.write-for`, `tcp.close`, `udp.bind`,
`udp.send-to`, `udp.recv-from` and `dns.resolve`. Addresses are
`"host:port"` strings, with a non-empty host (IPv6 in brackets) and a
decimal port up to 65535; failures raise `Error[IoError]`. Only the calling
task is suspended while a socket operation waits. One task may read a
connection while another writes to it, and closing a socket wakes the
tasks waiting on it, which then fail with a "closed" error.

`signal.shutdown-requested ()` becomes true after SIGINT or SIGTERM (its
first call installs the handlers), or after `signal.request-shutdown ()`.

## HTTP

A handler is an ordinary function, and middleware is ordinary composition:

```
handler : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
handler = http.count | timeout 5s | auth.bearer "secret" | service | json.response
```

- **Routing:** `http.router [http.route "GET" "/items/:id" item, ...]`
  binds path parameters, which `http.param` reads back. When no route
  matches, the router answers 404, or 405 if the path matches a route for a
  different method. HEAD requests use the GET routes.
- **Requests:** `http.header`, `http.query-param`, `http.body-text`,
  `http.form` and `http.json-body`.
- **Responses:** `http.text`, `http.json`, `json.response`, `http.respond`,
  `http.with-header`, and `http.stream`, which produces a chunked body from a
  task. `http.fail status message` aborts a handler with that response.
- **Server:** `http.serve config handler` (or `http.serve-on listener`) runs
  each connection in its own task. Requests on a connection are kept alive.
  - `max-connections` bounds the number of connections; when all slots are
    taken, the server stops accepting until one frees up.
  - `max-header-bytes` (431) and `max-body-bytes` (413) bound request sizes.
  - `max-requests-per-connection` limits keep-alive reuse.
  - `idle-timeout` (30 s) applies while waiting for a request.
    `header-timeout` (10 s) bounds the time from a request's first byte to
    the end of its head, and `body-timeout` (30 s) the time to receive its
    body; when either passes, the client gets 408. `write-timeout` (30 s)
    bounds writing each response (or each chunk of a streamed one), after
    which the connection is dropped.
  - `request-timeout` bounds each handler, which runs in its own task; when
    the timeout passes, the handler is cancelled and the client gets 503.
  - On SIGINT or SIGTERM, the server stops accepting and lets in-flight
    requests finish within `shutdown-grace`, then cancels whatever is left.
- **Client:** `http.get`, `http.post` and `http.send`. An HTTP/1.1
  request uses one connection; responses may be chunked or sized by
  `content-length`. HTTP/2 connections are kept and shared (below).
- **TLS:** a config with `tls = Some (tls.server "cert.pem" "key.pem")`
  serves HTTPS, and the client fetches `https://` URLs, verifying
  certificates (`http.send-with` takes `TlsOptions`). TLS connections are
  `Conn`s, so the same server and client code runs over them; handshakes
  wait on the scheduler like any socket operation, in the connection's own
  task. See [tls.md](tls.md).

Request bodies
with a transfer encoding are rejected with 501, and requests whose
`content-length` is not a plain decimal number or appears more than once
with 400, so that a request's length is never ambiguous. A response whose
status is not three digits or that has a header that cannot be written as
is (a name that is not a token, a value with CR, LF, NUL or another
control character) is replaced by a 500. The client likewise refuses such
methods and headers, and URLs with spaces or control characters; its
`host` header carries the port when it is not the scheme's default.

`examples/server/api.fwp` is a complete JSON API. `tests/http_server.rs`
drives it, both interpreted and native, with curl, a concurrent keep-alive
load test, and a SIGTERM shutdown while a request is in flight.

### HTTP/2

`http.serve` (and so every REST server) speaks HTTP/2 as well as
HTTP/1.1, with the same handlers:

- Over TLS, the server offers `h2` and `http/1.1` with ALPN and prefers
  `h2`; a client that offers only HTTP/1.1 gets HTTP/1.1.
- On cleartext connections, a connection that starts with HTTP/2's
  connection preface is HTTP/2 (h2c with prior knowledge, as
  `curl --http2-prior-knowledge` and gRPC clients connect). A request
  with `Upgrade: h2c` and `HTTP2-Settings` (as `curl --http2` sends)
  switches the connection: the server answers 101, reads the client's
  preface, and answers the request on stream 1 (its body was read
  first, as for any request); the settings in the header are not used,
  as the client's SETTINGS frame follows. Over TLS the upgrade is
  ignored (ALPN chooses).
- `http2 = False` in the config turns both off.

Every stream runs in its own task and becomes the same `Request`
(`version` is `"HTTP/2"`, `:authority` is the `host` header), so routing,
middleware and `http.fail` work unchanged. A `Body.Full` response is sent
with `content-length`, and a `Body.Stream` as DATA frames, one per chunk,
with HTTP/2's flow control giving the producer backpressure. The limits
apply per stream: `max-header-bytes` (431), `max-body-bytes` (413),
`body-timeout` (408) and `request-timeout` (503).
`max-requests-per-connection` counts streams: after the last one the
server sends GOAWAY and refuses new streams. `idle-timeout` closes a
connection without open streams, at most 128 streams are open at once
(`SETTINGS_MAX_CONCURRENT_STREAMS`), and on SIGINT or SIGTERM a
connection sends GOAWAY and closes once its streams have finished.
`write-timeout` does not apply to HTTP/2 streams, whose writes wait on
the client's flow control.

The client (`http.send`) uses HTTP/2 when a TLS server chooses `h2` with
ALPN, and keeps that connection for later requests to the same origin
(with the same TLS options), multiplexing requests from different tasks
on it; HTTP/1.1 requests still use one connection each.
`http.send-using options request` takes `ClientOptions`, whose `version`
forces HTTP/1.1 (`HttpVersion.Http1`) or HTTP/2 (`HttpVersion.Http2`,
also on cleartext connections, with prior knowledge):

```
http.client | with { version = HttpVersion.Http2 }
```

The HTTP/2 framing, HPACK and flow control are those of gRPC
(`src/h2.rs`, `runtime/fwp_rt_h2.c`); the connections and streams of
`src/grpc.rs` and `runtime/fwp_rt_grpc.c` serve HTTP streams too
(`src/h2web.rs`, `runtime/fwp_rt_http2.c`). No server push, priorities
or trailers in responses.

### WebSocket

`http.websocket f` is a handler that upgrades an HTTP/1.1 request to a
WebSocket session (RFC 6455) and runs `f` with it; `ws.connect url`
connects to a `ws://` or `wss://` URL. A `WebSocket` is a pair of
channels of `WsMessage`s (`Text`, `Binary`, `Ping`, `Pong`, `Close code
reason`):

```
echo : WebSocket -> () ! {Async, IO, Network, FileIO}
echo = loop echo-step

echo-step : WebSocket -> Step[WebSocket, ()] ! {Async, IO, Network, FileIO}
echo-step = fork echo-got id ws.recv

echo-got : WebSocket -> Option[WsMessage] -> Step[WebSocket, ()] ! {Async, IO, Network, FileIO}
echo-got = curry (match
    (_, Some (WsMessage.Close _ _)) -> curry3 (const (Stop ()))
    (_, Some _) -> curry (tap (fork ws.send .1 .0) | .0 | Again)
    (_, None) -> const (Stop ()))

routes = http.router [http.route "GET" "/ws" (http.websocket echo)]
```

- `ws.recv` waits for the next message, `ws.send` and `ws.send-text`
  send one (`False` once the session is closing), and `ws.close` or
  `ws.close-with code reason` start the closing handshake; when `f`
  returns, the server closes the session itself. `incoming` ends with a
  `WsMessage.Close` before it is closed.
- Pings are answered with pongs, fragmented messages are reassembled, a
  client masks every frame and a server requires masked frames, and text
  must be UTF-8. A message (all its fragments together) longer than
  `max-message-bytes` (`WsConfig`, 1 MiB by default; `http.websocket-with`
  and `ws.connect-with` take one) ends the session with code 1009; a frame
  that breaks the protocol, 1002; text that is not UTF-8, 1007.
- The server answers a request that is not an upgrade with 400, and one
  for another WebSocket version than 13 with 426. The upgrade is a
  `Body.Upgrade` response (status 101), which hands the connection to a
  function once the response head is written; it works over HTTPS too
  (`wss://`). WebSocket over HTTP/2 (RFC 8441) is not supported.
- `Sec-WebSocket-Accept` uses SHA-1 and base64 written from scratch. A
  session is three tasks (reader, writer and a supervisor that closes the
  connection), all fwp code over `tcp.read` and `tcp.write`; framing,
  masking and the accept key are primitives (`src/h2web.rs`,
  `runtime/fwp_rt_http2.c`).
- Compression (`permessage-deflate`, RFC 7692): with `compress = Some n`
  in its `WsConfig`, a client offers it and a server accepts an offer it
  can honour, both without context takeover, so each message is
  compressed on its own (as a stream's chunks are, below). Text and
  binary messages of at least n bytes go out compressed (RSV1); a
  compressed message in is decompressed up to `max-message-bytes`
  (1009 beyond, 1007 for data that does not decompress), and RSV1
  without an agreement, or on a continuation or control frame, is 1002.
- Subprotocols (`Sec-WebSocket-Protocol`): a client offers the
  `protocols` of its `WsConfig`, and a server picks the first of its own
  `protocols` (in its order of preference) that the client offered. The
  session's `protocol` is the one chosen, or `None`; a client refuses an
  answer naming a protocol it did not offer.

`examples/server/chat.fwp` is a chat server; tutorial 20 walks through
WebSocket and HTTP/2.

### Compression

- **Responses:** `compress = Some n` in the config compresses response
  bodies of at least `n` bytes with gzip, or deflate, for clients whose
  `Accept-Encoding` accepts it (a coding with `q=0` is refused), adding
  `content-encoding` and `vary: accept-encoding`. The middleware
  `http.compress n handler` does the same for one handler. Streamed
  bodies, whatever their length, are compressed with gzip as they go:
  each chunk is a block of its own, flushed, so the client decodes it
  when it arrives (a client that accepts only deflate gets the stream as
  it is). Responses that have a `content-encoding` already, statuses 204
  and 304, and types that are compressed already (images but SVG, video,
  audio, archives) are left alone.
- **Requests:** bodies with `content-encoding: gzip` (or `x-gzip`) or
  `deflate` are decompressed before the handler sees them, which then
  sees no `content-encoding`; `max-body-bytes` bounds the decompressed
  size (413). Other codings get 415, and malformed data 400.
- **Client:** `http.send` sends `accept-encoding: gzip, deflate` (unless
  the request has an `accept-encoding`) and decompresses responses, which
  then have no `content-encoding` (`compression = False` in
  `ClientOptions` turns this off).
- `gzip.compress`, `gzip.decompress`, `deflate.compress` and
  `deflate.decompress` (the zlib format of HTTP's `deflate`; raw DEFLATE
  is accepted too) are the codecs, written from scratch
  (`src/gzip.rs`, `runtime/fwp_rt_h2.c`): the encoder uses fixed Huffman
  codes and a greedy LZ77 search, so it compresses less than zlib.
  Decompression stops at 64 MiB (`gzip.decompress-max` takes a limit).

`tests/web.rs` drives `tests/web/server.fwp` and `tests/web/client.fwp`
on both backends: curl over h2c and h2 with ALPN, concurrent streams on
one connection, compression, the fwp client against the fwp server in
every pairing of the interpreter and native code (also over TLS), and
WebSocket from raw sockets (handshake, fragmentation, close codes, an
oversized message) and from node's WebSocket client.

## JSON, URLs, logs and metrics

The signatures of everything below are in the
[standard library reference](stdlib.md#http).

- **JSON:** `json.parse` (errors give the byte offset), `json.encode`,
  `json.get`, `json.at` and `json.as-*`. `null` is the explicit variant
  `Json.Null`. `json.write` and `json.read` convert values of any
  encodable type to JSON text and back, with errors that name the JSON
  path (`$.items[2].price: expected a number, got "x"`); the mapping is in
  [rest.md](rest.md#json). Exported functions can be served as REST
  endpoints without a handler ([rest.md](rest.md)).
- **URLs:** `url.parse`, `url.encode`, `url.decode`, `form.parse` and
  `form.encode`.
- **Logs:** `log.info`, `log.warn`, `log.error` and
  `log.event level message fields` write logfmt lines to stderr.
- **Metrics:** `metrics.add`, `metrics.inc`, `metrics.set`,
  `metrics.observe` and `metrics.render` (the Prometheus text format).
