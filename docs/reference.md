# fwp reference

fwp is a tacit, curried, pipe-oriented language with static types, effect
tracking, and two backends: an interpreter and native code through C. This
page is the reference for the language as implemented. For a gentler
introduction, see the [tutorial](tutorial.md).

## Lexical structure

- **Comments** run from `#` to the end of the line.
- **Names** are kebab-case (`read-all`, `max-header-bytes`). Dots qualify
  them (`list.flat-map`, `mods.util.helper`). Upper-case names denote types
  and constructors, which may also be qualified (`Json.Null`).
- **Integer literals:** `42`, `-7`, `1_000`, `0x1f`, `0b101`, `0o17`. A suffix fixes the type: `i8`,
  `i16`, `i32`, `i64`, `i128`, `u8`..`u128`, `isize`, `usize`. Without a
  suffix, the literal takes the type it is used at; a literal out of range
  for that type is a compile error.
- **Float literals:** `1.5`, `2e-3`, with suffixes `f16`, `bf16`, `f32`,
  `f64`, `f128`.
- **Duration literals:** `500ns`, `20us`, `250ms`, `2s`, `5min`, `1h`.
- **Balanced ternary literals:** `0t+-0` (`TInt`).
- **Strings:** `"..."`, with the escapes `\n \t \r \0 \\ \"` and
  `\u{1F600}`.
- **Layout:** a declaration continues on the following lines as long as they
  are indented more deeply than its first line.

## Declarations

```
name = expression                 # a definition
name : Type where Trait[a]        # a signature (optional)
rec name = ...                    # recursion must be declared
rec name : Type                   # (or on the signature)
export name : Type                # exported: executables, libraries
import dir.module                 # dir/module.fwp; names as dir.module.name

Point = { x: F64, y: F64 }        # nominal record
Shape =                           # variants
    | Circle Point F64
    | Square Point F64
Meters = F64                      # alias
Handle = builtin                  # opaque, provided by the runtime
resource File = builtin           # affine: no Dup, not captured by partial application
repr(C) Vec2 = { x: F64, y: F64 } # C layout (fields in declaration order)

trait Shape[T] : Super[T] =       # superclasses after `:`
    area : T -> F64
    describe : T -> String
    describe = area | show        # default method
impl Shape[Circle] where Ring[F64] =
    area = ...

test "name" = expression          # must evaluate to True
macro name = function             # a Syntax -> Syntax function
foreign "C" name : Type = "symbol" [variadic N]
```

## Expressions

| Form | Meaning |
|---|---|
| `f x y` | application; functions are curried |
| `x \| f` | `f x` when `x` is a value; composition when `x` is a function |
| `[a, b]`, `(a, b)`, `()` | list, tuple, unit (tuples are records with fields `.0`, `.1`, ...) |
| `{ x = 1, y = 2 }` | record (structural; unifies with nominal records) |
| `.x`, `.x.y`, `.0` | field selector functions |
| `make T { f = g }` | build a record from functions of the input |
| `update { f = g }` | apply `g` to field `f` |
| `with { f = v }` | replace field `f` |
| `match` arms | pattern matching (below) |
| `comptime e` | evaluate `e` at compile time |
| `quote e`, `unquote!(x)` | syntax as data; `unquote!(0)` etc. make a template function |
| `name!(args)` | macro call, expanded before type checking |
| `type[T]` | a `TypeInfo` value describing `T` |

Arguments come last: `sub 1` subtracts one, `div 2` halves, `lt 0` tests
`x < 0`, and `concat "!"` appends.

### Pipes

The meaning of `|` is decided by the type of its left side: application
for values, left-to-right composition for functions. When the type is not
yet known, the decision is deferred until it is.

### Pattern matching

```
area = match
    Circle _ _ -> const (fork mul id id | mul 3.14159)
    Square _ _ -> const (fork mul id id)
```

A `match` is a function. Patterns are constructors, literals, tuples,
records and `_` holes. Each hole's value is passed, in order, as an argument
to the arm's body. Arms are checked for exhaustiveness, and the compiler
names a missing case. Multi-argument pattern functions use
`curry (match (a, b) ...)`.

## Types

- **Numbers:** `I8`..`I128`, `U8`..`U128`, `ISize`, `USize`, `F16`, `BF16`,
  `F32`, `F64`, `F128`, `TInt[N]`, `Trit`.
  - Integer arithmetic traps on overflow; `wrapping.*`, `saturating.*`,
    `checked.*` and `overflowing.*` give the other behaviours.
  - Floats are IEEE.
- **Basic types:** `Bool`, `String` (UTF-8), `Bytes`, `Duration`,
  `List[T]`, `Array[T]`, `Map[K, V]`, `Set[T]`, `Option[T]`,
  `Result[T, E]`.
- **Functions:** `A -> B ! {IO, Error[E] | e}`. The effect row comes after
  `!`, and `e` is a row variable.
- **Type-level naturals:** `Vector[F64, 3]`, `Matrix[T, M, N]`, `Vec[4, F32]`.
- **Higher-kinded parameters:** `Functor[F]`.

## Traits

- **Numeric:** `Add`, `Sub`, `Mul`, `Div`, `Rem`, `Neg`, `Zero`, `One`,
  `FromInt`, `FromFloat`, `Ring`, `Field`, `Floating`, and the primitive
  classes `Integer`, `Signed`, `Float` and `Numeric`.
