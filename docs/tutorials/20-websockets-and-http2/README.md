# 20. WebSockets and HTTP/2

[Tutorial 8](../08-http-server/README.md) wrote an HTTP server with
`http.serve`. The same server, with the same handlers, also speaks HTTP/2, can
compress its responses, and can switch a connection to WebSocket for
messages in both directions. [docs/concurrency.md](../../concurrency.md#http2)
has the details.

## Handlers

Two ordinary handlers, and a router:

```fwp
# GET /hello: the HTTP version the request came in
hello : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
hello = .version | format "hello over {}\n" | http.text 200

# GET /report: a long text
report : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
report = const (string.repeat 100 "all work and no play\n") | http.text 200
```

```fwp
routes : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
routes = http.router [
    http.route "GET" "/hello" hello,
    http.route "GET" "/report" report,
    http.route "GET" "/mirror" (http.websocket mirror),
]
```

## Compression

`http.compress 512` compresses the responses of a handler whose bodies
have 512 bytes or more, with gzip (or deflate) for clients that say they
accept it (`Accept-Encoding`):

```fwp
# responses of 512 bytes or more are compressed
app : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
app = http.compress 512 routes
```

`compress = Some 512` in a server's config does the same for every
handler. Request bodies sent with `Content-Encoding: gzip` (or `deflate`)
are decompressed before the handler sees them, and fwp's HTTP client asks
for compressed responses and decompresses them, so neither side has to do
anything. `gzip.compress` and `gzip.decompress` are there for the rest:

```fwp
                ("GET", "/report", [("accept-encoding", "gzip")])
                | call
                | both
                    describe
                    (body-of | gzip.decompress | result.map bytes.length)
                | echo,
```

## A WebSocket

`http.websocket f` is a handler: it answers the upgrade request with
`101 Switching Protocols` and then runs `f` with the session, a pair of
channels of messages. This session sends every message back until the
client closes it:

```fwp
# a WebSocket session: every message back, until the client closes
mirror : WebSocket -> () ! {Async, IO, Network, FileIO}
mirror = loop mirror-step

mirror-step : WebSocket -> Step[WebSocket, ()] ! {Async, IO, Network, FileIO}
mirror-step = fork mirror-got id ws.recv

mirror-got : WebSocket -> Option[WsMessage] -> Step[WebSocket, ()] ! {Async, IO, Network, FileIO}
mirror-got = curry (match
    (_, Some (WsMessage.Close _ _)) -> curry3 (const (Stop ()))
    (_, Some _) -> curry (tap (fork ws.send .1 .0) | .0 | Again)
    (_, None) -> const (Stop ()))
```

`ws.recv` waits for the next message (`None` when the session is over),
`ws.send` sends one, and when `f` returns the server closes the session.
Pings get pongs, fragmented messages arrive whole, and a message over
`max-message-bytes` (1 MiB unless `http.websocket-with` says otherwise)
ends the session with the close code 1009. A request to `/mirror` that is
not an upgrade gets 400.

## Serving

`fwp run main.fwp serve` serves `app` on 127.0.0.1:8080:

```fwp
# serve: `fwp run main.fwp serve`
serve : () -> () ! {Async, IO, Network, Error[IoError]}
serve = const ("127.0.0.1:8080" | http.config) | flip http.serve app
```

curl speaks HTTP/1.1 unless it is told that the server speaks HTTP/2
(`--http2-prior-knowledge`; over TLS, the server offers HTTP/2 with ALPN
and curl takes it by itself):

```
$ fwp run main.fwp serve &
$ curl http://127.0.0.1:8080/hello
hello over HTTP/1.1
$ curl --http2-prior-knowledge http://127.0.0.1:8080/hello
hello over HTTP/2
$ curl --compressed -D - -o /dev/null http://127.0.0.1:8080/report
HTTP/1.1 200 OK
content-encoding: gzip
vary: accept-encoding
content-type: text/plain; charset=utf-8
content-length: 59
connection: keep-alive

```

On one HTTP/2 connection, every request is a stream with a task of its
own, so slow requests do not hold up the others. Any WebSocket client
can talk to `/mirror`; node 22 has one built in:

```
$ cat mirror.mjs
const ws = new WebSocket('ws://127.0.0.1:8080/mirror');
ws.onopen = () => ws.send('hello, mirror');
ws.onmessage = (e) => { console.log('got:', e.data); ws.close(1000, 'thanks'); };
ws.onclose = (e) => console.log('closed:', e.code);
$ node mirror.mjs
got: hello, mirror
closed: 1000
```

So does fwp's (`ws.connect`, which takes `wss://` URLs too), and its
HTTP client speaks HTTP/2 when asked, or when a TLS server offers it:

```
$ cat client.fwp
main =
    "ws://127.0.0.1:8080/mirror"
    | ws.connect
    | tap (ws.send-text "hello from fwp")
    | tap (ws.recv | echo)
    | tap ws.close
    | ws.wait
$ fwp run client.fwp
Some (Text "hello from fwp")
```

```fwp
                http.client
                | with { version = HttpVersion.Http2 }
                | .version
                | echo,
```

## The program

```fwp
# 20. WebSockets and HTTP/2
#
# A server with a WebSocket echo and responses compressed for clients that
# accept it, which also speaks HTTP/2: the README serves it and talks to
# it with curl, node and an fwp client. `main` calls the handler
# in-process, which is how its output is checked.

# GET /hello: the HTTP version the request came in
hello : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
hello = .version | format "hello over {}\n" | http.text 200

# GET /report: a long text
report : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
report = const (string.repeat 100 "all work and no play\n") | http.text 200

# a WebSocket session: every message back, until the client closes
mirror : WebSocket -> () ! {Async, IO, Network, FileIO}
mirror = loop mirror-step

mirror-step : WebSocket -> Step[WebSocket, ()] ! {Async, IO, Network, FileIO}
mirror-step = fork mirror-got id ws.recv

mirror-got : WebSocket -> Option[WsMessage] -> Step[WebSocket, ()] ! {Async, IO, Network, FileIO}
mirror-got = curry (match
    (_, Some (WsMessage.Close _ _)) -> curry3 (const (Stop ()))
    (_, Some _) -> curry (tap (fork ws.send .1 .0) | .0 | Again)
    (_, None) -> const (Stop ()))

routes : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
routes = http.router [
    http.route "GET" "/hello" hello,
    http.route "GET" "/report" report,
    http.route "GET" "/mirror" (http.websocket mirror),
]

# responses of 512 bytes or more are compressed
app : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
app = http.compress 512 routes

# serve: `fwp run main.fwp serve`
serve : () -> () ! {Async, IO, Network, Error[IoError]}
serve = const ("127.0.0.1:8080" | http.config) | flip http.serve app

# a request made in-process: method, path and headers
request : (String, String, List[(String, String)]) -> Request
request = make Request {
    method = .0,
    path = .1,
    query = const "",
    version = const "HTTP/1.1",
    headers = .2,
    body = const http.no-bytes,
    params = const [],
    remote = const "test",
}

body-of : Response -> Bytes
body-of = .body | match
    Body.Full _ -> id
    _ -> const http.no-bytes

describe : Response -> String
describe = make {
    0 = .status,
    1 = .headers | json.lookup "content-encoding" | option.unwrap-or "none",
    2 = body-of | bytes.length,
} | format "{} (content-encoding {}, {} bytes)"

upgrade : List[(String, String)]
upgrade = [
    ("upgrade", "websocket"),
    ("connection", "Upgrade"),
    ("sec-websocket-key", "dGhlIHNhbXBsZSBub25jZQ=="),
    ("sec-websocket-version", "13"),
]

call : (String, String, List[(String, String)]) -> Response ! {Async, IO, Network, FileIO}
call = request | attempt app | match
    Ok -> id
    Err -> fork http.text .status .message

main =
    if
        (const () | args | contains "serve")
        (attempt serve | ignore)
        (const [
                ("GET", "/hello", [])
                | call
                | body-of
                | string.from-bytes
                | echo,
                ("GET", "/report", []) | call | describe | echo,
                ("GET", "/report", [("accept-encoding", "gzip")])
                | call
                | both
                    describe
                    (body-of | gzip.decompress | result.map bytes.length)
                | echo,
                ("GET", "/mirror", upgrade)
                | call
                | both .status (.headers | json.lookup "sec-websocket-accept")
                | echo,
                ("GET", "/mirror", []) | call | describe | echo,
                http.client
                | with { version = HttpVersion.Http2 }
                | .version
                | echo,
            ]
            | ignore)
        ()
```

Run it with `fwp run docs/tutorials/20-websockets-and-http2/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/20-websockets-and-http2/main.fwp -o mirror`.
The output is [`main.out`](main.out):

```
Some "hello over HTTP/1.1\n"
200 (content-encoding none, 2100 bytes)
("200 (content-encoding gzip, 59 bytes)", Ok 2100)
(101, Some "s3pPLMBiTxaQ9kYGzzhZRbK+xOo=")
400 (content-encoding none, 36 bytes)
Http2
```

`main` calls the handler in-process: the plain request, the report with
and without `accept-encoding: gzip` (59 compressed bytes for 2100), the
upgrade with its `sec-websocket-accept` key, and a request to `/mirror`
that is not an upgrade. The shell sessions above show it served.

---

Previous: [TLS](../19-tls/README.md) · Next: [Reverse-mode autodiff and devices](../21-autodiff-and-devices/README.md) · [All tutorials](../README.md)
