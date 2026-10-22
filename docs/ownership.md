# Memory ownership and efficient native execution

A program needs memory for values that outlive a single calculation. An **owner**
is responsible for keeping such storage alive. **Borrowing** uses a value while
an existing owner keeps it alive. An **alias** is another reference to the same
storage. These are compiler/runtime concepts; fwp code still uses immutable values
and ordinary pipes.

This guide states the implemented memory contract and labels proposed changes.
The [primitive tables](primitive-ownership.md)
give per-operation details, [benchmarks](benchmarks.md) distinguish memory savings
from speed, and [delivery history](roadmap-history.md) records accepted tests.

For a first example of immutable sharing, read
[lesson 22](tutorials/22-recursion-and-sharing/README.md). For a specific question:

- [Modes and representations](#existing-implementation): what the compiler does today.
- [Boundary rules](#ownership-boundaries): who owns arguments and results.
- [Checked ARC](#checked-arc-delivery): supported entries and caller obligations.
- [Cycle proposal](#proposed-cycle-policy): design work, not implemented APIs.

## Direction

The [project plan](../PLAN.md#memory-direction) targets removal of tracing GC,
with compile-time ownership, moves and borrowing as the normal way to manage
lifetimes. ARC is reserved for necessary shared ownership. Counted allocation
alone is not the desired endpoint: unshared values should avoid count traffic,
and eligible abstractions should compile away. The contracts below describe
what exists today; they do not claim this objective is already achieved.

## Proposed cycle policy

An **owning cycle** is a loop of references that keep each other alive. For
example, a channel owns a queued callback whose captures own the same channel.
Ordinary reference counting cannot reclaim that unreachable loop.

The design direction is to require a proved way to release each ownership group
without tracing. This is not a ban on recursion, shared immutable values or
logical cyclic graphs. The precise rules and public APIs remain to be designed;
current checked ARC uses the conservative restrictions below.

| Pattern | Proposed treatment | Cost or restriction |
|---|---|---|
| Callback used during one call | Borrow inputs/captures | The borrow cannot outlive its owner or escape the call without another valid owner. |
| Subscription or background operation | Independent scope owns registration and disconnects it | Cleanup must cover failure/cancellation and active callbacks; it cannot depend on the cyclic object's destructor. |
| Back-reference to an independently owned resource | Explicit weak handle | Acquiring a temporary owner can fail when the target is gone; the program chooses what to do. |
| Cyclic graph | One graph owner, nodes linked by non-owning IDs | Node deletion and stale IDs need rules; unused nodes may remain until explicitly removed. |
| Unknown retained callback or foreign pointer | Explicit lifetime contract or rejection | The compiler cannot infer arbitrary external behavior. |

A weak reference does not keep its target alive. Hypothetical `weak.create` and
`weak.upgrade` helpers could create one and return `Some owner` or `None` when
used. **These functions and a public `Weak` type are not implemented.** A scoped
event-registration API is also a design sketch, not a runnable library example.

For example, a callback printing a resource's name could handle a missing weak
target by reporting “source has gone.” If it must keep the resource alive until
the job completes, it instead needs an independent operation owner. Silently
weakening the capture would change the program's behavior.

Weak handles alone do not prove cycle freedom: an acquired strong owner could
be stored back into a cyclic relationship. The proof must cover later retention
as well as initial capture. Diagnostics should distinguish a known cycle from
an unproved lifetime and suggest borrowing, a scope or weak access as appropriate.
Some safe programs may need more information before the compiler accepts them.

Swift leaves strong-cycle breaking to programmers; fwp's proposed checked policy
would be stricter. See [Swift's ARC guide](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/AutomaticReferenceCounting.md).
This policy cannot prevent a program deliberately growing a live collection,
prove task termination, or replace a foreign library's own lifetime obligations.

[Lesson 23](tutorials/23-ownership-scopes/README.md) exercises a scoped event
callback, a channel worker, a cancelled background task and a graph with node
deletion using existing APIs. The scoped callback models the ownership direction
needed for subscriptions; it is not a persistent subscription API. Checked ARC
diagnostics identify the payload field/container/capture path that lacks a
proof and suggest data queues or independently owned handles. They do not claim
that merely having such a type creates a cycle. Keep ordinary inference and pipes. For today's runnable behavior,
see [tasks and channels](tutorials/06-tasks-and-channels/README.md) and
[recursion and sharing](tutorials/22-recursion-and-sharing/README.md).

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
host roots. Checked ARC admits native executables, synchronous WASI executables,
and C libraries with checked copying boundaries, described below.
The browser-loader and asynchronous WASI extensions accepted in PR #164 also use
these ownership checks. [Checked ARC delivery](#checked-arc-delivery) records
their passing evidence under Node and the remaining browser-engine coverage gap.

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
| Closures | Owned captured arguments and typed call metadata; eligible functions with only fixed function captures use static records | Runtime-data captures retain ordinary ownership; retained unknown callbacks are not checked ARC |
| Tasks and channels | Counted handles/results/queues; ARC admits acyclic nested channel types and proved captures, including shared sockets | Other resource-bearing or unknown queued captures, HTTP stream payloads and recursive channel ownership remain unproved; [direct task messages](measurements/task-channels.md) passed PR #190 |
| Derivative tapes | Scoped owners and a bounded numeric workspace | Raw unscoped tape calls are not checked ARC |
| External/network state | Explicit resource teardown where modeled | Freeing a C buffer does not prove the lifetime of every referenced fwp value |

Fresh numeric result trees also need ownership before their first reference
can be released. Native heap allocations already have an empty count slot;
WASI allocations acquire their external slot when claimed. Native libraries use
the native allocator even though they do not scan host roots.
Generated ownership helpers distinguish those cases. An absent external slot is
not proof that a freshly allocated wide integer is immortal. Physical storage
checks and a control restoring that mistaken early return cover this boundary.

## Compact set storage

`["b", "a", "b"] | set.from-list` makes `set{"a", "b"}`: each distinct key
appears once, in sorted order. A native set now stores its length followed by
one eight-byte slot per key. Maps retain two slots per entry, including maps whose values
are `()`. The interpreter also distinguishes sets from maps; this distinction
lets compile-time constants use the correct native layout.

Inserting or removing a key can reuse uniquely owned storage. If an older value
is still live, the result owns a separate container and shares keys through their
typed ownership operations. Dropping a set releases each managed key once;
inline integers need no retain/release. The change removes empty value slots,
not the remaining container allocation or necessary sharing.

`tests/map_set_ownership.rs` checks actual allocation requests and rejects a
control that restores wasted slots. Existing failure-injection tests cover
partial construction, updates, aliases and cleanup. Constants, nested sets,
JSON, text/binary decoding, hashing and WASI have regression coverage.
[Measured storage](benchmarks.md#compact-set-storage-measured-allocation-size)
records six-host byte counts and the binary inspection, separately from timing.
[PR #172](roadmap-history.md#compact-set-storage-pr-172) records full acceptance.

## Cached numeric map reads

A top-level computed map has a cache owner, released at program teardown. For
example, this builds a map on first use and returns its value at key 1:

```fwp
table : Map[I64, I64]
table = [(1, 7), (2, 9)] | map.from-list
lookup = flip map.get table | option.unwrap-or 0
main = 1 | lookup | echo
```

`map.get` returns `Some value` for a present key or `None` for a missing one;
`option.unwrap-or 0` extracts that value or supplies zero. This prints `7`.
The compiler can borrow `table` for the lookup instead of acquiring another
owner. The cache keeps the map alive throughout that read.

This optimization currently covers `map.get` and `map.size` on maps of immediate
numeric keys/values (integers up to 64 bits, F32 and F64). It needs a proved
non-suspending read span: no unknown call, escaping map value or potentially
reentrant cleanup while a later read still needs the borrow. Other uses keep
their existing ownership requirements. There is no new syntax or implicit copy.

Initialization keeps its original effects and failure timing. If initialization
reenters and replaces an earlier cached result, the old cache owner releases;
independent callers retain their own owners. A failed first read unwinds caller
owners. A borrowed local never releases the cache's owner. Returning a tuple or
variant after the read preserves eligible direct-field results without an
intermediate box. `tests/cached_map_borrows.rs` checks these paths, including
reentrant aliases, deliberate missing-cleanup controls and raw-interpreter
agreement. [Measurements](benchmarks.md#compiler-proved-cached-map-reads) separate
count savings from timing;
[PR #167](roadmap-history.md#interactive-tools-and-cached-map-borrows-pr-167)
records acceptance.

## Ownership boundaries

A boundary is a call where ownership passes between functions, the runtime,
foreign code or a remote service. Every contract distinguishes:

- **Borrow:** use a value for this call while its caller remains responsible.
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

Typed channel sends now consume one message owner while borrowing the channel
handle. A successful queue insertion transfers that owner without a retain.
The compiler retains a separate owner first when an independently live alias
needs the same value. Closed sends, native sinks, traps and cancelled waits release
the consumed message; a sink borrows it only during its callback. Failed queue
growth leaves no queued message. A failed receive allocation keeps the queued
owner intact for retry. These changes passed native/WebAssembly checks and
[production acceptance in PR #175](roadmap-history.md#function-queues-and-cheaper-sends-pr-175). [Measured baselines](measurements/channel-transfer-protocol.md)
show why the previous retain was avoidable for fresh messages.

The accepted [receive-result implementation](measurements/channel-receive-results.md)
passes an immediately matched result as separate tag and payload fields, avoiding
its `Some` allocation. Whole-value uses keep boxed results; both forms transfer
the same queued owner. Boxed allocation must precede dequeue so failure permits
retry. It also repairs that order in the uncounted tracing path.
Its selected two-word result has audited text-message allocation savings on both
Linux architectures and [complete production acceptance](roadmap-history.md#receive-results-without-temporary-wrappers-pr-177).

Counting cannot reclaim an unreachable cycle by itself. For example, a channel
can contain a queued value holding that same channel. Closing it must preserve
queued values for later receives. Explicit draining breaks the tested cycle;
losing the last external handle without draining does not. Today, tracing handles
unproved cycles in native tracing mode; checked ARC rejects them. This is the
current limitation, not permission to introduce tracing into future ownership rules.

Checked ARC admits channels carrying numbers, strings, records, recursive
immutable lists or variants, and nested channels whose types cannot form an
owning cycle. For example, `Channel[Channel[String]]` can hold a string channel:
the inner queue holds only strings, so it cannot refer back to the outer queue.
`Channel[List[Channel[String]]]` is also accepted. A recursive immutable tree
with string-channel leaves is allowed; recursion alone is not an owning cycle.

For each channel type, the compiler follows payload, record and variant fields,
including nested containers. Reaching the same channel type again means the
types permit an owning cycle, so the compiler rejects that relationship. For
example, `Link = | Node (Channel[Link])` is still rejected even if a particular
program would drain every queue. This is a missing proof about all executions,
not a claim that every value of `Link` is cyclic.

HTTP stream handles remain excluded: their connection-owned handler can lead
back to the queue. Functions need the capture and call-scope checks below.
The [task-message extension](measurements/task-channels.md) follows each known
task's computation and result owners; its result type alone cannot reveal a
captured queue. Unknown producers remain rejected. These flow checks supplement
the payload-type check without new runtime fields, weak handles or draining.
The payload-type search visits a reachable type once; checking C channel types in a
graph of V types and E field links takes at most O(C × (V + E)) graph visits.
The compiler checks each channel separately so an outer queue cannot hide a
cycle in an inner one. This remains a conservative eligibility rule, not a ban
on ordinary tracing channels.
Closing an admitted channel still preserves queued messages for receiving.
Releasing its last owner destroys the remaining queue and its typed contents;
cancelled blocked operations release their wait registrations and owners first.

### Moving a sole matched payload

A variant such as `Some text` owns its payload, here a string. When the variant
already lives in local fields and its match arm immediately retains `text` and
releases the variant, the compiler transfers that existing owner instead.
Another live alias of the string keeps its own owner. The rule requires one
directly bound payload, adjacent count operations and no protected resource slot;
boxed variants and other shapes keep their existing cleanup. It does not alter
which channels or function captures checked ARC accepts.

[The measurement](measurements/channel-variant-moves.md) removes one retain per
fresh-text/fresh-function/shared-text message and two per shared-function message.
Allocations and peak charged storage are unchanged. Focused Linux checks pass,
including independent aliases and a deliberately leaked-owner control. Broader
ownership checks pass on all six native platforms and both WebAssembly hosts.
[PR #179](roadmap-history.md#matched-payload-moves-and-direct-call-borrows-pr-179)
records production acceptance.

### Borrowing across direct calls

Direct-call borrowing passed
[PR #179 acceptance](roadmap-history.md#matched-payload-moves-and-direct-call-borrows-pr-179).
A **direct call** names a function known to the
compiler. When that function uses an argument only during the call and does not
store or return its counted storage, the caller can keep ownership throughout
the call. Every caller must already need the same counted values afterward.
Last-use inputs retain their consuming convention, so borrowing does not keep
their storage alive longer than the original callee needed it.

For example, in the [text-channel program](../tests/fixtures/channel_transfer_text.fwp),
`exchange` takes a tuple containing a channel and an integer. It creates a string,
sends it, receives it and checks its length. The loop keeps the same channel for
the next exchange. Giving `exchange` another channel owner would add a retain
and release per message; borrowing uses the loop's existing owner instead.
The source signature and pipe syntax stay unchanged. Removing retains does not
remove allocation, destruction or all runtime ownership checks.

This requires more than seeing a channel of strings. Native channels can also
hold callback context whose destruction is observable. The proof therefore
requires every live caller to use that same channel after the call; later use
of another tuple field does not qualify. Resource captures, recursive workers,
unknown calls and escaping arguments retain their existing ownership rules.

The proof also permits borrowing a handle whose queue contains
functions. It borrows the channel itself; it does not borrow, move or grant
permission to store its messages. The caller's continuing owner keeps the queue
and its native callback context alive. The separate checks for queued captures,
cycles and State/autodiff scopes still apply in ARC mode. Resource scopes still
prevent selection. The [function-channel measurements](measurements/function-channel-borrows.md)
record passing focused Linux checks, including native-context destruction.
[PR #180](roadmap-history.md#function-channel-borrows-and-integer-text-pr-180)
records full production acceptance of this extension.

Failure or cancellation releases caller-owned storage through the caller's
cleanup scope. Generic function entries still consume their inputs, including
boxed tuples. Tests exercise these boundaries with independent aliases,
collector stress, reuse poisoning and an intentionally leaked-owner control.
An ARC case checks complete reclamation after an exchange fails. Passing those
focused Linux checks and [binary measurements](measurements/channel-direct-borrows.md)
show zero retains per fresh-text exchange; the handle extension also removes
the fresh-function exchange's remaining retain. Allocations and peak charged
storage are unchanged; shared cases retain their measured costs.

A temporary local name can also borrow the original storage directly. The
compiler checks later reads through enclosing bindings and matches, so a
temporary name inside a match's input can borrow a channel still needed in its
selected arm. Another field's later use does not qualify. Consuming/unknown
calls, escaping aliases and resource scopes keep their existing ownership.
The [local-borrow measurements](measurements/channel-local-borrows.md) remove
the closed-send loop's final retain and one of three shared-text retains,
with unchanged allocations and peak charge.
Native tests cover normal return, failure, cancellation, independent aliases and
deliberately broken cleanup. [PR #181 acceptance](roadmap-history.md#temporary-channel-borrows-and-failure-cleanup-pr-181)
records passing production checks on all six native platforms.

### Functions stored in channels

[PR #175](roadmap-history.md#function-queues-and-cheaper-sends-pr-175) records
passing native, WebAssembly and production checks for this subset. A partial
application such as `add 3` is a function that adds three to its next input. It
keeps the integer `3` as a **capture**, a value saved for the later call. Storing
that function in a channel cannot create a cycle through this integer. Receiving
it and applying it to `5` produces `8`; the interpreter already supports this.

Here `tap` sends while keeping the channel as the pipe's value. Receiving returns
an `Option`: `Some` for a message, or `None` for a closed, empty queue.
`option.map (apply 5)` calls a received function with `5`, when one is present.

```fwp
callbacks : I64 -> Channel[I64 -> I64] ! {Async}
callbacks = channel.make
main = callbacks 1
    | tap (flip channel.send (add 3))
    | channel.recv
    | option.map (apply 5)
    | echo
```

It prints `Some 8`. The `1` is queue capacity; `flip` puts the message before
the piped channel in the send call. No ownership syntax is added to this program.

The type `I64 -> I64` describes input and output, not captures. Another function
of that type could retain the sending channel. Accepting all functions with this
signature would therefore be unsafe. The implementation uses two linked checks:

- Identify each possible stored function and its captures, following returned
  functions, nested containers and partial applications. Follow owning captures
  back toward the queue; reject unproved or cyclic relationships. Runtime-created
  closures and foreign producers need contracts too. No known producer is not
  the same as a proof that a function captures nothing.
- Carry those possible functions through sends and receives. Check State and
  autodiff operations in the scope where the received function runs. A queue
  must not silently extend the lifetime of the sender's temporary scope.

`src/arc.rs` follows channel payload types. `src/arc_scope.rs` connects sends and
receives and tracks each known function with its number of supplied arguments.
It also records an explicit unknown source: combining it with a known function
does not make it known. Captures, calls, queues and caught error payloads are
revisited until no set gains another target. This is a finite, conservative
analysis of the specialized program, not execution of the program.
An empty origin set means no function value reaches that path, as when mapping
over an empty collection of functions. It adds no call target. This differs from
an unknown source, which remains a rejection even if known functions reach the
same path. The compiler must explicitly mark unmodeled runtime and foreign
producers as unknown; an empty set must not stand in for missing analysis.

The accepted subset allows immutable scalar, string and container captures,
including other functions whose captures pass the same check, and shared
`UdpSocket`, `Listener` and `Conn` handles. The [socket checks](measurements/queued-callbacks.md)
passed on Linux, macOS and Windows, each on ARM64 and AMD64.
These handles share a socket, but cannot own language values, callbacks or queues.
A queue therefore cannot lead back to itself through one of these handles.
A closure keeps its captured handle alive; receiving transfers ownership, dropping
an undrained queue releases it, and releasing the final socket owner closes the
OS descriptor. Explicit close still affects every alias.

The data-queue extension tracks queue creators. It admits a callback capturing
a queue from `channel.make` only when its payload
cannot contain functions and its nested queue owners have known sources. Unknown
producers remain rejected as captures, including when mixed with
known creators. Recursive queue types still fail the separate cycle check.
The [cleanup checks](measurements/queued-data-channels.md) pass on all six native
platforms and both WebAssembly hosts.
[PR #185](roadmap-history.md#queued-callbacks-retaining-data-queues-pr-185)
records full production acceptance.

The service extension admits one known native producer: a served gRPC method's
response channel. Its stream and connection own protocol data, without an owning
path back to a language callback. A retained callback keeps that transport alive
until it is released. This does not grant the same contract to arbitrary external
channels. [The service example and checks](measurements/queued-grpc-responses.md)
explain this distinction and record what has been verified.

The [task-handle proof](measurements/queued-task-handles.md) follows known task
computations and results, including whether a result can own its producing task
through a returned callback. [Direct task messages](measurements/task-channels.md)
use the same proof, with separate classification of unknown queues. Both passed
[PR #190](roadmap-history.md#queued-task-owners-and-callback-transfers-pr-190).
Unknown task producers remain rejected.

For example, an event can retain a text queue until someone calls its `read`
function. `Channel[String]` stores text; `Channel[Event]` stores records containing
a function. The `Async` effect allows these operations to wait for a message or
space. Both queues below have capacity one.

`curry` turns a function taking a tuple into successive single-argument calls.
Here `read-text queue` saves the queue and returns a function waiting for `()`;
`.0` selects the queue from that pair. `make Event { read = id }` wraps this
function in the record's `read` field. `id` keeps its input unchanged.

```fwp
Event = { read: () -> Option[String] ! {Async} }
texts : I64 -> Channel[String] ! {Async}
texts = channel.make
events : I64 -> Channel[Event] ! {Async}
events = channel.make
read-text : Channel[String] -> () -> Option[String] ! {Async}
read-text = curry (.0 | channel.recv)
event : Channel[String] -> Event ! {Async}
event =
    tap (flip channel.send "hello") | read-text | make Event { read = id }
main =
    texts 1
    | event
    | both (const 1 | events) id
    | tap (fork channel.send .0 .1)
    | .0
    | channel.recv
    | option.and-then (.read | apply ())
    | echo
```

`both f g` builds a pair from two uses of the same input. `const 1` ignores that
input and produces the capacity, so the pair contains a fresh event queue and
the event. `fork channel.send .0 .1` sends the pair's second value into its first;
`tap` keeps the pair afterward. Receiving the event and calling its `read` field
receives `"hello"` from the text queue. `option.and-then` runs this call only for
`Some event`, without nesting another `Option`. The output is `Some "hello"`.

The ownership chain is event queue → event → text queue → text. Text cannot refer
back to either queue. A second read would wait while the text queue is open and
empty: retaining a queue does not duplicate its messages. This example passes
raw interpretation; the native fixture checks this pattern alongside failure
and cancellation.

`File` is different: source type checking already forbids capturing this
single-use resource in a reusable function. Pass the file as the final argument;
removing a queue rejection cannot make repeated file use legal. Captured channels
and tasks outside the proofs described above, HTTP/2 streams and gRPC cells
still need ownership contracts. Functions in a queued list or record
receive the same checks as functions queued directly. Empty containers need no
invented callback. Unknown external function-bearing queues remain rejected.

Queues with the same concrete payload type share a possible-target set. Aggregate
fields also share a set, and caught errors are combined conservatively. These
choices can reject safe programs with unrelated owners or scopes; they must not
accept an unproved capture. When a value is used as a function, its checked type
excludes incompatible targets from neighboring fields; unknown sources remain
unknown. For example, a scope wrapper taking a function must not be confused
with that function taking an integer. Comparing recursive record types visits
each pair once; revisiting a pair does not skip checks on its other fields.
More precise analysis can reduce other rejections
later without changing source syntax. Native constructors need an explicit source
model; an arrow type alone never proves capture freedom. A received gRPC
iterator contains a continuation that keeps the network stream alive. The
analysis follows its ordinary constructor and rejects that captured stream owner
in a queue, even though the iterator's public type does not name the resource.

Acceptance needs scalar/string captures, returned and nested callbacks, aliases,
undrained/closed queues, failure, cancellation and repeated bounded-live work.
Reject self-queue and two-queue cycles, hidden captures, unknown foreign producers
and calls outside a required State/autodiff scope. Keep task and HTTP-stream
payload restrictions until their hidden owners have separate proofs. Compare
interpretation, native ARC/tracing and WASI, including cleanup counts and controls
that deliberately omit a release. This targets a provable subset, not perfect
cycle inference for arbitrary programs; it adds no proposed surface syntax.

The [socket queue regression](../tests/fixtures/queued_sockets.fwp) uses an
`Event` record containing a `check` function. This function captures a socket and,
when called with `()`, returns whether its address is available. The queue owns
the event after the creating function returns. Receiving and calling it twice
should produce `True` both times. Explicitly closing a retained UDP alias instead
makes it return `False`. Other cases drop undrained queues, catch a failure and
cancel a blocked sender. Native tests count live socket objects over 64 rounds,
check complete ARC teardown and deliberately omit queue release and socket close
to check the leak detectors. Counters are inserted by the tests into generated C;
ordinary programs keep the existing runtime and shared ownership costs. The
[evidence guide](measurements/queued-callbacks.md) explains the counters, controls
and inspected binaries. These are correctness checks, not performance measurements
or a bound for arbitrary applications.
[PR #184](roadmap-history.md#queued-socket-callbacks-and-handler-inference-pr-184)
records production acceptance.

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

## Value decoders

A decoder turns encoded bytes or text into ordinary language values.
Balanced-ternary conversions, URL/form decoding and HTTP-head parsing have
explicit owners for their results. Complete and partial results must be
released without relying on a later collection.

The decoder subset passes focused checks on all six native hosts at `30399066`
(`38886033175`). Actual WASI checks cover its available ternary/text helpers at
`72321a55` (`38884843627`). These focused results precede the combined batch accepted in
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153). [Earlier allocation evidence](measurements/value-decoders-2026-10-16.json)
retains the six-host ternary/text counts and the neighboring Windows failures
that were subsequently repaired.

Compressed bytes and WebSocket frames are also decoding boundaries. Their native
implementation owns copied bytes/text and result wrappers, including malformed
input results. Compression encoders protect native output buffers if language
result allocation traps. Tests count native buffers separately from managed
storage and deliberately omit cleanup to check detection. This covers synchronous
conversion of bytes already in memory; socket, server and retained-callback
lifetimes remain separate work. These helpers are unavailable on WASI.

Ternary list conversions traverse borrowed inputs directly and build owned
lists. Packing writes the result bytes directly. Partial lists have cleanup if
node allocation fails. Counts remain bounded by the available input bytes;
invalid widths and oversized digit lists retain their existing optional results.

URL decoding protects its temporary byte buffer and completed result fields
until the outer optional value owns them. HTTP parsing copies names/values into
owned header pairs and lists, without temporary line-index or value arrays.
It reads headers from last to first while prepending them, preserving source
order and the existing single invalid-header error. Parse rejection and allocation
failure release completed fields and buffers. Input text stays borrowed and
unchanged. Asynchronous connection lifetimes and retained callbacks remain
separate work; owning a decoded message does not prove those boundaries safe.

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

### UDP socket owners

A UDP socket owns an operating-system descriptor: a handle used to send and
receive datagrams. Unlike `File`, a socket can be copied and captured by a
function. Copies refer to the same socket. Explicit `udp.close` closes it for
all copies, and releasing its final owner also closes it. A closure, record or
suspended task that holds the socket must keep it alive until its own original
scope ends. Returning only an address string does not keep the socket alive.

The UDP implementation preserves those original scopes before optimization,
uses a separate 64-bit logical owner count for descriptors, and owns both fields of a
received `(Bytes, String)` pair while constructing it. The socket count is aligned
in the common header. TCP/TLS stream handles keep UDP headers the same
size while giving stream handles a separate TLS field when needed. Failure releases completed
fields and temporary receive buffers. Closing a Linux descriptor wakes its waiting
tasks and releases its polling records; synchronization after wake does not
recreate a closed descriptor's record. Disabling physical frees still closes the
socket when its logical owners finish. Library teardown closes retained sockets
without taking ownership of host sockets.

All six focused native jobs and both shared-runtime WASI regression jobs pass;
[the UDP report](measurements/udp-ownership-2026-10-16.json) retains the exact
results and an ARM64 binary inspection. [PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
supplies the passing full production acceptance. This does not establish whole-language GC removal. Opaque
function types do not describe their captures, so programs using UDP currently
preserve possible closure-holder frames conservatively. This may prevent some
optimizations; there is no zero-cost or throughput claim. Tracing programs retain
weak finalizers for unproved sharing, while checked ARC must prove ownership and
exclude tracing from its binary. The
[gRPC extension](#checked-grpc-clients-and-services) covers checked remote calls;
arbitrary retained host callbacks and mutable cycles remain separate work.

### TCP and TLS socket owners

TCP connections and listeners have logical socket owners. Copies share a handle; explicit close affects every copy, while the
last owner closes the socket automatically. Function and task captures preserve
the original lifetime. Returned optional connections, bytes and certificate text
keep their partially built values alive and release them on allocation failure.

For example, the following helper returns an address string. `()` is the unit
value, used when there is no input data. `const` makes a function that ignores
that input and returns the address text. Port `0` asks the operating system to
choose an unused port. Each `|` passes the previous result to the next function.

```fwp
address : () -> String ! {Network, Error[IoError]}
address = const "127.0.0.1:0" | tcp.listen | tcp.local-addr
```

The type says that `address` takes unit, returns a `String`, uses the network,
and can report an `IoError`. It creates a listener and returns its address.
The listener belongs to that helper's scope, so returning the string releases
it; the string itself does not keep a port open. In contrast, returning a
function that captures the listener keeps it open while that function lives.
The native tests compare both cases with the interpreter, including rebinding
the same port. For an application that needs a persistent listener, return or
retain the listener itself instead of only its address.

The common socket header stores a descriptor, a kind and a 64-bit owner count.
UDP and programs without TLS keep the previous header size. In a TLS-enabled
program, a stream handle adds a pointer to the TLS session or listener context;
that pointer follows the common header in the same allocation. This costs one
additional pointer for those stream handles, without a separate allocation for
the count. The passing ARM64 macOS TLS executable requests a 24-byte stream
header: the count is at byte offset 8, and the TLS pointer is at byte offset 16.
The plain TCP executable requests 16 bytes. These sizes describe the handle,
not all memory used by the allocator, operating system or OpenSSL. [The TCP/TLS report](measurements/tcp-tls-ownership-2026-10-16.json) records
passing focused checks on all six native targets and actual WASI shared-runtime
regressions. [PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
records full production acceptance on the final combined revision.

ARC executables omit the finalizer-table lookup during socket release because
they never register these sockets in that table. Tracing programs and unloadable
libraries keep the lookup so they cannot later finalize reused storage. This
removes a specific unnecessary operation; it does not remove all count or
allocator metadata costs. These socket owners support checked ARC. The
[gRPC extension](#checked-grpc-clients-and-services) adds separate ownership
proofs for remote service graphs.

## Releasing long chains

An owner must release a value's children when its last reference disappears.
For a long sequence, recursively calling one cleanup function per node can
exhaust the machine stack even when there is enough heap memory. Ordinary lists
already use a cleanup loop. The compiler now also follows a final owned field
through records and variants with one nonempty constructor, such as `Option`,
when that path returns to the starting type. `Option` represents either no value
or one present value; a tuple can hold both a payload and the next node.

At every wrapper, a remaining alias stops destruction of its children. Releasing
the final alias later resumes ordinary typed cleanup. The compiler emits these
steps directly, without a heap work list. This covers the measured record →
optional value → next record and record → optional value → tuple → next record
paths. It does not make every branching recursive graph use constant stack space.
Existing direct list-tail handling and `FWP_FREE=0` count-only behavior remain.

[The six-platform comparison](benchmarks.md#stack-use-when-releasing-wrapped-chains)
checks up to 16,384 links, retained aliases at each wrapper and complete physical
reclamation without tracing. Real source programs match the interpreter and
also pass GC/reuse stress. [PR #155](roadmap-history.md#shared-remote-reads-and-bounded-chain-cleanup-pr-155)
records production acceptance.
Reference-count operations and the chain's allocations still exist. Native remote
stream caches use a separate runtime cleanup loop; their request and connection
owners are described [below](#received-iterators-and-remote-call-storage).

## Failed map and set operations

A callback can fail after producing some results. Allocation or reference-count
acquisition can also fail after earlier fields were acquired. Those completed
fields still need owners: catching the error must release them without changing
an independently retained input map.

The repair accepted in [PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
registers cleanup for partial maps, lists, pending fields and
temporary arrays. Insert, remove and update consume their map argument, including
on failure; decoding transfers that owner before insertion. A partial map records
each acquired key before acquiring its value. Result cleanup uses the output
value type, so mapping strings to integers never treats integer bits as pointers.
These are compiler/runtime rules, with no new language syntax or heap wrapper.
The [six-host report](benchmarks.md#cleanup-after-failed-map-and-set-operations)
checks each allocation/retain failure across 22 operations, independent input
aliases and callbacks that change the value type. All 66 focused tests pass on
Linux, macOS and Windows, each on ARM64 and AMD64. Actual checked-ARC executables
exclude tracing functions and report zero counted bytes at shutdown.
All nine production jobs and documentation pass; the linked history records
full acceptance separately from the focused memory checks.

## Checked ARC delivery

`fwp build --gc arc` checks the supported ownership contracts and excludes
tracing code. It rejects unproved ownership instead of silently retaining it.
Ordinary counted freeing must remain enabled; tracing stress and reuse poisoning
are diagnostic modes incompatible with ARC.

Native ARC preprocessing omits marking, root scanning and sweeping, including
their scheduler and Windows fiber helpers. This must hold even at `-O0`: GCC
previously kept unused tracing functions that Clang removed. Typed finalizers,
explicit destruction and scheduler stack-position helpers remain. The
[delivery history](roadmap-history.md) records accepted revisions; binary checks
cover ARC exclusion and an ordinary tracing control.

| Entry or boundary | Implemented contract | Evidence and limits |
|---|---|---|
| Native main, function executable, CLI | Each entry proves its own state/derivative scopes and releases owned results | [Reference](reference.md#checked-reference-counting) |
| Native C libraries | Copy supported inputs; return scalars or explicitly released strings/records | [PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165); manual-pointer extension under validation; retained callbacks excluded |
| gRPC clients/services | Typed input/result owners and checked iterator handler lifetimes | [Details below](#checked-grpc-clients-and-services) |
| HTTP clients/servers | Own connections, requests, copied responses, handler captures and tasks | [PR #162](roadmap-history.md#http-client-owners-and-complete-connection-keys-pr-162), [#163](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163) |
| Generated REST/MCP | Same checked entries, including aliases, errors and normal shutdown | [PR #164](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164) |
| WASI and browser-loader modules | Counted values and command-end task/scheduler cleanup | [Module evidence](benchmarks.md#webassembly-task-and-browser-loader-ownership); loader tested in Node, actual browser engines remain unverified |

These accepted paths still allocate and count references. Default native mode
still includes tracing; general removal is a [project goal](../PLAN.md).
The JavaScript host owns its instances, promises and copied strings independently;
removing fwp tracing does not remove that host's collector.

### HTTP ownership

Client connections have independent pool, caller and I/O-task owners. Socket/TLS
ownership transfers only after connection allocation succeeds. A request keeps
its stream alive until the copied response is ready or the call fails.
Failure/cancellation notifies the peer before releasing request storage.
Response strings, headers and partial lists own each completed field; returned
responses never borrow network buffers. Complete pool keys include long TLS options.

On the server, a stream handle owns request/connection storage and may survive
its handler task. Its allocation also holds the task payload. Active requests
and dispatch lists own streams. One retained handler per connection keeps its
captures alive until child tasks finish; individual jobs borrow it. HTTP callbacks
run in fresh task scopes, without inheriting an active State or derivative handler.

ARC rejects channel payloads containing HTTP stream handles, including nested
ones: a handler could otherwise queue its own handle, creating the cycle
`channel → handle → connection → handler → channel`. Ordinary returned aliases
remain allowed. [Client](benchmarks.md#http-clients-without-tracing) and
[server measurements](benchmarks.md#http-server-ownership-and-memory) explain
bounded measured storage, remaining per-request costs and sampling exclusions.

### WebAssembly ownership

Build with `fwp build --gc arc --target wasm32-wasi app.fwp -o app.wasm` and the
[required toolchain](reference.md#targets). Counted objects use an external
count table and typed destructors. The last owner removes its entry and frees
storage; this still costs metadata, lookups and allocation. An escape into
permanent shared retention traps. Native-library flags with a WebAssembly target
are rejected. Each browser-loader invocation owns a separate module instance;
output callbacks receive copied strings.

Tests compare actual O1/O2 modules with raw interpretation, including repeated
collections, closures, failures, scoped derivatives and task cancellation.
Independent allocation ledgers observe cleanup; deliberately omitted frees/cache/
scheduler shutdown must fail. Freed blocks are reusable, but WebAssembly memory
capacity does not shrink. See the [module report](benchmarks.md#webassembly-task-and-browser-loader-ownership).

### C library results and foreign calls

Scalar inputs copy by value; strings copy into language-owned storage. Supported
records contain those input types. Scalar results copy all their bits before
language temporaries release. Strings and flat records containing strings return
with explicit owners.

For example, an export `greet` returns a string with a generated
`fwp_release_greet(result)` function. Call it exactly once with the complete,
unchanged result before unloading the library. A record's function releases all
string fields, including aliases. Copying pointer bits creates no new owner.
Do not use C `free`, mutate returned bytes or use released values. Serialize host
calls and releases; concurrent entry is outside this contract.

Unique results transfer ownership without a string copy or extra retain. Eligible
compiled record returns pass fields directly without a box. Other record returns
release their temporary box after transfer; shared fields retain the independent
owners needed by C. All conversions finish before transfer: embedded NUL traps
rather than truncating text, and a failed field conversion frees partial results.
Every export proves its own entry scopes. The same release interface applies to
tracing libraries. Rebuild callers/libraries together; there is no compatibility
adapter. Input strings still copy even for read-only calls; borrowing them needs
a proof that no result/capture can outlive the call.

Scoped foreign calls can borrow strings/bytes and copy supported scalar/record
values. Synchronous callbacks run on the calling task before C returns; C must
copy borrowed data before keeping it. Foreign strings copy into fwp-owned values.
The manual-pointer extension admits `Ptr[T]` and `Option[Ptr[T]]` in native calls,
callbacks and exports. Its cross-platform validation is tracked in the
[handoff](development-state.md). A pointer copies an address, never an owner of
`T`. ARC releases any surrounding option or record, but neither follows nor
frees the address. This also applies when `T` names an opaque host type.
Callbacks returning managed C strings remain rejected: their result needs a
separate host-retention contract.

The programmer must keep raw storage valid, synchronize concurrent access and
release it with its matching allocator. `mem.alloc` and `mem.string` require
`mem.free`; borrowed host pointers must not be freed. `ptr.read-string` copies
bytes into an owned fwp string. `Unsafe` records these obligations without
proving them. A caught failure needs an explicit cleanup path; a raw allocation
is not automatically reclaimed on failure or cancellation. Do not use raw
addresses to smuggle managed fwp owners past the cycle or callback checks.

C receives managed `String`/`Bytes` storage only for the call. It must not return
or retain that address as a raw pointer. If C returns an alias into its argument
(as `strchr` does), pass an explicitly owned raw buffer and copy the result
before freeing it. Returning a `String` instead copies the result before the
borrow ends. See [C interop](tutorials/09-c-interop/README.md).

### Owned library values

The [primitive contracts](primitive-ownership.md) are the detailed inventory.
The following rules explain common boundaries:

| Operations | Ownership and observable behavior |
|---|---|
| `list.transpose` | New nodes own typed aliases of original elements. Protect partial columns/cursors on failure; stop at the shortest row. Scratch grows with rows plus columns. |
| Console, arguments, environment | Return copied strings/lists; protect partial results. Preserve UTF-8 replacement, CRLF and EOF behavior. Environment names with embedded NUL return `None`. |
| Directory/environment snapshots | Own copied strings, pairs and nodes; release scratch and OS handles on failure. |
| Files and metadata | Own returned strings/bytes/records. Ordinary file actions borrow paths/data; write/close errors remain visible. `file.write-new` replaces or creates, not exclusive creation. |
| Working directory | Return a counted string or `IoError` of kind `cwd`; do not substitute `"."` or truncate paths. |
| Six dense F64 solvers | Borrow inputs, protect scratch and partial results, transfer completed outputs. QR checks output-size overflow separately. Arithmetic order is unchanged. |
| JSON/text/binary/CSV and CLI parsing | Own decoded fields, aliases, defaults, flags, errors and displaced map values. Freeing decoder scratch alone is insufficient. |
| Empty maps/sets | Immutable static storage needs no allocation/count. Insertion allocates an owned container; old aliases remain empty. |
| Boolean operations | Immediate tags need no storage/counts. |
| Clocks | `time.monotonic`/`time.unix` return counted Duration records; repeated calls free them. Avoiding those allocations remains work. |

### State, derivatives and processes

State operations need a proved handler. Returning a closure does not extend its
old handler's lifetime, though it can run under a new one. The checker follows
known targets, captures and stored values; unknown targets are rejected.
A partial application is a function with some arguments already supplied. The
proof keeps separate records of those saved arguments for calls inside and
outside a State handler. A plain fold must not acquire the State requirements
of another fold merely because both use the same `uncurry` helper. This does not
keep a handler alive: an escaped callback is checked where it is actually called.
Derivative tokens likewise do not extend tape lifetime. Stale, mixed or cross-task
tokens trap. F128/nested tapes own typed weights; scope exit, failure, cancellation
and library teardown release them. Workspace reuse is bounded and counted
separately from returned arrays. See [numerics](numerics.md#reverse-mode).

`rev.jacobian f` calls `f` once to count outputs, then once per output row to
compute derivatives. The counting pass has its own tape scope, just like each
row. Temporary tapes must be released before the next expression, including when
`f` creates a tape that it never uses. These scope repairs passed
[PR #191](roadmap-history.md#task-results-and-explicit-cpu-execution-pr-191), including the native
production gates and focused WebAssembly cleanup controls.

Process calls borrow arguments/input during execution. `process.run` and
`process.run-input` return owned status/output/error records; `process.call`
returns a status number. A nonzero child status is a result, while failure to
start/communicate raises `Error[IoError]` of kind `spawn`. Reject NUL arguments
before OS access. Protect copied output while constructing the result.

Cleanup frees pipes/buffers, reaps POSIX children or closes Windows handles;
unwinding before child completion terminates and waits for it. Calls are
synchronous; this does not promise cancellation responsiveness while waiting.
POSIX children receive normal SIGPIPE behavior. Parent writes temporarily block
SIGPIPE only on the calling thread, consume only a newly generated broken-pipe
signal, and restore the old mask/handler/pending state. Inputs never transfer
to the child. Tests cover large output, early child exit and forced OS failures.

Secret input returns an owned optional string; cleanup restores terminal echo
before unwinding. Native Windows console mode/width are queried directly;
redirected streams remain ordinary input. Validate descriptors before narrowing
to the OS integer type. Real terminal tests require a missing-restore control
to fail. [PR #149](roadmap-history.md#owned-processes-and-numeric-mapped-arrays-pr-149)
records platform acceptance.

## Structural hashing without temporary storage

`hash` returns a deterministic U64 fingerprint of a value's typed binary encoding.
Integer widths, floating-point bits, length prefixes and field order all contribute.
It uses FNV-1a, a non-cryptographic hash. The compiler's native implementation
borrows the input and feeds those bytes directly into the hash state, without
serializing the whole value into a temporary heap buffer. Packed array elements
remain borrowed views during the call; hashing does not retain or release them.

The interpreter's existing buffered encoding supplies an independent reference.
Native/WASI checks compare hashes across scalar widths and nested containers,
keep aliases live, count both libc and managed allocations inside hash calls,
and verify that restoring the old buffered implementation fails the zero-allocation
check. [PR #151](roadmap-history.md#synchronous-wasi-ownership-and-streaming-hashes-pr-151)
records acceptance; later numeric specialization is recorded in PR #174. These
correctness checks alone are not a timing improvement or C/Rust parity claim.

## Vector-library results

A `Vec[N, T]` currently holds an array inside a record; each array entry is a lane.
The native ownership path gives the result record and array one owner and
retains borrowed boxed integer lanes when they are shared. F128 arrays store their
128-bit payloads directly, so copying a lane does not retain a temporary scalar
box. Converting a correctly sized array to a vector retains that array; a wrong
length returns `None` without taking ownership. Partial arrays and wrappers are
protected until construction finishes, including arithmetic and allocation failure.

A reduction keeps one owned accumulator and releases each replaced boxed result.
A one-lane sum owns its returned reference independently of the input. These
changes preserve wrapping integer operations and existing division checks; they
do not promise stack-only vectors or hardware vector instructions. General
removal of tracing remains unfinished; checked ARC deployment limits still apply.

## Process metrics and syntax text

Metric snapshots and rendered syntax text have explicit value owners.
A metric registry stores names and numbers for a process or library instance.
Repeated updates of an existing name reuse that entry; distinct names require
more native storage. Process shutdown and library teardown free it. A snapshot
copies names and kinds into an immutable list of tuples: subsequent updates cannot
mutate an earlier snapshot. Construction now protects partial strings, tuples and list nodes,
without a temporary pointer array. This registry lifetime is separate from the
shorter lifetime of snapshot storage; it is not an allocation-free service claim.

Names use their complete byte length, including embedded NUL, matching interpreter
lookup and string sorting. Observation suffixes are compared and copied directly
without a temporary concatenated name. `syntax.show` borrows its syntax tree and
returns new text; its native formatting buffer is protected if result allocation
traps. Managed allocation fault tests, missing-cleanup controls, tracing stress,
checked ARC and actual WASI checks pass. Windows and POSIX library
unload tests verify registry release separately. The
[retained report](measurements/owned-values-and-kernels-2026-10-16.json) records
the artifacts and repaired test failures.
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
records full production acceptance.

### DNS result ownership

`dns.resolve` borrows its hostname and returns an owned list of copied address
strings. The native implementation releases the operating system's temporary
resolver entries on success and on recoverable allocation failure, and owns each
partially built list. It preserves first-seen order and removes duplicate address
strings without the previous 64-address cutoff. Both engines reject embedded NUL
bytes instead of passing a shortened hostname to the operating system.

The DNS tests compare real numeric and localhost lookups, then use a deterministic
resolver peer to check 81 distinct addresses and every result-allocation failure.
[DNS evidence](measurements/dns-ownership-2026-10-16.json) records six native
hosts passing, including 162 allocation-failure positions and deliberate omitted
cleanup. Both actual WASI jobs pass common-helper regressions; they do not test
DNS. The earlier owned-values/kernel report does not cover DNS. Retained
networking callbacks still need separate ownership work. This does not add WASI networking or prove faster DNS lookups.

TCP/UDP receive buffers and UDP-send resolver entries are also registered on the
runtime cleanup stack so cancellation and result-allocation failure can release
them. Failed native receive allocation traps before the buffer is used. These
repairs pass all six focused native hosts in `38898918147` at `7224b3de` and do
not establish socket-handle ownership; the separate socket rules and acceptance
above cover handles.

### Copied service data

A served request carries headers (name/value strings) and may identify a peer
certificate. `grpc.metadata` returns an independent list of incoming headers;
`grpc.peer-subject` returns copied certificate text when available. These output
values have ordinary owners, with cleanup for partially
copied fields if construction fails. Metadata preserves the input order and
duplicate names while omitting protocol headers; it builds directly into the
result list without a temporary array of pointers.

These rules cover copied results. Separate owners keep the service's connection,
stream and retained request context alive; their lifetimes and the checked ARC
extension are described [below](#checked-grpc-clients-and-services).

`http2.request` and `http2.body` also return owned results.
A request copies its method, path, headers, remote address and optional certificate
name; a body copies every byte, including zero and non-text bytes. The source
stream remains live during copying. Header order and duplicates are preserved,
and an existing `host` header takes precedence over `:authority`. Partial strings,
pairs, lists and result wrappers use the existing typed cleanup on failure.
Those accepted result-copy changes do not alone establish ownership of the
stream; the server extension above supplies that separate lifetime contract.
These copied results pass focused allocation-failure and lifetime checks on all
six native hosts at `e715de1a` (`38935341434`), followed by full acceptance in
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153).

Outgoing gRPC response headers and trailers also copy their input strings.
Normalization now happens in the owned copy: names become lowercase, and carriage
returns/newlines in values become spaces. This removes two temporary buffers
without changing input strings. The protocol layer now checks raw header
allocations and buffer-size growth before using them. Failed header construction
preserves earlier entries and frees its partial new strings; impossible sizes
and allocation failure retain the existing exit status 102. This is a bounded
allocation check, not a claim that protocol allocation failures can be recovered
inside a running service. Native controls pass on all six hosts in the same
focused run. Response-header capture also checks its own allocation: failure
traps before invoking the callback or installing the new context. Existing child
task, cancellation and counter-overflow tests remain active.

The [service-result report](measurements/service-values-2026-10-16.json) records
12 incoming-metadata, 2 certificate-name, 20 request and 2 body allocation-failure
points, each returning charged result storage to its baseline with collection
disabled. Raw protocol buffers are counted separately. Returned values still
allocate and typed cleanup uses stack records; this is cleanup evidence, not a
speed comparison or a measurement of total server memory.

Each partial-result cleanup record occupies 184 bytes, aligned to eight bytes,
on all six measured hosts. It keeps up to eight field values inline on the stack.
The instrumented ARM64 metadata, certificate, request and body functions use
448, 272, 624 and 288-byte stack frames respectively, including saved registers.
These are test-binary observations, not bounds on an ordinary server's total
stack use. The report retains the instructions used to read those sizes.

### Service settings, outgoing headers and callback results

`grpc.with-gzip` and related helpers run a callback with temporary service
settings; see [examples](services.md#settings-for-a-group-of-calls). Settings
live on the stack during that callback. A child task copies them into its own
record and retains independently live TLS/capture owners. Synchronous scopes
borrow those owners. Outgoing headers use one block for pointers/text; empty or
ignored lists borrow earlier settings. Check overflow before allocation and
release completed owners on error/cancellation.

The helpers borrow their callback and own its result. Header capture returns an
owned tuple of that result and copied header pairs; reverse construction keeps
order without a temporary pointer array. Every partial field has cleanup.
A forwarding function can return that owner directly when all paths forward the
same dynamic result, instead of unpacking and rebuilding an identical tuple.

The TLS-settings cache reads environment variables once per runtime instance.
It survives tasks/resource finalizers and releases afterward during library
teardown. Entry and full name share one allocation; no fixed-length truncation.
A construction guard frees an unpublished entry if settings allocation fails,
so a later retry remains possible.

The [baseline](measurements/service-context-baseline-2026-10-16.json) and
[owned/forwarded report](measurements/service-context-forwarded-2026-10-16.json)
compare 1/32/128 scope calls against identical plain state updates. Slopes between
32 and 128 calls exclude fixed setup. Collection is off. Compression/deadline
scopes drop from one allocation/64 requested bytes per call to zero; one outgoing
header drops 5 → 1 requests, and response capture 4 → 1. Returned charge becomes
zero. Earlier figures cover Linux AMD64; new counts agree on six native hosts.
These are fwp memory comparisons, with no speed or C/Rust baseline. Task records
grow to hold settings (1,512 → 1,584 bytes in the Linux AMD64 example).

The [stack-copy](measurements/service-context-stack-2026-10-16.json) and
[owned-scope](measurements/service-context-owned-2026-10-16.json) reports retain
intermediate costs and repaired Windows failures. [Iteration measurements](benchmarks.md#list-iteration-compared-with-its-previous-definition)
explain why `each` now avoids a discarded result list and how known callbacks
remove dispatch without repeating captured computations.
[PR #154](roadmap-history.md#service-settings-and-iteration-storage-pr-154)
records acceptance. Preserve aliases, inherited settings, returned functions,
all partial failures and deliberately missing-owner controls.

### Received iterators and remote-call storage

A remote call asks another process to run a function. A streaming response lets
the caller request values one at a time. fwp saves each received value so two
references to the same iterator position observe the same result, rather than
receiving two different messages. Keeping an earlier iterator keeps its saved
history alive.

The native cache now has typed owners: cleanup knows which fields are values
that need releasing. Reading a uniquely owned position transfers its saved
result; reading a shared position acquires another result reference. Cleanup
walks the position and its wrappers in a loop, stopping when another owner
remains. The receive source moves to the next unread position. Its error
description lives in that same allocation, so a completed calling scope cannot
leave a dangling description.

One task receives a position while other readers wait for its saved result.
Completion, failure and cancellation release that guard and wake waiters.
Cancelling a waiting reader leaves the receiving task running. Cancelling the
active client call still resets its request. The guard borrows task identities
from the scheduler and adds no allocation per element.

[Complete-client measurements](benchmarks.md#moving-captured-values-instead-of-retaining-them-again)
show constant remaining managed storage across 64, 1,024 and 16,384 consumed
integers in all six native environments. Retained history deliberately increases
peak memory until released. Five allocations per integer and extra reference
counts remain; this is not a zero-cost result. The measured region excludes raw
network buffers and whole-process memory.

Repeating calls exposed a separate lifetime: the request object itself.
[The repeated-call baseline](benchmarks.md#memory-left-behind-by-repeated-remote-calls)
leaves 240 managed bytes per additional call on every native platform, plus
unread message queues for partial readers. One connection is reused throughout.
This separates finished-request growth from the cost of keeping a connection
pool available.

PR #157 gives each client request references from its active
connection list, response source and detached sender. Dropping the source
releases unread messages without cancelling the remote operation. Later data
for that abandoned reader is discarded while maintaining network flow control.
The list keeps the unfinished request alive until completion, reset or connection
failure. Final release removes the collector finalizer, frees metadata and
releases request storage. All six focused native jobs verify complete request
and message release across 1/16/256 batches, with constant final managed storage.
[The comparison](benchmarks.md#memory-left-behind-by-repeated-remote-calls) records
the remaining allocations and reduced reference-count traffic. Infinitely many unfinished operations can still require
unbounded storage. [PR #157](roadmap-history.md#freed-requests-and-transferred-selected-fields-pr-157)
records native validation and full production acceptance.

The connection change separates an open socket from the information
kept about it. Each connection has two background tasks: one reads incoming
bytes and one writes outgoing bytes. These are its I/O tasks. A response reader
can still need the final error or completion information after both tasks finish,
so closing the socket does not by itself free the connection record. Its last
storage owner removes the collector's cleanup registration and frees that record
and its metadata. The pool, a cache of reusable connections, owns each connection
while it is available for another call. Calls and detached senders also keep
their own references.
The request record does not gain an owning back-pointer to the connection.

Client I/O task records have only the scheduler, which runs ready tasks, as owner.
Their storage releases after their stack and scheduler links are removed, without
task reference-count updates. Language task handles can have independent aliases and retain their
shared policy. Server task ownership is described below; the HTTP extension
is accepted in PR #163.
Library teardown first shuts down connections used by live I/O tasks, then waits
for those tasks to finish. This includes connections removed from the reuse pool:
canceling a task alone is insufficient while it defers cancellation to protect
transport state. A regression test must detect omitted shutdown within a fixed
deadline, instead of hanging the test job.
All six focused native jobs verify complete connection/request/message release
and constant final managed storage across the measured call counts. The
[comparison](benchmarks.md#freeing-closed-connections-and-finished-tasks) explains
the added connection count operations and remaining allocations. PR #158 passed
full production acceptance; [history](roadmap-history.md) records its merge.

Preserve these ownership relationships and their regression checks:

| Storage | Who keeps it alive | Accepted behavior and checks to preserve |
|---|---|---|
| Client request | The active connection list, receive source and detached sender hold references. | Accepted in PR #157; preserve completion, failure, cancellation and repeated-call checks. |
| Connection | The pool, readers/writers and callers hold separate storage owners; the socket has its own reader/writer use count. | Accepted in PR #158; closing a socket alone does not finish every borrow. Preserve the lifecycle checks. |
| Pending sender values | Each input cursor has a concrete iterator destructor and an independent owner. | Accepted in PR #159; preserve cleanup, aliases, failure/cancellation and stress/reuse checks. |
| Server callbacks and response channels | Serving jobs and retained iterators/channels own their request and connection records. | Accepted in PR #160; preserve partial construction and cancellation controls. Arbitrary escaped callback cycles remain outside the proof. |
| Task identities and wait lists | The scheduler owns parked tasks; request state borrows their identities. | Preserve this direction when adding owners; do not turn back-pointers into owning cycles. |

A detached sender sends iterator elements as requests described by compiler
metadata. Its unused function-encoder field and branch were removed in PR #157: the sole production caller always supplies that request
description. Native fixtures record its size and test request encoding across
errors and cancellation.

The server frees its job and task records and keeps temporary
argument slots on the serving stack. The job contains the service context; its
existing context-user count owns the whole allocation. Detached senders keep it
alive after the serving task finishes. Completion clears borrowed task pointers
before releasing the job. Unscoped internal tasks have one scheduler owner and
release without task reference-count traffic; scoped tasks keep the existing
shared policy. [Six-host storage measurements](benchmarks.md#freeing-finished-server-tasks-and-keeping-argument-slots-on-the-stack)
show fewer allocations with unchanged count increments.

Concrete generated destructors now release decoded arguments, complete returned
iterators, ordinary results and errors. Stack cleanup records protect partial
decoding, method failures, encoding failures and cancellation. A method receives
its complete argument array through its owning entry, without constructing a
temporary function object. The ordinary entry remains the explicit no-reuse mode.
[Linux measurements](benchmarks.md#freeing-method-arguments-and-results-linux-measurement)
record the memory reduction and mixed count/stack costs.

A native output channel's callback borrows each sent value until it returns.
The typed send owns and releases the message; a callback that keeps it must
acquire its own typed owner. The channel's payload lives
after the channel header in one allocation. The transfer change removes an unused
duplicate-function pointer; its native layout test requires 88 bytes, compared
with the earlier measured 96-byte header.
[PR #175](roadmap-history.md#function-queues-and-cheaper-sends-pr-175) records
passing platform checks; the smaller header does not reduce allocator charge.
Last-channel cleanup
releases request/connection references and then that allocation; construction
protects partially acquired references. Queue and callback cleanup use alternative
fields in the header, without another lookup on the send path.

The values/channel changes and complete request/connection ownership passed all
six native hosts, followed by full production acceptance in PR #160. The earlier
partial values-only stage still grew by 240 managed bytes per call; the complete
request/connection rules below remove that growth. Its intermediate
[report](benchmarks.md#freeing-server-values-and-output-channels-on-all-six-hosts)
remains evidence of that stage, rather than the current memory result.

### Server request and connection ownership

A request record stores one remote call's headers, queued messages and status.
A connection record holds the socket and information shared by calls using it.
PR #160 gives these records explicit owners; [history](roadmap-history.md)
records full production acceptance.

While parsing incoming bytes, a temporary list owns each new request. This matters
when the same input contains both a new call and its cancellation: cancellation
can remove the request from the connection before a serving task starts. The
parser list keeps it alive, then moves its owner into the serving job. A parse
failure releases every request still in the temporary list.

Connection startup moves its owner to the reader task. The writer and each
serving job acquire separate owners because they can finish at different times.
An input iterator or output channel retained by language code also keeps its
request and connection alive. Closing the socket finishes transport activity;
the record remains available until those retained users release it. Job cleanup
clears borrowed task pointers before releasing the request and connection, so
those pointers do not keep finished tasks alive or form an owning cycle.

Native Windows testing exposed a shutdown issue: a locally shut-down socket did
not wake its parked reader through OS polling. The implementation explicitly wakes
socket waiters on shutdown and close. On polling platforms, each wait record lives
on the waiting task's stack and is removed on return or cancellation. This adds
no heap allocation or task-header field. Timeout, cancellation, task deadlines and
two simultaneous readers are tested separately from connection ownership.

The [six-host comparison](benchmarks.md#freeing-server-requests-and-borrowing-fold-captures)
finalizes every measured request and connection. All four workloads leave 544
constant managed bytes on Linux and zero on macOS/Windows after 1, 16 or 256 calls.
Allocation requests match the preceding values/channel stage; independently live
owners add counts while callback borrowing removes repeated channel counts.
The separate long-running resident-memory regression also passes, with its
unchanged 8 MiB growth bound. That report predates checked gRPC and HTTP handlers;
their accepted contracts appear below and in [checked ARC delivery](#checked-arc-delivery).
Arbitrary escaped callback cycles remain unproved.

### Borrowing values inside known folds

A fold visits collection elements while updating a running result. Its callback
receives that result and the next element; it may also keep values supplied
earlier, called captures. For a callback known to the compiler, the collection
and enclosing call can keep those elements and captures alive throughout each
invocation. The callback borrows them instead of acquiring and releasing an owner
on every iteration. The running result still transfers ownership between steps.

If the callback returns a borrowed value or stores it somewhere that survives
the invocation, the compiler acquires an owner at that use. Error and cancellation
cleanup release only owners actually acquired. The ownership verifier checks
these distinctions before generating the callback's actual body. Recursive
callbacks and resource-closing scopes keep their existing compilation until their
additional lifetime rules are proved. The language's function and fold semantics
do not change, and no forwarding wrapper is added.

The measured text-channel loop sends 64 messages per call. Borrowing removes its
64 per-message channel retains and releases, while independent request/connection
owners remain. Inlining also changes code size and stack frames; the binary
comparison must report those costs alongside the count reduction. This is not
a general zero-cost or execution-time claim.

### Accepted input iterator ownership

Accepted input ownership keeps two iterator nodes: the next node to read and
the node whose element is currently being encoded. This preserves the existing
order, which evaluates the next step before encoding the current element.
The current element remains borrowed from its still-owned node. The compiler
supplies the iterator's concrete destruction function in static request metadata;
there is no extra input heap object. Synchronous calls keep this cursor on their
stack; background senders embed it in their existing record.
When the node has one owner, the implementation moves its continuation into the
call and clears the old field. A shared node keeps its continuation and lends it
to the call instead. All six native hosts verify bounded remaining storage and
reduced count traffic compared with the first ownership probe; count operations
remain higher than the original version that retained storage for tracing.

A sender owns its cursor and record exclusively. The scheduler exclusively owns
its task record and releases it after stack and task-list removal. The caller's
input is borrowed at entry, so the cursor acquires a separate reference and
retained original iterators remain usable. Input references release on completion,
continuation/encoding failure and cancellation. All six focused native jobs
verify these contracts. [The comparison](benchmarks.md#input-owners-and-moves-bounded-memory-with-measured-count-costs)
records memory/count costs; [history](roadmap-history.md) records full production
acceptance in PR #159.

Request failure also differs from dropping an unused response reader. Native
input production/encoding failure and failed response-channel delivery must
reset the remote request before releasing the reader, as the interpreter does.
Ordinary response-iterator abandonment still lets the remote operation finish.
Scoped failure cleanup and deliberate missing-reset tests enforce that distinction.

Keep the cache, shared-reader and decoder failure controls while extending these
owners. Test partial construction and every last-owner case; retain deliberately
broken variants to prove that missing cleanup is detected. HTTP/2 handlers are
accepted in PR #163. GPU execution is outside the CPU-only design.

### Checked gRPC clients and services

A split gRPC build can select `--gc arc` for both its client and service entries.
[The service guide](services.md#building-without-tracing-collection) introduces the
command and iterator lifetime rules. All six native hosts pass focused O1/O2
interpreter comparisons, cleanup controls and tracing-free binary checks. The
[repeated comparison](benchmarks.md#remote-services-without-tracing-and-with-fewer-field-retains)
records remaining memory/count costs; [PR #161 acceptance](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
records all final production gates. This does not establish complete GC removal.

The compiler follows known iterator continuations, including later steps. A
single-result remote call consumes its input under the caller's current state
and differentiation handlers. A bidirectional sender runs in a separate task
without inheriting those handlers. Received-input iterator constructors run in
the service task before the method body; returned iterators are drained after
the method's local handlers end. A continuation that requires an expired or absent handler is rejected.
Installing a handler inside the continuation is allowed.

Remote arguments are borrowed while encoded or delivered. Retained input cursors
acquire their own typed owners. A decoded single reply stays protected until the
final status arrives; cancellation, extra replies and failed status release it.
A channel send consumes the decoder's owner and transfers it into an accepting
queue. Native sinks and closed channels release that owner before returning. Caught
status errors own both their record and message. Tests omit these owners
separately and require a failure, in addition to normal and cancellation checks.

Wire messages encode data, not managed pointers or callable captures. Local
queues follow their separate [capture proof](#functions-stored-in-channels);
the local function/task extensions do not serialize functions or task handles.
HTTP stream payloads and recursive channel ownership remain excluded. Known local
task messages use the separate computation/result proof described above.
Request/connection owners and borrowed
task links retain their existing contracts. ARC binaries still allocate and
count shared owners; removing the collector does not make networking a zero-cost
abstraction. Repeated server measurements compare identical fwp programs across
memory modes, with no speed or C/Rust-parity claim.

### Moving record fields into a compiled function

A boxed record stores its fields together in a heap object. Some compiled
functions instead accept those fields as separate arguments; this avoids
repacking them inside the function. Calling such a function through a function
value still needs entry code to unpack the original record.

When that record has one owner, the entry transfers its counted fields and clears
their original slots. It reads all fields before clearing any slot. A shared
record keeps its fields and supplies independent owners to the call. Scalar
bits are never treated as pointers just because they resemble addresses.

Original arguments and partially prepared fields remain protected if preparation
fails. The compiled body takes responsibility before it can suspend or trap; the
entry releases the outer record after the call. Resource-containing records keep
their existing cleanup rules. Tests cover shared parents, shared fields, failure
after a partial transfer, cancellation on entry and returned values. The current
six-host checks pass, with one fewer retain per measured greeting and unchanged
allocation requests. The [comparison](benchmarks.md#remote-services-without-tracing-and-with-fewer-field-retains)
also records code-size and stack costs. PR #161 passed final production acceptance;
the record allocation and sharing costs remain.

### Moving values held by a closure

A closure is a function that keeps values for a later call. For example, `add 1`
keeps the integer `1` until it receives the number to add it to. Captured strings,
arrays or stream positions can require separate storage and owners.

The runtime transfers captured owners when consuming a closure with
exactly one owner. It copies their value words into the destination, then clears
the original closure's capture count so its cleanup cannot release them twice.
For a partial call, the destination is the new closure; for a complete call, it
is the callee's argument storage. Shared closures still acquire typed references
so that existing aliases remain valid. Scalar values are never treated as heap
references merely because their bits resemble an address.

The destination is ready before this transfer. No allocation, task suspension or
recoverable trap occurs between moving the owners and assigning responsibility
for cleanup. The callee owns its arguments on both return and failure, while
runtime cleanup still frees the consumed closure. This needs no new language
syntax or closure fields. It removes capture retains on this path, but dynamic
calls still perform dispatch, ownership checks and argument copying.

Focused controls cover unique/shared closures, partial/complete application,
normal returns, errors and traps. They require exact reclamation without
collection and deliberately restore unnecessary duplication or steal shared
captures to ensure those bugs are detected. All six native jobs pass at `afd7d460`, including native Windows stack-allocation
failure injection. [The comparison](benchmarks.md#moving-captured-values-instead-of-retaining-them-again)
records the saved retains and remaining costs.
[PR #156](roadmap-history.md#released-stream-caches-and-moved-closure-captures-pr-156)
records full production acceptance.

## Compile-time storage

Known compound constants and wide literals now use static program storage, like
strings. They have no heap owner to retain or release; immutable updates still
allocate a separate result. This removes startup heap allocations rather than
adding an allowance for them to leak checks. Runtime-computed cached values still
need their usual owners. See [layouts and initialization](design.md#compile-time-values-in-static-storage)
and [PR #169 acceptance](roadmap-history.md#static-constants-and-complete-shutdown-checks-pr-169).
