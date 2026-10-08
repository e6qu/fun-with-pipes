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
| Tasks, channels, networking, callbacks | Prepared Task owners/cache results and typed Channel queue owners; unknown boundaries still share | Cycles, library/unload and full sequential CI |
| AD tapes/kernel buffers | Numeric arrays outside the collected value heap | Cleanup on failure/cancellation, capacity reuse and scoped lifetimes |

Native executables still need a generational conservative collector for shared
values. WebAssembly uses a bump allocator; native libraries do not trace the
host's unknown roots. `FWP_GC=off` disables tracing, not all allocation and not
the ownership gap. `--memory static` provisions bounded memory, not static
lifetimes. None of these is a general collector-free execution guarantee.

## Prepared C export result ownership

Native library wrappers evaluate each exported call once, protect its owned
result through C conversion, and release copied record/nullable-pointer boxes.
CAF calls give up the caller reference while retaining the cache owner. Raw
pointer payloads and scalar words never acquire counts from their bit patterns.

C string results, including string fields of `repr(C)` records, escape into
host storage. After successful conversion only those strings become shared;
the enclosing counted record can still be released. This preserves the existing
library lifetime of host pointers without introducing a new release interface.
A rejected NUL-containing string releases its result through the conversion
unwind scope; it does not promote unfinished results to host retention.

Focused O1/O2 probes check exact counts, immediate release, stable cache counts,
pointer-shaped scalars, retained host strings and recovered conversion traps.
Library collection stays unarmed even with stress requested because host roots
are unknown. These checks therefore demonstrate count reclamation, not host-root
tracing. Returned strings, converted input ownership, heap unmapping on unload,
resource finalization and cycles remain distinct acceptance work. Full sequential
Linux/macOS CI is required before this prepared change becomes merged support.

## Prepared C export input ownership

Library wrappers prepare C parameters in signature order. Copied String inputs,
nullable-pointer option boxes and `repr(C)` record boxes start counted. Raw
pointers and scalar fields do not. A record prepares its fields in C declaration
order, retaining only completed fields in a typed cleanup scope; canonical field
indices still determine the language record layout.

The wrapper owns every completed argument until entry. Arguments consumed by
an expression function, constructor or consuming primitive transfer once into
the callee. Borrowed arguments remain protected through the call and are released
on return. These modes use the same `rc::consumes_arg` contract as internal calls.
Aliased owned results survive that release, and the result wrapper preserves C
strings that escape to the host. Ordinary foreign calls keep their shared fallback.

Failed later string validation releases the preceding arguments and record field
prefix. An injected record-allocation trap checks the whole prepared field scope;
actual allocator exhaustion still exits fatally and is not a recoverable claim.
Source functions keep their existing semantics and worker ABI; field workers can
duplicate and release fields while also releasing the input box.

The pointer-only C ABI cannot construct a Bytes header or establish its length.
Library exports with Bytes parameters now report that missing length explicitly;
ordinary foreign functions can still receive the byte payload pointer. A new
length-bearing export ABI is outside this focused ownership change.

Focused unoptimized interpreter/C checks and O1/O2 probes cover consumed/borrowed
calls, field order, aliases, pointer-shaped scalars, partial conversions and
callee traps with immediate count reclamation. Negative controls verify argument
release, transfer clearing and argument/field completion guards. Tracing remains
unarmed in native libraries. Unload, runtime resources/cycles and remaining shared
boundaries stay separate acceptance tasks; full sequential CI is still required.

## Prepared native library teardown

Native library unload cancels and drains attached and detached scheduler tasks
before releasing generated-code storage. It releases active/idle stack mappings,
runtime metrics and the owned polling descriptor, restores saved host signal
actions if they still point at this runtime, and releases typed CAF owners.
Registered finalizers run while their objects remain mapped. Collector side
allocations and the complete raw heap/metadata reservations are then released.
The host keeps ownership of its file descriptors and manually allocated pointers.

A library-only pthread key holds the temporary per-thread closure-release work
list; deleting it at unload avoids the native TLS descriptor that prevented
Darwin's loader destructor from running. Native executables retain their TLS
implementation. Numerical kernel threads are joined within each kernel call.
Hosts must complete all calls before unloading; this adds no concurrent-call ABI.

Actual repeated loader cycles and static-archive process exit pass focused O1/O2
checks with reuse poisoning. Negative controls detect missing unmap, CAF/side
cleanup, signal restoration and pthread-key deletion. Native library collection
stays unarmed. Ordinary archives are covered; static-memory provisioning, general
File/socket/TLS/GPU resources, source-reachable cycles and complete tracing-free
execution still need evidence. Full sequential Linux/macOS CI is required.

## Prepared native OpenCL owners

The runtime keeps one owner of its OpenCL loader handle, context and command
queue. Missing entry points, unavailable platforms/devices and context/queue
creation failure release completed owners immediately. The cached diagnostic
and availability result remain stable. Successful completion drains the queue,
releases it and its context, then closes the loader owner. Normal native program
completion and native library exit/unload run this path.

Native library initialization registers its guarded finish for process exit as
well as keeping its unload destructor. This releases dynamically loaded resources
before Darwin terminates the dependency image, including static archives; repeated
finish calls are harmless. Actual loader probes cover API release counts/order,
partial failure, shared unload, archive exit and executable completion at O1/O2.
Negative controls detect omitted release/drain/finish and Darwin exit registration.
A fake OpenCL implementation proves the resource protocol; it proves no hardware
GPU speed or numerical correctness. Full sequential CI is still required.

