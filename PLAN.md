# fwp ("foop") — Implementation Plan

fwp is our implementation of the *Pipe Language Compact Specification*. The
language is renamed to **fwp** (pronounced "foop") to avoid clashing with other
languages called "pipe". Source files use the `.fwp` extension, and the
compiler binary is `fwp`.

This plan covers delivery in **12 PRs**. Each PR leaves `main` green and adds a
usable vertical slice. The PRs build on each other, but several of the later
ones (8–12) can be developed in parallel once PR 7 lands.

---

## 1. Guiding decisions

The spec states goals but leaves much of the concrete syntax and semantics
open. The decisions below fill those gaps. They are binding for the
implementation unless revisited in a PR.

### 1.1 Implementation strategy

| Concern | Decision |
|---|---|
| Host language | Rust (stable toolchain), no third-party crates in the compiler core |
| Pipeline | `lex → parse → macro-expand → resolve → infer (types + traits + effects) → monomorphize → typed IR → optimize → {interpret, C codegen}` |
| AOT backend | Typed IR → portable C11 → system `cc`/`clang` → native executable. LLVM is avoided at first: C gives native and WASM (`clang --target=wasm32-wasi`) through one backend |
| Interpreter | Runs the *same* mono IR. It powers `fwp run`, `comptime`, macros and the test oracle, so the C backend is always differentially tested against it |
| Builtins | A small fixed set of `prim.*` primitives, implemented twice (Rust interpreter + C runtime). Everything else in the stdlib is written in fwp in `lib/`. Combinators (`id`, `const`, `flip`, `fork`, …) are defined as IR templates, so both backends get them for free |
| Polymorphism | Whole-program **monomorphization**. Traits resolve statically and there is no dictionary passing. Polymorphic recursion is rejected |
| Memory (v1) | Region/arena allocation: a program-lifetime arena plus explicit `arena.scope`. Region inference and affine-driven frees come later (see §4) |

### 1.2 Syntax decisions

* **Comments** use `#` to end of line, so `#!/usr/bin/env fwp` shebangs work.
* **Identifiers** are `lower-kebab-case`. A hyphen is allowed between letters,
  as in `route-spec` or `all-reduce`. Because a hyphen can't start an
  operator, there is **no infix arithmetic**.
* **Qualified names** are written `wrapping.add`, `http.server`, `Json.Null`.
  Uppercase names are types and constructors. An unknown single-letter
  uppercase name in a type (`T`, `M`, `K`) is an implicit type variable.
* **Selectors** are `.name`, `.0`, or a chain such as `.address.city`. They are
  ordinary functions.
* **Layout:** a top-level declaration starts in column 1, and any indented line
  continues it. `match`, `trait` and `impl` blocks use an offside rule. A
  braces-and-commas form is accepted everywhere for one-liners.
* **Data-last argument order:** `x | sub 1` means `x − 1`, and `x | lt 5`
  means `x < 5`. Every stdlib function takes its "subject" last, which is what
  makes `|` read naturally.
* **Pipe meaning** is decided by the type checker:
  * If the left side is a value, `x | f` means `f x` (application, a shell
    *producer*).
  * If the left side is a function, `f | g` means `g ∘ f` (composition, a
    shell *filter*).
  * If the left side's type is still unknown when the binding is generalized,
    the checker defers the choice and defaults to application.
* **Tacit pattern matching:** `match` builds a *function*. Patterns never bind
  names. Instead, every `_` hole is passed to the arm's body as a curried
  argument, from left to right. A bare constructor `Some` is shorthand for
  `Some _`. An arm with no holes yields its body directly.
  ```
  rec factorial = match
      0 -> 1
      _ -> fork mul id (sub 1 | factorial)
  ```
* **Declarations:**
  * `name : Type where C[T]` declares a signature.
  * `name = expr` and `rec name = expr` declare bindings. A self-reference or
    mutual reference without `rec` is an error.
  * `Name[T] = | A T | B` declares an ADT.
  * `Name = { f: T }` declares a nominal record.
  * `resource Name = …` declares an affine type.
  * `trait`, `impl`, `macro`, `import`, `export`, `foreign "C"`, and
    `test "name" = expr` are also declarations.
