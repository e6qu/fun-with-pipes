# Plan

fwp implements the *Pipe Language Compact Specification*. The design
decisions are in [docs/design.md](docs/design.md); this page tracks the
work.

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

## Next

1. **Tooling.** `fwp fmt` (a formatter that keeps comments), `fwp lint`,
   and `fwp lsp` (diagnostics, hover, go to definition, symbols,
   formatting, completion), with a parser that recovers from errors.
2. **fwp in the browser.** The compiler and interpreter built for
   WebAssembly, and a playground page that checks and runs programs
   without a server.

## Later

See [Not implemented](docs/design.md#not-implemented).
