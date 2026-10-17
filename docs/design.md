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

Pipes stay data-last: `x | sub 1` means `x − 1`. Prefix calls and infix arithmetic
coexist: `x - 1` has the same numeric result. `x | f` applies a function and `f | g` combines
functions. If the left side is still unknown when its binding is solved, the
compiler selects application. Parentheses group nested arguments.

Every function takes one argument; its result may be another function.
`f x y` means `(f x) y`, and `A -> B -> C` means `A -> (B -> C)`.
A tuple is one value: `(A, B) -> C` takes a pair, while `A -> B -> C`
takes an `A` and returns a function taking a `B`. The library helpers `curry`
and `uncurry` explicitly convert between these shapes. Type inference does not
silently convert them. Native calls may combine successive applications and
eliminate temporary closures or tuples while preserving evaluation and effects.

Arithmetic has fixed precedence: calls, unary negation, `* / %`, `+ -`, then
pipes, from tightest to loosest. Binary arithmetic associates left to right;
parentheses override grouping. Operators use the existing standard arithmetic
traits, with operands evaluated left to right. Their syntax tree retains notation
for formatting while inference and specialization handle ordinary applications.
There is no separate numeric runtime or implicit numeric conversion.

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

## Combining hash and bitwise pipelines

A list pipeline can become one loop when running its stages element by element
preserves effects, termination and which trap occurs first. Structural `hash`
reads a finite immutable value without callbacks or language traps; its type
constraint excludes functions and resources. Integer `bit.and`, `bit.or`,
`bit.xor` and `bit.not` are also total: every valid input has a result. The existing
fusion analysis recognizes these contracts, so `map hash | fold bit.xor 0u64`
can avoid its intermediate result list. It keeps captured inputs alive through
the ordinary ownership rules. Hash still uses its runtime type description. Its separately reviewed nonescape
contract proves that the input object is used only during the call, allowing
existing stack placement for temporary tuples. Borrowing alone does not imply
this guarantee: other borrowed inputs can be returned or retained.

For a direct temporary tuple, ownership lowering can borrow its fields until
hash returns. Existing sequence rules keep every field owner alive while later
fields are evaluated. A later operation that consumes an alias must obtain its
own reference; a failure must still release pending owners. The independent
ownership verifier checks that counted fields have owners alive at the call,
and the backend builds a stack record without extra child references. Ordinary
escaping tuples still own their fields. Disabling stack placement retains the
ordinary counted representation for comparison.

A temporary tuple or its counted fields may have local names introduced by
simplification. The ownership pass can expose their sole, immediate hash use
across other plain local/field reads. It does not move calls, traps or resource
frames. Other uses preserve ordinary ownership, so keeping an alias or consuming
an owner later cannot turn a borrowed field into a dangling reference.

Bit shifts remain excluded from that proof because an oversized shift traps.
Effectful callbacks and distinguishable traps still prevent interleaving. This
adds no syntax or implicit conversion. A known callback's eager captures are
bound once in their original left-to-right order before input evaluation; the
existing specialization then sees direct calls. Capture bindings stay outside
the fused loop and cannot cross effectful or trapping consumer arguments.
Resource-bearing captures keep their original frames. A pure binding that returns
an immediately applied function can expose that call while keeping the binding
first; bindings that may contain resources retain their original boundary.
Specializing a known state callback also examines newly exposed callbacks, so a
fold inside that callback can call its known function directly. The same applies
to known callbacks of synchronous service helpers. Aggregate captures, including
purely constructed header lists, are bound once before the callback; specializing
a loop must not rebuild them on each element. Repeated callback
bodies share a specialization rather than expanding recursively. The handoff separates
implementation, focused checks and full acceptance; benchmarks retain the
unfused baseline.

## Combining F64 lane pipelines

F64 lane arithmetic and sums terminate without language arithmetic traps. Their
binary results use at most the common length of already valid input arrays.
Integer-to-F64 conversion is also total, although it may round. A splat creates
new storage: its proof applies only when the declared lane count fits the
existing array size limit on every supported target, including 32-bit WASI.
Other splat sizes and integer vector division do not receive this proof.

The existing pipeline analysis can therefore combine eligible F64 maps and
reductions into a loop, eliminating their intermediate lists. It still rejects
interleaving observable effects, unknown callbacks or distinguishable traps.
Arithmetic keeps its original lane/iteration order; this does not authorize
floating-point reassociation. When F64 multiply's result has a sole immediate
sum use, the compiler also combines those two operations without a product
vector. Input evaluation order and actual common-prefix length remain unchanged.
Each multiplication rounds before its addition; additions start with the first
product in lane order. An empty input prefix returns positive zero. A retained
product vector still has ordinary storage. The interpreter keeps materialized
products as an independent semantic reference.