Interpreter OpenCL retains a process-lifetime cache; its partial-failure resource
cleanup remains separate acceptance work. File/socket/TLS ownership, remaining
aggregate paths and cycles still require evidence before tracing can be optional.

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

## Prepared typed record updates

`ownership-record-update`, `/private/tmp/fwp-record-update-worktree`, OLD base
`34873f4`. Record copies now retain only typed kept fields: scalar words and
replaced fields acquire no reference. Unique updates release overwritten typed
fields before assignment. Poison-copy verification uses ordinary typed
original destruction, including its children. Both generated copy paths use
one helper; the checker records update liveness with a borrowed base and
consumed replacements. The helper protects remaining owners and replacements,
then its raw copied outer cell and partial completed field retains separately.
Allocation still precedes retained-field acquisition; field evaluation order
is unchanged. No speed or complete ARC claim is made.

Seventeen ownership units pass (CPU 3.24 s / elapsed 6.71 s). Eight focused
integration checks (record update, boxed conversion, constructor context and
five compiler caller checks) pass, CPU 28.28 s / elapsed 56.77 s. Dedicated
update probes cover unique/shared normal results and actual first/later wide
count overflow, aliases, exact counts and scalar address bits at O1/O2,
GC stress/verification and both poison modes. The C probe supplies a counted
replacement through the fixture's captured constant slot; ordinary source
behavior also agrees with the interpreter. Independent controls removing the
unique overwritten-field drop, raw-cell scope, partial-retain scope or
replacement scope fail with codes 3, 8, 11 and 7 respectively. A mistyped
`call_unwind_ownership` target was rejected without running checks; the
corrected compiler-call target passed in the batch above.

Full sequential CI remains required. Remaining work includes direct exceptional
coverage of the general copy path, reconstruction from flattened records,
vlocal boxing, untyped field/scrutinee contexts, CAF/inline ownership and
retained task lifetimes/cycles. Do not mistake this focused evidence for all
update/reconstruction ownership coverage.


## General record copy coverage

Extended `ownership-record-update` after `b21203d` in the same focused change.
The source fixture `both (with { old = "new" }) id` performs its copy before
consuming the original. Generated C is asserted to have no unique-update
branch, proving coverage of the general `ExprSetFields` path. Normal result
contains the updated record and untouched original; their exact child counts,
independent external aliases and scalar address bits are checked. Actual
first/later wide-count overflows release partial retained fields, replacement,
copied outer storage and original owners. Removing the remaining-owner scope
fails with code 9; raw-cell/partial/replacement controls fail with 8/11/7.
O1/O2, stress/verification, both poison modes and ordinary interpreter/native
stdout agree. Both update tests pass, CPU 8.32 s / elapsed 16.78 s.

The added remaining-owner control initially assumed the context declaration
and registration occupied one C line; its lookup failed before compilation.
The lookup now follows the context variable to its registration. Clippy's
iterator-style warning was repaired with `rfind`; warning-free library and
new-test lint passes (CPU 0.00 s / elapsed 0.14 s). No product failure remains.
Validation used the bounded fwp guard with `cargo test --test
record_update_ownership --test general_record_update_ownership -- --nocapture`
and `cargo clippy --lib --test general_record_update_ownership -- -D warnings`.
Full sequential CI remains required; no new PR is open.

Reconstruction audit identified the active boxed-record-to-worker field
conversion in `FnGen::expr_fields`: it retains counted fields and drops its
input without protecting originals, remaining owners or completed extras.
This is the next implementation task; prove a real source fixture and add
first/later overflow checks before claiming it fixed. Nested loop reconstruction
in `FnGen::expr` is separate: existing RC argument naming keeps the nested
state boxed, so current fixtures do not prove that flattening path. Enabling it
also needs precise ownership for reconstructed borrowed field bindings.
Keep that work open rather than treating an unexercised path as verified.

## Prepared boxed record field conversion

`ownership-record-conversion`, `/private/tmp/fwp-record-conversion-worktree`,
OLD base `5c5875d`. `FnGen::expr_fields` now protects the consumed boxed input
(or typed stack children) and remaining caller values while acquiring counted
field references. The common typed partial-retain helper releases only completed
extras if a later retain fails. Scalars have no owner slot. On success the
original scope unlinks before typed destruction and field owners transfer to
the worker. Pure/no-reuse builds omit registration; no new heap allocation or
surface syntax is introduced. Unknown type contexts remain an acceptance gap.

A real source fixture prints the whole input record, then passes it to a
recursive worker reading fields. Generated C asserts exactly one boxed scalar
field read and one two-owner partial-retain scope. Its first/later actual wide
count overflows preserve independent boxed-input and remaining-String aliases,
restore exact child counts, free unique original storage and leave scalar
address bits untouched. O1/O2, GC stress/verification, both poison modes and
ordinary interpreter/native stdout agree. Removing the original scope fails
with code 3, remaining-owner scope with 7, and partial-retain scope with 4.
Dedicated check passes, CPU 4.22 s / elapsed 8.61 s, using the bounded fwp guard
with `cargo test --test record_conversion_ownership -- --nocapture`.

