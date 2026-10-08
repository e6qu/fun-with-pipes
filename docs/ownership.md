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
| Arrays, maps, sets | Counted where supported; unique updates in place | More precise borrowing/results, typed storage and views |
| Strings and bytes | Selected copy/alias primitive results counted; leaf destruction frees storage directly | Complete remaining result families, callback lifetimes and exceptional cleanup |
| Escaping closures | Compiled dynamic calls own heap closures and typed captures; runtime callbacks still share | Retained callback ownership, remaining temporary contexts, retained callback and exceptional cleanup |
| Tasks, channels, networking, callbacks | Runtime structures and shared value boundaries | Explicit retained ownership, teardown and cancellation paths |
| AD tapes/kernel buffers | Numeric arrays outside the collected value heap | Cleanup on failure/cancellation, capacity reuse and scoped lifetimes |

Native executables still need a generational conservative collector for shared
values. WebAssembly uses a bump allocator; native libraries do not trace the
host's unknown roots. `FWP_GC=off` disables tracing, not all allocation and not
the ownership gap. `--memory static` provisions bounded memory, not static
lifetimes. None of these is a general collector-free execution guarantee.

## Remaining ownership coverage

Container contracts and comparison-key borrowing are merged. Selected leaves,
fresh text trees, compiled captures, concrete temporaries and stack children are
also merged; synchronous map/filter borrow callback inputs and own their fresh spines/results.
Finish remaining primitive/runtime families, including argument/result ownership,
retention, aliases and exceptional cleanup. The exact prepared queue and current
verification are in [the handoff](development-state.md). Keep the IR pass and
code generator on the same contracts.

Contracts must distinguish borrowing for the call, consuming a reference,
retaining a reference beyond the call, returning a fresh owned value, and
returning an alias of an argument. A borrowed callback input cannot silently
become an owned result. A slice must retain its backing buffer if it escapes.

Extend measured borrowing and deterministic cleanup to the remaining container,
callback and runtime boundaries in focused changes.
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
container drops currently release only outer storage.

Generational marking restricts immediate freeing of old counted objects. Removing
that restriction needs its own invariant and stress evidence. Define cycle
policy and teardown before claiming general execution without tracing GC.

## Counted leaf primitive families

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
still require ownership contracts and cleanup. Old marked objects remain under
the collector's generational policy; WebAssembly still uses its bump allocator.

## Fresh nested text results

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
not complete ownership. PR #78 passed its full architecture and benchmark
gates; later ownership extensions require their own exact-head gates.

Eligible stack aggregates now retain typed child ownership; runtime-retained
callbacks, exceptional paths, generational old objects, count overflow and WASI
reclamation remain gaps. Closure releases use a per-thread work list to avoid recursion through nested
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
path. PR #79 passed full native/WASI/platform and benchmark gates. This does
not establish ownership of every callback or arbitrary aggregate shape.

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
PR #80 passed full CI. This covers call argument temporaries; it does not
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
stack closure allocation elimination regression passed locally. PR #81 then
passed its full architecture, WASI, GC/reuse and benchmark gates.


## Borrowed synchronous callbacks and map results

The typed `fwp_apply_borrowed` boundary borrows callback arguments during a
synchronous call and returns an owned result. Compiled callbacks retain returned
aliases by their concrete types. Map owns its fresh list spine and callback
results while borrowing input elements; direct and captured specializations keep
the same contract. Retained runtime callbacks still require separate ownership.
PRs #82–#86 passed their exact-head full gates. Fold transfers its owned
accumulator through borrowed synchronous calls while input elements remain
borrowed. Zip owns its result spine and callback results with borrowed typed input aliases.
Right-fold is next; other callbacks, runtime unwind and retained owners remain
preparation.

## Prepared work and acceptance limits

[The immutable queue](roadmap-queue.md) records runtime/callback/container,
aggregate, type, CAF, task/channel/library, OpenCL and resource cleanup work.
These branches are not merged support. Each must rebase and pass full exact-head
CI. No optional tracing-free mode is accepted until ownership coverage and cycle
policy justify it.

