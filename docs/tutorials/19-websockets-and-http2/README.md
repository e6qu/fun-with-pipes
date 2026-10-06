# 19. WebSockets and HTTP/2

[Tutorial 8](../08-http-server/README.md) wrote an HTTP server. The same
server, with the same handlers, also speaks HTTP/2, can compress its
responses, and can switch a connection to WebSocket for messages in both
directions. [docs/concurrency.md](../../concurrency.md#http2) has the
details.

To follow along, go to this directory (`cd docs/tutorials/19-websockets-and-http2`).
The sessions below run exactly as shown: the test suite runs them.

## Handlers

Two ordinary handlers, and a router:

```fwp
hello : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
hello = .version | format "hello over {}\n" | http.text 200

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
app : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
app = http.compress 512 routes
```

`compress = Some 512` in a server's config does the same for every
handler. Request bodies sent with `Content-Encoding: gzip` (or `deflate`)
are decompressed before the handler sees them, and fwp's HTTP client asks
for compressed responses and decompresses them, so neither side has to do
anything. `gzip.compress` and `gzip.decompress` are there for the rest.

## A WebSocket

`http.websocket f` is a handler: it answers the upgrade request with
`101 Switching Protocols` and then runs `f` with the session, a pair of
channels of messages. This session sends every message back until the
client closes it:

```fwp
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

[`app.fwp`](app.fwp) serves `app` on the address its argument names. Start
it in the background:

```console
$ fwp run app.fwp 127.0.0.1:8720 &
serving on http://127.0.0.1:8720
```

curl speaks HTTP/1.1 unless it is told that the server speaks HTTP/2
(`--http2-prior-knowledge`; over TLS, the server offers HTTP/2 with ALPN
and curl takes it by itself):

```console
$ curl -s http://127.0.0.1:8720/hello
hello over HTTP/1.1
$ curl -s --http2-prior-knowledge http://127.0.0.1:8720/hello
hello over HTTP/2
$ curl -s http://127.0.0.1:8720/report | wc -c
2100
$ curl -s -H 'Accept-Encoding: gzip' -D - -o /dev/null http://127.0.0.1:8720/report | tr -d '\r'
HTTP/1.1 200 OK
content-encoding: gzip
vary: accept-encoding
content-type: text/plain; charset=utf-8
content-length: 59
connection: keep-alive

$ curl -s --compressed http://127.0.0.1:8720/report | head -2
all work and no play
all work and no play
```

On one HTTP/2 connection, every request is a stream with a task of its
own, so slow requests do not hold up the others.

Any WebSocket client can talk to `/mirror` (in a browser, `new
WebSocket('ws://127.0.0.1:8720/mirror')`). So does fwp's, `ws.connect`,
which takes `wss://` URLs too. [`client.fwp`](client.fwp):

```fwp
# Talk to the mirror over a WebSocket.

main =
    "ws://127.0.0.1:8720/mirror"
    | ws.connect
    | tap (ws.send-text "hello from fwp")
    | tap (ws.recv | echo)
    | tap ws.close
    | ws.wait
```

```console
$ fwp run client.fwp
Some (Text "hello from fwp")
$ curl -s -w ' %{http_code}\n' http://127.0.0.1:8720/mirror
expected a WebSocket upgrade request 400
```

A request to `/mirror` that is not an upgrade gets 400. fwp's HTTP
client speaks HTTP/2 too, when asked (`http.client | with { version =
HttpVersion.Http2 }`) or when a TLS server offers it.

## The program

[`app.fwp`](app.fwp):

```fwp
# HTTP/1.1 and HTTP/2, compressed responses, and a WebSocket:
# `fwp run app.fwp [host:port]`.

hello : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
hello = .version | format "hello over {}\n" | http.text 200

report : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
report = const (string.repeat 100 "all work and no play\n") | http.text 200

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

app : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
app = http.compress 512 routes

# serve until SIGINT or SIGTERM
serve : String -> () ! {Async, IO, Network, Error[IoError]}
serve =
    tcp.listen
    | tap (tcp.local-addr | format "serving on http://{}" | eprint)
    | fork http.serve-on id (const (http.config "unused", app))

main =
    () | args | head | option.unwrap-or "127.0.0.1:8080" | attempt serve | match
        Ok _ -> id
        Err _ -> .message | eprint | const 1 | exit
```

---

Previous: [TLS](../18-tls/README.md) · Next: [Reverse-mode autodiff and devices](../20-autodiff-and-devices/README.md) · [All tutorials](../README.md)
