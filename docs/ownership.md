# Memory ownership

An **owner** keeps a value's storage alive and is responsible for releasing it.
A **move** transfers that responsibility. A **borrow** uses storage while another
owner keeps it alive. An **alias** is another reference to the same storage.
These are mostly compiler concepts: fwp programs still use ordinary immutable
values and pipes.

**Automatic reference counting (ARC)** tracks how many owners share an object
and releases it when the last owner goes. A **tracing garbage collector (GC)**
finds reachable objects by following references, then reclaims unreachable ones.
A **region** groups allocations under one lifetime so they can be released
together. fwp aims to prove ownership at compile time, using counts only where
sharing requires them; deleting tracing does not by itself remove count costs.

This page describes today's contracts. [PLAN.md](../PLAN.md) names the remaining
implementation tasks. [Primitive ownership](primitive-ownership.md) specifies
individual operations; [measurements](benchmarks.md) report actual costs.
The [accepted ownership direction](gc-removal-design.md) specifies explicit weak
links, rejection of unproved owning cycles, count-free unique storage and scoped
regions. Weak channels and retained C registrations are implemented. A restricted
[count-free local array path](measurements/unique-array-storage.md) is implemented
and under verification; general regions remain planned. APIs may change.

## Existing implementation

fwp has one native ownership policy: prove lifetimes
before generation, transfer or borrow existing owners where possible, and count
remaining shared owners. Unsupported relationships are compile errors. There
is no command-line memory-policy selector. `--memory static` chooses a bounded
storage pool; it does not make every allocation a stack value.

