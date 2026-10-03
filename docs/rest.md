# REST APIs and OpenAPI

Any exported function is a REST endpoint. Its parameters are the request:
path parameters, query parameters and a JSON body (or a form, with
files); its result is the JSON response (or text, or CSV), and its errors
are error responses. One file of exported
functions builds into one HTTP server, which also serves its OpenAPI 3.1
document. In the other direction, `fwp openapi --import` turns the OpenAPI
document of any API (JSON or YAML, OpenAPI 3 or Swagger 2.0) into an fwp
module of typed client functions. There
is nothing to declare and no routing or JSON code to write.

```
$ fwp serve --rest examples/rest/books.fwp
fwp: rest listening on http://127.0.0.1:8080
$ curl localhost:8080/books/1
{"id":1,"title":"Structure and Interpretation of Computer Programs",...}
$ curl 'localhost:8080/books?tag=classic&max-price=30'
[{"id":3,"title":"Gödel, Escher, Bach","author":"Hofstadter",...}]
$ curl -d '{"lines":[{"book":2,"quantity":2}]}' localhost:8080/quotes
{"error":{"type":"OutOfStock","value":{"available":0,"book":2,"wanted":2}}}
$ curl localhost:8080/books/x
{"error":"path.id: expected an integer, got \"x\""}
```

The same functions are also a command-line program ([cli.md](cli.md))
and a gRPC service ([services.md](services.md));
[interfaces.md](interfaces.md) compares the three.
[`examples/rest`](../examples/rest/books.fwp) is a small bookstore, and
[tutorial 17](tutorials/17-rest-and-openapi/README.md) walks through
one.

## Commands

| Command | Result |
|---|---|
| `fwp build app.fwp --rest -o server` | a native HTTP server of the exported functions |
| `fwp serve --rest app.fwp [--listen addr]` | the same server, compiled and cached (`--interp` interprets it) |
| `fwp openapi app.fwp` | the OpenAPI document of the endpoints, as JSON (`--yaml`: as YAML) |
| `fwp openapi --import spec.json [-o client.fwp]` | an fwp client module of an API (JSON or YAML; OpenAPI 3.0, 3.1 or Swagger 2.0) |

