# TLS

TLS connections, HTTPS servers and clients, REST APIs over HTTPS and gRPC
over TLS, in both backends, with the system's OpenSSL 3. TLS itself is not
written from scratch: the cryptography is OpenSSL's, and fwp adds the
non-blocking glue to its schedulers, the configuration and the error
messages.

```
$ fwp serve --rest api.fwp --listen 127.0.0.1:8443 --tls-cert server.pem --tls-key server.key
fwp: rest listening on https://127.0.0.1:8443
$ curl --cacert ca.pem https://localhost:8443/items/3
{"id":3,"name":"item 3"}
$ fwp serve --grpc weather.fwp --tls-cert server.pem --tls-key server.key
fwp: service weather listening on tls://127.0.0.1:50051
$ grpcurl -cacert ca.pem localhost:50051 list
grpc.health.v1.Health
weather.Weather
```

[Tutorial 19](tutorials/19-tls/README.md) walks through an example.

## OpenSSL

| | |
|---|---|
| interpreter (`fwp run`, `fwp serve`) | loads `libssl.so.3` and `libcrypto.so.3` with `dlopen` the first time a program uses TLS; the `fwp` executable does not link them, so it runs (and programs without TLS run) where they are missing, and TLS then fails with an `IoError` of kind `"tls"`: `TLS needs OpenSSL 3 (libssl.so.3), which could not be loaded` |
| native programs | programs that use TLS are linked with `-lssl -lcrypto`, so they depend on `libssl.so.3`; building them needs the OpenSSL headers (`libssl-dev` on Debian and Ubuntu, `openssl-devel` on Fedora). A program uses TLS when a `tls.*` primitive is reachable from its entry points: any HTTPS server or client (`http.serve`, `http.get`, ...; `--rest` servers), and every program that calls or serves gRPC services. Other programs do not depend on OpenSSL |
| `--staticlib`, `--emit-c` | a static library, or the C, of a program that uses TLS needs `-lssl -lcrypto` where it is linked; `--cdylib` libraries are linked with them |
| WebAssembly | no sockets: `wasm32-wasi` and `wasm32-browser` reject programs that use TLS, like other `Network` programs, and so does the WebAssembly build of fwp |

Connections use TLS 1.2 or 1.3, with OpenSSL's default ciphers.

## Connections

