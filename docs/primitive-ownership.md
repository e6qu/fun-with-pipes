# Native primitive ownership contracts

This is a maintainer reference for calls between generated code and the runtime.
Read [memory ownership](ownership.md) first. A **primitive** is a library operation
implemented directly in Rust and C rather than in fwp. Its contract tells the
compiler who keeps each argument and result alive.

`src/ownership.rs` is the shared inventory used by reference-count insertion and
C generation. A coverage test checks library declarations against it. Unknown
primitives, foreign functions and remote calls keep a conservative contract:
arguments may become runtime-shared, and results need tracing unless a more
precise contract proves their lifetime. Such a call is not automatically eligible
for `--gc arc`.

Read the tables using these meanings:

| Term | Meaning |
|---|---|
| borrow | Use during this call; the caller keeps an owner |
| consume | Take an owned reference and release it or transfer it onward |
| retain | Acquire an additional reference to keep a value alive |
| alias | A reference to storage also reachable through another value |
| counted | Reference-counted storage with typed release operations |
| scalar | Inline number/tag bits, requiring no child destructor |
| callback | A function the primitive calls, with its own argument/result contract |
| spine | The linked list cells, separate from the values they contain |
| unwind | Exit several active calls because of failure, a trap or cancellation |

Arguments are numbered from zero in source application order, with the subject
last. For example, `array.set index value array` borrows `index` and `value` but
consumes its reference to `array`. If another owner still sees that array, the
operation must copy; it cannot change the other owner's value. An owning wrapper
is the runtime entry that implements that transfer policy.