Nine focused caller, stack-child and record/variant conversion checks pass,
CPU 28.95 s / elapsed 58.13 s. Library and dedicated-test clippy pass,
CPU 2.34 s / elapsed 4.63 s; fmt/whitespace pass. Full sequential platform/benchmark CI remains
required. Next audit vlocal alias boxing and untyped aggregate contexts;
nested flattened loop reconstruction still requires an actual eligible source
fixture and precise ownership of reconstructed borrowed bindings. CAF/inline,
retained task lifetimes, teardown/cycles and later phases remain incomplete.

## Prepared returned variant aliases

`ownership-variant-alias`, `/private/tmp/fwp-variant-alias-worktree`, OLD base
`614dd3b`. `expr_variant` transfers a named returned alias by reusing its
existing unboxed representation. Previously a nested alias expression fell
through whole-value binding, duplicated its fields, boxed it, and unboxed it
again while the source's logical owner had already been consumed. The valid
monomorphic IR regression reproduced unreleased String children (exit 3).
The fix keeps field ownership intact without an extra retain or heap box.
Evaluation order, explicit RC Dups and pipe syntax remain unchanged.

The regression checks local types, compares its value with the interpreter,
and verifies unique/shared input child counts at O1/O2 with stress/verification
and both poison modes. Generated holder code has no vbox/vunbox. Restoring an
extra typed retain makes the control fail with exit 3 at both optimization levels.
A separate source fixture returns a recursive variant worker's value through
a yield and matching alias; it remains unboxed and matches interpreter stdout
at O1/O2 in both poison modes. This source fixture was already healthy before
the change: it is adjacent coverage, not proof of the nested IR leak's source
reachability. The nested valid IR case is the direct regression evidence.

Eight adjacent checks pass (IR alias, two record/variant conversion checks and
five compiler caller checks), CPU 18.67 s / elapsed 37.54 s. Both final alias
checks pass, CPU 2.33 s / elapsed 4.86 s. The fixture first used an incorrect
concat order and omitted the holder from main's reachable graph; those test
setup errors were repaired before reproducing the native ownership leak.
Checks use the bounded fwp guard with `cargo test --test variant_alias_ownership
--test variant_conversion_ownership --test record_conversion_ownership --test
compiler_call_liveness -- --nocapture`, then the dedicated alias test. Package
clean preceded this checkout's compiler build. Full sequential platform and
benchmark gates remain required; no additional PR opens while #80 is pending.

Next address untyped field/scrutinee contexts, reconstructed borrowed records,
remaining whole-value vlocal boxing, CAF/inline lifetimes and retained task
callbacks/teardown/cycles. No complete ARC, tracing-free execution or general
speed claim is made; phases 2–6 remain incomplete.

## Prepared nominal match context

`ownership-match-context`, `/private/tmp/fwp-typed-expression-worktree`, OLD
base `de85621`. The optimizer previously removed a typed binding before matching
a bare aggregate. Discarded effectful nested constructors then had unknown
ownership locals, so their children could remain live. The regression reproduced
`?` locals after optimization and RC insertion. Known-constructor elimination
now inherits the checked binding's nominal field types when it must evaluate
a discarded field. It keeps a typed binding when elimination cannot recover
the scrutinee's type. Existing trivial-record match elimination remains enabled.
No new IR annotation node, surface syntax or runtime allocation is introduced.

Two dedicated checks cover typed IR and real source. They compare interpreter
and native values, prove the outer matched value has no heap allocation, and
check that a freshly repeated String child is destroyed while external input
aliases survive. Erasing the retained nominal field type makes the control fail
with exit 3. O1/O2, GC stress/verification and both poison modes pass. Five focused
match/alias/constructor checks pass, CPU 8.06 s / elapsed 16.35 s. Selected
case_of_case, unboxed_records and variant_returns goldens agree exactly with
the interpreter, including stdout/stderr/exit and both poison modes at O2,
CPU 3.11 s / elapsed 6.42 s. This is selected semantic evidence, not a full gate
or speed claim. Full sequential architecture/benchmark CI remains required.

Library and dedicated-test clippy pass without warnings, CPU 2.34 s / elapsed
4.64 s; fmt/whitespace pass. Checks used the serial bounded fwp guard with
`cargo test --test match_context_ownership --test variant_alias_ownership --test
constructor_type_ownership -- --nocapture`, `cargo clippy --lib --test
match_context_ownership -- -D warnings`, and
`python3 /private/tmp/fwp-match-context-goldens.py`. Package clean and rebuild
preceded checks after switching from the stack checkout. No local workload
remains; shared target contains the match-context compiler.

PR #80 is merged and sole PR #81 is now in full CI `37696063781` for exact
`6eeb915`. This context change remains separate. Prepared squash subject
`Preserve nominal match context for discarded constructor fields` is one line,
63 characters, empty body/no trailers. Next audit remaining field-result
contexts, reconstructed borrowed fields, whole-value boxing, CAF/inline owners
and retained task lifetimes/teardown/cycles. Phases 2–6 remain incomplete.

## Prepared typed record projection

`ownership-field-context`, `/private/tmp/fwp-field-context-worktree`, OLD base
`3f61f51521d95527d6754c2e6c3ca01a31f64bd7`. Inlining a checked record-producing
call under a projection erased its nominal base type. The valid IR regression
reproduced three unknown RC locals, an inappropriate generic scalar retain and
a live discarded nested String child (native exit 3). The optimizer now keeps
the pre-inlining base type in a typed binding when the optimized expression no
longer exposes a type. Existing scalar replacement gives each field its checked
type without allocating the projected outer record. Field evaluation order is
preserved. No inferred nominal labels, IR annotation or surface syntax is added.

