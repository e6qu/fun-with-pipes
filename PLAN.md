# Plan

fwp implements the *Pipe Language Compact Specification*. The design
decisions are in [docs/design.md](docs/design.md); this page tracks the
work.

## Active roadmap

Execution: continue through this roadmap automatically, one focused PR at a
time. Run full gates on GitHub runners, resolve failures, then squash-merge
with an explicitly supplied single-line subject of at most 80 characters
and an empty body, without trailers or attribution. Update this plan and
the session handoff with acceptance evidence and the next action; move a
phase to done only when its criteria have been met. The user authorized
this workflow on 2026-10-07. Treat failing tests as work to fix and queued
CI as a merge gate. Continue useful implementation, investigation and next-task
preparation while CI runs; do not stop the roadmap merely for test failures
or runner delays. Keep one PR open at a time.

The goal is an efficient native language with simple pipe semantics,
strong inference and static typing, compile-time specialization, little
heap allocation, and deterministic ownership wherever possible. Tracing
GC is a compatibility fallback while runtime ownership is completed.

Start each session with [the handoff](docs/development-state.md) and
[the ownership design](docs/ownership.md). The numbered history below
records deliveries; its old "next" remarks are historical, not a second
priority queue.

| Order | Work | Acceptance |
|---|---|---|
| 1, done (#74) | Native macOS on Apple Silicon and Intel: task ABI, collector roots, libraries, processes, sockets, TLS and CI | Both macOS jobs and Linux CI pass; collection really runs; interpreter/native behavior agrees; unsupported build options are explicit |
| 2, in progress | Primitive and runtime ownership contracts; count elimination at borrowed boundaries; ownership of strings, bytes and escaping closures | Checked ownership paths and aliasing/callback tests; fewer counts without losing roots or increasing allocation; immediate reclamation demonstrated by counters |
| 3 | Typed contiguous numeric storage, views, scalar/aggregate ABI and measured alignment | Narrow elements use their natural width; fewer copies/boxes; allocation and assembly evidence on arm64 and x86-64; ABI/FFI tests |
| 4 | Fused numerical loops, blocked matrix kernels and autodiff lifetime/buffer improvements | Correct gradients and exceptional cleanup; equivalent C/Rust comparisons; fixed floating-point behavior by default |
| 5 | Expand allocation/ownership/performance regression evidence | Allocation, live-memory, retain/release and collection measurements alongside timings; full workloads on CI |
| 6 | Optional execution without tracing GC, after complete ownership coverage | Supported programs reclaim memory with collection disabled, including escaping values and runtime boundaries; cycles have an explicit lifetime policy |

Native macOS passed both architecture jobs, Linux full tests and benchmarks in
run `37591744197`; PR #74 was squash-merged as `af15d26`.

Container ownership contracts passed all four jobs in run `37612412156`;
[PR #75](https://github.com/e6qu/fun-with-pipes/pull/75) was squash-merged as
`5998302`. Comparison-only keys borrow; stored elements and retained callbacks
still share. The concurrent macOS executable-cache failure was repaired and
verified by full CI. Owned String/Bytes leaves passed all four jobs in
run `37623311024`; [PR #76](https://github.com/e6qu/fun-with-pipes/pull/76) was
squash-merged as `22994ba`. [PR #77](https://github.com/e6qu/fun-with-pipes/pull/77) covers fresh text result
trees and scratch cleanup, rebased onto main with passing focused checks;
full current-head CI gates its merge. Later published branches prepare closure and
synchronous list ownership, call-effect inference, exact high-fanout counts and
scan/iterate state ownership. Prepared work needs full CI in sequence; the
handoff records heads, old rebase anchors and local evidence. Next separate
implementation covers retained runtime ownership/teardown. Old marked-object
reclamation is prepared with focused survival, alias and task stress tests;
full CI still gates publication as the next sequential PR. Typed array and map/set element boundaries pass focused
validation in separate prepared branches;
repeat/range and zip/unzip/chunks ownership pass focused validation in separate branches. General/fused loop
state transfer is published separately; it repairs the lost reclamation in a
map/sum sequence consumer. Full gates after parent merges still remain.
Phase 2 remains incomplete; runtime teardown and full retained lifetimes remain.

Allocation elimination comes first, then registers/stack, ownership transfer,
regions with known lifetimes, and reference counting for sharing. Reference
counting itself has a cost. Static memory provisioning is not a proof of
allocation-free execution. C structs are not a guarantee of register placement.

Keep data-last pipes, composition, currying, immutable source semantics,
explicit generic signatures, effects, overflow checks and trap order stable.
Do not relax floating-point semantics globally to obtain benchmark speedups.
Defer Windows, additional interfaces and a new backend until the foundations
above are measured and stable.

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

## Delivery history

1. **Tooling** (done). `fwp fmt` (a formatter that keeps comments), `fwp lint`,
   and `fwp lsp` (diagnostics, hover, go to definition, references,
   rename, symbols, formatting, completion), with a parser that recovers
   from errors.
2. **fwp in the browser** (done). The compiler and interpreter build for
   `wasm32-wasip1`; the playground in `web/` checks, formats, tests and runs
   programs in a web worker, through a small WASI in JavaScript with an
   in-memory file system, without a server. Programs with tasks, sockets
   or foreign C functions are rejected there, as for the `wasm32-wasi`
   target. See [the reference](docs/reference.md#fwp-in-the-browser) and
   [tutorial 15](docs/tutorials/15-browser/README.md).
3. **Command-line programs** (done). Exported functions are CLIs:
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
5. **REST and OpenAPI** (done). Exported functions are REST endpoints:
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
6. **gRPC** (done). Exported functions are gRPC methods
   (`fwp build --grpc`, `fwp serve --grpc`, `fwp proto --grpc`, with
   `# grpc:` names), with server, client and bidirectional streams decided
   by `Iterator` and `Channel` types, deadlines through the task
   machinery (`grpc-timeout`, `grpc.with-deadline`), metadata, statuses
   from `Error[GrpcError]`, server reflection and health checking. The
   HTTP/2 transport runs on the task scheduler in both backends: servers
   run calls concurrently and clients multiplex calls on one connection,
   waiting only in the calling task. `fwp proto --import` turns `.proto`
   files into fwp types, codecs (`lib/protobuf.fwp`), clients and server
   routes (`lib/grpc.fwp`). (Item 29 narrowed gRPC to the calls between
   the parts of a split program: the streams, deadlines, metadata and
   statuses stay, in [docs/services.md](docs/services.md).)
7. **TLS** (done). HTTPS servers and clients, REST over HTTPS
   (`--tls-cert`, `--tls-key`) and gRPC over TLS (ALPN `h2`, `tls://`
   addresses), with the system's OpenSSL 3 in both backends: native
   programs that use TLS link it, the interpreter loads it with `dlopen`.
   TLS connections are `Conn`s, so the HTTP server and client run over
   them unchanged, and handshakes wait on the task scheduler in the
   connection's own task. `lib/tls.fwp` has connections with
   verification, SNI and ALPN. See [docs/tls.md](docs/tls.md) and
   [tutorial 18](docs/tutorials/18-tls/README.md).
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
   clients. See [docs/rest.md](docs/rest.md), [docs/services.md](docs/services.md)
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
    [tutorial 19](docs/tutorials/19-websockets-and-http2/README.md).

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
    [tutorial 20](docs/tutorials/20-autodiff-and-devices/README.md).

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
    them, so grpcurl needs no `.proto` (removed by item 29). See
    [docs/rest.md](docs/rest.md).

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
    `V`; records by value come with escape analysis (18, 19).

16. **Direct calls of known functions** (done). `map`, `filter`, `fold`,
    `fold-right`, `take-while`, `drop-while`, `zip-with` and `loop`, given
    a named function (or one the optimizer reduced to one), call it
    directly: the runtime's `fwp_k_*` variants take a C function pointer
    and are inlined at the call. Records and constructor values, which
    are filled as soon as they are allocated, no longer have their memory
    zeroed first. The loop of tuple arithmetic of item 15 runs 2.6 times
    as fast as before item 15.

17. **Static memory** (done). `fwp build --memory static` maps all of a
    program's memory once, populated, when it starts: the collector's heap
    (still collected, never grown), a pool behind `malloc` and `free`
    (defined by the program, so the C library's allocations come from it
    too), and the stacks of the main task, of a fixed number of tasks and
    of the threads of parallel kernels; nothing is asked of the operating
    system after that, which `strace` confirms in the tests. The sizes
    are options (`--heap`, `--pool`, `--stack`, `--tasks`,
    `--task-stack`, `--threads`); running out names the one to raise, and
    `FWP_MEMORY_REPORT=1` shows how much of each part was used. See
    [the reference](docs/reference.md#static-memory).

18. **Loops without allocation** (done). A `loop` whose step function is
    known, returns literal `Again x` and `Stop y`, and reads a record state
    only field by field compiles to a C loop with the state's fields in
    locals: neither the state nor the `Step` is allocated per iteration
    (with any other state, only the `Step` is not). The loop of tuple
    arithmetic of item 15 runs in 0.15 s instead of 1.7 s before item 15.

19. **Generational collection** (done). Small allocations already came
    from bump arenas per size class; collections are now generational
    without moving anything: marks stay from one collection to the next,
    minor collections trace only young objects and free young garbage,
    and old objects never point to young ones because values are
    immutable once allocated (memory filled later is scanned whole). On
    a program that churns through lists and a map, collections take 250
    ms instead of 850 ms and the program runs 2.6 times as fast.
    `FWP_GC_VERIFY=1` checks every minor collection against a full trace
    under `FWP_GC_STRESS` in the tests.

The optimization series delivered the following work; unfinished portions
are prioritized in the active roadmap above:

20. Escape analysis beyond loops (begun: a tuple built only to be
    matched is never built, and a `match` on `map.get` looks the key up
    and branches without allocating the `Some`, so the `map` benchmark
    allocates 72 MiB instead of 408). A record bound to a local and read
    only field by field becomes a local per field (scalar replacement),
    and copies of locals are propagated: the tuples `curry3` and friends
    leave behind are never built. Records and variants that do not
    outlive a call live on the stack (`src/escape.rs`): a variant built
    in a loop and handed to a function that matches on it went from 610
    MiB allocated and 0.58 s to nothing and 0.40 s. Closures too: one
    built per iteration and given to a function that only applies it
    went from 46 MiB allocated and 152 ms to nothing and 109 ms
    (`tests/stack/twice.fwp`). A match on a value built by an inlined
    function moves into the arms that build it, where the constructor is
    known, so the value is never built: a loop matching on a function's
    `Option` went from 153 MiB allocated and 164 ms to nothing and 22 ms.
    Calls that are not inlined return such a variant as a struct (tag
    and fields) when every path builds one, and a caller that only
    matches on it keeps it as one: a recursive function's `Option`,
    matched in a loop, went from 24 MiB allocated and 125 ms to nothing
    and 84 ms (`tests/stack/digits.fwp`). Records of up to eight fields
    are passed and returned as structs (a wide one returned by a function
    that builds it on every path), which the C ABI places in the caller's
    frame: a recursion returning a record of six fields went from 366 MiB
    allocated and 301 ms to nothing and 103 ms (`tests/stack/wide.fwp`).
21. **Fused list pipelines** (done for folds, `length` and `find`). A
    `fold` (and so `sum`), `length` (and so `count`) or `find` (and so
    `any` and `all`) over `map` and `filter` stages of a `range` or a list
    runs as one `loop`, without the intermediate lists (`src/fuse.rs`). A totality
    analysis comes first: every stage must be pure and terminating, and
    the stages together may raise at most one trap message, so whichever
    stage traps first, the program prints and exits the same. The
    `pipeline` benchmark went from 44 times C's time to 1.2. `find` stops
    at its first match, so the stages before it may not trap at all.
    Chains of two or more stages whose list is used as such build it in
    one pass (in reverse, then reversed). `iter.to-list` over
    `iter.map`, `iter.filter` and `iter.take` runs as one loop that pulls
    its source one element at a time: iterators are lazy, so the order is
    already element by element and no totality condition is needed (a
    pipeline over `iter.count-from` went from 2.4 s to 0.48 s). String stages
    (`show`, `concat`, `string.length`, ...) count as total, and the C
    backend measures a `concat` or a shown integer without building
    it: the `strings` benchmark went from 4.1 times C's time to 0.1.
    Loops in programs without tasks count no safe points, maps compare
    integer keys inline, and the optimizer substitutes a closure used
    once where it is applied and drops tuples built only to be matched:
    `loop` and `map` went from 2.5 and 2.0 times C's time to 1.3 and
    1.1.
22. Faster first runs (begun: large programs are compiled with GCC's
    parallel link-time optimization, halving a REST server's first start
    on four cores; and no C is generated for the functions nothing
    reaches after inlining, mostly instances of small combinators: the
    REST bookstore's C went from 2.3 MB and 3796 functions to 1.1 MB and
    839, and its first build from 9.4 s to 4.4 s). Static and
    profile-guided builds are done: `fwp build --static` links a
    self-contained executable, and `fwp build --pgo -- args` trains the
    program once and compiles it again with the profile (the `map`
    benchmark: 650 ms to 558 ms).
23. **Benchmarks against C and Rust** (done). `bench/` has five programs
    in fwp, C and Rust, run in CI with their outputs compared; see
    [docs/benchmarks.md](docs/benchmarks.md). They found that building a
    map or a set from a list was quadratic (now sorted once), and that
    closures such as `map (mul 3)` or `filter (rem 2 | eq 0)` went through
    the generic application for every element: higher-order primitives
    now get a specialized function of the captured locals and the
    elements, called directly (`opt::specialize_hofs`).
24. **Explicit generics** (done). Only a signature makes a top-level
    definition generic, as in Odin. A definition without one is
    monomorphic: a type left open by a literal takes the literal's
    default (`I64`, `F64`), and any other open type is an error that
    gives the signature to write. Effect rows are still inferred.
    Generics stay zero-cost: each is specialized per use by the
    monomorphizer. This avoids what implicit generalization cost Haskell:
    generic code that needs an optimizer to be fast again, and type
    errors far from their cause. See
    [docs/design.md](docs/design.md#generics).
25. **Memory without a collector** (begun). Plan: values small enough
    for registers stay in them, and the rest is reference counted with
    reuse in place (as in Perceus), checked against the interpreter.
    Every IR function now records the type of each local
    (`Func::locals`), kept by mono, the optimizer and fusion, and checked
    after each pass in debug builds (`ir::check_locals`): a value's size
    and whether it holds pointers follow from its type. Records of up to
    four fields are passed and returned in registers by direct calls, as
    C structs: a recursion over pairs went from 437 MiB allocated and 282
    ms to 21 MiB (its input list) and 49 ms. A `loop`'s state whose
    fields are such records (a `fold` with a tuple accumulator) keeps
    them field by field: summing and counting 30 million numbers went
    from 915 MiB and 176 ms to nothing allocated and 26 ms. Reference
    counting: `src/rc.rs` inserts `Dup` and `Drop` (Perceus's discipline:
    owned parameters, borrowing primitives, drops as early as possible)
    and checks every path of every function for leaks, double releases
    and reads after the last reference. The collector keeps freeing
    memory; the counts find records with one reference, which an update
    then writes in place (now the default; `FWP_REUSE=0` turns it off): a loop updating a
    record of five fields went from 458 MiB allocated and 114 ms to
    nothing and 67 ms, while the benchmarks stay within noise except
    `map` (8% slower: its pairs are made unique and then shared at once).
    A variant's cell is reused by a constructor of the same size: adding
    to every node of a tree of 2^18 nodes 20 times went from 168 MiB
    allocated and 234 ms to 16 MiB (the tree) and 137 ms. Arrays are
    counted too, and `array.set` and `array.push` write a unique array in
    place: 200 000 pushes in a loop went from 152 GiB allocated and 80 s
    to 6 MiB and 14 ms. Maps and sets too: 100 000 insertions went from
    76 GiB and 41 s to 5 MiB and 17 ms. Objects are freed when their
    last counted reference goes, with what they hold (drop functions per
    type): building and walking a tree 200 times went from 33
    collections and a 37 MiB heap to none and 2 MiB. Lists the runtime's
    primitives build stay shared and are left to the collector: counting
    their cells (fresh results, inputs shared element by element) freed
    730 of 1101 MiB of a list-churning program but made it 35% slower, as
    the generational collector already frees short-lived lists cheaply.
    Remaining: precise borrowing at runtime boundaries, then ownership of
    the runtime-shared categories (active roadmap item 2).
26. **Cross-compilation** (begun). `fwp build --target aarch64-linux`
    (or `riscv64-linux`, `x86_64-linux`, ...) builds for another 64-bit
    Linux with that system's C compiler: `FWP_CC_<triple>`,
    `<triple>-gcc`, `clang --target` or `zig cc`. `--static` gives one
    self-contained executable, as Go does. The tests build every golden
    program for aarch64 and run it under qemu (`tests/cross.rs`). musl
    (`--target x86_64-linux-musl`, `aarch64-linux-musl`): the runtime
    switches tasks itself there (a few instructions for x86-64 and
    AArch64), and the tests build every golden program static with musl,
    and run the task programs on aarch64 with that switch. Native macOS is
    now the active portability work; Darwin cross targets and Windows
    remain deferred. Current verification is in the session handoff.
27. **Size arithmetic** (done). Sizes in types may be sums and
    products (`Vector[t, n + m]`, `Vector[t, m * n]`), checked as
    polynomials over the size variables, with `vector.append`,
    `vector.push`, `matrix.flatten`, `matrix.stack` (rows add up) and
    `matrix.beside` (columns add up) in the standard library.
    A size `n + 1` proves a vector has an element: `vector.head`,
    `last`, `tail` and `init` are total, without an `Option`.
    Subtraction where it is safe: `vector.split : Vector[a, m] ->
    Vector[t, n + m] -> (Vector[t, m], Vector[t, n])` takes the first m
    elements, and a split of more than a vector has is a compile error.
    `matrix.split-rows` and `matrix.split-columns` do the same for
    matrices.
28. **Abstract sizes** (done). `Dyn` is gone: a size known only when
    the program runs is abstract (`_`, `_n` in a signature's result),
    chosen afresh by each call and rigid for callers, with
    `vector.same-size`, `matrix.same-shape` and `matrix.as-square` to
    compare at run time. Performance-impacting: each such check is a
    run-time comparison and an `Option`. Packed values hold sizes of
    their own: `AnyVector[t]` and `AnyMatrix[t]` (`vector.pack`,
    `vector.unpack`), so a list may hold vectors of different lengths.
29. **Explicit interfaces and MCP** (done). An exported function is on
    an interface only when a `# expose: cli, rest, mcp` line (above it,
    or in the file's leading comment) says so; `--fn`, `fwp exec`, C
    libraries and the services of a split program need none, so a
    program deploys as one executable or as services with no change to
    its functions. gRPC is now only the transport between those
    services: `fwp build --grpc`, `fwp serve --grpc`, `fwp proto --grpc`,
    `fwp proto --import`, the client and server routes of `lib/grpc.fwp`,
    `lib/protobuf.fwp` and server reflection of routes are gone. `fwp build --mcp` and `fwp serve --mcp` serve the
    functions exposed as `mcp` as the tools of a stateless MCP server
    (protocol 2026-07-28: `server/discover`, `tools/list`, `tools/call`,
    no session), over stdio or HTTP, with JSON Schemas from the types
    (`lib/mcp.fwp`, `src/mcp.rs`). The tutorials about building things
    (7, 8, 14, 16 to 19, 21) are shell sessions that the test suite replays. See
    [docs/interfaces.md](docs/interfaces.md) and [docs/mcp.md](docs/mcp.md).

## Later

See [Not implemented](docs/design.md#not-implemented).
