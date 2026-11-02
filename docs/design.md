# Compiler architecture

This guide maps implementation responsibilities and the rules an optimization
must preserve. Learn syntax through the [tutorials](tutorials/README.md).
[Compiler stages and parser theory](compiler-pipeline.md) explain parsing,
desugaring, macro expansion and lowering. [Ownership](ownership.md) owns memory
contracts; [numerics](numerics.md) owns derivative and numerical semantics.
Performance claims need [measurements](benchmarks.md), not an implementation label.
The [accepted memory direction](gc-removal-design.md) guides upcoming ownership
changes; the pipeline below describes current implementation responsibilities.

## Pipeline

| Responsibility | Source | Main invariant |
|---|---|---|
| Tokens, layout and syntax trees | `src/lexer.rs`, `src/parser.rs` | Fixed grammar and precedence; no type-driven parsing |
| Macro expansion | `src/macros.rs`, `src/syntax.rs` | Check and run macro implementations before checking their expanded program |
| Types, traits and effects | `src/env.rs`, `src/types.rs`, `src/infer.rs`, `src/solve.rs` | Preserve constraints and effect-handler relationships |
| Specialization and typed IR | `src/mono.rs`, `src/ir.rs` | Resolve concrete generic uses and evaluate allowed `comptime` expressions |
| Original resource lifetimes | `src/resource.rs` | Preserve disposal timing before transformations change call structure |
| Simplification and fusion | `src/opt.rs`, `src/fuse.rs` | Preserve values, effects, termination and first failure |
| Tail-frame reuse | `src/tailrec.rs` | Next arguments survive old-frame cleanup |
| Lifetime admission | `src/arc.rs`, `src/arc_scope.rs` | Prove supported scope/capture lifetimes; reject unknown retention |
| Ownership operations | `src/ownership.rs`, `src/rc.rs`, `src/rc/borrows.rs` | Borrow/consume/retain/result contracts agree |
| Representation and C emission | `src/escape.rs`, `src/cgen.rs`, `src/cgen_wide.rs` | Layout, aliasing and child ownership remain valid |
| Execution | `src/interp.rs`, `runtime/` | Interpreter and native language behavior agree |

The stage guide describes actual ordering; this table groups responsibilities.
Both ordinary interpretation and native compilation normally optimize. Compare
an optimization against `FWP_NO_OPT=1 fwp run --interp program.fwp` or the original
typed IR, not only against another optimized backend. Check stdout, stderr,
exit status and effect/trap order.

## Syntax

Each function takes one argument and may return another function. `f x y` is
`(f x) y`; `(A, B) -> C` takes a tuple, while `A -> B -> C` takes successive
arguments. `curry` and `uncurry` convert explicitly. Optimizing the native calling
convention does not change this source model.

`x | f` applies a function; `f | g` composes functions. If the left type is still
unknown when the binding is solved, inference selects application. Values do not
implicitly become functions: `const x` constructs one explicitly. Selectors are
functions and tuple positions start at zero. Fixed-precedence infix arithmetic
and prefix calls coexist. See [parser rules](compiler-pipeline.md) and the
[reference](reference.md) for layout, patterns and exact precedence.