Two dedicated tests cover the failing IR shape and representative source
behavior. Interpreter/native results agree; fresh discarded String children are
dead, unique inputs release, and external input aliases survive with count 1.
Erasing only the nested field type makes the negative control leak at O1/O2.
Both optimization levels, GC stress/verification and both poison modes pass.
The source fixture supplies differential coverage; source reachability of the
specific failing IR shape is not claimed. Seven focused projection/match/alias/
constructor checks pass, CPU 9.77 s / elapsed 19.74 s. Five selected goldens
(case_of_case, unboxed_records, variant_returns, wide_records, loop_nested_state)
agree exactly on stdout/stderr/exit at O2 in both poison modes, including the
intentional trap, CPU 5.20 s / elapsed 10.65 s. Full sequential CI remains required.

Library and dedicated-test clippy pass, CPU 2.34 s / elapsed 4.64 s. Formatting
passes under the bounded guard (CPU 0.34 s / elapsed 0.60 s). Checks used
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py cargo test --test field_context_ownership --test
match_context_ownership --test constructor_type_ownership --test
variant_alias_ownership -- --nocapture`, the corresponding `cargo clippy --lib
--test field_context_ownership -- -D warnings`, and
`python3 /private/tmp/fwp-field-context-goldens.py`. Guarded package clean preceded
the worktree switch/build. No workload remains; shared target contains this
projection compiler. Bare projections with no checked base metadata,
reconstructed borrowed records, remaining whole-value boxing, CAF/inline
lifetimes and retained task lifetimes/teardown/cycles remain open. Phases 2–6
remain incomplete; no general ARC, tracing-free or speed claim is made.

PR #81 is the sole open PR, exact `6eeb915`, full CI `37696063781`; benchmark
passed and all three architecture test jobs are running. Prepare this branch
separately. Future squash subject `Preserve checked record types across inlined field projections`
is one line, 62 characters, empty body/no trailers. Publication follows checks.

## Prepared counted CAF caches

`ownership-caf-cache`, `/private/tmp/fwp-caf-ownership-worktree`, OLD base
`085dc716d5994681b998f13cd619b139794539fc`. CAFs previously recursively shared
cached results, discarding their counts. A native count probe failed with exit 1.
Counted CAFs now hold one typed cache owner and return a retained owner per call.
Scalar CAFs avoid generic share/retain operations even for pointer-looking words.
Initialization remains lazy and memoized; failure leaves it retryable. If
initialization reenters, replacing the earlier cached result releases that cache
owner while preserving already returned references. This is valid IR/runtime
coverage, not a claim of a newly reachable source reentrancy shape.

RC now names CAF results in borrowed/consumed argument preparation, preserving
evaluation order and giving borrowed calls a temporary to release. CAF evaluation
also records caller liveness and generates a cleanup scope when unwind is enabled.
A source test initially exposed the missing temporary, and its corrected case
reclaims the cache. A separate trapping source fixture, with task support enabled,
releases unique caller inputs and preserves external aliases; removing only the
CAF caller scope makes the control fail with exit 4. Initialization-failure retry,
actual SIZE_MAX retain overflow and cleanup boundaries pass. Cache aliases and a
record containing two aliases of the same String have exact reference counts.

Executables release the counted main result after tasks finish, then clear and
release counted CAF caches by type. Both cleanup stages have failing controls:
omitting root release leaves the child alive (exit 3); omitting cache teardown
fails with exits 3/9. Missing returned retain fails with exit 11; removing replaced
cache release fails with exit 12. Teardown is idempotent. All three CAF tests pass
at O1/O2, with GC stress/verification and both poison modes; source stdout/stderr/
exit agrees with the interpreter, including initialization and trapping behavior.
Native library caches retain their loaded-program lifetime; host/unload teardown
and shared runtime graphs remain acceptance gaps. No public interface is added.

Seventeen RC unit checks pass, guarded CPU 3.28 s / elapsed 6.99 s. Ten focused
CAF/caller/projection checks pass, CPU 23.50 s / elapsed 47.09 s. Final CAF controls
pass (3 tests), CPU 4.10 s / elapsed 9.53 s. The shared-library C interop smoke
check passes, CPU 0.80 s / elapsed 2.32 s. Four selected opt_constant_order,
effects, unboxed_records and variant_returns goldens agree exactly on stdout/
stderr/exit at O2 in both poison modes, CPU 4.03 s / elapsed 8.18 s. Full sequential
Linux/ARM macOS/Intel macOS/benchmark CI remains required before merging.

All local checks used the serial bounded fwp guard with the shared target.
Commands: `cargo test --lib rc::tests -- --nocapture`, `cargo test --test
caf_ownership --test compiler_call_liveness --test field_context_ownership --
--nocapture`, `cargo test --test caf_ownership -- --nocapture`, `cargo test --test
ffi shared_library_from_c -- --nocapture`, and
`python3 /private/tmp/fwp-caf-goldens.py`. An initial invocation named nonexistent
`call_liveness`; corrected to `compiler_call_liveness` before the successful run.
The 2,000-task tasks_local interpreter workload was explicitly stopped and moved
to full CI; it is not locally verified. At inspection it used 72 MiB RSS and
38.32 s CPU after 75 s elapsed; no resource limit was raised or bypassed. The
four smaller goldens above were then run serially. Package clean preceded the
checkout switch. No local workload remains; shared target contains this CAF
compiler. Remaining work includes reconstructed nested state, untyped contexts,
whole-value variant boxing, inline lifetimes, retained task teardown/cycles and
library lifetime coverage. Phase 2 and later roadmap phases remain incomplete.

PR #81 remains the sole open PR, exact `6eeb915`, full CI `37696063781`;
benchmarks passed, all three architecture test jobs running. Failing tests remain
repair tasks; CI gates merging only. This prepared change stays separate.
Prepared squash subject `Own cached CAF results and release executable cache owners`
is one line, 58 characters, empty body/no trailers. Publication follows checks.

Dedicated-test/library clippy passes after correcting the fixture initializer.
Final CAF tests pass after that edit (CPU 4.18 s / elapsed 10.91 s). Formatting
and whitespace pass; no remaining focused failure. Full sequential CI is pending.

## Prepared CAF evaluation during inlining

`ownership-inline-caf`, `/private/tmp/fwp-inline-caf-worktree`, OLD base
`68cf7bf2f7ca0986edf7039ff2e0bfe584e45820`. The optimizer classified every Func
as trivial, including zero-argument CAFs whose evaluation can allocate or trap.
Inlining a callee that ignored such an argument skipped the CAF. A real source
regression printed 17 and exited 0 instead of raising division by zero with exit
101. The ordinary optimized interpreter also skipped the trap; its pipeline uses
the same optimizer, so the reference must disable that pass. This was reproduced
before the fix, not inferred only from IR shape.

Only positive-arity static function references remain trivial. CAF arguments now
keep a checked evaluation binding before entering the inlined callee. Existing RC
then releases an ignored counted result; no heap object or surface syntax is added
by the binding. Three source cases cover ignored scalar and String CAF arguments
and the order between an earlier CAF trap and the callee's later integer overflow.
Unoptimized interpreter (`FWP_NO_OPT=1`), optimized interpreter and native O1/O2
agree exactly on stdout/stderr/exit in both poison modes with GC stress/verification.
A mistaken initial negative-repeat fixture was corrected: string.repeat clamps
negative counts to zero, so it was not a trapping reference.

A successful String CAF regression proves one evaluation, count 1 before cache
teardown (only the cache owns it), and destruction after executable cleanup.
Removing only the ignored argument's typed release leaves an extra owner and
makes the control fail with exit 4 at O1/O2. The two new tests and three adjacent
CAF ownership tests pass, guarded CPU 10.47 s / elapsed 21.53 s. Four selected
opt_constant_order, case_of_case, unboxed_records and variant_returns goldens
agree exactly on stdout/stderr/exit at O2 in both poison modes, CPU 4.13 s /
elapsed 8.42 s. Library/dedicated-test clippy passes, CPU 2.42 s / elapsed 4.84 s;
formatting passes, CPU 0.36 s / elapsed 0.75 s. Full sequential CI remains required.
CONTRIBUTING now requires an unoptimized IR/interpreter reference for optimizer
changes, because agreement between optimized engines can miss a common bug.

All local checks were serial and bounded through
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py`: `cargo test --test inline_caf_ownership --test
caf_ownership -- --nocapture`, `cargo clippy --lib --test inline_caf_ownership --
-D warnings`, and `python3 /private/tmp/fwp-inline-caf-goldens.py`. Guarded package
clean preceded switching from the CAF checkout. No resource refusal or local
workload remains; shared target contains this inlining compiler. Remaining work
includes aggregate reconstruction/metadata, whole-value variant boxing, other
inline lifetime cases, retained task teardown/cycles and library/unload coverage.
Phases 2–6 remain incomplete; no general ARC, tracing-free or speed claim is made.

