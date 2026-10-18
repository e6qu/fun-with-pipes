# fwp ("foop")

fwp is a programming language built around pipes: each step receives the result
of the previous step. It checks types before running a program and can compile
the program into a native executable through a C compiler.

```fwp
double = mul 2
main = 5 | double | echo
```

This program prints `10`. `double` names a function; `mul 2` means “multiply the
input by two.” The `|` symbol passes `5` to `double`, then passes its result to
`echo`, which prints it. `main` is where execution begins. Arguments are written
before the input being transformed, so the same function works naturally in a
pipe: `5 | mul 2`.

Start with [the tutorials](docs/tutorials/README.md). They explain functions,
data, types and error handling before building larger programs. The
[glossary](docs/glossary.md) explains terms used in the reference and compiler
documentation; you do not need to learn them all before writing a program.

## What the language offers

- **Type checking before execution.** The compiler can infer ordinary types
  from how values are used. A reusable function that works with several types
  has an explicit type signature. Integer arithmetic checks for overflow.
- **Functions that fit into pipes.** Functions can be combined without naming
  every intermediate value. This is called *tacit* programming. It is a style
  of writing functions, not an extra execution mechanism.
- **Explicit external actions.** Function types identify actions such as file
  access, networking or a recoverable error. These are called *effects*.
- **Immutable values.** An update produces a new logical value. The compiler
  may reuse storage when it can prove that older values cannot observe the change.
- **Several ways to manage memory.** The normal native runtime includes a
  garbage collector. Checked `--gc arc` uses automatic reference counting for
  programs whose memory lifetimes the compiler can prove safe. Unsupported
  programs are rejected in that mode; not every fwp program is collector-free.
- **Numerical programming.** The library includes vectors, matrices, several
  floating-point formats, and automatic differentiation: computing how a
  function's output changes when its inputs change.
- **Programs, commands and servers.** Functions can become command-line tools,
  HTTP endpoints or tools for applications that use the Model Context Protocol
  (MCP). Tasks and channels support concurrent work.

Generics are resolved when compiling, so they do not require runtime method
lookup through type dictionaries. That does **not** mean every abstraction is
free: some values still need heap storage, reference-count updates or indirect
function calls. [Performance measurements](docs/benchmarks.md) explain the
comparisons with C and Rust and the limits of the evidence.

## Project direction

The remaining [project plan](PLAN.md) targets removal of tracing garbage
collection and less reference-counting overhead through compile-time ownership,
borrowing and storage reuse. It also covers measured CPU performance,
differentiation, numerical kernels and larger example applications. These are
active goals; the capabilities and limitations above describe today's compiler.
The [design limits](docs/design-limits.md) explain achievable guarantees and
tradeoffs. General cycle prevention and guaranteed tail recursion remain design
work; use existing checked ARC contracts and `loop` today.

## Supported platforms

Native execution and packaged compilers have passed automated checks on:

| Operating system | Processor families |
|---|---|
| Linux | AMD64 (also called x86-64) and ARM64 |
| macOS | Intel AMD64 and Apple Silicon ARM64 |
| Windows | AMD64 and ARM64 |

There is a separate compiler binary for each combination. This does not promise
that any one computer can build executables for every other platform.
[Project status](docs/development-state.md) links the accepted checks.

## Run your first program

You need the `fwp` compiler on your command search path (`PATH`). Successful
[CI runs](https://github.com/e6qu/fun-with-pipes/actions/workflows/ci.yml) provide
platform-specific compiler packages. CI means *continuous integration*: the
automated builds and tests for a change. The packages are tested outside the
source checkout. See [Contributing](CONTRIBUTING.md#setting-up) for source builds
and toolchain requirements.

Native compilation also needs a C compiler: GCC or Clang on Linux, Xcode command
line tools on macOS, or the supported Windows C toolchain described in the
contributor guide. Encrypted networking additionally needs OpenSSL 3.

From this repository's root directory:

```sh
fwp run examples/hello.fwp
fwp build examples/hello.fwp -o hello
```

The first command compiles and runs the program, keeping a cached executable
for later runs. The second creates an executable; run `./hello` on Linux/macOS
or `./hello.exe` on Windows. `fwp run --interp examples/hello.fwp` uses the
interpreter instead: it evaluates the compiler's checked program directly.
The test suite compares both execution methods.

Run `fwp repl --no-history` to try expressions without creating a file. The
[interactive guide](docs/repl.md) explains numbered results, multiline input,
history, type inspection and how to save definitions.
For code and explanations in cells, use the [local notebook](docs/notebooks.md).
The [debugging guide](docs/debugging.md) covers breakpoints, Python instrumentation,
generated C and machine instructions across architectures and optimization levels.

## Where to go next

| If you want to… | Read |
|---|---|
| Learn the language with explained, runnable examples | [Tutorials](docs/tutorials/README.md) |
| Find an example application and its prerequisites | [Example applications](examples/README.md) |
| Try expressions interactively | [REPL guide](docs/repl.md) |
| Look up syntax or a compiler command | [Language reference](docs/reference.md) |
| Look up a library function or read a type signature | [Standard library](docs/stdlib.md) |
| Understand a performance comparison | [Benchmarks and overhead](docs/benchmarks.md) |
| Build a command-line program | [Command-line guide](docs/cli.md) |
| Build a web API or client | [REST and OpenAPI guide](docs/rest.md) |
| Learn about tasks and networking | [Concurrency guide](docs/concurrency.md) |
| Connect functions to commands, web routes or MCP tools | [Interface guide](docs/interfaces.md) |
| Use encrypted connections | [TLS guide](docs/tls.md) |
| Split a program into communicating processes | [Services guide](docs/services.md) |
| Compute derivatives or run array calculations | [Numerical guide](docs/numerics.md) |
| Understand memory management | [Memory and ownership](docs/ownership.md) |
| Understand parsing, desugaring and macro expansion | [Compiler pipeline](docs/compiler-pipeline.md) |
| Work on the compiler | [Design](docs/design.md) and [Contributing](CONTRIBUTING.md) |
| Find completed work and the current task | [Plan](PLAN.md) and [session handoff](docs/development-state.md) |

## Repository layout

| Directory | Purpose |
|---|---|
| `src/` | Rust implementation of the compiler, interpreter and development tools |
| `runtime/` | C support code included in generated programs |
| `lib/` | Standard library functions written in fwp |
| `examples/` | Small applications; see their [reading guide](examples/README.md) |
| `docs/tutorials/` | Lessons with source files and expected results |
| `tests/` | Automated checks, including comparisons with expected output |
| `bench/` | The fwp, C and Rust programs used in performance comparisons |
| `web/` | Browser playground |
| `scripts/` | Build, test, packaging and measurement tools |

## License

fwp uses the [MIT license](LICENSE). Material imported from other projects keeps
its original license and source information.

Copyright 2026 Adrian Mârza and fwp contributors
