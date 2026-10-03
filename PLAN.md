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
9. **Production interfaces** (done). REST endpoints read headers and
   cookies as parameters (`# header:`, `# cookie:`) or the whole
   `Request`, choose their status and headers (`RestReply`), require
   bearer tokens, API keys or client certificates verified by
   `authenticate` (`# auth:`, OpenAPI security schemes), answer CORS
   (`# cors:`), have time limits (`# timeout:`), JSON server errors, a
   `/docs` page and YAML documents; the importer reads `allOf`, untagged
   `oneOf`s (`# json: untagged`), header and cookie parameters, security
   requirements and form bodies. gRPC has response metadata, streams of
   results that end with a status, interleaved bidirectional clients and
   gzip (DEFLATE written from scratch). TLS has client certificates
   (mutual TLS) for servers and clients, and per-call options for gRPC
   clients. See [docs/rest.md](docs/rest.md), [docs/grpc.md](docs/grpc.md)
   and [docs/tls.md](docs/tls.md).
10. **Tasks in the browser** (done where the engine has JavaScript Promise
    Integration). Tasks and channels run on WebAssembly, both in programs
    built with `--target wasm32-wasi` or `wasm32-browser` and in fwp.wasm
    (the playground runs tutorial 6): each task is a fiber, which the
    JavaScript host suspends and resumes with JSPI (`web/fibers.js`), while
    the scheduling stays in the native runtime and the interpreter.
    Sleeping uses a JavaScript timer; a deadlock traps. This works in
    Chrome and Edge 137 and later and in node 24 (node 22 with
    `--experimental-wasm-jspi`); other engines and WASI runtimes run
    programs without tasks only (a program that starts one traps, or in
    fwp.wasm is rejected before it starts). Sockets stay unavailable. See
    [the reference](docs/reference.md#tasks-on-webassembly).
11. **HTTP/2, WebSocket and compression** (done). `http.serve`, and so
    every REST server, speaks HTTP/2 with the same handlers: h2 chosen
    with ALPN over TLS and h2c with prior knowledge, every stream in its
    own task, streamed bodies as DATA frames, the server's limits and
    timeouts per stream, GOAWAY on shutdown. It runs on the HTTP/2
    connections of gRPC (framing, HPACK, flow control), shared in both
    backends. The client uses HTTP/2 when a TLS server chooses it (or
    when told to), pooling a connection per origin. WebSocket (RFC 6455)
    servers (`http.websocket`, on a new `Body.Upgrade` response) and
    clients (`ws.connect`, `ws://` and `wss://`) exchange messages over a
    pair of channels, with pings, fragmentation, masking, close codes and
    size limits; SHA-1 and base64 are written from scratch. Responses are
    compressed with gzip or deflate (`compress` in the config,
    `http.compress`), request bodies decompressed, and the client
    decompresses responses. See
    [docs/concurrency.md](docs/concurrency.md#http2) and
    [tutorial 20](docs/tutorials/20-websockets-and-http2/README.md).

12. **Preemption, faster pipes, tasks without JSPI** (done). Tasks are
    preempted after a slice of 10000 safe points (function entries and
    `loop` iterations), counted alike by the interpreter and native
    programs, so busy tasks no longer starve others, deadlines and
    cancellation interrupt them, and the interleaving stays deterministic
    and identical between the backends. Between fwp executables on Linux,
    the binary pipe protocol moves to a Unix domain socket (`UDS_V1`) or a
    lock-free ring in shared memory (`SHM_V1`) after its header, with the
    same bytes and a fallback to the pipe. `--wasm-async=asyncify` runs
    the tasks of compiled WebAssembly programs in engines without JSPI,
    through binaryen's Asyncify. See
    [docs/concurrency.md](docs/concurrency.md#preemption),
    [docs/protocol.md](docs/protocol.md#transports) and
    [the reference](docs/reference.md#tasks-on-webassembly).

13. **Reverse-mode autodiff and devices** (done). `Rev[T]` numbers record
    operations on a tape kept by the runtime, so generic numeric code
    differentiates in reverse mode unchanged: `grad`, `value-and-grad`,
    `vjp`, `rev.jacobian`, checked against forward mode and finite
    differences. Tensor expressions implement the numeric traits and
    compile to fused elementwise kernels that run on a `Device`: `Cpu`,
    `CpuParallel n` (OS threads, with results that do not depend on the
    thread count, sums included) or `Gpu` (OpenCL C generated from the
    kernel, with libOpenCL loaded at run time); `tensor.grad`
    differentiates them in reverse mode. A JIT and distributed execution
    were left out. See [docs/numerics.md](docs/numerics.md) and
    [tutorial 21](docs/tutorials/21-autodiff-and-devices/README.md).

14. **REST bodies, formats and imports; reflection of imported routes**
    (done). REST endpoints take forms and `multipart/form-data` with
    files (`Upload`) besides JSON (`# accepts:`, 415 for other media
    types), and write their results as JSON, text or CSV by the request's
    `Accept` header (`# produces:`, 406), all in fwp and in the OpenAPI
    document. `fwp openapi --import` reads YAML (a YAML 1.2 reader of its
    own) and Swagger 2.0 (converted to OpenAPI 3), and its clients send
    forms and files and read text and bytes. `fwp proto --import` keeps
    the descriptors of the `.proto` file and its imports, and `grpc.serve`
    serves server reflection (v1 and v1alpha) for the routes that carry
    them, so grpcurl needs no `.proto`. See [docs/rest.md](docs/rest.md)
    and [docs/grpc.md](docs/grpc.md).

14. **Compiled by default** (done). `fwp run`, `fwp exec`, `fwp test`,
    `fwp serve` and `fwp pipe` compile programs to native executables
    through C and run them in place of `fwp`, cached by the hash of the C
    source, the compiler, its options and the linked C code; `--interp` (or
    `FWP_RUN=interp`) runs the interpreter, which stays the reference, and
    so does a missing C compiler. See
    [the reference](docs/reference.md#compiled-by-default).

15. **Typed scalar code** (done). Arithmetic, negation and comparisons of
    fixed-width integers, `F32` and `F64` compile to plain typed C that
    the C compiler inlines, with the interpreter's traps (overflow,
    division by zero, `MIN / -1`), instead of calls that dispatch on the
    number kind at run time; and applying a closure that captured nothing
    to all its arguments no longer copies them. A loop of tuple
    arithmetic runs 1.7 times as fast. Scalars were already unboxed in a
    `V`; records by value come with escape analysis (17).

Next in this series, toward static, zero-cost programs:

16. Closures and combinators specialized away (defunctionalization,
    direct calls of known functions in `loop`, `map`, `fold` and the
    other higher-order primitives), and fused list and iterator
    pipelines.
17. Escape analysis: values that do not outlive a call on the stack, and
    records and tuples that do not escape kept in C locals.
18. Arenas by default: bump allocation per task and per request, freed
    whole, with the collector for what escapes them.
19. A static memory mode (`--memory=static`): every limit computed or
    declared, all memory allocated once at startup, nothing after it.
20. Static, LTO and profile-guided builds, a precompiled runtime for
    faster first runs, and benchmarks against C and Rust in CI.

## Later

See [Not implemented](docs/design.md#not-implemented).