PR #81 remains the sole open PR, exact `6eeb915`, CI `37696063781`: ARM macOS and
benchmarks passed; Linux and Intel macOS tests running. CI gates merging only;
repair failures and continue separate preparation. Prepared squash subject
`Preserve CAF argument evaluation and ownership during inlining` is one line,
62 characters, empty body/no trailers. Publish after checks; preserve OLD
`68cf7bf` for this child and OLD `b563360` for the immediate borrowed-callback
rebase after #81 merges. No second PR opens while that current gate is pending.

## Prepared retained task thunks

Branch `ownership-task-thunks`, checkout `/private/tmp/fwp-retained-thunk-worktree`,
OLD base `6734248e7c0d4d53d57e5acccb9af02641713e9d`. task.spawn borrows its
callback and the runtime retains one counted closure reference. Task entry
transfers it to owned application; cancellation before entry releases it.
Typed captures release on completion and cancellation while suspended. Unknown
owned-entry metadata preserves the conservative shared fallback. The callback
still escapes, so this contract grants no stack-allocation permission.

Spawn reserves scope storage and prepares its stack before publishing a child.
Recoverable stack mapping failure previously left a partial child linked to its
parent; the repaired path leaves parent/scope/GC task lists unchanged and
releases only the extra thunk owner. Scope capacity and count overflow likewise
preserve original aliases. Actual allocator OOM remains fatal; no recoverable
allocator-OOM claim is made. Task handles and counted results still share.
Result type metadata keeps address-shaped scalar words out of generic sharing.

Two dedicated tests compare real source behavior with an unoptimized interpreter
and probe generated C at O1/O2 with GC stress/verification and both poison modes.
They cover normal completion, pre-entry and suspended cancellation, external
capture aliases, scalar address bits, unknown metadata, stack failure, scope
capacity overflow and retain-count overflow. Negative controls restoring early
child publication and removing the extra-owner scope fail with exits 2 and 4.
The pre-fix compiler failed the counted-closure probe with exit 1.