Two consecutive splats can also disappear when their only uses are that first
direct dot call and both lengths satisfy the portable size proof. The compiler
binds each scalar input once, in its original order, then sums the repeated
product. It still evaluates both scalar expressions for an empty vector, while
performing no multiplication in that case. Retained vectors or intervening work
prevent this transformation. The product rounds once exactly as each identical
lane product would; the sum repeats additions in order rather than multiplying
by the lane count.

## Reading F64 vector lanes directly

An F64 lane occupies eight contiguous bytes in both ordinary arrays and array
views. Vector splats, arithmetic and sums can select the storage address once,
then read or write those bytes without repeating the representation check for
each lane. Byte copies respect C's aliasing rules; inputs remain borrowed from
live owners, and results use fresh owned arrays. This does not assume a manual
record's actual array length matches its declared lane count: binary operations
still use the common prefix. Boxed and other numeric formats retain their own
representation and cleanup rules.

Summation starts with the first lane, adds each later lane in order and returns
positive zero for an empty vector. It does not reassociate additions or insert
an initial addition to zero, which would change a singleton negative zero.
Native code and timing measurements determine whether a target compiler actually
emits vector instructions; this source change alone is not evidence of speedup.

## Constructing integer range arrays directly

`range lo hi` includes `lo` and excludes `hi`. When its only use is immediate
`array.from-list`, inline integer elements can be written directly into packed
array storage, without temporary list nodes. Bounds keep their original evaluation
order; equal or descending bounds produce an empty array. Wide intermediate
arithmetic checks the existing array size limit before converting to a machine
size, including on 32-bit WASI. Boxed I128/U128 elements keep their existing path.
The ordinary array-fusion comparison switch also controls this transformation.

## Borrowing array data inside loops

An array slice can store a pointer into another array rather than copying its
numbers. Reading it normally selects between that pointer and an ordinary
array's inline data. For a flat F64 array parameter passed unchanged through
every `Again` state, the compiler can select the data address once before the
loop. It still checks each index and keeps the array's existing owner alive.
Loops that replace their input array do not satisfy this proof. Narrow packed
and wider boxed element types retain their existing access rules.

This removes repeated representation checks without changing evaluation order,
adding a retain or changing floating-point operations. It does not assume that
all array loops are invariant. The [handoff](development-state.md) records
current compiler validation and performance evidence for this new change.

### Numeric lists immediately converted to arrays

The compiler recognizes `map f | array.from-list` when each mapped
result is an inline integer, F32 or F64. It runs the same callbacks in the same
order, stores their numeric results in temporary storage, then packs the array.
It avoids allocating list nodes that would immediately be discarded. Known
callbacks keep direct calls, including their captured values; unknown callbacks
use the ordinary dynamic call path. Input
aliases stay alive; failures release the temporary storage. Boxed numbers and
managed results keep their existing construction and cleanup rules. No new
language notation is introduced.

