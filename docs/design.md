# Design

This page records how fwp is built and why. It covers the decisions the
*Pipe Language Compact Specification* leaves open. The language itself is
described in the [reference](reference.md); this page is for people working
on the compiler.

## Pipeline

```
lex → parse (offside layout) → macro expansion → name collection
    → inference (types, traits, effects, resources) → monomorphization
    → typed IR → optimizer → { interpreter, C code generator }
```

| Concern | Decision |
|---|---|
| Host language | Rust, stable, with no third-party crates |
| Native code | Typed IR → C11 → the system C compiler. The same C goes to WebAssembly through `clang --target=wasm32-wasi` |
| Interpreter | Runs the same typed IR. It powers `fwp run`, `fwp test`, `comptime` and macros, and it is the oracle the native backend is tested against |
| Primitives | A fixed set of primitives, implemented twice: in Rust (`src/prims_std.rs`, `src/web.rs`, `src/linalg.rs`, …) and in C (`runtime/fwp_rt*.c`). Everything else in the standard library is fwp code in `lib/` |
| Polymorphism | Whole-program monomorphization. Traits resolve statically; there is no dictionary passing. Polymorphic recursion is rejected |
| Memory | Native programs have a non-moving mark-and-sweep collector with conservative roots (`runtime/fwp_rt_gc.c`, see [Runtime](#runtime)); WebAssembly builds allocate from a bump heap that is never freed. The interpreter uses Rust reference counting |

The C backend and the interpreter must agree byte for byte on stdout,
stderr and the exit code. `tests/golden_run.rs` runs every program in
`tests/run/` through both.

## Syntax

- `#` starts a comment, so `#!/usr/bin/env fwp` works.
- Identifiers are `lower-kebab-case`. A hyphen may join letters, so there
  is no infix arithmetic: `x | sub 1` is `x − 1`.
- Uppercase names are types and constructors. An unknown uppercase name in
  a type (`T`, `Elem`) is an implicit type variable.
- Selectors (`.name`, `.0`, `.address.city`) are ordinary functions.
- A top-level declaration starts in column 1 and indented lines continue
  it. `match`, `trait` and `impl` use an offside rule; a braces-and-commas
  form works everywhere.
- Every standard function takes its subject last, which is what makes `|`
  read left to right.
- The type checker decides what `|` means. With a value on the left,
  `x | f` is application; with a function on the left, `f | g` is
  composition. If the left side is still unknown when the binding is
  generalized, it defaults to application.
- `match` builds a function. Patterns never bind names; each `_` hole is
  passed to the arm's body as a curried argument, left to right.
- `quote` turns an expression into a `Syntax` value and `name!(…)` calls a
  macro. Tacit code has no local binders, so the only possible capture is
  at module level, and quoted names are qualified with their module.

## Types and effects

- Hindley–Milner inference with levels. Records and effects share one row
  unifier.
- Tuples are records with numeric labels, and unit is the empty record.
- Nominal records are distinct from each other but unify structurally with
  open rows, so `.name` accepts both `User {…}` and `{name = "x"}`.
- Higher-kinded parameters work through variable-headed application
  (`F[A]`). Type-level naturals (`Vector[F64, 3]`) unify by equality.
- Traits have superclasses, default methods and parameterized impls. The
  compiler solves `Eq`, `Ord`, `Hash`, `Display`, `Dup`, `Encode` and
  `Decode` structurally. Integer and float literals are classes that fall
  back to `FromInt` and `FromFloat`, so `Dual[F64]` accepts literals.
- Every arrow carries an effect row. A closed row in a signature is opened
  when instantiated, which gives subeffecting. Handlers (`attempt`, `try`,
  `run-state`) remove labels by unification.
- Only the last arrow of a binding may have effects, so effects happen
  exactly when a call is saturated. Top-level values that are not
  functions must be pure (`main` and tests aside).
- `Error[E]` is a delimited abort: a Rust `Result` in the interpreter,
  `setjmp`/`longjmp` in C.
- Values flow linearly through a pipeline. Duplication happens only through
  combinators (`dup`, `fork`, `both`), which need `Dup[T]`; `resource`
  types are not `Dup`.
- Numbers have explicit widths. Arithmetic traps on overflow and division
  by zero; `wrapping`, `saturating`, `overflowing` and `checked` give the
  alternatives. There are no implicit conversions. `F16`, `BF16` and
  `F128` are computed at `F32` or `F64` precision.

## Runtime

- In C every value is a 64-bit word. Integers up to 64 bits and floats are
  stored inline; 128-bit integers, records, variants with fields, strings
  and closures are boxed; nullary constructors are small tags.
- A closure is a partial application of a known function. Tacit code has
  no free variables, so every function value can be serialized, which is
  how `comptime` results become static data.
- A type descriptor per monomorphic type drives equality, ordering,
  hashing, `Display`, text parsing, typed JSON and the binary protocol in
  C. For JSON, nominal records also carry their declaration order and the
  JSON names of renamed fields, and the descriptors of `Bool`, `Option`,
  `Json` and `Duration` are flagged.
- Floats print in the shortest form that reads back exactly.
- Native memory is collected by a non-moving mark-and-sweep collector
  (`runtime/fwp_rt_gc.c`). The heap is one reserved region of 64 KiB
  chunks; a chunk holds objects of one size class (16 bytes to 16 KiB)
  and one kind, or is part of one big object, and its class and mark bits
  are kept out of line, so any word can be tested for pointing into an
  object. Leaf objects (strings, bytes, boxed 128-bit integers, byte and
  float buffers) are never scanned; everything else is scanned
  conservatively, word by word, including the runtime structures that
  hold values (tasks, channels, gRPC connections and streams, temporary
  arrays). Roots are found conservatively: the registers (spilled to the
  stack), the running stack, the stack of every suspended task from its
  saved stack pointer, and the program's writable data segments, where
  static constants, CAFs and runtime globals live. Pointers into the middle
  of an object keep it alive, and from a stack so do pointers just past
  its end. A collection starts when the bytes allocated since the last one
  exceed twice the live heap (8 MiB at least); free chunks beyond a
  reserve are given back to the system. `FWP_GC=off` disables it,
  `FWP_GC_STATS=1` prints statistics at exit and `FWP_GC_STRESS=n`
  collects at every n-th allocation, which `tests/gc.rs` uses to run every
  golden program with a collection at each allocation. WebAssembly keeps
  a bump allocator that never frees, because values in WebAssembly locals
  are invisible to a stack scan; libraries (`--staticlib`, `--cdylib`)
  use the collector's allocator but never collect, since the host's
  stacks are unknown. The collector needs Linux (`dl_iterate_phdr`) to
  find the data segments; elsewhere it never collects.
- Native tasks are green threads (`ucontext`) on an event loop: epoll on
  Linux, poll elsewhere. Interpreter tasks are OS threads that pass a
  baton, so only one runs at a time and scheduling is the same.

## Executables and the pipe protocol

Each exported function can be built as its own executable. Arguments fill
the leading parameters, parsed by type; the last parameter comes from
stdin, per line or frame for `T` and all at once for `List[T]`.

A first parameter that is a record becomes flags, and the doc comments
above an `export` become its `--help`; `fwp build --cli` puts all the
exported functions into one executable with subcommands
([cli.md](cli.md)). The comments are read from the source text after
parsing (`cli::Docs`), so they need no syntax of their own.

Between fwp executables, values travel in the `PIPE_V1` binary protocol: a
header with the magic `FWP1`, a version, capabilities, a 128-bit type
fingerprint and the canonical type string, then frames of
`kind:u8, len:u32le, payload`. The payload is a deterministic
little-endian encoding driven by the type. A fingerprint mismatch is an
error. See [protocol.md](protocol.md).

## Builds

| Output | How |
|---|---|
| executable | C compiled and linked with the runtime; the reachable standard library is included. Programs whose reachable code uses TLS (a `tls.*` primitive) or services also get `runtime/fwp_rt_tls.c` and are linked with `-lssl -lcrypto`; the interpreter reaches the same OpenSSL through `dlopen` (`src/tls.rs`), so the compiler links no TLS library. See [tls.md](tls.md). Programs that serve or send HTTP (HTTP/2, compression, WebSocket frames: `http2.*`, `zlib.*` and `ws.*` primitives) also get the HTTP/2 runtime of gRPC (`fwp_rt_h2.c`, `fwp_rt_grpc.c`) and `runtime/fwp_rt_http2.c` |
| `--fn f` | the exported function `f` as a standalone executable |
| `--cli` | every exported function as a subcommand of one executable. `src/cli.rs` computes the command line of each function (flags from an options record, positional arguments, defaults evaluated with the interpreter at build time) and its help and usage texts once; the C runtime (`runtime/fwp_rt_exec.c`) gets them as static data and parses arguments with the same rules as `src/exec.rs`. See [cli.md](cli.md) |
| `--rest` | every exported function as an endpoint of one HTTP server. `src/rest.rs` computes the endpoints from the types and doc comments (routes, where each argument comes from, statuses) and `src/openapi.rs` the OpenAPI document; the file is then compiled again with a generated `main` (`Roots::entry`) that serves `rest.endpoint`s of `lib/rest.fwp` over the HTTP server of `lib/http.fwp`, with authentication (`rest.secured` and the file's `authenticate`, compiled by name: `Roots::names`), time limits, CORS and an HTML page of the document, all in fwp. Arguments and results go through the typed JSON codec (`json.read`, `json.write`), a primitive written twice: `src/jsontype.rs` over types, `runtime/fwp_rt_json.c` over type descriptors. See [rest.md](rest.md) |
| `--grpc` | every exported function as a gRPC method. `src/rpc.rs` derives each method's messages and streams from its type (`Iterator`, `Channel`), its path from `# grpc:` lines, the `.proto` text and the reflection descriptor; the program is compiled as a service of its root module (`Roots::service`). The transport runs on the task scheduler: `src/grpc.rs` for the interpreter, `runtime/fwp_rt_grpc.c` natively. See [grpc.md](grpc.md) |
| `--fat` | one copy of the program per x86-64 CPU level, chosen at startup |
| `--service m` | the program split into gRPC services: a server executable for each named module, and a main executable whose calls to those modules' exported functions are remote. The monomorphizer replaces each such call with a client stub (`Body::Remote`); see [services.md](services.md) |
| `--staticlib`, `--cdylib` | a C library and header for the exported functions |
| `--target wasm32-wasi`, `wasm32-browser` | WebAssembly through clang; `setjmp`/`longjmp` use the WebAssembly exception proposal. Effects the target lacks (`Network`, `Process`) are compile errors. Tasks are fibers (`FWP_FIBERS` in `runtime/fwp_rt_task.c`): the scheduler is the native one, but `swapcontext` becomes a call to a hook that the JavaScript host installs in the function table (`web/fibers.js`), which suspends the calling fiber with JavaScript Promise Integration and resumes the next one; each task has its own 1 MiB region of linear memory for C's stack, and the stack pointer is saved and restored around each switch. Waiting for a timer with every task parked is another hook, a JavaScript timer |
| fwp itself, `--target wasm32-wasip1` | `cargo build --release --target wasm32-wasip1`: the compiler and interpreter as one WASI command, `fwp.wasm`, which the playground (`web/`) runs in a web worker through a small WASI written in JavaScript (`web/wasi.js`). There are no threads, so `with_big_stack` runs inline on a 512 MiB stack set at link time (`.cargo/config.toml`), and a program that uses `Network`, services or foreign C functions is rejected after lowering, before it runs (`driver::wasm_host_unsupported`), as the `wasm32-wasi` target rejects it. Tasks run on fibers (`src/fiber.rs`, with the same hooks as compiled programs): `World::park` switches to the next ready fiber instead of handing a baton between threads, in the same order, and traps on a deadlock. The interpreter's frames in linear memory are large (about a kilobyte per call), so the fibers of tasks share one 32 MiB stack region: a fiber that suspends copies out the part it uses, and copies it back when it resumes. Without JSPI, a program that uses tasks is rejected before it runs. Commands that compile C or start processes report that they are unavailable. Stdout is line-buffered there, so the output before an engine stack overflow is kept; values are dropped iteratively, so long lists do not need a deep stack |

## Not implemented

- HTTP/3; the HTTP/1.1 `Upgrade: h2c` handshake, HTTP/2 server push and
  WebSocket over HTTP/2 (RFC 8441); WebSocket subprotocols and extensions
  (permessage-deflate); compression of streamed responses, and content
  codings other than gzip and deflate. REST endpoints take JSON bodies
  only (no content negotiation or forms; headers and cookies are
  parameters), and `fwp openapi --import` reads JSON documents of
  OpenAPI 3.0 and 3.1, not YAML or Swagger 2.0 (`fwp openapi --yaml`
  writes YAML).
- TLS of fwp's own: TLS uses the system's OpenSSL 3 ([tls.md](tls.md)),
  which native programs that use it link and the interpreter loads at run
  time, with client certificates (mutual TLS). DTLS and QUIC are not
  implemented.
- Server reflection for `grpc.serve` routes made from `.proto` files.
- Sockets and foreign C functions in the WebAssembly build of fwp (the
  playground): a browser has neither sockets nor a C compiler. Tasks on
  WebAssembly need JavaScript Promise Integration, or binaryen's Asyncify (`--wasm-async=asyncify`, and
  `scripts/build-playground.sh --asyncify` for fwp.wasm); WASI runtimes
  without a JavaScript host run no tasks.
- GPU and distributed backends, a JIT, reverse-mode autodiff.
- Transports of the pipe protocol other than the pipe, `UDS_V1` and
  `SHM_V1` (which are Linux only), the WebAssembly component model and
  `wasm64`.
