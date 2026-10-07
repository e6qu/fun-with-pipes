# Ownership and efficient native execution

This is the development contract for the memory work in [PLAN.md](../PLAN.md).
It separates existing behavior from proposed changes. Current progress and
validation are in [development-state.md](development-state.md).

## Stable language behavior

Keep tacit, curried, data-last pipes, composition, immutable values, strong
static inference, tracked effects and checked arithmetic. Generic definitions
have explicit signatures and are specialized at compile time. Storage,
ownership and calling conventions are compiler concerns unless a separately
reviewed language design requires a surface change.

Optimization preserves evaluation order, effects, failures and trap messages.
An internally mutable unique buffer still has immutable source semantics:
an alias observes the original value. AD tape operations must not be duplicated
or hoisted merely because their public types are pure.

## Existing implementation

`src/rc.rs` inserts and checks `Dup`/`Drop` after the other IR passes.
Functions and constructors consume owned arguments; primitive, foreign and
remote calls normally borrow. Selected container primitives consume their
container argument. [The shared primitive contract inventory](primitive-ownership.md)
drives argument modes, runtime sharing and owning wrapper selection for arrays,
maps and sets. Comparison-only keys borrow; inserted keys remain shared.

Generated drop functions free counted objects at their last reference.
Unique records, variants and containers can reuse storage. Escape analysis,
scalar replacement, specialized calls and pipeline fusion eliminate many
allocations before counting is needed.

| Category | Current treatment | Remaining work |
|---|---|---|
| Scalars and nullary variants | Inline words; no counting | Preserve typed arithmetic and improve native ABI where measured |
| Eligible records/variants | Fields/structs or stack; otherwise counted heap objects | Broader layout and escape evidence; remove unnecessary counts |
| Arrays | Counted storage and typed element ownership across creation, copies, updates and callbacks | Natural-width storage, views and retained/exception lifetime coverage |
| Maps, sets | Counted storage with typed key/value ownership, copied aliases and synchronous callbacks | Old-object reclamation, runtime lifetime and numeric layout coverage |
| Strings and bytes | Selected copy/alias primitive results counted; leaf destruction frees storage directly | Complete remaining result families, callback lifetimes and exceptional cleanup |
| Escaping closures | Compiled dynamic calls own heap closures and typed captures; runtime callbacks still share | Retained callback ownership, remaining temporary contexts, retained callback and exceptional cleanup |
| Tasks, channels, networking, callbacks | Runtime structures and shared value boundaries | Explicit retained ownership, teardown and cancellation paths |
| AD tapes/kernel buffers | Numeric arrays outside the collected value heap | Cleanup on failure/cancellation, capacity reuse and scoped lifetimes |

Native executables still need a generational conservative collector for shared
values. WebAssembly uses a bump allocator; native libraries do not trace the
host's unknown roots. `FWP_GC=off` disables tracing, not all allocation and not
the ownership gap. `--memory static` provisions bounded memory, not static
lifetimes. None of these is a general collector-free execution guarantee.

## Next ownership change

The shared inventory consolidates array/map/set contracts and borrows comparison-only
keys. Arrays now own typed elements across their native boundaries. Maps/sets now own typed keys and values too. Old marked allocation reclamation is prepared. Next finish retained runtime callbacks, including exception,
handler/cancellation teardown and cycles. Keep the IR pass
and code generator on the same contracts.

Contracts must distinguish borrowing for the call, consuming a reference,
retaining a reference beyond the call, returning a fresh owned value, and
returning an alias of an argument. A borrowed callback input cannot silently
become an owned result. A slice must retain its backing buffer if it escapes.

Start with read-only container primitives that currently force sharing.
Eliminate redundant counts/transitions there, measure the result, then extend
coverage to strings/bytes, closures and runtime structures in focused changes.
Do not indiscriminately count every short-lived list: the delivery history
records a case where doing so slowed execution by 35%.

Each change needs aliasing, escape and callback tests; branch and tail-call
ownership checks; GC/reuse verification; and allocation/count evidence.
Failure, handler unwind, cancellation and FFI lifetime paths are part of the
contract. Define how runtime cycles are broken before removing tracing.

## Representation and numerics

Prefer elimination, registers and scalar replacement, then stack allocation,
ownership transfer, scoped regions and reference counting for sharing. A
heap-owned reusable buffer is appropriate for large or dynamic tensors;
forcing them onto a stack is not the goal.

