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

The tables describe accepted main through PR #125. Arrays, maps and sets own typed elements.
The finite review records explicit compatibility fallbacks; [the queue](roadmap-queue.md) retains delivered preparation anchors.

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
| array.sort | borrow array | copied sorted storage retaining typed aliases | none |
| array.append | borrow both arrays | copied storage retaining typed aliases | none |

Array destruction releases typed children before outer storage; views release
their retained backing owner at the last reference. Nested views flatten their
backing owner, and small slices copy to limit retention. Scalar fields
are skipped; boxed128-bit payloads retain their compatibility lifetime. Immutable
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

Comparison-only keys never escape into fwp_map_find or structural fwp_cmp;
these functions read values, allocate nothing and invoke no user callbacks.
Their wrappers omit fwp_rc_share(key). Typed destruction releases keys/elements
before buffers and outer storage. Copies retain aliases; replacement/removal
releases displaced owners. Scalar payloads are skipped and boxed128-bit values
retain their compatibility lifetime. Ordering, key identity and immutable
aliases are preserved. Unmodeled callbacks retain explicit sharing and conservative roots.

## Registered unwind cleanup

The merged runtime cleanup stack releases registered owners and scoped files in
LIFO order before failure, trap or cancellation invalidates their frames. It
stops at the catching handler boundary; task switches preserve separate chains.
Normal transfer unlinks registrations without releasing a transferred value.
Compiler caller/reuse-token and runtime application/capture-preparation cleanup
are merged through PR107 after all exact-head gates. Selected compiler, runtime and synchronous callback registrations are accepted
through PR124. Unmodeled runtime boundaries retain compatibility roots; this is not
complete exceptional ownership or tracing-free support.

## Conservative reconstruction and external boundaries

Accepted PR124 inventories375 declarations,365 runtime symbols and40 aliases:
168 ownership contracts,19 combinators lowered to ordinary IR,11 flat scalar
signatures and177 review declarations covering167 symbols. Scalar signatures can
still allocate external state; descriptor availability does not prove counted
ownership of a reconstructed graph. The declaration audit passes all production
gates. The finite fallback classification passes against the actual accepted source;
the handoff records its exact gates and acceptance proof.

Unknown primitive, foreign and remote boundaries keep explicit sharing in
[src/ownership.rs](../src/ownership.rs). The finite review records argument,
result, callback, retention, teardown and cycle policy for every remaining
boundary; it does not establish tracing-free eligibility.

| Boundary | Current lifetime policy |
|---|---|
| JSON/CSV/protocol and descriptor decoding | Reconstructed or cached graphs retain compatibility roots; typed child transfer and partial-construction ownership require explicit contracts |
| Remote values and memoized decoding | Preserve retained context/cache owners and independent reader aliases; scratch cleanup alone does not count decoded nodes |
| Foreign values and retained callbacks | Keep explicit sharing unless host lifetime and teardown are proved |
| list.flat-map and list.ap | Borrow typed synchronous inputs, adopt owned callback results and own copied spines; partial results, scratch and unwind cleanup pass PR124 controls |
| State handlers | Typed get/put/modify/run-state ownership and task scope chains pass PR124 aggregate, capture and nonlocal-exit controls; legacy/unmodeled payloads retain fallback |
| External resource contexts | Original scoped/task owners preserve teardown order; counted C context storage does not by itself prove ownership of every fwp graph |

Channel close preserves queued values. Explicit drain breaks the tested counted
cycle, while unreachable shared cycles still need tracing. Preserve callback,
trap and task ordering when extending contracts. Phase2 verifies this documented
compatibility model; phase6 must separately prove tracing-free eligibility and
its cycle policy. Older373-declaration classifications and prepared-only notes
are archived in history rather than supplying current priorities.

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
PR122 also retains spawn/deadline captures through entry, completion or
cancellation and protects scope results through joining and unwind. Counted
task handles own typed cached results; repeated awaits return separate owners.
Typed channels retain queued elements and transfer them on receive; close
preserves the queue. These contracts do not establish automatic cycle
reclamation, complete ARC or tracing-free execution.

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

## Accepted ownership review

The finite177-declaration/167-symbol fallback review passes against the actual
merged source. All168 explicit contracts and remaining IR/flat boundaries are
inventoried. Original preparation and accepted binary/GC/reuse/omission controls
are retained in history and the immutable queue. Natural-width numeric
representation is accepted. Checked native ARC has a separate eligibility
contract in [ownership](ownership.md); no blanket no-GC claim is established.

## Validation and limits

Merged contracts and the finite coverage review passed their exact-head full
platform gates and actual merged-source acceptance. Focused interpreter oracles explicitly use FWP_NO_OPT=1. Tests cover retained aliases,
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
after the state sequence is built. Unmodeled retained/runtime callbacks keep
explicit sharing and conservative roots.
