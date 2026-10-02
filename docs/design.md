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
| Memory | Native programs allocate from a bump heap and never free. The interpreter uses Rust reference counting. A collector is on the roadmap |

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
  hashing, `Display`, text parsing and the binary protocol in C.
- Floats print in the shortest form that reads back exactly.
- Native tasks are green threads (`ucontext`) on an event loop: epoll on
  Linux, poll elsewhere. Interpreter tasks are OS threads that pass a
  baton, so only one runs at a time and scheduling is the same.

## Executables and the pipe protocol

Each exported function can be built as its own executable. Arguments fill
the leading parameters, parsed by type; the last parameter comes from
stdin, per line or frame for `T` and all at once for `List[T]`.

Between fwp executables, values travel in the `PIPE_V1` binary protocol: a
header with the magic `FWP1`, a version, capabilities, a 128-bit type
fingerprint and the canonical type string, then frames of
`kind:u8, len:u32le, payload`. The payload is a deterministic
little-endian encoding driven by the type. A fingerprint mismatch is an
error. See [protocol.md](protocol.md).

## Builds

| Output | How |
|---|---|
| executable | C compiled and linked with the runtime; the reachable standard library is included |
| `--fn f` | the exported function `f` as a standalone executable |
| `--fat` | one copy of the program per x86-64 CPU level, chosen at startup |
| `--staticlib`, `--cdylib` | a C library and header for the exported functions |
| `--target wasm32-wasi`, `wasm32-browser` | WebAssembly through clang; `setjmp`/`longjmp` use the WebAssembly exception proposal. Effects the target lacks (`Network`, `Async`) are compile errors |

## Not implemented

- A garbage collector for native programs.
- TLS, HTTP/2, HTTP/3, WebSocket and compression.
- Preemptive scheduling.
- GPU and distributed backends, a JIT, reverse-mode autodiff.
- The `UDS_V1` and `SHM_V1` transports (the header reserves bits for
  them), the WebAssembly component model and `wasm64`.
