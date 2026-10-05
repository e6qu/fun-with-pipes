# 19. TLS

[Tutorial 17](../17-rest-and-openapi/README.md) and
[tutorial 18](../18-grpc/README.md) served exported functions as REST
endpoints and gRPC methods, in cleartext. With a certificate, the same
servers speak TLS: HTTPS for REST, gRPC over TLS for gRPC, with no change
to the program. fwp's clients (the HTTP client, generated REST and gRPC
clients, the stubs of split services) verify the server's certificate.
TLS is the system's OpenSSL 3; [docs/tls.md](../../tls.md) has the
details.

## A certificate

A server needs a certificate and its private key. For a test, make a CA of
your own and a certificate for `localhost` that it signs (in production,
the certificate comes from a CA that clients already trust):

```
$ openssl req -x509 -newkey rsa:2048 -nodes -keyout ca.key -out ca.pem -days 30 \
    -subj "/CN=test CA" -addext "basicConstraints=critical,CA:TRUE" \
    -addext "keyUsage=critical,keyCertSign"
$ openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/CN=localhost"
$ printf "subjectAltName=DNS:localhost,IP:127.0.0.1\nextendedKeyUsage=serverAuth\n" > ext.cnf
$ openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial \
    -out server.pem -days 30 -extfile ext.cnf
```

`server.pem` and `server.key` are the server's; clients that should trust
it are given `ca.pem`.

## HTTPS

The program has two exported functions:

```fwp
# A quote by its id.
# route: GET /sayings/{id}
export saying : I64 -> Option[Quote]
saying = eq | compose .id | find | apply all-quotes
```

```fwp
# How many quotes there are.
# route: GET /count
export count : () -> I64
count = const all-quotes | length
```

`--tls-cert` and `--tls-key` make the REST server of tutorial 17 an HTTPS
server (`fwp build --rest` servers take the same flags, or the variables
`FWP_TLS_CERT` and `FWP_TLS_KEY`):

```
$ fwp serve --rest main.fwp --listen 127.0.0.1:8443 --tls-cert server.pem --tls-key server.key
fwp: rest listening on https://127.0.0.1:8443
$ curl --cacert ca.pem https://localhost:8443/sayings/2
{"id":2,"text":"Make it work, make it right, make it fast."}
$ curl --cacert ca.pem https://localhost:8443/count
3
$ curl https://localhost:8443/count
curl: (60) SSL certificate problem: unable to get local issuer certificate
```

Without `--cacert`, curl does not trust the certificate, as it should.
fwp clients verify it the same way. A client generated from the OpenAPI
document takes an `https://` base URL, and trusts the system's CA
certificates, which OpenSSL's variable `SSL_CERT_FILE` replaces:

```
$ curl -s --cacert ca.pem https://localhost:8443/openapi.json > api.json
$ fwp openapi --import api.json -o sayings.fwp
$ cat client.fwp
import sayings

main = 2 | sayings.saying "https://localhost:8443" | echo
$ SSL_CERT_FILE=ca.pem fwp run client.fwp
Some (sayings.Quote {id = 2, text = "Make it work, make it right, make it fast."})
$ fwp run client.fwp
error: RestError {message = "localhost:8443: certificate verify failed: unable to get local issuer certificate", status = 0}
```

## TLS settings in fwp

A program sets TLS up with two records of `lib/tls.fwp`. `TlsOptions` say
how a client verifies the server; `tls.with-ca` trusts a CA of one's own
for one client instead of setting `SSL_CERT_FILE` for all:

```fwp
client : TlsOptions
client = tls.options | tls.with-ca "ca.pem"
```

