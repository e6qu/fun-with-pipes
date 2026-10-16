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
values and context have scoped cleanup. Raw pointers, retained unknown callbacks
and managed C addresses do not establish complete lifetime proofs.

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

Comparison-only keys never escape into fwp_map_find or structural fwp_cmp;
these functions read values, allocate nothing and invoke no user callbacks.
Their wrappers omit fwp_rc_share(key). Typed destruction releases keys/elements
before buffers and outer storage. Copies retain aliases; replacement/removal
releases displaced owners. Scalar payloads are skipped; boxed I128/U128 values
retain and release typed leaf references. Ordering, key identity and immutable
aliases are preserved. Unmodeled callbacks retain explicit sharing and conservative roots.

## Registered unwind cleanup

Cleanup registrations record owners acquired so far, so a failure during the
next allocation does not lose them. LIFO means last acquired, first released.

The merged runtime cleanup stack releases registered owners and scoped files in
LIFO order before failure, trap or cancellation invalidates their frames. It
stops at the catching handler boundary; task switches preserve separate chains.
Normal transfer unlinks registrations without releasing a transferred value.
Compiler caller/reuse-token, runtime application/capture preparation and
synchronous callback registrations preserve partially acquired owners. Unmodeled runtime boundaries retain compatibility roots; this is not
complete exceptional ownership or tracing-free support.

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
| Remote values and memoized decoding | Preserve retained context/cache owners and independent reader aliases; scratch cleanup alone does not count decoded nodes |
| Foreign values and retained callbacks | Keep explicit sharing unless host lifetime and teardown are proved |
| list.flat-map and list.ap | Borrow typed synchronous inputs, adopt owned callback results and own copied spines; partial results, scratch and unwind cleanup have partial-result and failure controls |
| list.transpose | Borrow rows, retain typed element aliases and own new row/outer list nodes; row cursors, completed-column storage and partial columns are released on success or failure; ragged input stops at its shortest row |
| State handlers | Typed get/put/modify/run-state owners; finite callback-flow proof admits State operations only under a handler. Returned closures require a fresh handler when called; unknown targets are rejected by ARC |
| term.read-secret | Borrow unit, return an owned optional string; restore terminal echo on return and unwinding |
| process.run-input / process.call | Borrow input/argument strings until the child finishes; captured status/output record owns both copied strings, while call returns an immediate status. Registered cleanup owns temporary buffers, pipe endpoints and child-process resources |
| External resource contexts | Original scoped/task owners preserve teardown order; counted C context storage does not by itself prove ownership of every fwp graph |

Channel close preserves queued values. Explicit drain breaks the tested counted
cycle, while unreachable shared cycles still need tracing. Checked ARC now admits
data-only channel payloads: no functions, tasks or channel handles at any nested
position. The queue owns each retained message and the last channel owner releases
remaining messages; the type restriction prevents a queue from owning a path
back to its channel. Preserve callback,
trap and task ordering when extending contracts. The finite review classifies this compatibility model. Checked native ARC separately enforces its proved eligibility
and cycle policy, rejecting unproved shared boundaries.

## Complete runtime sharing

Sharing promotes the reachable graph to the tracing lifetime policy. It is
different from merely increasing an exact reference count.

Native counts 1–254 fit the existing byte. At 255, rare exact size_t side
entries keyed by canonical metadata slots track additional owners without new
value roots. Release, sharing, free/reuse and collection remove those entries;
count overflow traps and side-entry allocation failure exits with status 102. Interior
references canonicalize to allocation starts. Explicit runtime sharing still
promotes the complete reachable graph; traversal overflow preserves child
counts while recursing. Large fanout no longer forces automatic sharing.

Eligible counted storage reclaims at last release at any age. Returning a cell
clears old marks; verification clears stale child words before linking the free
slot. In-place record reuse/updates retain their young-cell restriction. Shared runtime graphs remain on tracing. The tracing churn fixture explicitly
disables both counted freeing and reuse so real collection remains tested.

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
| parse-int; parse-float | Borrow input text; result remains shared, including boxed numeric cases |

Character, codepoint and byte-list conversions release their temporary arrays
once the list is constructed. Those arrays use `fwp_mem_alloc`/`fwp_mem_free`:
native arrays remain scanned while alive, and WASI uses a separately releasable
allocation rather than freeing an interior pointer from its bump heap.

## Task result and deadline boundaries

The runtime owns fresh typed result wrappers from task.await, task.within and
Channel receives. Wrappers retain pointer-bearing payload owners; scalar words
do not select reference destructors. task.deadline borrows its typed argument
and retains the returned alias instead of forcing it into runtime sharing.
It also retains spawn/deadline captures through entry, completion or
cancellation and protects scope results through joining and unwind. Counted
task handles own typed cached results; repeated awaits return separate owners.
Typed channels retain queued elements and transfer them on receive; close
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
- `CopiedSpine`: new list cells retain borrowed elements.
- `FreshOuter`: one new wrapper retains its pointer-bearing fields.
- `FreshTree`: every reachable allocation is new and independently owned.

None needs no allocation. These contracts preserve aliasing and immutable values;
they do not establish complete exception or retained-callback ownership.

Repeat borrows value/count and retains each typed alias in fresh counted list
nodes. Range borrows bounds and owns fresh nodes and wide numeric elements;
pending elements and completed spines release on unwind. Scalar words never
select reference destructors.

## Accepted ownership review

The immutable baseline and exact contract promotions distinguish counted
boundaries from reviewed tracing requirements. Preparation and historical
binary/GC/reuse/omission controls remain in [history](roadmap-history.md).
Checked native ARC has a separate [eligibility contract](ownership.md); no
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
