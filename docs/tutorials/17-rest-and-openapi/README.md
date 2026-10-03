# 17. REST APIs and OpenAPI

[Tutorial 16](../16-clis/README.md) made exported functions command-line
programs. The same functions are REST endpoints: `fwp serve --rest`
serves each one over HTTP with a JSON contract derived from its type, and
publishes the OpenAPI document of the API. In the other direction,
`fwp openapi --import` turns an OpenAPI document into typed fwp functions
that call the API. [docs/rest.md](../../rest.md) has every rule.

## Functions are endpoints

The program quotes shipping rates. Its types are ordinary records and
variants:

```fwp
Parcel = { weight: F64, size: Size, to: String }
```

```fwp
Rate = { carrier: String, price: F64, days: I64 }
```

Each exported function is an endpoint. Without a comment it would be
`POST /carrier` with the name as its JSON body; a line `# route:` gives
it a method and a path, whose `{name}` segment is the parameter:

```fwp
# A carrier by its name.
# route: GET /carriers/{name}
export carrier : String -> Option[Carrier]
```

```
$ fwp serve --rest main.fwp
fwp: rest listening on http://127.0.0.1:8080
$ curl localhost:8080/carriers/swift
{"name":"swift","base":9.0,"per-kg":2.0,"days":1,"countries":["FR","DE"]}
$ curl -i localhost:8080/carriers/zippy
HTTP/1.1 404 Not Found
...
{"error":"not found"}
```

The result is written as JSON (records are objects, enums strings), and
`None` is a 404. `fwp build main.fwp --rest -o shipping` builds the same
server as a native executable.

## Query parameters and the body

A record first parameter is the options record, as on a command line:
its fields are query parameters (a `Bool` is a switch, an `Option` may be
absent). The last parameter is the JSON body. The function's `Error` is
an error response, with a status for each variant:

```fwp
Options = {
    # only carriers that deliver within two days
    express: Bool,
    # at most this many days
    max-days: Option[I64],
}
```

```fwp
# The rates for a parcel, cheapest first.
# route: POST /rates
# error: TooHeavy 422, NoRoute 404
export rates : Options -> Parcel -> List[Rate] ! {Error[Problem]}
```

```
$ curl -d '{"weight": 2, "size": "Medium", "to": "FR"}' 'localhost:8080/rates?express'
[{"carrier":"swift","price":15.0,"days":1}]
$ curl -d '{"weight": 40, "size": "Small", "to": "FR"}' localhost:8080/rates
{"error":{"type":"TooHeavy","value":40.0}}          (status 422)
$ curl -d '{"weight": 2, "size": "Tiny", "to": "FR"}' localhost:8080/rates
{"error":"$.size: expected one of \"Small\", \"Medium\", \"Large\", got \"Tiny\""}   (status 400)
```

Arguments that do not decode are a 400 whose message says where the
problem is: `$.size` in the body, `query.max-days` or `path.name`.

## The JSON codec

The server reads and writes JSON with two functions of the standard
library, which work for any type that has an `Encode` or `Decode`
instance: `json.write` and `json.read`. A program can use them directly:

```fwp
read-parcel : String -> Result[Parcel, String]
read-parcel = json.read
```

Integers are written exactly, `Option` fields that are `None` are left
out, variants with fields are `{"type": ..., "value": ...}`, and a field
comment `# json: name` gives a field another JSON name.

## The OpenAPI document

`fwp openapi main.fwp` prints the OpenAPI 3.1 document, which the server
also serves at `/openapi.json`. The paths come from the routes, the
schemas from the types, the descriptions from the comments:

```
$ fwp openapi main.fwp
{
  "openapi": "3.1.0",
  "info": {
    "title": "main",
    "version": "1.0.0",
    ...
  "paths": {
    "/carriers/{name}": {
      "get": {
        "operationId": "carrier",
        "summary": "A carrier by its name.",
        ...
      "Problem": {
        "oneOf": [
          {
            "$ref": "#/components/schemas/Problem.TooHeavy"
          },
        ...
```

