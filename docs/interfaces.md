# One function, three interfaces

An exported fwp function can be a command-line program, a REST endpoint
and an MCP tool, without a line of interface code. Its type is
the contract; its comments are the documentation; a few comment lines
adjust what the types cannot say. You choose which interfaces a function
has, and build the program for one of them:

```
$ fwp build books.fwp --cli -o books        # a command-line program
$ fwp build books.fwp --rest -o books-api   # an HTTP server with OpenAPI
$ fwp build books.fwp --mcp -o books-mcp    # an MCP server for AI clients
```

[`examples/rest/books.fwp`](../examples/rest/books.fwp) builds all three
from one file. This page compares them; [cli.md](cli.md),
[rest.md](rest.md) and [mcp.md](mcp.md) describe each, and tutorials
[16](tutorials/16-clis/README.md), [17](tutorials/17-rest-and-openapi/README.md)
and [21](tutorials/21-mcp/README.md) build one of each.

## Exposing functions

`export` makes a function visible to other modules; it does not put it on
any interface. A comment line `# expose:` does, naming the interfaces:
`cli`, `rest`, `mcp`. Above an `export`, it exposes that function:

```fwp
# Quote an order: the price of each line and the total, with a 10%
# discount for the coupon `FWP10`.
# expose: rest, mcp
# route: POST /quotes
# error: UnknownBook 404, OutOfStock 409, BadCoupon 422
export quote-order : Order -> Quote ! {Error[OrderError]}
```

In the file's leading comment, it exposes every exported function that
has no `# expose:` line of its own:

```fwp
# A small bookstore: a catalog and price quotes.
#
# expose: rest, cli, mcp
```

`fwp build --cli`, `--rest` and `--mcp` (and `fwp serve`, `fwp exec
--cli` and `fwp openapi`) take the functions
exposed as their interface, and stop with an error when there are none.
A line that configures an interface (`# route:`, `# command:`, ...) above
a function not exposed as that interface is an error too.

What names a function itself needs no `# expose:`: `fwp exec file f`,
`fwp build --fn f`, `--staticlib` and `--cdylib` (a C library of the
exports), and the services of a split program (`--service m`,
[services.md](services.md)), where every exported function of the module
stays callable by the rest of the program, deployed as one executable or
as several parts that talk gRPC: the function's code does not change
either way. gRPC is not an interface of its own: it carries the calls
between the parts of a split program, and nothing else.

