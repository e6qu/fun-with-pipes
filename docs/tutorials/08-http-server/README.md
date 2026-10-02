# 8. An HTTP server

A handler is an ordinary function from `Request` to `Response`. It may
fail with `HttpError`, and the server turns that failure into a response
with the error's status. Middleware is ordinary composition:

```fwp
handler = timeout 2s | routes
```

## Routing

`http.router` takes a list of routes. A route is a method, a path pattern
and a handler. A segment that starts with `:` binds a parameter, which
`http.param` reads. When no route matches, the router answers 404; when
only the method is wrong, it answers 405.

## Requests and responses

- `http.json-body` parses the body, failing with 400 when it is not JSON.
- `http.query-param` and `http.header` read the rest of the request.
- `http.text`, `http.json` and `json.response` build responses.
- `auth.bearer` requires an `Authorization: Bearer ...` header.

## Serving

`http.serve (http.config "0.0.0.0:8080") handler` serves until SIGINT or
SIGTERM. Then it stops accepting connections, lets requests in flight
finish, and returns. The configuration limits:

- connections;
- request header and body sizes;
- requests per connection;
- idle time;
- handler time.

This program uses `http.serve-on` with a listener on a free port instead,
so that it can call itself with the HTTP client and then stop.

## The program

[`main.fwp`](main.fwp):

```fwp
# 8. An HTTP server
#
# A handler is a function from `Request` to `Response`; middleware is
# ordinary composition. This program starts the server on a free port,
# calls it with the built-in client, and shuts it down again.

hello : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
hello = http.param "name" | option.unwrap-or "world" | format "hello, {}" | http.text 200

# POST /sum with a JSON array of numbers
sum-numbers : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
sum-numbers = http.json-body | json.as-array | or-fail { status = 400, message = "expected an array" } | filter-map json.as-number | sum | Json.Num | json.response

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

# the client side: (method, path, body, headers)
calls : List[(String, String, String, List[(String, String)])]
calls = [
    ("GET", "/hello", "", []),
    ("GET", "/hello/fwp", "", []),
    ("POST", "/sum", "[1, 2, 3.5]", []),
    ("POST", "/sum", "{}", []),
    ("GET", "/admin", "", []),
    ("GET", "/admin", "", [("authorization", "Bearer secret")]),
    ("GET", "/nowhere", "", []),
]

call : (String, (String, String, String, List[(String, String)])) -> String ! {Async, Network}
call = make ClientRequest {
    method = .1 | .0,
    url = fork concat (.1 | .1) .0,
    body = .1 | .2 | string.to-bytes,
    headers = .1 | .3,
} | attempt http.send | match
    Ok _ -> both .status (.body | string.from-bytes | option.unwrap-or "") | format "{} {}"
    Err _ -> .message

run-calls : String -> () ! {Async, IO, Network}
run-calls = format "http://{}" | curry id | flip map calls | each (call | print)

main = "127.0.0.1:0" | tcp.listen
    | both (both id (const (http.config "unused", handler)) | spawn-with (uncurry http.serve-on)) (tcp.local-addr | run-calls)
    | tap (const () | signal.request-shutdown)
    | .0 | task.await | ignore
```

Run it with `fwp run docs/tutorials/08-http-server/main.fwp`, or compile it with
`fwp build docs/tutorials/08-http-server/main.fwp -o http-server`. The output is
[`main.out`](main.out):

```
200 hello, world
200 hello, fwp
200 6.5
400 expected an array
401 missing or invalid bearer token
200 welcome
404 not found
```

For a complete service, see
[examples/server/api.fwp](../../../examples/server/api.fwp); the HTTP and
networking reference is [docs/concurrency.md](../../concurrency.md).

---

Previous: [Functions as executables](../07-executables-and-pipes/README.md) · Next: [Calling C](../09-c-interop/README.md) · [All tutorials](../README.md)
