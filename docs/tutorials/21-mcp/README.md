# 21. MCP tools

Read lessons 1–4 first, plus lesson 8 for the HTTP transport. A tool server
lets another application discover named operations and call them with structured
arguments. Model Context Protocol (MCP) defines those requests. JSON-RPC messages
have a method name, parameters and an ID that matches a reply to its request.
A schema describes valid arguments/results; annotations provide hints about a
tool, not permission to run it.

This repository implements the `2026-07-28` protocol version shown in the tested
messages below. A client must support that version and stateless operation;
being described as an MCP client is not sufficient to establish compatibility.
`jq` formats/selects JSON in the terminal. `<<'EOF'` supplies the following lines
as input until the closing `EOF`; the `>` marks in the transcript are prompts.

This tutorial makes ordinary functions the tools of a Model Context
Protocol server, which compatible client applications
call. The server implements the stateless `2026-07-28` protocol version: no session, no `initialize` handshake, every request on
its own. It talks over standard input and output, or over HTTP. The tools'
input and output schemas come from the functions' types, and their
descriptions from the comments. [docs/mcp.md](../../mcp.md) has every rule.

To follow along, go to this directory (`cd docs/tutorials/21-mcp`). The
sessions below run exactly as shown: the test suite runs them. They use
`jq` to show the JSON.

## Reading the example

`convert` first converts the input to Celsius, then to the requested output
unit. `fork` supplies the target unit and intermediate value to `from-celsius`.
These are F64 calculations and can round.

`split-bill` validates the person count, computes integer quotient and remainder,
then maps `share` over zero-based person indices. For nonnegative cents, the first
`remainder` people receive one extra cent. `fork lt (.0 | .extra) .1` passes the
extra-count first and the index last, testing `index < extra`. All shares therefore
sum to the original amount. The code is a small example, not a full payment system.

## Functions are tools

[`converter.fwp`](converter.fwp) converts temperatures and splits bills:
arithmetic that a model should not do in its head. An exported function
is a tool only when it is exposed as `mcp`; the file's leading comment
exposes all of them, and is the server's instructions:

```fwp
# Temperature conversions and integer-cent bill splits.
# Floating-point conversions can round.
#
# expose: mcp
```

A tool's arguments are a JSON object. A function of one record takes the
record's fields, with the field comments as their descriptions:

```fwp
Reading = {
    # the temperature to convert
    value: F64,
    # its unit
    from: Unit,
    # the unit to convert it to
    to: Unit,
}
```

```fwp
# Convert a temperature from one unit to another.
export convert : Reading -> F64
convert = fork from-celsius .to (fork celsius .from .value)
```

A function of several parameters takes one argument per parameter,
named by `# args:`. Its `Error` is a result with `isError`, which the
model sees and can act on:

```fwp
# Split a bill of CENTS between PEOPLE: equal shares in cents, the first
# ones a cent more when it does not divide evenly.
# args: cents people
export split-bill : I64 -> I64 -> List[I64] ! {Error[String]}
```

## Over standard input and output

`fwp build --mcp` builds the server, a native executable (`fwp serve
--mcp converter.fwp` runs the same server without a build step). An MCP
client starts it and writes one JSON-RPC request per line; the server
writes one response per line, and exits at the end of its input. Without
a session, a request names the protocol version in its `_meta`, except
`server/discover`, which tells a client what the server is:

```console
$ fwp build converter.fwp --mcp -o converter
$ echo '{"jsonrpc":"2.0","id":1,"method":"server/discover"}' | ./converter | jq .result
{
  "supportedVersions": [
    "2026-07-28"
  ],
  "capabilities": {
    "tools": {}
  },
  "serverInfo": {
    "name": "converter",
    "version": "1.0.0"
  },
  "instructions": "Temperature conversions and integer-cent bill splits.\nFloating-point conversions can round.",
  "resultType": "complete"
}
```