A server takes `--listen host:port` (default: `FWP_REST_ADDR`, else
`127.0.0.1:8080`; port 0 picks a free port), `--tls-cert file` and
`--tls-key file` (default: `FWP_TLS_CERT` and `FWP_TLS_KEY`; with both,
it serves HTTPS, see [tls.md](tls.md#rest)), `--tls-client-ca file`
(default: `FWP_TLS_CLIENT_CA`: require client certificates signed by
these CAs, [tls.md](tls.md#mutual-tls)), `--cors origins` (the
origins that may call it from browsers, [below](#cors); default:
`FWP_REST_CORS`), `--openapi` (print the document and exit) and `--help`.
It writes `fwp: rest listening on http://host:port` (`https://` with TLS)
on stderr once it accepts connections, and serves:

* each endpoint, with JSON request and response bodies (and forms,
  files, text and CSV where it declares them, [below](#forms-and-files));
* `GET /openapi.json`, the document `fwp openapi` prints;
* `GET /docs`, an HTML page of the document: each operation with its
  parameters, responses and security, and the schemas (plain HTML and CSS,
  without scripts or anything fetched from elsewhere);
* `{"error": "not found"}` (404) for other paths and
  `{"error": "method not allowed"}` (405) for other methods.

The server is the HTTP/1.1 server of `lib/http.fwp`, with its limits and
timeouts ([concurrency.md](concurrency.md#http)): keep-alive, bounded
connections, request and body sizes, per-request timeouts, and a
graceful shutdown on SIGINT and SIGTERM. The errors the server answers
itself are JSON too: `{"error": "request timed out"}` (503),
`{"error": "invalid request line"}` (400), `{"error": "request body too
large"}` (413), and so on. A `HEAD` request is answered like a `GET`.
WebAssembly targets have no sockets, so `--rest` builds native programs
only.

## Routes

An exported function `f` is `POST /f` unless a comment line above its
`export` gives another route; a `# command:` line renames it as it renames
a command:

```fwp
# A book by its id.
# route: GET /books/{id}
export book : I64 -> Option[Book]
```

| Comment line | Meaning |
|---|---|
| `# route: GET /books/{id}` | the method (`GET`, `POST`, `PUT`, `PATCH` or `DELETE`) and the path; a segment `{name}` is a path parameter |
| `# args: id limit` | the names of the positional parameters (as for command lines) |
| `# status: 201` | the status of a success (default 200, or 204 for a `()` result); for a `RestReply`, the statuses it may answer with (`# status: 200, 301`), the first one the default |
| `# error: 404` | the status of errors (default 500) |
| `# error: NotFound 404, Invalid 422` | the status of each variant of the error type, and possibly a default |
| `# command: name` | the name of the endpoint: its default path and its operation id |
| `# header: X-Request-Id`, `# header: X-Request-Id -> id` | a parameter from a request header ([below](#headers-and-cookies)) |
| `# cookie: session`, `# cookie: session -> sid` | a parameter from a cookie |
| `# auth: bearer`, `# auth: api-key header X-API-Key`, `# auth: none` | the credentials the endpoint needs ([below](#authentication)) |
| `# timeout: 5s` | how long a call may take, else 503 ([below](#timeouts)) |
| `# response-header: Location the new item` | a header that a `RestReply` sets, for the document ([below](#replies-statuses-and-headers)) |
| `# accepts: json, form, multipart` | the media types of the request body ([below](#forms-and-files)) |
| `# produces: json, text, csv` | the media types of the response, chosen by `Accept` ([below](#content-negotiation)) |

The comment lines are not part of the description, which becomes the
operation's summary and description in the OpenAPI document (and the help
of the command). Exported constants, `version` and `defaults` are not
endpoints, and neither is `authenticate`.

In the file's leading comment (the module description, separated by a
blank line from the first declaration), `# auth:` and `# timeout:` lines
are the defaults of every endpoint, and a `# cors:` line lists the origins
that browsers may call the API from.

## Arguments

Each parameter of the function comes from somewhere in the request:

1. **`()`** parameters are implicit (`ping : () -> String` is
   `GET /ping` with no arguments).
2. **The options record.** A record first parameter of a function with
   several parameters, or of a `GET` or `DELETE` route, is an options
   record, as on a command line: each field is a query parameter of its
   name.

   | Field type | In the query | When absent |
   |---|---|---|
   | `Bool` | `?desc`, `?desc=true`, `?desc=false` | `False` |
   | `Option[T]` | `?limit=10` | `None` |
   | `List[T]` | repeated: `?tag=a&tag=b` | `[]` |
   | any other `T` | `?prefix=x` | a 400 |

3. **Path parameters** bind the parameter of their name: the names of
   `# args:`, or, without it, the positional parameters in order.
4. **The body.** For `POST`, `PUT` and `PATCH`, the last remaining
   parameter is the JSON body (an `Option` body may be absent).
5. **Query parameters.** The other parameters are query parameters of
   their names (`# args:`, else `arg1`, `arg2`, ... by position): an
   `Option` is optional, a `List` repeated.

Besides these, a parameter may come from a request header or a cookie
([below](#headers-and-cookies)), be the whole `Request`, or be the
principal that authentication found ([below](#authentication)).

Path and query parameters must be numbers, strings, `Bool`, enums or
`Duration` (or `Option`s and `List`s of them for query parameters); the
body may be any type that has a JSON form. A function of another kind is
an error when the server or the document is built, naming the function
and the parameter.

```fwp
# Search by a term in the path and an optional limit.
# route: GET /search/{term}
# args: term limit
export search : String -> Option[I64] -> List[Item]

# route: POST /sum/{a}/{b}
# args: a b c xs
export sum4 : I64 -> I64 -> I64 -> List[I64] -> I64   # POST /sum/1/2?c=3 with [4, 5]
```

Values are decoded with the typed JSON codec below; path and query values
are strings, which it accepts for numbers, `Bool` and enums (`"42"`,
`"true"`). A value that does not decode is a 400 whose message names the
parameter and the place: `path.id: expected an integer, got "x"`,
`query.limit: ...`, `$.items[2].price: ...` (in the body). A body that is
not JSON is `invalid JSON in the request body: unexpected character at
byte 3`, a missing one `missing request body`, a missing required query
parameter `missing query parameter c`.

## Headers and cookies

A function reads request headers and cookies through its parameters, so
that they are typed, documented in the OpenAPI document (`in: header`,
`in: cookie`) and generated in clients:

```fwp
# A greeting for the caller.
# route: GET /hello
# header: X-Name -> name
# cookie: session -> session
export hello : String -> Option[String] -> String
```

* `# header: Name -> param` binds a request header to the parameter
  `param` (named by `# args:`); without `-> param`, the parameter is the
  header's name in lower case. Without `# args:`, path parameters and then
  the headers and cookies, in the order of their lines, name the
  positional parameters in order, as path parameters do.
* `# cookie: name -> param` does the same with a cookie of the `Cookie`
  header (percent-decoded).
* A field comment `header: X-Trace-Id` or `cookie: theme` in an options
  record reads that field from a header or cookie instead of the query:

  ```fwp
  Seen = {
      # header: X-Trace-Id
      trace: Option[String],
      # cookie: theme
      theme: Option[String],
      limit: Option[I64],
  }
  ```

The types are those of query parameters: an `Option` is optional (absent
is `None`), a `List` header takes every line of the header (one element
per line), and other types are required: a missing one is a 400
(`{"error": "missing header X-Name"}`), a value that does not decode too
(`header.X-Name: ...`). Header names are case-insensitive.

A parameter of type `Request` (`lib/http.fwp`) is the whole request:
method, path, query, headers, body and the client's address
(`http.header "x-forwarded-for"`). It is not in the document.

The headers are parameters rather than a context to ask for (as
`grpc.metadata` is for gRPC), so the document and generated clients know
them; `Request` covers the rest.

## Replies: statuses and headers

A function that returns `RestReply[T]` chooses the status and the headers
of each response; `T` is the JSON body (none for `RestReply[()]`):

```
RestReply[T] = { status: I64, headers: List[(String, String)], body: T }
```

```fwp
# Create an item: 201 with its location.
# route: POST /items
# status: 201
# response-header: Location where the item is
export create : User -> Item -> RestReply[Item]
create = curry (.1
    | rest.reply 201
    | fork
        (rest.with-header "location")
        (.body | .id | format "/items/{}")
        id)
```

`rest.reply status body` makes one without headers and
`rest.with-header name value` adds one. `# status:` lists the statuses it
may answer with (each documented with `T`'s schema, but 204 and 304
without a body) and `# response-header:` the headers it sets (documented
in each of them). A status outside 100 to 599, or a header with a line
break, is a 500.

## Forms and files

By default the body is JSON, whatever the request's `Content-Type`. An
endpoint with `# accepts:` takes the media types it lists, chosen by
`Content-Type` (the first one when the request has none), and answers
others with 415 (`{"error": "unsupported content type text/plain (it
accepts application/json, multipart/form-data)"}`):

| Name | Media type | The body |
|---|---|---|
| `json` | `application/json` (and `+json` types) | JSON, as above |
| `form` | `application/x-www-form-urlencoded` | the fields of a form, as browsers and `curl -d` send them |
| `multipart` | `multipart/form-data` | the parts of a form with files, as browsers and `curl -F` send them |

```fwp
# Files sent with a title.
Batch = { title: String, files: List[Upload], tags: List[String] }

# route: POST /uploads
# accepts: multipart
export upload : Batch -> Receipt
```

```
$ curl -F title=notes -F files=@README.md -F files=@LICENSE localhost:8080/uploads
$ curl -d 'name=Ada&message=hello' localhost:8080/guestbook
```

A form fills the fields of the body's record by name (their JSON names):

| Field type | From the form | When absent |
|---|---|---|
| numbers, strings, enums, `Duration` | the field's (last) value, read as a query parameter is | a 400 |
| `Bool` | `on` (what a checkbox sends) or empty is true; `true` and `false` | `False` |
| `Option[T]` | the value; an empty one is absent | `None` |
| `List[T]` | every value of the name, in order | `[]` |
| `Bytes` | the bytes of the part (a file or not) | a 400 |
| `Upload` | a file part: `Upload = { filename: String, content-type: String, bytes: Bytes }` (`lib/rest.fwp`); a text part is a file without a name | a 400 |

`Option`s and `List`s of `Bytes` and `Upload` work the same way. Other
field types (records, nested lists) cannot come from a form, and a body
that is not a record cannot be a form: both are errors when the server
is built. A text value that is not UTF-8 is a 400, as is a multipart
body without parts (`{"error": "invalid multipart/form-data body"}`);
values that do not decode are 400s as in JSON bodies
(`$.size: expected an integer, got "x"`). In JSON, an `Upload` is an
object whose `bytes` are base64, so an endpoint that also accepts JSON
takes files that way. The whole body is in memory (within the server's
body size limit) before it is decoded.

For hand-written servers, `rest.multipart-parts boundary bytes` gives the
parts (`RestPart`s) of a body, and `rest.header-param "boundary"` the
boundary of its `Content-Type`.

## Content negotiation

The response is JSON. An endpoint with `# produces:` writes its result in
the media types it lists, chosen by the request's `Accept` header (with
qualities and wildcards: `text/*;q=0.5, application/json;q=0.4`), the
first one when the request has none; a request that accepts none of them
gets 406 (`{"error": "not acceptable: the response is application/json,
text/plain"}`) before the function is called:

| Name | Media type | The result |
|---|---|---|
| `json` | `application/json` | its JSON |
| `text` | `text/plain; charset=utf-8` | as `show` writes it (`Display`) |
| `csv` | `text/csv; charset=utf-8` | for a list of records whose fields are numbers, strings, `Bool`, enums or `Duration` (or `Option`s of them): a header of the fields' JSON names, then a row per record (`lib/csv.fwp`), with absent values empty |

```fwp
# route: GET /guestbook
# produces: json, csv, text
export guestbook : () -> List[Entry]
```

```
$ curl -H 'accept: text/csv' localhost:8080/guestbook
name,message,stars
Ada,hello,5
Alan,"a, b, ""c""",
```

It applies to the value of `Option`, `Result` and `RestReply` results;
`None`, errors and the server's own errors stay JSON. A `()` result has
no body to negotiate (an error when the server is built).
[`examples/rest/uploads.fwp`](../examples/rest/uploads.fwp) has files, a
form and the three formats.

## Authentication

Endpoints can require a bearer token (`Authorization: Bearer <token>`) or
an API key, which a function of the program verifies:

```fwp
# The clerk of a bearer token: REST servers check the credentials of
# endpoints with `# auth:` with this function.
authenticate : String -> Result[Clerk, String]
authenticate = match
    "clerk-token" -> Ok Clerk { name = "clerk" }
    _ -> const (Err "unknown token")
```

| Line | The credential |
|---|---|
| `# auth: bearer` | the token of `Authorization: Bearer <token>` |
| `# auth: api-key header X-API-Key` (or `api-key X-API-Key`) | the value of a header |
| `# auth: api-key query api_key` | the value of a query parameter |
| `# auth: api-key cookie key` | the value of a cookie |
| `# auth: client-cert` | the subject of the client's certificate (`CN=alice,O=Example`), on a server that requires client certificates (`--tls-client-ca`, [tls.md](tls.md#mutual-tls)) |
| `# auth: none` | no credentials (overrides the file's default) |

Several `# auth:` lines are alternatives: the first credential the request
carries is checked. `# auth:` lines in the file's leading comment apply
to every endpoint without its own.

* **The verifier** is the function `authenticate : String -> Result[P,
  String]` of the file, exported or not (it is not an endpoint; it may
  perform the effects of endpoints). It gets the credential and returns
  the principal, or why the credential is refused.
* **Failures** are 401 with the reason as the error:
  `{"error": "missing credentials"}`, `{"error": "unknown token"}`, with
  `WWW-Authenticate: Bearer` for bearer tokens. An endpoint that rejects
  a principal (an authorization decision) fails with its own error, such
  as `http.fail 403 "admins only"`.
* **The principal** is passed to a parameter of type `P`, when `P` is a
  type of the program (a record or variant type) and the endpoint has a
  parameter of that type: `export me : User -> User` with `# auth:` gets
  the user. A parameter of type `P` in an endpoint without `# auth:` is an
  error.
* **The document** has `components/securitySchemes` (`bearerAuth`, of type
  `http`, scheme `bearer`; `apiKey-X-API-Key`, of type `apiKey`) and a
  `security` requirement per operation, and a 401 response.

On the server it is `rest.secured authenticate [RestAuth.Bearer] route`
(`lib/rest.fwp`), which can secure hand-written routes too.

## CORS

A `# cors:` line in the file's leading comment lets pages of other origins
call the API from browsers:

```
# cors: https://app.example https://admin.example
```

(`*` allows any origin.) `--cors https://a.example,https://b.example` or
`FWP_REST_CORS` replace the origins when the server starts. For a request
with an allowed `Origin`, the server:

* answers a preflight request (`OPTIONS` with
  `Access-Control-Request-Method`) with 204, the methods of the API's
  routes, the request headers it reads (`Content-Type`, `Authorization`
  for bearer tokens, API key headers and header parameters) and a max age
  of 600 seconds;
* adds `Access-Control-Allow-Origin` (the origin), `Vary: Origin`,
  `Access-Control-Expose-Headers` (the `# response-header:` headers) and,
  unless any origin is allowed, `Access-Control-Allow-Credentials: true`
  to other responses, errors included.

Requests from other origins get no CORS headers (browsers then keep the
response from the page), and their preflight requests get 405.

## Timeouts

`# timeout: 5s` (on an endpoint, or in the leading comment for all) gives
each call a time limit: when it passes, the call's task is cancelled (at
its next suspension point, as for `task.within`) and the client gets 503
`{"error": "request timed out"}`. The HTTP server's own request timeout
(30 seconds) applies to every request too, with the same answer.

## HTTP/2 and compression

REST servers speak HTTP/2 as well as HTTP/1.1 (h2 with ALPN over TLS, and
h2c with prior knowledge on cleartext connections; see
[concurrency.md](concurrency.md#http2)): `curl --http2-prior-knowledge
http://127.0.0.1:8080/books/1` works as it does with HTTP/1.1. Responses
of 1 KiB or more are compressed with gzip (or deflate) for clients that
send `Accept-Encoding`, and request bodies with `Content-Encoding: gzip`
or `deflate` are decompressed before they are decoded. Generated clients
(`rest.fetch`) use `http.send`, which asks for compressed responses,
decompresses them, and uses HTTP/2 when a TLS server offers it.

## Results and errors

| The function... | The response |
|---|---|
| returns a value | 200 (or `# status:`), its JSON |
| returns `()` | 204, no body |
| returns `None` | 404 `{"error": "not found"}` |
| returns `Some x` | `x` as a value |
| returns a `RestReply` | its status, headers and body |
| returns `Err e` | `{"error": e}` with the error's status |
| raises an `Error[E]` | the same |
| traps | the server stops, as any fwp program (`fwp: trap: ...`) |

The status of an error `e` is, in order: the status that `# error:` gives
its variant (`NotFound 404`), the value of its own `status` field (so
`http.fail 409 "conflict"`, an `HttpError`, is a 409), the default of
`# error:`, else 500. An endpoint may perform `IO`, `FileIO`, `Network`,
`Async` and `Error`; other effects (`Process`, `Random`, `State`) are
rejected when the server is built.

## JSON

The codec is `json.write : a -> String where Encode[a]` and
`json.read : String -> Result[a, String] where Decode[a]` in the standard
library ([stdlib.md](stdlib.md#json)), with `json.encode-value` and
`json.decode` for `Json` values. Any value that can be sent to a service
can be written, in both backends, identically:

| fwp | JSON |
|---|---|
| `I8` ... `I64`, `U8` ... `U64`, `TInt`, `Trit` | numbers, exactly (beyond 2^53 some readers, such as JavaScript's, lose digits; decimal strings are accepted too) |
| `I128`, `U128` | decimal strings: `"-170141183460469231731687303715884105728"` |
| `F32`, `F64` | numbers in the shortest form that reads back exactly; `"NaN"`, `"Infinity"`, `"-Infinity"` |
| `Bool`, `String` | `true`, `false`; strings |
| `Bytes` | base64 strings (`"Zm9v"`); URL-safe and unpadded base64 are accepted |
| `Duration` | strings as `show` writes them: `"1500ms"`, `"2min"`; reading also accepts fractions (`"1.5s"`) and numbers of nanoseconds |
| `()` | `{}` (`null` and `[]` are accepted) |
| records, nominal or not | objects; nominal records in declaration order. A field of type `Option` that is `None` is left out, and absent or `null` reads as `None` |
| tuples | arrays: `[1, "a"]` |
| `List`, `Array`, `Set` | arrays |
| `Map[String, V]` | objects; other maps are arrays of `[key, value]` pairs |
| `Option[T]` | `null` or the value; an `Option[Option[T]]` is `null` or `[value]` |
| variants without fields (enums) | strings: `"Red"` |
| other variants | `{"type": "Circle", "value": 1.5}`; `value` is absent for a constructor without fields and an array for several (`{"type": "Rect", "value": [2.0, 3.0]}`); a bare string is accepted for constructors without fields |
| `Json` | itself |

Integers may be written with a fraction or an exponent if their value is
integral (`1e3`, `5.0`), out-of-range values are errors
(`$.age: 300 is out of range for U8`), and unknown members are ignored.
When reading a record, the fields are read in declaration order and the
first wrong one is reported.

A field comment `# json: name` gives a field another JSON name, for names
that are not fwp names (`type`, `userId` is one already, `user_id` too,
`2nd` is not):

```fwp
Event = {
    # json: type
    kind: String,
    user-id: I64, # json: userId
}
```

A comment line `# json: untagged` above a variant type writes a value of
it as the value of its constructor alone (a constructor without fields is
`null`, one with several fields an array), and reads one by trying the
constructors in order: the first whose fields read wins. It is the JSON
of a `oneOf` without a discriminator; clients from `fwp openapi --import`
use it for those:

```
# json: untagged
SessionData =
    | SessionData.Text String
    | SessionData.Int I64
```

Values are read leniently (`"42"` reads as an integer), so put the
constructors whose values are strings last, or order them from the most
to the least specific.

## OpenAPI

`fwp openapi app.fwp` prints the OpenAPI 3.1 document of the endpoints
(JSON, two-space indentation), derived from the same rules as the server:

* `info`: the file name as the title, the exported `version` (default
  `0.1.0`) and the comment block at the top of the file as the
  description.
* An operation per endpoint, with the function's name (or `# command:`) as
  its `operationId`, the first sentence of its comment as the summary,
  its parameters (`in: path`, `in: query`, `in: header` or `in: cookie`,
  with the field comments of an options record as descriptions), its
  request body (an entry per media type of `# accepts:`; a form's schema
  is an object of the record's fields, with files as `{type: string,
  format: binary}`), its responses (an entry per media type of
  `# produces:`, text and CSV as strings; 406 and 415 when it negotiates) (the successes, with the headers of
  `# response-header:`; 400 for arguments that do not decode, 401 for
  endpoints that need credentials, 404 for `Option` results, 503 for
  endpoints with a time limit, and the statuses of its errors with the
  schema of `{"error": E}`, `default` if the error has its own `status`),
  and its `security`.
* `components/schemas`: nominal records, enums and variant types by name.
  Generic types get names such as `ResultI64String`; and
  `components/securitySchemes`.

`fwp openapi --yaml app.fwp` prints the same document as YAML.

| fwp | Schema |
|---|---|
| `I8`, `I16`, `U8`, `U16` | `integer`, `int32`, with `minimum` and `maximum` |
| `I32`; `I64`, `ISize`; `U32`; `U64`, `USize` | `integer`: `int32`; `int64`; `int64` from 0 to 2^32 - 1; `uint64` from 0 |
| `I128`, `U128` | `string`, formats `int128`, `uint128`, with a pattern |
| `F32`, `F64` | `number`: `float`, `double` |
| `Bytes`, `Duration` | `string`: `byte` (`contentEncoding: base64`); `duration` with a pattern |
| record | `object` with `properties` in declaration order and `required` for the fields that are not `Option`s; field comments are descriptions |
| enum | `string` with `enum` |
| variant type | `oneOf` the constructors' schemas, with `discriminator: {propertyName: type}`; each is an object with `type` (`const`) and `value` (a tuple is `prefixItems`) |
| variant type with `# json: untagged` | `oneOf` the schemas of the constructors' values, without a discriminator |
| `Option[T]` | not required in an object; elsewhere `anyOf: [T, {type: null}]` |
| `List`, `Array`; `Set` | `array`; with `uniqueItems` |
| `Map[String, V]` | `object` with `additionalProperties` |
| tuple | `array` with `prefixItems` and `items: false` |
| `Json` | `{}` |

The test suite checks the documents structurally (references, parameters,
operation ids), validates the server's responses against their schemas
with Python's `jsonschema` when it is installed, and compares the
documents of `tests/rest/api.fwp`, `tests/rest/secure.fwp` and
`examples/rest/books.fwp` (and the YAML of `secure.fwp`) with golden
files.

## Calling REST APIs

`fwp openapi --import spec.json -o client.fwp` generates a module of
types and functions from an OpenAPI 3.0 or 3.1 document, or a Swagger
2.0 one, in JSON or YAML:

```
$ fwp openapi examples/rest/books.fwp > books.json
$ fwp openapi --import books.json -o bookclient.fwp
```

```fwp
# A book by its id.
# GET /books/{id}
book : String -> I64 -> Option[Book] ! {Async, Network, Error[RestError]}
```

```fwp
import bookclient

main = 1 | bookclient.book "http://127.0.0.1:8080" | option.map .title | echo
```

* **Types.** Component schemas become types of their names: objects
  records (properties that are not required, or nullable, are `Option`s),
  string enums whose values are constructor names variant types (other
  string enums are `String`s), a `oneOf` with the discriminator `type` in
  fwp's form a variant type with fields, other `oneOf`s and `anyOf`s
  `# json: untagged` variant types with a constructor per alternative
  (`PetOrTag.Pet Pet`, `SessionData.Text String`; a `null` alternative
  makes it an `Option`), an `allOf` of object schemas one record with all
  their properties (an `allOf` of one schema is that schema), and other
  schemas aliases.
  Inline objects become records named after where they are
  (`PetOwner`). Properties that are not fwp names get one, with a
  `# json:` comment for the original. Formats follow the table above in
  reverse (`int32` is `I32`, `int64` `I64`, `float` `F32`, `byte` `Bytes`,
  `duration` `Duration`, ranges of `I8`, `U8`, `I16`, `U16`, `U32`).
* **Functions.** Each operation is a function named after its
  `operationId` in kebab case (`getPetById` is `get-pet-by-id`), of the
  base URL of the server, then its credential if it needs one, then its
  path parameters in the order of the path, then records of its query,
  header and cookie parameters (`GetPetsQuery`, `GetPetsHeaders`,
  `GetPetsCookies`), then its body: JSON, else a record sent as a form
  (`application/x-www-form-urlencoded`), else a record sent as
  `multipart/form-data` (`rest.multipart-request`), whose binary
  properties (`format: binary`) are `Upload`s. It returns the body of the
  first 2xx response: its JSON decoded, else its text as a `String`
  (`text/*`, asked for with `Accept`), else its `Bytes` (other media
  types), and `()` without content; as an `Option` that is `None` on a
  404 when the operation declares a 404 response described as "not
  found".
* **YAML and Swagger 2.0.** YAML documents are read by a YAML 1.2 reader
  of fwp's own (`src/yaml.rs`: block and flow collections, the quoting
  styles, block scalars, comments, anchors, aliases and merge keys).
  Swagger 2.0 documents are converted to OpenAPI 3 first
  (`src/swagger.rs`): `definitions` are the component schemas, a `body`
  parameter the request body with the media types of `consumes`,
  `formData` parameters a form (`multipart/form-data` when one is a
  `file`), responses get the media types of `produces`, `host` and
  `basePath` the server, and `securityDefinitions` the security schemes
  (`basic`, `apiKey`, `oauth2`).
* **Credentials.** An operation whose `security` (or the document's)
  requires a bearer token (`http` with scheme `bearer`, or OAuth 2 and
  OpenID Connect, whose access tokens are bearer tokens) or an API key
  (`apiKey` in a header, query parameter or cookie) takes the token or key
  as a `String` after the base URL, and its comment says which
  (`# auth: bearer (the token after the base URL)`). Of several
  alternatives the first supported one is used; an empty requirement
  (`{}`) means no credential is needed.
* **Errors.** Any other response raises `Error[RestError]`, a record of
  the status and the body; a failed connection has the status 0.
* **The client** is `rest.fetch` in `lib/rest.fwp` over `http.send`: one
  connection per call; `https://` base URLs use TLS, verifying the
  server's certificate with the system's CA certificates (or
  `SSL_CERT_FILE`; see [tls.md](tls.md)).

Schemas outside this subset (`not`, enums of numbers, an `allOf` of
schemas that are not all objects) become `Json` values, and operations
whose body is neither JSON, a form nor `multipart/form-data`, or that
only accept credentials of other schemes (HTTP basic authentication, mutual TLS), are left out; each
is reported on stderr, as in
`fwp openapi: spec.json: POST /user/logout: its security scheme \`basic\` is not supported (bearer tokens and API keys are); it is left out`.
The round trip is tested: a client generated from the document a server
serves calls that server, interpreted and natively, and decodes what it
answers (`tests/rest/roundtrip.fwp`; `tests/rest/secureroundtrip.fwp`
with tokens, headers, cookies and replies; `tests/rest/formsroundtrip.fwp`
with forms, files, text and CSV; `tests/rest/swaggerroundtrip.fwp`, a
client of a Swagger 2.0 document in YAML). The YAML that
`fwp openapi --yaml` prints makes the same client as the JSON.

## How it works

`fwp build --rest` and `fwp serve --rest` compile the file twice. The
first compilation gives the types and comments of the exported functions,
from which `src/rest.rs` computes the endpoints and `src/openapi.rs` the
document. The second compiles the file with a generated `main` added to it:

```
fwp-rest-main =
    rest.serve RestApi {
        openapi = "{\n  \"openapi\": \"3.1.0\", ...",
        docs = "<!doctype html>...",
        cors = RestCors { origins = ["http://localhost:3000"], methods = ["GET", "POST", "HEAD"], ... },
        routes = [
            rest.endpoint-option (RestRoute { method = "GET", path = "/books/{id}", sources = [RestSource.Path "id"], ... }) book,
            rest.endpoint (RestRoute { ... }) quote-order | rest.secured authenticate [RestAuth.Bearer],
            ...
        ],
    }
```

`rest.endpoint` (`lib/rest.fwp`) makes a route of `http.router`: it
gathers the arguments as JSON text (path and query values as strings, the
body as it is, or a JSON object of a form's fields:
`RestSource.Content`), decodes them with `json.read` at the type of the function's
parameters (a tuple for several), calls the function under `attempt`, and
writes the result or the error with `json.write` (`rest.endpoint-as`
writes the result in the format that `Accept` chooses). `rest.secured` checks
credentials before the endpoint's handler, `rest.within` gives it a time
limit, and `rest.serve` adds `/openapi.json`, `/docs`, CORS
(`rest.cors`) and JSON errors (`rest.error-response` as the server's
`error-response`); each can be used in hand-written servers. The typed codec is a
primitive implemented twice, in Rust (`src/jsontype.rs`) and in C over the
type descriptors (`runtime/fwp_rt_json.c`), which carry the declaration
order, the JSON names and flags for `Bool`, `Option`, `Json`,
`Duration` and untagged variant types. Everything else is fwp code, so both backends serve the same
endpoints byte for byte.

## Limitations

* Request bodies are JSON, forms and `multipart/form-data`, read whole
  into memory; responses are JSON, text and CSV. There are no other media
  types (XML), no streaming bodies and no `Content-Encoding`. A part's
  `filename*` (RFC 5987) is not read, and quotes in file names arrive as
  clients escape them (`%22`).
* Authentication is bearer tokens and API keys checked by one function;
  no HTTP basic authentication, OAuth flows or scopes (the token of an
  OAuth flow is a bearer token, which `authenticate` must verify itself).
  Generated clients do not send client certificates (operations that
  require `mutualTLS` are left out of them).
* CORS origins are exact (no patterns), and the methods, headers and max
  age of the policy are derived from the API rather than configured.
* A `RestReply` result chooses its status and headers, but errors keep
  the statuses of `# error:`, and redirects carry a body.
* Constructor names are JSON names: enums with values that are not fwp
  constructor names import as `String`. Untagged variant types are read
  by trying their constructors in order, so overlapping alternatives
  read as the first.
* `I64` values beyond 2^53 are exact in fwp's JSON, but JavaScript clients
  lose digits; query parameters in generated clients go through `Json`
  values (doubles).
* Compression is gzip and deflate (from scratch, below zlib's ratio); no
  Brotli or zstd, and streamed responses are not compressed.