Current generic array slots are 64-bit `V` words. Plan specialized contiguous
numeric buffers with natural element widths, checked strides and bounds,
aligned payloads where useful, and views with explicit backing lifetimes.
Measure array-of-struct versus struct-of-arrays layouts for each workload.
Do not pad every small object to a cache line.

C ABI struct returns can use registers or caller storage. Check emitted arm64
and x86-64 assembly for spills, floating-point register use, boxing and calls;
the number of fields alone is not a machine-speed guarantee. The C backend
remains the first implementation target.

Keep deterministic operation/reduction order by default and contraction off.
If relaxed floating-point arithmetic is later exposed, it needs an explicit
contract and separate tests. Prioritize fused elementwise and gradient kernels,
blocked matrix multiplication, reusable tape/scratch buffers and exceptional
cleanup before adding accelerator backends. OpenCL discovery is not evidence
that kernels executed on a real device.

## Evidence required

Use equivalent workloads against C and Rust, with allocation-inclusive and
kernel-only timings separated. Record hardware, compiler/version, flags,
input sizes, output checks, allocated bytes, peak live bytes, count operations
and collection pauses. Keep noisy timing thresholds out of shared-runner CI;
assert semantic results and stable allocation properties instead.

Run full workloads on GitHub runners. Passing Linux tests alone does not
validate Darwin root discovery, task ABIs or Apple Silicon numeric behavior.

## Remaining leaf and capture coverage

Selected direct leaves and copied Option/List trees now have ownership contracts.
Other IO/network/runtime results still share. Primitive contract coverage alone
is not proof that every result has deterministic reclamation. Complete retained
container elements, callbacks/captures, handlers/traps, FFI retention and young/old
collector interaction. Typed record/variant drops release their children;
prepared typed container drops release elements as well as outer storage.

The prepared old-object change permits final counted references to free marked
storage; immutable in-place reuse remains young-only and has separate stress
evidence. Define cycle
policy and teardown before claiming general execution without tracing GC.

## Prepared leaf ownership implementation

`String` and `Bytes` locals now participate in IR ownership. Selected primitive
results establish counts: copies start fresh, `string.to-bytes` duplicates its
identity result, and padding/replacement duplicate the input when a no-op returns
it unchanged. Their read-only arguments borrow without promoting the leaf to
runtime sharing. Unknown runtime and FFI boundaries retain the shared fallback.

Leaf allocations use the existing out-of-line count metadata. Sharing stops at
a leaf; its bytes are not scanned as pointers. A generated typed leaf drop frees
the allocation directly rather than reading an ADT tag. Reuse verification
poisons only within its capacity and clears its String/Bytes length, avoiding
the record poisoner's interpretation of that length as a field count.

The focused copy loop demonstrates reclamation of young owned leaves on normal
paths. It does not establish full ARC: other runtime-created text results, retained
container elements, callbacks, stack captures, handler unwind and cancellation
still require ownership contracts and cleanup. Prepared native releases now reclaim
old storage at the final counted reference; immutable reuse remains young-only.
WebAssembly still uses its bump allocator.

## Prepared nested text result ownership

Generated type-directed helpers own copied String/Bytes result trees returned by
selected primitives. They install one count on every new object, skip scalar
fields and traverse list tails in a loop. The fresh-tree contract prohibits input
aliases, internal sharing and cycles; it is narrower than general graph ownership.
Numeric parse options remain shared while representation/destruction of boxed
numeric cases is unfinished. Full inventory and regression details are in
[primitive-ownership.md](primitive-ownership.md).

## Compiled closure ownership

Function locals participate in IR Dup/Drop. Compiled dynamic application consumes
its function reference and arguments. Partial application builds a fresh heap
closure, duplicates existing captures by their monomorphic types and transfers
new arguments. Full application duplicates the captured references for the
callee, consumes supplied arguments and releases the function after the call.
A retained function alias keeps its captures alive; overapplication continues
with the returned owned function. Static function values remain off the heap.

Each live function used as a closure has sparse metadata for an owned entry and
typed capture handling. The function table adds one metadata pointer per slot;
this is a layout cost, not a measured speed improvement. Capture cleanup never
counts inline scalar bits. Primitive owned entries release borrowed arguments
after the call, preserve their addresses as collector roots, and respect consumed
container arguments. Unknown FFI/runtime boundaries still promote values to
sharing. Runtime callback entries explicitly share their typed inputs and results.