`tools/list` lists the tools, with their JSON Schemas. A tool without
effects (no `IO`, `Network`, ...) receives the read-only and idempotent hints
shown below. Idempotent means repeating it is expected to have the same external
effect. These are behavior hints; the client still decides whether a call needs
permission:

```console
$ ./converter <<'EOF' | jq -c '.result.tools[] | {name, annotations}'
> {"jsonrpc":"2.0","id":2,"method":"tools/list","params":{"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}
> EOF
{"name":"convert","annotations":{"readOnlyHint":true,"idempotentHint":true,"openWorldHint":false}}
{"name":"split-bill","annotations":{"readOnlyHint":true,"idempotentHint":true,"openWorldHint":false}}
$ ./converter <<'EOF' | jq '.result.tools[0].inputSchema'
> {"jsonrpc":"2.0","id":2,"method":"tools/list","params":{"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}
> EOF
{
  "type": "object",
  "properties": {
    "value": {
      "type": "number",
      "format": "double",
      "description": "the temperature to convert"
    },
    "from": {
      "$ref": "#/$defs/Unit",
      "description": "its unit"
    },
    "to": {
      "$ref": "#/$defs/Unit",
      "description": "the unit to convert it to"
    }
  },
  "required": [
    "value",
    "from",
    "to"
  ],
  "$defs": {
    "Unit": {
      "type": "string",
      "enum": [
        "Celsius",
        "Fahrenheit",
        "Kelvin"
      ]
    }
  }
}
```

`tools/call` calls one. The result is the value as text and as
`structuredContent` (`{"result": ...}` when it is not a JSON object):

```console
$ ./converter <<'EOF' | jq -c .result
> {"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"convert","arguments":{"value":100,"from":"Celsius","to":"Fahrenheit"},"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}
> {"jsonrpc":"2.0","id":4,"method":"tools/call","params":{"name":"split-bill","arguments":{"cents":1000,"people":3},"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}
> {"jsonrpc":"2.0","id":5,"method":"tools/call","params":{"name":"split-bill","arguments":{"cents":1000,"people":0},"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}
> {"jsonrpc":"2.0","id":6,"method":"tools/call","params":{"name":"convert","arguments":{"value":"hot","from":"Celsius","to":"Kelvin"},"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}
> EOF
{"content":[{"type":"text","text":"212.0"}],"structuredContent":{"result":212.0},"isError":false,"resultType":"complete"}
{"content":[{"type":"text","text":"[334,333,333]"}],"structuredContent":{"result":[334,333,333]},"isError":false,"resultType":"complete"}
{"content":[{"type":"text","text":"there must be at least one person"}],"isError":true,"resultType":"complete"}
{"content":[{"type":"text","text":"invalid arguments: $.value: expected a number, got \"hot\""}],"isError":true,"resultType":"complete"}
```

A client of an earlier, stateful version of the protocol starts with
`initialize`; the server answers that it supports 2026-07-28 only:

```console
$ echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18"}}' | ./converter | jq -c .error
{"code":-32022,"message":"unsupported protocol version","data":{"supported":["2026-07-28"],"requested":"2025-06-18"}}
```

For 1001 cents among three people, two shares must get the extra cent. The
base share is integer division (`333`); the remainder (`2`) is the number of
leading shares to increase. `share` checks `index < extra`. The total remains 1001.

```console
$ ./converter <<'EOF' | jq -c .result.structuredContent
> {"jsonrpc":"2.0","id":7,"method":"tools/call","params":{"name":"split-bill","arguments":{"cents":1001,"people":3},"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}
> EOF
{"result":[334,334,333]}
```

Temperature conversions use `F64` and can round. Its JSON output retains the
floating-point spelling `212.0`; no conversion through another numeric type is
used for tool results. Bill amounts here are nonnegative integer cents; this example does not implement currency conversion.

## Adding it to a client

Configure a compatible client to start the built `converter` executable with
no arguments and communicate over its standard input/output. Configuration syntax
belongs to that client; confirm that it supports the version above before using
it. Standard output carries only protocol messages; diagnostics use standard error.
The client decides when a tool may run, regardless of tool annotations.

