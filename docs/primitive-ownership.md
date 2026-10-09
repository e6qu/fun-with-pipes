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

The table below describes the merged container baseline. Typed element and
runtime refinements remain prepared in [the queue](roadmap-queue.md); consult
[the handoff](development-state.md) for current validation.

| Primitives | Arguments in data-last order | Result / aliasing | Callback |
|---|---|---|---|
| array/map/set.from-list | share list | fresh outer storage, shared elements | none |
| array.to-list; map.keys/values/to-list; set.to-list | borrow container | shared list containing aliased elements | none |
| array.length; map.size; set.size | borrow container | scalar | none |
| array.get | borrow index, borrow array | shared Option containing an aliased element | none |
| array.set | borrow index, share value, consume array | owned optional container; failure consumes array too | none |
| array.push | share value, consume array | owned container, old/inserted elements shared | none |
| array.make | borrow count, share value | fresh container holding repeated shared value | none |
| array.generate | borrow count, share callback | fresh container, shared callback results | argument 1 |
| array.map; map.map-values | share callback, borrow container | fresh container, shared callback results; map keys alias input | argument 0 |
| array.fold | share callback, share accumulator, borrow array | accumulator or shared callback result | argument 0 |
| array.slice | borrow start, length and array | copied outer storage, aliased elements; no backing view | none |
| array.append; set.union/intersect/diff | borrow both containers | fresh outer storage, aliased elements | none |
| array.sort | borrow array | copied outer storage, aliased elements | none |
| map.empty; set.empty | none | static shared empty value | none |
| map.insert | share key, share value, consume map | owned container, aliased stored elements | none |
| map.get | borrow key, borrow map | shared Option containing aliased value | none |
| map.contains; set.contains | borrow key and container | scalar | none |
| map.remove; set.remove | borrow key, consume container | owned container; missing key can return original | none |
| map.update | share key, callback and default, consume map | owned container with shared callback result | argument 1 |
| set.insert | share key, consume set | owned container with shared key | none |

Comparison-only keys never escape into `fwp_map_find` or structural `fwp_cmp`:
these functions read values, allocate nothing and invoke no user callbacks.
Their primitive wrappers therefore omit `fwp_rc_share(key)`. Insert/update still
share keys because a key can be stored. Container callbacks in this table
still share inputs/results, including returned inputs and captured aliases.

Fresh outer storage does not imply independently owned elements. Current
container destruction frees the outer buffer; it does not recursively release
its runtime-shared elements. Aliasing metadata records which arguments or their
elements can be reachable from the result, including callback captures. Typed
container elements, retained runtime results, exceptional cleanup and cycles
remain work in [ownership.md](ownership.md). Selected leaves and compiled
closure ownership are merged as described below.

## Complete runtime sharing

Native counts1..254 fit the existing byte. At255, rare exact size_t side
entries keyed by canonical metadata slots track additional owners without new
value roots. Release, sharing, free/reuse and collection remove those entries;
count overflow traps and side-entry allocation failure exits102. Interior
references canonicalize to allocation starts. Explicit runtime sharing still
promotes the complete reachable graph; traversal overflow preserves child
counts while recursing. Large fanout no longer forces automatic sharing.

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

## Prepared refinements

These contracts are published preparations, not main support. Exact heads and
immutable parent anchors are in [the queue](roadmap-queue.md); current commands
and failures are in [the handoff](development-state.md). Each sequential PR needs
its own final rebase, focused checks and six passing exact-head full gates.

