# Learn fwp

Start with a working compiler from the [project README](../../README.md). Lessons
1–5 teach the notation used by every later example: functions and pipes, records
and variants, types, effects, then collections. After those, choose an application
path below. Each lesson states any extra prerequisites; they are not independent
of the basics.

| Goal | Read after lessons 1–5 |
|---|---|
| Terminal tools | 7, then 16 |
| Tasks and servers | 6, 8, then 17–19 |
| C integration | 9 |
| Browser programs | 10, then 15 |
| Generated code and editor tooling | 11, 13 |
| Numerical calculations and derivatives | 12, then 20 |
| Split a program into services | 6–8, then 14 and optionally 18 |
| Recursion and memory use | 22–24 for recursion, ownership, graphs and subscriptions |
| Expose functions as tools | 21; 8 for its HTTP transport |

## Running the examples

A language lesson has a complete `main.fwp` and expected `main.out`. Commands
whose paths begin `docs/` run from the repository root. A terminal-session lesson
tells you to enter its directory first. Copy commands without the `$` shell prompt
or `>` continuation prompt. Lines without a prompt show expected output.

`fwp run` compiles and caches native code; `--interp` selects interpretation.
Native compilation needs the toolchain in the project README. Networking lessons
need OpenSSL 3, and name additional tools such as `curl`, `jq` or `openssl` when
used. WebAssembly lessons have separate target/host requirements. Shell sessions
use POSIX shell conventions; Windows native support does not mean those shell
commands are PowerShell syntax.

In a shell, `|` connects process output to input, `>` writes a file, and `<` reads
one. These are shell operations, separate from fwp's `|` for applying/composing
functions. Quoting keeps spaces or symbols inside one shell argument. Background
servers are started with `&`; stop them after the session as shown.

The tests compare each program's interpreter/native output, replay the terminal
sessions, and check that README source copies match the actual files. A transcript
is an expected test result, not a benchmark. The larger [example applications](../../examples/README.md)
have their own guide; their general test gate checks types, which alone does not
prove every external deployment works.

## Lessons

| # | Tutorial | Covers |
|---|---|---|
| 1 | [Pipes and functions](01-pipes-and-functions/README.md) | `\|` pipes, currying, data-last arguments, combinators |
| 2 | [Data: records, tuples and variants](02-data/README.md) | records, tuples, variants, `match`, `make`/`update`/`with` |
| 3 | [Types and traits](03-types-and-traits/README.md) | signatures, type variables, traits and impls, literals |
| 4 | [Effects](04-effects/README.md) | effect types, `fail`/`attempt`, `run-state` |
| 5 | [Collections and strings](05-collections/README.md) | lists, maps, strings, lazy iterators |
| 6 | [Tasks and channels](06-tasks-and-channels/README.md) | tasks, channels, `loop`, deadlines |
| 7 | [Functions as executables](07-executables-and-pipes/README.md) | `export`, `fwp exec`, `fwp build --fn`, typed pipes |
| 8 | [An HTTP server](08-http-server/README.md) | handlers, routing, middleware, the HTTP client |
| 9 | [Calling C](09-c-interop/README.md) | `foreign "C"`, structs, pointers, callbacks, C libraries |
| 10 | [WebAssembly](10-webassembly/README.md) | WASI and browser targets |
| 11 | [Compile-time code and macros](11-comptime-and-macros/README.md) | `comptime`, `type[T]`, `quote`, macros |
| 12 | [Numerics](12-numerics/README.md) | matrices, complex numbers, automatic differentiation |
| 13 | [Tooling](13-tooling/README.md) | `fwp fmt`, `fwp lint`, the language server |
| 14 | [Services](14-services/README.md) | one program as one executable or as gRPC services |
| 15 | [fwp in the browser](15-browser/README.md) | `wasm32-browser`, fwp itself as WebAssembly, the playground |
| 16 | [Command-line programs](16-clis/README.md) | `# expose: cli`, `fwp build --cli`, flags from records, `--help`, exit statuses, completion, the `cli` module |
| 17 | [REST APIs and OpenAPI](17-rest-and-openapi/README.md) | `# expose: rest`, `fwp build --rest`, calls with `curl`, OpenAPI documents, a generated fwp client |
| 18 | [TLS](18-tls/README.md) | HTTPS and services over TLS: certificates, `--tls-cert`, verifying clients, `lib/tls.fwp` |
| 19 | [WebSockets and HTTP/2](19-websockets-and-http2/README.md) | HTTP/2 servers and clients (h2c, ALPN), compressed responses, WebSocket sessions with `http.websocket` and `ws.connect` |
| 20 | [Reverse-mode autodiff and devices](20-autodiff-and-devices/README.md) | `grad` and `vjp` on tapes, tensor expressions as fused kernels, `Cpu` and `CpuParallel` execution |
| 21 | [MCP tools](21-mcp/README.md) | `# expose: mcp`, `fwp build --mcp`, a stateless MCP server over stdio and HTTP, schemas from types |
| 22 | [Recursion, loops and shared values](22-recursion-and-sharing/README.md) | Tail calls, bounded iteration and immutable sharing |
| 23 | [Ownership scopes](23-ownership-scopes/README.md) | Scoped callbacks, workers, cancellation and graph IDs/deletion |
| 24 | [Subscriptions](24-subscriptions/README.md) | Streaming callbacks, explicit finish/stop, active cancellation and reentry |

Use the [reference](../reference.md) to look up exact syntax and the
[glossary](../glossary.md) for terminology. Lessons introduce concepts before
using them; those links supplement the explanation.
