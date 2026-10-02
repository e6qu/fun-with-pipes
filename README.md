# fwp ("foop")

fwp is a tacit, curried, pipe-oriented programming language. It has static
types, tracked effects, structured concurrency, and two execution engines:
an interpreter and native code through C. It implements the *Pipe Language
Compact Specification*.

```fwp
# Count the most common words on stdin.
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
- **Tracked effects.** `IO`, `Error[E]`, `State[S]`, `Async`, `Network`
  appear in function types, with handlers and affine resources.
- **Compile time.** `comptime`, syntax as data, hygienic macros, `type[T]`.
- **Numerics.** Sized vectors and matrices, complex numbers, autodiff,
  balanced ternary, SIMD and tensor graphs.
- **Concurrency and the web.** Tasks, channels and deadlines; TCP, UDP and
  DNS; an HTTP/1.1 server and client; JSON, logs and metrics.
- **Many outputs.** An interpreter and native executables with identical
  output; one executable per exported function, joined by a typed pipe
  protocol; WebAssembly; fat binaries; C libraries and C interop.
- **Command-line programs.** Any exported function is a CLI: a record
  parameter becomes flags, doc comments become `--help`, and
  `fwp build --cli` makes one executable with a subcommand per function.
- **REST and OpenAPI.** Any exported function is also a REST endpoint
  with a typed JSON contract: `fwp build --rest` makes one HTTP server,
  which serves the OpenAPI 3.1 document derived from the types, and
  `fwp openapi --import` turns any API's OpenAPI document into typed
  client functions.
- **In the browser.** The compiler and interpreter build for WebAssembly;
  a playground page checks, formats and runs programs without a server.
- **gRPC.** Any exported function is also a gRPC method, with streams
  decided by its type (`Iterator` and `Channel`), deadlines, metadata and
  statuses: `fwp build --grpc` makes one server, with reflection and
  health checking, and `fwp proto --import` turns any `.proto` file into
  typed clients and server routes. Calls and servers run concurrently on
  the task scheduler.
- **One program, two deployments.** The same source builds into one
  executable or into gRPC services, one per module you name, whose calls
  to each other go over HTTP/2.

## Quick start

Requirements: Rust (stable) and a C compiler. Optionally, for WebAssembly:
clang with a WASI sysroot (Debian/Ubuntu: `wasi-libc`,
`libclang-rt-18-dev-wasm32`, `lld`) and node.

```
cargo build --release
export PATH=$PWD/target/release:$PATH

fwp run examples/hello.fwp
fwp build docs/tutorials/02-data/main.fwp -o data && ./data
fwp build examples/hello.fwp --target wasm32-wasi -o hello.wasm
fwp run examples/server/api.fwp          # a JSON API on 127.0.0.1:8080
fwp build examples/services/main.fwp --service inventory -o shop   # gRPC
fwp build examples/cli/todo.fwp --cli -o todo && ./todo --help    # a CLI
fwp serve --rest examples/rest/books.fwp # a REST API with /openapi.json
fwp openapi examples/rest/books.fwp      # its OpenAPI document
fwp serve --grpc examples/grpc/weather.fwp   # a gRPC server, with reflection
fwp test --std                           # the standard library's own tests
fwp fmt --check . && fwp lint examples   # formatting and lint checks
fwp lsp                                  # the language server, for editors
```

fwp itself also runs in the browser. The playground in `web/` checks,
formats and runs programs with no server (needs
`rustup target add wasm32-wasip1`):

```
scripts/build-playground.sh             # builds web/fwp.wasm
python3 -m http.server -d web 8000      # open http://localhost:8000
```

## Documentation

| Document | Contents |
|---|---|
| [docs/tutorials](docs/tutorials/README.md) | eighteen tutorials, from pipes to gRPC services, fwp in the browser, command-line programs, REST APIs and gRPC |
| [docs/reference.md](docs/reference.md) | the language, the `fwp` command, targets, C interop, formatter, linter and language server |
| [docs/stdlib.md](docs/stdlib.md) | every standard library module and signature |
| [docs/concurrency.md](docs/concurrency.md) | tasks, networking, HTTP, JSON, logs, metrics |
| [docs/cli.md](docs/cli.md) | any function as a command-line program: flags, choices, environment variables, help, subcommands, exit statuses, shell completion, man pages |
| [docs/rest.md](docs/rest.md) | any function as a REST endpoint: routes, the JSON codec, OpenAPI documents and generated clients |
| [docs/interfaces.md](docs/interfaces.md) | one function as a command, a REST endpoint and a gRPC method, compared |
| [docs/grpc.md](docs/grpc.md) | any function as a gRPC method: streams, deadlines, metadata, statuses, reflection, and clients and servers from `.proto` files |
| [docs/protocol.md](docs/protocol.md) | executables and the typed pipe protocol |
| [docs/services.md](docs/services.md) | one program as one executable or as gRPC services |
| [docs/design.md](docs/design.md) | how the compiler is built, and what is not implemented |
| [PLAN.md](PLAN.md) | what was delivered and what comes next |

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
            split into services, command-line programs, a REST bookstore,
            gRPC services
tests/      golden programs, type-check and lint snapshots, protocol, HTTP,
            FFI, WebAssembly, fat-binary, formatter, language server,
            services, REST, gRPC and browser (fwp.wasm) tests
docs/       documentation and tutorials
```

## Development

```
cargo fmt --all
cargo clippy --all-targets -- -D warnings
cargo test                 # interpreter and native for every golden program
FWP_BLESS=1 cargo test     # regenerate snapshot files after an intended change
```