`FWP_MAP_ARRAY=0` disables this transformation for controlled comparisons;
`FWP_ARRAY_FUSION=0` disables it along with the other array transformations.
Semantic and cleanup checks passed on all six native hosts and in the full
[PR #149 gate](roadmap-history.md#owned-processes-and-numeric-mapped-arrays-pr-149); [benchmarks](benchmarks.md#building-numeric-arrays-without-temporary-list-nodes)
records the measured gains and limits.

### Numeric pairs immediately mapped

`xs | zip ys` pairs each `x` with the corresponding `y`, stopping when either
list ends. `map f` then calls `f` on each pair. The compiler combines these
steps for known callbacks and inline numeric inputs: existing `zip-with`
ownership handles the output, while a specialized callback can receive the two
numbers directly. This avoids temporary pairs and their list nodes. Result
values and their output list still need storage when they escape.

Both input lists are evaluated in the original order, followed by callbacks in
pair order. The transformation cannot move past an earlier call, trap or resource
region. Managed inputs stay on their existing path because changing their last
owner could change resource behavior. Existing fold and numeric-array consumers
get their optimization first; this later transformation must not reintroduce
list results they already eliminated. `FWP_ZIP_MAP=0` disables only this transformation
for controlled comparisons. [PR #150](roadmap-history.md#numeric-zip-intermediates-and-owned-listtext-results-pr-150)
records its full native acceptance.

Ordinary zip also protects its temporary buffers, completed pairs and each field
whose reference has already been duplicated. If a later retain fails, those
owners unwind without losing the borrowed input or leaking a partial result.
This cleanup applies independently of numeric pair elimination.

`unzip` splits a list of pairs into two lists. Its pending duplicated fields and
both partial lists stay owned until the outer result pair exists. A failure while
building the right list must also release the completed left list. Typed cleanup
preserves numeric bits without treating them as pointers.

Other list builders use the same owner records for pending elements and partial
results. `repeat` and `chunks` keep each duplicated field protected until its
node exists. `scan` and `iterate` keep earlier states alive while a callback
borrows the current state. Traps release completed states and temporary buffers.
These rules preserve callback and retain order; the handoff records acceptance
of the latest failure-cleanup repairs.

### Hashing borrowed values

`hash` computes FNV-1a over the existing typed binary encoding. Its native traversal
streams bytes directly into the hash state, preserving widths, little-endian
order, float bits and container order. It borrows arrays and nested fields without
allocating an encoded copy or adjusting their reference counts. The interpreter's
buffered encoder remains an independent reference. The handoff records acceptance;
allocation removal does not by itself establish a wall-time improvement.

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

When a record already exists as separate local fields, selecting its last-used
field can transfer that field's ownership and release only the discarded fields.
The new conversion path also checks whether a heap record has exactly one owner:
if so, its fields transfer to the receiving function and only the outer record
is freed. A shared record needs retained field references; a stack record keeps
its existing child-owner rules. The accepted tests include aliases, pointer-like
scalar bits, wide numeric boxes and failure cleanup. These rules remove specific
count operations; they do not prove every record or call allocation-free.

A function used as a value may receive a boxed record even when its compiled
body accepts separate fields. The entry code reads those fields before calling
that body. For a uniquely owned plain-data record, it transfers counted fields
and clears their old slots instead of acquiring duplicate owners. Shared records
still duplicate their counted fields. Cleanup protects the original arguments
and each prepared field until the body takes responsibility, including failure
partway through preparation. The outer record stays alive until the call ends.
Records containing resources retain their existing lifetime treatment. This
removes redundant count operations at eligible calls; the outer allocation and
runtime uniqueness check remain. Validation is tracked in the handoff.

The compiler also handles selecting a field from a consumed heap record
when that field is its only value needing reference-counted storage. A record
with one owner gives the selected value to its caller and frees its outer storage.
A shared record retains the selected value before releasing the caller's record
reference. Other fields must be scalars, with no cleanup to perform. Existing
stack, resource-scope and storage-reuse rules keep their current paths. Focused tests and real clients pass on all six native platforms;
[PR #157](roadmap-history.md#freed-requests-and-transferred-selected-fields-pr-157)
records production acceptance. Allocations and runtime ownership checks remain.

A function that only forwards a callback's tuple can keep its existing storage.
A callback is a function supplied by the caller; its concrete target may be
unknown during compilation. Such calls return a boxed tuple. Unpacking that
tuple into separate C fields and immediately boxing it again adds an allocation
without changing the value. The compiler avoids this conversion
when every return path forwards a callback result, including through local names
or branches. Functions that build records or make known direct calls retain their
existing choices. Alias, failure-cleanup and allocation checks passed with
[PR #154](roadmap-history.md#service-settings-and-iteration-storage-pr-154).

List `each` runs a callback from first to last and returns unit, written `()`.
Its definition, `const | flip fold ()`, uses unit as the running value
of `fold`. Here `const` ignores that running value and selects the supplied
callback; `fold` applies it to the next element. This replaces mapping to a list
of unit results and immediately discarding that list. It adds no primitive or
syntax. Tests compare output, aliases, state updates and early failures, and
measure allocations against the previous mapping definition. The
[benchmark guide](benchmarks.md) records the native measurements and their limits.

A closure contains a function and its already supplied arguments, called its
captures. Generated calls transfer or retain those values according to ownership
and their types. The runtime moves captures when consuming a closure
with one owner, both when supplying more arguments and when entering the function.
Shared closures still need additional owners for the captures used by that call.
The destination is prepared before transfer, and generated callee cleanup handles
failure after entry. This adds no language syntax or fields to the closure layout.
[PR #156](roadmap-history.md#released-stream-caches-and-moved-closure-captures-pr-156)
records full platform acceptance.

Shared top-level computed values have cached owners, released during teardown.
A type descriptor is runtime metadata used for operations such as equality,
printing and decoding.

The default native memory mode combines reference counting with a non-moving
tracing collector. Counting frees proved owned objects when their last owner is
released. Tracing starts from live roots (registers, stacks and globals) and
finds reachable shared objects. Minor collections inspect young objects plus
mutable storage; major collections trace the whole managed graph. Complete
immutable allocations must not acquire untracked links to younger objects.
[Ownership](ownership.md) explains these obligations and checked ARC mode.

Linux, macOS and Windows find roots through their platform's executable-image
and task-stack mechanisms. Native entry uses the operating system's thread-stack
limit. A frame pointer is a compiler's marker inside a function's stack storage;
it can lie below live temporary values and is not a safe limit for scanning.
WebAssembly cannot scan hidden host locals, and a
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

Client connection I/O tasks have one scheduler owner. Their records release
when execution finishes and their stacks and scheduler links have been removed;
this path needs no task reference-count updates. Language-visible task handles
retain the shared-owner policy because callers can keep independent aliases.
Server jobs also have explicit owners; the HTTP extension is under validation. Connection records
can outlive their sockets while response readers retain status information;
the pool, I/O tasks and callers hold separate storage owners. Library teardown
closes these connections before waiting for their tasks. The
[ownership guide](ownership.md) and [measured comparison](benchmarks.md#freeing-closed-connections-and-finished-tasks)
describe the limits. Checked gRPC client/service builds add iterator scope
checks and use these owners; [PR #161](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
records passing production acceptance. HTTP handler acceptance is separate.

The next HTTP client extension gives pooled connections, I/O tasks and requests
explicit owners. Responses are copied into typed fields and lists with cleanup
for partially built values. It also stores complete connection keys, including
TLS options, instead of truncating them in a fixed-size buffer. The server
extension owns the connection, request handles and writer tasks. Each handle
also carries its task payload, replacing two allocations with one. Handler
captures have one connection owner, borrowed by its request tasks; this owner
survives failure before child tasks finish. The reader's 64 KiB scratch buffer
stays on its stack because processing copies each chunk before the next read.
Platform checks and stack/memory measurements are pending;
[the handoff](development-state.md) tracks acceptance.

Accepted input ownership gives remote input iterators concrete destruction
metadata. Its cursor keeps the current element alive while advancing to the
next node and encoding that element. Synchronous cursors live on the stack;
background senders embed the cursor in their existing record. It
also resets requests on input-production and response-channel delivery failure,
matching the interpreter. Unique nodes transfer their continuation to the call;
shared nodes preserve it for older readers. All six focused native hosts pass
cleanup and semantic checks. [The comparison](benchmarks.md#input-owners-and-moves-bounded-memory-with-measured-count-costs)
records bounded memory and remaining count costs; [history](roadmap-history.md)
records production acceptance in PR #159.

The server keeps argument and typed-cleanup records on the stack,
calls each compiled method directly, and releases its arguments, result or error
through concrete generated destructors. Native output channels borrow sent values
and embed their callback payload after the channel header. Queue and callback
cleanup share alternative header fields; sends retain their direct callback
pointer. The [ownership guide](ownership.md) describes the lifetime rules, and
[history](roadmap-history.md) records production acceptance in PR #160. The next
checked ARC extension excludes tracing from eligible service binaries.

The same delivery gives server requests and connections explicit owners and
lets known fold callbacks borrow captures and collection elements while owning
their running result. A capture is a value kept by a function for a later call.
Borrowing removes count updates when the enclosing call already keeps that value
alive; values that escape still acquire owners. Socket shutdown wakes parked
readers explicitly on polling platforms. The combined implementation passes the
long-running Linux ARM64 memory check that failed with partial ownership, keeping
its original memory limit.

When a compiled program has no tasks or services, its runtime primitives omit
task-slice checks as well as function-entry checks. Programs that can schedule
tasks retain both. WebAssembly Asyncify's stack-bound checks remain active.
The blocked F64 matrix kernel uses fixed-size compiler copy intrinsics: they
preserve aliasing and alignment rules while exposing loads/stores to the C
compiler's vectorizer. Shape validation bounds each access; floating-point
accumulation order and separate multiplication/addition remain unchanged.

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

## Checked ARC execution

`--gc arc` asks the compiler to prove that supported values can be released by
automatic reference counting (ARC), without a tracing collector. It checks
concrete function/local types and runtime ownership contracts after reference
count insertion. Unsupported lifetimes produce a compile error; the compiler
does not silently switch to tracing.

Admitted programs include ordinary immutable values, scoped files and state,
proved derivative scopes, selected retained tasks, channels carrying data without
functions/tasks/channel handles, and scoped C calls. Mutable
cycles, raw pointers and unproved external callbacks remain excluded.
Checked ARC supports native main and function executables,
including CLI commands, and C libraries with copied inputs and pointer-free
results. Every library export is checked as a separate entry. Synchronous WASI
main/function/CLI entries use the same ownership checks and free counted storage
through their existing external count table. Checked gRPC clients and service
methods additionally prove when sent and received iterator steps run; the
[service guide](services.md#building-without-tracing-collection) explains the
command and current validation. HTTP client/server extensions are under validation.
Browser re-entry, WASI host fibers, REST and MCP entry points remain excluded.
HTTP stream handles cannot be queued through a channel in checked ARC: their
connection retains the handler, whose captures could contain that same channel.
The allocators still use metadata;
native allocation may retain reusable pages. See
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