A synchronous C callback runs before the foreign call returns. Its temporary
values and context have scoped cleanup. A raw pointer has a manual pointee
lifetime: copying its address never acquires an ARC owner. The programmer still
ensures validity and cleanup; PR #193 records native acceptance. The
[callback-input extension](ownership.md#c-library-results-and-foreign-calls) copies
incoming C strings into owned fwp values, accepted in
[PR #196](roadmap-history.md#array-owner-moves-and-copied-callback-strings-pr-196).
Retained unknown callbacks and callbacks returning managed C addresses remain
outside the checked contract.

| Array primitives | Arguments in data-last order | Result / aliasing | Callback |
|---|---|---|---|
| array.from-list; array.to-list | borrow input | counted output retaining typed elements | none |
| array.length | borrow array | scalar | none |
| array.get | borrow index and array | owned Option retaining selected typed element | none |
| array.set | borrow index/value, consume array | owned optional container; retains inserted value and copied aliases | none |
| array.push | borrow value, consume array | owned container retaining inserted and copied elements | none |
| array.make | borrow count/value | counted container retaining each repeated typed alias | none |
| array.generate | borrow count/callback | counted container adopting owned callback results | argument1 borrowed |
| array.map | borrow callback/array | counted container adopting owned callback results | argument0 borrows typed elements |
| array.fold | borrow callback/array, consume accumulator | transfers owned accumulator/result | argument0 borrows elements |
| array.slice | borrow arguments | numeric backing view or small copy; pointer/resource elements copy retaining typed aliases | none |
| array.sort | consume array | reuse unique owning storage; shared arrays/views copy; empty/singleton input transfers unchanged | none |
| array.append | borrow both arrays | copied storage retaining typed aliases | none |

Array destruction releases typed children before outer storage; views release
their retained backing owner at the last reference. Nested views flatten their
backing owner, and small slices copy to limit retention. Scalar fields
are skipped; boxed I128/U128 payloads have typed leaf owners. Immutable
updates preserve live aliases. Unmodeled callbacks retain explicit sharing and conservative roots.

| Map/set primitives | Arguments in data-last order | Result / aliasing | Callback |
|---|---|---|---|
| map/set.from-list | borrow list | counted storage retaining typed elements | none |
| map.keys/values/to-list; set.to-list | borrow container | counted list retaining typed aliases | none |
| map.size; set.size | borrow container | scalar | none |
| map.map-values | borrow callback/map | counted container retaining keys and adopting callback results | argument0 borrows values |
| set.union/intersect/diff | borrow both sets | counted storage retaining selected typed aliases | none |
| map.empty; set.empty | none | static shared empty value | none |
| map.insert | borrow key/value, consume map | owned container retaining inserted values and copied aliases | none |
| map.get | borrow key/map | owned Option retaining selected typed value | none |
| map.contains; set.contains | borrow key/container | scalar | none |
| map.remove; set.remove | borrow key, consume container | owned container; missing key can return original | none |
| map.update | borrow key/callback/default, consume map | owned container retaining keys and adopting callback result | argument1 borrows value |
| set.insert | borrow key, consume set | owned container retaining inserted and copied keys | none |

The compiler-only `map._map-list` and `set._map-list` operations borrow a callback
and input list; their `_map-range` forms borrow a callback and two I64 bounds.
They return an owned numeric container. Callbacks borrow each input; their results
contain only inline numeric fields, although dynamic map callbacks can still
allocate the containing tuple. Unfinished buffers have scoped cleanup. These are internal
representations of ordinary `map` followed by construction, not new library APIs.

`set._range` borrows two inline integer bounds and returns an owned set, or the
static empty set. Its ordered, distinct keys need no callbacks, retains or child
cleanup. It checks storage limits before allocation and cannot fail while filling
the allocated buffer. The compiler uses this only for an immediately consumed
`range | set.from-list`; boxed integer keys keep ordinary construction.

Comparison-only keys never escape into fwp_map_find or structural fwp_cmp;
these functions read values, allocate nothing and invoke no user callbacks.
Their wrappers omit fwp_rc_share(key). Typed destruction releases keys/elements
before buffers and outer storage. Copies retain aliases; replacement/removal
releases displaced owners. Scalar payloads are skipped; boxed I128/U128 values
retain and release typed leaf references. Ordering, key identity and immutable
aliases are preserved. Unmodeled callbacks retain explicit sharing and conservative roots.

## String transformations

`lower`, `upper`, `trim`, `trim-start` and `trim-end` consume one source-string
owner. `replace from to source` borrows its pattern/replacement and consumes
one source owner. `OwnedLeaf` names this compiler contract: a leaf has no managed
children. The source stays protected while a changed result is allocated. An
unchanged result transfers that same owner, without an extra retain/release pair.
A changed result reuses eligible unique storage or owns a copy and releases the
consumed source.

ASCII case conversion can change uniquely owned storage in place. Tracing mode
also requires that storage to be young (not yet preserved by a collection);
reuse verification forces a copy. Shared strings copy, preserving every older
value. Changed trim and replacement results use separate storage.
ASCII case conversion returns the source when no relevant ASCII letter changes;
trim returns it when no boundary whitespace is removed. Replacement returns it
for an empty pattern, equal pattern/replacement or no occurrence. Embedded NUL
and non-ASCII bytes keep the existing length-aware behavior.
[PR #192](roadmap-history.md#string-ownership-and-repeated-file-cleanup-pr-192)
accepted unchanged-result transfers;
[PR #194](roadmap-history.md#string-map-ownership-and-native-reuse-checks-pr-194)
accepted unique ASCII case reuse, including alias and failure controls.

## Registered unwind cleanup

Cleanup registrations record owners acquired so far, so a failure during the
next allocation does not lose them. LIFO means last acquired, first released.

The merged runtime cleanup stack releases registered owners and scoped files in
LIFO order before failure, trap or cancellation invalidates their frames. It
stops at the catching handler boundary; task switches preserve separate chains.
Normal transfer unlinks registrations without releasing a transferred value.
Compiler caller/reuse-token, runtime application/capture preparation and
synchronous callback registrations preserve partially acquired owners. Unproved
boundaries remain available only under explicit tracing; checked ARC rejects them. Cleanup registrations alone do not establish their ownership.

## Conservative reconstruction and external boundaries

The inventory checks declarations, runtime symbols and aliases against the
immutable original baseline, including each numeric/CSV/CLI promotion and the
nonreturning failure contract. Its generated report records current counts. Scalar
signatures can still allocate external state; descriptors alone cannot establish
counted reconstruction. The handoff records validation of the current revision.

Unknown primitive, foreign and remote boundaries keep explicit sharing in
[src/ownership.rs](../src/ownership.rs). The finite review records argument,
result, callback, retention, teardown and cycle policy for every remaining
boundary; it does not establish tracing-free eligibility.

| Boundary | Current lifetime policy |
|---|---|
| JSON/typed CSV/text/binary decoding | Descriptor Dup/Drop owns reconstructed children and partial field vectors; parse/read and typed CSV return OwnedTree. External protocol contexts remain separately unproved |
| csv.parse / csv.parse-with | Counted String leaves and nested list spines; registered pending-field, partial-row and scratch cleanup; private spine reversal transfers existing owners |
| cli.parse / cli.help | Borrow defaults and input strings; reconstruct owned flag records/positional lists, retain aliases, release displaced flags and partial values; help and diagnostics own their scratch/text |
| Numeric I128/U128 results | Fresh leaf/aggregate ownership or explicitly retained selected aliases; scalar results remain inline |
| grpc.with-gzip / with-deadline / with-metadata / with-tls | Borrow a synchronous unit-taking callback and transfer its typed result, including captured aliases; stack settings and constructor owners remain alive until return or unwind |
| grpc.with-response-metadata | Borrow the callback, own its result and independent copied response headers; partial construction releases completed fields and the capture owner; inheriting child tasks keep separate capture references |
| exit | Borrow the scalar status and terminate the process; no result or callback exists. Process teardown is not normal scope unwinding, and no result-storage reclamation claim follows from it |
| Remote values and memoized decoding | Preserve retained context/cache owners and independent reader aliases; scratch cleanup alone does not count decoded nodes |
| Foreign values and retained callbacks | Keep explicit sharing unless host lifetime and teardown are proved |
| list.flat-map and list.ap | Borrow typed synchronous inputs, adopt owned callback results and own copied spines; partial results, scratch and unwind cleanup have partial-result and failure controls |
| list.transpose | Borrow rows, retain typed element aliases and own new row/outer list nodes; row cursors, completed-column storage and partial columns are released on success or failure; ragged input stops at its shortest row |
| State handlers | Typed get/put/modify/run-state owners; finite callback-flow proof admits State operations only under a handler. Returned closures require a fresh handler when called; unknown targets are rejected by ARC |
| term.read-secret | Borrow unit, return an owned optional string; restore terminal echo on return and unwinding |
| term.is-tty / term.width | Borrow the descriptor or unit argument; return an immediate Boolean or I32 width without allocating managed storage |
| process.run-input / process.call | Borrow input/argument strings until the child finishes; captured status/output record owns both copied strings, while call returns an immediate status. Registered cleanup owns temporary buffers, pipe endpoints and child-process resources |
| External resource contexts | Original scoped/task owners preserve teardown order; counted C context storage does not by itself prove ownership of every fwp graph |

Channel close preserves queued values. Explicit drain breaks the tested counted
cycle, while unreachable shared cycles still need tracing. Checked ARC admits
nested channels when following their payload types cannot lead back to the same
channel type. HTTP stream handles remain excluded because their hidden owners
can lead back to the queue. The [task-message extension](measurements/task-channels.md)
also follows each known task's computation and result; unknown producers and
captured task-bearing queues remain rejected. The
[queued-function capture proof](ownership.md#functions-stored-in-channels)
checks actual captures and call scopes separately. The queue owns each
retained message and the last channel owner releases remaining messages. See the
[type proof](ownership.md#ownership-boundaries). Preserve callback, trap and task ordering when extending
contracts. These contracts describe the current runtime. Checked ARC additionally
enforces its lifetime and cycle rules, rejecting unproved shared boundaries.

## Complete runtime sharing

In explicit tracing mode, runtime sharing can promote a reachable graph to
tracing-managed storage. This differs from adding an ordinary counted owner.
Checked ARC rejects calls requiring that promotion; normal ARC sharing keeps
exact counts and typed cleanup.

Native counts 1–254 fit the existing byte. At 255, rare exact size_t side
entries keyed by canonical metadata slots track additional owners without new
value roots. Release, sharing, free/reuse and collection remove those entries;
count overflow traps and side-entry allocation failure exits with status 102. Interior
references canonicalize to allocation starts. Explicit runtime sharing still
promotes the complete reachable graph; traversal overflow preserves child
counts while recursing. Large fanout no longer forces automatic sharing.

Eligible counted storage reclaims at last release at any age. Returning a cell
clears old marks; verification clears stale child words before linking the free
slot. The young-cell restriction on record reuse applies to tracing builds. ARC
objects do not age through collections; unique counted objects remain eligible
for reuse. Unproved shared graphs require explicit tracing. The tracing churn
fixture explicitly disables both counted freeing and reuse so real collection
remains tested.

## Selected String/Bytes boundaries

The table identifies calls that borrow inputs and those that consume a source
owner. Generated native calls protect borrowed pointer arguments until return:
inlining must not discard an allocation address while its later drop has
been reduced to metadata accesses. Constructors returning
fresh storage establish a count; aliases acquire a count on the same allocation.
A shared input remains shared when duplicated. Slices copy and retain no view.

| Primitives | Arguments | Result ownership |
|---|---|---|
| trim; trim-start; trim-end; lower; upper | Consume source | Transfer unchanged source, reuse eligible unique storage, or own a copy and release source |
| replace | Borrow pattern/replacement; consume source (argument 2) | Transfer unchanged source or own changed text; preserve independent aliases |
| string.reverse | Borrow source | Fresh copied leaf |
| concat; bytes.append; string.repeat; bytes.from-list | Borrow inputs | Fresh copied leaf |
| string.slice; bytes.slice | Borrow bounds/source | Fresh copied leaf |
| string.to-bytes | Borrow source | Identity alias of argument 0; duplicate its reference |
| pad-left; pad-right | Borrow width/padding/source | Fresh leaf or retained no-op alias of argument 2 |
| string.length/byte-length; bytes.length; print/write/eprint/ewrite | Borrow input | Scalar/unit result |
| string.contains; starts-with/ends-with | Borrow inputs | Scalar comparison result |
| eq/ne/lt/le/gt/ge/compare | Borrow inputs | Read-only comparison, scalar result |

## Fresh copied text result trees

A result tree can contain many allocations: for example, `words` returns list
cells containing newly copied strings. The outer list and every string need owners.

A `FreshTree` result guarantees a tree of new counted allocations, with no aliases
of arguments and no internal sharing or cycles. Generated helpers establish one
reference per node using monomorphic field types. They skip scalar fields, treat
String/Bytes payloads as leaves and walk a list spine iteratively. A counted node
encountered twice is a contract violation, detected before silently resetting its
count. This contract cannot be reused for views, caches or callback results.

| Primitives | Owned result |
|---|---|
| string.chars; split; lines; words | List of newly copied String leaves |
| string.codepoints; bytes.to-list | List with inline scalar elements |
| string.from-codepoints; string.from-bytes | Option containing a copied String, or None |
| string.split-once | Option of a fresh pair of copied Strings, or None |
| string.find; bytes.find; bytes.get | Option of an inline scalar, or None |
| join; format; show | Fresh String leaf; arguments borrow |
| length | Read-only list length; scalar result |
| parse-int; parse-float | Borrow input text; fresh owned Option tree, including any boxed numeric payload, or immediate None |

Character, codepoint and byte-list conversions release their temporary arrays
once the list is constructed. Those arrays use `fwp_mem_alloc`/`fwp_mem_free`:
native arrays remain scanned while alive, and WASI uses a separately releasable
allocation rather than freeing an interior pointer from its bump heap.

## Task result and deadline boundaries

Escaping task/receive results and task.within results own typed wrappers.
Immediate await/receive matches can carry fields directly, as described in the
[await comparison](measurements/task-await-fields.md). A wrapper owns its
pointer-bearing payload; scalar words
do not select reference destructors. task.deadline borrows its typed argument
and retains the returned alias instead of forcing it into runtime sharing.
The `task.spawn` and `task.within` contracts consume one callback owner;
the compiler duplicates it first only if another use needs an independent owner.
The task keeps that owner through preparation, completion or cancellation.
Deadline calls protect it while reading the clock. These contracts passed
[PR #190](roadmap-history.md#queued-task-owners-and-callback-transfers-pr-190);
[the comparison](measurements/queued-task-handles.md#transferring-task-callbacks)
records the saved retains and unchanged allocations.
Scope results remain protected through joining and unwind. Counted
task handles own typed cached results; repeated awaits return separate owners.
Typed sends consume message owners and transfer them into the queue; the compiler
retains independently live aliases before a send. Receive transfers the queued
owner into its result, while failure before result allocation leaves it queued; close
preserves the queue. These contracts do not establish automatic cycle
reclamation, complete ARC or tracing-free execution.

## Compiled closures and synchronous callbacks

A closure stores a function and arguments already supplied to it. Partial
application supplies fewer arguments than the function needs; overapplication
supplies enough to call a function and then call the function it returns. Both
paths must transfer the correct typed owners.

Compiled dynamic calls own heap closures and typed captures. Monomorphic
argument metadata distinguishes references from scalar words. Borrowed callback
application retains the original function, duplicates typed borrowed slices and
transfers owned spans into the callee. Partial application stores owned copies;
overapplication splits at actual arities and uses each returned function's types.
Owned returned aliases retain their references. Unknown metadata and retained
runtime callbacks preserve sharing.

Synchronous callback contracts permit escape analysis for the callback slot,
without treating every borrowed argument as nonescaping. Generic/direct/captured
paths keep specialization, callback/evaluation order and conservative roots
through allocation. Scratch buffers remain scanned until transfer and are
released explicitly. Scalar bits never select a reference destructor.

| Merged primitive | Arguments | Owned result and callback transfer |
|---|---|---|
| map; zip-with | Borrow callback and lists | Fresh spine adopts owned callback results; callback borrows typed inputs |
| filter; take-while | Borrow predicate and list | Fresh spine retains selected elements; predicate borrows |
| fold | Borrow callback/list, consume accumulator | Return owned accumulator; transfer callback argument0 |
| fold-right | Borrow callback/list, consume accumulator | Return owned accumulator; transfer callback argument1 |
| drop-while | Borrow predicate/list | Retained input tail; stop predicate calls at first failure |
| reverse; flatten; take | Borrow inputs | Copied fresh spine retaining selected elements |
| sort; unique | Borrow list | Copied spine retaining typed selected elements; release scanned scratch; stable comparisons/first occurrence |
| sort-by | Borrow callback/list | Evaluate each key once in input order; own typed keys and copied result, release scratch; stable ties |
| scan; iterate | Borrow callbacks/inputs | Retain initial stored state and adopt subsequent owned callback states |
| loop | Borrow callback, consume state | Transfer callback input; retain selected typed Step payload before releasing wrapper; reclaim typed worker/ABI wrappers |
| zip; unzip; chunks | Borrow inputs | Counted nested spines retain typed aliases; release scratch; invalid chunk size traps before list evaluation |
| append | Borrow both lists | Copied spine plus retained tail from argument0 |
| drop | Borrow count/list | Retained tail of argument1 |
| nth; find | Borrow arguments | Fresh Option retaining selected element; find borrows predicate and stops at first match |
| index-of | Borrow key/list | Fresh Option of scalar; comparison key is read-only |

The internal result labels describe distinct promises:

- `FreshSpine`: new list cells adopt already owned elements.
- `CopiedSpine`: the runtime counts each new list cell immediately and retains
  its borrowed element by type. Scoped cleanup owns the partial list, any
  pending element and scratch until construction succeeds. An appended suffix
  gets one owner before copying starts. See [list-copy failure checks](measurements/list-copy-cleanup.md).
- `FreshOuter`: one new wrapper retains its pointer-bearing fields.
- `FreshTree`: every reachable allocation is new and independently owned.

`None` is an immediate tag and needs no allocation. These contracts preserve
aliasing and immutable values; they do not establish complete exception or
retained-callback ownership.

Repeat borrows value/count and retains each typed alias in fresh counted list
nodes. Range borrows bounds and owns fresh nodes and wide numeric elements;
pending elements and completed spines release on unwind. Scalar words never
select reference destructors.

## Accepted ownership review

The immutable baseline and exact contract promotions distinguish counted
boundaries from reviewed tracing requirements. Preparation and historical
binary/GC/reuse/omission controls remain in [history](roadmap-history.md).
Checked ARC has a separate [eligibility contract](ownership.md); no
blanket no-GC claim is established.

## Validation and limits

[Delivery evidence](roadmap-history.md) records the exact source and accepted
checks for past changes; the handoff tracks current work.
Focused interpreter oracles explicitly use FWP_NO_OPT=1. Tests cover retained aliases,
scalar words resembling pointers, callback/capture ownership, conservative flags,
GC stress/verification and reuse poisoning. The interpreter/native comparison
includes observable callback and trap order.

Detailed tests, failed controls, allocation/count measurements and compiler/
hardware settings are preserved in
[the archived record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#archived-primitive-contract-notes-through-queue18).
They are scoped reclamation evidence, not blanket speed, register-placement or
no-GC claims. Retained callbacks, exception/cancellation, unknown runtime boundaries and
cycles remain explicit acceptance concerns.

The prepared vector-library contracts use borrowed inputs and already-owned
results for `simd.splat`, `simd.from-array`, `simd.sum`, and the six lane-wise binary
operations. Their runtime paths must own wrappers, shared boxed lanes and reduction
accumulators, and release partial results on failure. Contracts alone are not
acceptance; [the handoff](development-state.md) records native and WASI checks.

## Decoded values, metrics, CPU tensors and DNS

These operations have explicit contracts, accepted in
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153).
A decoder
turns encoded input into ordinary values. A snapshot is an independent copy of
current state. Neither returns pointers into temporary parsing or registry memory.

| Operations | Arguments | Result and cleanup |
|---|---|---|
| `trit.from-sign`, `trit.to-int`, `tint.to-int` | Borrow input | Inline scalar |
| `tint.of-int`, `tint.from-trits` | Borrow input | Owned optional scalar wrapper |
| `tint.trits`, `trits.unpack` | Borrow value/count/bytes as applicable | Owned list; partial-list cleanup |
| `trits.pack` | Borrow trit list | Fresh bytes; no temporary digit array |
| `url.decode`, `form.decode`, `url.split`, HTTP-head parsers | Borrow text/bytes | Owned optional/result fields and list nodes; release partial fields and scratch |
| `http.field-ok`, `http.content-length`, `int.parse-hex` | Borrow inputs | Boolean/integer, or fresh optional integer wrapper |
| `zlib.gunzip`, `zlib.inflate`, `ws.inflate` | Borrow limit and bytes | Owned bytes/error/result; protected native output buffer |
| `ws.parse`, `ws.close-parse` | Borrow frame options and/or bytes | Owned record/tuple with copied payload |
| `zlib.crc32` | Borrow seed and bytes | Inline checksum |
| `metrics.add`, `metrics.set`, `metrics.observe` | Borrow name and number | Unit; registry owns a native copy of each distinct name |
| `metrics.snapshot` | Borrow unit | Owned list of copied name/kind/value tuples; release partial construction |
| `dns.resolve` | Borrow hostname | Owned address strings/list; release OS resolver entries and partial results |
| `syntax.show` | Borrow syntax tree | Fresh text; release formatting buffer even if result allocation traps |
| `device.run` | Borrow worker count, element count, instruction array, constants and input arrays | Owned numeric array; workers write distinct ranges and all finish before return/cleanup |
| `device.sum` | Same five borrowed arguments | Inline F64; release input table, worker workspace and block sums |

The compression/frame helpers are native-only. Process metrics retain registry
entries until process exit or library teardown; snapshots have ordinary value
lifetimes. CPU workers retain no language references after the call. Reporting
worker-start failure joins already started workers before releasing borrowed
inputs or pending output. Whole-service ownership needs the separate
[gRPC and HTTP contracts](ownership.md#checked-arc-delivery); these individual
primitives alone cannot prove it. Retained foreign callbacks still need separate
lifetime proofs. Socket handles have
[their own contracts](ownership.md#tcp-and-tls-socket-owners).

## Copied service data

These result-copy contracts passed full production acceptance in
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153).
They do not admit entire services into checked ARC.
A request context holds information about the request being served. Returning a
copy transfers ownership of the new data, not ownership of that context.

| Operations | Arguments | Result and cleanup |
|---|---|---|
| `grpc.metadata` | Borrow unit | Owned list of copied header pairs, in source order |
| `grpc.peer-subject` | Borrow unit | Owned optional copy of the client's certificate name |
| `grpc.set-header`, `grpc.set-trailer` | Borrow name and value | Unit; the response owns normalized copies of both strings |
| `http2.request` | Borrow stream | Owned method, path, headers, remote address and optional certificate name |
| `http2.body` | Borrow limit, timeout and stream | Owned body bytes or an integer error wrapped in a result |
| `http2.send` | Borrow pool key, optional connection and request | Owned status/header/body record; release partial copies and request owners on failure or cancellation |
| `http2.pooled` | Borrow pool key | Boolean indicating an available connection with the full matching key |
| `http2.serve` | Borrow connection, input, limits and upgrade; retain handler captures once per connection | Unit; connection and task owners release on completion, failure and cancellation |
| `http2.respond`, `http2.data` | Borrow response fields and stream handle through any wait | Boolean; queued protocol bytes are copied, and the handle keeps request/connection storage alive |
| `signal.shutdown-requested`, `signal.request-shutdown` | Borrow unit | Boolean or unit; read/set the shutdown flag without retaining language values |

Copied values do not borrow the source strings or body buffer. Typed cleanup
releases partially copied fields if a managed result allocation fails. The source
stream remains live during copying. HTTP clients give pooled connections, I/O
tasks and requests explicit owners, accepted across the native platform matrix in
[PR #162](roadmap-history.md#http-client-owners-and-complete-connection-keys-pr-162).
The server extension gives stream handles typed owners and retains handler captures
once per connection. Its focused checks pass on all six native hosts; final
production acceptance is tracked in [the handoff](development-state.md).
Handler tasks start with fresh State and
automatic-differentiation scopes, rather than borrowing a caller's dynamic scope.

## Remote stream positions

A remote stream position stores either the source of its next message or the
result already received at that position. `grpc._force` is an internal operation
that returns an optional pair of the value and the next position. `None` means
the stream ended. Multiple reads of one position must return its saved result.

The operation consumes one position owner. When that owner is exclusive,
it moves the saved result; otherwise it adds one result owner. Typed cleanup
releases cached values and continuation wrappers, stopping at a shared wrapper.
It follows long cache chains in a loop. Positions and receive sources use raw
runtime layouts, so their release must not interpret them as record headers
when verifying memory reuse. This position contract is one part of the complete
connection, stream and decoder-capture ownership needed for remote calls.
[PR #161](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
accepted checked ARC for supported gRPC clients and services on all six native
hosts. The [ownership guide](ownership.md#checked-grpc-clients-and-services)
states the remaining restrictions, including cycles through channel payloads.