## Calling an API

`fwp openapi --import` reads an OpenAPI document, this one or any other,
and writes a module with its types and a function per operation. Each
function takes the server's base URL first:

```
$ fwp openapi main.fwp > shipping.json
$ fwp openapi --import shipping.json -o shipping.fwp
$ grep -A1 '^# GET' shipping.fwp
# GET /carriers/{name}
carrier : String -> String -> Option[Carrier] ! {Async, Network, Error[RestError]}
```

A program then does `import shipping` and calls
`"swift" | shipping.carrier "http://127.0.0.1:8080"`; a response that is
not a success raises `Error[RestError]` with its status and body.

## Under the hood

`fwp serve --rest` adds a `main` to the file that serves a router of
`rest.endpoint`s: each one decodes a request's arguments, calls the
function and encodes its result. The program builds the same router to
call the endpoints in-process, without a socket:

```fwp
# The endpoints as `fwp serve --rest` builds them, called in-process.
api : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
```

## The program

[`main.fwp`](main.fwp):

```fwp
# 17. REST APIs and OpenAPI
#
# Exported functions are REST endpoints: `fwp serve --rest` serves them
# with JSON bodies, and their OpenAPI document is derived from their types.

export version : String
version = "1.0.0"

Size =
    | Small
    | Medium
    | Large

Parcel = { weight: F64, size: Size, to: String }

Carrier = {
    name: String,
    base: F64,
    per-kg: F64,
    days: I64,
    countries: List[String],
}

Rate = { carrier: String, price: F64, days: I64 }

Options = {
    # only carriers that deliver within two days
    express: Bool,
    # at most this many days
    max-days: Option[I64],
}

# why a parcel cannot be shipped
Problem =
    | TooHeavy F64
    | NoRoute String

carriers : List[Carrier]
carriers = [
    Carrier {
        name = "swift",
        base = 9.0,
        per-kg = 2.0,
        days = 1,
        countries = ["FR", "DE"],
    },
    Carrier {
        name = "steady",
        base = 4.0,
        per-kg = 1.0,
        days = 4,
        countries = ["FR", "DE", "IT"],
    },
]

# A carrier by its name.
# route: GET /carriers/{name}
export carrier : String -> Option[Carrier]
carrier = eq | compose .name | find | apply carriers

# The rates for a parcel, cheapest first.
# route: POST /rates
# error: TooHeavy 422, NoRoute 404
export rates : Options -> Parcel -> List[Rate] ! {Error[Problem]}
rates = curry (tap (.1 | check-weight) | fork offers .0 (.1 | routes))

check-weight : Parcel -> () ! {Error[Problem]}
check-weight = if (.weight | gt 30.0) (.weight | TooHeavy | fail) (const ())

serving : String -> List[Carrier]
serving = contains | compose .countries | filter | apply carriers

routes : Parcel -> List[Rate] ! {Error[Problem]}
routes =
    if
        (.to | serving | is-empty)
        (.to | NoRoute | fail)
        (fork map rate (.to | serving))

factor : Size -> F64
factor = match
    Small -> 1.0
    Medium -> 1.5
    Large -> 2.5

rate : Parcel -> Carrier -> Rate
rate = curry (make Rate {
    carrier = .1 | .name,
    price =
        fork
            add
            (.1 | .base)
            (fork mul (.1 | .per-kg) (.0 | fork mul .weight (.size | factor))),
    days = .1 | .days,
})

offers : Options -> List[Rate] -> List[Rate]
offers = curry (fork filter (.0 | keep) .1 | sort-by .price)

keep : Options -> Rate -> Bool
keep = curry (fork
    and
    (if (.0 | .express) (.1 | .days | le 2) (const True))
    (fork within (.0 | .max-days) (.1 | .days)))

within : Option[I64] -> I64 -> Bool
within = curry (match
    (None, _) -> const True
    (Some _, _) -> le)

parcel : Parcel
parcel = Parcel { weight = 2.0, size = Medium, to = "FR" }

anything : Options
anything = Options { express = False, max-days = None }

read-parcel : String -> Result[Parcel, String]
read-parcel = json.read

# The endpoints as `fwp serve --rest` builds them, called in-process.
api : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
api = http.router [
    rest.endpoint-option
        RestRoute {
            method = "GET",
            path = "/carriers/{name}",
            sources = [RestSource.Path "name"],
            status = 200,
            error-status = 500,
            errors = [],
        }
        carrier,
    rest.endpoint
        RestRoute {
            method = "POST",
            path = "/rates",
            sources = [
                RestSource.Fields [("express", 3), ("max-days", 1)],
                RestSource.Body False,
            ],
            status = 200,
            error-status = 500,
            errors = [("TooHeavy", 422), ("NoRoute", 404)],
        }
        (uncurry rates),
]

request : (String, String, String, String) -> Request
request = make Request {
    method = .0,
    path = .1,
    query = .2,
    version = const "HTTP/1.1",
    headers = const [],
    body = .3 | string.to-bytes,
    params = const [],
    remote = const "test",
}

body-text : Body -> String
body-text = match
    Body.Full _ -> string.from-bytes | option.unwrap-or ""
    _ -> const ""

call : (String, String, String, String) -> () ! {Async, IO, Network, FileIO}
call =
    request
    | attempt api
    | rest.respond
    | both .status (.body | body-text)
    | format "{} {}"
    | print

main = [
    "swift" | carrier | echo,
    parcel | attempt (rates anything) | echo,
    parcel | rates anything | json.write | print,
    TooHeavy 40.0 | json.write | print,
    "{\"weight\": 2, \"size\": \"Medium\", \"to\": \"IT\"}" | read-parcel | echo,
    "{\"weight\": 2, \"size\": \"Tiny\", \"to\": \"IT\"}" | read-parcel | echo,
    ("GET", "/carriers/swift", "", "") | call,
    ("GET", "/carriers/zippy", "", "") | call,
    (
        "POST",
        "/rates",
        "express",
        "{\"weight\": 1, \"size\": \"Small\", \"to\": \"DE\"}",
    ) | call,
    (
        "POST",
        "/rates",
        "max-days=x",
        "{\"weight\": 1, \"size\": \"Small\", \"to\": \"DE\"}",
    ) | call,
    (
        "POST",
        "/rates",
        "",
        "{\"weight\": 40, \"size\": \"Small\", \"to\": \"DE\"}",
    ) | call,
    (
        "POST",
        "/rates",
        "",
        "{\"weight\": 1, \"size\": \"Small\", \"to\": \"JP\"}",
    ) | call,
] | ignore
```

