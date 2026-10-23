# How the compiler works

This guide is for contributors. Start with the [language tutorials](tutorials/README.md)
for syntax, then the [reference](reference.md) for exact rules. The compiler's
job is to preserve a program's results, external actions and failures while
removing unnecessary work. Fast execution is a goal supported by specific
[measurements](benchmarks.md), not a guarantee for every program.

The compiler is written in Rust; terminal editing and interrupt handling use
Rustyline and ctrlc. Native programs
are generated as C and compiled by the system toolchain. Shared software libraries
supply some floating-point operations; see [formats](float-formats.md). The
interpreter runs the compiler's internal program representation directly.

## Pipeline

For parser theory, precedence, desugaring and macro execution, read
[From source text to a running program](compiler-pipeline.md). The table below
is a navigation summary; specialization and IR lowering happen together.

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
Native commands accept explicit `--gc arc` or `--gc tracing` settings; interpreted
commands reject those native-only settings. Native test execution checks every
test entry before running and releases caught error values and formatting buffers.
A missing C compiler is an error; choose `--interp` explicitly to use the evaluator.
The executable cache includes the selected C compiler's version, target and
header-search environment for integer-only programs as well as floating-point
programs. Exact floating-point programs also include their C++ compiler identity;
integer-only programs do not require a C++ compiler.
For linked C or preprocessed assembly sources, the cache also fingerprints the
expanded source so changes to included headers invalidate the executable. A
missing header reports a compile error even when an older executable is cached.
Concurrent compilers build private files and briefly lock cache publication.
The first complete image keeps its content-addressed name; another compiler
discards its duplicate instead of replacing a running executable. The lock is
released when its handle closes, including process termination, using Rust's
[file-lock contract](https://doc.rust-lang.org/std/fs/struct.File.html#method.lock).
Cache hits update usage timestamps without opening executable data for writing.
Windows requests the specific [attribute-write access](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-setfiletime)
required for that metadata update.
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

Operators have fixed precedence: calls, unary negation, `* / %`, `+ -`,
comparisons (`== != < <= > >=`), then pipes, from tightest to loosest.
Comparisons do not chain without parentheses. Binary arithmetic associates left to right;
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
When a handler accepts a callback with `{Error[x] | e}` and returns a function
with `e`, the two uses of `e` must stay related. For example,
`attempt (apply ())` takes a function, calls it with unit and catches its error;
the result must not still require that handled error. Adding `Error` only to a
temporary callback type would lose this relationship when the callback's input
is itself a function. Argument checking preserves these shared rows, including
handlers returned inside records. Returning a function produces a value;
accepting one consumes a value. The check follows that direction through record
and variant fields, rather than treating every occurrence of the same effect
variable as a returned effect. It still rejects unrelated required effects,
such as IO under an error handler. The [runnable regression](../tests/fixtures/handled_callbacks.fwp)
covers these cases. The [focused acceptance report](measurements/queued-callbacks.md)
records passing native and WASI checks;
[PR #184](roadmap-history.md#queued-socket-callbacks-and-handler-inference-pr-184)
records full production acceptance.
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

Generated C must also avoid overflowing an intermediate before the language's
check runs. For example, multiplying two `U32` values uses an unsigned 64-bit
intermediate: `4294967295 * 4294967295` fits there, but exceeds signed 64-bit
range. The compiler then checks the result against `U32`'s maximum and traps.
Dynamic-input tests compare the unoptimized interpreter with native execution;
C's undefined-behavior sanitizer checks the emitted multiplication, with the
former signed intermediate as a control that must fail.

For signed 64-bit multiplication (I64 and ISize), generated C keeps the overflow
check and returns the safe `x*y` expression afterward. This exposes operand
bounds that GCC can lose through the overflow builtin's output variable. Both
operands are already evaluated; no source effects repeat. The expression is
reached only when its product fits. The [checked-product measurements](measurements/checked-products.md)
show the O2 benefit, the extra product emitted at O0/O1, correctness controls and
remaining C/Rust gaps. This is not a promise of improvement for every program.

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
the ordinary ownership rules. Numeric layouts can use the
[specialized traversal](#hashing-numeric-layouts-without-repeated-type-dispatch);
other layouts use a runtime type description. A separate nonescape contract
proves that the input object is used only during the call, allowing
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
bodies share a specialization rather than expanding recursively.
[Hash measurements](benchmarks.md#hashing-values-without-constructing-their-encoded-bytes)
retain the unfused baseline and the remaining costs.

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

### Constructing integer range sets directly

`range -2 3 | set.from-list` produces `set{-2, -1, 0, 1, 2}`. Its integers
are already ordered and distinct. For an immediately consumed range of inline
integers (I8 through I64, U8 through U64, ISize and USize), the compiler writes
the keys directly into one owned set buffer. It avoids the temporary list and sorting buffers.
This internal operation is called `set._range`; it is not a new library API.

Both bounds retain their original evaluation order. Equal or descending bounds
return the static empty set. Wide intermediate arithmetic checks the complete
container size before converting to a target-sized integer, including on 32-bit
WASI. Once allocation succeeds, filling inline keys cannot call user code,
allocate or fail. Boxed I128/U128 keys keep ordinary construction. Aliased lists
also keep their storage; the transformation requires an immediate range input.
`FWP_MAP_BUILD=0` disables this transformation for controlled comparisons.
[PR #173](roadmap-history.md#direct-integer-range-sets-pr-173) records acceptance.

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
all array loops are invariant. [Controlled measurements](benchmarks.md#selecting-invariant-array-data-once)
separate this optimization from changes in runner hardware/load.

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

### Building numeric maps and sets without temporary lists

A map stores one value for each key; a set stores distinct keys. For example,
`range 0 4 | map (rem 3) | set.from-list | set.to-list` produces `[0, 1, 2]`:
the callback produces `0, 1, 2, 0`, and the set removes the duplicate zero.
When map input contains duplicate keys, the first key and last value survive.

The compiler now combines `map f | map.from-list` or `map f | set.from-list`
when the stored fields are integers, F32 or F64 held directly in machine words
rather than separate heap objects. It runs every callback
in input order, writes the numeric fields into temporary buffers, then sorts
and removes duplicates. An immediate I64 `range` can supply numbers directly,
without allocating its input list. Other list sources remain borrowed, so their
aliases stay alive. Boxed numbers and managed result fields keep their existing
construction rules. This changes no language notation or inference rule.

When an ordinary map callback is known at compile time, its generated function
can return the two numeric fields directly, avoiding temporary tuples. This uses
the compiler's existing field-return calling convention. Known set callbacks
also call their existing owned function entry directly, avoiding general function
dispatch per item. This includes primitive callbacks and their argument cleanup.
Captured values still use
ordinary argument ownership and may need reference-count operations. Dynamic
callbacks use their normal call convention and can still allocate result tuples;
they share the same protected buffer construction. Errors and task
cancellation release unfinished buffers. Empty or reversed ranges call no
callbacks; duplicate handling and floating-key ordering remain unchanged.

Map construction now uses two temporary allocations. Each stores a key lane
followed immediately by a value lane, with one owner for both. Sort scratch uses
the same layout. This removes separate-allocation gaps and unused sentinel words;
size guards check the complete byte count before allocation. Sets use one key
lane in each allocation, sharing the sorter's key/value lanes rather than storing
unused values. The sorter copies shared output lanes once. Ordinary typed maps
use the joined layout too, and empty maps avoid scratch allocation. Both forms
allocate the final exact-size owned container after sorting. Peak storage grows with input length even when
most keys are duplicates. Small integer fields still occupy full words.
Final sets now store one word per key, while maps store a key/value pair per entry.
Both have an eight-byte length header. For example, a newly built three-key set
requests 32 bytes instead of the previous 56; allocator metadata, padding and any
separately allocated keys add to this amount. Unique insertion may reserve extra
capacity. [The ownership contract](ownership.md#compact-set-storage) explains
shared updates and cleanup;
[PR #172](roadmap-history.md#compact-set-storage-pr-172) records acceptance.

`FWP_MAP_BUILD=0` disables this transformation for controlled comparisons.
Focused local checks cover raw/optimized interpretation, native O1/O2, ARC,
stressed tracing, aliases, every injected allocation failure and cancellation.
The [six-host measurements](benchmarks.md#building-numeric-maps-and-sets-without-temporary-lists)
verify the joined layout, allocation counts and actual instructions.
[PR #166](roadmap-history.md#numeric-map-and-set-construction-pr-166) records full
production acceptance. Its large-map Xeon slowdown was subsequently repaired
for the measured workload by [cached-map borrowing](benchmarks.md#rechecking-the-original-xeon-slowdown).
Other layouts and workloads can still be slower; reduced allocation counts do
not establish universal speed gains.

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
These rules preserve callback and retain order; [delivery history](roadmap-history.md)
records acceptance of the failure-cleanup repairs.

### Hashing borrowed values

`hash` computes FNV-1a over the existing typed binary encoding. Its native traversal
streams bytes directly into the hash state, preserving widths, little-endian
order, float bits and container order. It borrows arrays and nested fields without
allocating an encoded copy or adjusting their reference counts. The interpreter's
buffered encoder remains an independent reference. [PR #151](roadmap-history.md#synchronous-wasi-ownership-and-streaming-hashes-pr-151)
records acceptance; allocation removal alone does not establish a timing improvement.

### Hashing numeric layouts without repeated type dispatch

For example, hashing `(3, range 0 16 | array.from-list)` reads the eight-byte
integer `3`, the array length and sixteen eight-byte elements. Those types are
known when C is generated. The compiler can emit that traversal directly instead
of asking the general hash visitor to identify each element's type at runtime.

This covers inline integers, F32/F64, flat numeric lists/arrays/sets,
maps with numeric keys and values, and records composed of those types. Other
representations keep their existing descriptor traversal. It introduces no
new source syntax. `FWP_TYPED_HASH=0` selects general traversal for comparison.

The generated loops retain the canonical encoding: unsigned LEB128 lengths,
little-endian scalar bytes, original floating-point bits and key/field order.
Packed and full-word arrays use their respective storage widths; slices borrow
their existing data address. Hashing adds no owners or temporary encoded buffer.
The [measurements](benchmarks.md#numeric-hash-specialization) retain native/WASI
checks, matching allocation counts for specialized/general traversal and mixed
timing results against C/Rust. Direct output separately removes a temporary
String. Removing dispatch does not guarantee a speed improvement.

### Printing integers without an owned temporary

The direct-output preparation recognizes an immediately consumed integer
`show | print`, including `echo` after inlining. Before ownership lowering adds
String temporaries, it replaces that pair with a typed backend-only print
operation that borrows the integer and returns unit. It formats into a 24-byte local
buffer, then writes the same digits and newline to the program output stream.
For example, `-17 | echo` prints `-17` on one line without requiring an owned
String solely for that print. The argument still evaluates before output.
Shared strings and displays for other types keep their normal evaluation.
This removes one managed allocation; it does not promise allocation-free libc
IO or a timing improvement. The [report](measurements/integer-output-2026-10-20.json)
records the six-host checks and actual code sizes;
[PR #174](roadmap-history.md#numeric-hashing-and-integer-output-pr-174)
records production acceptance.
The combined `hash` evidence suite checks all six native hosts. Once it passes,
`integer-output-report` takes its `evidence_run` and full `source_revision`, checks
all 76 hash, output and neighboring ownership tests on each host, and inspects
the 144 saved output semantic-test binaries.
Allocation counts come from a separate test that detects an intentionally added
String. The report does not infer whole-process heap use from that narrower check.

### Measuring integer text without building it

`show | string.length` asks how many characters an integer's decimal display
would contain. For example, applying it to `-17` returns `3`: the minus sign and
two digits. Native lowering can count those characters directly, without owning
a temporary String. The same rule handles concatenations of integer displays
and literal text: `show | concat "é🙂" | string.length` returns `5` for `-17`.
Literal lengths count Unicode scalar values, as ordinary `string.length` does.

`src/cgen/scalar_text.rs` performs this rewrite before ownership lowering adds
temporary locals. It handles signed and unsigned integers up to 64 bits and
preserves the order of integer-producing expressions, including their effects
and traps. A static bound proves that combining the lengths fits I64; the
generated sum still uses ordinary checked addition. Shared strings, unknown
string producers, floating-point displays and wider integers keep their storage.
The private integer-length operation has no source-language declaration.
Its scalar runtime counts decimal digits in descending groups of 16, 8, 4, 2
and 1. Signed values use unsigned magnitude and add one for the minus sign, so
I64's minimum does not require an overflowing signed negation. Ordinary inline
hints allow the C compiler to combine counting with its caller; they do not force
inlining. [Controlled comparisons](measurements/integer-counting.md) record the
algorithm, call/size tradeoffs and current validation.
The [Linux measurements](measurements/integer-text.md) record zero managed leaf
allocations in the probe, actual machine code and comparison with direct
character counting in C/Rust.
[PR #180](roadmap-history.md#function-channel-borrows-and-integer-text-pr-180)
records production acceptance; PR #182 subsequently improved digit counting.

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

Two C pointers **alias** when they can access the same storage. C compilers may
assume that pointers to unrelated structure types do not alias, even if the
structures have identical field offsets. fwp emits fixed-size structures for
stack and static values, then accesses them through runtime structures with
variable-length trailing arrays. Those views need an explicit aliasing contract.

The object, closure, string, array and map view types use `__may_alias__`, supported
by [GCC](https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html) and
[Clang](https://clang.llvm.org/docs/UsersManual.html). Their pointers can then
access the concrete generated structures without allowing the optimizer to
discard the stores that initialized them. Field sizes, offsets and alignment
remain the same. This annotation changes compiler assumptions and adds no runtime
operation; its effect on generated code and performance still needs measurement.
Strict alias analysis remains enabled elsewhere. Byte reinterpretation, such as
floating-point bits and packed array loads, continues to use `memcpy`.

Errors use C's `setjmp` to save a handler and `longjmp` to return to it after
releasing pending owners. C does not guarantee the value of a changed,
non-volatile automatic object after that jump
([C11 draft §7.13.2.1](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf)).
The error value and its type descriptor are therefore volatile fields. Task
scopes also keep their changing child list, count and capacity volatile: failure
must still find every spawned task to cancel, join and release it. Unchanged
links and saved depths do not need this qualification. This adds no heap object
or source-language rule; it constrains C optimization of those accesses.

When a record already exists as separate local fields, selecting its last-used
field can transfer that field's ownership and release only the discarded fields.
The new conversion path also checks whether a heap record has exactly one owner:
if so, its fields transfer to the receiving function and only the outer record
is freed. A shared record needs retained field references; a stack record keeps
its existing child-owner rules. The accepted tests include aliases, pointer-like
scalar bits, wide numeric boxes and failure cleanup. These rules remove specific
count operations; they do not prove every record or call allocation-free.

Known numeric `array.generate` callbacks can borrow their captures while the
caller keeps them alive throughout generation. The compiler lowers the callback
body with that ownership contract; escaping uses acquire their own owners.
The existing partial-array builder handles errors and cancellation. Recursive
callbacks and resource scopes keep their ordinary calling convention.

A temporary record of caller-borrowed parameters can disappear when every use
projects a field or passes it to a proved nonescaping call. Alias normalization
then uses the caller's whole-call lifetime, including the last local read.
Whole-record escapes and resource boundaries preserve ordinary owners; returning
a projected field acquires ownership. Eligible numeric-array aliases qualify;
algebraic list aliases retain their existing representation. The
[application measurement](measurements/array-capture-descent.md) verifies zero
retains in repeated packed descent on both Linux architectures. The
[six-host ownership checks](measurements/array-capture-borrows.md) cover effects,
shared inputs and cleanup; the [handoff](development-state.md) tracks final gates.

A dying stack record can also transfer its sole counted numeric-array field.
The compiler requires one tracked child owner, a matching `Array` of inline
machine numbers, scalar siblings and no protected resource slot. The underlying
array may have other owners: moving this record's reference does not alter them.
This removes a duplicate/release pair around projections such as `(weights, i) | .0`.
The ownership pass must still show that the record is consumed at that point;
nested stack aggregates and resource lifetimes keep their separate rules.
[Focused checks](measurements/stack-array-ownership.md) pass on all six native
platforms, including aliases, failure and cancellation. Timing and delivery
acceptance are recorded separately in the [handoff](development-state.md).

The variant-matching change applies the same move principle to a
constructor with one payload already held in local fields. If a match arm begins
by retaining that payload and immediately releasing the variant, the payload can
keep its existing owner. For example, consuming `Some text` can return `text`
without increasing and immediately decreasing its count. Another live owner of
`text` keeps its existing count. Boxed variants, multiple fields and protected
resource slots retain their existing lowering. The compiler keeps the original
remaining expression nodes so failure-cleanup plans still identify their scopes.
[Focused checks and measurements](measurements/channel-variant-moves.md) pass
on Linux ARM64/AMD64; broader ownership checks pass on all six native platforms
and both WebAssembly hosts.
[PR #179](roadmap-history.md#matched-payload-moves-and-direct-call-borrows-pr-179)
records production acceptance.

A function used as a value may receive a boxed record even when its compiled
body accepts separate fields. The entry code reads those fields before calling
that body. For a uniquely owned plain-data record, it transfers counted fields
and clears their old slots instead of acquiring duplicate owners. Shared records
still duplicate their counted fields. Cleanup protects the original arguments
and each prepared field until the body takes responsibility, including failure
partway through preparation. The outer record stays alive until the call ends.
Records containing resources retain their existing lifetime treatment. This
removes redundant count operations at eligible calls; the outer allocation and
runtime uniqueness check remain. [Delivery history](roadmap-history.md) preserves
the accepted revisions and their validation scope.

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

In current preparation, generic call adapters are emitted only for function
values and external dispatch. An adapter accepts the runtime argument array and
calls a concrete function. A direct call already knows that function and does
not need this extra entry. For example, `read-all () | string.length | add 7`
needs direct operations; a function selected at runtime and later applied still
needs an entry. Service methods and transport-created iterators explicitly keep
their entries. Numeric array callbacks whose captures are borrowed use their
specialized body directly. The [initial comparison](measurements/direct-call-entries.md)
measures smaller code and preserves inconclusive timing.

The expanded preparation also keeps eligible `array.generate`, `fold` and
`fold-right` captures in separate local variables. A capture is an argument
already supplied to a partially applied function. If every use of that local
function is a known generator/fold callback, no function record is needed.
Capture expressions still run at their original binding, before later count or
input expressions. Existing typed child-owner cleanup handles drops and unwind;
explicit lifetime barriers keep captures alive through allocating calls. Escapes,
aliases, ordinary function application, resource frames and recursive tail frames
keep their existing representation. Disabling stack representations disables this
change too. Borrowing-eligible folds also avoid otherwise unused generic entries.
[The numerical comparison](measurements/callback-locals.md) records smaller code;
[the handoff](development-state.md) distinguishes preparation from verified support.

A partial application supplies some arguments now and returns a function waiting
for the rest. Some such functions contain only fixed references to other
functions. For example, `neg | abs` composes integer negation with absolute value;
passing that composition around need not allocate a fresh function record.
The compiler now places eligible records in static program storage and shares
equal records. Each capture must itself be a fixed function with no captures.
Runtime data, zero-argument evaluation and fully supplied calls keep their
existing evaluation and ownership rules. No effect runs early.

These records use the ordinary closure layout. Their capture addresses are filled
during existing constant initialization, including on 32-bit WebAssembly, where
a widened pointer cannot use the same C static initializer as a native address.
They own no runtime data and need no heap allocation or reference count. Generic
calls and their ownership checks can still have costs; this does not make every
function call free. Static storage and startup stores also have costs. The
[measurements](benchmarks.md#fixed-function-values-in-the-http-server) report
those costs; [PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records full platform acceptance.

Shared top-level computed values have cached owners, released during teardown.
For numeric maps, ownership lowering can introduce `BorrowGlobal`: an internal
binding that uses the cache owner directly during a verified read span. This
removes per-read retain/release operations without changing source syntax.
Initialization still happens at the original read and may fail or yield before
the borrow begins. The span permits numeric calculations and map reads, but no
unknown callback, suspension, escape or reentrant destruction while the borrowed
value is needed. Verification repeats the check after cleanup insertion.
Tuple and variant result generation must traverse this binding without creating
intermediate heap objects. See [the contract](ownership.md#cached-numeric-map-reads)
and [measurements](benchmarks.md#compiler-proved-cached-map-reads).
A type descriptor is runtime metadata used for operations such as equality,
printing and decoding.

Explicit `--gc tracing` combines reference counting with a non-moving
tracing collector. Counting frees proved owned objects when their last owner is
released. Tracing starts from live roots (registers, stacks and globals) and
finds reachable shared objects. Minor collections inspect young objects plus
mutable storage; major collections trace the whole managed graph. Complete
immutable allocations must not acquire untracked links to younger objects.
Reuse checks read the allocator's actual age representation: a per-slot bitmap
for small objects and a separate mark for large allocations. A constructor that
holds storage across another allocation rechecks its age before writing fields.
Mutable arrays are scanned each minor collection and have a separate reuse rule.
[Ownership](ownership.md) explains these obligations and checked ARC mode.

Linux, macOS and Windows find roots through their platform's executable-image
and task-stack mechanisms. Native entry uses the operating system's thread-stack
limit. A frame pointer is a compiler's marker inside a function's stack storage;
it can lie below live temporary values and is not a safe limit for scanning.
WebAssembly cannot scan hidden host locals, and a native library cannot discover
arbitrary host roots. In explicit tracing mode, they free counted owners but
retain unproved shared graphs. Default checked ARC instead rejects unproved
ownership and requires checked host boundaries. Disabling collection is not a
lifetime proof. Resource cleanup also runs on failure, traps and task cancellation.

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
Server jobs also have explicit owners, including the accepted HTTP extension. Connection records
can outlive their sockets while response readers retain status information;
the pool, I/O tasks and callers hold separate storage owners. Executable and library teardown
close these connections before waiting for their tasks. The
[ownership guide](ownership.md) and [measured comparison](benchmarks.md#freeing-closed-connections-and-finished-tasks)
describe the limits. Checked gRPC client/service builds add iterator scope
checks and use these owners; [PR #161](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
records passing production acceptance; HTTP handlers are accepted in
[PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163).

Accepted HTTP client support gives pooled connections, I/O tasks and requests
explicit owners. Responses are copied into typed fields and lists with cleanup
for partially built values. It also stores complete connection keys, including
TLS options, instead of truncating them in a fixed-size buffer. The server
extension owns the connection, request handles and writer tasks. Each handle
also carries its task payload, replacing two allocations with one. Handler
captures have one connection owner, borrowed by its request tasks; this owner
survives failure before child tasks finish. The reader's 64 KiB scratch buffer
stays on its stack because processing copies each chunk before the next read.
Six-host binary and server-memory evidence, with Linux stack measurements, is in the
[measurement report](benchmarks.md#http-server-ownership-and-memory);
[PR #163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records acceptance.

The server measurement also exposed periodic socket retry delays on macOS and
Windows. Their scheduler now queries all parked sockets together with poll or
WSAPoll, using the next real deadline as the timeout; preemption checks without
waiting. Stack-local wait records unlink before cancellation unwinds. A reusable
leaf array holds only OS descriptors/events and is released when the last waiter
leaves. Local close still wakes waiters explicitly, including before descriptor
reuse. The server-ownership delivery includes this repair and its native platform checks.

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
through concrete generated destructors. A typed send consumes a message owner;
native output callbacks borrow that value only for the duration of the callback
and keep their callback payload after the channel header. Queue and callback
cleanup share alternative header fields; sends retain their direct callback
pointer. The [ownership guide](ownership.md) describes the lifetime rules, and
[history](roadmap-history.md) records production acceptance in PR #160. Checked
ARC also excludes tracing from eligible service binaries.

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

The [direct-await lowering](measurements/task-await-fields.md) exposes an
immediately matched task result as tag/payload fields. It removes the temporary
Option box while retaining the cached task result for other handles and later
awaits. The measured fixture removes 34 allocation requests on all six native
platforms without reducing retains or peak storage.
[PR #191](roadmap-history.md#task-results-and-explicit-cpu-execution-pr-191) records
acceptance. Options that escape the direct match retain their ordinary representation.

## Compile-time values in static storage

A value produced by `comptime` is already known when C is generated. For example,
`table = comptime ([1i8, 2i8] | array.from-list)` needs storage for two bytes and
an array header, but does not need to allocate that storage on the heap at startup.
The current change places compound constants, wide numeric literals and closures
with constant captures in static program storage. Strings already use this model.
Compile-time evaluation may read files, but its result cannot contain an open
file or another runtime handle. Such handles belong to the compiler process;
return file contents or other ordinary data instead. Nested containers and
captures follow the same rule, checked before embedding constants.

Records and variants keep their tag/count headers. Arrays preserve the selected
packed or word layout; F128 elements keep all 128 bits. Maps keep their sorted
interleaved keys and values. Signed and unsigned 128-bit scalar globals have the
alignment of their C types. Pointer fields are filled during existing constant
initialization, which also works on wasm32 without widening pointers in C static
initializers. Every child of these graphs is itself a compile-time value.

These objects have no heap ownership count and cannot be uniquely reused.
Updating a constant array or map creates owned storage and leaves the constant
unchanged. Program data size and initialization stores remain costs; this is not
zero memory use or a claim that all cached values avoid allocation. Values computed
at runtime retain their existing ownership rules.
[PR #169](roadmap-history.md#static-constants-and-complete-shutdown-checks-pr-169)
records acceptance of static constants and complete cleanup.

## Tail calls and recursion

A tail call returns the called function's result without further work. Reusing
the caller's execution frame can make a chain of these calls use constant call
stack space. It does not eliminate result storage, derivative tapes, necessary
owners or arithmetic work, and it does not change an algorithm's time complexity.

For nonnegative input, this recursive function counts down and returns zero:

```fwp
rec down = match
    0 -> 0
    _ -> sub 1 | down
```

The recursive branch returns `down`'s result directly. Adding `| add 1` after
`down` leaves an addition to perform after the recursive call returns, so that
version is not tail recursive. Turning arbitrary recursion into an accumulator
loop is a separate transformation: it must preserve checked-overflow, floating
rounding, effects and failure order rather than assume arithmetic is associative.

### Implemented lowering and its limits

After simplification, callback specialization and fusion, `src/tailrec.rs`
marks eligible direct self-tail calls. It keeps their expressions intact so
native representation selection can still pass records, variants and wide
numbers as direct fields. The interpreter replaces a proved tail call with the
next set of parameter values. Generated C prepares those values, retires unused
storage-reuse tokens and jumps to the function's entry check. Existing wide
numeric workers retain their own native loop. Each backend therefore keeps
bounded call-stack space for the recurrence, including native O0 builds.
[PR #169](roadmap-history.md#static-constants-and-complete-shutdown-checks-pr-169)
established full acceptance after the initial shutdown repairs;
[PR #171](roadmap-history.md#mixed-tail-recursion-pr-171) extended the proof to
functions that also make ordinary recursive calls.

Eligibility requires at least one direct self call in tail position and the
frame's types to describe plain immutable data. A function may also contain
ordinary recursive calls: calls used to compute arguments, bindings, match
scrutinees or a later calculation keep their own frames. Only a chain of eligible
tail transfers has bounded stack use; other recursion can still grow the stack.
For example, [lesson 22](tutorials/22-recursion-and-sharing/README.md) mixes a
tail countdown with a branch that performs one addition after a recursive call.

Closures with unknown captures and resource/task/channel owners still prevent
frame reuse. Resource regions and debugger frames cannot be discarded. Function
parameters are prepared in their original order before becoming next-iteration
state, including swaps and multiple curried arguments. This adds no source
syntax or intermediate `Step` values. Native record/variant arguments keep their
existing field layout; the interpreter keeps its ordinary value objects. Native
frames selected for reuse do not allocate local stack objects that could become
next-iteration state. Direct fields remain available without such objects. This
restriction can leave heap allocations that a non-reused frame could place on
the stack; broader eligibility is not by itself proof of lower total cost.

`FWP_DUMP_IR=1 fwp run --interp program.fwp` reports each direct-self-recursion
lowering decision. A rejection states what prevents the proof; it does not say
that the program is unsafe. `FWP_NO_OPT=1` disables this pass with the other
optimizations and remains the small-case semantic reference. The source debugger
also retains original recursive frames. Deep recursion in those modes can still
reach the stack limit. Calls made inside an iteration have their own stack costs,
and a loop can still retain growing data.

The existing `loop step state` API remains available when the source program
needs explicit iteration. `FnGen::tail_tokens` also releases unused storage-reuse
tokens before eligible ordinary calls; this separate cleanup optimization does
not promise portable tail transfer for every function. Long-chain destruction
and function-call recursion are separate stack concerns.

### Remaining work

1. Broaden frame reuse only with ownership evidence for the additional cases.
   Preserve cleanup, handler scopes and cancellation; measure allocations,
   retained memory and code size as well as execution time. The first comparison
   uses equivalent explicit fwp loops, not a C/Rust parity claim.
2. For statically known mutually recursive groups, assess a shared internal loop
   with a tag selecting the next function and typed argument storage. This is a
   potential implementation, not adopted behavior. Measure dispatch, storage and
   code-size costs before choosing it.
3. Treat unknown function-value calls and foreign calls separately. Different
   native argument/result layouts and live frame storage complicate portable
   tail transfer. Do not introduce a general heap-allocated continuation per
   call merely to claim constant native stack use. A universal tail-call promise
   is not part of the current contract.

The proof must prepare next arguments in their original order before destroying
anything they need. Moves, aliases and swapped arguments must remain correct.
A borrowed pointer into a discarded caller frame cannot survive the transfer;
its storage must remain valid through another proved arrangement. Pending
destructors, error handlers, state handlers, derivative scopes and active callback
registrations cannot simply be discarded or run early. Some last-looking source
calls are therefore not tail calls once their required cleanup is included.

Preserve scheduling/cancellation safe points when replacing function entries
with loop iterations. Every iteration must retire or transfer its cleanup owners
without accumulating hidden cleanup records. Constant call stack is insufficient
if continuation storage or retained memory grows with recursion depth.

The existing C backend can implement direct self loops portably. Relying only
on a C optimizer is weaker: [GCC documents calling-convention restrictions](https://gcc.gnu.org/onlinedocs/gccint/Tail-Calls.html),
and [Clang's musttail](https://clang.llvm.org/docs/AttributeReference.html#musttail)
requires compatible signatures/calling conventions and ends local lifetimes
before transfer. It is not an unrestricted solution for fwp's specialized workers
or borrowed stack arguments.

Before documenting a guarantee, test growing depths with bounded stack and memory,
interpreter/native agreement, all supported native architectures and supported
WebAssembly modes, applicable optimization levels, checked ARC and tracing,
aliases, argument swaps, resource/handler cleanup, cancellation and negative
eligibility cases. Inspect generated C and machine code; a deep run alone does
not identify which transformation occurred. Native regression tests retain generated C, executables and disassembly when
`FWP_TAIL_ARTIFACTS` names an output directory. Mixed-call tests compare deep
optimized execution with a smaller raw-interpreter reference, including O0/O2,
aliases, failure order and cancellation. These are correctness checks, not timing
comparisons; [the accepted mixed-recursion delivery](roadmap-history.md#mixed-tail-recursion-pr-171)
records their scope and remaining exclusions.

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

`tap action` runs an action and returns its original input. When its internal
match has one wildcard arm returning an unchanged local value, the optimizer
uses that local directly in the continuation. It keeps the action first, without
copying or dropping it, and preserves existing resource-lifetime boundaries.
This exposes field-only uses to existing direct-call specialization. The
[channel experiment](measurements/channel-transfer-protocol.md#removing-a-temporary-tuple-after-tap)
removes a temporary argument tuple. [Later loop-state lowering](measurements/channel-loop-state.md)
also removes the repeated state-tuple allocation for these programs.

Local tuple matching can expose the same direct calls. Consider:

```fwp
choose : (I64 -> I64, Option[I64]) -> I64
choose = match
    (_, Some _) -> id
    (_, None) -> const 0
```

Each `_` supplies one argument to its arm. In the first arm, `id` returns the
function from the first hole, which is then applied to the number from the
second hole. Thus `(add 1, Some 4) | choose` produces `5`; `(add 1, None) | choose`
produces `0`. The second arm ignores its one function argument through `const`.

The current tuple-match extension binds nontrivial fields once, in source order,
before matching the Option directly. This exposes the known `add 1` callback and
avoids constructing a tuple only to inspect it. A field ignored by the selected
arm still evaluates: an effect must run and a trapping constant must still trap.
Checked local types preserve nominal aggregates and their child cleanup rules.
The transformation applies only when at most one tuple field is tested; complete
tuple uses, multiple tested fields and protected original resource bindings keep
their existing lowering. [Measurements](measurements/channel-match-results.md) record allocation, count
and machine-code changes;
[PR #178](roadmap-history.md#direct-matches-and-callbacks-pr-178) records acceptance.
No execution-time improvement has been established.

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
proved derivative scopes, selected retained tasks, channels with acyclic nested
queue ownership, and scoped C calls. HTTP stream handles remain excluded from
channel payloads because their hidden owners can lead back to the queue. The
[task-message proof](measurements/task-channels.md) replaces the blanket Task
ban with a proof of the task's computation and result owners. Unknown producers
and captured task-bearing queues remain rejected.
[PR #190](roadmap-history.md#queued-task-owners-and-callback-transfers-pr-190) records acceptance.
The [queued-function extension](ownership.md#functions-stored-in-channels),
accepted in PR #175, admits functions whose actual immutable captures are
proved safe and checks their required scope when called after receiving.
The current extension also admits shared socket handles: `fwp_sock` owns only
a descriptor, kind and reference count. A TLS stream additionally owns OpenSSL
state and copied protocol bytes, which contain no fwp values. Neither can own
a channel or callback. Existing typed closure cleanup therefore releases these
captures without creating a queue cycle; explicit close still changes every
alias. Native validation is tracked in the linked queued-function contract.
`File` remains single-use and cannot be captured by a reusable function.

`arc_scope.rs` also tracks data queues created by `channel.make`. A callback may
capture one when its payload contains no functions and nested queues have proved
creators. Function-return summaries preserve these queue origins, meaning the
possible places where a value was created. Unknown native or external sources
stay unknown when combined with known sources. Checking every value sent into a
nested queue prevents a known outer creator from hiding an unknown inner owner.
The [data-queue checks](measurements/queued-data-channels.md) cover native and
WebAssembly cleanup; this changes the compile-time proof, not runtime storage.

Service emission supplies one further explicit producer contract: the final
response-channel argument of a served gRPC method comes from `g_sink_value`.
It owns a stream and connection, with static message encoding metadata and no
language callback. Task identities in that transport are borrowed and cleared
before task destruction. A queued function may therefore retain this channel
when its payload passes the same data-only check. Other entry modes and unknown
channel arguments keep their rejection. A matching function signature alone
does not establish the contract. [The gRPC capture checks](measurements/queued-grpc-responses.md)
describe the program, cleanup counters and current validation status.

The [channel proof](ownership.md#ownership-boundaries) follows each channel's
payload types and rejects a path back to that channel type. Immutable recursive
containers remain allowed. Mutable
cycles and unproved external callbacks remain excluded. Raw pointers carry
manual lifetime obligations, not managed ownership;
[PR #193](roadmap-history.md#manual-c-pointers-and-foreign-storage-cleanup-pr-193) records their accepted native delivery.
Checked ARC supports native main and function executables,
including CLI commands, and C libraries with copied inputs. The C-result
extension accepted in PR #165 transfers owned strings and record string fields to the host, with
explicit per-export release functions. It avoids an extra heap handle; unique
owners move and shared fields retain only the necessary owners. When the existing
worker already returns record fields and takes ordinary word arguments, the C
export transfers those fields directly instead of allocating and unpacking a
record box. Typed cleanup protects the fields if conversion fails. Raw pointer
bits copy without owning their pointees; an option wrapper is still counted. [Delivery history](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records full acceptance. Every library export is checked as a separate entry. Synchronous WASI
main/function/CLI entries use the same ownership checks and free counted storage
through their existing external count table. Checked gRPC clients and service
methods additionally prove when sent and received iterator steps run; the
[service guide](services.md#building-without-tracing-collection) explains the
command and validation. HTTP clients and servers are accepted in PRs #162/#163.
Generated REST and MCP entries use the ordinary ownership checks, with native
execution and memory acceptance recorded in
[PR #164](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164). They decode requests, call exported functions
and encode results using ordinary typed fwp code. A returned alias must retain
its input storage until encoding finishes; a failed call must release decoded
input. HTTP modes also depend on the connection/task owners described above.
The browser/WASI task extension accepted in PR #164 uses the same
checked task/channel owners and frees scheduler records and pooled linear-memory
stacks when the command returns. A completed fiber saves its latest State
storage pointer before another fiber replaces the runtime globals. The browser
loader gives each invocation its own instance and passes copied strings to host
output callbacks. Exceptions from those callbacks propagate unchanged; a host
`RangeError` must not become a language stack-overflow trap or trigger a second
call to the failed output sink. JSPI and Asyncify execution, cleanup controls
and actual-module inspection pass on both Linux hosts. All nine final production
jobs and docs pass; [history](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164) records the accepted source and scope.
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
native fwp functions compile ahead of execution. The interpreter prepares its C
foreign-call bridge before evaluating language code, including failure reporting
before program effects. Its calls do not compile code. The CPU-only numerical design
removes runtime OpenCL compilation; validation of that change is recorded in the
[handoff](development-state.md). CPU kernels interpret their arithmetic instruction
arrays without generating machine code. GPU execution, a replacement backend and
distributed tensor execution are outside this roadmap.

Darwin cross-compilation and Clang profile-guided optimization are not supported.
WebAssembly target effects and host capabilities are limited as described in the
reference. HTTP/3, WebSocket over HTTP/2 and unlisted transport extensions are
not implemented; use the individual networking guides for exact limits.

## Ownership implementation

Primitive ownership contracts live in `src/ownership.rs`. For eligible direct
calls, `src/rc/borrows.rs` also proves which arguments can remain owned by their
callers. Both reference-count insertion and C generation use the resulting
`Program.borrowed_parameters` contract. The ownership verifier checks it before
code generation, including whether later argument evaluation consumes an owner
needed by an earlier borrowed argument.

The proof starts with primitive borrows and extends through nonrecursive direct
calls. Returning or storing a counted argument, unknown calls, resource scopes,
function-value uses and external entries prevent selection. Every live caller
must already need the same counted values after the call; otherwise borrowing
could prolong an input's lifetime and increase peak memory. Flat record views
also need a separate proof that the record cannot escape. For channels, keeping
the same owner also preserves destruction of hidden native callback context,
even when the element type is plain data. Dead functions do not change live
call contracts.

Channel handles do not need plain-data payloads for this call convention.
Keeping the same channel owner after the call preserves its queued values and
native sink context regardless of payload representation. This does not prove
the payload graph acyclic: `arc.rs` and `arc_scope.rs` still check stored captures,
cycles and call scopes independently.
[PR #180](roadmap-history.md#function-channel-borrows-and-integer-text-pr-180)
records acceptance of the handle extension, cleanup checks and measurements.

Ownership lowering also forwards temporary aliases into borrowed call arguments.
For example, an inlined call may name a channel field, use it to send, then keep
the original field in the next loop state. The temporary needs no independent
owner if that same field is required after the send. The proof follows enclosing
`let` and match continuations, checks branches independently, and does not treat
a later read of another field as sufficient. Borrowing calculations inside
record fields can qualify; storing the alias itself in a field cannot.
Calls, argument evaluation and
traps stay in order. Consuming or unknown uses, escapes and resource scopes keep
ordinary ownership.
[PR #181](roadmap-history.md#temporary-channel-borrows-and-failure-cleanup-pr-181)
records measured count reductions and failure-cleanup acceptance; simple alias
tests alone do not establish a reduction in a larger program.

The caller keeps borrowed values and original record boxes visible to tracing
through the call, and remains responsible for failure and cancellation cleanup.
Existing generic entries still consume arguments: they protect those owners
while calling the borrowing worker, then release them. No source annotations or
new runtime wrapper are added. See [direct-call borrowing](ownership.md#borrowing-across-direct-calls)
for an example and current validation status.

Borrowing, consuming, retaining and returning aliases have different meanings.
A successful output test alone cannot
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
