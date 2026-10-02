# Plan

fwp implements the *Pipe Language Compact Specification*. The design
decisions are in [docs/design.md](docs/design.md); this page tracks the
work.

## Done

The language was delivered in twelve pull requests, each one green on
both backends:

| PR | Contents |
|---|---|
| 1 | lexer, layout-sensitive parser, diagnostics, `fwp check --parse` |
| 2 | Hindley–Milner inference with rows, ADTs, records, `rec`, pipe modes, exhaustiveness |
| 3 | traits with superclasses and higher kinds, sized numbers, literal and structural classes |
| 4 | effect rows, handlers, the effect rules, affine resources |
| 5 | monomorphization, typed IR, the interpreter, `fwp run` |
| 6 | the standard library in fwp, `fwp test` |
| 7 | the IR optimizer, native code through C, `fwp build`, differential tests |
| 8 | exported functions as executables, the `PIPE_V1` protocol, `fwp pipe` |
| 9 | `comptime`, `Syntax` values, hygienic macros, `type[T]` |
| 10 | vectors and matrices, complex numbers, autodiff, balanced ternary, SIMD, tensor graphs |
| 11 | tasks and channels, TCP/UDP/DNS, the HTTP server and client, JSON, URLs, logs, metrics |
| 12 | C interop, static and shared libraries, WebAssembly, fat binaries, documentation |

A review pass then fixed the problems found across the compiler, runtime
and standard library, and moved the tutorials to
[docs/tutorials](docs/tutorials/README.md).

**Services** followed: one program built either as a single executable,
where modules call each other directly, or as separate executables that
talk gRPC, with no change to the program (`fwp build --service`,
`fwp serve`, `fwp proto`). It brought HTTP/2 (h2c), HPACK and protobuf,
written from scratch for both backends. See [docs/services.md](docs/services.md).

## Next

1. **Tooling** (done). `fwp fmt` (a formatter that keeps comments), `fwp lint`,
   and `fwp lsp` (diagnostics, hover, go to definition, symbols,
   formatting, completion), with a parser that recovers from errors.
2. **fwp in the browser** (done). The compiler and interpreter build for
   `wasm32-wasip1`; the playground in `web/` checks, formats, tests and runs
   programs in a web worker, through a small WASI in JavaScript with an
   in-memory file system, without a server. Programs with tasks, sockets
   or foreign C functions are rejected there, as for the `wasm32-wasi`
   target. See [the reference](docs/reference.md#fwp-in-the-browser) and
   [tutorial 15](docs/tutorials/15-browser/README.md).
3. **Command-line programs** (done). Any exported function is a CLI:
   flags from a record parameter (with short flags, typed defaults and
   `--no-` switches), `--help` from the doc comments, `--version`,
   multi-command executables (`fwp build --cli`, `fwp exec --cli`),
   `Result` and `Option` results, and a standard library for files,
   directories, paths, processes (the `Process` effect), the
   environment, terminals and tables. See [docs/cli.md](docs/cli.md) and
   [tutorial 16](docs/tutorials/16-clis/README.md).
4. **Complete command-line programs** (done). Choices from
   enumerations, environment variables for flags (`[env: VAR]`), value
   names, optional and defaulted positional arguments, exit statuses
   (`Outcome`), `[requires: ...]`/`[conflicts: ...]`, shell completion
   (`--completions bash|zsh|fish`) and man pages (`--man`), doc comments
   from the syntax tree, and a library for CSV, prompts, progress lines,
   terminal width and streaming standard input. See
   [docs/cli.md](docs/cli.md#what-was-missing-and-what-was-added).
5. **REST and OpenAPI** (done). Any exported function is a REST endpoint:
   `fwp build --rest` and `fwp serve --rest` serve a file's functions over
   the HTTP server of `lib/http.fwp`, with routes, path and query
   parameters and statuses from doc comments (`# route:`, `# status:`,
   `# error:`), a typed JSON codec for every encodable type in both
   backends (`json.write`, `json.read`, with JSON paths in errors), and
   the OpenAPI 3.1 document derived from the types (`fwp openapi`,
   `/openapi.json`). `fwp openapi --import` generates typed client
   modules from OpenAPI documents. See [docs/rest.md](docs/rest.md),
   [docs/interfaces.md](docs/interfaces.md) and
   [tutorial 17](docs/tutorials/17-rest-and-openapi/README.md).
6. **gRPC** (done). Any exported function is a gRPC method
   (`fwp build --grpc`, `fwp serve --grpc`, `fwp proto --grpc`, with
   `# grpc:` names), with server, client and bidirectional streams decided
   by `Iterator` and `Channel` types, deadlines through the task
   machinery (`grpc-timeout`, `grpc.with-deadline`), metadata, statuses
   from `Error[GrpcError]`, server reflection and health checking. The
   HTTP/2 transport runs on the task scheduler in both backends: servers
   run calls concurrently and clients multiplex calls on one connection,
   waiting only in the calling task. `fwp proto --import` turns `.proto`
   files into fwp types, codecs (`lib/protobuf.fwp`), clients and server
   routes (`lib/grpc.fwp`). See [docs/grpc.md](docs/grpc.md) and
   [tutorial 18](docs/tutorials/18-grpc/README.md).
7. **TLS** (done). HTTPS servers and clients, REST over HTTPS
   (`--tls-cert`, `--tls-key`) and gRPC over TLS (ALPN `h2`, `tls://`
   addresses), with the system's OpenSSL 3 in both backends: native
   programs that use TLS link it, the interpreter loads it with `dlopen`.
   TLS connections are `Conn`s, so the HTTP server and client run over
   them unchanged, and handshakes wait on the task scheduler in the
   connection's own task. `lib/tls.fwp` has connections with
   verification, SNI and ALPN. See [docs/tls.md](docs/tls.md) and
   [tutorial 19](docs/tutorials/19-tls/README.md).
8. **A garbage collector for native programs** (done). A non-moving
   mark-and-sweep collector with size-segregated chunks, leaf objects
   that are never scanned, and conservative roots: registers, the running
   stack, every suspended task's stack and the program's writable data.
   Long-running native servers (HTTP, REST, gRPC) and long loops now run
   in bounded memory; `FWP_GC_STRESS` runs the golden suite with a
   collection at every allocation. WebAssembly builds keep the bump
   allocator. See [the design](docs/design.md#runtime).
9. **Tasks in the browser.** A scheduler for the WebAssembly build that does
   not need threads, for example with the WebAssembly stack switching
   proposal once browsers ship it.

## Later

See [Not implemented](docs/design.md#not-implemented).