`lib/tls.fwp` ([stdlib.md](stdlib.md#tls)). A TLS connection is a `Conn`,
like a TCP connection: `tcp.read`, `tcp.write`, `tcp.read-for`,
`tcp.write-for`, `tcp.close` and `tcp.peer-addr` read and write through
TLS, so code written for TCP connections works over TLS unchanged (the HTTP
server and client of `lib/http.fwp` are such code). `tls.read`,
`tls.write`, ... are the same functions under the TLS names.

| Function | |
|---|---|
| `tls.connect "host:port"` | connect, finish the handshake and verify the server's certificate with the system's CA certificates |
| `tls.connect-with options "host:port"` | with `TlsOptions` (below) |
| `tls.listen server "host:port"` | a listener whose connections are TLS connections, with a `TlsServer` (`tls.server "cert.pem" "key.pem"`) |
| `tls.accept`, `tls.accept-for` | accept a connection; its handshake happens on its first read or write |
| `tls.handshake conn` | finish an accepted connection's handshake now |
| `tls.alpn conn` | the protocol chosen with ALPN (`""` for none) |
| `tls.peer-subject conn` | the subject of the certificate the peer presented (`Some "CN=fwp client,O=fwp"`, as RFC 2253 writes names), after the handshake |
| `tls.secure conn` | `True` for a TLS connection, `False` for a plain one (or a closed one) |
| `tls.available ()` | OpenSSL can be used |

```fwp
# trust our own CA when calling the server
client-tls : TlsOptions
client-tls = tls.options | tls.with-ca "ca.pem"
```

### Client options

```
TlsOptions = {
    ca-file: Option[String],     # trust the CA certificates of this PEM file instead
    insecure: Bool,              # do not verify the server's certificate
    server-name: Option[String], # the name to verify and send (default: the host)
    alpn: List[String],          # protocols to offer
    cert-file: Option[String],   # a client certificate chain (PEM), for mutual TLS
    key-file: Option[String],    # and its private key (else in cert-file)
}
```

`tls.options` verifies with the system's CA certificates, offers no
protocols, presents no certificate and takes the server name from the
address. Change it with `with`, `tls.with-ca` or
`tls.with-cert "client.pem" "client.key"`:
`tls.options | with { server-name = Some "api.internal", alpn = ["h2"] }`.

* **Verification** is on by default: the chain must lead to a trusted CA,
  and the certificate must be valid for the server name (a DNS name, or an
  IP address in the certificate's IP addresses for `127.0.0.1:8443`).
  The system's CA certificates are OpenSSL's defaults; the standard
  variables `SSL_CERT_FILE` (a PEM file) and `SSL_CERT_DIR` replace them,
  for every client of the program, gRPC clients included. `ca-file`
  replaces them for one connection. `insecure = True` skips verification
  altogether (for tests; the connection is then encrypted but not
  authenticated).
* **SNI**: the server name is sent with the handshake, unless it is an IP
  address.
* **ALPN**: `alpn` lists protocols in order of preference; a server picks
  the first of its own that the client offers, and `tls.alpn` tells the
  choice. A handshake without a common protocol goes on without one.

### Servers

```
TlsServer = {
    cert-file: String,
    key-file: String,
    alpn: List[String],
    client-ca: Option[String],
}
```

`cert-file` is a PEM certificate chain (the server's certificate first,
then intermediates), `key-file` its private key (PEM, unencrypted). Both
are loaded by `tls.listen`, which fails if they cannot be read or do not
match. Without `client-ca`, client certificates are not requested.

### Mutual TLS

`tls.server "server.pem" "server.key" | tls.with-client-ca "ca.pem"` is a
server that requires a client certificate signed by the CA certificates
of `ca.pem`: a client without one, or with one of another CA, fails the
handshake (the server's `tls.handshake`, or first read, fails with
`TLS handshake failed: ...`; the client sees an `IoError` of kind `"tls"`
when it reads). After the handshake `tls.peer-subject conn` is the
client's verified subject, which the server can use to authorize it.
Clients present a certificate with `tls.with-cert`:

```
server = tls.server "server.pem" "server.key" | tls.with-client-ca "ca.pem"
client = tls.options | tls.with-ca "ca.pem" | tls.with-cert "client.pem" "client.key"
```

* **HTTPS**: a `ServerConfig` whose `tls` has `client-ca` requires client
  certificates; `http.peer-subject request` is the client's subject.
* **REST**: `--tls-client-ca ca.pem` (or `FWP_TLS_CLIENT_CA`), and
  `# auth: client-cert` authenticates clients by their subject
  ([rest.md](rest.md#authentication)); the OpenAPI document declares a
  `mutualTLS` security scheme.
* **gRPC**: `--tls-client-ca ca.pem` (or `FWP_TLS_CLIENT_CA`) for
  `--grpc` and `--service` servers, `tls.with-client-ca` in the
  `TlsServer` of `grpc.serve-tls`; `grpc.peer-subject ()` is the subject
  of the call's client. Clients present certificates with
  `grpc.with-tls` or `FWP_SERVICE_<M>_CERT` ([below](#grpc)).

`tests/tls/mutual.fwp` is an example.

### Errors

Failures are `IoError`s of kind `"tls"`, with OpenSSL's reasons, and the
address for clients:

| Message | |
|---|---|
| `localhost:8443: certificate verify failed: unable to get local issuer certificate` | the server's CA is not trusted |
| `localhost:8443: certificate verify failed: hostname mismatch` | the certificate is for another name |
| `localhost:8443: certificate verify failed: certificate has expired` | |
| `127.0.0.1:8080: TLS handshake failed: wrong version number` | the server does not speak TLS |
| `TLS handshake failed: http request` | (server side) a plain HTTP request on a TLS port |
| `TLS handshake failed: tlsv1 alert unknown ca` | (server side) the client did not trust our certificate |
| `server.pem: No such file or directory` | |
| `server.key: cannot load the private key: key values mismatch` | |

A peer that closes a connection without TLS's `close_notify` ends the
stream like a TCP close (most HTTP peers do), rather than failing the
read.

## Scheduling

Sockets stay non-blocking. When OpenSSL needs the socket to become
readable or writable (during a handshake, or a read that needs more of a
record), the task waits for that the way it waits on a plain socket: on
the event loop (epoll) natively, and polling in short slices in the
interpreter, where it gives up the baton meanwhile (see
[concurrency.md](concurrency.md)). Only the calling task waits; timeouts
and cancellation apply as for TCP (`tcp.read-for` covers the handshake
that a read performs).

An accepted connection does its handshake in the task that serves it, on
its first read or write, not in the accept loop, so a client that is slow
to finish (or never starts) its handshake holds up no other connection.
The HTTP server's idle and header timeouts apply to it; gRPC servers give
a client 10 seconds. One task may read a TLS connection while another
writes to it, as with TCP.

## HTTPS

`lib/http.fwp` runs the same server and client code over TLS connections:

* **Server**: a `ServerConfig` with `tls` serves HTTPS (offering
  `http/1.1` with ALPN); `http.serve-on` serves a listener from
  `tls.listen` the same way.

  ```fwp
  # an HTTPS server's configuration
  server : ServerConfig
  server =
      "127.0.0.1:8443"
      | http.config
      | with { tls = Some (tls.server "server.pem" "server.key") }
  ```

* **Client**: `http.get`, `http.post` and `http.send` fetch `https://` URLs
  over TLS, verifying the server's certificate with the system's CA
  certificates (and `SSL_CERT_FILE`); `http.send-with options request`
  takes `TlsOptions`. Redirects are not followed, as for `http://`.

HTTPS servers offer HTTP/2 and HTTP/1.1 with ALPN (`h2`, then
`http/1.1`), and the client offers both and uses HTTP/2 when the server
chooses it ([concurrency.md](concurrency.md#http2)). WebSocket clients
connect to `wss://` URLs over TLS too.

`examples/server/api.fwp` serves HTTPS when `FWP_TLS_CERT` and
`FWP_TLS_KEY` are set.

## REST

REST servers (`fwp serve --rest`, `fwp build --rest`; [rest.md](rest.md))
serve HTTPS with a certificate and key:

| Option | Environment variable | |
|---|---|---|
| `--tls-cert file` | `FWP_TLS_CERT` | the certificate chain (PEM) |
| `--tls-key file` | `FWP_TLS_KEY` | its private key (PEM) |

Both or neither: `fwp: --tls-cert needs --tls-key (or FWP_TLS_KEY)`. The
first line on standard error is then
`fwp: rest listening on https://host:port`. Clients generated by
`fwp openapi --import` take `https://` base URLs.

## gRPC

[gRPC](grpc.md) servers and clients speak TLS with ALPN `h2` (HTTP/2 over
TLS, as every gRPC implementation does). Cleartext h2c stays the default.

* **Servers** of exported functions (`fwp serve --grpc`,
  `fwp build --grpc`) and of split services (`fwp serve` and the
  executables of `fwp build --service`) take `--tls-cert file` and
  `--tls-key file`, else `FWP_TLS_CERT` and `FWP_TLS_KEY`, and then say
  `fwp: service weather listening on tls://127.0.0.1:50051`. Servers of
  `GrpcRoute`s use `grpc.serve-tls (tls.server "cert.pem" "key.pem")
  address routes` in place of `grpc.serve address routes`.
* **Clients** call TLS servers at `tls://host:port` (or
  `grpcs://host:port`; `https://` works too), wherever an address goes:
  `FWP_SERVICE_<MODULE>=tls://shop.internal:443` for the stubs of split
  builds, the address argument of clients from `fwp proto --import` and of
  `grpc.open`. `host:port`, `grpc://` and `http://` are h2c. The server's
  certificate is verified with the system's CA certificates, which
  `SSL_CERT_FILE` and `SSL_CERT_DIR` replace, and must be for `host`. A
  failure is `UNAVAILABLE`:
  `cannot connect to localhost:50051: certificate verify failed: unable to get local issuer certificate`.
* **Per-address options**: `grpc.with-tls options f` makes the calls of
  `f` connect with `TlsOptions`: a CA file, `insecure`, a server name, a
  client certificate and key (connections are pooled per address and
  options). The stubs of split builds read them for a service `m` from
  `FWP_SERVICE_<M>_CA`, `FWP_SERVICE_<M>_INSECURE` (`1`),
  `FWP_SERVICE_<M>_SERVER_NAME`, `FWP_SERVICE_<M>_CERT` and
  `FWP_SERVICE_<M>_KEY`, unless the calling task has `grpc.with-tls`.

  ```fwp
  # a call with TLS options
  call : (TlsOptions, String) -> String ! {Network, Error[GrpcError]}
  call =
      fork
          grpc.with-tls
          .0
          (.1 | iter.later (flip whoamigen.whoami.grpc-peer () | .value))
  ```

Calls over TLS send `:scheme https`. Connections are pooled per address,
as for h2c.

## A certificate for testing

```
openssl req -x509 -newkey rsa:2048 -nodes -keyout ca.key -out ca.pem -days 30 \
    -subj "/CN=test CA" -addext "basicConstraints=critical,CA:TRUE" \
    -addext "keyUsage=critical,keyCertSign"
openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/CN=localhost"
printf "subjectAltName=DNS:localhost,IP:127.0.0.1\nextendedKeyUsage=serverAuth\n" > ext.cnf
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial \
    -out server.pem -days 30 -extfile ext.cnf
```

`server.pem` and `server.key` are then a server's certificate and key,
for `localhost` and `127.0.0.1`, and clients trust `ca.pem`
(`SSL_CERT_FILE=ca.pem`, `curl --cacert ca.pem`,
`grpcurl -cacert ca.pem`, `tls.with-ca "ca.pem"`). The test suite
(`tests/tls.rs`) makes such files at test time.

## Tests

`tests/tls.rs` runs, on both backends: TLS connections with verification
and its failures (an untrusted CA, a wrong name), ALPN, plain clients of
TLS servers and TLS clients of plain servers, stalled handshakes
(`tests/tls/streams.fwp`); mutual TLS (`tests/tls/mutual.fwp`), REST and
gRPC servers that require client certificates (`tests/tls/whoami.fwp`,
with curl, grpcurl, `grpc.with-tls` and `FWP_SERVICE_<M>_CERT`); `examples/server/api.fwp` over HTTPS queried
by curl and by fwp clients while other clients stall in their
handshakes; fwp clients of `openssl s_server`; a REST server over HTTPS
with the generated OpenAPI client; and the weather service over TLS
between fwp clients and servers, with grpcurl when it is installed. It
needs the `openssl` command and skips without it.

## Limitations

* No encrypted private keys, no certificate reloading, no session
  resumption settings, no cipher or version settings, no OCSP or
  certificate revocation lists. A server's client certificates are
  verified against one CA file, and the handler sees only the subject.
* Clients generated by `fwp openapi --import` (`rest.fetch`) present no
  client certificates; use `http.send-with` with `tls.with-cert` by hand.
* No DTLS (TLS over UDP) and no QUIC.
* OpenSSL 3 only, found under its usual names (`libssl.so.3`, then
  `libssl.so`; `libssl.3.dylib` on macOS, which the test suite does not
  cover). Error reasons are OpenSSL's, and may differ between its
  versions.