Serial guarded checks (same bounded fwp guard as above):
- `cargo test --test retained_thunk_ownership --test task_ownership -- --nocapture`:
  five pass, CPU 12.65 s / elapsed 25.50 s.
- `cargo test --test closure_ownership --test unwind_cleanup -- --nocapture`:
  five pass, CPU 13.73 s / elapsed 27.72 s; closure counts free 1.2 MiB versus 0.
- `cargo test --lib ownership::tests -- --nocapture`: one inventory check passes,
  CPU 3.23 s / elapsed 6.70 s; spawned callbacks remain marked escaping.
- Final two dedicated tests, including unknown metadata: pass, CPU 9.35 s /
  elapsed 19.49 s.

Full sequential CI remains required. Remaining tasks include task.within/scope
callback ownership, task results/handles and channel teardown/cycles, aggregate
reconstruction/metadata, whole-value variant boxing and library/unload lifetimes.
Phases 2–6 remain incomplete. PR #81 is the sole open PR, exact `6eeb915`, CI
`37696063781`: Linux, ARM macOS and benchmarks passed; Intel macOS is running.
After all four pass, squash with the recorded subject and empty body, rebase
borrowed callbacks from OLD `b563360` onto the new squash, then open the next PR.
Continue separate implementation while CI runs; repair any failure. Preserve
OLD `6734248` for this branch and its published head for its future child.

Retained-thunk library/dedicated-test clippy passes, CPU 2.31 s / elapsed 4.61 s.
Six adjacent escape-analysis checks pass, CPU 0.00 s / elapsed 0.14 s. No focused
failure remains; no resource limits were raised or bypassed. The shared target
contains this compiler; guarded package clean is required before switching.
Final formatting/whitespace pass, CPU 0.36 s / elapsed 0.73 s.

## Prepared retained deadline callbacks

`ownership-task-within`, `/private/tmp/fwp-task-within-worktree`, OLD base
`7208e4a2d93e7e0402dee4d7f4783fe185565d74`. task.within now borrows the
callback and uses the same retained-owner preparation as task.spawn, with its
deadline preserved. Result metadata avoids sharing scalar address bits; counted
results remain shared and the Option outer remains owned. Unknown callback
metadata preserves the shared fallback. Escape analysis still treats it as
retained. task.scope, channels, result/handle teardown and cycles remain open.

A source/generated-C regression checks successful execution and immediate
deadline cancellation, original callback owners and external capture aliases.
The initial C fixture erroneously passed a scalar Duration and crashed; fixed to
construct the boxed current ABI value, it reproduced the pre-fix count failure
with exit 1. After the fix, O1/O2, both poison modes and GC stress/verification
pass; native stdout/stderr/exit match an unoptimized interpreter. Restoring the
legacy shared callback path makes the negative control fail with exit 1.
The parent spawn preparation controls were updated to target the factored helper
and still fail with their expected exits.

Serial bounded checks after guarded package clean:
- `cargo test --test within_thunk_ownership --test retained_thunk_ownership --
  --nocapture`: three pass, CPU 11.52 s / elapsed 23.51 s.
- `cargo test --test within_thunk_ownership --test task_ownership -- --nocapture`:
  four pass, including final negative control, CPU 5.47 s / elapsed 11.31 s.

Full sequential CI is required. #81 remains sole open PR, exact `6eeb915`, run
`37696063781`; Linux, ARM macOS and benchmarks passed, Intel macOS is live.
Fix any failure and continue separate preparation. After all four pass, use the
recorded subject/empty body and exact-head squash, then rebase borrowed callbacks
from OLD `b563360`. Next implementation: task.scope callback ownership and
scope result protection across joining/cancellation. Preserve OLD `7208e4a` for
this child and its published head for the next child. Phases 2–6 remain open.

Deadline library/dedicated-test clippy passes, CPU 2.35 s / elapsed 4.71 s.
Formatting/whitespace pass, CPU 0.37 s / elapsed 0.76 s. No focused failures or
local resource-limit refusals remain. Full sequential CI and inventory execution
after the added deadline assertion remain required; don't count clippy as a test.
Shared target switched to borrowed-callback validation after guarded package clean.

## Prepared scoped callback ownership

`ownership-task-scope`, `/private/tmp/fwp-task-scope-worktree`, OLD base
`14a76de5b8bbbf4e23a06b547ebaf374b931b20e`. task.scope now borrows its
synchronous callback and receives a typed owned result. Owned callback entry
metadata retains only typed captures/arguments; unknown metadata keeps the
shared fallback. Scope state and its task array have an unwind owner, including
restoration of the previous handler on an external recovered trap. A separate
typed result owner protects the value across child joins and final cancellation.
Normal return transfers it without an extra retain. Scalar address bits are
uncounted. The callback itself does not escape; captured returned values still
carry their own references. Pipe syntax, effects and evaluation order are unchanged.

The corrected pre-fix source/generated-C fixture failed capture-count checks
with exit 1. During test development, the probe incorrectly used rc_last as a
release; corrected to rc_release_last (which decrements nonlast counts). This
fixture error is not recorded as a compiler regression. The fixed probe covers
external capture aliases, returned aliases, scalar address bits and unknown
callback metadata. It cancels real worker tasks before callback entry and after
result production, with a child registered in the scope, and recovers an external
trap before callback entry. Scope task arrays are freed once, task scope pointers
are restored and captures are destroyed; the scope's stack handler cannot survive
a recovered trap. Probes use O1/O2, GC stress/verification and both poison modes.
Real source stdout/stderr/exit agree with an unoptimized interpreter.