| | Command line | REST | MCP |
|---|---|---|---|
| unit | the root file's exported functions | the root file's exported functions | the root file's exported functions |
| build | `fwp build --cli`, `fwp exec --cli` | `fwp build --rest`, `fwp serve --rest` | `fwp build --mcp`, `fwp serve --mcp` |
| name | `books quote-order` (or `# command:`) | `POST /quote-order` (or `# command:`, `# route:`) | the tool `quote-order` |
| record first parameter | flags: `--author x --tag a --tag b` | query parameters (GET, DELETE, or with more parameters): `?author=x&tag=a&tag=b` | the arguments object itself when it is the only parameter, else an argument |
| other parameters | positional arguments, named by `# args:`; the last from stdin | path parameters, query parameters, the body (the last): JSON, or a form or `multipart/form-data` with files (`# accepts:`) | members of the arguments object, named by `# args:` (`input`, or `arg1`, `arg2`, ...) |
| `()` parameter | implicit | implicit | no argument |
| value encoding | fwp's text format (`show`); strings as they are | JSON (`json.write`, `json.read`); text and CSV responses by `Accept` (`# produces:`) | JSON, as REST |
| result | printed; a list one per line | the JSON body of a 200 (`# status:`) | text content and `structuredContent` (`{"result": ...}` unless it is an object) |
| `()` result | nothing | 204 | `{}` |
| `None` | nothing | 404 | `null` |
| `Err e`, `Error[E]` | `name: e` on stderr, exit status 1 | `{"error": e}` with a status (`# error:`, the error's `status`, else 500) | a result with `isError`, the error as text |
| bad arguments | usage error, exit status 2 | 400 `{"error": "path.id: ..."}` | a result with `isError` naming the argument |
| request headers | environment variables (`[env: VAR]`) | parameters (`# header:`, `# cookie:`, field comments), or a `Request` parameter | — |
| response status and headers | `Outcome` (the exit status) | `RestReply[T]` (`rest.reply 201 x`, `rest.with-header`) | — |
| authentication | — | `# auth:` (bearer tokens, API keys, client certificates) verified by `authenticate` | — (stdio: the client runs the server; HTTP: local origins only) |
| browsers | — | CORS (`# cors:`, `--cors`) | pages of `localhost` only (`Origin`) |
| compression | — | gzip or deflate by `Accept-Encoding` (responses of 1 KiB or more), compressed request bodies ([rest.md](rest.md#http2-and-compression)) | — |
| TLS | — | HTTPS with `--tls-cert` and `--tls-key`, client certificates with `--tls-client-ca` ([tls.md](tls.md#rest)) | — |
| documentation | `--help` from the comments | OpenAPI 3.1 (`fwp openapi`, `--yaml`, `/openapi.json`) and its page (`/docs`) | `tools/list`: descriptions from the comments, JSON Schemas from the types |
| calling it from fwp | `process.run` | `fwp openapi --import` gives typed functions (of OpenAPI 3 or Swagger 2.0, in JSON or YAML) | — |
| versioning | — | unknown members are ignored, so new `Option` fields and new results' fields keep clients working; the document is the contract | protocol version 2026-07-28; `ttlMs` and `cacheScope` of the tool list |

## Comment lines

| Line | Command line | REST | MCP |
|---|---|---|---|
| the comment block above `export` | `--help` | summary and description | the tool's description |
| `# expose: cli, rest, mcp` | exposes it | exposes it | exposes it |
| `# args: A B...` | names of positional arguments; `B...` takes the rest | names of path and query parameters | names of the arguments |
| `# command: name` | the command's name | the endpoint's name and default path | — |
| `# route: METHOD /path/{p}` | — | the route | — |
| `# status: 201` | — | the success status | — |
| `# error: 404`, `# error: V 404, W 422` | — | error statuses | — |
| `# header: X-Id -> id`, `# cookie: s -> sid` | — | parameters from headers and cookies | — |
| `# auth: bearer`, `# auth: api-key header X-Key`, `# auth: client-cert`, `# auth: none` | — | security schemes (also in the file's leading comment) | — |
| `# timeout: 5s` | — | a time limit (503) | — |
| `# response-header: Location ...` | — | a header of a `RestReply` | — |
| `# accepts: json, form, multipart` | — | the media types of the body (415 for others) | — |
| `# produces: json, text, csv` | — | the media types of the result, by `Accept` (406) | — |
| `# cors: origins` (leading comment) | — | allowed origins | — |
| a field comment `-x text` | the short flag `-x` and the flag's help | the query parameter's description | the argument's description |
| a field comment `json: name` | — | the JSON name of the field | the JSON name of the field |
| a field comment `header: X-Id`, `cookie: name` | — | the field comes from a header or cookie | — |
| a type comment `json: untagged` | — | a variant type written as its value alone | a variant type written as its value alone |
| `export f.defaults`, `export defaults` | defaults of flags | — | — |
| `export version` | `--version` | `info.version` | `serverInfo.version` |

## Encodings of the same value

| fwp | Command line (text) | REST (JSON) |
|---|---|---|
| `I64` | `-3` | `-3` |
| `U128` | `340282366920938463463374607431768211455` | `"340282366920938463463374607431768211455"` |
| `F64` | `1.5`, `inf` | `1.5`, `"Infinity"` |
| `String` | `hello` (as it is) | `"hello"` |
| `Bytes` | `bytes[102, 111]` | `"Zm8="` |
| `Duration` | `1500ms` | `"1500ms"` |
| `Option[T]` | `Some 3`, `None`; flags may be absent | the value, or absent or `null` |
| record | `{x = 1, y = 2}`, or flags | `{"x": 1, "y": 2}` |
| enum | `Red` | `"Red"` |
| variant | `Circle 1.5` | `{"type": "Circle", "value": 1.5}` |
| `List[T]` | `[1, 2]`, or one per line on stdin | `[1, 2]` |
| `Map[String, V]` | `map{"a": 1}` | `{"a": 1}` |

## Choosing

* **Command line** for people and scripts on one machine, and for pipes
  between programs (the binary protocol of [protocol.md](protocol.md)
  keeps types between fwp programs).
* **REST** for clients that are not fwp programs: browsers, scripts in any
  language, tools that read OpenAPI; and for calling other services'
  REST APIs from fwp.
* **MCP** for AI applications: the functions become tools that a model
  calls, with schemas and descriptions it reads.

The choice is made with `# expose:` and when building, so a function can
have all three at once, and moving from one to another needs no change to
the function. Between the parts of one fwp program deployed apart, calls
need none of these: they stay ordinary calls in the source, carried by
gRPC with exact types and a fingerprint check ([services.md](services.md)).

## Limitations

* Parameters that only one interface has (a `Request`, the principal of
  `# auth:`, header parameters) make a function less useful as the others:
  a `Request` parameter is a flag record on the command line and an
  object argument of an MCP tool. Keep such functions thin, around a function of the data.
* Authentication is per interface: REST endpoints verify credentials
  with `authenticate`; command lines and MCP tools have none (an MCP
  client runs the server it calls).
* There are no streams: REST has no streaming responses, the command
  line reads standard input as a list, and an MCP tool returns one
  result. (`Iterator` and `Channel` stream between the parts of a split
  program.)
