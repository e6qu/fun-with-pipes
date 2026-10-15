# How the compiler works

This guide is for contributors. Start with the [language tutorials](tutorials/README.md)
for syntax, then the [reference](reference.md) for exact rules. The compiler's
job is to preserve a program's results, external actions and failures while
removing unnecessary work. Fast execution is a goal supported by specific
[measurements](benchmarks.md), not a guarantee for every program.

The compiler is written in Rust without third-party Rust crates. Native programs
are generated as C and compiled by the system toolchain. Shared software libraries
supply some floating-point operations; see [formats](float-formats.md). The
interpreter runs the compiler's internal program representation directly.

## Pipeline

Each stage produces input for the next:

| Stage | What it does | Main source |
|---|---|---|
| Lex and parse | Turn text into tokens, then a tree of nested expressions; indentation continues declarations and groups match arms | `src/lexer.rs`, `src/parser.rs` |
| Expand macros | Run syntax-transforming functions before ordinary type checking | `src/macros.rs` |
| Infer types | Check values, trait requirements, effects and resource use | `src/infer.rs` |
| Specialize generics | Make a version of each generic function for its concrete types; this is called monomorphization | `src/mono.rs` |
| Lower to typed IR | Represent calls, branches and values in an intermediate representation (IR), keeping every local's type | `src/ir.rs` |
| Preserve resource lifetimes | Record where resources such as files must remain open, before optimization changes function structure | `src/resource.rs` |
| Optimize | Inline suitable calls, remove unused work, combine eligible loops and avoid temporary objects | `src/opt.rs`, `src/fuse.rs` |
| Check ownership | Insert and verify reference duplication/release operations | `src/rc.rs`, `src/ownership.rs` |
| Execute or generate C | Interpret the IR or emit C with the runtime support it needs | `src/interp.rs`, `src/cgen.rs`, `runtime/` |

`fwp run`, `exec`, `test`, `serve` and `pipe` compile native code by default and
cache it by content. The front end still runs to produce current diagnostics.
`--interp` selects interpretation. Both paths normally optimize; use
`FWP_NO_OPT=1` with `--interp` when checking an optimization against the original
operation order. Tests compare standard output, standard error and exit status.

## Syntax

Pipes stay data-last: `x | sub 1` means `x − 1`. Calls are prefix expressions;
there is no infix arithmetic. `x | f` applies a function and `f | g` combines
functions. If the left side is still unknown when its binding is solved, the
compiler selects application. Parentheses group nested arguments.

Selectors such as `.name` and `.0` are functions. Tuple positions start at zero.
A top-level declaration starts in column one; indented lines continue it.
`match`, `trait` and `impl` also have indentation-based forms. This does not make
arbitrary indentation an implicit function-argument group.