* **Literals:**
  * Integer and float literals are polymorphic and can carry an explicit
    suffix (`7u8`, `1.5f32`). Integers default to `I64` and floats to `F64`.
  * Balanced ternary literals look like `0t+-0-+`.
  * Duration literals look like `2s` or `150ms`.
  * Other literals are strings, lists `[…]`, tuples `(…)`, records
    `{a = 1}`, and nominal records `User {…}`.
* **Macros:** `quote expr` produces a `Syntax` value. A macro is invoked as
  `name!(arg, …)`. Because tacit code has no local binders, the only possible
  name capture is at module level. Quoted names are qualified with their
  defining module, which makes macros hygienic.
* **Reflection:** `type[T]` evaluates to a `TypeInfo` value. Typed macros and
  comptime code use it.

### 1.3 Type system decisions

* **Inference** is Hindley–Milner with Rémy-style levels. Records and effects
  both use one row-unification engine.
* **Tuples** are records with numeric labels (`(a, b)` ≡ `{0: a, 1: b}`), so
  `.0` and `.1` are ordinary row-polymorphic selectors. Unit is the empty
  record.
* **Nominal records** are distinct from one another, but they unify
  *structurally* with anonymous rows. So `.name : {name: a | r} -> a` accepts
  both `User` and `{name = "x"}`.
* **Higher-kinded types** work through var-headed type application
  (`F[A]`). Type-level naturals (`Vector[F64, 3]`) unify by equality.
* **Traits** are multi-method, with superclasses and parameterized impls.
  * Structural classes are solved automatically: `Eq`, `Ord`, `Hash`,
    `Display`, `Encode`, `Decode`.
  * The literal classes `IntLit` and `FloatLit` fall back to the `FromInt` and
    `FromFloat` traits. This lets `Dual[F64]` accept literals.
* **Effects:**
  * Every arrow carries an effect row: `A -> B ! {IO, Error[E] | e}`.
  * A closed row in a signature is opened (given a fresh tail) when the
    signature is instantiated, which gives subeffecting.
  * Handlers remove labels through row unification, for example
    `attempt : (a -> b ! {Error[x] | e}) -> a -> Result[b, x] ! e`.
  * Only the *final* arrow of a binding may be effectful, so effects happen
    exactly when a call is saturated.
  * Top-level non-function bindings must be pure. `main` and `test` are the
    exceptions.
* **Monadic pipes:** effects run in direct style (sequencing *is* bind).
  `try : Result[a, x] -> a ! {Error[x] | e}` bridges values to effects.
  `Error[E]` is implemented by the runtime as a delimited abort: `Result` in
  the interpreter, and `setjmp`/`longjmp` in C. It is not a user-visible
  exception mechanism.
* **Affine resources:** in tacit code, values flow linearly through pipelines
  by construction. Duplication happens only through combinators (`dup`,
  `fork`, `both`, …), and those require the structural class `Dup[T]`.
  `resource` types are not `Dup`. Capturing a resource in a partial
  application is rejected.
* **Numerics:**
  * All runtime numeric types have an explicit width.
  * Arithmetic is checked and traps on overflow or division by zero. Traps are
    unrecoverable aborts with a diagnostic, not exceptions.
  * Explicit alternatives live in `wrapping.*`, `saturating.*`,
    `overflowing.*` and `checked.*` (which returns `Option`).
  * There are no implicit conversions. Conversion functions are explicit and
    return `Option` when they can lose information.

### 1.4 Runtime and protocol decisions

* **Values in C** are 64-bit words:
  * Integers up to 64 bits are stored inline. 128-bit integers are boxed.
  * Floats are stored as their raw bits.
  * ADTs are boxed. A nullary constructor is stored as a small integer tag.
  * Closures are partial applications of a known function id: `{fn, arity, n,
    args[]}`. Tacit code has no free variables, so every function value is
    reifiable, which makes comptime results embeddable as static data.
* **Type descriptors** are emitted per mono type. They drive structural
  eq/compare/hash, `Display`, text parsing, and the binary protocol in the C
  runtime.
