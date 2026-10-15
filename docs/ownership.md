# Memory ownership and efficient native execution

A program needs memory for values that outlive a single calculation. An **owner**
is responsible for keeping such storage alive. **Borrowing** uses a value while
an existing owner keeps it alive. An **alias** is another reference to the same
storage. These are compiler/runtime concepts; fwp code still uses immutable values
and ordinary pipes.

This guide states the implemented memory contract. The [primitive tables](primitive-ownership.md)
give per-operation details, [benchmarks](benchmarks.md) distinguish memory savings
from speed, and [delivery history](roadmap-history.md) records accepted tests.

## Direction

The [project plan](../PLAN.md#memory-direction) targets removal of tracing GC,
with compile-time ownership, moves and borrowing as the normal way to manage
lifetimes. ARC is reserved for necessary shared ownership. Counted allocation
alone is not the desired endpoint: unshared values should avoid count traffic,
and eligible abstractions should compile away. The contracts below describe
what exists today; they do not claim this objective is already achieved.

## Stable language behavior

Optimization must preserve results, external actions, evaluation order, failures
and trap messages. Updating a uniquely owned buffer internally must not change an
older value still visible through an alias. Files must remain open for their
original language lifetime even if the optimizer inlines or removes calls.

Derivative recording has observable ordering requirements despite its pure public
types. The optimizer must not duplicate or move tape operations in ways that alter
the recording. Arithmetic remains checked; floating-point operations retain their
specified order and precision.

## Existing implementation

There are three different claims to keep separate:

| Mode or setting | What it provides | What it does not prove |
|---|---|---|
| Default native tracing mode | Reference counting for proved owners, plus tracing collection for shared graphs | Every object is freed immediately |
| `--gc arc` | Compile-time checks for the supported automatic-reference-counting subset; tracing code is excluded | Every fwp program is supported, or allocations disappear |
| `FWP_GC=off` | Turns collection off in a tracing build, useful as a test control | Values have complete ownership or memory use stays bounded |

`--memory static` provides a bounded memory pool. It does not mean that every
value has a statically known lifetime. WebAssembly and native libraries release
typed counted owners but retain unproved shared graphs: they cannot scan arbitrary
host roots. Checked ARC admits native executables and C libraries with checked
copying boundaries, described below.

The compiler first tries to eliminate temporary objects, keep fields as scalars,
and place eligible values on the stack. Values that still need shared storage
use typed reference counts where their lifetime is proved. A count reaching zero
releases typed children and eligible storage. Counts above 254 use an auxiliary
exact count; they do not automatically become permanently shared. Count overflow
traps. Unproved runtime sharing still uses tracing.

| Value family | Current representation or ownership | Important boundary |
|---|---|---|
| Small scalars and empty variants | Inline words or concrete C scalars | Bits resembling addresses remain numbers |
| Records and variants | Separate fields, C structs, stack values or counted heap objects | Whole-value uses and unknown calls can require boxing |
| I128/U128 | Direct wide values in eligible workers; counted 16-byte boxes at generic boundaries | Containers and closures can still box |
| Arrays, maps and sets | Typed elements, counted storage, selected unique updates | Callback and alias contracts must be proved |
| Strings and bytes | Counted leaves for proved copies/aliases | Unmodeled result families remain shared |
| Closures | Owned captured arguments and typed call metadata | Retained unknown callbacks are not checked ARC |
| Tasks and channels | Counted handles/results/queues | Mutable cycles are not automatically broken by counting |
| Derivative tapes | Scoped owners and a bounded numeric workspace | Raw unscoped tape calls are not checked ARC |
| External/network state | Explicit resource teardown where modeled | Freeing a C buffer does not prove the lifetime of every referenced fwp value |

## Ownership boundaries

A boundary is a call where ownership crosses between compiled code and a runtime,
foreign function or remote service. Every contract distinguishes:

- **Borrow:** read a value for this call while its caller remains responsible.
- **Consume:** take an owned reference; the callee releases it or transfers it on.
- **Retain:** acquire an additional reference that can outlive the call.
- **Fresh result:** return newly owned storage.
- **Alias result:** return existing storage with an independently valid owner.
- **Runtime sharing:** place a graph under the tracing lifetime policy because
  complete counted ownership is not proved.

A borrowed callback input cannot simply become an owned output. An escaping view
must retain its backing buffer. Copies of containers retain their selected
pointer-bearing elements; scalar elements need no reference operations.

Failure cleanup is part of each contract. Registered owners are released in
reverse acquisition order before a failure, trap or cancellation invalidates the
stack frame. A catching handler bounds that cleanup; each task has its own chain.
Successful transfer removes the registration without releasing the transferred
owner. Partially constructed records, callback arguments and decoder results
must protect every acquired child until transfer succeeds.

Counting cannot reclaim an unreachable cycle by itself. For example, a channel
can contain a queued value holding that same channel. Closing it must preserve
queued values for later receives. Explicit draining breaks the tested cycle;
losing the last external handle without draining does not. Unproved cycles need
tracing and are rejected by checked ARC.

## Ownership contract checks

The tests inventory declarations, resolved runtime symbols and
aliases against the recorded baseline. They check argument/result modes,
callbacks, retention, teardown and cycle policy. A count of inventoried functions
is not a count of freed objects or fixed bugs.

The inventory, reference-count pass and C wrappers must agree. Tests also cover
aliases, scalar bits resembling addresses, cleanup on nonlocal exit, resource
lifetimes and cycles. Unknown calls remain explicit sharing boundaries. The
[accepted evidence](roadmap-history.md) records platform runs; a skipped test is
not support for that platform.

## Representation and numerics

Use the least costly representation that preserves behavior. A large dynamic
matrix can appropriately use a reusable heap buffer. Putting everything on the
stack is not an objective. Register spills are ordinary compiler decisions,
not an alternative memory mode.

Natural alignment means an address meets the requirement of its element type.
It does not promise cache-line alignment or a SIMD instruction (one instruction
operating on several numbers). Padding every small value to a cache line can
waste memory. Layout, cache behavior and speed need workload-specific evidence.

Floating-point storage and binary transport preserve bits. Arithmetic rounding
is a separate contract: [float formats](float-formats.md) specifies software-format
NaN handling and precision; host F32/F64 arithmetic can have target-dependent
NaN payload choices. Compare NaN classification separately from raw transport
payloads. No optimization may silently reassociate operations or combine a
multiply/add into one differently rounded operation.

### Accepted numeric representation

Direct numeric workers are specialized functions with concrete C parameters,
results and record fields. Their generic entry points convert between those
values and `V` words/boxes without changing bits. The platform's C calling
convention chooses registers or caller-provided return storage. For example,
three F64 fields can use floating-point registers on ARM64 while a 24-byte
return uses caller storage on AMD64. Inspect emitted code for the target before
making a register-placement claim.

Numeric arrays have an eight-byte length header and descriptors outside the
payload. Element sizes are:

| Types | Bytes per element |
|---|---|
| I8/U8 | 1 |
| I16/U16/F16/BF16 | 2 |
| I32/U32/F32 | 4 |
| I64/U64/F64 | 8 |
| F128 | 16 |

Pointer-bearing elements and boxed wide integers keep generic word slots and
typed destruction. F128 arrays use sixteen-byte stride at eight-byte alignment;
an escaping scalar copies its bits into an independent box. `memcpy`-based
loads/stores preserve alignment and C aliasing rules.

A numeric slice can be a view with a tagged length, byte address and retained
backing owner. Nested views retain the original backing directly. Updates copy
a view; only an owning unique array can mutate in place. Slices copy instead if
the payload is no larger than the 24-byte view header or less than one quarter
of the backing length. This avoids retaining a large array for a tiny result.
Pointer/resource-element slices always copy to preserve disposal order.

`FWP_TYPED_ABI=0` and `FWP_PACKED_ARRAYS=0` select older representations for
controlled experiments. They are comparison controls, not recommended settings.
F128 stride remains sixteen bytes even with narrow packing disabled.

Fusion combines collection stages into one loop. Eager stages may interleave
only when they are pure, terminate and cannot change which trap message appears.
An early-stopping `find` needs nontrapping stages. Keep the
[distinct-trap](../tests/run/fusion_traps.fwp) and
[early-stop](../tests/run/fusion_find_trap.fwp) tests when changing those rules.

## Evidence required

For semantic changes, compare native execution against the unoptimized interpreter,
including effects and failures. Memory changes need tracing stress/verification,
reuse verification, aliases, exceptional exits and deliberate omitted-cleanup
controls. A deliberate omission should make the test fail; otherwise a successful
run may not be measuring reclamation at all.

For performance, name the baseline and compare equivalent inputs/results. Record
hardware, compiler versions, flags, timing scope, allocations, peak live storage,
reference operations and collection activity. Separate kernel-only time from
construction/cleanup and whole-process time. Reserved address space and process
resident memory are different from live value bytes. See [benchmarks](benchmarks.md).
Run full gates and measurements on GitHub runners under the repository work rules.

## Merged ownership boundaries

The supported families include typed arrays/maps/sets, selected string/byte
results, synchronous list callbacks, owned closure captures, task results,
scoped state, decoded trees, CLI arguments and scoped derivative recording.
Their exact borrow/consume/result contracts live in
[primitive ownership](primitive-ownership.md), avoiding a second competing list.

The runtime also protects resource/network contexts during normal and exceptional
teardown. This does not admit every network graph into ARC. Container ownership
and freeing temporary transport buffers are narrower claims than proving every
retained external callback or connection context.

## Ownership coverage

Checked ARC admits immutable retained-task graphs whose captures and results have
proved owners. Scheduler, scope and caller each hold their own references;
repeated awaits return separate result owners. Child tasks start fresh state and
derivative scopes, so a parent's scope proof cannot be inherited across spawn.
Captures may point to older tasks, but the admitted subset cannot publish a raw
mutable back-edge through channels, pointers or unknown callbacks.

The compiler checks lowered temporary types as well as source types. Declaring
a user primitive with a familiar runtime symbol does not grant it the standard
library's checked ownership contract.

## Original resource semantics

`File` is **affine**: it may be used at most once unless an operation explicitly
returns it for further use. It has no duplication trait. A file parameter stays
alive until its original function frame exits, even if ignored. Closing it early
could change later IO failures. Internal resource-region markers preserve that
lifetime through inlining and fusion. Partially matched values keep already bound
resources alive until the same original boundary.

File headers count logical owners independently of ordinary collector slots.
The last owner closes the stream; explicit close and teardown are safe to repeat.
Constructor failures protect the raw stream until registration succeeds. Releasing
an unshared header removes its library finalizer before freeing storage.
`FWP_FREE=0` can keep ordinary storage for comparison while resource ownership
still closes streams. Resource lifetime and physical storage lifetime are distinct.

## Checked ARC delivery

`fwp build --gc arc` excludes tracing code and rejects unsupported ownership.
Supported native entries include `main`, exported function executables and CLI
commands and native C libraries with copied inputs and pointer-free results.
Each entry starts without assuming an existing state or derivative scope.
WebAssembly, remote and service entry points remain outside this mode.

For a static or shared C library, scalar inputs are copied by value and string
inputs are copied into owned language storage during the call. Records can
contain these input types. Results must be scalars or records of scalars: C
receives all their bits before the temporary language value is released.
Returned strings and raw pointers are rejected because the current ABI (the C
calling convention and generated declarations) has no way for the host to
release managed storage. Each exported function is checked independently, even
if another export uses it under a state or derivative handler. Serialize host
calls and finish them before unloading; concurrent host entry is not supported
by this contract. The generated header states these obligations.

This extends the existing copying ABI without introducing a handle or release
wrapper. Ordinary tracing libraries keep their existing behavior. Proving these
boundaries does not make every library eligible for ARC, or eliminate the
necessary copy of a string that the host can later change.

Scoped C calls can borrow strings/bytes and copy supported scalar/record values.
Synchronous callbacks must run on the calling task before C returns; C must copy
borrowed data before keeping it. Foreign strings are copied into owned fwp values.
Raw pointers and callbacks returning managed C addresses are rejected because
an address alone cannot prove its storage lifetime.

State operations must run under a proved handler. A returned closure does not
extend the old handler's lifetime, though it can run under a new one. The checker
tracks callback targets, captures and stored values; unknown targets are rejected.

Derivative calls likewise need a proved scope. A returned token cannot keep a
tape alive, and stale/mixed/cross-task tokens trap. Nested tapes own typed weights
and remain protected while backward callbacks record into an outer tape. Scope
exit, failure, cancellation and library teardown release those owners. Numeric
workspace reuse is bounded and counted separately from returned gradient arrays.

Decoded JSON/text/binary/CSV trees have typed ownership, including partially
constructed fields and displaced map values. CLI parsing owns defaults, repeated
flags, diagnostics and results. Temporary decoder scratch has its own cleanup;
freeing scratch alone would not prove ownership of the resulting tree.

Acceptance tests check physical reclamation at O1/O2 with stack placement both
on and off, inspect native symbols/instructions for absent tracing, and require
missing-free controls to fail. ARC still needs allocator metadata and can retain
reusable pages. It promises neither zero allocation overhead nor immediate return
of every page to the operating system.
