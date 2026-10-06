# MCP servers

Exported functions exposed as `mcp` are the tools of a Model Context
Protocol server, which AI applications such as Claude call. The server
speaks the stateless protocol of the
[2026-07-28 specification](https://modelcontextprotocol.io/specification/2026-07-28):
there is no session and no `initialize` handshake, and every request
stands alone. [Tutorial 21](tutorials/21-mcp/README.md) builds one step
by step.

```fwp
# Exact conversions and sums, for a model that should not do arithmetic
# in its head.
#
# expose: mcp

# Split a bill of CENTS between PEOPLE: equal shares in cents, the first
# ones a cent more when it does not divide evenly.
# args: cents people
export split-bill : I64 -> I64 -> List[I64] ! {Error[String]}
```

```
$ fwp build converter.fwp --mcp -o converter    # a native server
$ fwp serve --mcp converter.fwp                 # the same, without a build step
$ claude mcp add converter -- /path/to/converter
```

## Commands

| Command | |
|---|---|
| `fwp build file.fwp --mcp [-o out]` | a native executable serving the tools |
| `fwp serve --mcp file.fwp [--interp] [--listen host:port]` | serve them (compiled and cached, or interpreted) |

The server reads one JSON-RPC message per line on standard input and
writes one response per line on standard output, until its input ends
(the stdio transport); it logs on stderr only. With `--listen
host:port`, it serves HTTP instead (below). `--help` shows its options.

## Tools

Every exported function exposed as `mcp` (a line `# expose: mcp` above
it, or in the file's leading comment) is a tool, named as the function
(`split-bill`). Functions of no parameters (constants), `version` and
`defaults` are not tools.

* The comment block above the `export` is the tool's `description`.
* The arguments are a JSON object. A function of one record parameter (or
  of `()`) takes the record's fields; other functions take one member per
  parameter, named by `# args:` (`input` for one parameter without it,
  `arg1`, `arg2`, ... for several). Field comments are the members'
  descriptions.
* The `inputSchema` and `outputSchema` are JSON Schemas of the types, as
  in [OpenAPI documents](rest.md): records are objects, enums strings,
  variants `{"type": ..., "value": ...}`, named types under `$defs`.
* The result is the function's value as JSON (see [the JSON
  codec](rest.md)): as text content (a string as it is) and as
  `structuredContent`, which is `{"result": value}` unless the value is
  an object.
* An `Error` effect, or an `Err` of a `Result`, is a result with `isError:
  true` and the error as text, as are arguments that do not decode (`invalid
  arguments: cents: expected an integer, got "x"`): the model sees what went
  wrong and can call again.
* A function without effects (no `IO`, `FileIO`, `Network`, `Async`) has
  the annotations `readOnlyHint`, `idempotentHint` and not
  `openWorldHint`, so clients may call it without asking.
* Types that JSON cannot carry (functions, `Iterator`, `Channel`) cannot
  be tools.

## Protocol

| Method | Answer |
|---|---|
| `server/discover` | `supportedVersions` (`["2026-07-28"]`), `capabilities` (`tools`), `serverInfo` (the file's name and `export version`), `instructions` (the file's leading comment) |
| `tools/list` | every tool, with `ttlMs` (an hour) and `cacheScope: "public"`: the list does not change while the server runs |
| `tools/call` | the tool's result |
| `ping` | an empty result |

* Every result has `resultType: "complete"`.
* Each request names its protocol version in
  `params._meta["io.modelcontextprotocol/protocolVersion"]`. A request
  without it is an invalid-params error (-32602), except
  `server/discover`. A version other than 2026-07-28 is the error -32022,
  whose `data` lists the supported versions; so is `initialize`, from a
  client of an earlier, stateful version.
* Notifications (messages without `id`) get no answer.
* Errors:
  * -32700: a line that is not JSON;
  * -32600: a message that is not a request;
  * -32601: an unknown method;
  * -32602: an unknown tool.

## HTTP

With `--listen`, the server is a Streamable HTTP endpoint at
`http://host:port/mcp`:

* each request is a `POST` with one JSON-RPC message, and the response
  is one JSON object (`application/json`);
* a notification is answered `202 Accepted`;
* other methods are `405`, other paths `404`.

The headers `MCP-Protocol-Version`, `Mcp-Method` and, for `tools/call`,
`Mcp-Name` must match the body's `_meta` version, method and tool name.
They let proxies route requests without reading them. A request whose
headers do not match is a `400` with the error -32020.

A request with an `Origin` header (from a web page) is refused (`403`)
unless the origin is `localhost`, `127.0.0.1` or `[::1]`. This guards
against DNS rebinding. The server has no authentication: listen on a
local address, or put it behind a proxy that authenticates.

## Under the hood

Like `--rest`, `--mcp` adds a generated `main` to the program, which
calls `mcp.serve` (`lib/mcp.fwp`) with one `mcp.tool` per function. The
tool decodes the arguments with `json.decode`, calls the function, and
encodes its result with `json.encode-value`. The protocol itself is fwp
code too: `mcp.handle` answers one message, `mcp.serve-stdio` and
`mcp.serve-http` are the transports. A program can serve tools of its
own making with them.