* **Text format:** `Display` output is byte-identical between the interpreter
  and C. Floats print the shortest round-trip form.
* **Exported functions as executables:**
  * Command-line arguments fill the leading curried parameters, parsed
    according to their types.
  * The last parameter comes from stdin.
  * If that parameter has type `T`, the function is mapped over input records
    (lines or frames), awk-style.
  * If it has type `List[T]`, all input is collected first. If it has type
    `Stream[T]`, input is streamed.
* **Typed process protocol (`PIPE_V1`):**
  * The stream header contains the magic bytes `FWP1`, a version, a
    capability list, a 128-bit type fingerprint, and the canonical type
    string.
  * Each frame is `kind:u8, len:u32le, payload`.
  * The payload uses a deterministic, type-directed little-endian encoding.
    Records are encoded in field order, ADT tags as LEB128, and lists as a
    count followed by the elements.
  * A consumer auto-detects the magic bytes on stdin. A producer emits binary
    when `FWP_OUT=bin` is set or when it is launched by `fwp pipe`.
  * A fingerprint mismatch is a hard error. There is no runtime cast.

---

## 2. Repository layout (target)

```
Cargo.toml
src/
  main.rs          CLI: run | check | build | test | eval | pipe | fmt-type
  lexer.rs  ast.rs  parser.rs
  macros.rs        expansion, AST <-> Syntax value conversion
  resolve.rs       modules, imports, qualified names
  types.rs         Type, rows, unification, schemes
  infer.rs         inference, traits, effects, resources
  mono.rs  ir.rs  opt.rs
  interp.rs  value.rs  prims.rs
  cgen.rs          IR -> C
  proto.rs         binary protocol + text format (Rust side)
runtime/fwp_rt.c, fwp_rt.h   C runtime (embedded with include_str!)
lib/               stdlib written in fwp (prelude.fwp, list.fwp, json.fwp, …)
tests/             golden tests: *.fwp + expected stdout, run on both backends
examples/          showcase programs
docs/              language reference + tutorial
```

---

## 3. The 12 PRs

Each PR lists its **scope**, **deliverables**, and **done when** criteria. "Both
backends" means a golden test passes on the interpreter and on the
C-compiled native binary with identical output.

### PR 1 — Skeleton, lexer, parser, `fwp check --parse`
* **Scope:** the Cargo project and CI workflow (`cargo test`, `clippy`,
  `fmt`), plus the full surface syntax from §1.2.
* **Deliverables:**
  * A lexer with layout info. It handles kebab identifiers, qualified names,
    selectors, all literal forms (suffixed numbers, `0t` trits, durations,
    strings), `#` comments, and the `name!(` macro-call token.
  * A recursive-descent parser covering:
    * expressions: application, `|`, tuples, lists, records, `with {}`,
      `match` (layout and brace forms), `comptime`, `quote`, `type[T]`,
      macro calls;
    * patterns with holes;
    * types: arrows, effect rows, row tails, `where` clauses, type-level
      naturals;
    * every declaration form.
  * The AST with spans. Diagnostics report `file:line:col`, show the source
    line, and print a caret.
  * `fwp check --parse` prints the parsed AST.
* **Done when:** the parser accepts every example in the spec (adapted to the
  §1.2 decisions). Snapshot tests cover the AST and the error messages.

### PR 2 — Core type inference
* **Scope:** HM inference, ADTs, records and tuples, rows, signatures, `rec`
  and SCCs.
* **Deliverables:**
  * The `Type` representation, with union-find over variables and levels.
  * Unification, including row unification, HKT application, nats, and
    nominal↔structural record unification.
  * Generalization and instantiation.
  * Dependency SCCs, with errors for non-`rec` recursion.
  * Skolemized checking of signatures.
  * Pipe-mode resolution (application vs composition, with deferred
    resolution).
  * `match` typing with holes, plus exhaustiveness and redundancy warnings.
  * Name resolution, including modules, `import`, and qualified constructors.
  * `fwp check` prints the inferred signatures.
