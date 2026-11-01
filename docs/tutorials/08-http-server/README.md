# 8. An HTTP server

Read lessons 1–4 and 6 first. HTTP is a request/response protocol: a client
asks for a path such as `/hello`, and a server returns a status number, headers
(named metadata), and a body (the content). `GET` reads a resource; `POST` sends
content for processing. JSON is a text format for objects, lists and values.
A **route** chooses a function by request method and path. **Middleware** wraps
that function to add behavior such as authentication or a deadline.

You need `curl`, a terminal HTTP client. Here `-s` hides its progress meter,
`-H` sets a header, `-d` sends a body and implies POST, and `-w` prints response
metadata. `127.0.0.1` is this computer; the number after `:` is the port.
The shell's `&` starts a server in the background and `$!` identifies that process
so the session can stop it with `kill`.

This tutorial writes an HTTP server by hand, runs it, and calls it with
`curl`. (To serve functions as a REST API with no HTTP code at all, see
[tutorial 17](../17-rest-and-openapi/README.md).)

To follow along, go to this directory (`cd docs/tutorials/08-http-server`).
The sessions below run exactly as shown: the test suite runs them.

## Reading the example

`hello` reads an optional path parameter, substitutes "world" if absent and
builds a 200 text response. `sum-numbers` requires a JSON array, then
`filter-map json.as-number` converts numeric members to `F64` and drops other
members: it does not reject a mixed array. `F64` is a 64-bit floating-point type;
this example therefore uses floating-point rounding when adding.

The JSON tree
itself keeps each number's exact text. `json.encode-value` converts the computed
sum back into a JSON value for the response. `admin` checks the demonstration
bearer token before returning a fixed message. `const` discards the authenticated request;
it does not skip the preceding check.

`serve` opens a TCP listener. `tap` prints its address while keeping that listener
as the pipeline value. `fork http.serve-on id (const (...))` supplies the listener
and the fixed configuration/handler pair to the server. `attempt` turns a startup
failure into `Err`; the final match prints its message and exits with status 1.

### Trace one request

```mermaid
flowchart LR
    C["GET /hello/fwp"] --> R["Router selects hello"]
    R --> P["name = Some fwp"] --> T["Text: hello, fwp"]
    T --> O["HTTP 200 response"]
```

For `POST /sum` with `[1, 2, 3.5]`, the numeric list totals `6.5`.
With `{}`, the array check fails first and produces HTTP 400; summation never runs.

## Handlers

A handler is an ordinary function from `Request` to `Response`. It may
fail with `HttpError`, and the server turns that failure into a response
with the error's status:

```fwp
hello : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
hello =
    http.param "name"
    | option.unwrap-or "world"
    | format "hello, {}"
    | http.text 200
```

- `http.json-body` parses the body, failing with 400 when it is not JSON.
- `http.query-param` and `http.header` read the rest of the request.
- `http.text`, `http.json` and `json.response` build responses.
- `auth.bearer` requires an `Authorization: Bearer ...` header.

## Routing and middleware

`http.router` takes a list of routes. A route is a method, a path pattern
and a handler. A segment that starts with `:` binds a parameter, which
`http.param` reads. When no route matches, the router answers 404; when
only the method is wrong, it answers 405:

```fwp
routes : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
routes = http.router [
    http.route "GET" "/hello" hello,
    http.route "GET" "/hello/:name" hello,
    http.route "POST" "/sum" sum-numbers,
    http.route "GET" "/admin" admin,
]
```

Middleware is ordinary composition: `timeout 2s` answers 503 when a
request takes longer.

```fwp
handler = timeout 2s | routes
```

## Serving

`http.serve-on` serves a handler on a listener until SIGINT or SIGTERM.
Then it stops accepting connections, lets requests in flight finish, and
returns. `http.config` sets limits: connections, request header and body
sizes, requests per connection, idle time and handler time:

```fwp
# serve until SIGINT or SIGTERM
serve : String -> () ! {Async, IO, Network, Error[IoError]}
serve =
    tcp.listen
    | tap (tcp.local-addr | format "serving on http://{}" | eprint)
    | fork http.serve-on id (const (http.config "unused", handler))
```

Run it, in the background, and call it with any HTTP client:

```console
$ fwp run server.fwp 127.0.0.1:8708 &
serving on http://127.0.0.1:8708
$ curl -s -w '\n' http://127.0.0.1:8708/hello/fwp
hello, fwp
$ curl -s -w '\n' -d '[1, 2, 3.5]' http://127.0.0.1:8708/sum
6.5
$ curl -s -w ' %{http_code}\n' -d '{}' http://127.0.0.1:8708/sum
expected an array 400
$ curl -s -w ' %{http_code}\n' http://127.0.0.1:8708/admin
missing or invalid bearer token 401
$ curl -s -w '\n' -H 'Authorization: Bearer secret' http://127.0.0.1:8708/admin
welcome
$ curl -s -w ' %{http_code}\n' http://127.0.0.1:8708/nowhere
not found 404
```

`fwp build server.fwp -o server` builds the same program as an
executable.

## The program

[`server.fwp`](server.fwp):

```fwp
# A small HTTP server: `fwp run server.fwp [host:port]`.

hello : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
hello =
    http.param "name"
    | option.unwrap-or "world"
    | format "hello, {}"
    | http.text 200

sum-numbers : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
sum-numbers =
    http.json-body
    | json.as-array
    | or-fail { status = 400, message = "expected an array" }
    | filter-map json.as-number
    | sum
    | json.encode-value
    | json.response

admin : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
admin = auth.bearer "secret" | const "welcome" | http.text 200

routes : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
routes = http.router [
    http.route "GET" "/hello" hello,
    http.route "GET" "/hello/:name" hello,
    http.route "POST" "/sum" sum-numbers,
    http.route "GET" "/admin" admin,
]

handler : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
handler = timeout 2s | routes

# serve until SIGINT or SIGTERM
serve : String -> () ! {Async, IO, Network, Error[IoError]}
serve =
    tcp.listen
    | tap (tcp.local-addr | format "serving on http://{}" | eprint)
    | fork http.serve-on id (const (http.config "unused", handler))

main =
    () | args | head | option.unwrap-or "127.0.0.1:8080" | attempt serve | match
        Ok _ -> id
        Err _ -> .message | eprint | const 1 | exit
```

For a complete service, see
[examples/server/api.fwp](../../../examples/server/api.fwp); the HTTP and
networking reference is [docs/concurrency.md](../../concurrency.md).

---

Previous: [Functions as executables](../07-executables-and-pipes/README.md) · Next: [Calling C](../09-c-interop/README.md) · [All tutorials](../README.md)