Local `let` values are strict and monomorphic. Pattern bindings have identities
separate from their spelling, so shadowing does not confuse captures or uses.
`fn` and named `match` arms lower to functions with explicit capture parameters.
The initializer stays at its original position; optimization must prove any
removal or movement, even when the local name is unused. Local aliases do not
change resource duplication or lifetime rules. See the [local binding contract](reference.md#local-bindings-and-named-functions).

A known curried callback can return another known partial function. Higher-order
specialization exposes both argument stages to the ordinary simplifier; it keeps
the original resource frames and computation order. Direct entries that already
accept the required arguments need no additional specialization. A single-use
local generated array can rejoin its immediate map/fold chain before fusion,
provided every argument crossed has no effects or traps.

The normal fusion proof
still decides whether interleaving element work is valid. The eight
[named/tacit cost pairs](functional-costs.md#local-names-candidate-coverage) pass
on Linux ARM64/AMD64 and macOS ARM64; #236 subsequently passed the full
[delivery matrix](roadmap-history.md#local-names-and-allocation-optimizations-pr-236).

A call stage is the group of inputs one internal function accepts before it
executes. A function constructor executes a stage and returns another function.
The compiler may group consecutive `fn` inputs only while no computation or
observable owner release lies between them.

A `let` calculation
ends that group. A top-level `let` is a cached value entry, even when it returns
a function; a `match` entry takes one input before evaluating its selected arm.
Applications subtract supplied inputs from the constructor's current stage,
following checked aliases and the selected trait implementation.

Runtime primitives
use their declared stage: substituting a function for a generic result does not
add inputs to that stage. For example:

```fwp
offset : I64 -> I64 -> I64
offset = fn x -> let y = 10 / x in fn z -> y + z
```

`offset 2` computes `y = 5` and returns a function that adds five. `offset 0`
must fail before a later input is evaluated. The returned function's type
cannot justify delaying that division. A composed
pipe likewise takes its input before evaluating any returned function's next input.

The optimizer may combine constructor stages only after proving that construction
merely captures values: no executed calls, possible traps, observable owners or
resource frames. It preserves typed local bindings and changes known callers
together; the source type alone supplies no such proof.

This bounded check runs
before constructors are inlined into their consumers.
This includes a cached function value whose captures are already constants.
`simd.splat` repeats one number across a vector's lanes. Small literal F64 splats
can become constant vectors within the existing inlining-size budget; their
signed-zero and NaN bits are copied unchanged.

Other computed captures retain their original evaluation point.
Unknown applications remain successive calls; combining them
could run a later argument before a first-stage failure. REPL results use cached
value entries even when their type is a function, so their construction runs once
and later redefinitions cannot replace their saved code or captures.

The IR marks these cached entries explicitly; constructor-stage optimization
must leave them at zero arguments. Session linking remaps that marker with the
function IDs, and the IR validator checks the entry contract.

CLI, REST, MCP, gRPC and C library argument lists come from the complete public
function type, not an internal entry's current stage. CLI, gRPC and C libraries
lower a complete invocation to an entry that follows those stages; the ordinary
lifetime proof checks it.
An entry that already accepts all those arguments needs no adapter. REST and MCP
generate the corresponding source application as before.

The lifetime proof distinguishes calls that construct function values by their
outer construction site. Nested constructors retain that one source position;
the proof does not accumulate a call stack. Returned partial functions keep the
same identity when supplied more inputs. This prevents two `iter.each` values
from mixing a State callback with an unrelated unscoped callback. Handler
requirements still apply where the callback is invoked: removing `run-state`
must reject the State call. Scaling and startup budgets cover this analysis.

## Eager computations in partial applications

`add (calculate ())` evaluates `calculate ()` when the partial function is made.
Calling that function later must not repeat the calculation, move it past an
effect or delay its failure. For a known partial function used once, the optimizer
binds computed captures at their original point, then substitutes the remaining
function value. Existing specialization can then expose a direct call.

Only known unsaturated applications take this path. Unknown calls and fully
applied functions returning closures keep their binding. Observable resource
captures reject the transformation; rejection discards every prepared temporary.
Original resource anchors, evaluation order and inlining limits remain unchanged.
The [eager-capture experiment](measurements/eager-captures.md) supplies operation
order tests and measured costs; it is not a promise that all closures allocate
nothing.

## Types and effects

Type inference solves constraints from uses, so ordinary expressions need few
annotations. An explicit signature supplies named input types before their bodies
are checked. This keeps a pure callback parameter separate from IO performed
while its caller evaluates an argument. A **row** describes fields or effects, possibly with an unknown
remainder. This lets `.name` work with different records that contain `name`.
Named records remain distinct types. Tuples are records with numeric labels;
unit `()` is the empty record.

Effects describe actions a function may perform, such as IO or failure. Every
function arrow has an effect row. A call may use a larger surrounding effect
context, but cannot silently widen the effects accepted by a nested callback.
The inference code must preserve required effects when unifying fields and
payloads.

Handlers such as `attempt` and `run-state` remove the effect they handle.
When a handler accepts a callback with `{Error[x] | e}` and returns a function
with `e`, the two uses of `e` must stay related. For example,
`attempt (apply ())` takes a function, calls it with unit and catches its error;
the result must not still require that handled error.

Adding `Error` only to a
temporary callback type would lose this relationship when the callback's input
is itself a function. Argument checking preserves these shared rows, including
handlers returned inside records. Returning a function produces a value;
accepting one consumes a value.

The check follows that direction through record
and variant fields, rather than treating every occurrence of the same effect
variable as a returned effect. It still rejects unrelated required effects,
such as IO under an error handler. The [runnable regression](../tests/fixtures/handled_callbacks.fwp)
covers these cases.

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

A selector immediately constrains its input's fields, so callback effects remain
available during inference. Its input stays linked through a type variable. When
a signature or call supplies a named record, unification checks the fields and
preserves that name for other uses of the same variable.

Thus
`if (.value | lt 0) neg id` can select the named input's `Neg` implementation.
Anonymous records still use structural rows. Refinement checks for infinite types,
including parameters absent from a record's fields; it adds no runtime conversion.
This inference repair passes all nine production jobs and both analysis hosts
in [PR #226](roadmap-history.md#derivative-allocation-and-accuracy-pr-226).

## Runtime representation and C safety

Generic entries pass 64-bit `V` words holding immediate values, tags or addresses.
The type determines which bits represent an owner; a number resembling an address
must not be counted as a pointer. Specialized workers use concrete C fields or
scalars. Whole-value uses can still need boxes. [Memory layouts](ownership.md#accepted-numeric-representation)
describe packed arrays, views and wide values.

Concrete stack/static structures and their runtime views need a valid C aliasing
contract. The object, closure, string, array and map view types use the supported
GCC/Clang `__may_alias__` annotation; ordinary strict alias analysis stays enabled
elsewhere. Byte reinterpretation and packed loads use `memcpy`. Matching offsets
alone do not make casts between unrelated C structure types safe.

Native errors use `setjmp`/`longjmp` after releasing pending owners. Use `setjmp`
directly as the `if` condition (or compare it with zero); initializing a variable
from its return value is not a permitted C context. See
[C §7.13.1.1](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf). Changed
non-volatile automatic objects have indeterminate values after such a jump, so
error/type fields and changing task-scope child metadata are volatile where needed.

Unchanged links need not be. An empty callback argument slice may be null; cleanup
must not offset it, and partial application must not pass it to `memcpy`, even
with a zero byte count. Tests must exercise the actual cleanup path at the
production compiler settings; one compiler's success does not verify another.

POSIX executable startup requires successful thread-attribute initialization and
stack configuration. It releases the attributes after thread creation and reports
setup failure before language code instead of switching to the process stack.
Alternate-stack and signal-handler registration are also required. Static numerical
workers check their stack attributes; a partial startup joins every started worker
before reporting failure. O0/O2 fault controls pass on native Linux and macOS, on ARM64 and AMD64,
including a deliberately omitted stack-error check that must fail the test.
The broader final-head matrix remains required before merge.

## Ownership implementation

`src/ownership.rs` defines primitive contracts. `src/rc/borrows.rs` proves eligible
borrowed parameters through known nonrecursive calls. Insertion, verification and
C generation share `Program.borrowed_parameters`. Later argument evaluation must
not consume an owner needed by an earlier borrowed argument.

Returning/storing a counted argument, unknown calls, resource scopes, escaping
function values and external entries prevent ordinary borrowing selection. Every
live caller must keep the relevant owner for a later use; another field's use
is insufficient. Temporary aliases can forward that same borrow through bindings
and matches. Generic entries still protect and consume their ordinary arguments
when calling a specialized borrowing worker.

Channel borrowing preserves hidden native contexts as well as payload storage.
It does not prove the queued graph acyclic: capture/cycle checks remain separate.
The caller keeps the borrowed owner alive and releases it on failure.
See [the ownership contracts](ownership.md#ownership-boundaries)
for examples, restrictions and tests.

An exactly saturated borrowed callback with only plain parameters can enter its
typed consuming function without retaining the closure. Saturation means that
the saved and newly supplied arguments exactly fill that entry. The generator's
argument-destructor metadata covers the complete arrow spine: a null destructor
proves no parameter owns storage.

Copy scalar captures before entry, keep the
caller's closure intact, and return the entry's owned result. This rule applies
only to the initial borrowed callable. A function returned during overapplication
is owned and must still be consumed. Owned captures, partial calls and extra
arguments keep their existing ownership handling.

The
[callable comparison](measurements/returned-callables.md) records verified native correctness and the still-open timing/size limits;
correctness alone does not establish performance acceptance.

### Proving a local array has one owner

`src/rc/unique.rs` checks the ownership-lowered body after a candidate allocation.
It follows sequential evaluation and match branches, allowing only nonescaping
borrows until exactly one destruction on each normal path. An earlier borrowed
argument must remain live while later arguments are evaluated. Alias creation,
returns, captures and unknown calls prevent selection. Generated call-liveness
cleanup handles exceptional exits separately.

The current check walks the remaining expression tree once per candidate: for
M candidates and N expression nodes, its worst-case work is O(MN). It adds no
whole-program inference or runtime uniqueness test. Measure compiler cost on
functions with multiple candidate arrays before expanding this selection; the
existing lifetime-analysis budgets remain required. The
[storage report](measurements/unique-array-storage.md) defines the narrow supported
shape, allocation layout, negative controls and verified acceptance evidence.

### Scalar fields and known sort keys

For a pure scalar projection such as `(word, count) | .1`, the generic function
entry reads the field from its boxed argument before releasing that argument.
It does not acquire temporary owners for unrelated fields. Direct calls retain
the existing separate-field worker. Resource-bearing records and borrowed-worker
contracts are excluded from this selection; ordinary entry cleanup handles a
failure before the read. String-valued results still require an independent owner
when their source record remains shared.

Known partial applications passed to `sort-by` use the same specialization pass
as `map` and `fold`. For `sort-by (both (.1 | neg) .0)`, the compiler can see the
whole key calculation and avoid duplicating a pair just to call its selectors.
Captures are evaluated once in their original order; callbacks still run in the
sort primitive's original order. Runtime-selected callbacks keep ordinary calls.
The [measurement protocol](measurements/sort-key-ownership.md) separates these
verified changes from their exact count targets and measurement limits.

The verified A4 path stores known `(I64, String)` keys in an aligned field buffer
and calls the existing worker directly on `(String, I64)` inputs. Its initialized
prefix owns the saved Strings; merge scratch borrows them. Other callback shapes
retain ordinary calls and key records. [The protocol](measurements/inline-sort-keys.md)
defines selection, cleanup, exact budgets and completed validation.

### Numeric record fold accumulators

PR #240 implements a narrower call boundary, with focused native checks in #241:
a known left fold can keep its accumulator's numeric fields in local variables.
An accumulator is the running result passed to the next iteration. `.0` selects
the first tuple field and `.1` the second. For example:

```fwp
step : (I64, F64) -> (I64, F64) -> (I64, F64)
step = fn acc -> fn item ->
    ((acc | .0) + (item | .0), (acc | .1) + (item | .1))
```

`[(1, 1.5), (2, 2.5)] | fold step (0, 0.5)` computes `(3, 4.5)`:

```text
seed (0, 0.5) → add (1, 1.5) → (1, 2.0) → add (2, 2.5) → (3, 4.5)
                                   ↑ local numeric fields           ↑ final box
```

- Read and release the seed box once; allocate only the final record.
- Borrow element fields while the caller keeps the input list alive.
- Return the original seed for an empty list. Preserve any aliases.
- Use the existing direct worker, which accepts/returns separate numeric fields.
- Exclude managed/nested fields, boxed wide numbers, captured or runtime-selected
  callbacks and right folds. Keep callback effects and evaluation order.

The [requirements and measurement protocol](measurements/derivative-record-folds.md)
cover alias preservation, allocation failure, traps, cancellation and exact counts.
This does not remove records that must remain stored in a list. Selection depends
on the generated worker, not just the source type. Destructuring an argument before
the next `fn` can currently leave a returned closure and a boxed result; that path
is semantically equivalent but does not qualify for this optimization.

Known partial callbacks passed to `attempt` now use the same specialization pass
as other synchronous handlers (PR #241, focused GCC/Clang checks pass). For
`attempt (fold step seed) values`, the pass exposes the fold inside the callback.
It evaluates `seed` before entering the handler; failures during the callback are
caught by `attempt`. The handler itself remains in place.

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

A temporary tuple or record can disappear only when its uses and child lifetimes
permit it. Ignored fields still evaluate in their original order. Known tuple
matches can expose direct callbacks, but multiple tested fields, whole-value uses
and protected resources retain their required representation. A compiler-generated
loop is not permission to interleave two trapping eager stages.

Zip/map fusion also selects flat records of immediate numeric fields. For
example, `Rev[F64]` contains an F64 value and an I64 tape index. In
`values | zip (drop 1 values) | map pair-calculation`, the generated loop can
read one element from each input and call `pair-calculation` directly, without
building the intermediate list of pairs. Both input lists remain alive until
the loop finishes; the shorter input determines the output length. Record fields
containing strings, nested records, functions, resources or boxed wide numbers
do not qualify. The [candidate protocol](measurements/derivative-forward-costs.md#candidate-acceptance-frozen-before-compiler-edits)
records passing native correctness/ownership checks and unmet timing limits.
[PR #239](roadmap-history.md#numeric-record-zipmap-fusion-pr-239) passed full
production verification; the user approved retaining the allocation savings
while leaving those timing limits open.

The generated-array transformation, verified in [PR #232](roadmap-history.md#generated-array-elimination-pr-232),
extends this rule to `flip array.generate id | array.fold add 0`. With input
`4`, the generator produces indices `0, 1, 2, 3`, and the fold adds them to get
`6`. The reference builds an array first; the transformation generates and adds
each index in one loop.

It requires known, terminating callbacks without effects,
inline numeric elements/accumulator/captures, and at most one possible trap
message across the stages. It preserves the original count check and argument
evaluation even for empty arrays. Reused arrays, resources, F128 values and
unknown callbacks do not qualify.

The [allocation acceptance requirements](measurements/generated-array-folds.md)
separate correctness, cleanup, allocation, code/stack costs and timing; the
implementation alone establishes none of those results.

The [State range candidate](measurements/state-range-folds.md) crosses one
specific handler boundary: `range 0 | run-state 0 (each (add | modify)) | .1`.
For input `4`, it adds `0, 1, 2, 3` to the scoped State and returns `6`.
It keeps the handler but specializes its known, single-use I64 list consumer to
accept bounds and iterate directly.

Effects still run once per index in order;
there is no eager mapping stage to reorder. Scalar captures must already be
evaluated in the original order. Shared lists, unknown consumers, resources and
wider element types do not qualify. This is a separate proof from pure eager
pipeline fusion, whose requirements are unchanged. Full production verification
passes in [PR #233](roadmap-history.md#state-range-elimination-pr-233).

When a worker returns record fields separately, every `match` arm must produce
that same representation. An arm may unpack a dynamically returned record; an
error arm may not return at all. Neither permits another arm to read the boxed
local of a record whose box was eliminated earlier.

Specialized loop state uses C struct members. F32/F64 members keep their floating
types between iterations; other members keep their ordinary value words. Reads
and writes at generic expression boundaries use bit-preserving conversions, not
numeric casts. The next state is completed before replacing the current state;
only counted fields participate in owner cleanup. This representation is under
[test](measurements/timing-variation.md#compiler-reports-and-typed-state-experiment);
its performance is not yet accepted.

The F64 matrix path uses blocks of 32 over contiguous arrays and accumulates in
ascending inner-index order. Multiply and add remain separate. Shape validation
precedes the specialized work; malformed cast shapes retain their specified
library behavior. Wider arithmetic and floating formats keep their own contracts.

A numeric derivative tape records two parents and local derivative weights per
operation. Its backward workspace need only reach the last requested output;
later forward work and failures still run. Parent buffers share one allocation
and derivative buffers another; only their base pointers own storage.
Recording receives four curried arguments: parent A, weight A, parent B, weight B.
Native typed recording consumes both weight owners. It protects them during
validation and growth, then stores them before publishing the node. Inactive
recording releases both; caller aliases keep their separately acquired owners.
The [transfer protocol](measurements/derivative-recording-moves.md) defines the
checks required before treating this implementation as verified support.

Growth must
preserve initialized entries and cleanup. A detached numeric workspace cache is
bounded at 512 KiB; the active-tape table is separate. Nested differentiation
records typed derivative values. Typed adjoint slots borrow the tape-owned zero
by exact identity; distinct values remain owned.

Final input owners move into
result cells with an unwind guard until allocation succeeds.
[Typed-owner checks](measurements/typed-derivative-owners.md) cover aliasing and
failed transfers. See [reverse mode](numerics.md#reverse-mode).

## Measuring integer text without building it

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
generated sum still uses ordinary checked addition.

Shared strings, unknown
string producers, floating-point displays and wider integers keep their storage.
The private integer-length operation has no source-language declaration.
The current [decimal-count experiment](measurements/decimal-count.md) uses a
balanced tree of exact power-of-ten comparisons, with at most five comparisons
and no lookup table.

Two selected sessions per architecture meet the frozen
timing limits; the final production matrix remains required before merge. The
preceding bit-length/table experiment passed correctness but failed the two-host
timing acceptance rule; its complete results remain in the report.
Signed values use unsigned magnitude and add one for the minus sign, so I64's
minimum does not require overflowing signed negation.

Ordinary inline hints let
the C compiler combine counting with its caller; they do not force inlining.
[Earlier controlled comparisons](measurements/integer-counting.md) retain the
previous grouped-division algorithm and its recorded call/size tradeoffs.
The [Linux measurements](measurements/integer-text.md) record zero managed leaf
allocations in the probe, actual machine code and comparison with direct
character counting in C/Rust.

## Constructing integer range sets directly

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

## Moving list elements and sorting an owned array

`array.from-list` consumes a list reference. An unshared prefix transfers its
values into array slots and releases its nodes. Once a shared node is reached,
the remaining tail stays owned until conversion finishes, and copied elements
are retained. Descendants can have counts of one yet remain reachable through a
shared ancestor; conversion must not resume moving within that tail. Inline
128-bit elements copy their bits and release the old scalar boxes. Input and
partially filled result owners handle interrupted allocation or retention.

Array sorting consumes one array reference. If it is the only owner,
sorting may reuse the storage; a shared array or view needs a copy so earlier
values remain unchanged. Empty and singleton arrays transfer their reference.
Input, result and temporary buffers have cleanup owners throughout the operation.

For ordinary elements, sort keys hold their values. A 128-bit key points into its
original array slot. Reusing that array therefore applies the sorted permutation
in cycles, with one sixteen-byte temporary, rather than overwriting slots whose
values have not moved yet. [The protocol](measurements/array-sort-ownership.md)
records alias, bit-pattern, interruption and cost checks. All production gates
passed in [#212](roadmap-history.md#array-moves-and-the-gc-removal-checklist-pr-212).

## Compile-time values in static storage

A value produced by `comptime` is already known when C is generated. For example,
`table = comptime ([1i8, 2i8] | array.from-list)` needs storage for two bytes and
an array header, but does not need to allocate that storage on the heap at startup.

The compiler places compound constants, wide numeric literals and closures
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
next set of parameter values.

Generated C prepares those values, retires unused
storage-reuse tokens and jumps to the function's entry check. Existing wide
numeric workers retain their own native loop. Each backend therefore keeps
bounded call-stack space for the recurrence, including native O0 builds.
Eligibility requires at least one direct self call in tail position and the
frame's types to describe plain immutable data.

A function may also contain
ordinary recursive calls: calls used to compute arguments, bindings, match
scrutinees or a later calculation keep their own frames. Only a chain of eligible
tail transfers has bounded stack use; other recursion can still grow the stack.

For example, [lesson 22](tutorials/22-recursion-and-sharing/README.md) mixes a
tail countdown with a branch that performs one addition after a recursive call.

Weak channel handles own expiration metadata, not the channel or its queued
values. The current extension allows these handles in a reused frame, including
handles whose payload type names a callback or task. Upgrading a handle creates
a strong owner; keeping that owner in a local still prevents frame reuse.
Swapping two weak handles first prepares both next arguments and only then
releases the old locals. This avoids dropping metadata that the next iteration
still needs. O0/O2 stack, cleanup and cancellation controls pass on the native platform matrix.

A known function with no supplied arguments owns no captures. A partial
application of a known function owns exactly its supplied arguments; the compiler
can remove its cleanup boundary when each argument contains only plain values
or weak metadata. This proof does not apply to unknown function values, cached
closures or a fully applied call returning a closure. The existing evaluation
and trap-order checks still apply. No whole-program capture search is added.

Closures with unknown captures and resource/task/strong-channel owners still
prevent frame reuse. Remaining resource regions and debugger frames cannot be
discarded. Tail analysis checks all parameters and every remaining local binding
or use; an unused type-table slot left by inlining owns no value.

Function
parameters are prepared in their original order before becoming next-iteration
state, including swaps and multiple curried arguments. This adds no source
syntax or intermediate `Step` values. Native record/variant arguments keep their
existing field layout; the interpreter keeps its ordinary value objects.

Native
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

The accepted mutual-recursion pass groups a pair with matching scalar signatures into
one internal loop. A small integer chooses which original body runs next. The
original entries select that integer; only direct tail calls change it. Calls
whose results require further work keep ordinary frames.

The pass admits
only I64, Bool and unit locals, rejects dynamic calls and observable cleanup or
debugger frames, and scans each candidate once. It does not promise constant
stack space for arbitrary groups or foreign calls. [The measured decision](functional-costs.md#accepted-longer-comparison)
compares O0/O2 ordinary calls, grouped recursion and an explicit fwp loop. The
restricted transformation passes its fixed limits and the full platform gates.

The existing `loop step state` API remains available when the source program
needs explicit iteration. `FnGen::tail_tokens` also releases unused storage-reuse
tokens before eligible ordinary calls; this separate cleanup optimization does
not promise portable tail transfer for every function. Long-chain destruction
and function-call recursion are separate stack concerns.

### Remaining work

Broader resource-frame reuse would need a new lifetime proof and measured benefit
beyond the verified F2–F3 cases. Next arguments
must be prepared before releasing anything they borrow. Pending destructors,
handlers, state/derivative scopes and callback registrations cannot be discarded
or run early. Unknown/foreign calls have separate ABI and lifetime constraints;
no universal constant-stack promise is made.

## Tasks and interpreter lifetimes

Native tasks share an event loop and switch stacks at suspension/safe points.
Function-entry budgeting lets ready tasks run; inlining changes entry counts.
Use a channel or await for ordering, not wall-clock assumptions. CPU numeric
parallel workers are a separate mechanism. The interpreter uses host threads
that take turns evaluating language values; WebAssembly uses supported host fibers.
[Concurrency](concurrency.md) describes the platform behavior.

Every public interpreter evaluation enters through `call_root` or `apply_root`.
It joins ordinary children, closes connection pools and cancels/joins background
workers before returning or propagating a Rust panic. Shutdown also drains workers
or connections registered while it waits. Low-level evaluation/transfer is internal.
Shared `Send` writers use `Arc<Mutex<...>>`, replacing raw borrowed writer pointers.
A panic during cleanup itself aborts: returning could let borrowed tasks escape.
This boundary also covers macros, commands and REPL cells. An unfinished remote
stream cannot keep reading across cells; completed ordinary values remain usable.

## Builds

`run`, `exec`, `test`, `serve` and `pipe` compile/cache native code unless
`--interp` is explicit. A missing C compiler is an error, not an implicit switch
to interpretation. The front end still produces current diagnostics on cache hits.
Native-only build settings are rejected by interpreted commands. Memory ownership
is part of the language contract, not a selectable execution mode.

The executable cache fingerprints source, target, C compiler version and header
search environment. Linked C/preprocessed assembly contributes expanded source,
so changed or missing headers invalidate a cached build. Exact-float builds also
track their C++ compiler; integer-only generated programs need no C++ compiler.
Concurrent builds use private files and briefly lock publication; they do not
replace an executable another process may be running. Timestamp updates use the
platform's metadata access without opening executable data for writing.

Native packages contain one compiler per OS/architecture. `--fat` selects among
x86-64 instruction levels at startup; it is not a macOS universal binary.
Compiler-build and generated-program toolchains can differ; configure them
explicitly as described in [Contributing](../CONTRIBUTING.md#setting-up).

## Remaining memory work

The [restricted unique-array path](measurements/unique-array-storage.md) was
verified in PR #219. [The scoped parser path](parser-workspace.md) is implemented
in `src/cgen/regions.rs` and `runtime/fwp_rt_region.c` and verified in PR #221. A selected call owns aligned blocks and passes an explicit
context to allocation helpers. Internal node links have no counts; escaped trees
keep ordinary ownership.

[Measurements](measurements/parser-workspace.md) separate
this storage change from input/token costs and from general region inference. Tracing removal passed integrated verification in
[#217](roadmap-history.md#tracing-gc-removal-pr-217). Explicit weak channels and retained
C callbacks are implemented; see [weak channels](weak-channels.md) and
[retained callbacks](retained-callbacks.md) for their lifetime rules.
General strong-cycle reclamation by ordinary ARC is not a goal.

The selected
model rejects unproved owning cycles and preserves escaping functions.
JIT compilation is excluded, not deferred. The interpreter prepares foreign-call
bridges before language execution; CPU kernel interpretation generates no machine
code. GPU execution, a replacement backend and distributed execution are outside
this roadmap.

Darwin cross-compilation and Clang profile-guided optimization are unsupported.
WebAssembly hosts have explicit capability limits. HTTP/3 and WebSocket over
HTTP/2 are not implemented; networking guides define supported protocols.