The focused closure regression checks retained captures and function aliases,
partial applications and input-returning functions against the interpreter at
-O1/-O2, with GC stress/verification and both reuse-poison modes. A 10,000-step
heap-closure loop, with tracing off and zero collections, frees 1.2 MiB by counts
versus 0.0 MiB with FWP_FREE=0 (Apple Silicon, Apple Clang 17, -O1,
FWP_STACK=0; counters rounded to tenths). This demonstrates the selected path,
not complete ownership. Full architecture and benchmark gates remain required.

Eligible stack aggregates now retain typed child ownership; runtime-retained
callbacks, exceptional paths and WASI reclamation remain gaps. Closure releases use a per-thread work list to avoid recursion through nested
function captures. Other aggregate destruction and incomplete temporary types
still need coverage before general no-tracing support. Cycles still require an
explicit policy.

## Bounded function capture cleanup

An outer closure release drains a work list. Nested function capture releases
queue their owned reference instead of recursively entering capture cleanup.
The work list keeps 64 values in the current C frame; wider pending work spills
into an explicitly freed allocation outside the collected heap. Neither the
queue nor typed capture destruction invokes a collection safe point. Native
contexts are per thread; WASI has no runtime threads and retains its no-op counts.
This limits C call depth through function captures, not arbitrary aggregate shapes.

The focused regression constructs 8,000-node linear and branching capture graphs,
then releases them on a 256 KiB native worker stack. At -O0, restoring only the
recursive release exhausts that stack; the work-list version completes, matches
the interpreter and reports zero collections with tracing disabled. Both nodes
and captures are released by counts; the branching graph exercises the spill
path. Optimized GC/reuse alias tests remain passing. Full native/WASI/platform
and benchmark gates are still required before this prepared change merges.

Investigation also exposed incomplete concrete typing of constructor temporaries:
borrowed constructor arguments previously fell back to the unknown type and
only decremented their outer count. Call parameter types now give these
ownership temporaries concrete monomorphic types, so typed release reaches their
children. Remaining constructor/result/field contexts still need coverage.

## Concrete call argument temporaries

IR constructors carry tags/fields without a standalone nominal type. When a call
parameter supplies that type, the ownership pass retains it on new temporaries
instead of using the unknown-type fallback. Existing inferred expression types
take precedence. Both owned function calls and borrowing primitive/FFI calls
provide their concrete parameter types; uncounted scalar temporaries stay scalar.
The evaluation sequence and early/last-use ownership discipline are unchanged.

A List-of-functions probe restores only the previous outer count decrement in
emitted C. With tracing off and zero collections, typed temporary cleanup frees
0.5 MiB versus 0.0 MiB, with identical interpreter output (Apple Silicon, Apple
Clang 17, -O1, FWP_STACK=0, 10,000 iterations, 0.1 MiB counter precision).
Retained function/list aliases and literal leaf/Option children match both
backends at -O1/-O2 under GC stress/verification and both poison modes. Earlier
container/leaf/text/closure/cleanup checks and five FFI regressions pass locally.
Full CI remains required. This covers call argument temporaries; it does not
complete type propagation into every generated constructor or aggregate.

## Owned children of stack aggregates

A stack wrapper does not have a heap count slot. Cgen now tracks its concrete
children in the frame instead. Dup/Drop of an eligible local or alias changes
those child references directly. A consumed stack argument retains its children
through the call and releases that owner's references after returning. Dynamic
application does the same for stack closures. Record/variant unboxing transfers
child ownership, and each normal or unboxed call has its own cleanup scope so
nested argument evaluation cannot release another call's children prematurely.

The stack object layout stays unchanged. Callees keep their existing behavior
for an off-heap pointer and duplicate retained fields/captures; cleanup in the
owning frame gives up the original references. Address fences retain children
through allocating calls. Heap reuse tokens and the in-place-update shortcut
are bypassed for tracked stack objects. Unknown child types retain the fallback;
this does not implement cancellation/handler unwind or runtime callback retention.

Two focused regressions compare interpreter/native aliases and record/variant
return paths at -O1/-O2, GC stress/verification and both poison modes. Restoring
only the previous retained child lifetimes, with tracing off and identical
output, changes a 10,000-step variant loop from 0.5 to 0.0 MiB freed by counts,
and a closure loop from 1.7 to 1.3 MiB (Apple Silicon, Apple Clang 17, -O1;
counters rounded to tenths). Fifteen focused ownership tests and the existing
stack closure allocation elimination regression pass locally. Full architecture,
WASI, GC/reuse sweeps and benchmark gates remain required before merging.

