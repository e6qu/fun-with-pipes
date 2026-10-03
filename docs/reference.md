# fwp reference

fwp is a tacit, curried, pipe-oriented language with static types, effect
tracking, and two backends: an interpreter and native code through C. This
page is the reference for the language as implemented. For a gentler
introduction, see the [tutorials](tutorials/README.md); the standard
library is listed in [stdlib.md](stdlib.md).

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
  `f64`, `f128`. `F16` and `BF16` are computed at `F32` precision and
  `F128` at `F64` precision.
- **Duration literals:** `500ns`, `20us`, `250ms`, `2s`, `1.5s`, `5min`,
  `1h`. They are decimal and at most about 292 years. Durations implement
  `Add`, `Sub` and `Zero` (`2s | add 500ms`).
- **Balanced ternary literals:** `0t+-0` (`TInt[3]`, one trit per digit).
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
Meters = F64                      # alias (aliases may refer to later ones,
Handler = { path: String } -> F64 #   but not to themselves)
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

In types, an unknown upper-case name (`T`, `Elem`) is a type variable.
Imported modules are named by their path; two different files may not be
imported under the same name.

## Expressions

| Form | Meaning |
|---|---|
| `f x y` | application; functions are curried |
| `x \| f` | `f x` when `x` is a value; composition when `x` is a function |
| `[a, b]`, `(a, b)`, `()` | list, tuple, unit (tuples are records with fields `.0`, `.1`, ...) |
| `{ x = 1, y = 2 }` | record (structural; unifies with nominal records) |
| `Point { x = 1.0, y = 2.0 }` | a nominal record |
| `.x`, `.x.y`, `.0` | field selector functions |
| `make { f = g }`, `make T { f = g }` | build a record (or a `T`) from functions of the input; `make { 0 = f, 1 = g }` builds a tuple |
| `update { f = g }` | apply `g` to field `f` |
| `with { f = v }` | replace field `f` |
| `match` arms, `match { P -> e, ... }` | pattern matching (below) |
| `comptime e` | evaluate `e` at compile time |
| `quote e`, `unquote!(x)` | syntax as data; `unquote!(0)` etc. make a template function |
| `name!(args)` | macro call, expanded before type checking |
| `type[T]` | a `TypeInfo` value describing `T` |

`loop step state` repeats `step` (which returns `Again s` or `Stop r`) in
constant stack space; use it for long-running loops instead of recursion.

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

A `match` is a function. Patterns are:

- constructors with argument patterns (`Circle _ _`); a bare constructor
  with fields, such as `Circle`, is short for `Circle _ _`;
- integer literals without a suffix and string literals; their type comes
  from the value matched;
- tuples, including `(_, )` for a one-element tuple, and `()`;
- `_` holes.

Records are matched through their fields with selectors, not patterns.
Each hole's value is passed, in order, as an argument to the arm's body.
Arms are checked for exhaustiveness, and the compiler names a missing case.
Multi-argument pattern functions use `curry (match (a, b) ...)`. The brace
form `match { Some -> id, None -> const 0 }` fits on one line.

## Types

- **Numbers:** `I8`..`I128`, `U8`..`U128`, `ISize`, `USize`, `F16`, `BF16`,
  `F32`, `F64`, `F128`, `TInt[N]`, `Trit`.
  - Integer arithmetic traps on overflow; `wrapping.*`, `saturating.*`,
    `checked.*` and `overflowing.*` give the other behaviours.
  - `TInt[N]` has at most 40 trits; a wider `TInt` is a compile error.
  - Floats are IEEE. An `F32` literal is rounded once, directly to `F32`;
    an integer literal at a float type is its magnitude, rounded once.
    `neg` flips the sign, so `neg 0.0` is `-0.0`. `float.to-int` is `None`
    unless the truncated value fits the integer type exactly.
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

The standard library implements the numeric traits for `Complex[T]`,
`Dual[T]` (forward-mode autodiff), `Rev[T]` (reverse-mode autodiff) and
`TensorExpr[N]` (fused elementwise kernels on devices), so code written
against the traits computes values, derivatives or kernels
([numerics.md](numerics.md)).

## Effects

