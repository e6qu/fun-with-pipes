# fwp ("foop")

Native macOS support is merged. Current development completes runtime ownership,
then numeric layouts and autodiff while preserving simple pipe semantics.
See [PLAN.md](PLAN.md) for the ordered roadmap and
[docs/development-state.md](docs/development-state.md) for the session handoff
and actual validation status.

fwp is a tacit, curried, pipe-oriented programming language. It has static
types, tracked effects, structured concurrency, and two execution engines:
an interpreter and native code through C. It implements the *Pipe Language
Compact Specification*. The five most common words on standard input:

```fwp
main =
    ()
    | read-all
    | words
    | map lower
    | frequencies
    | map.to-list
    | sort-by (.1 | neg)
    | take 5
    | each (format "{}: {}" | print)
```

## Highlights

- **Tacit and data-last.** `x | f` applies, `f | g` composes, and `match`
  passes the `_` holes of a pattern to its arm.
- **Static types.** Inference with records, rows and variants; traits with
  superclasses and higher kinds; numbers that trap on overflow;
  exhaustive matching.
- **Explicit, zero-cost generics.** Only a signature makes a definition
  generic. Every generic is resolved at compile time and specialized for
  each type it is used at, with no boxing and no dictionaries
  ([docs/design.md](docs/design.md#generics)).
- **Tracked effects.** `IO`, `Error[E]`, `State[S]`, `Async`, `Network`
  appear in function types, with handlers and affine resources.
- **Compile time.** `comptime`, syntax as data, hygienic macros, `type[T]`.
- **Numerics.** Sized vectors and matrices, complex numbers, forward and
  reverse-mode autodiff, balanced ternary, SIMD, and fused tensor kernels
  on CPU threads or OpenCL devices ([docs/numerics.md](docs/numerics.md)).
- **Concurrency and the web.** Tasks, channels and deadlines; TCP, UDP and
  DNS; HTTP/1.1 and HTTP/2 servers and clients, WebSocket; JSON, logs and metrics.
- **Many outputs.** An interpreter and native executables with identical
  output; one executable per exported function, joined by a typed pipe
  protocol; WebAssembly; fat binaries; C libraries and C interop.
- **One function, three interfaces.** A line `# expose: cli, rest, mcp`
  makes exported functions command-line programs, REST endpoints or MCP
  tools, with no interface code: the types are the
  contract and the comments the documentation
  ([docs/interfaces.md](docs/interfaces.md)).
- **Command-line programs.** A record parameter becomes flags, doc
  comments become `--help`, and `fwp build --cli` makes one executable
  with a subcommand per function, shell completion and a man page.
- **REST and OpenAPI.** Each endpoint has a typed JSON contract (forms,
  file uploads and text or CSV responses where declared): `fwp build
  --rest` makes one HTTP server, which serves the OpenAPI 3.1 document
  derived from the types, and `fwp openapi --import` turns any API's
  OpenAPI or Swagger document (JSON or YAML) into typed client functions.
- **MCP.** `fwp build --mcp` makes a server of tools for AI applications,
  on the stateless Model Context Protocol (2026-07-28), over stdio or
  HTTP, with JSON Schemas derived from the types.
- **In the browser.** The compiler and interpreter build for WebAssembly;
  a playground page checks, formats and runs programs without a server,
  tasks and channels included where the browser has JavaScript Promise
  Integration (Chrome and Edge 137 and later).
- **HTTP/2 and WebSocket.** The HTTP server speaks HTTP/1.1 and HTTP/2
  (h2 with ALPN, h2c) with the same handlers, compresses responses, and
  upgrades connections to WebSocket sessions, which are pairs of
  channels; the client speaks both versions and WebSocket too.
- **One program, two deployments.** The same source builds into one
  executable or into services, one per module you name, whose calls to
  each other go over gRPC, with streams decided by the types (`Iterator`
  and `Channel`), deadlines, metadata and statuses; the functions do not
  change.

## Quick start

Requirements: Rust (stable) and a C compiler. For TLS (HTTPS, services over
TLS): OpenSSL 3 (`libssl3`; to build native programs that use it, also
`libssl-dev`). Optionally, for WebAssembly: clang with a WASI sysroot
(Debian/Ubuntu: `wasi-libc`, `libclang-rt-18-dev-wasm32`, `lld`) and node.

On macOS, install the Xcode command line tools (`xcode-select --install`).
For TLS, install OpenSSL 3 (`brew install openssl@3`) and set
`FWP_OPENSSL_DIR` to the output of `brew --prefix openssl@3`; it supplies
the headers/libraries for native builds and the interpreter's loader path.
Native macOS is verified on Apple Silicon and Intel by the full CI suites;
see [the handoff](docs/development-state.md) for the exact baseline and checks. Darwin cross targets and native `--static`
linking are unavailable; `--pgo` still requires GCC.

```
cargo build --release
export PATH=$PWD/target/release:$PATH

fwp run examples/hello.fwp
fwp build docs/tutorials/02-data/main.fwp -o data && ./data
fwp build examples/hello.fwp --target wasm32-wasi -o hello.wasm
fwp build examples/hello.fwp --target aarch64-linux -o hello-arm64
```

The last two build for WebAssembly and, cross-compiling, for 64-bit ARM
Linux. More to try:

| Command | What it does |
|---|---|
| `fwp run examples/server/api.fwp` | a JSON API on 127.0.0.1:8080 |
| `fwp run examples/server/chat.fwp` | a WebSocket chat on 127.0.0.1:8080 |
| `fwp build examples/services/main.fwp --service inventory -o shop` | a program split into gRPC services |
| `fwp build examples/cli/todo.fwp --cli -o todo && ./todo --help` | a command-line program |
| `fwp serve --rest examples/rest/books.fwp` | a REST API, with `/openapi.json` |
| `fwp openapi examples/rest/books.fwp` | its OpenAPI document |
| `fwp build examples/rest/books.fwp --mcp -o books-mcp` | an MCP server of the same functions |
| `fwp test --std` | the standard library's own tests |
| `fwp fmt --check . && fwp lint examples` | formatting and lint checks |
| `fwp lsp` | the language server, for editors |

fwp itself also runs in the browser. The playground in `web/` checks,
formats and runs programs with no server (needs
`rustup target add wasm32-wasip1`). Build `web/fwp.wasm`, serve `web/`,
and open http://localhost:8000:

```
scripts/build-playground.sh
python3 -m http.server -d web 8000
```

## Documentation

| Document | Contents |
|---|---|
| [docs/tutorials](docs/tutorials/README.md) | twenty-one tutorials, from pipes to split services, fwp in the browser, and building real command-line programs, REST APIs and MCP servers, step by step |
| [docs/reference.md](docs/reference.md) | the language, the `fwp` command, targets, C interop, formatter, linter and language server |
| [docs/stdlib.md](docs/stdlib.md) | every standard library module and signature |
| [docs/concurrency.md](docs/concurrency.md) | tasks, networking, HTTP, JSON, logs, metrics |
| [docs/cli.md](docs/cli.md) | functions as a command-line program: flags, choices, environment variables, help, subcommands, exit statuses, shell completion, man pages |
| [docs/rest.md](docs/rest.md) | functions as REST endpoints: routes, the JSON codec, forms and files, content negotiation, OpenAPI documents and generated clients |
| [docs/interfaces.md](docs/interfaces.md) | exposing functions (`# expose:`); one function as a command, a REST endpoint and an MCP tool, compared |
| [docs/mcp.md](docs/mcp.md) | functions as the tools of a stateless MCP server, over stdio or HTTP |
| [docs/tls.md](docs/tls.md) | TLS with the system's OpenSSL: HTTPS servers and clients, REST over HTTPS, services over TLS |
| [docs/protocol.md](docs/protocol.md) | executables and the typed pipe protocol |
| [docs/services.md](docs/services.md) | one program as one executable or as services that talk gRPC: streams, deadlines, metadata, statuses |
| [docs/benchmarks.md](docs/benchmarks.md) | fwp against C and Rust on five programs, and what the gaps come from |
| [docs/design.md](docs/design.md) | how the compiler is built, and what is not implemented |
| [docs/ownership.md](docs/ownership.md) | memory/representation design, stable semantics and acceptance criteria |
| [docs/development-state.md](docs/development-state.md) | current branch, checks, remaining failures and next session's actions |
| [PLAN.md](PLAN.md) | what was delivered and what comes next |
| [CONTRIBUTING.md](CONTRIBUTING.md) | setting up, testing, the rules the code follows, and how changes are merged |

## Layout

```
src/        compiler: lexer, parser, type checker, monomorphizer, optimizer,
            interpreter, C code generator, protocol, FFI, scheduler;
            formatter, linter and language server
runtime/    the C runtime embedded in native programs (and WASM helpers)
web/        the playground: fwp.wasm in a page, with a small WASI in JavaScript
scripts/    build-playground.sh
lib/        the standard library, written in fwp (with its tests)
examples/   a word counter, a JSON API server, executable tools, a shop
            split into services, command-line programs, a REST bookstore
tests/      golden programs, type-check and lint snapshots, protocol, HTTP,
            TLS, FFI, WebAssembly, fat-binary, formatter, language server,
            services, REST, gRPC, browser (fwp.wasm), compile cache, GC,
            static memory and preemption tests; the benchmark runner
bench/      the same programs in fwp, C and Rust (docs/benchmarks.md)
docs/       documentation and tutorials
```

## Development

```
cargo fmt --all
cargo clippy --all-targets -- -D warnings
cargo test
```

`cargo test` runs every golden program in the interpreter and natively;
`FWP_BLESS=1 cargo test` regenerates the snapshot files after an intended
change.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full checklist, the test
suites and how changes are merged.

## License

fwp is released under the MIT license ([LICENSE](LICENSE)). Code and
documentation vendored in from other projects keep their own licenses,
which are kept with them. Each is traceable to its original source: the
project, where it came from and the version taken.

Copyright 2026 Adrian Mârza and fwp contributors
