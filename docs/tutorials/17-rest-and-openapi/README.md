# 17. REST APIs and OpenAPI

This tutorial serves ordinary functions as a REST API, calls it with
`curl`, publishes its OpenAPI document, and calls it from another fwp
program through a client generated from that document. Each endpoint's
JSON contract comes from the function's type. [docs/rest.md](../../rest.md)
has every rule.

To follow along, go to this directory (`cd docs/tutorials/17-rest-and-openapi`).
The sessions below run exactly as shown: the test suite runs them.

## Functions are endpoints

[`shipping.fwp`](shipping.fwp) quotes shipping rates. Its types are
ordinary records and variants:

```fwp
Parcel = { weight: F64, size: Size, to: String }
```

```fwp
Rate = { carrier: String, price: F64, days: I64 }
```

An exported function becomes an endpoint only when it is exposed as
`rest`. The file's leading comment exposes all of them:

```fwp
# Shipping rates: the carriers, and what they charge for a parcel.
#
# expose: rest
```

Without other comments an endpoint is `POST /carrier`, with the argument
as its JSON body; a line `# route:` gives it a method and a path, whose
`{name}` segment is the parameter:

```fwp
# A carrier by its name.
# route: GET /carriers/{name}
export carrier : String -> Option[Carrier]
```

`fwp build --rest` builds the server as a native executable, which takes
`--listen`. Start it in the background:

```console
$ fwp build shipping.fwp --rest -o shipping
$ ./shipping --listen 127.0.0.1:8717 &
fwp: rest listening on http://127.0.0.1:8717
```

(`fwp serve --rest shipping.fwp` runs the same server without a separate
build step, which is handy while you write it.) Now call it. The result
is written as JSON (records are objects, enums strings), and `None` is a
404:

```console
$ curl -s -w '\n' localhost:8717/carriers/swift
{"name":"swift","base":9.0,"per-kg":2.0,"days":1,"countries":["FR","DE"]}
$ curl -s -w ' %{http_code}\n' localhost:8717/carriers/zippy
{"error":"not found"} 404
```

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

```console
$ curl -s -w '\n' -d '{"weight": 2, "size": "Medium", "to": "FR"}' localhost:8717/rates
[{"carrier":"steady","price":7.0,"days":4},{"carrier":"swift","price":15.0,"days":1}]
$ curl -s -w '\n' -d '{"weight": 2, "size": "Medium", "to": "FR"}' 'localhost:8717/rates?express'
[{"carrier":"swift","price":15.0,"days":1}]
$ curl -s -w ' %{http_code}\n' -d '{"weight": 40, "size": "Small", "to": "FR"}' localhost:8717/rates
{"error":{"type":"TooHeavy","value":40.0}} 422
$ curl -s -w ' %{http_code}\n' -d '{"weight": 1, "size": "Small", "to": "JP"}' localhost:8717/rates
{"error":{"type":"NoRoute","value":"JP"}} 404
```

Arguments that do not decode are a 400 whose message says where the
problem is: `$.size` in the body, `query.max-days` or `path.name`:

```console
$ curl -s -w ' %{http_code}\n' -d '{"weight": 2, "size": "Tiny", "to": "FR"}' localhost:8717/rates
{"error":"$.size: expected one of \"Small\", \"Medium\", \"Large\", got \"Tiny\""} 400
$ curl -s -w ' %{http_code}\n' -d '{"weight": 2, "size": "Small", "to": "FR"}' 'localhost:8717/rates?max-days=soon'
{"error":"query.max-days: expected an integer, got \"soon\""} 400
```

The server reads and writes JSON with `json.read` and `json.write`, which
a program can call on any type: integers are written exactly, `Option`
fields that are `None` are left out, variants with fields are `{"type":
..., "value": ...}`, and a field comment `# json: name` gives a field
another JSON name.

## The OpenAPI document

The server serves its OpenAPI 3.1 document at `/openapi.json`, and a page
that shows it at `/docs` (open http://127.0.0.1:8717/docs in a browser).
`fwp openapi` prints the same document without a server. The paths come
from the routes, the schemas from the types, the descriptions from the
comments:

```console
$ fwp openapi shipping.fwp > shipping.json
$ curl -s localhost:8717/openapi.json | cmp - shipping.json && echo same
same
$ head -12 shipping.json
{
  "openapi": "3.1.0",
  "info": {
    "title": "shipping",
    "version": "1.0.0",
    "description": "Shipping rates: the carriers, and what they charge for a parcel."
  },
  "paths": {
    "/carriers/{name}": {
      "get": {
        "operationId": "carrier",
        "summary": "A carrier by its name.",
```

## Calling it from fwp

`fwp openapi --import` reads an OpenAPI document, this one or any other
service's, and writes an fwp module with its types and one function per
operation. Each function takes the server's base URL first:

```console
$ fwp openapi --import shipping.json -o api.fwp
$ grep -A1 '^# GET' api.fwp
# GET /carriers/{name}
carrier : String -> String -> Option[Carrier] ! {Async, Network, Error[RestError]}
```

[`client.fwp`](client.fwp) imports it and calls the API; a response that
is not a success raises `Error[RestError]`, with its status and body:

```fwp
# Ask the shipping API for rates through `api.fwp`, the module that
# `fwp openapi --import` generates from its OpenAPI document.

import api

parcel : api.Parcel
parcel = api.Parcel { weight = 2.0, size = api.Medium, to = "FR" }

express : api.RatesQuery
express = api.RatesQuery { express = Some True, max-days = None }

calls : String -> () ! {Async, IO, Network, Error[RestError]}
calls =
    tap (fork api.carrier id (const "steady") | option.map .countries | echo)
    | fork apply (const parcel) (fork api.rates id (const express))
    | json.write
    | print

main =
    ()
    | args
    | head
    | option.unwrap-or "http://127.0.0.1:8717"
    | attempt calls
    | match
        Ok _ -> id
        Err _ -> .message | eprint | const 1 | exit
```

```console
$ fwp run client.fwp
Some ["FR", "DE", "IT"]
[{"carrier":"swift","price":15.0,"days":1}]
```

## The same functions elsewhere

Nothing in the functions is about HTTP. Add `cli` to the `# expose:` line
and `fwp build shipping.fwp --cli` makes the same functions a
command-line program ([tutorial 16](../16-clis/README.md)); add `mcp` for
tools that a language model can call ([tutorial 21](../21-mcp/README.md)).

## The program

[`shipping.fwp`](shipping.fwp):

```fwp
# Shipping rates: the carriers, and what they charge for a parcel.
#
# expose: rest

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
```

---

Previous: [Command-line programs](../16-clis/README.md) · Next: [TLS](../18-tls/README.md) · [All tutorials](../README.md)
