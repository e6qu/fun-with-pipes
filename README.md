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
fwp test --std                           # the standard library's own tests
fwp fmt --check . && fwp lint examples   # formatting and lint checks
fwp lsp                                  # the language server, for editors
```

## Documentation

| Document | Contents |
|---|---|
| [docs/tutorials](docs/tutorials/README.md) | thirteen tutorials, from pipes to WebAssembly and tooling |
| [docs/reference.md](docs/reference.md) | the language, the `fwp` command, targets, C interop, formatter, linter and language server |
| [docs/stdlib.md](docs/stdlib.md) | every standard library module and signature |
| [docs/concurrency.md](docs/concurrency.md) | tasks, networking, HTTP, JSON, logs, metrics |
| [docs/protocol.md](docs/protocol.md) | executables and the typed pipe protocol |
| [docs/design.md](docs/design.md) | how the compiler is built, and what is not implemented |
| [PLAN.md](PLAN.md) | what was delivered and what comes next |

## Layout

```
src/        compiler: lexer, parser, type checker, monomorphizer, optimizer,
            interpreter, C code generator, protocol, FFI, scheduler;
            formatter, linter and language server
runtime/    the C runtime embedded in native programs (and WASM helpers)
lib/        the standard library, written in fwp (with its tests)
examples/   a word counter, a JSON API server, executable tools
tests/      golden programs, type-check and lint snapshots, protocol, HTTP,
            FFI, WebAssembly, fat-binary, formatter and language server tests
docs/       documentation and tutorials
```

## Development

```
cargo fmt --all
cargo clippy --all-targets -- -D warnings
cargo test                 # interpreter and native for every golden program
FWP_BLESS=1 cargo test     # regenerate snapshot files after an intended change
```
