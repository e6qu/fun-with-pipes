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
when it next suspends: when it sleeps, waits on a channel, awaits another
task, or waits on a socket. At that point it unwinds. Cancellation is not an
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
| waiting for sockets | `poll` in 50 ms slices, without the baton | non-blocking sockets on an epoll event loop (poll elsewhere) |
| scheduling | cooperative: tasks switch only when they suspend | cooperative, as in the interpreter |

On both backends, a task that computes without ever suspending is not
pre-empted. A native program in which every task waits forever stops with a
`deadlock` trap.

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
- **Client:** `http.get`, `http.post` and `http.send`. Each request uses one
  connection; responses may be chunked or sized by `content-length`.
- **TLS:** a config with `tls = Some (tls.server "cert.pem" "key.pem")`
  serves HTTPS, and the client fetches `https://` URLs, verifying
  certificates (`http.send-with` takes `TlsOptions`). TLS connections are
  `Conn`s, so the same server and client code runs over them; handshakes
  wait on the scheduler like any socket operation, in the connection's own
  task. See [tls.md](tls.md).

HTTP/3 and WebSocket are not implemented yet; HTTP/2 is used only
by [gRPC](grpc.md), whose servers and clients also run on the task
scheduler. Request bodies
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