## Over HTTP

With `--listen`, the same server answers HTTP requests at `/mcp`: one
`POST` per request, answered with one JSON response. The headers
`MCP-Protocol-Version`, `Mcp-Method` and (for `tools/call`) `Mcp-Name`
repeat what the body says, so that proxies can route requests without
reading them; a request whose headers do not match is refused:

```console
$ ./converter --listen 127.0.0.1:8722 &
fwp: mcp listening on http://127.0.0.1:8722/mcp
$ curl -s localhost:8722/mcp \
    -H 'Content-Type: application/json' \
    -H 'MCP-Protocol-Version: 2026-07-28' \
    -H 'Mcp-Method: tools/call' -H 'Mcp-Name: convert' \
    -d '{"jsonrpc":"2.0","id":7,"method":"tools/call","params":{"name":"convert","arguments":{"value":0,"from":"Kelvin","to":"Celsius"},"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}' \
  | jq -c .result.structuredContent
{"result":-273.15}
$ curl -s -w ' %{http_code}\n' localhost:8722/mcp \
    -H 'MCP-Protocol-Version: 2026-07-28' -H 'Mcp-Method: tools/list' \
    -d '{"jsonrpc":"2.0","id":8,"method":"tools/call","params":{"name":"convert","arguments":{},"_meta":{"io.modelcontextprotocol/protocolVersion":"2026-07-28","io.modelcontextprotocol/clientCapabilities":{}}}}'
{"jsonrpc":"2.0","id":null,"error":{"code":-32020,"message":"the `Mcp-Method` header does not match the request"}} 400
```

A request from a web page on another host (an `Origin` header that is not
`localhost`) is refused with a 403, against DNS rebinding.

## The same functions elsewhere

Nothing in the functions is about MCP. With `# expose: mcp, cli, rest`
the same file is also a command-line program
([tutorial 16](../16-clis/README.md)) and a REST API
([tutorial 17](../17-rest-and-openapi/README.md)), and `fwp exec` runs any
exported function, exposed or not:

```console
$ fwp exec converter.fwp split-bill 1000 3
334
333
333
```

## The program

[`converter.fwp`](converter.fwp):

```fwp
# Temperature conversions and integer-cent bill splits.
# Floating-point conversions can round.
#
# expose: mcp

export version : String
version = "1.0.0"

Unit =
    | Celsius
    | Fahrenheit
    | Kelvin

Reading = {
    # the temperature to convert
    value: F64,
    # its unit
    from: Unit,
    # the unit to convert it to
    to: Unit,
}

celsius : Unit -> F64 -> F64
celsius = match
    Celsius -> id
    Fahrenheit -> sub 32.0 | mul 5.0 | div 9.0
    Kelvin -> sub 273.15

from-celsius : Unit -> F64 -> F64
from-celsius = match
    Celsius -> id
    Fahrenheit -> mul 9.0 | div 5.0 | add 32.0
    Kelvin -> add 273.15

# Convert a temperature from one unit to another.
export convert : Reading -> F64
convert = fork from-celsius .to (fork celsius .from .value)

# Split a bill of CENTS between PEOPLE: equal shares in cents, the first
# ones a cent more when it does not divide evenly.
# args: cents people
export split-bill : I64 -> I64 -> List[I64] ! {Error[String]}
split-bill = curry (tap (.1 | le 0 | match
        True -> fail "there must be at least one person"
        False -> ())
    | shares)

Split = { base: I64, extra: I64 }

shares : (I64, I64) -> List[I64]
shares =
    fork
        map
        (make Split { base = swap | uncurry div, extra = swap | uncurry rem }
            | share)
        (.1 | range 0)

share : Split -> I64 -> I64
share = curry (if (fork lt (.0 | .extra) .1) (.0 | .base | add 1) (.0 | .base))
```

---

Previous: [Reverse-mode autodiff and devices](../20-autodiff-and-devices/README.md) · [All tutorials](../README.md)