- **Structural**, derived by the compiler: `Eq`, `Ord`, `Hash`, `Display`,
  `Dup`, `Encode`, `Decode`.
- **Abstractions:** `Functor`, `Applicative`, `Monad`.

## Effects

| Effect | Performed by |
|---|---|
| `IO` | console, environment, clocks, logs, metrics |
| `FileIO` | files |
| `Network` | sockets, DNS |
| `Async` | tasks, channels, sleeping |
| `Random` | random numbers |
| `State[S]` | `get`, `put`, `modify` (handled by `run-state`) |
| `Error[E]` | `fail` (handled by `attempt`, re-raised by `try`) |
| `Alloc`, `Unsafe` | allocation, raw memory and pointers |

The effect rules:

- Definitions other than `main` and tests must be pure values.
- Only the final arrow of a function type may carry effects.
- `comptime` code may use only `IO`, `FileIO`, `Alloc` and `Error`.
- A spawned task may not raise `Error`.

## Compile-time evaluation and macros

- `comptime e` runs `e` in the interpreter during compilation and embeds
  the result, even closures and maps, as a constant.
- `quote e` is the `Syntax` of `e`. `Syntax` and `SynPat` are ordinary
  data types.
- A macro is a function from `Syntax` to `Syntax`. Names that a quote
  refers to resolve where the quote was written (hygiene).

## C interop

```
foreign "C" strlen : String -> USize
repr(C) DivResult = { quot: I32, rem: I32 }
foreign "C" div : I32 -> I32 -> DivResult
foreign "C" qsort : Ptr[I32] -> USize -> USize -> (Ptr[I32] -> Ptr[I32] -> I32 ! {Unsafe}) -> () ! {Unsafe}
foreign "C" snprintf : Ptr[U8] -> USize -> String -> I64 -> I32 ! {Unsafe} = "snprintf" variadic 3
```

| fwp | C |
|---|---|
| integers | `intN_t`, `uintN_t`; `ISize`/`USize` are `ptrdiff_t`/`size_t` |
| `F32`, `F64`, `Bool` | `float`, `double`, `_Bool` |
| `()` | `void` |
| `String` | `const char *` |
| `Bytes` | `const uint8_t *` (parameters only) |
| `Ptr[T]` | a pointer |
| `Option[Ptr[T]]` | a nullable pointer |
| `repr(C)` record | a struct |
| function | a callback |

- Raw memory: `mem.alloc`, `mem.free`, `mem.string`, `ptr.read`,
  `ptr.write`, `ptr.at` and `ptr.read-string`, under `Unsafe`.
- A callback may only be used while the foreign call that received it is
  running.
- The interpreter reaches C through a generated shim library, built with
  the system C compiler and loaded with `dlsym`.
- `--link` adds C sources, objects or libraries (`-lm`, `-L/dir`,
  `util.c`) for both backends.
- `fwp build --staticlib` or `--cdylib` turns the exported functions into
  a C library with a header. Any language with a C FFI can call it; see
  `tests/c-interop/main.rs` for Rust.

## The `fwp` command

```
fwp run [--link X]... file.fwp [args...]      run main (interpreter)
fwp build file.fwp [options]                  compile
    -o out           output path
    -O0..-O3         C optimization level
    --fn name        an exported function as an executable (see protocol.md)
    --target T       native (default), wasm32-wasi, wasm32-browser
    --fat            one variant per CPU feature level, chosen at startup
    --staticlib      lib<name>.a and lib<name>.h of the exported functions
    --cdylib         lib<name>.so and lib<name>.h
    --link X         C code or libraries for foreign functions
    --emit-c         write the generated C instead of compiling it
fwp exec file.fwp fn [args...]                run an exported function
fwp pipe 'a.fwp:f x | b.fwp:g'                connect functions with typed pipes
fwp test file.fwp [--native]                  run test declarations
fwp test --std [--native]                     the standard library's tests
fwp check [--parse] file.fwp                  print inferred types (or the syntax tree)
```

Exit codes:

| Code | Meaning |
|---|---|
| 0 | success |
| 1 | uncaught error, or the main task was cancelled |
| 2 | usage error |
| 3 | malformed input to an executable function |
| 101 | trap: overflow, division by zero, or deadlock |

### Targets

| Target | Output | Runtime |
|---|---|---|
| native | an executable | all features |
| `wasm32-wasi` | a module for wasmtime or `node:wasi` | needs clang with a WASI sysroot; no tasks or sockets, and programs that use them are rejected at compile time; files only in preopened directories |
| `wasm32-browser` | the module plus a JavaScript loader (`run({ stdout, args, env, stdin })`) | standard streams, clocks and random numbers |
| `--fat` (x86-64) | variants for x86-64, x86-64-v2 and x86-64-v3 | the best variant the CPU supports runs; `FWP_VARIANT=name` forces one, `FWP_VARIANT_SHOW=1` reports the choice |

The interpreter and every compiled target produce the same output for the
same program, including float formatting and trap messages. The test suite
checks this.

### Environment variables

| Variable | Effect |
|---|---|
| `FWP_SEED` | fixes the seed of `random.*` |
| `FWP_OUT=bin` | makes executable functions write the binary protocol |
| `FWP_NO_OPT=1` | disables the IR optimizer |
| `CC` | the C compiler for native builds |
| `FWP_WASM_CC` | the C compiler for WebAssembly builds |
| `FWP_BLESS=1` | regenerates the expected outputs of the test suite |
