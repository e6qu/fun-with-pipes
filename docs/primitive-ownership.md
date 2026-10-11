# Native primitive ownership contracts

`src/ownership.rs` is the shared boundary inventory used by IR counting and
native code generation. Its container inventory covers every array/map/set
primitive declared in `lib/collections.fwp`; a coverage check detects newly
added declarations without contracts. All 31 string-module declarations and seven byte primitives now have contracts;
selected typed result ownership is listed below. Other primitives, foreign
functions and remote calls retain the conservative default: borrow arguments, promote counted
values to runtime sharing, and return runtime-shared values. Further inventories
must refine that default before extending deterministic reclamation.

Arguments have three modes: **borrow** for the call, **consume** an owned
reference, or **share** a borrowed value because it may escape into runtime
storage. Consume is checked by `src/rc.rs`; share is emitted by `src/cgen.rs`.
Result metadata distinguishes shared results, owned leaf copies/aliases, fresh outer containers and
containers returned by an owning wrapper. That last category includes copies,
in-place updates, missing-key no-ops and `array.set`'s optional container.
Every failure path still consumes its specified reference.

The tables describe main through PR #118. Arrays, maps and sets own typed elements.
Exceptional and retained-runtime refinements remain in [the queue](roadmap-queue.md).

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
| array.slice; array.sort | borrow arguments | copied storage retaining typed aliases; no backing view | none |
| array.append | borrow both arrays | copied storage retaining typed aliases | none |

Array destruction releases typed children before outer storage. Scalar fields
are skipped; boxed128-bit payloads retain their compatibility lifetime. Immutable
updates preserve live aliases. General callback unwind remains prepared work.

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

Comparison-only keys never escape into fwp_map_find or structural fwp_cmp;
these functions read values, allocate nothing and invoke no user callbacks.
Their wrappers omit fwp_rc_share(key). Typed destruction releases keys/elements
before buffers and outer storage. Copies retain aliases; replacement/removal
releases displaced owners. Scalar payloads are skipped and boxed128-bit values
retain their compatibility lifetime. Ordering, key identity and immutable
aliases are preserved. General callback unwind remains prepared work.

## Registered unwind cleanup

The merged runtime cleanup stack releases registered owners and scoped files in
LIFO order before failure, trap or cancellation invalidates their frames. It
stops at the catching handler boundary; task switches preserve separate chains.
Normal transfer unlinks registrations without releasing a transferred value.
Compiler caller/reuse-token and runtime application/capture-preparation cleanup
are merged through PR107 after all exact-head gates. Registration for wider
callback, constructor and runtime ownership remains prepared work; this is not
complete exceptional ownership or tracing-free support.

## Conservative reconstruction and external boundaries

A bounded audit of prepared source 112 (`b45e93a71d40`) enumerates 373 library primitive declarations,
resolves 40 explicit foreign aliases and finds 363 distinct runtime symbols.
It queries the unmodified shared contract module using those actual symbols
and checks monomorphization templates:

| Declaration category | Count | Meaning |
|---|---|---|
| Explicit ownership contract | 134 | IR counting and native wrapper selection use the shared inventory |
| Combinator lowered to ordinary IR | 19 | `mono::foreign_instance` emits `Body::Expr`; ordinary function ownership applies |
| Flat concrete scalar signature | 12 | No counted value parameters/results in these declared signatures; external state may still exist |
| Runtime or specialization review | 208 | Inspect actual monomorphic types, lowering and wrappers before judging sharing or ownership |

