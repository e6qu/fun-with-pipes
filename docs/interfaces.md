# One function, three interfaces

An exported fwp function is a command-line program, a REST endpoint and a
gRPC method, without a line of interface code. Its type is the contract;
its comments are the documentation; a few comment lines adjust what the
types cannot say. The program is built for one interface or another: a
command-line program, an HTTP server, a gRPC server, or a gRPC server and
its client:

```
$ fwp build books.fwp --cli -o books
$ fwp build books.fwp --rest -o books-api
$ fwp build books.fwp --grpc -o books-grpc
$ fwp build shop.fwp --service books -o out
```

[`examples/rest`](../examples/rest/books.fwp) builds all three from one
file. This page compares them; [cli.md](cli.md), [rest.md](rest.md),
[grpc.md](grpc.md) and [services.md](services.md) describe each.

```fwp
# Quote an order: the price of each line and the total, with a 10%
# discount for the coupon `FWP10`.
# route: POST /quotes
# error: UnknownBook 404, OutOfStock 409, BadCoupon 422
export quote-order : Order -> Quote ! {Error[OrderError]}
```

| | Command line | REST | gRPC |
|---|---|---|---|
| unit | the root file's exported functions | the root file's exported functions | the root file's exported functions (`--grpc`), or an imported module's (`--service m`) |
| build | `fwp build --cli`, `fwp exec --cli` | `fwp build --rest`, `fwp serve --rest` | `fwp build --grpc`, `fwp serve --grpc`; `fwp build --service m`, `fwp serve` |
| name | `books quote-order` (or `# command:`) | `POST /quote-order` (or `# command:`, `# route:`) | `/fwp.Books/QuoteOrder` (or `# grpc:`) |
| record first parameter | flags: `--author x --tag a --tag b` | query parameters (GET, DELETE, or with more parameters): `?author=x&tag=a&tag=b` | the request message itself when it is the only parameter, else a field of it |
| other parameters | positional arguments, named by `# args:`; the last from stdin | path parameters, query parameters, the body (the last): JSON, or a form or `multipart/form-data` with files (`# accepts:`) | `arg1`, `arg2`, ... of the request message |
| `Iterator` and `Channel` | — | — | streams: an `Iterator` result or a final `Channel` parameter streams responses, an `Iterator` parameter requests |
| `()` parameter | implicit | implicit | no field |
| value encoding | fwp's text format (`show`); strings as they are | JSON (`json.write`, `json.read`); text and CSV responses by `Accept` (`# produces:`) | protobuf (proto3), through the canonical binary encoding |
| result | printed; a list one per line | the JSON body of a 200 (`# status:`) | `value = 1` of the response (a record result is the response) |
| `()` result | nothing | 204 | an empty message |
| `None` | nothing | 404 | an absent `optional` |
| `Err e`, `Error[E]` | `name: e` on stderr, exit status 1 | `{"error": e}` with a status (`# error:`, the error's `status`, else 500) | the `error` of the response's `oneof`; `Error[GrpcError]` is a status |
| bad arguments | usage error, exit status 2 | 400 `{"error": "path.id: ..."}` | `INVALID_ARGUMENT` |
| request headers | environment variables (`[env: VAR]`) | parameters (`# header:`, `# cookie:`, field comments), or a `Request` parameter | `grpc.metadata ()`, `grpc.header name` |
| response status and headers | `Outcome` (the exit status) | `RestReply[T]` (`rest.reply 201 x`, `rest.with-header`) | `grpc.set-header`, `grpc.set-trailer`; statuses from `Error[GrpcError]` or `Iterator[Result[R, GrpcError]]` |
| authentication | — | `# auth:` (bearer tokens, API keys, client certificates) verified by `authenticate` | client certificates (`grpc.peer-subject`); metadata the function checks |
| browsers | — | CORS (`# cors:`, `--cors`) | — |
| compression | — | gzip or deflate by `Accept-Encoding` (responses of 1 KiB or more), compressed request bodies ([rest.md](rest.md#http2-and-compression)) | gzip (`grpc.with-gzip`) |
| TLS | — | HTTPS with `--tls-cert` and `--tls-key`, client certificates with `--tls-client-ca` ([tls.md](tls.md#rest)) | TLS with `--tls-cert` and `--tls-key`, client certificates with `--tls-client-ca`; clients call `tls://host:port` ([tls.md](tls.md#grpc)) |
| documentation | `--help` from the comments | OpenAPI 3.1 (`fwp openapi`, `--yaml`, `/openapi.json`) and its page (`/docs`) | `.proto` (`fwp proto`), server reflection (also of routes from `.proto` files) |
| calling it from fwp | `process.run` | `fwp openapi --import` gives typed functions (of OpenAPI 3 or Swagger 2.0, in JSON or YAML) | `fwp proto --import` gives typed functions; or the same call, made remote by the build |
| versioning | — | unknown members are ignored, so new `Option` fields and new results' fields keep clients working; the document is the contract | a type fingerprint between fwp programs; field numbers for others |

## Comment lines

| Line | Command line | REST | gRPC |
|---|---|---|---|
| the comment block above `export` | `--help` | summary and description | — |
| `# args: A B...` | names of positional arguments; `B...` takes the rest | names of path and query parameters | — |
| `# command: name` | the command's name | the endpoint's name and default path | — |
| `# route: METHOD /path/{p}` | — | the route | — |
| `# grpc: Method`, `# grpc: package.Service/Method` | — | — | the method's name and service; in the file's leading comment, `# grpc: package.Service` names the service |
| `# status: 201` | — | the success status | — |
| `# error: 404`, `# error: V 404, W 422` | — | error statuses | — |
| `# header: X-Id -> id`, `# cookie: s -> sid` | — | parameters from headers and cookies | — |
| `# auth: bearer`, `# auth: api-key header X-Key`, `# auth: client-cert`, `# auth: none` | — | security schemes (also in the file's leading comment) | — |
| `# timeout: 5s` | — | a time limit (503) | — |
| `# response-header: Location ...` | — | a header of a `RestReply` | — |
| `# accepts: json, form, multipart` | — | the media types of the body (415 for others) | — |
| `# produces: json, text, csv` | — | the media types of the result, by `Accept` (406) | — |
| `# cors: origins` (leading comment) | — | allowed origins | — |
| a field comment `-x text` | the short flag `-x` and the flag's help | the query parameter's description | — |
| a field comment `json: name` | — | the JSON name of the field | — |
| a field comment `header: X-Id`, `cookie: name` | — | the field comes from a header or cookie | — |
| a type comment `json: untagged` | — | a variant type written as its value alone | — |
| `export f.defaults`, `export defaults` | defaults of flags | — | — |
| `export version` | `--version` | `info.version` | — |

## Encodings of the same value

| fwp | Command line (text) | REST (JSON) | gRPC (protobuf) |
|---|---|---|---|
| `I64` | `-3` | `-3` | `sint64` |
| `U128` | `340282366920938463463374607431768211455` | `"340282366920938463463374607431768211455"` | 16 `bytes` |
| `F64` | `1.5`, `inf` | `1.5`, `"Infinity"` | `double` |
| `String` | `hello` (as it is) | `"hello"` | `string` |
| `Bytes` | `bytes[102, 111]` | `"Zm8="` | `bytes` |
| `Duration` | `1500ms` | `"1500ms"` | a message `{ nanos }` |
| `Option[T]` | `Some 3`, `None`; flags may be absent | the value, or absent or `null` | `optional` |
| record | `{x = 1, y = 2}`, or flags | `{"x": 1, "y": 2}` | a message |
| enum | `Red` | `"Red"` | a `oneof` of empty messages |
| variant | `Circle 1.5` | `{"type": "Circle", "value": 1.5}` | a `oneof` of messages `{ f0 }` |
| `List[T]` | `[1, 2]`, or one per line on stdin | `[1, 2]` | `repeated` |
| `Map[String, V]` | `map{"a": 1}` | `{"a": 1}` | `map<string, V>` |

## Choosing

* **Command line** for people and scripts on one machine, and for pipes
  between programs (the binary protocol of [protocol.md](protocol.md)
  keeps types between fwp programs).
* **REST** for clients that are not fwp programs: browsers, scripts in any
  language, tools that read OpenAPI; and for calling other services'
  REST APIs from fwp.
* **gRPC** between parts of one fwp program deployed apart: calls stay
  ordinary calls in the source, with exact types and a fingerprint check.

The choice is made when building, so a function can be all three at once,
and moving from one to another needs no change to the function.

## Limitations

* Parameters that only one interface has (a `Request`, the principal of
  `# auth:`, header parameters) make a function less useful as the others:
  a `Request` parameter is a message on gRPC and a flag record on the
  command line. Keep such functions thin, around a function of the data.
* Authentication is per interface: REST endpoints verify credentials
  with `authenticate`, gRPC methods check metadata or the client's
  certificate themselves, and command lines have none.
* Streams are gRPC's alone: REST has no streaming responses, and the
  command line reads standard input as a list.