* **Done when:**
  * Type-error golden tests (mismatch, occurs check, missing field, non-`rec`
    recursion) produce precise, located messages.
  * The inferred types of a corpus of tacit programs match their expected
    signatures.

### PR 3 — Traits, numerics, literals, structural classes
* **Scope:** traits, impls and superclasses with constraint entailment and
  defaulting. All sized numeric types, literal classes, and the structural
  classes (`Eq`, `Ord`, `Hash`, `Display`, `Dup`, `Encode`, `Decode`).
* **Deliverables:**
  * Constraint solving and generalization with predicates.
  * Range checks on literals.
  * `where` clauses.
  * The prim signature table for numeric primitives, and prelude traits
    `Add Sub Mul Div Neg Zero One Ring Field FromInt FromFloat Functor
    Applicative Monad`.
* **Done when:**
  * `double = mul 2` generalizes to `T -> T where Mul[T], IntLit[T]`.
  * Out-of-range literals are rejected.
  * Missing impls produce errors that point at the use site.
  * HKT `Functor[List]` and `Functor[Option]` type-check.

### PR 4 — Effects and resources
* **Scope:** effect rows on arrows, subeffecting by opening rows,
  handler typing, the final-arrow and pure-definition rules, and resource
  types and `Dup`.
* **Deliverables:**
  * Effect inference through application and composition.
  * Built-in effect labels: `IO FileIO Network Async Random State Alloc
    Error[E] Unsafe`.
  * Typing for `fail`, `attempt`, `try`, `or-fail`, and `run-state`.
  * The checks for resource capture and duplication.
  * The rule that comptime effects must come from an allowed set.
* **Done when:** golden tests show that:
  * a pure signature rejects `IO`;
  * `attempt` removes `Error[E]` from the row;
  * duplicating a `File` with `fork` is rejected;
  * effectful top-level values other than `main` are rejected.

### PR 5 — Monomorphization, typed IR, interpreter → `fwp run`
* **Scope:** the first end-to-end execution.
* **Deliverables:**
  * The mono worklist, keyed by concrete types (effects erased), with trait
    method → impl resolution.
  * IR: `Local, Func, Call, Apply, Prim, Construct, Field, With, Switch,
    Const`.
  * Eta-expansion to scheme arity.
  * Lifting of `match`, selectors and constructors.
  * Combinator templates.
  * A tree-walking interpreter with checked arithmetic traps, lazily
    initialized CAFs, a large-stack main thread, and `Error` handling.
  * The `prim.*` set for numbers, strings, arrays, and basic IO.
  * `fwp run file.fwp`.
  * A golden-test harness.
* **Done when:** `hello`, `factorial`, `users | filter .active | map .name |
  sort`, ADT and record programs, and `attempt`/`try` pipelines produce the
  expected output.

### PR 6 — Stdlib core (in fwp)
* **Scope:** the `lib/` prelude written in fwp itself.
* **Deliverables:**
  * The `Option` and `Result` APIs.
  * The full `List` API (map, filter, fold, sort, zip, …) and `Array[T]`.
  * `Map[K,V]` and `Set[T]` as structural-ordered primitives.
  * `String` and `Bytes` functions, `Iterator[T]` and `Stream[T]` (lazy,
    pull-based), and conversions.
  * The `wrapping`, `saturating`, `overflowing` and `checked` modules.
  * Basic IO: `print`, `read-line`, `args`, and the `env` and `time` modules.
  * `fwp test`, which runs `test "…" = expr` declarations.
* **Done when:** every stdlib function has an in-language test that passes
  under `fwp test lib/`.

### PR 7 — Native AOT: C backend + runtime → `fwp build`
* **Scope:** IR optimization and C code generation.
* **Deliverables:**
  * IR optimizations: PAP saturation into direct calls, compose fusion
    ("internal pipes are optimized away"), small-function inlining, and
    constant folding.
  * `cgen`: uniform `V` words, a function table for `rt_apply`, direct calls
    for known saturated calls, static data for constants, and per-mono-type
    descriptors.
  * `runtime/fwp_rt.c`, containing:
    * the arena allocator and boxed values;
    * structural eq/compare/hash/display driven by descriptors;
    * shortest round-trip floats;
    * checked arithmetic traps;
    * an `Error` handler stack implemented with `setjmp`;
    * the C implementations of all `prim.*`.
  * `fwp build file.fwp -o app` produces a self-contained ("fat") executable.
    The runtime and the reachable stdlib are statically linked.
