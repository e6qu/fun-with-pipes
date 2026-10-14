# Design

This page records how fwp is built and why. It covers the decisions the
*Pipe Language Compact Specification* leaves open. The language itself is
described in the [reference](reference.md); this page is for people working
on the compiler.

## Pipeline

The active priorities are in [../PLAN.md](../PLAN.md), the ownership and
representation contract in [ownership.md](ownership.md), and current checks
and limitations in [development-state.md](development-state.md).

```
lex → parse (offside layout) → macro expansion → name collection
    → inference (types, traits, effects, resources) → monomorphization
    → typed IR → resource frame anchors → optimizer → { interpreter, C code generator }
```

| Concern | Decision |
|---|---|
| Host language | Rust, stable, with no third-party crates |
| Native code | Typed IR → C11 → the system C compiler. The same C goes to WebAssembly through `clang --target=wasm32-wasi` |
| Ahead of time by default | `fwp run`, `exec`, `test`, `serve` and `pipe` compile to native executables, cached by content (`src/aot.rs`), and run them in place of `fwp`. The front end still runs on every start, so diagnostics do not depend on the cache. See [Compiled by default](reference.md#compiled-by-default) |
| Interpreter | Runs the same typed IR. It powers `comptime`, macros, the WebAssembly build of fwp and `--interp`, and it is the oracle the native backend is tested against |
| Scalars | Generic C entries use 64-bit `V` words: integers up to 64 bits sign- or zero-extended, floats by their bits, pointers or small tags. Direct numeric workers and numeric array payloads use concrete scalar types and natural widths, with bit-preserving bridges to generic entries. Arithmetic and comparisons of fixed-width integers, `F32` and `F64` are generated as typed C per type (`Scalar` in `src/cgen.rs`), checked like the interpreter's; eligible I128/U128 scalar workers use native wide arithmetic with explicit boxed generic boundaries; other wide paths, `TInt` and `F16` use runtime arithmetic |
| Loops | A `loop` whose step is a known function with literal `Again x` and `Stop y` results compiles to a C loop (`loop_shape`, `Gen::loop_def` in `src/cgen.rs`): the step's body writes the next state into locals instead of allocating it, field by field when the state is a record the step only reads through fields, and a field that is itself a record of up to eight fields (a `fold`'s tuple accumulator) as its fields too, built only where it is read whole (`LoopGen::slots`); safe points are counted as in the generic loop |
| List pipelines | A `fold` (so `sum`), `length` (so `count`) or `find` (so `any`, `all`) over `map` and `filter` stages of a `range` or a list becomes one `loop` whose state is the position, the accumulator and the captured values (`src/fuse.rs`), so no intermediate list is built. Fusing interleaves the stages, so it is done only when the stages are pure and terminating and can raise at most one trap message between them: then which stage traps first cannot be seen. `find` stops early, so its stages may raise none. `iter.to-list`, `iter.fold`, `iter.each` and `iter.find` fuse eligible `iter.map`, `iter.filter` and `iter.take` chains into flat loop state. Known consumer callbacks specialize; callbacks finish before forcing a tail, and find/take preserve early stopping. Direct count-from, iterate and from-list producer chains keep scalar/list state without tail closures. Count-from and iterate preserve eager successor construction, including initial lookahead before an exhausted take. Other lazy tails still dispatch. `FWP_ITER_CONSUMERS=0` and `FWP_ITER_PRODUCERS=0` provide separate comparison controls |
| Higher-order primitives | `map`, `filter`, `fold`, `fold-right`, `take-while`, `drop-while`, `zip-with` and `loop` called with a known function that captured nothing compile to `fwp_k_*` (runtime/fwp_rt_prims.c), which take a C function pointer and are always inlined, so the function is called directly. A known function applied to captured values (`map (mul 3)`) gets a specialized loop of its own, `fwp_hof<i>`, which takes the captured values and calls the function directly (`opt::specialize_hofs` in `src/opt.rs`, `hof_def` in `src/cgen.rs`); compiled dynamic calls use `fwp_apply_owned` with typed captures; runtime callbacks use the shared `fwp_apply` entry |
| Records that do not escape | A record bound to a local and read only through its fields becomes one local per field (`only_fields` and `replace_fields` in `src/opt.rs`), and copies of locals and constants are propagated, so the tuples that `curry`, `uncurry` and `curry3` build are never allocated. A `match` on `map.get` branches on the lookup without building the `Some` (`lookup_match` in `src/cgen.rs`) |
| Record workers | Direct numeric workers pass concrete C scalar parameters/results and use natural numeric aggregate fields with bit-preserving bridges to V entries. FWP_TYPED_ABI=0 retains V boundaries. A direct call passes a record of up to eight fields as its fields when the callee reads it only field by field, and a function returning such a record returns a C struct (numeric fwp_wr layouts preserve concrete field types; the target C ABI determines register or caller-storage return). A record of more than four fields is returned so only by a function whose every tail builds one, so that one it passes on is not read into a struct and built again (`wide_record_returns`). Return-origin and field tracking follow typed local aliases while preserving intervening effects. Its caller reads the struct's fields when it only reads fields (`let`, `.i`, a tail call), so recursion over pairs allocates nothing. Each such function has a worker with this convention (`w<id>`) and keeps its usual entry (`f<id>`), which boxes, for closures and primitives (`Abi` in `src/cgen.rs`). A function whose every tail builds a variant of a non-recursive type with up to eight fields per constructor (`Option`, `Result`, a parser's token), or calls such a function, returns its tag and fields as a struct (`fwp_u<m>`, `variant_returns`); a caller that only matches on the result keeps it as one, counting the fields' references by tag (`fwp_vdup<k>`, `fwp_vdrop<k>`), and any other builds it (`fwp_vbox<k>`). Lists and trees are left out, as their nodes are rebuilt in the cells of the old ones. `FWP_VRET=0` when compiling turns it off |
| Ownership and reuse | `src/rc.rs` inserts typed `Dup`/`Drop` and checks every path. Known constructors and callees take ownership; primitive contracts define borrowing and transfer. Counted native objects release typed children and eligible storage at the last owner, and compatible unique cells can be reused. Unknown runtime boundaries share conservatively. Details are in [ownership](ownership.md) and [primitive contracts](primitive-ownership.md). `FWP_REUSE=0` disables reuse; `FWP_FREE=0` defers physical freeing; `FWP_REUSE_VERIFY=1` poisons released cells to detect stale uses |
| Typed locals | Every IR function records the type of each local, its parameters first (`Func::locals` in `src/ir.rs`). Monomorphization gives them, the optimizer and fusion keep them as they add locals, and debug builds check after each pass that each local's type agrees with what it is bound to (`ir::check_locals`). They are what a value's size and layout are read from |
| Known constructors | After inlining, a match on a value whose constructor is known (`Some x`, a record of locals) selects its arm and binds the fields to the arm's names, so the value is never built. A match on a match whose every arm ends in a constructor (`half \| option.unwrap-or 0`, with `half` returning `Some` or `None`) first moves into those arms, as long as the copies are small (`case_of_case` and `known_ctor` in `src/opt.rs`). Historical timings are in [history](roadmap-history.md); new claims follow [the measurement contract](ownership.md#evidence-required) |
| Dead functions | After inlining, most instances of small combinators (`fork`, `curry`, `const`) are reached by nothing. The C backend generates code only for the functions reachable from `main`, the tests, the exports and the served methods (`live_functions` in `src/cgen.rs`); the others keep their place in the function table, without code |
| Primitives | A fixed set of primitives, implemented twice: in Rust (`src/prims_std.rs`, `src/web.rs`, `src/linalg.rs`, …) and in C (`runtime/fwp_rt*.c`). Everything else in the standard library is fwp code in `lib/` |
| Polymorphism | Explicit and static: only a signature makes a definition generic, and whole-program monomorphization compiles each use to its own code. Traits resolve statically; there is no dictionary passing. Polymorphic recursion is rejected. See [Generics](#generics) |
| Values on the stack | A record, variant or closure (a known function applied to fewer arguments than it takes) that does not escape lives in the C stack frame of the function that builds it: its local is read through fields, matched, copied with fields replaced, applied (which hands the function the closure's captured values, never the closure), or passed to a parameter that does not escape either (`src/escape.rs`, a fixed point over all functions), and never returned, stored, captured or given to a primitive. Its fields are on a stack the collector scans. The wrapper has no heap count slot; generated code tracks owned child references for eligible stack locals, aliases and consumed calls, and preserves their addresses through allocation. Unknown child types retain the fallback. A value the function builds is not passed to the function itself (a tail call becomes a jump that reuses the frame), while a parameter passed on to it may be (it lives in a caller's frame). `FWP_STACK=0` when compiling turns it off |
| Memory | Native programs have a generational, non-moving mark-and-sweep collector with conservative roots (`runtime/fwp_rt_gc.c`, see [Runtime](#runtime)); with `--memory static` its heap, a `malloc` pool and every stack are mapped once at startup (`runtime/fwp_rt_static.c`, see [Static memory](reference.md#static-memory)); WebAssembly builds free typed counted owners and retain unproved shared graphs. The interpreter uses Rust reference counting |

`make { .field }` expands in the parser to the ordinary named selector field,
including nominal builders. Nested and numeric selectors require an explicit
output name. There is no extra AST or IR node, ownership rule, or runtime call.
The formatter canonicalizes named identity projections. Existing canonical
record-label evaluation order is preserved.

`iter.fold`, `iter.each`, `iter.find` and list `fold-until` use the existing
`loop` and Step constructors; `map-accum` uses a left fold followed by reverse.
They introduce no primitives and do not widen iterator tail effects. Callback
and tail evaluation order is tested against raw interpretation. Producer fusion applies only to proven direct chains; arbitrary lazy producers
retain their declared forcing behavior and may allocate.

Merged synchronous callback entries borrow typed inputs and return owned results;
map/filter own fresh spines and results without promoting input elements to sharing.
Map callback failure, trap and cancellation release results, partial spines and
scratch through registered cleanup. Filter/take-while selection unwind similarly
releases owned aliases, partial spines and scratch. Zip unwind releases owned
callback results and partial spines, plus both borrowed scratch buffers, including
failure while preparing the second buffer.
Merged folds protect the current accumulator and each completed borrowed argument
duplicate until callback transfer; right-fold scratch releases on unwind.
Merged loops protect current state across cancellation ticks and Step payload
preparation; flattened Again records remain unboxed.
Other runtime boundaries retain explicit sharing fallbacks.
See [the ownership contract](ownership.md) for the supported memory modes and
explicit compatibility boundaries.

Compiler reuse tokens clear dead fields before retaining empty young cells,
transfer into compatible constructors and release unused cells. Registered token
cleanup handles failure, trap and cancellation, and unlinks before tail calls.

The runtime cleanup stack releases registered owners and scoped files before
nonlocal failure, trap or cancellation invalidates their frames. Catching
handlers bound cleanup, and task switches preserve separate chains. Compiler
cleanup now protects typed caller and incoming-parameter references across
calls, later-argument failures and cancelled entry ticks. Consumed constructor
fields stay protected before allocation; worker result fields and remaining
caller references stay protected until record/variant boxing succeeds. Worker
argument preparation now protects original boxed arguments and each completed
field duplicate until worker transfer. Multi-field retain cleanup releases
completed extras on count overflow and protects existing caller owners before
duplication. Fusion registers the fields of synthesized Step variants. Inlining preserves
typed bindings for constructed and compile-time aggregates.
Nested constructor temporaries inherit known monomorphic context
for typed child cleanup; expression-inferred types remain authoritative. Boxed
variant conversion keeps original boxed and remaining caller owners registered
until typed payload retention succeeds. Record updates retain typed kept fields
and release replaced owners; replacement, partial retains and unfinished copies
stay protected through failure, while general copies preserve borrowed originals.
Boxed record conversion protects the original box, remaining caller owners and
completed typed field retains; matched results preserve the caller checkpoint.
Unmodeled callback boundaries retain shared fallback.

Merged runtime application cleanup protects consumed functions, pending typed
arguments and original stack captures through nonlocal unwind. It adds a typed
pending-argument drop pointer to owned-function metadata (eight bytes on 64-bit
targets); programs without possible unwind omit runtime registration. Scalar
words stay uncounted. Merged loop cleanup protects counted current state and
owned Step payloads; flattened loop argument preparation now protects the original
box and each completed field duplicate until transfer.

Accepted resource lifetimes and storage are summarized in
[ownership](ownership.md#original-resource-semantics). The queue records immutable
branches and the handoff records acceptance and the remaining tracing fallbacks.

The C backend and the interpreter must agree byte for byte on stdout,
stderr and the exit code. `tests/golden_run.rs` runs every program in
`tests/run/` through both.

## Syntax

- `#` starts a comment, so `#!/usr/bin/env fwp` works.
- Identifiers are `lower-kebab-case`. A hyphen may join letters, so there
  is no infix arithmetic: `x | sub 1` is `x − 1`.
- Uppercase names are types and constructors. An unknown uppercase name in
  a type (`T`, `Elem`) is an implicit type variable.
- Selectors (`.name`, `.0`, `.address.city`) are ordinary functions.
- A top-level declaration starts in column 1 and indented lines continue
  it. `match`, `trait` and `impl` use an offside rule; a braces-and-commas
  form works everywhere.
- Every standard function takes its subject last, which is what makes `|`
  read left to right.
- The type checker decides what `|` means. With a value on the left,
  `x | f` is application; with a function on the left, `f | g` is
  composition. If the left side is still unknown when the binding's
  types are solved, it defaults to application.
- `match` builds a function. Patterns never bind names; each `_` hole is
  passed to the arm's body as a curried argument, left to right.
- `quote` turns an expression into a `Syntax` value and `name!(…)` calls a
  macro. Tacit code has no local binders, so the only possible capture is
  at module level, and quoted names are qualified with their module.

## Types and effects

- Hindley–Milner inference with levels. Records and effects share one row
  unifier. Only signatures generalize: see [Generics](#generics).
- Calls reopen only their own closed effect row after argument unification,
  allowing callee effects in a larger ambient context without contaminating
  function-valued argument types. Pipe application, composition and ordinary
  application use this rule; required callback effects remain checked.
- The row-unifier refreshes tails after payload unification,
  preserving required effects or fields bound by those payloads. Positive and
  missing-IO State callback controls remain mandatory before acceptance.
- Callback argument comparison widens only the outer function effects
  permitted by the parameter. It preserves nested input rows, rejects missing
  required effects and reports the original value type on mismatches.
- Tuples are records with numeric labels, and unit is the empty record.
- Nominal records are distinct from each other but unify structurally with
  open rows, so `.name` accepts both `User {…}` and `{name = "x"}`.
- Higher-kinded parameters work through variable-headed application
  (`F[A]`). Type-level naturals (`Vector[F64, 3]`) may be sums and
  products of sizes (`n + m`, `m * n`, `Type::NatOp`). They unify as
  polynomials: equal polynomials unify, an equation in one unknown
  (`v + 2 = m + 3`) solves it when its value is a natural, and an
  equation still undecided is deferred and checked when the definitions
  of its group are (`Infer::check_sizes`). Monomorphization turns every
  size into a number.
- A size known only when the program runs is abstract: `_` or `_n` in
  the result of a signature (`vector.from-list : List[t] -> Vector[t,
  _]`). The definition chooses it; for callers it is rigid. In a
  function's result it is a marker (`TypeTable::markers`) that each call
  replaces by a fresh rigid size (`open_call`), so two calls give
  different sizes. A composition or `match` re-marks the sizes its body's
  calls chose (`Infer::reabstract`), since it runs them once per call. A
  marker bound anywhere but a function's final result would be shared by
  many calls, which is an error (`UnifyError::Abstract`). Sizes are
  phantom, so monomorphization gives abstract ones no number.
  Performance: abstract sizes move checks to run time — `vector.same-size`,
  `matrix.same-shape` and `matrix.as-square` compare lengths and return an
  `Option` that the program must take apart — where a static size costs
  nothing.
- Traits have superclasses, default methods and parameterized impls. The
  compiler solves `Eq`, `Ord`, `Hash`, `Display`, `Dup`, `Encode` and
  `Decode` structurally. Integer and float literals are classes that fall
  back to `FromInt` and `FromFloat`, so `Dual[F64]` accepts literals.
- Every arrow carries an effect row. Signature instantiation opens result
  spine rows for subeffecting. Actual calls reopen only their own closed row;
  temporary call rows include known ambient labels to a temporary open call row
  so State does not recursively contaminate a stored function type. Existing
  effect/type snapshots and positive/negative State controls pass in PR124. Handlers (`attempt`, `try`, `run-state`) remove labels by unification.
- Only the last arrow of a binding may have effects, so effects happen
  exactly when a call is saturated. Top-level values that are not
  functions must be pure (`main` and tests aside).
- `Error[E]` is a delimited abort: a Rust `Result` in the interpreter,
  `setjmp`/`longjmp` in C.
- Values flow linearly through a pipeline. Duplication happens only through
  combinators (`dup`, `fork`, `both`), which need `Dup[T]`; `resource`
  types are not `Dup`.
- Numbers have explicit widths. Arithmetic traps on overflow and division
  by zero; `wrapping`, `saturating`, `overflowing` and `checked` give the
  alternatives. There are no implicit conversions. The active format migration
  gives `F16`, `BF16` and `F128` their declared precision through shared software
  cores; [the format contract](float-formats.md) records integration and validation.

## Generics

Polymorphism is explicit, as in Odin, and every generic is resolved at
compile time.

- A top-level definition is generic only when its signature has type
  variables:

  ```fwp
  swap : (a, b) -> (b, a)
  swap = both .1 .0

  sum-squares : List[a] -> a where Add[a], Mul[a], Zero[a], Dup[a]
  sum-squares = map (fork mul id id) | fold add zero
  ```

  Inference still works inside every definition and along every pipeline.
  It never makes a definition generic on its own.
- A definition without a signature is monomorphic. A type left open only
  by a literal takes the literal's default (`I64` for an integer, `F64`
  for a float), as it does for values: `inc = add 1` is `I64 -> I64`.
  Any other type or record row variable is an error at the definition,
  and the error gives the inferred signature to write
  (`explicit_generics` in `src/infer.rs`):

  ```
  error: `square` would be generic, but it has no signature
    note: generics are explicit: write `square : a -> a where Mul[a]`
          to make it generic, or a signature with concrete types
  ```

  `main`, tests, the REST entry point and macros are exempt. The first
  three are values whose open types are `()`, and a macro's type is
  checked where it is expanded.
- Effect row variables are generalized without a signature. Effects are
  erased before code generation, so a function that is polymorphic in
  its effects is still one function.
- Generics are a zero-cost abstraction. The monomorphizer gives every
  instantiation its own function, with its types known, so the C backend
  generates typed scalar code and direct calls. Nothing is boxed or
  erased, as Java erases its generics, and no dictionary of methods is
  passed, as Go passes one to code shared by types of the same shape.
  Trait methods are resolved at compile time. A definition that would be
  instantiated at unboundedly many types (polymorphic recursion) is
  rejected.

Why: Haskell generalizes every definition it can and solves constraints
by passing dictionaries at run time. GHC then needs a large optimizer
(specialization, inlining, worker/wrapper) to win the performance back,
and pays for it in compile time. Its type errors also surface at a use,
far from the definition that was too general. GHC's own designers
stopped generalizing local definitions (`MonoLocalBinds`, after
Vytiniotis, Peyton Jones and Schrijvers, *Let Should Not Be
Generalised*, 2010), and it keeps the monomorphism restriction and
defaulting for top-level ones. fwp has no local definitions, and with
this rule it has no implicit generalization at top level either. Each
generic in a program is one the programmer wrote down. Monomorphization's
cost is code size, so explicit generics keep that cost visible.


PR122 merges direct typed variant alias transfer and checked nominal context for
match/field elimination. CAF caches own typed results, return separate owners,
and release after task teardown; inlined arguments still evaluate and release
before the callee. Spawn/deadline callbacks retain captures with rollback;
scopes protect result/storage through joining and unwind. Counted task handles
own cached results, and await returns separate owners. Typed channel queues
retain elements and transfer them on receive; close preserves queued values.
Explicit draining breaks the tested counted cycle; automatic unreachable-cycle
reclamation remains unproved. Unmodeled resource boundaries retain compatibility lifetimes.

PR123 accepts library input/result/unload ownership, scoped native and
interpreter OpenCL teardown, TLS listener/cache/wire/connect cleanup and File
construction/write/error/resource-frame protections. Fake OpenCL tests verify
API lifetimes; GPU hardware coverage remains separate. Nine raw-memory primitive
contracts borrow inputs; ptr.read-string returns an independent counted String.
Unsigned pointer-width wrapping matches the interpreter and keeps ordinary
checked arithmetic unchanged. Raw C buffers still require explicit mem.free.

## Runtime

- In C every value is a 64-bit word. Integers up to 64 bits and floats are
  stored inline; 128-bit integers, records, variants with fields, strings
  and closures are boxed; nullary constructors are small tags.
- A closure is a partial application of a known function. Tacit code has
  no free variables, so every function value can be serialized, which is
  how `comptime` results become static data.
- Native State uses per-task scanned storage and typed stack owner records.
  Inactive words clear on pop/error/task exit; typed values retain borrowed
  initials, own gets/results and release replacements across return and nonlocal
  exits. Task switches preserve scope chains. Legacy/unmodeled payloads retain
  tracing fallback. PR124 passes aggregate and escaping-closure controls.
- A type descriptor per monomorphic type drives equality, ordering,
  hashing, `Display`, text parsing, typed JSON and the binary protocol in
  C. For JSON, nominal records also carry their declaration order and the
  JSON names of renamed fields, and the descriptors of `Bool`, `Option`,
  `Json` and `Duration` are flagged.
- Floats print in the shortest form that reads back exactly.
- Native memory is collected by a non-moving mark-and-sweep collector
  (`runtime/fwp_rt_gc.c`). The heap is one reserved region of 64 KiB
  chunks; a chunk holds objects of one size class (16 bytes to 16 KiB)
  and one kind, or is part of one big object, and its class and mark bits
  are kept out of line, so any word can be tested for pointing into an
  object. Leaf objects (strings, bytes, boxed 128-bit integers, byte and
  float buffers) are never scanned; everything else is scanned
  conservatively, word by word, including the runtime structures that
  hold values (tasks, channels, gRPC connections and streams, temporary
  arrays). Roots are found conservatively: the registers (spilled to the
  stack), the running stack, the stack of every suspended task from its
  saved stack pointer, and the program's writable data segments, where
  static constants, CAFs and runtime globals live. Pointers into the middle
  of an object keep it alive, and from a stack so do pointers just past
  its end.

  Collection is generational without moving anything: mark bits are kept
  from one collection to the next, so an object that survived one is old.
  Most collections are minor: they mark from the roots without tracing
  into old objects and free only young garbage, so they cost what the
  young survivors cost, not the whole live heap; a major collection clears
  the marks and traces everything when the heap kept since the last one
  has grown by half. This needs old objects never to point to young ones,
  which holds because fwp values are immutable, with the help of a split
  by kind: records, variants and list cells are complete when allocated
  (`fwp_alloc_init`) and never written again, while memory that is filled
  after other allocations (arrays, maps, partial applications, temporary
  arrays, runtime structures: `fwp_alloc`) is scanned whole by every minor
  collection once it is old. The only write to a complete value in
  generated code, a record update, computes its new fields before copying.
  On a program that builds a map and churns through lists, minor
  collections cut the time spent collecting from 850 ms to 250 ms.

  A collection starts when the bytes allocated since the last one exceed
  the live heap (twice it without generations; 8 MiB at least); free
  chunks beyond a reserve are given back to the system. `FWP_GC=off`
  disables collection, `FWP_GC=full` makes every collection major,
  `FWP_GC_STATS=1` prints statistics at exit and `FWP_GC_STRESS=n`
  collects at every n-th allocation. `tests/gc.rs` runs every golden
  program with a collection at each allocation and `FWP_GC_VERIFY=1`,
  which checks each minor collection against a full trace from scratch
  and stops at the first reachable object it did not mark. WebAssembly frees
  typed last-owner storage without tracing. Unproved shared graphs remain
  retained because WebAssembly locals are invisible to a stack scan; libraries (`--staticlib`, `--cdylib`)
  use the collector's allocator but never collect, since the host's
  stacks are unknown. Linux finds program data segments with
  `dl_iterate_phdr`; the Darwin implementation finds the Mach-O image
  containing the runtime and scans its writable-at-load segments, including
  `__DATA_CONST` and zero-fill storage. Other native systems do not arm
  collection. Darwin validation is tracked in the session handoff.
  Runtime value/string constructors and list traversals keep their source
  objects/buffers reachable until the last allocating operation: `FWP_KEEP_ALIVE` is a compiler lifetime fence.
  Optimized Clang can otherwise preload a short buffer and discard its
  only root while its elements are still needed.
- Reverse-mode autodiff records operations on tapes kept by the runtime
  outside the program's values (numbers only), and tensor kernels run on
  OS threads that never touch the collected heap; both are implemented
  twice, with the same operation order (`src/numerics.rs`,
  `runtime/fwp_rt_kernel.c`, see [numerics.md](numerics.md)).
- Native tasks are green threads on an event loop: epoll on
  Linux, poll elsewhere. glibc uses `ucontext`; musl and Darwin use the
  runtime's custom x86-64/AArch64 context switch, with ELF and Mach-O
  symbol/directive conventions respectively. The active Windows port uses native
  fibers with explicit saved-register and stack root ranges; the OS owns stack
  reservation, commitment and ABI restoration. Native acceptance remains pending. Interpreter tasks are OS threads that pass a
  baton, so only one runs at a time. Function-entry preemption preserves
  deterministic ready-task interleaving across backends; relative wall-clock
  timers do not establish an order between independent effects. Use channels
  or awaits when output order matters.

## Numerical specialization

Pure, terminating numeric Array map/fold/length pipelines use a single loop
when their traps can be interleaved without changing observable behavior.
The loop starts from flat state fields; scalar array lookups use a tag and
payload without allocating Some. Record fields passed to borrowing operations
stay borrowed through their parent owner, including later argument evaluation.
Lookup lowering preserves original IR nodes because loop tails and unwind
liveness refer to those nodes.

Canonical F64 matmul checks runtime dimensions and array lengths once. Valid
shapes use32-element blocked loops over contiguous numeric data, with one fresh
output and borrowed inputs. Loads/stores preserve C aliasing rules and support
views and shared backing. Each output accumulates in ascending inner-index order,
with multiplication followed by addition and contraction disabled. matrix.cast
can preserve inconsistent runtime fields; those values retain the library's
existing list/chunk/zip semantics. Compiler-internal matrix primitives cannot be
called through source foreign declarations.

AD tape capacity is limited before allocation by the signed vertex index and
native address width. Native and interpreter runtimes may retain one detached
workspace up to512KiB; oversized buffers are released. Reuse clears adjoints and
retains generation/token validation. Scope exit, traps, cancellation and library
unload retire owners. Cold/warm allocation and native/WASI boundary controls
cover the private buffers separately from the managed result array.

## Checked native ARC execution

The `fwp build --gc arc` mode admits immutable typed value graphs and
scoped File/State owners, counted I128/U128 leaves and typed reconstructed trees whose
compiler/runtime ownership contracts are established. The handoff distinguishes
current implementation from accepted production gates.
The checker visits monomorphic function/local types, ownership temporaries and
primitive boundaries after reference-count insertion.
Ordinary calls, records, variants, captured functions and numeric containers keep
their existing Pipe syntax and value semantics. Scalar fields finish evaluation
before consuming later arguments; reference-valued borrowed fields retain their
parent owner through the operation. Inlining retains typed locals for constructed
aggregate arguments so ownership lowering keeps their child types.

ARC builds require counted ownership and freeing. They exclude the collector
body and reject incompatible tracing/reuse-poison settings. An attempted
promotion of a counted owner to uncounted runtime sharing is a contract error.
The native allocator still maintains allocation and reference-count metadata;
released value storage returns to that allocator. Reserved pages and permanent
program constants are separate from live temporary values.

Eligibility excludes unproved mutable/cyclic runtime graphs, external retained
callbacks, raw pointers, unscoped reverse-mode operations, unchecked user native
declarations, managed foreign/remote calls and unmodeled shared results. PR #135
extends admission to typed retained-task captures and recursively pointer-free
foreign C records, scoped text/byte borrows and synchronous foreign callbacks
with copied C values, pending acceptance. The callback context follows the
calling task, with unwind cleanup. Child tasks start independent State/AD
contexts; the closure-flow proof clears parent scope assumptions at spawn/within. Native symbol names alone do
not establish ownership signatures. A finite closure-flow analysis proves that
executed ad.tape/ad.push/ad.backward calls occur under ad.scope/ad.scope2. It
tracks partial applications, returned callbacks and functions inside containers;
ambiguous targets are rejected. Function names confer no exemption. Arguments
evaluate before the scope callback, and escaped tokens retain stale-token checks.
Scoped gradients use the same bounded workspace and exceptional cleanup. The initial checked mode supports native main programs;
WebAssembly, executable protocol, library and service boundaries diagnose as
unsupported. `--gc tracing` explicitly selects the existing compatibility mode;
no ARC rejection silently selects it. The handoff records production acceptance.

## Executables and the pipe protocol

Each exported function can be built as its own executable. Arguments fill
the leading parameters, parsed by type; the last parameter comes from
stdin, per line or frame for `T` and all at once for `List[T]`.

A first parameter that is a record becomes flags, and the doc comments
above an `export` become its `--help`; `fwp build --cli` puts all the
exported functions into one executable with subcommands
([cli.md](cli.md)). The comments are read from the source text after
parsing (`cli::Docs`), so they need no syntax of their own.

Between fwp executables, values travel in the `PIPE_V1` binary protocol: a
header with the magic `FWP1`, a version, capabilities, a 128-bit type
fingerprint and the canonical type string, then frames of
`kind:u8, len:u32le, payload`. The payload is a deterministic
little-endian encoding driven by the type. A fingerprint mismatch is an
error. See [protocol.md](protocol.md).

## Builds

| Output | How |
|---|---|
| executable | C compiled and linked with the runtime; the reachable standard library is included. Programs whose reachable code uses TLS (a `tls.*` primitive) or services also get `runtime/fwp_rt_tls.c` and are linked with `-lssl -lcrypto`; the interpreter reaches the same OpenSSL through `dlopen` (`src/tls.rs`), so the compiler links no TLS library. See [tls.md](tls.md). Programs that serve or send HTTP (HTTP/2, compression, WebSocket frames: `http2.*`, `zlib.*` and `ws.*` primitives) also get the HTTP/2 runtime of gRPC (`fwp_rt_h2.c`, `fwp_rt_grpc.c`) and `runtime/fwp_rt_http2.c` |
| `--fn f` | the exported function `f` as a standalone executable |
| `--cli` | every exported function exposed as `cli` (`# expose:`, read with the doc comments in `src/cli.rs`) as a subcommand of one executable. `src/cli.rs` computes the command line of each function (flags from an options record, positional arguments, defaults evaluated with the interpreter at build time) and its help and usage texts once; the C runtime (`runtime/fwp_rt_exec.c`) gets them as static data and parses arguments with the same rules as `src/exec.rs`. See [cli.md](cli.md) |
| `--rest` | every exported function exposed as `rest` as an endpoint of one HTTP server. `src/rest.rs` computes the endpoints from the types and doc comments (routes, where each argument comes from, statuses) and `src/openapi.rs` the OpenAPI document; the file is then compiled again with a generated `main` (`Roots::entry`) that serves `rest.endpoint`s of `lib/rest.fwp` over the HTTP server of `lib/http.fwp`, with authentication (`rest.secured` and the file's `authenticate`, compiled by name: `Roots::names`), time limits, CORS, forms and `multipart/form-data` bodies (`RestSource.Content`), content negotiation (`rest.endpoint-as`) and an HTML page of the document, all in fwp. `fwp openapi --import` reads JSON and YAML (`src/yaml.rs`, a YAML 1.2 reader of its own) and converts Swagger 2.0 to OpenAPI 3 (`src/swagger.rs`). Arguments and results go through the typed JSON codec (`json.read`, `json.write`), a primitive written twice: `src/jsontype.rs` over types, `runtime/fwp_rt_json.c` over type descriptors. See [rest.md](rest.md) |
| `--fat` | one copy of the program per x86-64 CPU level, chosen at startup |
| `--mcp` | every exported function exposed as `mcp` as a tool of a stateless MCP server (protocol 2026-07-28). `src/mcp.rs` derives each tool's arguments and JSON Schemas from its type (the schemas of `src/openapi.rs`, under `$defs`), and the results of `server/discover` and `tools/list`; as with `--rest`, the file is compiled again with a generated `main` that calls `mcp.serve` of `lib/mcp.fwp`, where the protocol (JSON-RPC, the version check, the stdio and HTTP transports) is written in fwp. See [mcp.md](mcp.md) |
| `--service m` | the program split into gRPC services: a server executable for each named module, and a main executable whose calls to those modules' exported functions are remote. `src/rpc.rs` derives each function's messages and streams from its type (`Iterator`, `Channel`) and the `.proto` text; the transport runs on the task scheduler: `src/grpc.rs` for the interpreter, `runtime/fwp_rt_grpc.c` natively. The monomorphizer replaces each such call with a client stub (`Body::Remote`); see [services.md](services.md) |
| `--staticlib`, `--cdylib` | a C library and header for the exported functions |
| `--target wasm32-wasi`, `wasm32-browser` | WebAssembly through clang; `setjmp`/`longjmp` use the WebAssembly exception proposal. Effects the target lacks (`Network`, `Process`) are compile errors. Tasks are fibers (`FWP_FIBERS` in `runtime/fwp_rt_task.c`): the scheduler is the native one, but `swapcontext` becomes a call to a hook that the JavaScript host installs in the function table (`web/fibers.js`), which suspends the calling fiber with JavaScript Promise Integration and resumes the next one; each task has its own 1 MiB region of linear memory for C's stack, and the stack pointer is saved and restored around each switch. Waiting for a timer with every task parked is another hook, a JavaScript timer |
| fwp itself, `--target wasm32-wasip1` | `cargo build --release --target wasm32-wasip1`: the compiler and interpreter as one WASI command, `fwp.wasm`, which the playground (`web/`) runs in a web worker through a small WASI written in JavaScript (`web/wasi.js`). There are no threads, so `with_big_stack` runs inline on a 512 MiB stack set at link time (`.cargo/config.toml`), and a program that uses `Network`, services or foreign C functions is rejected after lowering, before it runs (`driver::wasm_host_unsupported`), as the `wasm32-wasi` target rejects it. Tasks run on fibers (`src/fiber.rs`, with the same hooks as compiled programs): `World::park` switches to the next ready fiber instead of handing a baton between threads, in the same order, and traps on a deadlock. The interpreter's frames in linear memory are large (about a kilobyte per call), so the fibers of tasks share one 32 MiB stack region: a fiber that suspends copies out the part it uses, and copies it back when it resumes. Without JSPI, a program that uses tasks is rejected before it runs, unless fwp.wasm was built with `scripts/build-playground.sh --asyncify`. Commands that compile C or start processes report that they are unavailable. Stdout is line-buffered there, so the output before an engine stack overflow is kept; values are dropped iteratively, so long lists do not need a deep stack |

## Not implemented

- General execution without tracing GC. Checked native ARC supports the proved
  ownership subset; unproved reconstructed graphs, retained runtime/foreign
  contexts, cycles and unproved AD lifetimes remain outside it.
  [Ownership](ownership.md) specifies coverage and numeric representation limits;
  [PLAN](../PLAN.md) records the remaining efficiency gaps. C structs alone do
  not guarantee registers.
- Windows on AMD64 and ARM64 is in active development. Interpreter platform probes pass, but the generated runtime and release packages are not yet verified.
  Linux/macOS have native CI on both architectures; see the
  [platform matrix](../PLAN.md#platform-objective-and-current-evidence) and handoff
  for actual acceptance gates. Cross-build/QEMU evidence remains distinct.
- Darwin cross-compilation and Clang PGO.
  Native macOS passed both architecture suites and the Linux/benchmark gates
  in PR #74; separate ARM and Intel binaries meet the packaging objective.
  Universal binaries are outside scope. Verification is recorded in
  [the handoff](development-state.md).

- HTTP/3; HTTP/2 server push and
  WebSocket over HTTP/2 (RFC 8441); WebSocket extensions other than
  permessage-deflate, and its context takeover; content codings other than gzip and deflate
  (streamed responses: gzip only). REST bodies are JSON, forms and
  `multipart/form-data` in, JSON, text and CSV out, read and written
  whole (no XML, no streaming bodies).
- TLS of fwp's own: TLS uses the system's OpenSSL 3 ([tls.md](tls.md)),
  which native programs that use it link and the interpreter loads at run
  time, with client certificates (mutual TLS). DTLS and QUIC are not
  implemented.
- Sockets and foreign C functions in the WebAssembly build of fwp (the
  playground): a browser has neither sockets nor a C compiler. Tasks on
  WebAssembly need JavaScript Promise Integration, or binaryen's
  Asyncify (`--wasm-async=asyncify`, and
  `scripts/build-playground.sh --asyncify` for fwp.wasm); WASI runtimes
  without a JavaScript host run no tasks.
- A JIT, and distributed execution (tensors sharded across processes,
  collectives). Reverse-mode autodiff and devices for fused tensor
  kernels (CPU threads, OpenCL loaded at run time) exist
  ([numerics.md](numerics.md)), but the OpenCL path has only been run
  without an OpenCL device; kernels are elementwise expressions and sums.
- Transports of the pipe protocol other than the pipe, `UDS_V1` and
  `SHM_V1` (which are Linux only), the WebAssembly component model and
  `wasm64`.


## Ownership implementation

PR124 accepts compiler and runtime ownership for original resource frames,
File IO/storage, typed State, synchronous list callbacks, scoped AD and resource/
network contexts. Typed holders preserve original lifetime/trap order through
inlining and flattening. Incoming owners, partial retains, callback results and
scratch remain protected across error, raw trap and cancellation; frame assignment
follows successful acquisition. FWP_FRAME_FIELDS=0 preserves the boxed control.

Native File owners close at original frame boundaries independently of optional
ordinary freeing. Inline paths use aligned leaf storage; constructor rollback
closes streams and last-owner release removes library finalizers before freeing
unshared headers. Shared headers keep compatibility lifetime. Actual WASI verifies
aggregate/task resource counts; typed last-owner storage is freed, while unproved shared graphs remain retained.

HTTP/2 and gRPC owners protect metadata roots, dequeued/copied messages, status,
encoding scratch, connections and inherited task contexts. TLS options/metadata
retain their original scoped and task owners; completion releases acquired owners
through joins and cancellation. Length-framed full keys preserve pool identity;
aligned tail storage avoids separate option strings and connection addresses.
Library teardown drains tasks and finalizers before clearing read-once TLS caches.
Protocol bytes, receive order and observable evaluation/trap order stay unchanged.

Unknown reconstruction, cached decoded values and retained callback boundaries
keep tracing compatibility. Channel close preserves queued values; explicit drain
breaks the tested counted cycle, while unreachable shared cycles still require
tracing. [Ownership coverage](ownership.md#ownership-coverage) and
[the handoff](development-state.md) record the finite review and accepted scope.


## Wide scalar workers and float formats

Eligible closed I128/U128 arithmetic functions receive native wide arguments,
keep native locals and call other eligible workers directly. Generic entries
copy incoming bits before releasing typed boxes and box an escaping wide
result. Containers and closures keep their established counted representations.
Checked operations share the runtime's overflow/division rules. Arguments are
evaluated into ordered temporaries before native calls, preserving trap order.
`FWP_WIDE_WORKERS=0` disables this lowering for equivalent-workload controls.
Unsupported expression shapes retain the ordinary lowering; this is a compile-time
eligibility choice. C compilation decides register assignment and spills.

[Float formats](float-formats.md) records the implemented F32/F64 representations
of half/wide float names and the decision for a coordinated future format and
protocol migration. Current native ownership/array claims do not imply true
binary16, bfloat16 or binary128 arithmetic.
