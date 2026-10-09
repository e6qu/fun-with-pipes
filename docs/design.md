# Design

This page records how fwp is built and why. It covers the decisions the
*Pipe Language Compact Specification* leaves open. The language itself is
described in the [reference](reference.md); this page is for people working
on the compiler.

## Pipeline

The active priorities are in [../PLAN.md](../PLAN.md), the ownership and
representation contract in [ownership.md](ownership.md), and current checks
and limitations in [development-state.md](development-state.md).

```
lex → parse (offside layout) → macro expansion → name collection
    → inference (types, traits, effects, resources) → monomorphization
    → typed IR → resource frame anchors → optimizer → { interpreter, C code generator }
```

| Concern | Decision |
|---|---|
| Host language | Rust, stable, with no third-party crates |
| Native code | Typed IR → C11 → the system C compiler. The same C goes to WebAssembly through `clang --target=wasm32-wasi` |
| Ahead of time by default | `fwp run`, `exec`, `test`, `serve` and `pipe` compile to native executables, cached by content (`src/aot.rs`), and run them in place of `fwp`. The front end still runs on every start, so diagnostics do not depend on the cache. See [Compiled by default](reference.md#compiled-by-default) |
| Interpreter | Runs the same typed IR. It powers `comptime`, macros, the WebAssembly build of fwp and `--interp`, and it is the oracle the native backend is tested against |
| Scalars | Every value is a 64-bit `V` in C: integers up to 64 bits sign- or zero-extended, floats by their bits, everything else a pointer or a small tag. Arithmetic and comparisons of fixed-width integers, `F32` and `F64` are generated as typed C per type (`Scalar` in `src/cgen.rs`), checked like the interpreter's; 128-bit integers, `TInt` and `F16` go through the runtime's generic `fwp_arith` |
| Loops | A `loop` whose step is a known function with literal `Again x` and `Stop y` results compiles to a C loop (`loop_shape`, `Gen::loop_def` in `src/cgen.rs`): the step's body writes the next state into locals instead of allocating it, field by field when the state is a record the step only reads through fields, and a field that is itself a record of up to eight fields (a `fold`'s tuple accumulator) as its fields too, built only where it is read whole (`LoopGen::slots`); safe points are counted as in the generic loop |
| List pipelines | A `fold` (so `sum`), `length` (so `count`) or `find` (so `any`, `all`) over `map` and `filter` stages of a `range` or a list becomes one `loop` whose state is the position, the accumulator and the captured values (`src/fuse.rs`), so no intermediate list is built. Fusing interleaves the stages, so it is done only when the stages are pure and terminating and can raise at most one trap message between them: then which stage traps first cannot be seen. `find` stops early, so its stages may raise none. `iter.to-list` over `iter.map`, `iter.filter` and `iter.take` is a loop too: iterators are lazy, so the order is unchanged and any stage may fuse |
| Higher-order primitives | `map`, `filter`, `fold`, `fold-right`, `take-while`, `drop-while`, `zip-with` and `loop` called with a known function that captured nothing compile to `fwp_k_*` (runtime/fwp_rt_prims.c), which take a C function pointer and are always inlined, so the function is called directly. A known function applied to captured values (`map (mul 3)`) gets a specialized loop of its own, `fwp_hof<i>`, which takes the captured values and calls the function directly (`opt::specialize_hofs` in `src/opt.rs`, `hof_def` in `src/cgen.rs`); compiled dynamic calls use `fwp_apply_owned` with typed captures; runtime callbacks use the shared `fwp_apply` entry |
| Records that do not escape | A record bound to a local and read only through its fields becomes one local per field (`only_fields` and `replace_fields` in `src/opt.rs`), and copies of locals and constants are propagated, so the tuples that `curry`, `uncurry` and `curry3` build are never allocated. A `match` on `map.get` branches on the lookup without building the `Some` (`lookup_match` in `src/cgen.rs`) |
| Records in registers | A direct call passes a record of up to eight fields as its fields when the callee reads it only field by field, and a function returning such a record returns a C struct (`fwp_r<n>`: two fields come back in registers, more in the caller's stack frame, which the C ABI provides). A record of more than four fields is returned so only by a function whose every tail builds one, so that one it passes on is not read into a struct and built again (`wide_record_returns`). Its caller reads the struct's fields when it only reads fields (`let`, `.i`, a tail call), so recursion over pairs allocates nothing. Each such function has a worker with this convention (`w<id>`) and keeps its usual entry (`f<id>`), which boxes, for closures and primitives (`Abi` in `src/cgen.rs`). A function whose every tail builds a variant of a non-recursive type with up to eight fields per constructor (`Option`, `Result`, a parser's token), or calls such a function, returns its tag and fields as a struct (`fwp_u<m>`, `variant_returns`); a caller that only matches on the result keeps it as one, counting the fields' references by tag (`fwp_vdup<k>`, `fwp_vdrop<k>`), and any other builds it (`fwp_vbox<k>`). Lists and trees are left out, as their nodes are rebuilt in the cells of the old ones. `FWP_VRET=0` when compiling turns it off |
| Reuse in place | Counted references free what compiled code gives up and find records with a single reference, so that an update writes into the record instead of copying it, as in Perceus's "functional but in place". `src/rc.rs` makes ownership explicit in the IR: `Dup` and `Drop` of locals of record, variant, array, map, set, String, Bytes and function types (unknown runtime boundaries still share), with functions and constructors owning their arguments and primitives borrowing them, and a local dropped as soon as the rest of its scope does not use it. A checker (`rc::check`) verifies every path of every function, and debug builds check every program. Native code keeps a count per object in the collector's metadata (`fwp_rc_*` in runtime/fwp_rt_gc.c): records and variants it allocates start unique, and whatever it hands to the runtime (unmodeled primitives, retained callbacks, other threads) becomes shared with everything it reaches, so counts are never too low. A unique, young record is updated in place, and the cell of a unique variant or record that a function drops is reused by a constructor of the same size that follows (`FnGen::reuse_token`): a function written in fwp that rebuilds a tree or a list writes each new node into the old one. `array.set` and `array.push`, `map.insert`, `map.remove` and `map.update`, and `set.insert` and `set.remove` own the array, map or set they are given (`rc::prim_consumes`) and write into it when it is unique, at any age (these are objects of kind 2, which every minor collection scans), an insertion growing it by doubling; the primitives that make them give them counted, those that only read one leave it unique (`rc::prim_reads_only`), and the last reference to an object holding them gives up their references (`fwp_rc_last`). A loop of 100 000 pushes or map insertions went from O(n²) to O(n). An eligible object compiled code gives up its last counted reference to is freed at once at any age; record updates/reuse retain their young-cell restriction: the drop functions generated per type (`Gen::drop_id`) give up the references it holds, by their types (a list's tail in a loop, not by recursion), and return its cell to the free lists (`fwp_rc_free_obj`); objects the runtime shares, and those off the heap, are left to the collector. A program that builds and walks a tree 200 times went from 33 collections and a 37 MiB heap to none and 2 MiB. `FWP_FREE=0` when compiling leaves freeing to the collector. `FWP_REUSE_VERIFY=1` poisons such a record instead of reusing or freeing it, and the tests run every program both ways (`tests/reuse.rs`). `FWP_REUSE=0` when compiling turns it off |
| Typed locals | Every IR function records the type of each local, its parameters first (`Func::locals` in `src/ir.rs`). Monomorphization gives them, the optimizer and fusion keep them as they add locals, and debug builds check after each pass that each local's type agrees with what it is bound to (`ir::check_locals`). They are what a value's size and layout are read from |
| Known constructors | After inlining, a match on a value whose constructor is known (`Some x`, a record of locals) selects its arm and binds the fields to the arm's names, so the value is never built. A match on a match whose every arm ends in a constructor (`half \| option.unwrap-or 0`, with `half` returning `Some` or `None`) first moves into those arms, as long as the copies are small (`case_of_case` and `known_ctor` in `src/opt.rs`): a loop over such a call went from 153 MiB allocated and 164 ms to nothing and 22 ms |
| Dead functions | After inlining, most instances of small combinators (`fork`, `curry`, `const`) are reached by nothing. The C backend generates code only for the functions reachable from `main`, the tests, the exports and the served methods (`live_functions` in `src/cgen.rs`); the others keep their place in the function table, without code |
| Primitives | A fixed set of primitives, implemented twice: in Rust (`src/prims_std.rs`, `src/web.rs`, `src/linalg.rs`, …) and in C (`runtime/fwp_rt*.c`). Everything else in the standard library is fwp code in `lib/` |
| Polymorphism | Explicit and static: only a signature makes a definition generic, and whole-program monomorphization compiles each use to its own code. Traits resolve statically; there is no dictionary passing. Polymorphic recursion is rejected. See [Generics](#generics) |
| Values on the stack | A record, variant or closure (a known function applied to fewer arguments than it takes) that does not escape lives in the C stack frame of the function that builds it: its local is read through fields, matched, copied with fields replaced, applied (which hands the function the closure's captured values, never the closure), or passed to a parameter that does not escape either (`src/escape.rs`, a fixed point over all functions), and never returned, stored, captured or given to a primitive. Its fields are on a stack the collector scans. The wrapper has no heap count slot; generated code tracks owned child references for eligible stack locals, aliases and consumed calls, and preserves their addresses through allocation. Unknown child types retain the fallback. A value the function builds is not passed to the function itself (a tail call becomes a jump that reuses the frame), while a parameter passed on to it may be (it lives in a caller's frame). `FWP_STACK=0` when compiling turns it off |
| Memory | Native programs have a generational, non-moving mark-and-sweep collector with conservative roots (`runtime/fwp_rt_gc.c`, see [Runtime](#runtime)); with `--memory static` its heap, a `malloc` pool and every stack are mapped once at startup (`runtime/fwp_rt_static.c`, see [Static memory](reference.md#static-memory)); WebAssembly builds allocate from a bump heap that is never freed. The interpreter uses Rust reference counting |

Merged synchronous callback entries borrow typed inputs and return owned results;
map/filter own fresh spines and results without promoting input elements to sharing.
Other callback/runtime and exceptional ownership extensions are prepared separately.
Consult [the current handoff](development-state.md) and [the immutable queue](roadmap-queue.md)
for their exact status; prepared changes are not merged support.

Compiler reuse tokens clear dead fields before retaining empty young cells,
transfer into compatible constructors and release unused cells. Registered token
cleanup handles failure, trap and cancellation, and unlinks before tail calls.

The runtime cleanup stack releases registered owners and scoped files before
nonlocal failure, trap or cancellation invalidates their frames. Catching
handlers bound cleanup, and task switches preserve separate chains. Compiler
registration of all owned references remains prepared work.

Prepared runtime application cleanup protects consumed functions, pending typed
arguments and original stack captures through nonlocal unwind. It adds a typed
pending-argument drop pointer to owned-function metadata (eight bytes on 64-bit
targets); programs without possible unwind omit runtime registration. Scalar
words stay uncounted. Prepared loop cleanup similarly protects counted current
state at cancellation safe points and owned Step payload preparation. Sequential
full CI is still required.

Prepared resource lifetimes and storage are summarized in
[ownership](ownership.md#original-resource-semantics). The queue records immutable
branches and the handoff records acceptance; these are not merged ARC support.

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
  composition. If the left side is still unknown when the binding's
  types are solved, it defaults to application.
- `match` builds a function. Patterns never bind names; each `_` hole is
  passed to the arm's body as a curried argument, left to right.
- `quote` turns an expression into a `Syntax` value and `name!(…)` calls a
  macro. Tacit code has no local binders, so the only possible capture is
  at module level, and quoted names are qualified with their module.

## Types and effects

- Hindley–Milner inference with levels. Records and effects share one row
  unifier. Only signatures generalize: see [Generics](#generics).
- Calls reopen only their own closed effect row after argument unification,
  allowing callee effects in a larger ambient context without contaminating
  function-valued argument types. Pipe application, composition and ordinary
  application use this rule; required callback effects remain checked.
- Tuples are records with numeric labels, and unit is the empty record.
- Nominal records are distinct from each other but unify structurally with
  open rows, so `.name` accepts both `User {…}` and `{name = "x"}`.
- Higher-kinded parameters work through variable-headed application
  (`F[A]`). Type-level naturals (`Vector[F64, 3]`) may be sums and
  products of sizes (`n + m`, `m * n`, `Type::NatOp`). They unify as
  polynomials: equal polynomials unify, an equation in one unknown
  (`v + 2 = m + 3`) solves it when its value is a natural, and an
  equation still undecided is deferred and checked when the definitions
  of its group are (`Infer::check_sizes`). Monomorphization turns every
  size into a number.
- A size known only when the program runs is abstract: `_` or `_n` in
  the result of a signature (`vector.from-list : List[t] -> Vector[t,
  _]`). The definition chooses it; for callers it is rigid. In a
  function's result it is a marker (`TypeTable::markers`) that each call
  replaces by a fresh rigid size (`open_call`), so two calls give
  different sizes. A composition or `match` re-marks the sizes its body's
  calls chose (`Infer::reabstract`), since it runs them once per call. A
  marker bound anywhere but a function's final result would be shared by
  many calls, which is an error (`UnifyError::Abstract`). Sizes are
  phantom, so monomorphization gives abstract ones no number.
  Performance: abstract sizes move checks to run time — `vector.same-size`,
  `matrix.same-shape` and `matrix.as-square` compare lengths and return an
  `Option` that the program must take apart — where a static size costs
  nothing.
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

## Generics

Polymorphism is explicit, as in Odin, and every generic is resolved at
compile time.

- A top-level definition is generic only when its signature has type
  variables:

  ```fwp
  swap : (a, b) -> (b, a)
  swap = both .1 .0

  sum-squares : List[a] -> a where Add[a], Mul[a], Zero[a], Dup[a]
  sum-squares = map (fork mul id id) | fold add zero
  ```

  Inference still works inside every definition and along every pipeline.
  It never makes a definition generic on its own.
- A definition without a signature is monomorphic. A type left open only
  by a literal takes the literal's default (`I64` for an integer, `F64`
  for a float), as it does for values: `inc = add 1` is `I64 -> I64`.
  Any other type or record row variable is an error at the definition,
  and the error gives the inferred signature to write
  (`explicit_generics` in `src/infer.rs`):

  ```
  error: `square` would be generic, but it has no signature
    note: generics are explicit: write `square : a -> a where Mul[a]`
          to make it generic, or a signature with concrete types
  ```

  `main`, tests, the REST entry point and macros are exempt. The first
  three are values whose open types are `()`, and a macro's type is
  checked where it is expanded.
- Effect row variables are generalized without a signature. Effects are
  erased before code generation, so a function that is polymorphic in
  its effects is still one function.
- Generics are a zero-cost abstraction. The monomorphizer gives every
  instantiation its own function, with its types known, so the C backend
  generates typed scalar code and direct calls. Nothing is boxed or
  erased, as Java erases its generics, and no dictionary of methods is
  passed, as Go passes one to code shared by types of the same shape.
  Trait methods are resolved at compile time. A definition that would be
  instantiated at unboundedly many types (polymorphic recursion) is
  rejected.

Why: Haskell generalizes every definition it can and solves constraints
by passing dictionaries at run time. GHC then needs a large optimizer
(specialization, inlining, worker/wrapper) to win the performance back,
and pays for it in compile time. Its type errors also surface at a use,
far from the definition that was too general. GHC's own designers
stopped generalizing local definitions (`MonoLocalBinds`, after
Vytiniotis, Peyton Jones and Schrijvers, *Let Should Not Be
Generalised*, 2010), and it keeps the monomorphism restriction and
defaulting for top-level ones. fwp has no local definitions, and with
this rule it has no implicit generalization at top level either. Each
generic in a program is one the programmer wrote down. Monomorphization's
cost is code size, so explicit generics keep that cost visible.

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
  its end.

  Collection is generational without moving anything: mark bits are kept
  from one collection to the next, so an object that survived one is old.
  Most collections are minor: they mark from the roots without tracing
  into old objects and free only young garbage, so they cost what the
  young survivors cost, not the whole live heap; a major collection clears
  the marks and traces everything when the heap kept since the last one
  has grown by half. This needs old objects never to point to young ones,
  which holds because fwp values are immutable, with the help of a split
  by kind: records, variants and list cells are complete when allocated
  (`fwp_alloc_init`) and never written again, while memory that is filled
  after other allocations (arrays, maps, partial applications, temporary
  arrays, runtime structures: `fwp_alloc`) is scanned whole by every minor
  collection once it is old. The only write to a complete value in
  generated code, a record update, computes its new fields before copying.
  On a program that builds a map and churns through lists, minor
  collections cut the time spent collecting from 850 ms to 250 ms.

  A collection starts when the bytes allocated since the last one exceed
  the live heap (twice it without generations; 8 MiB at least); free
  chunks beyond a reserve are given back to the system. `FWP_GC=off`
  disables collection, `FWP_GC=full` makes every collection major,
  `FWP_GC_STATS=1` prints statistics at exit and `FWP_GC_STRESS=n`
  collects at every n-th allocation. `tests/gc.rs` runs every golden
  program with a collection at each allocation and `FWP_GC_VERIFY=1`,
  which checks each minor collection against a full trace from scratch
  and stops at the first reachable object it did not mark. WebAssembly keeps
  a bump allocator that never frees, because values in WebAssembly locals
  are invisible to a stack scan; libraries (`--staticlib`, `--cdylib`)
  use the collector's allocator but never collect, since the host's
  stacks are unknown. Linux finds program data segments with
  `dl_iterate_phdr`; the Darwin implementation finds the Mach-O image
  containing the runtime and scans its writable-at-load segments, including
  `__DATA_CONST` and zero-fill storage. Other native systems do not arm
  collection. Darwin validation is tracked in the session handoff.
  Runtime value/string constructors and list traversals keep their source
  objects/buffers reachable until the last allocating operation: `FWP_KEEP_ALIVE` is a compiler lifetime fence.
  Optimized Clang can otherwise preload a short buffer and discard its
  only root while its elements are still needed.
- Reverse-mode autodiff records operations on tapes kept by the runtime
  outside the program's values (numbers only), and tensor kernels run on
  OS threads that never touch the collected heap; both are implemented
  twice, with the same operation order (`src/numerics.rs`,
  `runtime/fwp_rt_kernel.c`, see [numerics.md](numerics.md)).
- Native tasks are green threads on an event loop: epoll on
  Linux, poll elsewhere. glibc uses `ucontext`; musl and Darwin use the
  runtime's custom x86-64/AArch64 context switch, with ELF and Mach-O
  symbol/directive conventions respectively. Interpreter tasks are OS threads that pass a
  baton, so only one runs at a time. Function-entry preemption preserves
  deterministic ready-task interleaving across backends; relative wall-clock
  timers do not establish an order between independent effects. Use channels
  or awaits when output order matters.

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
| `--cli` | every exported function exposed as `cli` (`# expose:`, read with the doc comments in `src/cli.rs`) as a subcommand of one executable. `src/cli.rs` computes the command line of each function (flags from an options record, positional arguments, defaults evaluated with the interpreter at build time) and its help and usage texts once; the C runtime (`runtime/fwp_rt_exec.c`) gets them as static data and parses arguments with the same rules as `src/exec.rs`. See [cli.md](cli.md) |
| `--rest` | every exported function exposed as `rest` as an endpoint of one HTTP server. `src/rest.rs` computes the endpoints from the types and doc comments (routes, where each argument comes from, statuses) and `src/openapi.rs` the OpenAPI document; the file is then compiled again with a generated `main` (`Roots::entry`) that serves `rest.endpoint`s of `lib/rest.fwp` over the HTTP server of `lib/http.fwp`, with authentication (`rest.secured` and the file's `authenticate`, compiled by name: `Roots::names`), time limits, CORS, forms and `multipart/form-data` bodies (`RestSource.Content`), content negotiation (`rest.endpoint-as`) and an HTML page of the document, all in fwp. `fwp openapi --import` reads JSON and YAML (`src/yaml.rs`, a YAML 1.2 reader of its own) and converts Swagger 2.0 to OpenAPI 3 (`src/swagger.rs`). Arguments and results go through the typed JSON codec (`json.read`, `json.write`), a primitive written twice: `src/jsontype.rs` over types, `runtime/fwp_rt_json.c` over type descriptors. See [rest.md](rest.md) |
| `--fat` | one copy of the program per x86-64 CPU level, chosen at startup |
| `--mcp` | every exported function exposed as `mcp` as a tool of a stateless MCP server (protocol 2026-07-28). `src/mcp.rs` derives each tool's arguments and JSON Schemas from its type (the schemas of `src/openapi.rs`, under `$defs`), and the results of `server/discover` and `tools/list`; as with `--rest`, the file is compiled again with a generated `main` that calls `mcp.serve` of `lib/mcp.fwp`, where the protocol (JSON-RPC, the version check, the stdio and HTTP transports) is written in fwp. See [mcp.md](mcp.md) |
| `--service m` | the program split into gRPC services: a server executable for each named module, and a main executable whose calls to those modules' exported functions are remote. `src/rpc.rs` derives each function's messages and streams from its type (`Iterator`, `Channel`) and the `.proto` text; the transport runs on the task scheduler: `src/grpc.rs` for the interpreter, `runtime/fwp_rt_grpc.c` natively. The monomorphizer replaces each such call with a client stub (`Body::Remote`); see [services.md](services.md) |
| `--staticlib`, `--cdylib` | a C library and header for the exported functions |
| `--target wasm32-wasi`, `wasm32-browser` | WebAssembly through clang; `setjmp`/`longjmp` use the WebAssembly exception proposal. Effects the target lacks (`Network`, `Process`) are compile errors. Tasks are fibers (`FWP_FIBERS` in `runtime/fwp_rt_task.c`): the scheduler is the native one, but `swapcontext` becomes a call to a hook that the JavaScript host installs in the function table (`web/fibers.js`), which suspends the calling fiber with JavaScript Promise Integration and resumes the next one; each task has its own 1 MiB region of linear memory for C's stack, and the stack pointer is saved and restored around each switch. Waiting for a timer with every task parked is another hook, a JavaScript timer |
| fwp itself, `--target wasm32-wasip1` | `cargo build --release --target wasm32-wasip1`: the compiler and interpreter as one WASI command, `fwp.wasm`, which the playground (`web/`) runs in a web worker through a small WASI written in JavaScript (`web/wasi.js`). There are no threads, so `with_big_stack` runs inline on a 512 MiB stack set at link time (`.cargo/config.toml`), and a program that uses `Network`, services or foreign C functions is rejected after lowering, before it runs (`driver::wasm_host_unsupported`), as the `wasm32-wasi` target rejects it. Tasks run on fibers (`src/fiber.rs`, with the same hooks as compiled programs): `World::park` switches to the next ready fiber instead of handing a baton between threads, in the same order, and traps on a deadlock. The interpreter's frames in linear memory are large (about a kilobyte per call), so the fibers of tasks share one 32 MiB stack region: a fiber that suspends copies out the part it uses, and copies it back when it resumes. Without JSPI, a program that uses tasks is rejected before it runs, unless fwp.wasm was built with `scripts/build-playground.sh --asyncify`. Commands that compile C or start processes report that they are unavailable. Stdout is line-buffered there, so the output before an engine stack overflow is kept; values are dropped iteratively, so long lists do not need a deep stack |

## Not implemented

- Complete ownership of strings, bytes, escaping closures and runtime-shared
  values; general execution without tracing GC. Narrow packed numeric arrays,
  broader typed aggregate ABIs and scoped view lifetimes are planned in
  [ownership.md](ownership.md). C structs alone do not guarantee registers.
- Darwin cross-compilation and universal binaries, Clang PGO, and Windows.
  Native macOS passed both architecture suites and the Linux/benchmark gates
  in PR #74; exact verification is recorded in [the handoff](development-state.md).

- HTTP/3; HTTP/2 server push and
  WebSocket over HTTP/2 (RFC 8441); WebSocket extensions other than
  permessage-deflate, and its context takeover; content codings other than gzip and deflate
  (streamed responses: gzip only). REST bodies are JSON, forms and
  `multipart/form-data` in, JSON, text and CSV out, read and written
  whole (no XML, no streaming bodies).
- TLS of fwp's own: TLS uses the system's OpenSSL 3 ([tls.md](tls.md)),
  which native programs that use it link and the interpreter loads at run
  time, with client certificates (mutual TLS). DTLS and QUIC are not
  implemented.
- Sockets and foreign C functions in the WebAssembly build of fwp (the
  playground): a browser has neither sockets nor a C compiler. Tasks on
  WebAssembly need JavaScript Promise Integration, or binaryen's
  Asyncify (`--wasm-async=asyncify`, and
  `scripts/build-playground.sh --asyncify` for fwp.wasm); WASI runtimes
  without a JavaScript host run no tasks.
- A JIT, and distributed execution (tensors sharded across processes,
  collectives). Reverse-mode autodiff and devices for fused tensor
  kernels (CPU threads, OpenCL loaded at run time) exist
  ([numerics.md](numerics.md)), but the OpenCL path has only been run
  without an OpenCL device; kernels are elementwise expressions and sums.
- Transports of the pipe protocol other than the pipe, `UDS_V1` and
  `SHM_V1` (which are Linux only), the WebAssembly component model and
  `wasm64`.


## Prepared ownership implementation

Compiler call ownership lowering must preserve allocation optimizations as well
as exceptional lifetimes. Earlier counted arguments, including duplicated
locals, stay registered while later arguments evaluate. A final consumed value
can stay inline when no earlier counted argument needs protection, preserving
direct stack, worker and flattened-loop representations. Existing allocation
limits and raw-interpreter comparisons remain acceptance gates.


Prepared record-worker calls keep returned locals as fields when every use is a
field read or a complete call with the matching record ABI. Typed aliases and
trap cleanup preserve field owners; partial and dynamic calls retain boxed
captures. The ordinary worker/wrapper ABI is unchanged. Sequential full CI
is still required; emitted box removal alone is not a speed claim.


[Ownership](ownership.md#prepared-ownership-work) summarizes prepared contracts
and acceptance limits; [the handoff](development-state.md) records current checks.
Original ResourceRegion markers preserve source resource lifetimes through
optimization. Eligible original record holders use typed fields; variants use
fwp_u structs with existing tag-aware vdup/vdrop helpers. Incoming owners remain
protected during partial retains, and frame assignment follows successful retain.
Cleanup IDs are captured after helper generation, which can add definitions.
Pattern bindings initialize payloads/fields from the current path's scrutinee.
FWP_FRAME_FIELDS=0 preserves the boxed comparison path.

Prepared match elimination carries nominal constructor-field context into
effectful discarded temporaries. If elimination cannot recover a safe type,
it preserves the original typed binding rather than erasing its ownership.
Inlined record projections similarly preserve the checked base type through
scalar replacement so discarded nested children keep their typed destruction.
Prepared nested loop reconstruction keeps compatible nested records as flat
state slots through Again updates. Reading a whole record reconstructs it with
typed children; progressive retains and completed fields remain protected until
boxing succeeds. Field reads that can reconstruct records participate in caller
liveness cleanup. Scalars remain uncounted; sequential full CI is required.

Prepared CAF ownership retains a typed cache owner and returns a separate
owner on each call. Initialization retry and reentrant replacement preserve
callers; executable teardown releases caches after finishing tasks. CAF
evaluation is a call safe point that protects existing caller owners.
Inlining treats a zero-argument function as an evaluation, preserving unused
argument evaluation and trap order rather than duplicating or erasing it.
Prepared task.spawn retains counted thunks until entry or cancellation.
Fallible stack/scope preparation protects only the extra owner and publishes
a task after preparation succeeds. Unknown closure metadata retains sharing;
task results still use the shared graph fallback at this stage.
Prepared deadline callbacks use the same retained owner through completion
or cancellation and preserve external capture aliases.
Prepared task.scope borrows its callback and protects its owned result
through joining/cancellation checks; unwind cleanup restores handlers and
scope state and releases scope storage.
A later prepared task-handle contract owns typed cached results, with
independent scheduler, scope, caller and await references; unknown/shared
boundaries retain tracing fallback.
Prepared typed channels own queued elements and transfer their references
into receive results after successful Option allocation. Close preserves
queued values; unknown sink/runtime boundaries still share, and cycles
require the explicit lifetime policy described in ownership.md.
Prepared TLS listener ownership retains server context and ALPN state through
accepted sessions, including raw HTTP/2 transfer. Listener stop releases its
owner; the last session releases the context and protocol storage.
Prepared library teardown finalizes Files, sockets and transferred HTTP/2
handles before releasing TLS client caches; implicit session disposal avoids
network shutdown traffic and preserves host signal policy.
The RC match preparation recovers missing nominal context from a whole-value
pattern's typed local, using it for scrutinee conversion and temporary destruction.
Known expression types remain authoritative. Whole-value pattern aliases of
stack aggregates retain/drop their typed children, preserving them when the
scrutinee releases its ownership. No new surface syntax is introduced.
Prepared original resource-frame holders keep eligible field-only records in
typed fields, avoiding a parent heap box while retaining children for the
original frame lifetime. Other bindings retain the boxed parent.
FWP_FRAME_FIELDS=0 provides an allocation comparison; partial field retention
must unwind safely. This preparation supplies no general speed claim.
Prepared File layout stores FILE*, a uint64 owner count and a NUL-terminated
inline path in one aligned leaf allocation. The checked path length includes
header and terminator. On 64-bit hosts the header is 16 bytes rather than
24 bytes; constructor allocation controls and display/I/O agreement are
required. This reduces layout/allocation overhead without a timing claim.
Prepared last-owner File disposal removes weak library finalizers before
reclaiming unshared native storage. Shared, bump and disabled-free storage
keeps its allocator lifetime. Scoped cleanup closes while its constructor
owner is live, then drops that owner; aliases must never see reclaimed storage.
Prepared original variant holders use tag-aware typed structs for eligible
matched bindings. Retain incoming payloads completely before replacing a frame
slot; cleanup dispatches only the active tag. Boxed fallback retains payloads
before dropping the wrapper. Generate cleanup IDs after helper generation,
which may add nested cleanup definitions. FWP_FRAME_FIELDS=0 compares boxing.
Prepared whole-pattern variant bindings initialize fresh typed holders from
the current scrutinee on each binding path. A local used by a let in another
arm must not supply that payload. Partially failed patterns preserve original
frame lifetime rather than releasing their File bindings early.
Prepared record pattern holders likewise initialize typed fields from their
current scrutinee before anchoring the original frame owner. A field mapping
created by a let on another arm must not supply these borrowed fields.
Prepared HTTP/2 body copying keeps its borrowed call owner live through
allocation. The stream buffer uses malloc, so its bytes alone cannot root
the GC-managed stream. Forced major collection and finalizer omission controls
verify this boundary; HTTP/2 handles still retain the tracing compatibility policy.
Prepared HTTP/2 body bounds clamp negative limits to zero, matching the
interpreter. Check size before completion, then reset/dead state, then timeout;
an empty completed body succeeds at a zero limit even if the stream reset.
File storage/finalizer, WASM logical counts, nested holders and graph/cycle work
remain subject to full sequential CI and the ownership acceptance criteria.

Prepared network ownership uses the existing unwind cleanup stack. HTTP/2
peer subject temporaries stay owned until String/Option copying finishes.
HTTP/2 handles and GC-managed connection/context storage retain tracing
compatibility; these preparations do not establish complete ARC support.

Served gRPC peer metadata has a logical owner for its serving task and each
detached sender that can invoke language code. A nonallocating, nonthrowing
completion callback releases its owner after structured child joins; the last
owner frees peer metadata and any stored status. Acquisition checks overflow
and unwinds failed spawning. Stored status replacement copies before dropping
the prior owner, including aliased input. Final encoding owns transferred text.

Server and client receive paths own dequeued malloc messages and copied status
text through decoding, subsequent waits and callbacks. Extra/malformed responses,
cancellation and decoder failures release scratch. Normal returns transfer only
the requested message, value or error text; cell forcing preserves its memo.
Retry releases copied reset text before reopening. Client failure raising copies
raw trap or typed GrpcError contents before releasing its transferred text;
the receive owner clears that text slot to prevent a second release. Reflection
releases copied end status, and streamed error rendering owns partial buffers.

Encoded frame buffers, detached and synchronous client request buffers, and
served unary/stream/error response buffers keep cleanup active across encoding
and cancellable flow-control waits. Canonical serialization scratch is owned
before writing/transcoding and released after success or unwind. Wire bytes,
plain/gzip payloads, fixed-width representation, oneof prefixes, diagnostics,
receive order and error/trap order remain unchanged.

These are prepared contracts, subject to sequential full platform/GC CI.
[Primitive ownership](primitive-ownership.md#prepared-refinements) records individual
acceptance controls; [the handoff](development-state.md) records delivery status.
Prepared pending gRPC connections also own lookup results, descriptors and
SSL state across connection/handshake suspension, transferring them after
connection-wrapper creation. Background startup has a temporary connection
owner and a protected reference reserved for each task; abort marks the
unpublished connection dead without allocating, cancels published tasks and
drops its owner. The last task releases the descriptor. Its static failure
marker is excluded from malloc finalization. Dynamic context callbacks use
the same cleanup stack to restore the saved task context on raw traps and
cancellation, retaining existing normal/typed-error restoration and handler
boundaries. Scoped TLS options have checked dynamic-scope and inheriting-task
owners; the last user releases copied strings and option storage without
tracing. Task preparation protects acquired context owners, and completion
releases the original retained context after child joins even if current
gctx changed. These hooks and one private pointer compile only for service/
web programs. Read-once environment options keep their cache lifetime; context
wrappers retain tracing compatibility. Response metadata captures also retain
constructor, scope and inheriting-task owners; the last owner frees headers
and their storage. Returned metadata is a snapshot, independent of later
child appends. Both resource counters validate before acquisition changes
either, and constructors protect resources if acquisition traps. TLS pool
keys use checked length framing and complete bytes rather than delimiter
serialization through a fixed diagnostic buffer; connections copy keys so
scoped options can be released independently. Read-once environment TLS
caches release on library teardown after tasks drain and GC finalizers finish,
before SSL cache disposal. Cache and hook state reset for reinitialization.
Prepared packed TLS options use one checked allocation containing an aligned
header followed by strings and the full length-framed key. Child string/key
pointers are borrowed within that allocation; last-owner release frees its
base once. Focused remote checks are pending, so allocation reduction is not
yet verified support. Full connection addresses also use checked tail storage
within the existing managed connection allocation, preserving complete pool
keys without separate address allocation. Connection wrappers retain tracing
compatibility. Canonical decode already frees temporary C buffers on normal
success/error exits; typed ownership of reconstructed aggregates remains an audit.