| Effect | Performed by |
|---|---|
| `IO` | console, environment, clocks, logs, metrics |
| `FileIO` | files and directories |
| `Process` | running other programs |
| `Network` | sockets, DNS |
| `Async` | tasks, channels, sleeping |
| `Random` | random numbers |
| `State[S]` | `get`, `put`, `modify` (handled by `run-state`) |
| `Error[E]` | `fail` (handled by `attempt`, re-raised by `try`) |
| `Alloc`, `Unsafe` | allocation, raw memory and pointers |

The effect rules:

- Top-level values that are not functions must be pure; `main` and tests
  are the exceptions.
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
foreign "C" c-div : I32 -> I32 -> DivResult = "div"   # c-div 7 2 is div(7, 2)
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

- Foreign functions take their arguments in C order, not data-last, and
  should not reuse a standard name (`div` above would shadow fwp's own).
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

Exported functions also run as command-line programs, with flags, help,
subcommands, environment variables, shell completion and man pages
([cli.md](cli.md)), as REST endpoints with a JSON contract and an
OpenAPI document ([rest.md](rest.md)), and as gRPC methods
([grpc.md](grpc.md)); [interfaces.md](interfaces.md) compares them.
The HTTP, REST and gRPC servers and clients also speak TLS
([tls.md](tls.md)). The HTTP server and client (and so REST) speak
HTTP/1.1 and HTTP/2, compress bodies with gzip and deflate, and carry
WebSocket sessions ([concurrency.md](concurrency.md#http2)).

```
fwp run [--link X]... [--service M]... file.fwp [args...]
                                              run main (compiled, see below)
fwp build file.fwp [options]                  compile
    -o out           output path
    -O0..-O3         C optimization level
    --fn name        an exported function as an executable (see cli.md)
    --cli            every exported function as a subcommand of one
                     executable (see cli.md)
    --rest           every exported function as an endpoint of one HTTP
                     server, with /openapi.json, forms and content
                     negotiation (see rest.md)
    --grpc           every exported function as a method of one gRPC
                     server, with reflection (see grpc.md)
    --target T       native (default), wasm32-wasi, wasm32-browser
    --fat            one variant per CPU feature level, chosen at startup
    --memory static  all memory mapped once at startup (see below), with
                     --heap S, --pool S, --stack S, --tasks N,
                     --task-stack S and --threads N
    --wasm-async A   jspi (default) or asyncify: how tasks switch on WebAssembly
    --staticlib      lib<name>.a and lib<name>.h of the exported functions
    --cdylib         lib<name>.so and lib<name>.h
    --link X         C code or libraries for foreign functions
    --emit-c         write the generated C instead of compiling it
    --service M[=A]  split M into a gRPC service (repeatable); -o is then
                     a directory for the main and server executables
fwp serve [--service M]... file.fwp module [--listen A]
                                              serve a module over gRPC
fwp serve --rest file.fwp [--listen A]        serve the exported functions as REST endpoints
fwp serve --grpc file.fwp [--listen A]        serve the exported functions over gRPC
    --tls-cert F --tls-key F                  (any `fwp serve`, and the servers that --rest,
                                              --grpc and --service build) serve over TLS
                                              with this certificate chain and key (PEM; see tls.md)
    --tls-client-ca F                         and require client certificates signed by these CAs
    --cors ORIGINS                            (REST servers) allow these origins from browsers
fwp proto file.fwp [--service M]...           print the .proto of the services
fwp proto --grpc file.fwp                     print the .proto of the exported functions
fwp proto --import file.proto [-o out.fwp]    generate types, clients and routes (with descriptors
                                              for server reflection) of a .proto file
fwp openapi [--yaml] file.fwp                 print the OpenAPI document of the REST endpoints
fwp openapi --import spec.json [-o out.fwp]   generate a client module of an OpenAPI 3 or Swagger 2.0
                                              document (JSON or YAML)
fwp exec file.fwp fn [args...]                run an exported function
fwp exec --cli file.fwp [command] [args...]   run the file as `--cli` builds it
fwp pipe 'a.fwp:f x | b.fwp:g'                connect functions with typed pipes
fwp test file.fwp                             run test declarations
fwp test --std                                the standard library's tests
fwp check [--parse] file.fwp                  print inferred types (or the syntax tree)
fwp fmt [--check] [paths...]                  format files in place (see below)
fwp lint [paths...]                           warn about likely mistakes (see below)
fwp lsp                                       the language server, on stdin/stdout
fwp cache dir | clean                         print or empty the cache of compiled programs
    --interp         (run, exec, test, serve, pipe) run the interpreter instead
    -O0..-O3         (run, exec, test, serve) the C optimization level
```

A file argument of `-` reads the program from standard input.

### Compiled by default

`fwp run`, `fwp exec`, `fwp test`, `fwp serve` (gRPC services, `--rest`
and `--grpc`) and the stages of `fwp pipe` compile the program to a native
executable through C, as `fwp build` would, and run it in place of `fwp`
(on Unix the executable replaces the `fwp` process, so it has its process
id, signals and exit status). The executable is cached under the hash of
its C source, the C compiler and its options, the files given to `--link`
and the version of fwp, so a program is compiled once and runs at native
speed after that; the type checker still runs on every start, so errors
and warnings are reported as before.

| | |
|---|---|
| `--interp`, `FWP_RUN=interp` | run the interpreter instead (`--native` and `FWP_RUN=native` ask for the default) |
| `-O0` .. `-O3`, `-Os` before the file | the C optimization level: `-O2`, and `-O1` for tests |
| `FWP_CACHE_DIR` | the cache: `$XDG_CACHE_HOME/fwp`, else `~/.cache/fwp` |
| `FWP_CACHE_MAX` | how many executables it keeps, the least recently used going first (256) |
| `fwp cache dir`, `fwp cache clean` | print its directory, empty it |
| `CC` | the C compiler (`cc`) |
| `FWP_LTO` | with GCC, a large program (over 1 MB of C, such as a REST or HTTP server with its standard library) is compiled with `-flto=auto`, which generates its code on all cores: a REST server's first start takes about half as long on four. `FWP_LTO=0` compiles it as one unit, `FWP_LTO=1` uses LTO for any size |

Without a C compiler a program is interpreted, with a note on standard
error (none when `FWP_RUN` is set). The WebAssembly build of fwp always
interprets. The interpreter is the reference: the golden tests run every
program through both and compare their output byte for byte.

Exit codes:

| Code | Meaning |
|---|---|
| 0 | success |
| 1 | uncaught error, or the main task was cancelled |
| 2 | usage error, or an executable function's argument or flag cannot be parsed |
| 3 | malformed input to an executable function |
| 101 | trap: overflow, division by zero, deadlock, or stack overflow (`fwp: trap: stack overflow`) |

An exported function run as a program exits with 1 when it returns
`Err` or raises an uncaught `Error`, and prints the error as
`name: message` ([cli.md](cli.md)); one that returns an `Outcome` exits with its `status`. When `main` has type `I32`, its value is the exit code. `exit n` exits with `n` modulo 256 (`exit 259` is 3, `exit -1` is 255),
as the operating system reports it, in both backends.

Text from outside the program, that is, standard input (`read-line`,
`read-all`, `read-lines`, and the text records of executables), command-line
arguments (`args`, and the arguments of executables) and environment
variables (`env.get`), is decoded as UTF-8 by both backends in the same
way: each maximal invalid sequence of bytes becomes one U+FFFD (`�`), as
Rust's `String::from_utf8_lossy` does. Strings are therefore always valid
UTF-8. Strings in the binary pipe protocol must be valid UTF-8 and are
rejected otherwise.

### Static memory

`fwp build --memory static` builds a native executable that maps all the
memory it will use when it starts, in one populated mapping, and asks the
operating system for none after that, in the spirit of TigerBeetle's
static allocation. The mapping holds:

| Part | Option | Default | What uses it |
|---|---|---|---|
| heap | `--heap S` | 64M | fwp values; still collected, but it never grows: when it is full the collector runs before giving up |
| pool | `--pool S` | 32M | `malloc`, `calloc`, `realloc` and `free`, which the program defines, so the runtime's buffers and the C library's own allocations come from it |
| main stack | `--stack S` | 16M | the main task |
| task stacks | `--tasks N`, `--task-stack S` | 64 of 1M | tasks: at most N run at once, each with a guard page |
| thread stacks | `--threads N` | 8 of 1M | the threads of `CpuParallel` kernels (more are not started; results do not depend on their number) |

Sizes take `K`, `M` and `G`. Running out of a part ends the program with
exit code 102 and names the option to raise:

```
fwp: out of memory: the static heap (1024 KiB) is full; build with a larger --heap
```

`FWP_MEMORY_REPORT=1` prints, at exit, the size of each part and how much
of it was used at most, which is how to size them:

```
fwp: static memory: 124448 KiB mapped at startup
  heap           65536 KiB, 8320 KiB used at most (4231 KiB live at most, 1 collections)
  pool           32768 KiB, 136 KiB used at most
  ...
```

Pipes between fwp programs stay on the Unix socket transport (`UDS_V1`)
rather than the shared-memory ring, which would be new memory. Static
memory is for native executables on Linux; WebAssembly and libraries
keep the usual allocator. `tests/static_memory.rs` checks the golden
programs with it, and, with `strace`, that a program with tasks, a
parallel kernel and plenty of allocation makes no memory system call after
startup.

### Targets

| Target | Output | Runtime |
|---|---|---|
| native | an executable | all features; a program that uses TLS ([tls.md](tls.md): HTTPS, HTTP clients, REST servers, gRPC) is linked with OpenSSL and depends on `libssl.so.3`, and building it needs OpenSSL's headers (`libssl-dev`) |
| `wasm32-wasi` | a module for wasmtime or `node:wasi` | needs clang with a WASI sysroot; no sockets or processes, and programs that use them are rejected at compile time; files only in preopened directories; tasks need a JavaScript host with JSPI, or `--wasm-async=asyncify` (see below) |
| `wasm32-browser` | the module plus a JavaScript loader (`run({ stdout, stderr, args, env, stdin })`, resolving to the exit code) | as `wasm32-wasi`, but no files: standard streams, clocks and random numbers; the page must be served over HTTP; tasks run in browsers with JSPI, or in any browser with `--wasm-async=asyncify` (see below) |
| `--fat` (x86-64) | variants for x86-64, x86-64-v2 and x86-64-v3 | the best variant the CPU supports runs; `FWP_VARIANT=name` forces one, `FWP_VARIANT_SHOW=1` reports the choice |

The interpreter and every compiled target produce the same output for the
same program, including float formatting and trap messages. The test suite
checks this.

#### Tasks on WebAssembly

WebAssembly cannot switch stacks by itself, so tasks and channels
(`Async`) run there with JavaScript Promise Integration (JSPI): each task
is a fiber whose stack the JavaScript host suspends and resumes
(`web/fibers.js`, which the browser loader includes). The scheduler is the
native one (or, in fwp.wasm, the interpreter's), with the same order of
tasks; waiting for a timer suspends the program on a JavaScript timer
rather than busy-waiting, and a program whose tasks all wait for each
other traps with `fwp: trap: deadlock: every task is waiting`. Tasks are
preempted there as natively ([preemption](concurrency.md#preemption)):
each switch at the end of a slice is a JSPI suspension.

| Host | Tasks |
|---|---|
| Chrome, Edge 137 and later | yes (JSPI is on by default) |
| Firefox, Safari | with `--wasm-async=asyncify` (below); otherwise once they enable JSPI by default (until then, a program with tasks is rejected or traps as below) |
| node 24 | yes (JSPI is on by default; node 22 needs `--experimental-wasm-jspi`). With `node:wasi`, also pass `--no-turbo-fast-api-calls` (`tests/wasm/wasi-run.mjs` and `fwp-run.mjs` do): node may otherwise crash when V8 collects garbage inside a WASI call made from optimized code (node 24 stops with ``Check failed: isolate_->IsOnCentralStack()``, node 22 with a segmentation fault), which programs that switch tasks often make likely. node 24's `node:wasi` also rejects addresses beyond 2 GiB (which the stacks of a few thousand tasks reach) unless its 32-bit arguments are made unsigned (`x >>> 0`) in wrappers, as these runners and the browser loader do |
| wasmtime and other WASI runtimes | no: a program that starts a task traps with `fwp: trap: tasks need a WebAssembly host with JavaScript Promise Integration (JSPI), …`; `task.sleep` alone works |

A module that uses tasks exports `fwp_fiber_hooks`, `fwp_fiber_stack`,
`fwp_fiber_entry`, its stack pointer and its function table, into which
the host installs the switching functions; it imports nothing beyond WASI,
so it still instantiates in any WASI runtime. Programs without tasks are
unchanged. A fiber's stack is as large as the engine makes it (in
browsers about as large as a page's, a few thousand nested calls); running
out is the trap `fwp: trap: stack overflow`.

`fwp build --target wasm32-wasi|wasm32-browser --wasm-async=asyncify`
builds a program with tasks for engines without JSPI: binaryen's Asyncify
pass (`wasm-opt --asyncify`) rewrites the module so that its call stack
can be unwound into memory and rewound later, and `web/fibers.js` then
switches fibers by unwinding the one that suspends and rewinding the next
(the module exports `asyncify_*`, which the loader recognizes). It runs in
any JavaScript engine (Firefox, Safari, node without flags), with the same
output, preemption and cancellation; not in WASI runtimes without a
JavaScript host. wasm-opt is an optional tool, needed only for this
option and only by programs with tasks: it comes with binaryen (`npm
install -g binaryen`, or a system package); `FWP_WASM_OPT` names the
executable. The cost: the module is about 7% larger, calls are about 70%
slower (`fib 35` in two tasks: 0.9 s against 0.53 s with JSPI in node
24), and a task's own stack in linear memory is checked at each call,
since its calls run on the engine's main stack. The default stays
`--wasm-async=jspi`. The same works for fwp.wasm itself:
`scripts/build-playground.sh --asyncify` applies Asyncify to it, so the
playground runs tasks without JSPI too (the module grows from 4.3 to
5.1 MB, and a run in node takes about four times as long, much of it
compiling the larger module).

### fwp in the browser

fwp itself, the compiler and the interpreter, builds for WebAssembly:
`cargo build --release --target wasm32-wasip1` makes `fwp.wasm`, a WASI
command module that takes the same arguments as `fwp`. The playground in
`web/` runs it in a page:

```
rustup target add wasm32-wasip1
scripts/build-playground.sh              # web/fwp.wasm and web/examples/
python3 -m http.server -d web 8000       # any static file server works
```

| File | Role |
|---|---|
| `web/index.html`, `web/playground.js` | the editor, standard input, examples, and Run (`fwp run`), Check (`fwp check`), Format (`fwp fmt -`), Test (`fwp test`) and Stop |
| `web/fwp-worker.js` | runs `fwp.wasm` in a web worker, so a long program can be stopped |
| `web/wasi.js` | a small WASI preview 1 in JavaScript: arguments, environment, clocks, random numbers, standard streams and an in-memory file system preopened as `.` and `/`. Other calls (sockets, links) return `ENOSYS`. It works in browsers and in node (`runWasi(module, { args, env, stdin, fs, stdout, stderr })`) |

`fwp.wasm` also runs under other WASI runtimes, with files in preopened
directories. A file argument of `-` reads the program from standard input
(`fwp run -`, `fwp check -`, `fwp fmt -`, which prints the formatted text);
this works in every build. `tests/wasm/fwp-run.mjs` runs `fwp.wasm` under
node with node's WASI or with `web/wasi.js`.

The WebAssembly build has no threads, sockets, processes or `dlopen`:

- `run`, `check`, `test`, `exec`, `fmt`, `lint`, `proto` and `lsp` work.
  `build --emit-c` writes C; other builds need a C compiler.
- Tasks and channels run where the engine has JavaScript Promise
  Integration (see [Tasks on WebAssembly](#tasks-on-webassembly)): the
  playground runs tutorial 6 in Chrome. Each task is a fiber, and
  `web/wasi.js` switches them; fwp's own main task is one too. Elsewhere
  a program that uses them is rejected before it starts:
  ``fwp run: the WebAssembly build of fwp does not provide the `Async` effect (used by `task.spawn`) in this host: tasks need a WebAssembly host with JavaScript Promise Integration (JSPI)``.
- A program that uses sockets or DNS (`Network`), other programs
  (`Process`), services or foreign C functions is rejected before it
  starts, with the effect or function named:
  ``fwp run: the WebAssembly build of fwp does not provide the `Network` effect (used by `tcp.listen`)``.
  These are the effects the `wasm32-wasi` target rejects.
- `fwp build` (without `--emit-c`), `--native`, `fwp pipe`,
  `fwp serve` and `--link` exit with status 2 and
  `fwp: … is not available in the WebAssembly build of fwp`.
- The interpreter's stack is 512 MiB (a linker argument in
  `.cargo/config.toml`), but WebAssembly frames also use the engine's
  native stack, which a browser keeps small: a few hundred to a few
  thousand nested non-tail calls. Running out of either is the trap
  `fwp: trap: stack overflow` (exit code 101), with the output written
  before it kept. Iteration, `loop` and long lists are not limited.

### Environment variables

| Variable | Effect |
|---|---|
| `FWP_SEED` | fixes the seed of `random.*` |
| `FWP_OUT=bin` | makes executable functions write the binary protocol |
| `FWP_PREEMPT=n` | the slice of a task: the safe points (function entries, `loop` iterations) after which it lets other tasks run and notices cancellation (default 10000; `0`: never; see [preemption](concurrency.md#preemption)) |
| `FWP_TRANSPORT` | the transport an executable reading the binary protocol asks its producer for: `shm` (the default), `uds`, or `stdio`, which keeps the stream on the pipe and makes producers not offer any (see [transports](protocol.md#transports)) |
| `FWP_TRANSPORT_WAIT=ms` | a producer of the binary protocol waits that long after its header for the consumer to ask for a transport (`fwp pipe` sets 10000 for its stages) |
| `FWP_TRANSPORT_REPORT=1` | a consumer of the binary protocol says on stderr when its input moves to another transport |
| `FWP_SERVICE_<M>` | the `host:port` of service `M`, or `tls://host:port` for TLS (see [services](services.md), [tls.md](tls.md#grpc)) |
| `FWP_REST_ADDR` | the `host:port` a REST server listens on without `--listen` (see [rest.md](rest.md)) |
| `FWP_TLS_CERT`, `FWP_TLS_KEY` | the certificate chain and private key (PEM files) of REST and gRPC servers without `--tls-cert` and `--tls-key`: they serve over TLS when both are set (see [tls.md](tls.md)) |
| `FWP_TLS_CLIENT_CA` | the CA certificates (PEM) of the client certificates that REST and gRPC servers require, without `--tls-client-ca` (see [tls.md](tls.md#mutual-tls)) |
| `FWP_SERVICE_<M>_CA`, `_INSECURE`, `_SERVER_NAME`, `_CERT`, `_KEY` | the TLS options of the clients of service `M`: a CA file, no verification, the server name, a client certificate and key (see [tls.md](tls.md#grpc)) |
| `FWP_REST_CORS` | the origins (separated by commas, or `*`) that may call a REST server from browsers, without `--cors` (see [rest.md](rest.md#cors)) |
| `SSL_CERT_FILE`, `SSL_CERT_DIR` | OpenSSL's: the CA certificates TLS clients trust instead of the system's (see [tls.md](tls.md#client-options)) |
| `FWP_OPENCL_LIB` | the OpenCL library of the `Gpu` device instead of `libOpenCL.so.1` (see [numerics.md](numerics.md#devices)) |
| `FWP_NO_OPT=1` | disables the IR optimizer |
| `FWP_GC=off` | native programs: disables the garbage collector (memory is never freed) |
| `FWP_GC=full` | native programs: every collection is a major one (no generations) |
| `FWP_GC_VERIFY=1` | native programs: check each minor collection against a full trace, and abort at the first object it missed (for testing the runtime) |
| `FWP_GC_STATS=1` | native programs: print the collector's statistics to stderr at exit (collections, bytes allocated, heap and live sizes, pauses, peak RSS) |
| `FWP_GC_STRESS=n` | native programs: collect at every n-th allocation (`1`: at every one), to find bugs in the runtime |
| `CC` | the C compiler for native builds |
| `AR` | the archiver for `--staticlib` |
| `FWP_WASM_CC` | the C compiler for WebAssembly builds |
| `FWP_WASM_OPT` | binaryen's `wasm-opt`, for `--wasm-async=asyncify` (default: `wasm-opt` on the `PATH`) |
| `FWP_BLESS=1` | regenerates the expected outputs of the test suite |

## Formatting, linting and editors

### `fwp fmt`

`fwp fmt [--check] [paths...]` formats `.fwp` files in place. Directories
are searched recursively (hidden directories and `target` are skipped);
without paths it formats the current directory. With `--check` it changes
nothing, prints the files that are not formatted and exits with status 1
if there are any. A file with a syntax error is reported and left alone.

The layout is canonical, computed from the syntax tree:

- 80 columns and 4-space indentation;
- an expression that fits on its line stays on it, otherwise it moves to
  the next line, and a pipeline that still does not fit gets one stage
  per line with a leading `|`;
- `match` arms go on their own lines, and the `match` keyword stays at the
  end of the line that introduces it (`f = match`, `curry (match`,
  `x | match`);
- brackets and records that do not fit get one item per line with a
  trailing comma, closing at the indentation of the line that opened
  them (`f [` ... `]`);
- an application that does not fit keeps a simple function and arguments
  on the line and breaks its last argument, or puts one argument per line;
- `make`, `with` and `update` arguments are parenthesized;
- literals keep their spelling (`0xff`, `1_000`, `150ms`, escapes).

Comments are kept: comments between declarations stay in place, and a
declaration that contains a comment is left as written (only trailing
whitespace is removed). Runs of blank lines become one, and the file ends
with a single newline. Formatting is idempotent and never changes the
syntax tree; the test suite checks both over every `.fwp` file of the
repository.

### `fwp lint`

`fwp lint [paths...]` prints warnings in the same form as compiler
diagnostics and exits with status 1 if there are any (2 if a file cannot
be read). It does not type-check the files; `fwp check` does. The rules:

| Code | Warns about |
|---|---|
| `unused-binding` | a top-level binding that is not exported, not `main` and not used anywhere in the file (only in files with `main` or exports; names starting with `_` are exempt) |
| `redundant-id` | a `\| id` stage |
| `map-fusion` | `map f \| map g`, which is `map (f \| g)` with one traversal |
| `trivial-match` | a `match` whose only arm is `_ -> f`, which is just `f` |
| `shadows-std` | a top-level definition with the name of a standard library function |
| `missing-binding` | a signature without a binding |

A comment `# fwp:allow(code, ...)` in the comment lines directly above a
declaration silences those rules inside it:

```fwp
# kept for the next release
# fwp:allow(unused-binding)
legacy-total = map .amount | sum
```

### `fwp lsp`

`fwp lsp` is a language server that speaks the Language Server Protocol
over stdin and stdout. It supports:

- diagnostics: syntax errors (all of them, thanks to recovery at
  declaration boundaries), type errors and warnings, and lint warnings
  with their codes, refreshed on every change (full document sync;
  imports are read from disk);
- hover: the inferred type of the name under the cursor (a top-level
  name, an imported or standard library name) and, for a generic name,
  its type at that use;
- go to definition: top-level and imported names, types and constructors,
  and standard library names when `lib/` is next to the compiler's
  sources;
- document symbols: the top-level declarations;
- formatting: the whole document with `fwp fmt`;
- completion: the file's top-level names and the standard library's, with
  their types.

Any editor with a generic LSP client can use it: run `fwp lsp` for
`*.fwp` files. For Neovim (0.11 or later):

```lua
vim.filetype.add({ extension = { fwp = "fwp" } })
vim.lsp.config("fwp", {
  cmd = { "fwp", "lsp" },
  filetypes = { "fwp" },
  root_markers = { ".git" },
})
vim.lsp.enable("fwp")
```

For Helix, in `languages.toml`:

```toml
[[language]]
name = "fwp"
scope = "source.fwp"
file-types = ["fwp"]
comment-token = "#"
language-servers = ["fwp"]

[language-server.fwp]
command = "fwp"
args = ["lsp"]
```

VS Code has no built-in generic client. Either configure a generic LSP
client extension with the command `fwp`, the argument `lsp` and the file
pattern `**/*.fwp`, or use a minimal extension built on
`vscode-languageclient`:

```js
// extension.js; package.json declares "activationEvents": ["onLanguage:fwp"]
// and contributes a language "fwp" with the extension ".fwp"
const { LanguageClient } = require("vscode-languageclient/node");

let client;

exports.activate = () => {
  client = new LanguageClient(
    "fwp",
    "fwp",
    { command: "fwp", args: ["lsp"] },
    { documentSelector: [{ scheme: "file", language: "fwp" }] }
  );
  client.start();
};

exports.deactivate = () => client && client.stop();
```
