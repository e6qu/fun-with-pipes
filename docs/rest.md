# REST APIs and OpenAPI

Any exported function is a REST endpoint. Its parameters are the request:
path parameters, query parameters and a JSON body; its result is the JSON
response, and its errors are error responses. One file of exported
functions builds into one HTTP server, which also serves its OpenAPI 3.1
document. In the other direction, `fwp openapi --import` turns the OpenAPI
document of any API into an fwp module of typed client functions. There
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
| `fwp serve --rest app.fwp [--listen addr]` | the same server, interpreted |
| `fwp openapi app.fwp` | the OpenAPI document of the endpoints, as JSON |
| `fwp openapi --import spec.json [-o client.fwp]` | an fwp client module of an API |

A server takes `--listen host:port` (default: `FWP_REST_ADDR`, else
`127.0.0.1:8080`; port 0 picks a free port), `--openapi` (print the
document and exit) and `--help`. It writes
`fwp: rest listening on http://host:port` on stderr once it accepts
connections, and serves:

* each endpoint, with JSON request and response bodies;
* `GET /openapi.json`, the document `fwp openapi` prints;
* `{"error": "not found"}` (404) for other paths and
  `{"error": "method not allowed"}` (405) for other methods.

The server is the HTTP/1.1 server of `lib/http.fwp`, with its limits and
timeouts ([concurrency.md](concurrency.md#http)): keep-alive, bounded
connections, request and body sizes, per-request timeouts (503), and a
graceful shutdown on SIGINT and SIGTERM. A `HEAD` request is answered like
a `GET`. WebAssembly targets have no sockets, so `--rest` builds native
programs only.

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
| `# status: 201` | the status of a success (default 200, or 204 for a `()` result) |
| `# error: 404` | the status of errors (default 500) |
| `# error: NotFound 404, Invalid 422` | the status of each variant of the error type, and possibly a default |
| `# command: name` | the name of the endpoint: its default path and its operation id |

The comment lines are not part of the description, which becomes the
operation's summary and description in the OpenAPI document (and the help
of the command). Exported constants, `version` and `defaults` are not
endpoints.

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

## Results and errors

| The function... | The response |
|---|---|
| returns a value | 200 (or `# status:`), its JSON |
| returns `()` | 204, no body |
| returns `None` | 404 `{"error": "not found"}` |
| returns `Some x` | `x` as a value |
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

## OpenAPI

`fwp openapi app.fwp` prints the OpenAPI 3.1 document of the endpoints
(JSON, two-space indentation), derived from the same rules as the server:

* `info`: the file name as the title, the exported `version` (default
  `0.1.0`) and the comment block at the top of the file as the
  description.
* An operation per endpoint, with the function's name (or `# command:`) as
  its `operationId`, the first sentence of its comment as the summary,
  its parameters (`in: path` or `in: query`, with the field comments of an
  options record as descriptions), its request body and its responses: the
  success, 400 for arguments that do not decode, 404 for `Option` results,
  and the statuses of its errors with the schema of `{"error": E}`
  (`default` if the error has its own `status`).
* `components/schemas`: nominal records, enums and variant types by name.
  Generic types get names such as `ResultI64String`.

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
| `Option[T]` | not required in an object; elsewhere `anyOf: [T, {type: null}]` |
| `List`, `Array`; `Set` | `array`; with `uniqueItems` |
| `Map[String, V]` | `object` with `additionalProperties` |
| tuple | `array` with `prefixItems` and `items: false` |
| `Json` | `{}` |

The test suite checks the documents structurally (references, parameters,
operation ids), validates the server's responses against their schemas
with Python's `jsonschema` when it is installed, and compares the
documents of `tests/rest/api.fwp` and `examples/rest/books.fwp` with
golden files.

## Calling REST APIs

`fwp openapi --import spec.json -o client.fwp` generates a module of
types and functions from an OpenAPI 3.0 or 3.1 document in JSON:

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
  fwp's form a variant type with fields, and other schemas aliases.
  Inline objects become records named after where they are
  (`PetOwner`). Properties that are not fwp names get one, with a
  `# json:` comment for the original. Formats follow the table above in
  reverse (`int32` is `I32`, `int64` `I64`, `float` `F32`, `byte` `Bytes`,
  `duration` `Duration`, ranges of `I8`, `U8`, `I16`, `U16`, `U32`).
* **Functions.** Each operation is a function named after its
  `operationId` in kebab case (`getPetById` is `get-pet-by-id`), of the
  base URL of the server, then its path parameters in the order of the
  path, then a record of its query parameters (`GetPetsQuery`), then its
  JSON body. It returns the decoded body of the first 2xx response (`()`
  if it has no JSON content), as an `Option` that is `None` on a 404 when
  the operation declares a 404 response described as "not found".
* **Errors.** Any other response raises `Error[RestError]`, a record of
  the status and the body; a failed connection has the status 0.
* **The client** is `rest.fetch` in `lib/rest.fwp` over `http.send`: one
  connection per call, no TLS.

Schemas outside this subset (`allOf`, a `oneOf` other than fwp's
variants, `not`, enums of numbers) become `Json` values, and operations
whose body is not JSON or that need header or cookie parameters are left
out; each is reported on stderr, as in
`fwp openapi: spec.json: schema \`Session\`: \`allOf\` is not supported; it is a \`Json\` value`.
YAML documents and Swagger 2.0 are not read (convert them to JSON or
OpenAPI 3 first).

The round trip is tested: a client generated from the document a server
serves calls that server, interpreted and natively, and decodes what it
answers (`tests/rest/roundtrip.fwp`).

## How it works

`fwp build --rest` and `fwp serve --rest` compile the file twice. The
first compilation gives the types and comments of the exported functions,
from which `src/rest.rs` computes the endpoints and `src/openapi.rs` the
document. The second compiles the file with a generated `main` added to it:

```
fwp-rest-main =
    rest.main
        "{\n  \"openapi\": \"3.1.0\", ..."
        [
            rest.endpoint-option (RestRoute { method = "GET", path = "/books/{id}", sources = [RestSource.Path "id"], ... }) book,
            rest.endpoint (RestRoute { ... }) books,
            ...
        ]
```

`rest.endpoint` (`lib/rest.fwp`) makes a route of `http.router`: it
gathers the arguments as JSON text (path and query values as strings, the
body as it is), decodes them with `json.read` at the type of the function's
parameters (a tuple for several), calls the function under `attempt`, and
writes the result or the error with `json.write`. The typed codec is a
primitive implemented twice, in Rust (`src/jsontype.rs`) and in C over the
type descriptors (`runtime/fwp_rt_json.c`), which carry the declaration
order, the JSON names and flags for `Bool`, `Option`, `Json` and
`Duration`. Everything else is fwp code, so both backends serve the same
endpoints byte for byte.

## Limitations

* JSON only: no content negotiation, forms, multipart bodies, headers or
  cookies as parameters, and no streaming responses.
* No authentication, CORS or TLS; put the server behind a proxy, or write
  a server by hand with `rest.endpoint` and the middleware of
  `lib/http.fwp`.
* The status of a success is fixed per endpoint, and a function cannot set
  response headers.
* Constructor names are JSON names: enums with values that are not fwp
  constructor names import as `String`.
* `I64` values beyond 2^53 are exact in fwp's JSON, but JavaScript clients
  lose digits; query parameters in generated clients go through `Json`
  values (doubles).
* Native servers allocate from a bump heap that is never freed (see
  [design.md](design.md)), like every native fwp program.
