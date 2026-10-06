# 18. TLS

[Tutorial 17](../17-rest-and-openapi/README.md) served functions as REST
endpoints, and [tutorial 14](../14-services/README.md) split a program
into services, in cleartext. With a certificate, the same servers speak
TLS: HTTPS for REST, gRPC over TLS between services, with no change to
the program. fwp's clients (the HTTP client, generated REST clients, the
calls of split services) verify the server's certificate. TLS is the
system's OpenSSL 3; [docs/tls.md](../../tls.md) has the details.

To follow along, go to this directory (`cd docs/tutorials/18-tls`). The
sessions below run exactly as shown: the test suite runs them. They need
the `openssl` command.

## A certificate

A server needs a certificate and its private key. For a test, make a CA of
your own and a certificate for `localhost` that it signs (in production,
the certificate comes from a CA that clients already trust):

```console
$ openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:P-256 -nodes \
    -keyout ca.key -out ca.pem -days 30 -subj "/CN=test CA" \
    -addext "basicConstraints=critical,CA:TRUE" \
    -addext "keyUsage=critical,keyCertSign" 2>/dev/null
$ openssl req -newkey ec -pkeyopt ec_paramgen_curve:P-256 -nodes \
    -keyout server.key -out server.csr -subj "/CN=localhost" 2>/dev/null
$ printf 'subjectAltName=DNS:localhost,IP:127.0.0.1\nextendedKeyUsage=serverAuth\n' > ext.cnf
$ openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial \
    -out server.pem -days 30 -extfile ext.cnf 2>/dev/null
$ ls *.pem *.key
ca.key
ca.pem
server.key
server.pem
```

`server.pem` and `server.key` are the server's; clients that should trust
it are given `ca.pem`.

## HTTPS

[`quotes.fwp`](quotes.fwp) has two functions, exposed as REST endpoints:

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
server (or the variables `FWP_TLS_CERT` and `FWP_TLS_KEY`):

```console
$ fwp build quotes.fwp --rest -o quotes-api
$ ./quotes-api --listen 127.0.0.1:8719 --tls-cert server.pem --tls-key server.key &
fwp: rest listening on https://127.0.0.1:8719
$ curl -s -w '\n' --cacert ca.pem https://localhost:8719/sayings/2
{"id":2,"text":"Make it work, make it right, make it fast."}
$ curl -s -w '\n' --cacert ca.pem https://localhost:8719/count
3
$ curl -s https://localhost:8719/count || echo "curl refused it: exit $?"
curl refused it: exit 60
```

Without `--cacert`, curl does not trust the certificate, as it should
(exit status 60). fwp clients verify it the same way. A client generated
from the OpenAPI document takes an `https://` base URL, and trusts the
system's CA certificates, which OpenSSL's variable `SSL_CERT_FILE`
replaces. [`client.fwp`](client.fwp):

```fwp
# Call the HTTPS API through the client generated from its OpenAPI
# document; the system's CA certificates (or `SSL_CERT_FILE`) are trusted.

import sayings

main = 2 | sayings.saying "https://localhost:8719" | echo
```

```console
$ curl -s --cacert ca.pem https://localhost:8719/openapi.json > api.json
$ fwp openapi --import api.json -o sayings.fwp
$ SSL_CERT_FILE=ca.pem fwp run client.fwp
Some (sayings.Quote {id = 2, text = "Make it work, make it right, make it fast."})
$ fwp run client.fwp
error: RestError {message = "localhost:8719: certificate verify failed: unable to get local issuer certificate", status = 0}
```

## TLS settings in fwp

A program sets TLS up with two records of `lib/tls.fwp`. `TlsOptions` say
how a client verifies the server; `tls.with-ca` trusts a CA of one's own
for one client instead of setting `SSL_CERT_FILE` for all, and
`http.send-with` sends a request with them (`http.get` and `http.send` use
`tls.options`, the system's CA certificates). [`fetch.fwp`](fetch.fwp):

```fwp
# Fetch a quote over HTTPS, trusting a CA of our own.

client : TlsOptions
client = tls.options | tls.with-ca "ca.pem"

fetch : I64 -> String ! {Async, Network, Error[IoError]}
fetch =
    format "https://localhost:8719/sayings/{}"
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

main = 1 | fetch | print
```

```console
$ fwp run fetch.fwp
{"id":1,"text":"Simplicity is prerequisite for reliability."}
```

A `TlsServer` holds a certificate and key: `tls.server "server.pem"
"server.key"` in the `tls` field of a server configuration of
`lib/http.fwp` serves HTTPS with `http.serve`. Below these, `tls.connect`
and `tls.listen` make TLS connections, which are `Conn`s like TCP
connections: `tcp.read` and `tcp.write` work on them, which is how the
HTTP server and client run over TLS unchanged. A handshake waits on the
task scheduler like any socket operation, in the connection's own task,
so a slow client holds up no other.

## Services over TLS

The servers of a split program take the same flags. A client calls
`tls://host:port` (or `grpcs://host:port`) where it would call
`host:port`, in `FWP_SERVICE_<M>`. [`show.fwp`](show.fwp) calls the
functions of `quotes.fwp`:

```fwp
# Show two quotes. Built with `--service quotes`, the calls go to the
# quotes service, over TLS when its address is `tls://host:port`.

import quotes

main = [2 | quotes.saying | echo, () | quotes.count | echo] | ignore
```

```console
$ fwp build show.fwp --service quotes -o split
$ ./split/quotes --listen 127.0.0.1:50069 --tls-cert server.pem --tls-key server.key &
fwp: service quotes listening on tls://127.0.0.1:50069
$ SSL_CERT_FILE=ca.pem FWP_SERVICE_QUOTES=tls://localhost:50069 ./split/show
Some (quotes.Quote {id = 2, text = "Make it work, make it right, make it fast."})
3
```

A program that uses TLS is linked with OpenSSL (`libssl.so.3`), and the
interpreter loads the same library when a program first uses TLS.

## The program

[`quotes.fwp`](quotes.fwp):

```fwp
# Quotes, served over HTTPS, and as a service over TLS.
#
# expose: rest

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
```

---

Previous: [REST APIs and OpenAPI](../17-rest-and-openapi/README.md) · Next: [WebSockets and HTTP/2](../19-websockets-and-http2/README.md) · [All tutorials](../README.md)