The208 review declarations resolve to198 distinct symbols; aliases remain
declaration coverage, not extra runtime boundaries. Missing metadata alone
does not identify a runtime sharing boundary. The scalar
category includes `ad.tape`, which creates external tape state; scalar values do
not prove allocation freedom or complete lifetime coverage. Generic numeric,
boxed 128-bit, callback, resource and reconstructed-value cases require their
actual representations. The portable audit passes on GitHub at evidence head
669c19e7cb67 (CI38099556010), checking actual contract metadata and IR lowering,
explicit aliases and all recorded compiler/library source hashes. Run the
inventory again on actual merged source at the phase 2 exit checkpoint. This is
prepared-source classification, not main acceptance or a tracing-free guarantee.
Counts and scope are recorded in
[history](roadmap-history.md#portable-finite-ownership-inventory-2026-10-11).

Unknown primitive, foreign and remote boundaries keep the explicit shared
fallback in [src/ownership.rs](../src/ownership.rs). A successful result or a
known descriptor does not establish ownership of every reconstructed node.

| Boundary | Current requirement and remaining ownership evidence |
|---|---|
| JSON/CSV/protocol parsing | Shared reconstructed aggregates; typed child transfer and partial-failure cleanup need separate contracts |
| Descriptor-based text/binary decode | Normal scratch cleanup does not make returned trees counted; fresh nodes, aliases and partial construction require typed review |
| Remote values and memoized decoding | Cached decoded results may have several readers; preserve a cache owner before returning independently owned aliases |
| Foreign values and retained callbacks | Explicit sharing protects unknown retention; ownership requires a verified host/runtime lifetime and teardown contract |

Source review of the same prepared head separates three concrete cases:

- `parse-int` and `parse-float` already borrow String input and return a shared
  `Option` result. Their wrappers select the monomorphic numeric kind; integer
  parsing can include boxed numeric payloads. Counting only the outer `Some`
  would not establish typed payload ownership.
- `g_force` returns `cell->memo` on repeated reads and stores the decoded result
  after the first successful force. A future counted contract must retain the
  cache's owner and acquire independent reader aliases; scratch-buffer cleanup
  alone does not supply that contract.
- `grpc.with-tls` copies option text into explicitly owned C storage and releases
  its scoped owner after `g_with_ctx`. Prepared task inheritance holds that C
  storage separately. The current primitive wrapper still shares counted fwp
  arguments, including callbacks; the C counter does not count their value graphs.

These are source-reviewed compatibility policies, not new runtime tests or
verified deterministic reclamation. Keep them in the finite phase 2 exit review;
changing a boundary requires interpreter/native, alias, partial-failure and
retention/teardown evidence before removing sharing.

Keep these boundaries on tracing compatibility until their contracts and cleanup
are proved. Phase2 records coverage and remaining fallback requirements; phase6
must establish eligibility and cycle policy before claiming collection-free use.

## Complete runtime sharing

Native counts1..254 fit the existing byte. At255, rare exact size_t side
entries keyed by canonical metadata slots track additional owners without new
value roots. Release, sharing, free/reuse and collection remove those entries;
count overflow traps and side-entry allocation failure exits102. Interior
references canonicalize to allocation starts. Explicit runtime sharing still
promotes the complete reachable graph; traversal overflow preserves child
counts while recursing. Large fanout no longer forces automatic sharing.

Eligible counted storage reclaims at last release at any age. Returning a cell
clears old marks; verification clears stale child words before linking the free
slot. In-place record reuse/updates retain their young-cell restriction. Shared
runtime graphs remain on tracing. PR101 passed all six production gates and the
documentation audit; the tracing churn fixture explicitly disables both counted
freeing and reuse so real collection remains tested.

## Selected String/Bytes boundaries

All arguments below borrow for the duration of the call. Generated native
calls retain borrowed pointer arguments as conservative roots until return:
inlining must not discard an allocation address while its later drop has
been reduced to metadata accesses. Constructors returning
fresh storage establish a count; aliases acquire a count on the same allocation.
A shared input remains shared when duplicated. Slices copy and retain no view.

| Primitives | Result ownership |
|---|---|
| trim/start/end; lower/upper; string.reverse | Fresh copied leaf |
| concat; bytes.append; string.repeat; bytes.from-list | Fresh copied leaf |
| string.slice; bytes.slice | Fresh copied leaf |
| string.to-bytes | Identity alias of argument 0; duplicate its reference |
| pad-left/right; replace | Fresh leaf or no-op alias of argument 2 |
| string.length/byte-length; bytes.length; print/write/eprint/ewrite | Scalar/unit result |
| string.contains; starts-with/ends-with | Scalar comparison result |
| eq/ne/lt/le/gt/ge/compare | Read-only comparison, scalar result |

## Fresh copied text result trees

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
| parse-int; parse-float | Borrow input text; result remains shared, including boxed numeric cases |

Character, codepoint and byte-list conversions release their temporary arrays
once the list is constructed. Those arrays use `fwp_mem_alloc`/`fwp_mem_free`:
native arrays remain scanned while alive, and WASI uses a separately releasable
allocation rather than freeing an interior pointer from its bump heap.

## Task result and deadline boundaries

Merged PR102 owns fresh typed result wrappers from task.await, task.within and
Channel receives. Wrappers retain pointer-bearing payload owners; scalar words
do not select reference destructors. task.deadline borrows its typed argument
and retains the returned alias instead of forcing it into runtime sharing.
Retained task thunks and scheduler/queue lifetimes remain later preparations;
these contracts do not establish complete ARC or tracing-free execution.

## Compiled closures and synchronous callbacks

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

FreshSpine adopts owned heads; CopiedSpine retains borrowed heads; FreshOuter
owns one newly allocated wrapper and duplicates typed pointer-bearing fields.
FreshTree requires every reachable allocation to be new and independently owned.
None needs no allocation. These contracts preserve aliasing and immutable values;
they do not establish complete exception or retained-callback ownership.

Merged repeat borrows value/count and retains each typed alias in fresh
counted list nodes. Range borrows bounds and owns fresh counted nodes. Scalar
words are never counted as pointers; boxed128-bit payloads retain the shared
compatibility lifetime. Full six-job acceptance is recorded in the handoff.

Merged arrays own typed elements. Get and copies retain aliases; map/generate
adopt callback results; fold consumes its accumulator; set/push consume the
container while preserving immutable aliases. Scalar bits are never treated as
pointers. PR99 passed all six platform and GC gates.

Merged maps/sets own typed keys/elements. Construction and copies retain aliases;
lookup returns an owned Option; updates consume the container and release
displaced owners. Synchronous callbacks borrow values and adopt results. PR100
passed all six production gates and the documentation audit.

## Prepared refinements

The remaining contracts below are prepared, with exact heads and immutable
anchors in [the queue](roadmap-queue.md). [The handoff](development-state.md)
gives current checks and the sole next action. Each delivery still needs its
actual squash-base rebase and all seven exact-head gates. Merged contracts are
summarized in [ownership](ownership.md#merged-ownership-boundaries); earlier
prepared rows and acceptance evidence are in history.

| Queue | Prepared contract | Remaining acceptance |
|---|---|---|
| 41 | Boxed-to-struct variants retain original typed owners through payload preparation; consumed-value checkpoints protect only remaining caller references | Sequential CI; retain overflow, aliases, scalar safety and exact IR ownership checkpoint |
| 42 | Record updates retain typed kept fields, release overwritten owners and protect replacement/partial-copy storage; general copies preserve borrowed original | Sequential CI; unique/copied updates, partial retention/allocation failures, scalar safety and aliases |
| 43 | Boxed record conversion protects consumed original and caller owners before each typed worker-field retain; partial extras release on failure | Sequential CI; count-overflow conversion, external aliases, scalar safety and entry transfer |
| 44 | Returned variant aliases transfer existing typed field owners directly, avoiding an extra box or retain set | Sequential CI; emitted ownership counts, aliases across yields and source/native agreement |
| 45 | Match elimination preserves nominal types for effectful discarded constructor fields and their child destruction | Sequential CI; nested fields, aliasing, effects and evaluation order |
| 46 | Inlined record projections retain checked base types while removing outer storage and dropping discarded children | Sequential CI; aliases, discarded nested fields and evaluation order |
| 47 | Typed CAF cache owners survive caller drops; calls return separate owners and executable teardown releases caches after tasks | Sequential CI; initialization failures, reentry, overflow, aliases and teardown |
| 48 | Inlining evaluates CAF arguments before the callee, including unused arguments, and releases their temporary owners | Sequential CI; first-trap order, raw interpreter agreement and missing-release control |
| 49 | task.spawn borrows the caller thunk and retains a typed task owner until entry or cancellation; failed preparation rolls back before publication | Sequential CI; stack/scope failures, captures, aliases and scalar results; task graph still shares |
| 50 | task.within borrows the caller thunk and retains typed captures through deadline completion or cancellation | Sequential CI; external aliases and rollback; task results still share |
| 51 | task.scope borrows its callback, returns an owned result and protects result/scope storage through joining, traps and cancellation | Sequential CI; handler restoration, aliases and cleanup omission controls |
| 52 | Counted task handles own typed cached results; scheduler/scope owners preserve tasks and each await returns an independent typed result owner | Sequential CI; minor roots, repeated awaits, overflow and cancelled/failed private awaits |
| 53 | Typed channels retain queued elements and transfer queue ownership into receive results; close preserves queued values | Sequential CI; blocked calls, allocation/retain failures, minor roots and cycle policy |
| 54 | C exports evaluate results once, release copied wrappers and preserve library-owned string pointers for the host | Sequential CI; conversion failure, nullable pointers, cached calls and host lifetimes |
| 55 | C library strings/records are copied into owned inputs; partial conversion protects earlier arguments and fields until transfer | Sequential CI; invalid inputs, allocation/callee traps, scalar/pointer ABI and lengthless Bytes rejection |
| 56 | Native library unload drains tasks, releases caches/runtime regions and restores host signal handlers; static archives clean at exit | Sequential CI; actual reload, finalizer order, descriptors, mappings and pthread cleanup metadata |
| 57 | Native OpenCL initialization/teardown owns the loader handle, context and queue with ordered release on failure and exit | Sequential CI; fake API controls establish ownership, not real device execution |
| 58 | Staged interpreter OpenCL owners release partial initialization before caching a failure; successful cache remains process-lived | Sequential CI; raw native/interpreter failure diagnostics and fake API lifetime controls |
| 59 | TLS server context and ALPN owners survive listener stop and raw accepted-session transfer; last session releases them | Sequential CI; real OpenSSL failures, engine agreement and full TLS stress suites |
| 60 | Library unload finalizes owned File/socket/HTTP2 descriptors and TLS sessions/caches without implicit shutdown traffic | Sequential CI; actual reload, explicit-close idempotence, host peers and cleanup omission controls |
| 61 | gRPC service listener owners protect descriptors/TLS contexts through preparation and cancellation while accepted sessions retain protocol state | Sequential CI; source gRPC/TLS behavior and precise listener cleanup controls |
| 62 | TLS client-cache publication preserves old entries and releases partial context/name owners on allocation failure; retry succeeds | Sequential CI; source TLS behavior, allocation controls and cached identity |
| 63 | ALPN packing borrows list elements without collector scratch, checks wire length and allocation, and closes a newly connected socket on failure | Sequential CI; source TLS behavior, bounds and allocation/descriptor omission controls |
| 64 | TCP preparation owns resolver results and pending descriptors through cancellation; TLS connection wrappers own sockets and SSL handshakes until transfer | Sequential CI; cancellation at each preparation boundary, refusal and cleanup omission controls |
| 65 | Compatible complete worker calls transfer record fields directly; typed aliases and trap cleanup preserve ownership, with boxed partial/dynamic captures | Sequential CI; emitted box removal, interpreter agreement and field cleanup |
| 66 | TLS peer subjects release acquired certificates, BIOs and native copy buffers on preparation failure or language String copy trap | Sequential CI; real handshakes, retry, Rust metadata agreement and omission controls |
| 67 | TLS protocol String allocation keeps its owning connection live while reading SSL-owned bytes | Sequential CI; forced major trace, actual collection, session lifetime and missing-fence control |
| 68 | Ownership probes pass valid GC metadata outputs; timer regressions exercise the merged join/drain/sort fixture under deliberate wake-order overtaking | Sequential CI; raw interpreter, preemption, stress and cleanup controls |
| 69 | Rebuilt nested loop records remain flat; original owners, progressive retains and completed fields survive failed whole-result reconstruction | Sequential CI; alias matrices, scalar bits, retain/allocation traps and omission controls |
| 70 | File construction owns raw streams before handle allocation and managed handles before path/finalizer preparation; failures close once and clear stale streams | Sequential CI; direct/scoped create/open, allocation/callback failures and finalization controls |
| 71 | Native File writes flush stdio before returning so later descriptor reads see interpreter-equivalent bytes and flush errors preserve the borrowed handle | Sequential CI; immediate visibility, short-write/flush errors and omitted-flush controls |
| 72 | File reads protect temporary buffers and owned streams, report read/write errors, and validate UTF-8 only for text; arbitrary byte reads remain binary | Sequential CI; raw interpreter errors, binary/text kinds, injected cleanup controls |
| 73 | Original resource frames are anchored before optimization and remain observable through inlining; fusion cannot interleave their cleanup | Sequential CI; parameter/local/result/error lifetimes and pure-pipeline fusion control |
| 74 | File logical alias counts live in the header independently of GC metadata; borrowed IO returns separately owned aliases and protects them during failures | Sequential CI; wide counts/overflow, GC-off close, IO traps and omission controls |
| 75 | Mandatory resource ownership releases File aliases at original frame boundaries even when ordinary reuse/freeing is disabled | Sequential CI; descriptor-bound discard, preserved parameter lifetimes, aliases and omitted-frame-drop controls |
| 76 | Scoped File callbacks return separately owned result aliases; task/loop results preserve File owners while disabled ordinary freeing still retains child storage | Sequential CI; raw interpreter/scoped/task/loop outputs, lost-owner and storage-free controls |
| 77 | Bump-heap resource aggregates use logical count metadata and drop typed File children; count metadata releases while physical value storage remains | Sequential CI; required actual WASI fstat, wide counts/overflow and scalar-bit safety; host C is separate evidence |
| 45–72 | Tasks, callbacks, aggregate/CAF contexts, native libraries, devices, networking, files and unwind | Sequential CI; escapes, cancellation and actual host behavior |
| 78 | Disabled-free aggregates/tasks/channels dispose logical metadata and File children while physical bump storage remains | Sequential CI; O1/O2 omission controls and required actual WASI in both free modes |
| 79 | Eligible field-only original record holders retain typed children without a parent box; boxed holders retain the parent | Sequential CI; original lifetime, partial-retain unwind and parent-box count control |
| 80 | File handle, count and inline path share one aligned leaf allocation; checked size includes terminator | Sequential CI; display/I/O agreement, one allocation versus two and constructor rollback |
| 81 | Last File owner closes the stream, removes weak finalizers and reclaims unshared native storage; shared/bump or disabled-free storage remains | Sequential CI; finalizer omission, reuse, freed-byte and scoped close-before-drop controls |
| 82 | Failed File construction closes raw streams and releases allocated headers; finalizer growth commits only after checked allocation succeeds | Sequential CI; constructor fault stages, retained registry, overflow and stale-finalizer controls |
| 83 | Original variant holders retain active typed payloads in structs; incoming values survive partial retains and boxed fallback | Sequential CI; tag/nullary/scalar safety, cleanup IDs and parent-box count controls |
| 84 | Whole-pattern variant holders initialize from the current scrutinee on each binding path | Sequential CI; mixed let/pattern arms, exact-once close and stale-local prevention |
| 85 | Whole-match scrutinees preserve nominal context; whole stack binders retain and drop their typed children | Sequential CI; File disposal plus HTTP/stack alias regressions and retain omission controls |
| 86 | Record pattern holders initialize borrowed typed fields from their own current scrutinee before frame retention | Sequential CI; mixed let/pattern arms, exact-once close and preserved stack binder repair |
| 87 | Nested nominal source matches discard typed File payloads at original frame exit without exhausting descriptors | Sequential CI; raw interpreter, optimized/unoptimized source, reuse/free and GC modes |
| 88 | Channel close preserves queued values; explicit receive/discard drains and breaks a counted self-cycle | Sequential CI; queue counts and normal/poison disposal; automatic cycle reclamation remains unproved |
| 89 | HTTP/2 body copying keeps the borrowed call/stream owner live while allocating from its external malloc buffer | Sequential CI; actual major collection, arbitrary bytes, finalizer lifetime and omitted-fence control |
| 90 | Negative HTTP/2 body limits clamp to zero; size, completion, reset/dead and timeout retain interpreter ordering | Sequential CI; thirteen raw interpreter/native cases, removed-clamp and borrowed-root controls |
| 91 | HTTP/2 peer subject malloc temporary remains unwind-owned through String/Option copying | Sequential CI; exactly-once release, copy traps, absent peer and no-TLS paths, omitted-cleanup controls |
| 92 | Served gRPC peer metadata has a task owner plus retained detached-sender owners; release each after child joins, protect spawning | Sequential CI; tracing off/on, child and detached callbacks, cancellation, preparation traps, overflow and leak/early controls |
| 93 | Served status messages transfer cancellation storage, stay unwind-owned through final encoding, and free normally; replaced stored statuses copy before old release | Sequential CI; final wire bytes, tracing off/on, cancellation, aliased replacement, retained context and allocation-failure/leak controls |
| 94 | Unary server receive owns dequeued request/copied status through subsequent wait; transfers only returned request or error text; reflection releases end text | Sequential CI; binary transfer, missing/extra messages, reset/cancelled wait and omitted-release controls |
| 95 | Streaming force owns received payload/status through decoding/copying; decoder failure and temporary error text unwind; first-error return transfers ownership | Sequential CI; first-error/memo behavior, decoder/copy traps, scalar/results, tracing off/on and three omission controls |
| 96 | Streamed non-status error owns its rendering scratch before formatting/trapping | Sequential CI; partial-render/final trap, exact diagnostics, tracing off/on and omitted cleanup |
| 97 | Encoded gRPC message h2_buf owns its malloc storage through cancellable flow-control waits | Sequential CI; zero/partial window cancellation, wake/resume, closed streams, exact plain/gzip frames and omitted cleanup |
| 98 | Detached sender owns request encoding scratch through encoding and cancellable send | Sequential CI; encode trap recovery, normal request bytes/end marker, simultaneous request/wire cancellation and omitted cleanup |
| 99 | Message/request encoders own canonical serialization scratch until transcoding completes or unwinds | Sequential CI; actual fixed-width/oneof bytes, partial serialization/transcoder traps, diagnostics and omitted cleanup |
| 100 | Served unary/stream/error responses own encoded buffers through cancellation; error canonical scratch owns partial serialization | Sequential CI; real parked scheduler cancellation, normal bytes, partial traps and omitted cleanup controls |
| 101 | Synchronous unary/iterator client requests own encoded buffers through encoding and cancellable sends | Sequential CI; real parked cancellation, request bytes/end marker, diagnostics and omitted cleanup controls |
| 102 | Client failure helper takes copied transport/status/iterator text and releases it after raising | Sequential CI; exact raw trap and typed GrpcError code/text, copying before release and omitted cleanup |
| 103 | Client receives own dequeued messages, status copies and decoder text across retry, callbacks and cancellation | Sequential CI; actual receive/scheduler success/retry/error/callback/cancel and first/next/decoder omission controls |
| 104 | Pending gRPC connects own address lookup, descriptor and SSL through handshake and wrapper transfer | Sequential CI; actual loopback connect/handshake cancellation, refusal/handoff and omitted fd/SSL cleanup; partial background startup remains separate |
| 105 | Background gRPC startup owns temporary and per-task reserved references until publication | Sequential CI; first/second spawn traps, actual reader/writer termination, descriptor/ref/finalizer checks and omitted reservation/startup/marker controls |
| 106 | Dynamic gRPC context restores its saved task pointer on every callback exit | Sequential CI; nested normal/typed/raw failures, actual parked cancellation and omitted unwind restore |
| 107 | Scoped TLS options have checked dynamic-scope and original inheriting-task owners | Sequential CI; structured/detached escapes, cancellation/preparation/overflow, original-context replacement, six malloc releases and three omission controls; plain tasks omit hooks |
| 108 | Response metadata captures have constructor, scope and inheriting-task owners | Sequential CI; snapshots resist later child appends, nested forwarding, typed/raw/cancel exits, failed preparation and counter acquisition; three omission controls |
| 109 | TLS pool identity preserves full fields with checked length framing | Sequential CI; delimiter collisions, every field, names beyond 1 KiB, actual key copy/pool reuse after scoped release, interpreter oracle and old-encoding rejection |
| 110 | Library teardown releases read-once environment TLS caches after tasks/finalizers | Focused GitHub CI37948869170 passes; cache immutability, task/finalizer order, ten malloc frees, reinit/idempotence and omission control; sequential CI remains required |
| 111 | Immutable TLS options pack header, strings and full key into one checked allocation | Focused GitHub CI37950759037 passes; sequential CI remains required; actual allocation/byte counts, header alignment, copied inputs, failure cleanup and existing scope/task/cache/pool controls |
| 112 | Connections preserve full addresses after aligned headers in one checked allocation | Focused GitHub CI37958243461 passes; sequential CI remains required; actual long-address loopback/pool reuse, truncation rejection, copied inputs and requested bytes against legacy short-address layout; tracing compatibility remains |
| 73–88 | Original resource frames, File owners/storage/rollback, WASM logical counts, typed record/variant holders and cycle draining | Sequential CI; original lifetimes, ambiguous contexts and shared cycle policy |

Prepared File IO borrows handles, owns returned File aliases/tuples and closes
idempotently. file.with transfers the owned callback result before scoped close;
fail/attempt retain and transfer typed error payloads before unwind. Resource
counts are mandatory even when optional reuse/freeing is disabled. Original frame
anchors preserve interpreter lifetimes rather than exposing new source syntax.

Prepared File paths use one aligned leaf allocation; final-owner disposal removes
library finalizers before unshared native storage release. Constructor failures
close streams and preserve existing registry entries. Shared/poison/no-free
storage follows its compatibility lifetime. WASM counts track logical owners and
resource disposal; physical bump storage remains allocated. Closing a channel
preserves its queued values; explicit drain can break a counted cycle. This is
not automatic cycle reclamation or general tracing-free support.

## Validation and limits

Merged contracts through #103 passed their exact-head full platform gates.
Prepared ownership extensions remain subject to their own sequential full
acceptance. Focused interpreter oracles explicitly use FWP_NO_OPT=1. Tests cover retained aliases,
scalar words resembling pointers, callback/capture ownership, conservative flags,
GC stress/verification and reuse poisoning. The interpreter/native comparison
includes observable callback and trap order.

Detailed tests, failed controls, allocation/count measurements and compiler/
hardware settings are preserved in
[history](roadmap-history.md#archived-primitive-contract-notes-through-queue18).
They are scoped reclamation evidence, not blanket speed, register-placement or
no-GC claims. Dead projected fields, retained callbacks, exception/cancellation,
unknown runtime boundaries and cycle policy remain part of phase2 acceptance.

Merged scan/iterate boundaries borrow callbacks and inputs, own initial stored
aliases and adopt subsequent callback results. Scratch storage is released
after the state sequence is built. Exceptional lifetime extensions remain
prepared work.
