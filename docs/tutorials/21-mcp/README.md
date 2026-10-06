# 21. MCP tools

This tutorial makes ordinary functions the tools of a Model Context
Protocol server, which AI applications (Claude and other MCP clients)
call. The server speaks the stateless protocol of the 2026-07-28
specification: no session, no `initialize` handshake, every request on
its own. It talks over standard input and output, or over HTTP. The tools'
input and output schemas come from the functions' types, and their
descriptions from the comments. [docs/mcp.md](../../mcp.md) has every rule.

To follow along, go to this directory (`cd docs/tutorials/21-mcp`). The
sessions below run exactly as shown: the test suite runs them. They use
`jq` to show the JSON.

## Functions are tools

[`converter.fwp`](converter.fwp) converts temperatures and splits bills:
arithmetic that a model should not do in its head. An exported function
is a tool only when it is exposed as `mcp`; the file's leading comment
exposes all of them, and is the server's instructions:

```fwp
# Exact conversions and sums, for a model that should not do arithmetic
# in its head.
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
  "instructions": "Exact conversions and sums, for a model that should not do arithmetic\nin its head.",
  "resultType": "complete"
}
```

`tools/list` lists the tools, with their JSON Schemas. A tool without
effects (no `IO`, `Network`, ...) is marked as only reading, so a client
can call it without asking:

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
{"content":[{"type":"text","text":"212"}],"structuredContent":{"result":212},"isError":false,"resultType":"complete"}
{"content":[{"type":"text","text":"[333,333,334]"}],"structuredContent":{"result":[333,333,334]},"isError":false,"resultType":"complete"}
{"content":[{"type":"text","text":"there must be at least one person"}],"isError":true,"resultType":"complete"}
{"content":[{"type":"text","text":"invalid arguments: $.value: expected a number, got \"hot\""}],"isError":true,"resultType":"complete"}
```

A client of an earlier, stateful version of the protocol starts with
`initialize`; the server answers that it supports 2026-07-28 only:

```console
$ echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18"}}' | ./converter | jq -c .error
{"code":-32022,"message":"unsupported protocol version","data":{"supported":["2026-07-28"],"requested":"2025-06-18"}}
```

## Adding it to a client

A client runs the executable itself. For Claude Code:

```sh
claude mcp add converter -- /path/to/converter
```

Other clients take the command in their configuration, as in
`{"mcpServers": {"converter": {"command": "/path/to/converter"}}}`. The
server's stdout carries only protocol messages; it logs on stderr.

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
333
333
334
```

## The program

[`converter.fwp`](converter.fwp):

```fwp
# Exact conversions and sums, for a model that should not do arithmetic
# in its head.
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
split-bill = curry (if
    (.1 | le 0)
    (const "there must be at least one person" | fail)
    shares)

Split = { base: I64, extra: I64 }

shares : (I64, I64) -> List[I64]
shares =
    fork
        map
        (make Split { base = swap | uncurry div, extra = swap | uncurry rem }
            | share)
        (.1 | range 0)

share : Split -> I64 -> I64
share = curry (if (fork lt .1 (.0 | .extra)) (.0 | .base | add 1) (.0 | .base))
```

---

Previous: [Reverse-mode autodiff and devices](../20-autodiff-and-devices/README.md) · [All tutorials](../README.md)