**Tracing removal is verified in [#217](roadmap-history.md#tracing-gc-removal-pr-217).**
The integrated compiler, replacement ownership tests and binary checks passed
on Linux, macOS and Windows, each on ARM64 and AMD64. Native packages contain
the collector-free compiler. Node-hosted browser-loader checks do not establish
support in every browser engine.

The interpreter uses Rust-owned values and scheduled task lifetimes. Counted native
values still need count slots and uniqueness checks. Selected local arrays can
instead use direct destruction without count storage; allocator size classes and
failure/cancellation cleanup remain necessary. Neither engine can prove arbitrary foreign code obeys its contract or
remove a JavaScript host's collector.

### What remains

- Preserve the independent [ownership diagnostics](ownership-diagnostics.md)
  and binary checks for absent collector code as storage representations change.
- Enforce the compiler analysis budgets in G2 as proof precision changes.
- Use A2–A6 to remove measured count traffic and boxes, then give a proved unique
  buffer and one scoped workspace their own storage paths. A program with zero
  retains may still allocate or check a count during destruction.

[PLAN.md](../PLAN.md) defines the fixtures and completion evidence.

## Stable language behavior

Values are immutable even when their storage is reused. For example:

```fwp
main = [3, 1, 2] | both sort id | echo
```

`both f g` applies both functions to the same input; `id` returns it unchanged.
The result is `([1, 2, 3], [3, 1, 2])`. Sorting must preserve the original list
needed by the second branch. Removing that branch can make more storage eligible
for reuse, but the source language still has no observable mutation.

Optimization also preserves effects, evaluation order, checked arithmetic,
failures and trap messages. A file's destruction cannot move earlier merely
because a call was inlined. Derivative recording cannot be duplicated or reordered
just because a derivative function has a pure public type.

## Ownership boundaries

A boundary is a call or stored value that changes who is responsible for storage.

| Contract | Meaning |
|---|---|
| Borrow | Use the caller's value during the permitted lifetime; do not release its owner |
| Consume | Take one owner, then release it or transfer it onward |
| Retain | Acquire an additional owner, usually by increasing a reference count |
| Fresh result | Return newly owned storage |
| Alias result | Return existing storage with an independently valid owner |
| Unknown retention | No checked ownership proof; ARC rejects the unsupported relationship |

A borrowed input does not automatically become an owned output. A view that
escapes a call must keep its backing storage alive. Copying a container retains
managed elements that both copies need; immediate numeric elements need no counts.

Cleanup is part of each contract. Partly constructed records, decoder results,
callback arguments and copied lists protect every acquired child until transfer
succeeds. On a failure, trap or cancellation, owners unwind in reverse acquisition
order up to the catching scope. Each task has its own cleanup chain. Successful
transfer removes the cleanup registration without freeing the transferred value.
[Collection cleanup](measurements/collection-cleanup.md),
[list copying](measurements/list-copy-cleanup.md) and
[record cleanup](measurements/record-cleanup.md) explain the failure controls.

### Borrowing across direct calls

A **direct call** has a target known to the compiler. It can borrow an argument
when the target neither stores nor returns its storage and the caller keeps the
same owner alive. The current proof requires the relevant owners to be used again
by every live caller; using another field is insufficient. Last-use arguments
keep their consuming convention, avoiding artificially extended lifetimes.
Unknown calls, escaping values and resource scopes need their existing ownership.

Temporary local names and eligible callback captures can also borrow established
owners. The proof follows bindings and matches and preserves failure cleanup.
Generic entries may still take boxed tuples and counted arguments even when a
specialized direct entry avoids them. See [direct-call borrowing](measurements/channel-direct-borrows.md),
[local borrowing](measurements/channel-local-borrows.md), and
[array captures](measurements/array-capture-borrows.md).

### Cached numeric map reads

A computed top-level value has a cache owner until teardown. Eligible reads of
`map.get` and `map.size` borrow that owner for immediate numeric key/value maps.
The read span must not suspend, escape or permit reentrant cleanup that invalidates
it. Initialization keeps its original effects and failure timing; replacing a
cached value releases the old cache owner while independent aliases remain valid.
`tests/cached_map_borrows.rs` checks these conditions. This optimization does not
make every access to a cached container free of count operations.

### Moving records, variants and captures

An owned field can move out of a uniquely owned parent when the discarded parent
will no longer release that field. Shared parents retain independent child owners.
Known record/variant results can pass separate fields without allocating a wrapper;
whole-value and unknown-call uses may still box them. Eligible closure captures
can move into their last consuming call. Every case needs the alias, effect and
cleanup proof, not just syntactic last use. See the
[compiler design](design.md) and [primitive contracts](primitive-ownership.md).

### Array construction and sorting

`array.from-list` takes one list owner. Nodes before the first shared node can
transfer their elements into the array; the shared tail must retain copied
owners even if later individual nodes have counts of one. `array.sort` takes
one array owner and can reuse uniquely owned storage. Shared arrays and views
preserve their original contents. Inline wide values keep all their bits.
The [comparison](measurements/array-sort-ownership.md) explains alias and cleanup
controls, count savings, and additional code/stack costs. Its six-host
checks and final production gates passed in #212.

## Tasks and channels

A channel owns its queued messages. Sending consumes one message owner while
borrowing the channel handle. Successful insertion transfers ownership; a live
source alias keeps its own owner. Closed sends, cancelled waits and failed growth
release the consumed message. A failed receive-result allocation leaves the
message queued for retry. An immediately matched receive can return separate tag
and payload fields without allocating `Some`; a whole-value result still boxes.

Closing a channel **preserves queued messages** for later receiving. It is not
cycle breaking. Releasing its final owner destroys the remaining queue and typed
contents. Cancelled waiters first remove their registrations and owners.

Checked ARC accepts immutable data payloads and nested channels whose ownership
cannot loop back. `Channel[Channel[String]]` is accepted: the inner queue only
owns strings. A type such as `Link = | Node (Channel[Link])` permits a back-edge
and is rejected even if one particular program would drain it safely. The error
means the compiler lacks a proof, not that every value is already cyclic.

### Functions stored in channels

A function's type describes its inputs and result, not what it captures. `add 3`
captures an integer; a different `I64 -> I64` function might capture a channel.
Accepting every function of that type would miss a possible owning cycle.

The compiler follows known functions, partial applications, returned functions,
containers, caught errors and queue producers. It checks captures and where the
received function uses State or autodiff scopes. An unknown producer remains
unknown when combined with known ones. An empty set of possible values, such as
an empty function list, is different from an unmodeled producer.

| Captured owner or payload | Current checked-ARC rule |
|---|---|
| Scalars, strings and immutable containers | Accepted when their contents satisfy the same ownership rules |
| Other functions | Follow their captures and eventual call scopes |
| UDP/socket/listener handles | Accepted shared handles cannot own a language callback or queue; the final owner closes the descriptor |
| Data-only channel from a known creator | Accepted if its nested owners cannot lead back to a callback queue |
| Served gRPC response channel | Has a specific transport-owner contract; not a general contract for external channels |
| Known task computation/result | Follow both captures and result owners, including returned callbacks |
| Unknown task/function/channel producer | Rejected until an explicit source/lifetime model supplies the proof |
| Queued HTTP/2 stream or captured unproved stream context | Rejected: a hidden handler/continuation may lead back to the queue |
| Single-use `File` captured by a reusable function | Rejected by the source type rules; weakening a queue check cannot make it reusable |

For a runnable example and explanations of `curry`, `const` and queue operations,
see [ownership scopes](tutorials/23-ownership-scopes/README.md). The
[queued callback](measurements/queued-callbacks.md),
[data-channel](measurements/queued-data-channels.md),
[task-handle](measurements/queued-task-handles.md) and
[gRPC response](measurements/queued-grpc-responses.md) reports record the supported
cases. These are finite proofs and tests, not general cycle inference.

Queues of the same concrete payload type currently share possible-target sets;
aggregate fields and caught errors also combine information conservatively.
This can reject safe programs. More precise analysis must preserve the explicit
unknown-source case and must not mistake no information for no captures.

### Interpreter entries

A public interpreter entry joins ordinary children and cancels/joins background
connection workers before its borrowed program or output buffers can expire.
Macros, compile-time evaluation, commands and REPL cells use that boundary.
An unfinished remote stream cannot continue reading in a later cell.

Writers have shared locked ownership and require Rust's `Send` trait because
interpreter tasks use different OS threads. Only the scheduled task evaluates
language values at a time. A Rust panic propagates after cleanup; if cleanup
itself panics, the process aborts rather than allowing live borrowed tasks to
escape. These are interpreter implementation guarantees, not new language effects.

## Original resource semantics

`File` is **affine**: an operation may consume it or explicitly return it for
further use, but it has no general duplication trait. Its original function frame
bounds its lifetime even when it is ignored. Resource-region markers preserve
that lifetime through optimization. Constructor failures release raw handles
before returning an error. Closing an already closed resource is safe where its
operation's contract permits it; this does not permit using a freed owner.

Shared sockets, listeners and process/network contexts use their own typed owners.
Explicit socket close affects every alias; retaining an alias does not duplicate
the underlying connection. Memory ledgers for language objects do not automatically
count OS descriptors, native buffers or library allocations: their tests observe
those separately.

Long-chain destruction uses iterative release where supported so that dropping
large lists or wrapped chains need not recurse through one C frame per node.
This is separate from optimizing a program's recursive function calls.

## Checked ARC delivery

### Native executables and services

Native ARC checks each entry and the lowered temporary values reachable from it.
A user declaration with a familiar primitive name does not inherit a checked
library contract. Maintained commands, collections, files, scoped derivatives,
HTTP and gRPC have explicit owners and cleanup tests. Accepted execution does not
imply that every closure or call avoids allocation.

### HTTP ownership

HTTP connections, handler functions, responses and stream contexts have distinct
owners. Handler borrowing during a known call does not authorize indefinite
retention elsewhere. The maintained HTTP/gRPC applications test repeated requests,
disconnects, cancellation and shutdown. Generated REST/MCP entries use checked
contracts too. Queuing a stream handle remains a different, restricted ownership
relationship. See [API memory](measurements/http-application-memory.md) and
[application acceptance](application-acceptance.md).

### WebAssembly and host roots

Supported WASI entries and the browser loader use typed owners and an external
count table. Removing a count entry frees its storage; this still costs metadata
lookups and allocation. Freed WebAssembly blocks can be reused, but the module's
memory capacity does not shrink. Browser-loader invocations own separate module
instances and copy output strings to callbacks. Asynchronous task support depends
on the declared host capabilities; emulation or a Node loader check does not prove
native platform or browser-engine coverage.

Tracing libraries and WebAssembly cannot discover arbitrary host roots. Their
historical unproved-graph retention is not a solution for the future GC-free
contract. Checked ARC rejects unsupported ownership instead.

### C library results and foreign calls

C input strings copy into owned fwp storage; supported scalars and raw pointers
copy by value. Exported strings and supported flat records containing strings
return explicit owners. Call the generated `fwp_release_NAME(result)` exactly once
with the complete unchanged result before unloading the library. Pointer-bit
copies do not create owners. Do not use C `free` on these values, mutate returned
bytes or use them after release. Host entry and release calls must be serialized.

Unique results can transfer without an extra string copy; shared fields still
need independent owners. Conversion finishes before transfer. Embedded NULs are
rejected instead of truncating strings, and a later conversion failure releases
earlier prepared fields. Borrowing C input strings instead of copying them still
needs an escape/lifetime proof.

Foreign callbacks currently run synchronously on the calling task. Incoming C
strings copy before the callback uses them, so a callback can retain its owned
copy. A later invalid/null input releases earlier copies. Managed string results
from callbacks and callbacks retained by C require a separate host-release
contract and remain restricted. Foreign strings returned to fwp copy before the
call's temporary buffers expire. The interpreter also releases its temporary
foreign-call copies after normal, nested and failed calls.

`Ptr[T]` copies an address, **not an owner of T**. The programmer keeps the storage
valid, synchronizes access and uses its matching allocator. `mem.alloc` and
`mem.string` need `mem.free`, including an explicit cleanup path after failure.
Borrowed host pointers must not be freed. `Unsafe` records these obligations;
it does not prove them. Never use raw addresses to bypass managed lifetime checks.
If C returns a pointer into an input buffer, use an explicitly owned raw buffer
and copy the result before freeing it. See [C interop](tutorials/09-c-interop/README.md)
and [manual-pointer checks](measurements/manual-pointers.md).

## Representation and numerics

Use the least costly representation that preserves behavior. A dynamically sized
matrix can appropriately own a heap buffer. Moving every value to the stack is
not a goal. Alignment and compactness are tradeoffs: padding every value to a
cache line wastes memory and does not establish vectorization or faster execution.

### Accepted numeric representation

Known numeric workers pass concrete C scalars and record fields. Generic entries
can still box those values. The target C calling convention decides register or
caller-provided result storage; the source type alone cannot promise registers.

Numeric arrays have an eight-byte length header, external type descriptors and
these element strides:

| Element type | Bytes |
|---|---:|
| I8/U8 | 1 |
| I16/U16/F16/BF16 | 2 |
| I32/U32/F32 | 4 |
| I64/U64/F64 | 8 |
| F128 | 16 |

Managed elements and boxed wide integers use generic word slots with typed
cleanup. F128 slots have eight-byte alignment and use byte-copy loads/stores to
respect C aliasing rules. An escaping F128 scalar copies its bits into a box.
A set uses one word per key; a map uses a key/value pair even when its value is `()`.

A numeric slice can keep a byte address and a backing owner in a 24-byte view.
Nested views retain the original backing directly. Slices copy when the payload
is no larger than the view header or less than a quarter of the backing length.
Managed/resource-element slices copy to preserve disposal order. Updating a view
copies; only an eligible owning array can reuse its storage.

Storage and binary transport preserve floating-point bits. Arithmetic rounding
and NaN handling are separate [format contracts](float-formats.md). No optimizer
may silently reassociate operations or fuse differently rounded multiply/adds.

### Fusion and derivative scopes

Fusion combines stages into one loop. Eager list stages may interleave only when
the compiler proves that effects, termination and the first trap stay unchanged.
An early-stopping operation needs a stronger nontrapping proof for skipped work.
Keep the distinct-trap and early-stop regressions when extending fusion.

A derivative scope owns its recording and result lifetime. Reusing bounded raw
workspace is permitted; retaining an expired derivative is not. Child tasks begin
fresh state/derivative scopes and cannot inherit a parent's proof. Raw unscoped
operations remain restricted. See [numerics](numerics.md#reverse-mode) and the
[AD application measurements](measurements/ad-application.md).

## Cycle and retention contract

An owning cycle is a loop of values that keep one another alive. Ordinary ARC
cannot reclaim an unreachable strong cycle. A logical cycle represented by
integer IDs is different: the IDs do not keep their targets alive.

The compiler rejects unproved owning cycles. [Weak channels](weak-channels.md)
provide explicit non-owning links; [C registrations](retained-callbacks.md) provide
an explicit lifetime for selected retained callbacks. Both were verified in #215.
Returned functions and partial applications retain their captures normally.

| Use case | Supported form or restriction | Release rule |
|---|---|---|
| A queued callback refers to its receiving channel | Capture a `WeakChannel`, then explicitly upgrade it before use. Capturing an unproved strong owner is rejected. | Final strong release expires weak links before destroying queued values. |
| Persistent subscription | A task owns the handler and reads a data queue; [lesson 24](tutorials/24-subscriptions/README.md) defines `subscribe`, `finish` and `stop`. | Finish drains; stop cancels and awaits. Remaining channel aliases still own unread messages. |
| Graph with node deletion | A map owns nodes; edges contain IDs. [Lesson 23](tutorials/23-ownership-scopes/README.md) handles a missing node. The [generation fixture](../tests/fixtures/graph_generations.fwp) checks ID reuse. | Deletion releases the node; generations distinguish a reused slot from its previous occupant. |
| C-retained callback | Register a selected export through its generated context API. Bare foreign callback pointers remain call-scoped. | Close prevents entry; release consumes the registration owner; active calls finish before destruction. |

A task handle's release does not cancel its task. A normal `task.scope` return
waits for children; failure cancels and joins them. An active callback may suspend,
spawn children or call another callback. Completion must wait for that work to
finish/unwind before its owners expire. Cancellation is cooperative, not a hard
latency bound. `attempt` handles language errors, not cancellation. A subscriber
that catches a callback error returns the error and stops; its owner still closes
the channel. Reentry into a bounded queue must avoid waiting on the only consumer.

For example, C code like this violates the current scoped callback contract:

```c
#include <stdint.h>
static int64_t (*saved)(int64_t);
void remember(int64_t (*callback)(int64_t)) { saved = callback; }
/* Calling saved after remember returns is not supported. */
```

The compiler cannot inspect arbitrary linked C and guarantee a diagnostic for
this violation. Use the [retained API](retained-callbacks.md) when C must keep
a callback: it provides the context, release operations and active-call rules.
Managed callback results likewise remain rejected without a host release contract.
Returning a copied C-library export result uses a separate, already defined API;
it does not make all foreign callback results safe.

Unknown callback/task producers, recursive channel owners, queued HTTP/2 streams
and task-result back-references remain rejected. The
[admission checklist](ownership-admission.md) records each boundary's diagnostic
and explicit supported alternative. Raw and optimized entries enforce these same
rules; there is no tracing execution path that bypasses them. The scoped
subscriber establishes one useful accepted form, not arbitrary cycle inference.

A weak reference does not keep its target alive. Use `channel.downgrade` and
`channel.upgrade` explicitly; see [weak channels](weak-channels.md) for examples. Silently weakening a
capture would change behavior. Acquiring an owner must not permit storing it
where it creates a new unproved owning cycle; a scoped access operation alone
does not establish that property.

## Ownership contract checks

`src/ownership.rs`, the reference-count pass and generated wrappers must agree.
The primitive inventory checks declarations, symbols, aliases, argument/result
ownership and callback policy against its frozen baseline. An inventory count
is not a count of allocations eliminated or objects reclaimed.

## Evidence required

Compare semantics with the unoptimized interpreter, including effects and errors.
Exercise aliases, reentry, cancellation and partial construction. Observe storage
between completed operations as well as at process teardown; a final zero can
hide growing retention during a service's lifetime. Deliberately missing releases,
invalid reuse and stale borrows must fail their observers.

G5 is complete only when the replacement ownership controls and all maintained
native targets pass on the same source. A focused test alone does not verify removal. Report managed bytes, native buffers, OS handles and process memory
separately. For a performance claim, name the exact comparison, inputs, toolchains,
samples, code size and stack cost. [Benchmarks](benchmarks.md) explains how to read
those results; [delivery history](roadmap-history.md) records tested revisions.