* **Done when:** the whole golden suite passes on **both backends** with
  byte-identical stdout and exit codes. This differential test is the
  permanent CI gate from here on.

### PR 8 — Standalone function executables + typed process protocol
* **Scope:** spec §31–35.
* **Deliverables:**
  * `export` declarations and `fwp build file.fwp --fn normalize` →
    `./normalize`.
  * Mapping argv to the leading curried parameters (parsed by type), and
    stdin to the last parameter with the record, `List`, and `Stream`
    semantics described above.
  * The `PIPE_V1` binary framing, with the header, fingerprint and
    capability list. It is implemented in Rust (`proto.rs`) and in C, with
    stderr reserved for diagnostics.
  * `fwp pipe 'a.fwp:f x | b.fwp:g'`, which:
    * sets up binary transport between stages;
    * fuses stages into direct calls when they come from the same build;
    * leaves room to negotiate later capabilities (`UDS_V1`, `SHM_V1`,
      `ZSTD`) through the header.
* **Done when:**
  * `printf 'A\nb\n' | ./normalize` produces the expected text output.
  * `./producer | ./f 3 | ./g` round-trips typed values in binary mode.
  * A fingerprint mismatch produces a typed error on stderr.
  * Encoding is deterministic across runs and architectures (golden bytes).

### PR 9 — Comptime, homoiconicity, macros, reflection
* **Scope:** spec §10, §11 and §27.
* **Deliverables:**
  * `comptime expr`, evaluated by the interpreter during mono and reified
    into IR constants. This includes function values, because they are
    partial applications.
  * Effects allowed at compile time are capability-restricted.
  * The `Syntax` ADT, `quote`, and AST↔`Syntax` conversion.
  * `macro name = …` with `name!(…)` invocation:
    * the macro and its dependencies are compiled and run in a first phase;
    * expansion repeats until a fixpoint, with a depth limit;
    * hygiene comes from module qualification.
  * Typed macros and reflection through `type[T]` → `TypeInfo` (fields,
    variants, args).
  * `Program`, `Target` and `Layout` comptime values for the target and
    layout queries.
* **Done when:**
  * Compile-time route compilation works:
    `routes = comptime route-spec | router.compile` emits a static dispatch
    table.
  * A JSON serializer is generated from `type[User]`.
  * A `unless!` / `assert!` macro works.
  * All three examples run on both backends.

### PR 10 — Numerical computing: tensors, autodiff, ternary, SIMD
* **Scope:** spec §8 and §15–20, implemented as a first slice.
* **Deliverables:**
  * `Vector[T,N]`, `Matrix[T,M,N]` and `Tensor[T,Shape]` with static dims,
    explicit `Dyn` dims, and zero-copy views (`slice`, `reshape`,
    `transpose`, `broadcast`, `flip`).
  * `dot`, `norm`, `matmul`, `determinant`, `lu`, `qr`, `cholesky`, `solve`,
    and the iterative solvers `cg` and `gmres`.
  * `Complex[T]`.
  * Sparse types `SparseVector` and `SparseMatrix` with COO and CSR layouts
    and explicit `Zero[T]` defaults.
  * `Dual[T]` forward-mode AD: `derivative`, `gradient`, `jacobian`,
    `hessian` (as nested duals), and `stop-gradient`.
  * The `TensorExpr[T,Shape]` lazy graph with `realize`. The fusion and
    `graph.*` passes are `cse`, `dce`, `constant-fold`, `fuse` and
    `toposort`.
  * Balanced ternary: `Trit`, `TInt[N]` with checked arithmetic, `0t`
    literals, and `PackedTrits[N]` (5 trits per byte).
  * Portable `Vec[N,T]` SIMD, lowered to GCC/Clang vector extensions in C
    (which map to SSE/AVX/NEON/WASM SIMD).
