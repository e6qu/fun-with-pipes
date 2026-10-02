# fwp ("foop")

fwp is a tacit, curried, pipe-oriented language with static, strong types.
It is based on the *Pipe Language Compact Specification*:

```
users
| filter .active
| map .name
| sort
```

See [PLAN.md](PLAN.md) for the language design decisions and the
implementation roadmap, [docs/protocol.md](docs/protocol.md) for the typed
process protocol and [docs/concurrency.md](docs/concurrency.md) for tasks,
networking and the HTTP server.

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
| FFI, WASM, fat binaries | planned |

## Usage

```
cargo build --release
./target/release/fwp run examples/hello.fwp            # run main (interpreter)
./target/release/fwp build examples/hello.fwp -o hello # native executable via C
./target/release/fwp build tools.fwp --fn scale        # an exported function as an executable
./target/release/fwp test some-file.fwp                # run test declarations
./target/release/fwp test --std                        # run the standard library's tests
./target/release/fwp check examples/hello.fwp          # print inferred types
./target/release/fwp check --parse examples/hello.fwp  # print the syntax tree
```

## Development

```
cargo fmt --all
cargo clippy --all-targets -- -D warnings
cargo test
FWP_BLESS=1 cargo test   # regenerate snapshot files after an intended change
```
