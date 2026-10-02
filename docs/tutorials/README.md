# Tutorials

Each tutorial is a directory with a `README.md` that explains it and a
complete program, `main.fwp`, whose output is in `main.out`. The test suite
runs every program in the interpreter and as a native executable, and
checks the code shown in each README against the program.

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
| 16 | [Command-line programs](16-clis/README.md) | flags from records, `--help`, `fwp build --cli`, exit statuses, the `cli` module |
| 17 | [REST APIs and OpenAPI](17-rest-and-openapi/README.md) | functions as endpoints, `fwp serve --rest`, the JSON codec, OpenAPI documents and generated clients |
| 18 | [gRPC](18-grpc/README.md) | functions as gRPC methods, `fwp serve --grpc`, streams from types, statuses, deadlines and metadata, `fwp proto --import` |
| 19 | [TLS](19-tls/README.md) | HTTPS and gRPC over TLS: certificates, `--tls-cert`, verifying clients, `lib/tls.fwp` |

Start with the first, which introduces the notation the others rely on.
After that, the tutorials stand alone. The [language
reference](../reference.md) collects the details.