Run it with `fwp run docs/tutorials/17-rest-and-openapi/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/17-rest-and-openapi/main.fwp -o
rest`. The output is [`main.out`](main.out):

```
Some (Carrier {base = 9.0, countries = ["FR", "DE"], days = 1, name = "swift", per-kg = 2.0})
Ok [Rate {carrier = "steady", days = 4, price = 7.0}, Rate {carrier = "swift", days = 1, price = 15.0}]
[{"carrier":"steady","price":7.0,"days":4},{"carrier":"swift","price":15.0,"days":1}]
{"type":"TooHeavy","value":40.0}
Ok (Parcel {size = Medium, to = "IT", weight = 2.0})
Err "$.size: expected one of \"Small\", \"Medium\", \"Large\", got \"Tiny\""
200 {"name":"swift","base":9.0,"per-kg":2.0,"days":1,"countries":["FR","DE"]}
404 {"error":"not found"}
200 [{"carrier":"swift","price":11.0,"days":1}]
400 {"error":"query.max-days: expected an integer, got \"x\""}
422 {"error":{"type":"TooHeavy","value":40.0}}
404 {"error":{"type":"NoRoute","value":"JP"}}
```

`main` calls the functions and the endpoints in-process, which is how the
output is checked; the shell sessions above show them served over HTTP.

---

Previous: [Command-line programs](../16-clis/README.md) · Next: [gRPC](../18-grpc/README.md) · [All tutorials](../README.md)
