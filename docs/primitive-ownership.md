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
| 16 | sort-by borrows callback/input, owns typed keys and copied result; keys evaluate once in input order | Sequential CI; alias/capture keys, scalar safety and exceptional cleanup |
| 17 | scan/iterate retain initial state and adopt later owned callback states; callbacks borrow earlier stored outputs | Sequential CI; empty/nonpositive cases and failure cleanup |
| 18 | loop consumes state, transfers callback input, retains selected Step payload before destroying Step; workers dispose typed boxed input | Sequential CI; flattened state, traps, scalar root fences and exceptional cleanup |
| 19 | zip/unzip/chunks borrow inputs, build counted nested structure, duplicate typed borrowed elements and release scratch | Sequential CI; retained aliases, scalar safety and chunk validation order |
| 20 | repeat borrows value/count and retains each typed alias; range borrows bounds and owns fresh nodes | Sequential CI; scalar safety, overflow edges and alias reclamation; boxed128-bit payloads remain shared |
| 21 | Arrays own typed elements; get/copies retain aliases, map/generate adopt callback results, fold consumes accumulator; set/push consume container | Sequential CI; callback order, copied and unique updates, aliases and scalar safety |
| 22 | Maps/sets own typed keys/elements; copies/get retain aliases, synchronous callbacks borrow inputs/adopt results; updates consume container | Sequential CI; key identity, ordering, aliasing, scalar safety and reclamation |
| 23 | Last counted owners free storage at any age; reuse clears old marks and stays young-only for immutable updates | Sequential CI; stale-root verification, shared boundaries and reclaimed storage controls |
| 24 | task.deadline borrows/retains typed alias; task.await/within and channel receives own fresh wrappers; retained boundaries still share | Sequential CI; typed scalar/pointer safety and aliases; deeper task/queue lifetimes remain later work |
| 25 | Runtime cleanup stack releases registered owners/scoped files before failure, trap or cancellation; task switching preserves cleanup scopes | Sequential CI; exactly-once/LIFO and handler boundaries; automatic owner registration remains later work |
| 26 | Detached compiler reuse cells retain a cleanup lifetime; transfer clears holders, unused cells release lexically and on unwind | Sequential CI; old/young eligibility, flags and exceptional token paths |
| 27 | Compiler call liveness protects actual owned references before later argument failures and at callee entry; boxed/worker and variant cleanup remain typed | Sequential CI; exactly-once release, aliases and cancellation before entry tick |
| 28 | Runtime application owns its function and pending typed arguments until transfer/return; unwind releases them, and callers protect stack captures | Sequential CI; overapplication, scalar safety, primitive traps and cancelled entry |
| 29–72 | Tasks, callbacks, aggregate/CAF contexts, native libraries, devices, networking, files and unwind | Sequential CI; escapes, cancellation and actual host behavior |
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