A `match` is a function that selects an arm. Each `_` in a pattern passes its
matched value to the arm, left to right. `const x` explicitly creates a function
that ignores its input and returns `x`; ordinary values do not automatically
become functions. See [constant functions](reference.md#constant-functions).

## Types and effects

Type inference solves constraints from uses, so ordinary expressions need few
annotations. A **row** describes fields or effects, possibly with an unknown
remainder. This lets `.name` work with different records that contain `name`.
Named records remain distinct types. Tuples are records with numeric labels;
unit `()` is the empty record.

Effects describe actions a function may perform, such as IO or failure. Every
function arrow has an effect row. A call may use a larger surrounding effect
context, but cannot silently widen the effects accepted by a nested callback.
The inference code must preserve required effects when unifying fields and
payloads. Handlers such as `attempt` and `run-state` remove the effect they handle.
Only the last arrow of a binding may have effects, so partial application does
not run that action early. Non-function top-level values must be pure, except
program/test entry points.

Type-level sizes make `Vector[F64, 3]` distinct from `Vector[F64, 4]`. Known size
expressions are solved at compile time. A size learned at runtime, such as the
length returned by `vector.from-list`, is abstract: each call introduces its own
size identity. Helpers such as `vector.same-size` check these sizes at runtime
and return an `Option` proving agreement. Static sizes remove those particular
checks; they do not make all vector operations free.

`Dup` means a value may be used more than once. Resource types such as `File`
lack that permission. Integer arithmetic checks overflow and division by zero;
wrapping, saturating, overflowing and checked-result operations are explicit
alternatives. Numeric conversions are explicit.

## Generics

A definition is generic only when its signature declares type variables. For
example, `swap : (a, b) -> (b, a)` works for pairs of different types; its body
`both .1 .0` exchanges the fields. Without a signature, `inc = add 1` has the
concrete type `I64 -> I64`. An otherwise unresolved generic definition is an
error with a suggested signature.

Specialization creates code for the concrete types used by the program. Trait
methods are selected during compilation, without passing a runtime table of
methods. This removes generic dispatch costs, but can increase compile time and
code size. It does not eliminate every heap object: generic entry points,
closures and containers can still use boxed values. A **box** is separate storage
holding a value that does not fit its immediate representation.

Recursion that would require infinitely many type specializations is rejected.
Effect variables can be generalized without an explicit signature because effects
are checked and erased before code generation.

## Runtime

The runtime supplies operations generated programs cannot express as simple C
arithmetic: allocation, strings, tasks, IO, decoding and derivative recording.
A primitive is a standard-library operation implemented in the runtime instead
of fwp. Its interpreter and native implementations must agree.

Generic native entries pass 64-bit `V` words. A word can hold an inline scalar,
a small constructor tag, or an address. Type information determines which it is;
number bits that resemble an address must not be reference-counted as a pointer.
Specialized numeric functions use concrete C types instead. Records, variants
and partially applied functions may need heap objects, but eligible local values
can remain as separate fields, C structs or stack storage.

A closure contains a function and its already supplied arguments. Generated
calls retain/release captured values according to their types. Shared top-level
computed values have cached owners, released during teardown. A type descriptor
is runtime metadata used for operations such as equality, printing and decoding.

The default native memory mode combines reference counting with a non-moving
tracing collector. Counting frees proved owned objects when their last owner is
released. Tracing starts from live roots (registers, stacks and globals) and
finds reachable shared objects. Minor collections inspect young objects plus
mutable storage; major collections trace the whole managed graph. Complete
immutable allocations must not acquire untracked links to younger objects.
[Ownership](ownership.md) explains these obligations and checked ARC mode.

Linux, macOS and Windows find roots through their platform's executable-image
and task-stack mechanisms. WebAssembly cannot scan hidden host locals, and a
native library cannot discover arbitrary host roots. Those modes free counted
owners but retain unproved shared graphs. Disabling collection is not a lifetime
proof. Resource cleanup also runs on failure, traps and task cancellation.

Native tasks are cooperatively scheduled computations on one event loop, with
function-entry preemption to let ready tasks run. Kernel worker threads are a
separate mechanism for numeric CPU parallelism. Interpreter tasks take turns
using a scheduling baton. Inlining can change the number of function entries;
wall-clock timers do not define an order between independent actions. Use a
channel or await when ordering matters. [Concurrency](concurrency.md) gives the
user-visible behavior and platform implementation.

## Numerical specialization

The optimizer removes work only when doing so preserves observable behavior:

| Optimization | Work it can remove | Important limit |
|---|---|---|
| Scalar replacement | Building a record that is only read field by field | A whole-value use may still need the record |
| Direct numeric workers | Boxing and generic word conversion at suitable calls | Closures and other generic boundaries keep conversion code |
| List/array fusion | Intermediate collections between eligible map/filter/consumer stages | Interleaving must preserve effects, termination and which trap occurs first |
| Iterator specialization | Tail closures and indirect calls for known producers/consumers | Early stopping and successor lookahead remain observable |
| Flat loop state | Rebuilding state tuples on each iteration | Unsupported shapes keep ordinary state representation |
| Variant returns | Building `Some`/`Ok` only to immediately inspect it | Unknown whole-value consumers may require a box |
| Blocked matrix multiplication | Poor locality and generic loop overhead | Preserve multiplication/addition order and shape semantics |

The F64 matrix path uses blocks of 32 over contiguous arrays, checks dimensions
once and allocates one output. Each element accumulates in ascending inner-index
order. Multiply and add remain separate: contraction into a fused instruction
could change rounding. Malformed shapes admitted through `matrix.cast` retain
the existing library behavior rather than entering the specialized path.

Automatic differentiation (AD) records operations so a backward pass can compute
derivatives. Numeric tapes store two parent indices and two local derivatives
per operation, excluding the original inputs. Backward numeric storage ends at
the last requested output, since later nodes cannot affect it. Forward work and
its possible failures still run. Nested differentiation stores typed derivative
values that can themselves record operations.

The native parent arrays share one allocation, and numeric derivative arrays
share another. Only the base pointers own storage. Growth preserves initialized
entries, alignment and cleanup if allocation fails. The table of active tapes
grows geometrically; a search cursor skips slots already known to be unavailable.
Arbitrary holes can still require a linear scan. A single detached numeric
workspace may retain at most 512 KiB; the table's capacity is separate.
[Numerics](numerics.md) defines tokens, precision and scope rules;
[benchmarks](benchmarks.md) records saved allocations and mixed timing results.

## Checked native ARC execution

`--gc arc` asks the compiler to prove that supported values can be released by
automatic reference counting (ARC), without a tracing collector. It checks
concrete function/local types and runtime ownership contracts after reference
count insertion. Unsupported lifetimes produce a compile error; the compiler
does not silently switch to tracing.

Admitted programs include ordinary immutable values, scoped files and state,
proved derivative scopes, selected retained tasks and scoped C calls. Mutable
cycles, raw pointers, unproved external callbacks and remote/service contexts
remain excluded. Checked ARC supports native main and function executables,
including CLI commands; WebAssembly and library entry points are outside this
mode. The allocator still uses metadata and may retain reusable pages. See
[the precise memory contract](ownership.md#checked-arc-delivery).

## Executables and the pipe protocol

An exported function can become a standalone executable. Leading parameters
come from command-line arguments; the last can come from standard input.
A first record parameter becomes named flags. Interface comments select CLI,
REST or MCP exposure; `export` alone only makes a definition visible to modules.
[Interfaces](interfaces.md) compares these choices.

Between fwp executables, the binary stream sends a version, a type description
and its fingerprint (a compact identity), followed by length-delimited values.
An incompatible peer is rejected before decoding. The interface is named
`PIPE_V1`, but its current value-encoding version is 2. See [the byte-level
protocol](protocol.md); the names are not interchangeable.

## Builds

| Output | Entry or guide |
|---|---|
| Native executable | `fwp build file.fwp -o program`; includes reachable runtime code and links required system libraries |
| One exported function | `--fn name`; [process input/output](protocol.md) |
| Command-line application | `--cli`; [CLI guide](cli.md) |
| REST or MCP server | `--rest` or `--mcp`; [REST](rest.md), [MCP](mcp.md) |
| Split services | `--service module`; [service deployment](services.md) |
| C library and header | `--staticlib` or `--cdylib`; [C interop](reference.md#c-interop) |
| WebAssembly program | `--target wasm32-wasi` or `wasm32-browser`; [targets](reference.md#targets) |
| Compiler/interpreter in a browser | Rust `wasm32-wasip1` build and JavaScript host; [browser tutorial](tutorials/15-browser/README.md) |

Compiler packages contain one binary per operating system and processor family.
`--fat` is a separate option for selecting among x86-64 instruction levels at
startup; it is not a macOS universal-binary requirement.

## Not implemented

Removing tracing GC and reducing ARC overhead are active goals in the
[project plan](../PLAN.md). General collector-free execution is not implemented.
A just-in-time compiler (JIT) is explicitly excluded from the project direction;
native fwp functions compile ahead of execution. The existing OpenCL device
path builds kernels at runtime; resolving that conflict is part of the numerical
work in the plan, not authorization to add a language JIT. A replacement backend
and distributed tensor execution remain deferred. Existing device kernels handle
elementwise expressions and sums, not arbitrary matrix operations. OpenCL
discovery/source tests do not establish execution on real GPU hardware.

Darwin cross-compilation and Clang profile-guided optimization are not supported.
WebAssembly target effects and host capabilities are limited as described in the
reference. HTTP/3, WebSocket over HTTP/2 and unlisted transport extensions are
not implemented; use the individual networking guides for exact limits.

## Ownership implementation

Keep one ownership contract inventory in `src/ownership.rs`, used by both
reference-count insertion and C generation. Borrowing, consuming, retaining and
returning aliases have different meanings. A successful output test alone cannot
prove those lifetimes. Changes need alias, failure, cancellation and deliberate
missing-cleanup controls as well as collector/reuse verification. The detailed
[primitive tables](primitive-ownership.md) and [ownership guide](ownership.md)
are the maintained source of those rules; old PR-by-PR notes belong in
[delivery history](roadmap-history.md).

## Wide scalar workers and float formats

Eligible I128/U128 functions use direct wide arguments and results; generic
containers still hold counted boxes. F16/BF16 arrays use two bytes per element,
F128 arrays sixteen. Closed F128 workers pass bit structs. The C calling
convention decides which values use registers and which spill or return through
memory. Source-level structs do not prove register placement: inspect generated
assembly for the actual target. [Float formats](float-formats.md) specifies
rounding, conversion, alignment and binary transport.