* **Done when:** these work with golden numeric outputs on both backends:
  * a matmul shape mismatch is a compile error;
  * Newton's method uses `derivative`;
  * an LU solve matches a reference;
  * TInt arithmetic round-trips;
  * a fused expression produces a single loop in the generated C.

### PR 11 — Concurrency, networking, HTTP server stdlib
* **Scope:** spec §24–26.
* **Deliverables:**
  * Structured concurrency: `Scope`, `Task[T]`, `Channel[T]`,
    `Cancellation`, `Deadline`. These run on an event loop (epoll/kqueue) in
    the C runtime and on threads in the interpreter.
  * `net.tcp`, `net.udp` and `net.dns`.
  * `http.server` (HTTP/1.1) with streaming bodies, backpressure, connection
    and request limits, timeouts and graceful shutdown, plus `http.client`.
  * `url`, `json` (with `Json.Null`), `form`, `log` and `metrics`.
  * Middleware as plain composition (`timeout 2s | auth.require | … |
    json.response`).
* **Out of scope here:** TLS, HTTP/2, HTTP/3 and gRPC are deferred to the
  roadmap.
* **Done when:** an example JSON API server handles concurrent requests
  under a load test (for example with `wrk`). Timeouts and shutdown behave
  as specified, and an integration test drives it with curl.

### PR 12 — FFI, WASM, fat binaries, docs, and 1.0 polish
* **Scope:** spec §28–30 and §35, plus documentation.
* **Deliverables:**
  * `foreign "C"` with `repr(C)` structs, pointers, `Option[Ptr[T]]` for
    nullable pointers, callbacks, and variadics. In the interpreter these
    are reached through `dlsym`.
  * `staticlib` and `cdylib` output, with a Rust interop example that goes
    through `extern "C"`.
  * WASM: `fwp build --target wasm32-wasi` (via clang/wasm-ld) and a browser
    target. Effects the target doesn't provide (`Network`, for example) are
    rejected at compile time.
  * Fat binaries with multiple CPU feature variants and runtime dispatch.
  * `docs/reference.md`, a tutorial, `examples/`, and a README.
* **Done when:**
  * The C library calls a C function, and a Rust program links the
    fwp-built `staticlib`.
  * A WASI build runs under node or wasmtime and passes the golden suite
    subset.

---

## 4. Explicitly deferred (post-12-PR roadmap)

These parts of the spec are acknowledged but not delivered in the 12 PRs:

* GPU and device backends (`Cuda`, `Rocm`, `Metal`, `Vulkan`, `WebGPU`),
  `Buffer[T, Device]`, multi-device sharding, and collectives.
* JIT (`kernel | jit target`). The interpreter and comptime specialization
  stand in for it.
* Region/lifetime inference and allocator-polymorphic collections beyond
  arenas.
* TLS, HTTP/2 and HTTP/3, gRPC, WebSocket, and compression.
* `UDS_V1`, `SHM_V1` and `GRPC_V1` transports. The protocol header reserves
  capability bits for them.
* `F16`, `BF16` and `F128` arithmetic. They are parsed and typed, and the
  arithmetic is emulated or deferred.
* Reverse-mode AD by IR transformation, and checkpointing.
* The WASM Component Model, and `wasm64`.
* A self-hosted compiler.

## 5. Testing strategy

* **Unit tests** cover the lexer, parser, unifier and protocol codec.
* **Golden tests** live in `tests/<area>/*.fwp`, each with `.out`, `.err` and
  `.exit` files. Every golden test runs on the interpreter and on the native
  build, and their outputs must match byte for byte (from PR 7 on).
* **In-language `test` declarations** cover the stdlib and run with
  `fwp test`.
* **Property tests:**
  * protocol encode/decode round-trips;
  * checked-arithmetic agreement between the interpreter and C on random
    inputs;
  * parse and pretty-print round-trips of `Syntax`.
* **CI** runs `cargo fmt --check`, `clippy -D warnings`, `cargo test`, the
  golden suite on both backends, and the WASI subset (from PR 12).
