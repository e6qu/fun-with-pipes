# Concurrency, networking and HTTP

## Tasks

Concurrency is structured. `task.spawn` starts a task as a child of the
current one. A task finishes only after all of its children have finished,
and a program's `main` (or a test) waits for every task it started.

```
task.spawn : (() -> a ! {Async, IO, Network, FileIO}) -> Task[a] ! {Async}
task.await : Task[a] -> Option[a] ! {Async}      # None if it was cancelled
task.cancel : Task[a] -> () ! {Async}
task.within : Duration -> (() -> a ! {...}) -> Option[a] ! {Async}
task.deadline : Duration -> a -> a ! {Async}     # also `timeout`
task.scope : (() -> a ! {Async | e}) -> a ! {Async | e}
task.sleep, task.yield, task.cancelled, task.map
```

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

Channels are bounded FIFO queues:

```
channel.make : I64 -> Channel[a] ! {Async}
channel.send : Channel[a] -> a -> Bool ! {Async}   # False once closed
channel.recv : Channel[a] -> Option[a] ! {Async}   # None once closed and empty
channel.recv-for, channel.close
```

A sender that finds the channel full waits, which propagates backpressure.

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
`tcp.read-for`, `tcp.write`, `tcp.close`, `udp.bind`, `udp.send-to`,
`udp.recv-from` and `dns.resolve`. Addresses are `"host:port"` strings, and
failures raise `Error[IoError]`. Only the calling task is suspended while a
socket operation waits.

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
  - `idle-timeout` applies while waiting for a request.
  - `request-timeout` bounds each handler, which runs in its own task; when
    the timeout passes, the handler is cancelled and the client gets 503.
  - On SIGINT or SIGTERM, the server stops accepting and lets in-flight
    requests finish within `shutdown-grace`, then cancels whatever is left.
- **Client:** `http.get`, `http.post` and `http.send`. Each request uses one
  connection; responses may be chunked or sized by `content-length`.

TLS, HTTP/2, HTTP/3 and WebSocket are not implemented yet. Request bodies
with a transfer encoding are rejected with 501.

`examples/server/api.fwp` is a complete JSON API. `tests/http_server.rs`
drives it, both interpreted and native, with curl, a concurrent keep-alive
load test, and a SIGTERM shutdown while a request is in flight.

## JSON, URLs, logs and metrics

- **JSON:** `json.parse` (errors give the byte offset), `json.encode`,
  `json.get`, `json.at` and `json.as-*`. `null` is the explicit variant
  `Json.Null`.
- **URLs:** `url.parse`, `url.encode`, `url.decode`, `form.parse` and
  `form.encode`.
- **Logs:** `log.info`, `log.warn`, `log.error` and
  `log.event level message fields` write logfmt lines to stderr.
- **Metrics:** `metrics.add`, `metrics.inc`, `metrics.set`,
  `metrics.observe` and `metrics.render` (the Prometheus text format).