`http.send-with` sends a request with them (`http.get` and `http.send` use
`tls.options`, the system's CA certificates):

```fwp
fetch : I64 -> String ! {Async, Network, Error[IoError]}
fetch =
    format "https://localhost:8443/sayings/{}"
    | make ClientRequest {
        method = const "GET",
        url = id,
        headers = const [],
        body = const ("" | string.to-bytes),
    }
    | http.send-with client
    | .body
    | string.from-bytes
    | option.unwrap-or ""
```

With the server above running, `fetch 1` gives
`{"id":1,"text":"Simplicity is prerequisite for reliability."}`.

A `TlsServer` holds a certificate and key; a server configuration of
`lib/http.fwp` with one serves HTTPS with `http.serve`:

```fwp
server : ServerConfig
server =
    "127.0.0.1:8443"
    | http.config
    | with { tls = Some (tls.server "server.pem" "server.key") }
```

Below these, `tls.connect` and `tls.listen` make TLS connections, which
are `Conn`s like TCP connections: `tcp.read` and `tcp.write` work on them,
which is how the HTTP server and client run over TLS unchanged. A
handshake waits on the task scheduler like any socket operation, in the
connection's own task, so a slow client holds up no other.

## gRPC over TLS

The same flags serve the functions over gRPC with TLS:

```
$ fwp serve --grpc main.fwp --tls-cert server.pem --tls-key server.key
fwp: service main listening on tls://127.0.0.1:50051
$ grpcurl -cacert ca.pem localhost:50051 list
grpc.health.v1.Health
quotes.Quotes
$ grpcurl -cacert ca.pem -d '{"arg1": 2}' localhost:50051 quotes.Quotes/Saying
{
  "value": {
    "id": "2",
    "text": "Make it work, make it right, make it fast."
  }
}
```

fwp clients call `tls://host:port` (or `grpcs://host:port`) where they
would call `host:port`: the address of a client generated by
`fwp proto --import`, and `FWP_SERVICE_<M>` for the services of
[tutorial 14](../14-services/README.md):

```
$ fwp proto --grpc main.fwp > quotes.proto
$ fwp proto --import quotes.proto -o rpc.fwp
$ cat grpc-client.fwp
import rpc

main =
    rpc.SayingRequest { arg1 = 2 }
    | rpc.quotes.saying "tls://localhost:50051"
    | echo
$ SSL_CERT_FILE=ca.pem fwp run grpc-client.fwp
rpc.SayingResponse {value = Some (rpc.Quote {id = 2, text = "Make it work, make it right, make it fast."})}
$ fwp run grpc-client.fwp
error: GrpcError {code = 14, message = "cannot connect to localhost:50051: certificate verify failed: unable to get local issuer certificate"}
```

Native servers and clients are built as before (`fwp build --rest`,
`fwp build --grpc`); a program that uses TLS is linked with OpenSSL
(`libssl.so.3`), and the interpreter loads the same library when a
program first uses TLS.

## The program

```fwp
# grpc: quotes.Quotes

Quote = { id: I64, text: String }

all-quotes : List[Quote]
all-quotes = [
    Quote { id = 1, text = "Simplicity is prerequisite for reliability." },
    Quote { id = 2, text = "Make it work, make it right, make it fast." },
    Quote { id = 3, text = "Data dominates." },
]

# A quote by its id.
# route: GET /sayings/{id}
export saying : I64 -> Option[Quote]
saying = eq | compose .id | find | apply all-quotes

# How many quotes there are.
# route: GET /count
export count : () -> I64
count = const all-quotes | length

client : TlsOptions
client = tls.options | tls.with-ca "ca.pem"

fetch : I64 -> String ! {Async, Network, Error[IoError]}
fetch =
    format "https://localhost:8443/sayings/{}"
    | make ClientRequest {
        method = const "GET",
        url = id,
        headers = const [],
        body = const ("" | string.to-bytes),
    }
    | http.send-with client
    | .body
    | string.from-bytes
    | option.unwrap-or ""

server : ServerConfig
server =
    "127.0.0.1:8443"
    | http.config
    | with { tls = Some (tls.server "server.pem" "server.key") }

main = [
    2 | saying | echo,
    () | count | echo,
    client | .ca-file | echo,
    client | .insecure | echo,
    server | .tls | option.map .cert-file | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/19-tls/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/19-tls/main.fwp -o quotes`. The output is
[`main.out`](main.out):

```
Some (Quote {id = 2, text = "Make it work, make it right, make it fast."})
3
Some "ca.pem"
False
Some "server.pem"
```

`main` calls the functions in-process and shows the settings, which is
how the output is checked; the shell sessions above show them served
over TLS.

---

Previous: [gRPC](../18-grpc/README.md) · Next: [WebSockets and HTTP/2](../20-websockets-and-http2/README.md) · [All tutorials](../README.md)