| Queue | Prepared contract | Remaining acceptance |
|---|---|---|
| 20 | repeat borrows value/count and retains each typed alias; range borrows bounds and owns fresh nodes | Sequential CI; scalar safety, overflow edges and alias reclamation; boxed128-bit payloads remain shared |
| 21 | Arrays own typed elements; get/copies retain aliases, map/generate adopt callback results, fold consumes accumulator; set/push consume container | Sequential CI; callback order, copied and unique updates, aliases and scalar safety |
| 22 | Maps/sets own typed keys/elements; copies/get retain aliases, synchronous callbacks borrow inputs/adopt results; updates consume container | Sequential CI; key identity, ordering, aliasing, scalar safety and reclamation |
| 23 | Last counted owners free storage at any age; reuse clears old marks and stays young-only for immutable updates | Sequential CI; stale-root verification, shared boundaries and reclaimed storage controls |
| 24 | task.deadline borrows/retains typed alias; task.await/within and channel receives own fresh wrappers; retained boundaries still share | Sequential CI; typed scalar/pointer safety and aliases; deeper task/queue lifetimes remain later work |
| 25 | Runtime cleanup stack releases registered owners/scoped files before failure, trap or cancellation; task switching preserves cleanup scopes | Sequential CI; exactly-once/LIFO and handler boundaries; automatic owner registration remains later work |
| 26 | Detached compiler reuse cells retain a cleanup lifetime; transfer clears holders, unused cells release lexically and on unwind | Sequential CI; old/young eligibility, flags and exceptional token paths |
| 27 | Compiler call liveness protects actual owned references before later argument failures and at callee entry; boxed/worker and variant cleanup remain typed | Sequential CI; exactly-once release, aliases and cancellation before entry tick |
| 28 | Runtime application owns its function and pending typed arguments until transfer/return; unwind releases them, and callers protect stack captures | Sequential CI; overapplication, scalar safety, primitive traps and cancelled entry |
| 29 | Map protects completed typed results and the partial spine until transfer, releasing them and scratch on unwind | Sequential CI; dynamic/direct/captured callbacks, scalar safety and allocation-failure ownership |
| 30 | Filter/take-while protect typed selected aliases and partial result spines until transfer; unwind releases scratch and owned selections | Sequential CI; predicate order, retained aliases, scalar safety and partial construction |
| 31 | zip-with protects completed typed results and partial spines; both borrowed scratch buffers release on unwind, including second-buffer failure | Sequential CI; aliases, scalar safety, callback traps, allocation failure and cancellation |
| 32 | Fold retains its current accumulator until transfer, releases right-fold scratch on unwind and protects each borrowed argument duplicate during preparation | Sequential CI; aliases, partial duplicate failure, scalar safety and overapplication |
| 33 | Loop protects counted current state at first/later cancellation safe points and owns Step through payload preparation | Sequential CI; flattened/nested state, aliases, scalar safety and payload-retain failures |
| 34 | Typed argument/capture preparation owns each completed duplicate; closure construction retains its empty cell until captures succeed, then transfers pending arguments | Sequential CI; partial duplicate failures, aliases and pending owned arguments |
| 35 | Constructors protect consumed typed fields before allocating storage; caller owners stay separate until actual transfer | Sequential CI; record/variant allocation failures, aliases and IR transfer checks |
| 36 | Owned worker record/variant results keep typed field owners until boxing succeeds; remaining caller owners stay protected | Sequential CI; boxing allocation failures, external aliases and nested typed fields |
| 37 | Boxed-to-worker wrappers protect original arguments before preparation and each completed typed field duplicate until worker entry | Sequential CI; partial retention failure, boxed/scalar arguments, aliases and worker entry transfer |
| 38 | Eligible loop state stays flattened through RC preparation; initial boxed input and each completed typed field duplicate stay owned until transfer | Sequential CI; partial field failures, cancellation slots, aliases and trap/evaluation order |
| 39 | Multi-field typed retains protect each completed extra reference; caller liveness excludes unfinished retains through count overflow | Sequential CI; partial variant/stack retains, wide-count overflow and live aliases |
| 40 | Monomorphic context supplies missing nested constructor/field temporary types; inferred expression types remain authoritative | Sequential CI; later-field failure, dynamic arguments, updates and exact IR type checks |
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

Merged contracts through #93 passed their full platform gates. Rebased focused
checks for prepared rows16–22 pass with explicit FWP_NO_OPT=1 raw interpreter
oracles; all sequential full gates remain required. Tests cover retained aliases,
scalar words resembling pointers, callback/capture ownership, conservative flags,
GC stress/verification and reuse poisoning. The interpreter/native comparison
includes observable callback and trap order.

Detailed tests, failed controls, allocation/count measurements and compiler/
hardware settings are preserved in
[history](roadmap-history.md#archived-primitive-contract-notes-through-queue18).
They are scoped reclamation evidence, not blanket speed, register-placement or
no-GC claims. Dead projected fields, retained callbacks, exception/cancellation,
unknown runtime boundaries and cycle policy remain part of phase2 acceptance.

Main through PR #95 also borrows scan/iterate callbacks and inputs, owns
initial stored aliases and adopts subsequent callback results; scratch
storage is released after the state sequence is built. Exceptional lifetime
extensions remain prepared work.