Bounded serial checks after guarded package clean:
- Scope plus three adjacent unwind tests pass, CPU 5.19 s / elapsed 10.55 s.
- Seven scope/spawn/deadline/task ownership tests pass, CPU 18.32 s / elapsed
  36.93 s; existing deadline count evidence remains 0.5 MiB versus zero.
- Scope with the recovered-trap and handler restoration changes passes,
  CPU 9.77 s / elapsed 19.82 s.

Full sequential CI remains required. Task handles and spawned results still
share; task/channel result teardown, cycles, aggregate reconstruction/metadata
and library/unload coverage remain unfinished. Phases 2–6 remain open. Sole
PR #82 exact `3fa67f3`, run `37703018710`, currently has both macOS jobs live
and Linux/bench queued. Merge only after all four pass, with the recorded subject
and empty body. Rebase the map child from OLD `029fac4` onto that squash. Next
implementation: precise task-result/handle lifetime contracts before channel
queue ownership. Preserve OLD `14a76de` for this branch's future rebase.

The complete contract inventory passes, including the previously pending
deadline assertion and the new scoped callback contract: guarded
`cargo test --lib ownership::tests -- --nocapture`, CPU 4.02 s / elapsed 8.27 s.
The final recovered-handler omission control fails with exit 4; removing result
cleanup fails with 5 and scope-array cleanup with 6, each at O1/O2. Scope checks
pass after adding those controls, CPU 3.37 s / elapsed 6.96 s. The added real
source child-joining case passes too, CPU 3.66 s / elapsed 8.09 s. Formatting
passes, CPU 0.47 s / elapsed 0.86 s. Clippy found a needless borrow in the new
result-type lookup; corrected before rerunning lint. Full CI still required.
All local commands used the bounded fwp guard, serial and low priority; none
refused for resource limits. No limits were raised. The shared target is this
scoped callback compiler; clean the package before switching checkouts.

Final library/dedicated-test clippy passes, CPU 2.76 s / elapsed 5.48 s.
No focused failures remain. Exact guarded commands included `cargo test --test
scope_thunk_ownership --test retained_thunk_ownership --test within_thunk_ownership
--test task_ownership -- --nocapture`, `cargo test --test scope_thunk_ownership
--test unwind_cleanup -- --nocapture`, `cargo clippy --lib --test
scope_thunk_ownership -- -D warnings`, and `cargo fmt --all -- --check`.

## Prepared counted task handles and results

Branch `ownership-task-handles`, checkout `/private/tmp/fwp-task-handle-worktree`,
OLD base `7da15d9c8ea330bea4f876f797038627720c4c38`. Task is now a counted
builtin type with a runtime destructor. Known owned callbacks produce counted
task storage, one scheduler owner and one external handle owner; scope task
arrays retain another owner. Scheduler release happens only after the finished
stack is returned/unmapped and GC task links are removed. Last handle release
destroys the cached typed result and private state storage. Finished child links
are cleared so they cannot keep stale borrowed parent/sibling pointers.

Await borrows the task and returns an owned Option with its own typed result
reference, independent of other awaits and the cache. Partial Option ownership
is protected while result retention can overflow. task.within protects its
private handle during waiting and releases it on success and failure. task.cancel
borrows its handle. Scalar address bits receive neither result duplication nor
generic sharing. Task storage remains mutable kind 2 for minor-collection scans;
poisoning uses mutable storage cleanup, never a record-header interpretation of
its context registers. Only one result-drop callback pointer is stored per task.
Unknown callback metadata and unmodeled runtime sharing retain the tracing
fallback. Channels, cycles and library/unload acceptance remain unfinished.

The corrected baseline count probe failed with exit 1: there was no counted task
handle. An initial function-ID prefix accidentally matched a runtime comment;
corrected to the generated signature marker before recording that reproduction.
Source/generated-C checks cover handle aliases, independent repeated awaits,
last cached-result destruction, early external-handle drops, scope retention
after task completion, pre-entry and suspended cancellation, old-task/young-result
minor collection, overflowing await result retention and private deadline-handle
cleanup. Native stdout/stderr/exit are compared with an unoptimized interpreter.
GC stress/verification and O1/O2 in both poison modes pass for completed probes.

Negative controls remove result retain (exit 2), cached result destruction (6),
scheduler release (3), scope retain (11), partial Option protection (17) and
private deadline-handle protection (20), at both optimization levels. The await
overflow preserves the original wide cache count and task handle, releasing only
the fresh Option. The private-handle failure preserves the caller's callback
and capture owner while releasing the cached extra reference.

Serial bounded local checks after package clean:
- Initial independent-handle probe passes, CPU 8.08 s / elapsed 16.32 s.
- Three task-handle/scope/deadline tests pass, CPU 14.70 s / elapsed 30.34 s.
- Eight adjacent spawn/task/unwind tests pass, CPU 16.15 s / elapsed 32.57 s.
- Dedicated failure controls pass, CPU 10.67 s / elapsed 22.25 s.
- Added minor-collection result probe passes, CPU 4.38 s / elapsed 9.59 s.
- Ownership inventory passes, CPU 3.26 s / elapsed 6.67 s; 17 RC checks pass,
  CPU 0.00 s / elapsed 0.13 s.