The latest worker-local repair keeps compatible complete calls and typed aliases
unboxed while partial/dynamic captures remain boxed. Exact child/alias/trap checks
pass, and the unchanged full wide-record allocation acceptance now passes on
Linux and both macOS architectures in separate evidence. File constructor cleanup
also has fault/omission checks for stream ownership through allocation and library
finalizer registration. Source File values remain affine: no Dup or resource
capture is added. Implicit resource discard and arbitrary resource lifetime
coverage still require interpreter/native evidence. Prepared TLS resource
teardown, connection cancellation and peer-subject temporary cleanup have actual
OpenSSL/omission checks; library probes generally run with collection unarmed.
They do not prove host-root tracing or deterministic discard of every resource.
Rebuilt nested loop records now also have a preparation that preserves typed
flattened state through Again and protects original, partial and pending owners
when Stop boxes an inner result. Alias/scalar/cancellation and omission controls
pass locally; sequential full CI remains required. No measured speed claim follows.
An ALPN owner-liveness probe deliberately arms collection in a standalone fixture
and reproduced loss of the owning Conn during String allocation. Its owner fence
and fence-omission control now pass under real GC/reuse verification; production library
tracing remains unarmed. Current work/evidence, including any unresolved failures,
is recorded in the handoff rather than appended as another priority queue here.

Native file.write also has a prepared visibility repair: flush checked stdio
buffers before returning to match Rust descriptor writes, including write errors
while the affine handle remains borrowed. General discard remains separate:
a File parameter stays alive until its original function frame exits, even after
ignore, because early close changes observable later I/O failures. Internal
resource scopes must survive optimization and preserve that original lifetime.

File read error/UTF-8 agreement and temporary read-buffer cleanup now also have
a preparation. The borrowed read-all handle stays open through failure; the
path-based read owns and closes its stream. Short write-new and buffered close
errors are checked with the original write errno preserved. This does not
establish general implicit resource disposal or tracing-free coverage.

## Original resource lifetimes

General resource discard is an active phase 2 repair, not a CI blocker. The
current File audit has two complementary acceptance cases: 64 open/discard loop
steps succeed under a 32-descriptor child limit without collection, and reopening
after ignoring a File parameter still fails under a four-descriptor child limit
until its original function frame exits. The interpreter retains original
parameters and local bindings for that frame. Eager last-use close would turn an
observable failure into success. Explicit file.close retains its existing effect.
Neither descriptor limit changes the compiler, test runner or user session.

A prepared compiler repair records original File owners before optimization.
Internal resource regions must survive inlining and loop lowering; an inlined
callee's parameter anchors must use fresh local binders rather than aliases of
caller binders. Preserve owners for initialized original resource locals, including
conditional pattern bindings, without retaining unrelated optimizer-generated
argument temporaries. A stack scope can hold zero-initialized owner slots and
release the initialized slots on normal return, effect failure, recoverable trap
or task cancellation. Protect partially retained slots during preparation. These
are compiler representation details, with no nullable File type or new syntax.

Region anchors complement typed retain/drop rather than replacing ownership of
returned values. Result aliases, returned aggregates, Again/Stop state, borrowed
runtime calls and error payloads need correct ownership transfer before dropping
the region. Optimized interpreter execution must release the same original frame
anchors at the same boundary. Required resource cleanup must work with
FWP_REUSE=0, FWP_FREE=0 and collection disabled; check supported WebAssembly
resource behavior separately because its bump allocator has no native RC slots.
Library finalization remains idempotent and must not double-close a discarded
handle. Preserve affine File restrictions and forbidden partial resource capture.

Typed ResourceRegion metadata and interpreter frame release are now prepared,
including a reproduced inlined-helper lifetime repair. Native regions currently
evaluate their bodies without implicit destruction; connecting typed File
ownership is the next required implementation step. This is not delivered
ARC coverage. Validate raw and optimized interpreter/native behavior, escapes,
errors, cancellation and optional flags before accepting general disposal. Keep
tracing available until complete ownership and cycle acceptance is demonstrated.
