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

- **Tacit, data-last, curried.** `x | f` applies a function to a value, and
  `f | g` composes two functions. `match` passes the `_` holes of a pattern
  to its arm. `make`, `update` and `with` build and modify records.
- **Types:**
  - Hindley–Milner inference with records, rows and variants;
  - traits with superclasses, default methods and higher-kinded parameters;
  - compiler-derived `Eq`, `Ord`, `Hash`, `Display` and `Encode`;
  - sized numbers that trap on overflow, and type-level naturals for
    matrix shapes;
  - exhaustive pattern matching, with the missing case named.
- **Effects:**
  - `IO`, `Error[E]`, `State[S]`, `Async`, `Network` and more, in function
    types;
  - pure definitions, handlers (`attempt`, `try`, `run-state`) and affine
    resources.
- **Compile time:** `comptime` evaluation, syntax as data, hygienic macros,
  and `type[T]` reflection.
- **Numerics:**
  - sized vectors and matrices with LU, QR, Cholesky and CG;
  - complex numbers and forward-mode autodiff;
  - balanced ternary, portable SIMD and tensor graphs.
- **Concurrency and the web:**
  - tasks, channels, cancellation and deadlines;
  - TCP, UDP and DNS;
  - an HTTP/1.1 server and client, where middleware is plain composition;
  - JSON, URLs, logs and Prometheus metrics.
- **Backends:**
  - an interpreter, and native executables via C, with identical output;
  - exported functions as standalone executables connected by a typed
    binary pipe protocol;
  - WebAssembly (WASI and browser), fat binaries with per-CPU variants, and
    C interop in both directions (`foreign "C"`, static and shared
    libraries).

## Quick start

Requirements: Rust (stable) and a C compiler. Optionally, for WebAssembly:
clang with a WASI sysroot (Debian/Ubuntu: `wasi-libc`,
`libclang-rt-18-dev-wasm32`, `lld`) and node.

```
cargo build --release
export PATH=$PWD/target/release:$PATH

fwp run examples/hello.fwp
fwp build examples/tutorial/02-data.fwp -o data && ./data
fwp build examples/hello.fwp --target wasm32-wasi -o hello.wasm
fwp run examples/server/api.fwp          # a JSON API on 127.0.0.1:8080
fwp test --std                           # the standard library's own tests
```

## Documentation

| Document | Contents |
|---|---|
| [docs/tutorial.md](docs/tutorial.md) | a tour, from pipes to tasks |
| [docs/reference.md](docs/reference.md) | the language, the `fwp` command, targets, C interop |
| [docs/concurrency.md](docs/concurrency.md) | tasks, networking, HTTP, JSON, logs, metrics |
| [docs/protocol.md](docs/protocol.md) | executables and the typed pipe protocol |
| [PLAN.md](PLAN.md) | the design decisions and the 12-PR implementation plan |

## Status

| Area | State |
|---|---|
| Lexer, parser, layout rule, diagnostics | done |
| Type inference (HM, rows, ADTs, records, `rec`, pipe modes, exhaustiveness) | done |
| Traits (HKT, superclasses, defaults), sized numerics, literal and structural classes | done |
| Effect rows, handlers (`attempt`, `try`, `run-state`), effect rules, affine resources | done |
| Monomorphization, typed IR, interpreter (`fwp run`, `fwp test`) | done |
| Standard library: lists, Option/Result, strings, arrays, maps, sets, bytes, lazy iterators, IO | done |
| IR optimizer, native AOT via C (`fwp build`), differential testing | done |
| Standalone function executables, typed pipe protocol (`PIPE_V1`), `fwp pipe` | done |
| Comptime evaluation, `Syntax` values, hygienic macros, `type[T]` reflection | done |
| Linear algebra (sized vectors/matrices), complex numbers, autodiff, balanced ternary, SIMD, tensor graphs | done |
| Structured concurrency (tasks, channels, deadlines), TCP/UDP/DNS, HTTP/1.1 server and client, JSON, URLs, logs, metrics | done |
| C FFI (`foreign "C"`, `repr(C)`, pointers, callbacks, variadics), static/shared libraries, WebAssembly (WASI, browser), fat binaries | done |

Not yet implemented, and deferred in the roadmap of [PLAN.md](PLAN.md):

- a garbage collector (native programs never free memory);
- TLS, HTTP/2 and HTTP/3;
- preemptive scheduling;
- GPU and distributed backends.

## Layout

```
src/        compiler: lexer, parser, type checker, monomorphizer, optimizer,
            interpreter, C code generator, protocol, FFI, scheduler
runtime/    the C runtime embedded in native programs (and WASM helpers)
lib/        the standard library, written in fwp (with its tests)
examples/   tutorial programs, a JSON API server, executable tools
tests/      golden programs, type-check snapshots, protocol, HTTP, FFI,
            WebAssembly and fat-binary tests
docs/       documentation
```

## Development

```
cargo fmt --all
cargo clippy --all-targets -- -D warnings
cargo test                 # interpreter and native for every golden program
FWP_BLESS=1 cargo test     # regenerate snapshot files after an intended change
```