Full sequential CI remains required. Sole PR #82 exact `3fa67f3`, run
`37703018710`: benchmark passed; Linux and both macOS test jobs are live.
Merge only after all four current-head gates pass with the recorded one-line
subject and empty body, then rebase map from OLD `029fac4`. Next implementation:
channel queue and handle ownership, including typed send/receive/cancellation
and closed/drained queues; finish task/runtime cycles and library evidence
before phase 2 acceptance. Preserve OLD `7da15d9` for this branch's rebase.

Final dedicated task-result checks, including explicit sharing fallback, pass
(CPU 4.15 s / elapsed 9.12 s). Library and three affected test targets pass
clippy after formatting (CPU 2.32 s / elapsed 4.80 s); fmt CPU 0.34 s / elapsed
0.61 s, whitespace clean. Commands used the bounded guard: `cargo test --test
task_handle_ownership -- --nocapture`, `cargo test --test task_handle_ownership
--test scope_thunk_ownership --test within_thunk_ownership -- --nocapture`,
`cargo test --test retained_thunk_ownership --test task_ownership --test
unwind_cleanup -- --nocapture`, `cargo test --lib ownership::tests -- --nocapture`,
`cargo test --lib rc::tests -- --nocapture`, and `cargo clippy --lib --test
task_handle_ownership --test retained_thunk_ownership --test
within_thunk_ownership -- -D warnings`. No resource limits were raised/bypassed,
no focused failure remains. Shared target contains this task-handle compiler.
Full sequential CI is still required; phase 2 and phases 3–6 remain incomplete.

## Prepared counted channels and queue elements

`ownership-channel-queues`, `/private/tmp/fwp-channel-queue-worktree`, OLD base
`bb6f9c49a0434afc9f7dd1fb9891a6fa8fb32a8a`. Channel is now a counted builtin
with typed queue duplicate/drop metadata and a runtime destructor. Send, receive,
timed receive and close borrow the handle. Enqueue retains one typed element
reference only after capacity is available; closed/blocked sends retain none.
Receive allocates its owned Option before removing the queue reference, then
transfers that reference without duplication. Last handle release destroys queued
elements and buffer storage. Parked compiled callers hold a handle owner, and
wait links clear before cancellation cleanup can destroy the last reference.
Scalar address bits receive no count/share/destruction operation. Unknown C
channels, promoted handles and sink callbacks retain the tracing fallback.

The pre-fix native probe failed with exit 1 (no counted channel handle). O1/O2
probes in both poison modes with GC stress/verification cover growth across the
initial capacity, caller/queue/receive aliases, closed sends, last handle queue
destruction, blocked send/receive cancellation and close, including early
external-handle drop while a worker waits. Queue function captures and task
cache descendants release correctly; an old channel/buffer roots young queued
elements through minor collection. Shared/C-channel and sink fallback behavior
is checked without counting scalar words. Native source stdout/stderr/exit
agree with an unoptimized interpreter. A function-valued fixture initially used
a pipe/Async scope context incorrectly; corrected to `option.map (apply ())`,
without changing syntax/type/effect semantics.

Wide retain overflow acquires no queue owner and preserves the caller. A forced
receive allocation trap leaves the element and queue owner intact, and retry
succeeds. This is an injected preparation failure, not a recoverable allocator
OOM claim. Controls removing queue retain/drop fail with 2/6; adding an extra
receive retain fails with 4; removing before allocation fails with 26. A control
initially targeted the old allocator expression after instrumentation; corrected
and all controls now assert they changed the generated runtime. An adjacent
task test likewise used the former receive helper name; its lookup is updated
to the scalar owned helper, retaining its count invariant checks.

Serial bounded checks after package clean:
- Initial queue probe passes, CPU 7.98 s / elapsed 16.37 s.
- Channel and task-handle probes pass in a group where the adjacent helper-name
  lookup failed; the failure was repaired, not skipped.
- Four final channel/task ownership tests pass, CPU 6.25 s / elapsed 12.67 s.
- Added function/task/generation/fallback probes pass, CPU 4.32 s / elapsed 8.80 s.

Full sequential CI remains required. Sole PR #82 exact `3fa67f3`, CI
`37703018710`: ARM macOS and benchmarks passed, Linux/Intel macOS tests live.
Merge only after all four pass with the recorded subject and empty body, then
rebase map from OLD `029fac4` onto that squash. Next acceptance work: runtime
cycles and library/unknown retained lifetime coverage, plus remaining aggregate
reconstruction/metadata gaps before phase 2 closes. Phases 2–6 remain incomplete.
Preserve OLD `bb6f9c4` for this branch's rebase and its published head for its child.

Final four channel/unwind tests pass, including timed receive checks, CPU
14.17 s / elapsed 28.63 s. Complete contract inventory (including all channel
borrow/result assertions) passes, CPU 3.26 s / elapsed 6.80 s. Library and both
affected test targets pass clippy, CPU 2.23 s / elapsed 4.63 s. Formatting passes,
CPU 0.34 s / elapsed 0.61 s; whitespace clean. Exact bounded commands included
`cargo test --test channel_queue_ownership --test task_ownership -- --nocapture`,
`cargo test --test channel_queue_ownership --test unwind_cleanup -- --nocapture`,
`cargo test --lib ownership::tests -- --nocapture`, and `cargo clippy --lib
--test channel_queue_ownership --test task_ownership -- -D warnings`. No resource
limits were raised/bypassed; no focused failure remains. Shared target contains
this channel compiler; package clean is required before checkout changes.
