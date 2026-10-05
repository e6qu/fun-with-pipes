# Contributing to fwp

Thank you for helping. This guide covers setting up, the rules the code
follows, how to test a change, and how changes are merged. How the
compiler is built is described in [docs/design.md](docs/design.md), and
the language in [docs/reference.md](docs/reference.md).

## Setting up

You need:

- Rust (stable), with `rustfmt` and `clippy`.
- A C compiler (`cc`; GCC or clang). Native programs, and most tests,
  are built with it.
- OpenSSL 3 with headers (`libssl-dev`), for TLS.
- Optional, for the WebAssembly tests: clang with a WASI sysroot and lld
  (Debian/Ubuntu: `clang lld wasi-libc libclang-rt-18-dev-wasm32`), the
  `wasm32-wasip1` Rust target (`rustup target add wasm32-wasip1`), node 24,
  and binaryen's `wasm-opt` (`npm install -g binaryen`).
- Optional, for the cross-compilation tests: an aarch64 C compiler and
  qemu (`gcc-aarch64-linux-gnu libc6-dev-arm64-cross qemu-user`). Tests
  that need a missing tool skip themselves.

```
cargo build --release
export PATH=$PWD/target/release:$PATH
fwp run examples/hello.fwp
```

## Before you open a pull request

CI runs these, and all of them must pass:

```
cargo fmt --all -- --check
cargo clippy --all-targets -- -D warnings
cargo clippy --target wasm32-wasip1 -- -D warnings
cargo test --all-targets
```

A separate CI job runs the benchmarks
(`cargo test --release --test bench -- --ignored --nocapture`). It
reports times without failing on them, but it does fail when fwp, C and
Rust print different results.

## Rules the code follows

- **No third-party crates.** fwp depends only on Rust's standard library,
  so everything it needs is written here: HTTP/2, gzip, protobuf, JSON,
  YAML and the rest. The C runtime uses only the C library, pthreads,
  OpenSSL (for TLS) and the OpenCL loader (for devices, loaded when used).
- **The interpreter is the reference.** Every feature works in both
  engines, the interpreter (`src/interp.rs`) and the C backend
  (`src/cgen.rs`, `runtime/*.c`), and the two agree byte for byte on
  stdout, stderr and the exit code. A change to one engine comes with the
  same change to the other.
- **Generics are explicit.** In `lib/` and in examples, every generic
  definition has a signature, because the compiler rejects a definition
  without one that would be generic. Generics compile to specialized
  code, so they cost nothing at run time
  ([docs/design.md](docs/design.md#generics)).
- **Abstractions cost nothing at run time.** An abstraction that is free
  in the source should compile to code a C programmer would write. When
  it does not, the benchmarks in `bench/` show the cost
  ([docs/benchmarks.md](docs/benchmarks.md)).
- **Errors say what to do.** A diagnostic points at the cause and, where
  there is one, gives the fix (the signature to write, the option to
  raise).

## Tests

| Kind | Where | What it checks |
|---|---|---|
| Golden programs | `tests/run/*.fwp` with `.out` (and optional `.in`) | each program, interpreted and compiled natively (`tests/golden_run.rs`), with static memory (`tests/static_memory.rs`) and in WebAssembly where available |
| Type-check snapshots | `tests/check/*.fwp` with `.out` | inferred types, warnings and error messages |
| Parse and lint snapshots | `tests/parse/`, `tests/lint/` | the parser and `fwp lint` |
| Standard library | `test "…" = …` in `lib/*.fwp` | `fwp test --std` |
| Tutorials and examples | `docs/tutorials/*/`, `examples/` | each tutorial runs in both engines and prints its `main.out`, and its README shows only code from the program; the examples type-check |
| Features | `tests/*.rs` | the protocol, HTTP, TLS, gRPC, REST, CLI, FFI, the GC, the cache, the formatter, the language server, the browser build, … |

After an intended change in output, regenerate the snapshots and review
the difference before committing it:

```
FWP_BLESS=1 cargo test
git diff tests/ docs/stdlib.md
```

`docs/stdlib.md` is generated from the comments and signatures in
`lib/*.fwp`. Regenerate it the same way, never by hand. A declaration
with a `# internal` comment line above it, or a name with a part starting
with `_`, is left out.

To add a golden test, write `tests/run/name.fwp` and bless its `.out`.
Then check the output by reading it: a blessed file is only as right as
the person who reviewed it.

## Common changes

### A primitive

Primitives are the functions the standard library cannot write in fwp.
Each one is implemented in both engines:

1. Declare it in the module it belongs to: `foreign "fwp" name : Type`
   in `lib/<module>.fwp`, with a doc comment and a `test`.
2. Implement it in the interpreter (`src/prims_std.rs`, or the module for
   its area: `src/web.rs`, `src/linalg.rs`, …).
3. Implement it in C: a mapping in `src/cgen.rs` and, where needed, a
   function in `runtime/fwp_rt*.c`.
4. Add a golden program that uses it, so both engines are compared.

### Memory in the C runtime

Native programs have a generational collector (`runtime/fwp_rt_gc.c`).
Objects come in three kinds, and the generated code must use the right
allocator:

- `fwp_alloc_init`: values that are complete when allocated (records,
  variants, list cells). Compute every field first, allocate, then fill
  the object at once. Never write to it after that: an old object must
  never point to a young one.
- `fwp_alloc_leaf`: memory that holds no values (string bytes, numbers).
- `fwp_alloc`: memory filled after it is allocated (arrays, maps,
  partial applications). Every minor collection scans these.

`FWP_GC_VERIFY=1` checks each minor collection against a full trace, and
`FWP_GC_STRESS=1` collects at every allocation to expose missing roots.
Run the golden tests with both after you change the runtime or the code
generator.

Records and variants that compiled code allocates are updated in place
when they have a single reference (`fwp_rc_*` in runtime/fwp_rt_gc.c).
A value the runtime keeps must be shared first (`fwp_rc_share`): generated
code does this for whatever it hands to a primitive. Runtime code that
calls compiled code back gets shared results through the `e<id>` and
`k<id>` entries. `FWP_REUSE_VERIFY=1` poisons what would be reused, and
tests/reuse.rs runs every golden program that way.

### A benchmark

Add `bench/<name>/main.fwp`, `main.c` and `main.rs`, three programs that
compute the same thing and print the same output. Then update
[docs/benchmarks.md](docs/benchmarks.md) with the results and an
explanation of any gap.

## Documentation

- A user-visible change updates the docs in the same pull request: the
  reference, the relevant guide in `docs/`, and the tutorials where they
  show the changed behavior. `PLAN.md` records what was delivered and
  what comes next.
- Write short, plain sentences in the present tense, and say what
  something does before why. Give exact commands, flags and names, and
  show working code; the examples and tutorials are tested.

## Commits and pull requests

- Work on a branch and open a pull request against `main`.
- Pull requests are merged by **squash**, so the pull request's title and
  description become the commit on `main`. Write them as you would a
  commit message: the title says what changed, and the description says
  why and how it was checked.
- One topic per pull request. A refactor needed for a feature can go in
  the same pull request; unrelated clean-ups get their own.

## Vendored code and licenses

fwp is under the MIT license ([LICENSE](LICENSE)). Code or documentation
copied from another project ("vendored") keeps its own license:

- Put it in a file or directory of its own, with the original license
  text and copyright notice next to it.
- Say where it came from: the project, its URL, and the version or
  commit it was taken from. Note any changes made to it here.
- Only vendor what is under a license compatible with MIT, and say so in
  the pull request.

Contributions are accepted under the project's MIT license.