## Exact high-fanout counts

The native common case keeps one-byte counts. Counts above 254 use rare size_t
side entries keyed by canonical metadata slots; they add no value roots.
Typed releases, closure cleanup and raw decrements use the same wide-aware
operation. Side entries disappear as counts shrink, sharing is explicit, storage
is freed/reused, or the collector sweeps it. Overflow and allocation failure are
explicit failures. High fanout no longer implicitly changes an owned graph to
runtime-shared lifetime. See [primitive contracts](primitive-ownership.md#exact-reference-counts-above-the-byte-range)
for overhead, tested boundaries and no-tracing reclamation evidence. This does
not complete phase 2 or eliminate tracing at other runtime boundaries.

## Prepared reclamation of surviving owned storage

A typed release of the last counted reference frees native storage even after
it survives a major or minor collection. Shared graphs have count zero and
remain with tracing. Freeing clears mark/count metadata; the next allocation
in that cell is young. Immutable record updates and reuse tokens still require
young storage, preserving the no-old-to-young-edge invariant. Under GC verification,
freed small cells have stale children cleared before joining the free list.
Reuse poisoning quarantines the cell instead of freeing it.

`tests/old_reclamation.rs` exercises actual collection survival, small/large
leaves, records, owned closure captures, arrays and maps, alias counts and shared
graphs. A separate 250-collection leaf probe frees 4.8 MiB versus 0.0 MiB when
only the former age gate is restored (Apple Silicon, O1, counter precision
0.1 MiB). Task/channel/cancellation golden cases pass O1/O2 stress, verification
and poisoning. This is focused reclamation evidence, not full ARC or a speed
claim. The Linux long-loop test retains explicit collection coverage through
an ownership-disabled build; its large runtime gate belongs on CI.

## Prepared task/channel result boundaries

Every task/channel foreign declaration now has an explicit ownership contract.
Retained callbacks, handles and channel payloads still share; completing their
lifetimes requires coordinated task ownership and exception/cancellation cleanup.
Fresh await/within/receive Option wrappers own type-directed aliases, allowing
normal typed destruction to reclaim wrappers without claiming payload ownership.
Deadline passthrough returns a typed owned alias instead of promoting the input
graph to sharing. Duration inputs borrow, with conservative roots through calls.

Focused O1/O2 stress/poison checks cover retained aliases and repeated awaits.
Generated-wrapper probes reject count operations on address-shaped scalar bits.
A 10,000-step tracing-disabled control loop frees 0.0 -> 0.5 MiB when only the
old deadline sharing boundary changes. This measures the selected normal path;
retained task lifetime, failure cleanup and full platform validation remain open.

## Prepared runtime unwind boundaries

Error handlers, recoverable gRPC traps and task cancellation now carry a
boundary for stack cleanup nodes. Nodes hold a release callback/context;
normal return unlinks them, and nonlocal unwind releases them before destroying
frames. Chains switch with each task, isolating suspended owners from a different
task's cancellation. Callbacks release storage synchronously without throwing,
suspending or registering another cleanup node.

file.with registers its open stream before handle allocation and closes it on
normal/error/trap/cancellation exits. The handle is invalidated after close.
Pre-handle failures close the raw stream. This matches the interpreter's close
on every returned control result and keeps File's affine typing unchanged.
The focused test checks actual descriptor closure and typed cleanup order under
stress, and normal/error pipe programs against the interpreter.

Runtime hooks do not yet register all compiled locals. Completing exceptional
ownership requires liveness across Dup/Drop, moves, stack fields, worker ABIs,
callback accumulators and tail calls. Incoming owners need registration before
Async preemption ticks, even in otherwise pure callees. Scalar paths should not
receive cleanup frames. Retained task ownership remains incomplete until those
paths are implemented and validated on all architectures.

## Compiler reuse-token lifetime

After dropping a unique record or variant's fields, the compiler may hold its
outer cell for a later constructor of the same size. This is a separate temporary
owner: its fields have already been released, so cleanup must never drop them
again. Clear all dead field words before any safe point, including pointer-shaped
scalar bits. Only young cells are reused in place. Release unused cells at scope
exit and release cells that became old before allocating a replacement.

When the executable can unwind through handlers, traps or cancellation, register
the token's ownership slot in the task-local cleanup chain. Clear the slot on
constructor transfer or cleanup, so each path releases at most once. Unlink and
release dead tokens before tail calls. Programs without nonlocal unwind omit
these registrations. Freeing-disabled comparison builds decrement counts without
freeing; the bump allocator retains its existing shared allocation convention.

Focused checks cover emitted compiler code at O1/O2, forced major collection,
unused constructor branches, normal/error results, poison verification and
ownership switches. These are prepared changes until the sequential PR passes
full CI. Other live compiler locals, pending arguments, stack/unboxed values,
runtime callback accumulators and retained task lifetimes still need unwind
ownership coverage; token cleanup does not establish general collector-free
execution.

## Prepared call liveness and unwind ownership

Call ownership facts come from the same checked reference accounting as IR
Dup/Drop, including reference multiplicity. A borrowed field or pattern alias
adds no separate owner. Computed counted arguments become named temporaries
before the operation; earlier computed scalar arguments keep their evaluation
order. This preserves earlier owned results while a later argument can fail.

Generated call scopes save the caller's references that have not transferred to
the callee, using type-directed drops on nonlocal unwind. Scalar bits are never
counted. Unboxed records save only counted fields; struct variants retain their
tag-directed cleanup. Stack aggregates save their owned children. A consumed unmanaged stack argument
also leaves its original children with the caller until return; include those
references in the exceptional scope. Hoist capture evaluation before choosing
closure storage so named arguments do not force stack closures onto the heap. Pure programs
without possible unwind and call sites without live owners need no such scope.
Normal returns pop the scope without releasing its saved references.

Incoming parameters are registered before a cancellable entry tick. A wrapper
that passes unboxed fields to its worker has two separate owners: the original
boxed argument and the duplicated child references consumed by the worker.
Protect the original across the worker call as well. Named variant moves can
stay in structs when the destination is only matched or returned as struct
parts; avoid introducing a heap box merely for unwind bookkeeping.

Focused evidence covers actual generated code, reference counts and immediate
free counters, normal/error results, external aliases, pending arguments,
boxed/unboxed wrappers, cancellation before the body and struct variant payloads.
Full architecture and benchmark gates still remain. This does not cover every
exceptional path: runtime callback accumulators, retained task
owners, allocator/boxing failures, CAF ownership and inline code rewrites still
need explicit coverage before claiming complete ARC or collector-free execution.


## Prepared runtime application cleanup

Runtime dynamic application retains its consumed function until the entry
returns. Register that owner while an executable can unwind, and release it on
errors, recovered traps or cancellation. Register pending supplied arguments
until they transfer to an entry or fresh partial application; overapplication
keeps the suffix typed along the full specialized arrow spine. Scalar words
remain uncounted, even when their bits name an allocation. Primitive/FFI owned
entries protect the borrowed arguments that they normally release after return.
Consumed stack closures leave their original capture owners with the caller
until return; dynamic application includes these in its exceptional scope.

Sparse owned-function metadata gains one typed pending-argument drop pointer,
eight bytes on 64-bit targets, without changing the ordinary function-table
slot's pointer count. Pure programs compile out runtime cleanup registration;
call sites without managed functions or pending typed arguments omit it.

Five focused tests exercise actual generated entries at O1/O2 with collection
stress/verification and both poison modes, external aliases, scalar address bits,
primitive traps and cancellation before entry. A controlled 10,000-failure loop
on Apple Silicon with Apple Clang 17 at O1 frees 0.3 MiB by counts, versus 0.0 MiB
when only the consumed-function unwind release is removed. Both have tracing
disabled and zero collections; counters round to 0.1 MiB. This measures immediate
reclamation, not elapsed performance or complete collector-free support. Full
architecture gates remain for this branch's sequential PR. Callback accumulators,
retained task lifetimes, allocator/boxing failures, CAF ownership and inline
rewrites still require coverage.


## Prepared map accumulator cleanup

Synchronous map owns only its completed callback-result prefix. The untouched
scratch suffix borrows the original list; unwinding must never drop these borrowed
words. Typed cleanup releases completed results and scratch. As result nodes are
built in reverse order, each element transfers into the partial list before the
next allocation; the cleanup scope owns the residual prefix and this partial
spine separately. This covers later callback errors, recovered construction traps
and cancellation, including dynamic, direct and captured specializations.
Normal return transfers the finished list and releases scratch. Pure programs
omit cleanup registration. Scalar result words need no child drops.

Focused checks compare interpreter/native behavior and actual generated cleanup
at O1/O2 with collection stress/verification and reuse poisoning. They preserve
an external input alias while inspecting immediate result/scratch reclamation,
including cancellation after a completed result and a trap after the first node
has been built. Full sequential CI remains required. Filter/take-while/zip
prefixes, fold/loop accumulators and retained task lifetimes remain separate work.


## Prepared predicate selection cleanup

Filter and take-while duplicate selected aliases independently of the input
list. A typed scope owns that selected prefix and its scratch buffer; each
selected element then transfers into the partial result spine. A failed later
predicate, recovered construction trap or cancellation releases these owners
without dropping the untouched borrowed suffix. All dynamic, direct and captured
predicate paths use this scope. Scalar element words stay uncounted. Normal
returns and early predicate rejection retain their original evaluation order.

Focused generated-code tests cover all six predicate paths at O1/O2 with
collection stress/verification and both poison modes, retained input aliases,
partial spine construction and cancellation after the first selected element.
A scalar fixture preserves address-shaped I64 values across prefix and partial
list cleanup. Existing alias/counter tests pass. Full architecture and benchmark
gates remain for this branch's future sequential PR. Zip-with scratch buffers,
fold/loop accumulators and retained task ownership remain unfinished.


## Prepared zip-with cleanup

Zip-with protects the first scratch/result-prefix scope before allocating its
second buffer. The second buffer borrows source elements and has its own cleanup
scope during callbacks. Release it before building output nodes, leaving the
first scope to transfer its completed owned results into a typed partial spine.
This protects dynamic, direct and captured callbacks on errors, recovered traps
and cancellation, including failure to allocate the second buffer. Scalar result
words stay uncounted. Input aliases and callback evaluation order are preserved.

Normal alias/counter tests and focused generated-code probes pass at O1/O2 with
collection stress/verification and both poison modes. The probes inspect both
scratch buffers, completed results, partial construction, cancellation, second
allocation failure and scalar address bits. Full sequential CI remains required.
General zip/unzip allocation failures, fold/loop accumulators and retained task
lifetimes remain outside this change's acceptance evidence.


## Prepared fold cleanup

Right fold protects its consumed accumulator before allocating scratch and
protects that borrowed scratch buffer across callback entries. The accumulator
moves out of the scope before the callback takes it; a successful result becomes
the next accumulator owner. Captured folds protect their accumulator while
preparing borrowed captures and elements. Direct callback wrappers similarly
protect the consumed accumulator before duplicating a borrowed element.

Runtime borrowed-span application protects its retained function and consumed
arguments before duplication, including an owned suffix awaiting a returned
function. Each successfully duplicated borrowed argument has its own typed
preparation scope until the entry consumes it. A later duplication failure drops
these extra references, preserving the original aliases. A borrowed-span overapplication probe checks the pending
owned suffix and surviving original function alias on prefix failure and successful
return. Scalar words stay
uncounted; programs without possible unwind retain grouped duplicate operations
and compile out runtime scope registration.

Focused generated-code probes cover direct, dynamic and captured right-fold
errors, initial scratch allocation traps, cancellation after a completed result,
consumed argument preparation and partial borrowed duplication, retained aliases
and scalar address bits at O1/O2 with stress/verification and both poison modes.
Normal fold/right-fold alias and reclamation checks pass. Full sequential gates
remain required. Loop state at cancellation ticks, multi-capture duplication
failures in specialized helpers and owned application, constructor/boxing/CAF
allocation lifetimes and retained tasks remain acceptance work.

## Prepared loop cancellation cleanup

Dynamic, known and captured owned loops retain a typed scope for the current
state before each outer safe point. The state leaves that scope before callback
entry; successful Again payloads become the next state. Captured loops retain
the state during capture preparation. Stop payloads return after unlinking the
inactive state scope, so a result of another type is never dropped as state.

Specialized native loops register only their counted typed state slots, saving
them before the outer tick and clearing them before fs takes ownership. The
next iteration refreshes the scope from next-state slots; old consumed slots
are never released twice. Scalar slots need no owner. Initial record flattening protects the owned input
and completed typed field duplicates separately until all slots are ready, then
transfers the duplicates and drops the input. Before shape analysis and emission,
an immediately consumed terminal rebuilt record is recovered from RC argument
naming; its preparation spine keeps the same evaluation/release order. A generated
four-slot state test checks first/later retention faults with independent input/
leaf aliases and shared sibling leaves. Removing the partial scope detects a
leaked field. GC stress/verification, both poison modes and O1/O2 pass; normal
output agrees with the interpreter. Further nested-slot flattening and boxed
field reconstruction remain an audit item; no speed claim follows from slots.

Step extraction protects the consumed Step while preparing its typed payload
duplicate, then releases it normally. A failed duplicate releases only the
consumed Step reference and preserves external Step/payload aliases.

Two focused generated-code checks pass at O1/O2 with GC stress/verification and
both reuse modes: first/second-tick cancellation on five native loop paths,
nested boxed-state destruction, Again/Stop payload-preparation traps, surviving
aliases and scalar address bits. Normal output matches the interpreter. Existing
loop and adjacent call/fold tests pass. Full sequential CI remains required;
flattened nested-slot cancellation, multi-capture preparation, owned application
allocation, boxing/constructors/CAF/inline owners and retained tasks remain open.

## Prepared argument and capture preparation

When unwind is possible, a generated helper that duplicates multiple counted
arguments keeps each successful duplicate in a typed prefix scope until the
requested span transfers. A later duplicate failure releases those extras,
preserving original aliases. Offset spans retain the original parameter types;
scalar fields are never interpreted as counted pointers. Capture duplication
uses this helper too. Single-counted helpers need no partial-prefix owner,
and programs without possible unwind retain grouped operations.

Owned application transfers pending arguments only after capture preparation
and immediately before entry. Captured stack functions still register pending
argument ownership although the function has no heap count. Partial application
registers its fresh outer cell while copied fields remain borrowed; failure
releases that cell without dropping borrowed children. A successful result owns
the prepared captures and consumed supplied arguments.

A focused generated-code probe passes at O1/O2 with stress/verification and both
poison modes: failed second/later duplicates, offset spans, heap/stack functions,
pending records with address-shaped scalar fields, partial allocation failure,
partial-cell reclamation and exact aliases. Removing only the helper scope makes
the same probe detect a leaked earlier duplicate. Normal output matches the
interpreter, and adjacent runtime/fold/loop checks pass. Full sequential CI remains
required. Constructor/boxing/CAF/inline-rewrite allocation lifetimes, initial
loop flattening, closure-cleanup spill failures and retained task lifetimes remain
acceptance work; this is not complete ARC or a collector-free guarantee.

## Prepared constructor allocation cleanup

The ownership checker records caller liveness for non-nullary record/variant
construction. Before allocating, the compiler protects remaining caller owners
and consumed typed fields separately. Successful allocation unlinks both scopes:
the fresh result now owns its fields, while other caller references remain live.
Constructor functions similarly protect their consumed parameters before data
allocation. Scalar fields, constant graphs and static functions have no pending
field entry. Existing unique-young reuse writes directly into the token cell;
only its allocating fallback registers these scopes.

Focused generated-code probes pass at O1/O2 with GC stress/verification and both
reuse modes: constructor functions, recursive variants, wide records, fresh
field results, retained input aliases, another caller reference to a consumed
field, and address-shaped integer bits. Restoring the missing constructor-function
scope makes the same probe detect its leaked fields. Normal output matches the
interpreter; ownership checker, call-liveness and reuse-token tests pass. Full
sequential CI remains required. Worker argument preparation, record/variant
result boxing, initial loop flattening, concrete types for unknown constructor
argument temporaries, CAF/inline ownership, cleanup-spill failure and retained
runtime lifetimes remain separate acceptance work.

## Prepared worker result boxing

A record wrapper protects owned returned fields until allocation succeeds.
Variant boxing selects the active constructor's typed fields; scalar-only and
nullary cases register no payload owner. Direct worker callers protect their
remaining locals again while boxing the newly returned record/variant, separately
from its owned fields. Successful boxing transfers the fields without extra
counts. Programs without possible unwind compile out these scopes.

Variant release declarations precede cleanup contexts and boxing definitions:
variant owners can call their releases, and boxing helpers can use typed contexts.
A focused generated-code probe passes at O1/O2 with stress/verification and both
reuse modes for record/variant wrappers, another caller reference across recursive
worker result boxing, retained aliases, address-shaped scalar bits and ignored
nullary payload slots. Restoring the missing record result scope makes the same
probe detect unreleased fields. Normal output matches the interpreter; six
adjacent call/constructor checks pass. Full sequential CI remains required.

Wrapper input scopes still need to start before field duplication, with each
completed duplicate protected until worker entry. Initial loop flattening,
vlocal variant duplication/boxing, unknown constructor temporary types,
CAF/inline lifetimes, cleanup-spill failures and retained tasks remain acceptance
work. These focused paths do not prove complete ARC or tracing-free execution.

## Prepared worker argument preparation

A boxed-to-worker wrapper protects all consumed incoming parameters before
preparing field duplicates. Typed slots start empty and take ownership after
each successful counted-field duplicate. A later failure releases just those
extras and the wrapper's original references. Scalar fields need no slot.

Immediately before worker entry, prepared fields and non-boxed parameters leave
the wrapper scopes. The worker owns them and protects its entry safe point.
Boxed originals remain with the wrapper until normal return or unwind; record
aliases retain their original children. Wrappers with no boxed inputs gain no
preparation scope, and programs without unwind retain grouped operations.

A focused generated-code probe passes at O1/O2 with stress/verification and both
reuse modes: first/later duplication failure, worker-entry cancellation, normal
return, independently retained box and leaf aliases, and scalar address bits.
Removing only the partial-preparation scope makes the same probe detect an
unreleased earlier duplicate. Normal output matches the interpreter; adjacent
call-liveness and boxing checks pass. Full sequential CI remains required.
Initial loop flattening, vlocal variant preparation/boxing, concrete constructor
temporary types, CAF/inline owners, cleanup-spill failures and retained task
lifetimes remain acceptance work.

## Prepared retain overflow cleanup

A Dup checkpoint records exactly the caller's existing references before the
extra reference is acquired. Generated count operations register these live
owners until the operation completes. Multi-field variant, flattened record and
stack-child retention uses typed, initially zero slots for completed extras;
an interrupted retain releases those extras independently of the original value.
Scalar fields never enter that scope. Single-field retention needs only the
caller's original-owner scope. Programs without unwind omit scope registration.

The generated-C regression uses actual wide-count overflow at the first/later
variant field and at a compiled worker input Dup, at O1/O2 under GC stress/
verification with both poison modes. Original borrowed fields and scalar pointer
bits survive. Independent controls remove the variant partial scope or the
worker Dup scope and detect the respective unreleased references. Normal native
output matches the interpreter. Eight adjacent integration checks and thirteen
RC units pass. Full architecture/benchmark gates remain required; boxed-to-
unboxed/vlocal conversion and nested-field reconstruction require further audit.
Metadata allocation exhaustion currently exits rather than recovering. Cleanup
registration is a correctness cost, not a demonstrated speed improvement.

## Prepared concrete aggregate context

Ownership conversion carries the known monomorphic result, binding, branch,
aggregate field, dynamic parameter and update-field context into constructor
preparation. Existing inferred types take precedence. A nested constructor's
ownership temporary therefore holds its concrete type, and cleanup releases its
children rather than only decrementing the outer cell. Computed consumed scalar
arguments are also named before final entry, keeping earlier counted fields
owned during later preparation failures. Scalars remain uncounted locals.

Fifteen RC units verify typed nested temporaries and the lifetime window during
later scalar preparation. A generated-C check uses an actual later-field error
for a record and a variant, independently restoring outer-only cleanup to detect
the leaked String child. It passes O1/O2 with GC stress/verification and both
poison modes, preserves input aliases and scalar bits, and matches successful
and handled-error interpreter output. Adjacent constructor, boxing, temporary,
retain, loop and caller checks pass. Full architecture/benchmark CI is required;
this is no speed claim. Untyped field bases and match scrutinees, conversions,
reconstruction and retained runtime lifetimes remain acceptance work.

## Prepared boxed variant conversion

Boxed-to-struct conversion protects the consumed boxed input and all remaining
caller owners separately while typed fields acquire their new references.
Compiler consumed-value checkpoints exclude the transferred input from the
remaining-owner scope. A stack original protects its counted children directly.
Successful conversion unlinks the original scope before normal typed destruction;
the partial-retain helper protects only completed extras if a later retain fails.

A real source fixture prints the whole variant before matching it and asserts
that generated C performs a boxed conversion. Its actual first/later count
overflow traps preserve boxed/remaining-value aliases, restore field counts,
release unique input storage and leave scalar bits untouched. Independent
controls remove the original or remaining-owner scope and detect the respective
unreleased owner at O1/O2. GC stress/verification, both poison modes and normal
interpreter/native stdout agree. Sixteen ownership units and nine focused
integration checks pass. Full sequential platform/benchmark gates remain required;
vlocal boxing, field reconstruction, updates, untyped contexts and retained
runtime lifetimes remain audits. No complete ARC or speed claim is made.
