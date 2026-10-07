# Native primitive ownership contracts

`src/ownership.rs` is the shared boundary inventory used by IR counting and
native code generation. Its container inventory covers every array/map/set
primitive declared in `lib/collections.fwp`; a coverage check detects newly
added declarations without contracts. All 31 string-module declarations and seven byte primitives now have contracts;
every task/channel foreign declaration is now inventoried too. Selected typed
result ownership is listed below. Other primitives, foreign
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

| Primitives | Arguments in data-last order | Result / aliasing | Callback |
|---|---|---|---|
| task.scope | borrow callback | typed owned callback result | borrowed argument 0 |
| task.within | borrow duration/thunk; runtime retains one counted owner | fresh Option holding a shared task result | retained argument 1 |
| task.spawn | borrow thunk; runtime retains one counted owner | shared task handle/result | retained argument 0 |
| array.from-list | borrow list | fresh array owning typed element references | none |
| map/set.from-list | borrow list | owned storage with selected typed key/value references | none |
| array.to-list | borrow array | fresh owned list with typed element aliases | none |
| map.keys/values/to-list; set.to-list | borrow container | owned list/pairs with typed element aliases | none |
| array.length; map.size; set.size | borrow container | scalar | none |
| array.get | borrow index, borrow array | fresh owned Option with a typed element alias | none |
| array.set | borrow index/value, consume array | owned optional array; replacement releases old element; failure consumes array | none |
| array.push | borrow value, consume array | owned array with typed old/inserted elements | none |
| array.make | borrow count/value | owned array with repeated typed references | none |
| array.generate | borrow count/callback | owned array with owned callback results | borrowed argument 1 |
| array.map | borrow callback/array | owned array with owned callback results | borrowed argument 0 |
| map.map-values | borrow callback/map | owned map with retained keys and owned callback results | borrowed argument 0 |
| array.fold | borrow callback/array, consume accumulator | owned accumulator or callback result | borrowed argument 0 |
| array.slice | borrow start, length and array | copied storage with typed owned element aliases | none |
| array.append | borrow both arrays | copied storage with typed owned elements | none |
| set.union/intersect/diff | borrow both sets | owned storage with typed selected key aliases | none |
| array.sort | borrow array | copied storage with typed owned element aliases | none |
| map.empty; set.empty | none | static shared empty value | none |
| map.insert | borrow key/value, consume map | owned map; equal key retains original key, replaces/releases old value | none |
| map.get | borrow key/map | fresh owned Option with a typed value alias | none |
| map.contains; set.contains | borrow key and container | scalar | none |
| map.remove; set.remove | borrow key, consume container | owned container; missing key can return original | none |
| map.update | borrow key/callback/default, consume map | owned map with owned callback result | borrowed argument 1 |
| set.insert | borrow key, consume set | owned set with typed stored keys | none |

Comparison-only keys never escape into `fwp_map_find` or structural `fwp_cmp`:
these functions read values, allocate nothing and invoke no user callbacks.
Their primitive wrappers therefore omit `fwp_rc_share(key)`. Insert/update retain keys by type only when stored. Synchronous container
callbacks borrow inputs and produce owned results, including input aliases and
closures capturing them. Prepared task.spawn retains a counted thunk owner;
other retained runtime callback boundaries still share.

Native arrays/maps/sets own typed elements and release them before outer
storage. Unmodeled runtime containers retain their conservative shared fallback. Aliasing metadata records which arguments or their
elements can be reachable from the result, including callback captures. Complete runtime-owned element coverage, retained results, exceptional
cleanup and runtime cycles remain separate work in [ownership.md](ownership.md).

## Complete runtime sharing

High-fanout counts stay exact through rare wide metadata. Explicit runtime
sharing promotes the whole reachable graph, not just the parent. Interior references are canonicalized to the allocation's
start before traversal. When the fixed traversal stack fills, recursive
promotion begins while the child is still counted; clearing it first would
skip its descendants. These transitions preserve the same alias protection
as primitive sharing.

## Evidence and remaining work

`tests/ownership.rs` checks interpreter/native agreement for record keys,
returned aliases, callbacks returning inputs and capturing them, failed
`array.set`, missing-key removal and updates with retained aliases. Native runs
use collection stress/verification and reuse poisoning. Generated wrappers must
borrow comparison keys and share inserted keys.

A runtime regression creates enough aliases to overflow the byte count,
explicitly hands the parent to a retained runtime callback, then attempts an
update of its reachable child. Restoring the unsafe parent-only saturation
behavior corrupts the value observed through another alias; explicit complete
graph sharing preserves it. The same regression protects interior
references and a 70-branch graph exceeding the traversal stack's capacity.

A second regression performs 10,000 updates of a nine-field record following a
map lookup. It compares identical generated code with only the previous key
sharing boundary restored. Stack placement is disabled to expose heap behavior;
all other ownership optimizations remain enabled. On the local Apple Silicon
host with Apple Clang 17.0.0 (`clang-1700.4.4.1`), `arm64-apple-darwin24.6.0`
and `-O1`, counters report 0.8 MiB allocated with sharing and
0.0 MiB with borrowing (one-decimal counter precision), with identical output.
Full architecture gates and benchmark equivalence are still required on CI.
This is an allocation result, not a timing or register-placement claim.

A three-field loop state retaining a key and map across update evaluation still
keeps an extra reference to the key until the remaining map field is read. That
prevents key reuse even with a borrowing comparison boundary. Later IR work
should release dead projected fields earlier while preserving argument order,
branch behavior and aliases; do not confuse this with runtime key retention.

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

`tests/leaf_ownership.rs` compares interpreter/native behavior for retained
aliases, no-op padding/replacement, copied slices/concatenation and byte identity,
at `-O1`/`-O2`, under collection stress/verification and both reuse-poison modes. A 10,000-step
copy loop, with tracing disabled and zero collections, reports 0.9 MiB freed by counts versus 0.0 MiB when `FWP_FREE=0`, with
identical output (Apple Silicon, Apple Clang 17, `-O1`, counter precision 0.1 MiB).
Five focused FFI checks also pass. Full CI on both architectures remains required.

Selected copied text Options/lists are owned as described below. Retained
callback/container values and other runtime-created results remain shared.
This change does not complete phase 2 or establish general execution without GC.

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

`tests/text_ownership.rs` checks retained inputs, Unicode, empty/missing/invalid
results, byte conversions, split/join and nested destruction against the
interpreter at `-O1`/`-O2`, GC stress/verification and both poison modes. A word-list
loop with tracing disabled frees 2.1 MiB by counts versus 0.0 MiB when freeing is
disabled, with the same output. Restoring only the previous temporary-buffer lifetimes raises the conversion
loop's committed native heap from 1.7 MiB to 9.2 MiB, with tracing off and identical
output. Both counter comparisons used Apple Silicon, Apple Clang 17 and `-O1`. Full CI remains required before merging.

IO/network-generated strings and result graphs, retained callbacks, stack captures,
container element ownership and exceptional cleanup remain work. Complete text
contract coverage does not mean every text result has counted ownership.

## Closure entries

Compiled dynamic calls use an owned entry with typed capture duplication and
release. Primitive entries preserve borrowed arguments through allocation and
release them after obtaining the result; consumed container arguments are
transferred. Calls from runtime callbacks keep a separate sharing entry, which
promotes typed inputs and the result to conservative runtime management.
Function table metadata exists only for live functions used as closure values;
it does not change source currying or pipe semantics. See [ownership.md](ownership.md)
for evidence and the remaining capture/exceptional-cleanup gaps.

## Borrowed dynamic callback foundation

Owned function metadata also describes duplication of a borrowed argument slice
by monomorphic parameter type. `fwp_apply_borrowed` retains the original function
owner, duplicates only pointer-bearing supplied parameters and consumes those
copies through the owned entry. Partial application transfers copies into a new
closure. Overapplication splits at each actual function's arity and uses the
returned function's types for the next slice; scalar bits are never used to guess
pointer ownership. Returned aliases carry an owned reference. Entries without
metadata retain the conservative runtime-sharing fallback.

The extra argument-helper pointer increases native owned metadata from two to
three pointers per live closure function (16 to 24 bytes on 64-bit targets).
The main function-table row remains 32 bytes; no runtime performance claim is
made. The synchronous list paths below use this foundation; retained runtime callbacks
keep sharing.
`tests/borrowed_callbacks.rs` checks the generated String/I64 argument metadata,
scalar bits resembling an allocation, exact and partial calls, overapplication
across a scalar-to-function boundary, captured/input aliases and a stack callback
at O1/O2 with collection stress/verification and both reuse-poison settings.

## Synchronous owned map results

`map` borrows the callback and input list. Its explicit Borrowed callback
contract proves synchronous invocation without retaining the function itself;
other callbacks keep Shared contracts. Escape analysis uses that proof only
for the function slot, never for every borrowed argument. The result has a
FreshSpine contract: new counted list nodes containing already-owned callback
results. Callback results may alias inputs/captures or be functions; neither
child counts nor shared children are reset. FreshTree is inappropriate here.

Generic map invokes the typed borrowed entry. Direct and captured HOF variants
still call statically known functions, taking typed argument copies per iteration.
Known partial callbacks hidden behind counted locals retain specialization.
Original callback/list addresses and captured pointer values stay roots through
allocating calls. Result buffers use separately releasable memory and transfer
owned element references into new nodes before release. The interpreter and
legacy uncounted execution retain their existing behavior.

`tests/map_ownership.rs` covers retained inputs, newly allocated captures,
identity/constant aliases, partial callbacks returning functions, dynamic
callbacks and scalar/aggregate results at O1/O2, stack on/off, collection stress
and verification, and both poison modes. A selected 10,000-step loop compares
identical generated code with only the old shared-result boundary restored:
zero collections, identical output, 2.7 MiB freed by counts versus 4.6 MiB for
owned map results (Apple Silicon, Apple Clang 17, O1, 0.1 MiB precision).
This is reclamation evidence, not a timing claim. Full CI and benchmarks remain
required. Other list/container callbacks, retained runtime callbacks, cycles,
exceptional cleanup, exact overflow counts and WASI reclamation remain work.

## Synchronous owned filter results

`filter` has the same explicit synchronous borrowed callback policy as map,
while its result spine contains selected aliases of input elements. A predicate
consumes typed temporary argument copies and returns Bool. Selection therefore
acquires an additional reference by the actual element parameter type before
transferring it into a result node. Pointer-bearing functions/aggregates are
counted; inline scalars are not guessed from their bits. Unknown function entries
retain conservative sharing. Direct and captured predicate loops preserve
specialization and address fences. Scratch storage is explicitly released.

`tests/filter_ownership.rs` checks retained input/capture aliases, selected
functions with shared captures, dynamic predicates, scalar elements, empty
inputs and no matches at O1/O2, stack on/off, GC stress/verification and both
poison settings. A selected no-tracing differential changes only the returned
spine's shared-result boundary: identical output and zero collections,
4.6 MiB freed by counts versus 5.0 MiB for owned filter results (Apple Silicon,
Apple Clang 17, O1, counters rounded to 0.1 MiB). Full platform and benchmark gates
remain required before merge; retained callbacks and exceptional cleanup remain.

## Synchronous fold accumulator transfer

`fold` borrows its callback/list and consumes one owned accumulator reference.
It returns an OwnedAccumulator result, possibly an input/capture alias; an empty
list returns the supplied accumulator unchanged. It is neither a fresh tree nor
a fresh spine. The borrowed application helper accepts an owned prefix, avoids
duplicating transferred arguments, and carries any remaining prefix across
partial/overapplication boundaries. Ordinary borrowed calls use prefix zero.

Direct/captured fold loops keep specialization: captures and elements acquire
typed argument copies, the accumulator transfers, and callbacks return its
replacement. Original callback/capture/list addresses remain roots until return.
Unknown entries retain sharing. New two-argument callback wrappers distinguish
accumulator transfer from map/filter's borrowed arguments.

`tests/fold_ownership.rs` covers accumulator/input/capture aliases, empty inputs,
function accumulators, dynamic and captured callbacks at O1/O2, stack on/off,
GC stress/verification and both poison modes. The callback runtime probe adds
owned-prefix exact/partial/overapplication and zero supplied arguments. A selected
no-tracing differential restores only generic/specialized callback result sharing:
identical output and zero collections, 1.3 MiB freed by counts versus 1.8 MiB with
transfers (Apple Silicon, Apple Clang 17, O1, 0.1 MiB precision). Restoring only an
unused generic path produced no difference; the final probe covers the executed
specialized path too. Full platform/benchmark gates remain required. Fold-right,
zip-with, retained callbacks and exceptional cleanup are separate work.

## Synchronous zip-with ownership

`zip-with` borrows its callback and both lists. Generic calls duplicate arguments
according to their distinct concrete types; direct/captured loops retain static
specialization. New list spines contain already-owned results, including aliases
of either input/captures or returned partial functions. Both temporary input/result
buffers are explicitly released, with original callback/list/capture roots kept
through allocating calls. Callback order, argument order and truncation at the
shorter list are unchanged. Borrowed direct callback wrappers now support one or
two supplied arguments; fold's transferring wrapper stays separate.

`tests/zip_ownership.rs` checks retained aliases, mixed String/I64 inputs, dynamic
and captured functions, empty/unequal lists and returned-function aliases at
O1/O2, stack on/off, GC stress/verification and both poison modes. A selected
no-tracing differential changes only result sharing: identical output and zero
collections, counts free 2.2 MiB versus 3.6 MiB with owned results (Apple Silicon,
Apple Clang 17, O1, 0.1 MiB precision). Full CI/benchmark gates remain required;
other runtime callbacks and exceptional cleanup remain in phase 2.

## Owned spans and right-fold transfer

Borrowed application can transfer a contiguous span of supplied arguments,
duplicating only typed slices before/after it. Span positions and lengths adjust
at each actual function boundary during overapplication. Prefix transfer remains
a wrapper; ordinary borrowing has an empty span. Zero-argument calls avoid null
pointer arithmetic. `fold-right` borrows callback/list, consumes the accumulator,
and transfers callback argument 1 while borrowing argument 0. Empty input returns
the original owned accumulator. Direct/captured right-fold loops keep specialization.
The input scratch buffer remains a root and is explicitly released on completion.

`tests/right_fold_ownership.rs` covers input/capture/accumulator aliases, returned
functions, empty input and dynamic/captured callbacks at O1/O2, stack on/off,
GC stress/verification and both poison modes. Interpreter agreement verifies
right-to-left callback behavior. The runtime probe transfers an owned second
argument across a scalar-to-function overapplication boundary. A selected
no-tracing differential restores only generic/specialized result sharing:
identical output, zero collections, 1.3 MiB freed by counts versus 1.8 MiB with
transfers (Apple Silicon, Apple Clang 17, O1, 0.1 MiB precision). Full CI/benchmarks
remain required; retained callbacks, exceptions and remaining primitive boundaries
still rely on conservative runtime ownership.

## Synchronous prefix and suffix ownership

`take-while` and `drop-while` borrow their callback and source list without
retaining the function beyond the call. Predicates consume typed temporary
copies and stop at the first rejected element. Direct and captured specialized
loops preserve this order and keep original allocation addresses live across
allocating callbacks.

`take-while` duplicates each selected element's typed reference, builds fresh
owned list nodes and releases its scanned temporary buffer. `drop-while` returns
one owned reference to the remaining tail, including the unchanged-input path;
the source owner's cleanup must not reclaim that tail. An empty suffix needs
no count. The result contract records argument 1 as the possible alias.

`tests/prefix_ownership.rs` checks empty/all/no-match cases, dynamic predicates,
function elements, retained aliases, results used after source cleanup and a
predicate that would trap if invoked after the first rejection. Interpreter and
native outputs agree at O1/O2 with stack allocation both ways, collection
stress/verification and both reuse-poison modes. The identical no-tracing loop
frees 8.2 MiB by counts versus 5.0 MiB after restoring prefix and suffix result
sharing in generic and specialized paths (Apple Silicon, Apple Clang 17, O1,
0.1 MiB counter precision, zero collections). Full platform CI remains required;
this does not establish general no-tracing execution.

## Typed ordinary list copies and suffixes

`reverse`, `take`, `append`, `flatten` and `drop` borrow their arguments.
CopiedSpine distinguishes new nodes containing aliases of borrowed elements from
FreshTree (independent copies) and FreshSpine (already-owned callback results).
The generated monomorphic wrapper owns each new node and duplicates only
pointer-bearing element references according to its List element type. It
never examines scalar bits to decide ownership.

`append` copies the subject's nodes and ends at its other list argument. The
wrapper stops at that existing suffix and acquires one reference to it, including
the empty-subject path. `drop` likewise returns one owned reference to the
remaining suffix; negative/zero counts retain the original list, and past-end
counts return Nil. Neither operation resets counts on aliased nodes.

Copies use separately releasable, scanned temporary buffers where needed;
reverse constructs directly without a buffer. Flatten keeps its outer source
and intermediate results rooted while copying inner lists and releases both
outer and per-inner scratch storage. Original input addresses remain live
through allocating calls. Tracked effects, count clamping and pipe order stay
unchanged. Head, tail and last remain their existing language implementations.

`tests/list_copy_ownership.rs` checks string/function elements, retained aliases,
results after input cleanup, nested flattening, append's shared suffix,
empty/negative/zero/oversized cases and scalar elements. Interpreter/native
outputs agree at O1/O2, stack on/off, collection stress/verification and both
reuse-poison settings. An identical no-tracing loop frees 13.6 MiB by counts
versus 7.3 MiB after restoring result sharing in all five emitted wrappers
(Apple Silicon, Apple Clang 17, O1, 0.1 MiB precision, zero collections).
This is reclamation evidence; full platform and benchmark gates remain required.

## Optional list aliases and synchronous find

`nth`, `find` and `index-of` borrow their arguments and own newly allocated
Option nodes. FreshOuter identifies one new structural allocation whose fields
may alias borrowed inputs: the generated wrapper duplicates pointer-bearing
fields by monomorphic constructor type and leaves scalar words alone. This
is distinct from FreshTree, which owns an independent allocation tree. None
requires no allocation or count.

`nth`/`find` acquire one reference to the selected input element. `index-of`
returns an owned optional scalar and borrows its comparison key. Negative or
past-end indices, empty inputs and missing values preserve existing behavior.
Find predicates use synchronous borrowed application, stop at the first match
and do not retain the callback. Direct/captured specializations keep typed
argument copies, selected-element references and original source/capture roots.

`tests/list_option_ownership.rs` checks retained aliases, selected functions,
results after input cleanup, dynamic/captured predicates, missing/negative/
past-end/empty cases, scalar elements and a predicate that traps if invoked
after a match. Interpreter/native outputs agree at O1/O2, stack on/off,
collection stress/verification and both reuse-poison settings. The no-tracing
loop frees 10.4 MiB by counts versus 9.6 MiB after restoring only optional-result
sharing in generic and specialized paths (Apple Silicon, Apple Clang 17, O1,
0.1 MiB precision, zero collections). Full platform CI remains required.

## Exact reference counts above the byte range

Native count metadata remains one byte per allocation: 0 means shared, 1..254
are inline counts, and 255 identifies an exact size_t count in rare side metadata.
Entries use canonical count-slot addresses, not value addresses, and live outside
the value heap. The collector metadata mapping is stable; these keys do not add
language-value roots. The fixed 256-bucket table adds 2 KiB on 64-bit native
platforms; each active wide entry holds three words (24 bytes before allocator
overhead). Normal objects need no new allocation.

Duplication above 254 allocates/increments one wide entry. Decrementing back to
254 removes it. Generated typed destruction and closure work-list cleanup use
one release helper so wide counts cannot be decremented as bytes. The ordinary
last-reference predicate retains its existing non-consuming behavior. Raw drops
retain their conservative outer-count behavior. Size_t overflow traps explicitly;
side-entry allocation failure reports out of memory rather than silently sharing.

Explicit graph sharing, runtime freeing, slot/chunk reuse and GC sweeping clear
wide entries, including empty chunks and big allocations. High fanout alone no
longer promotes descendants to tracing-managed sharing. Retained runtime
callbacks still require their explicit graph-sharing boundary.

`tests/wide_counts.rs` covers 601-reference leaf/record/function aliases,
interior count-slot canonicalization, capture cleanup, graph sharing, runtime
free/reuse, partial/empty-chunk and big-object sweep, overflow and injected OOM.
An interpreter/native high-fanout function/string fixture passes O1/O2, stack
on/off, GC stress/verification and both poison settings. The identical no-tracing
loop frees 74.8 MiB through counts versus 73.9 MiB after restoring automatic
sharing at saturation (Apple Silicon, Apple Clang 17, O1, 0.1 MiB precision,
zero collections). This is reclamation evidence, not a timing result. Complete
runtime inventories, old-object reclamation, exceptional/retained lifetimes,
cycles and WASI remain unfinished; full platform CI is required after parents.

## Sorted and unique copied spines

`sort` and `unique` borrow their source and return fresh list nodes with typed
additional references to retained elements. The existing CopiedSpine wrapper
owns only the new nodes and distinguishes scalar words from references. Sorting
retains the stable merge comparison order; unique retains the first occurrence.
Source and merge scratch buffers remain scanned across allocating operations and
are freed explicitly. The source root survives through result construction.

`tests/list_order_ownership.rs` compares retained source/result aliases, strings,
nested string lists, scalar values and empty/singleton inputs with the interpreter
at O1/O2, stack on/off, GC stress/verification and both reuse-poison settings.
The identical no-tracing loop frees 6.5 MiB by counts versus 4.7 MiB after only
sort/unique result sharing is restored (Apple Silicon, Apple Clang 17, O1,
0.1 MiB precision, zero collections). Both variants use the same scratch cleanup;
this difference measures result ownership, not scratch savings or execution speed.
Sort-by callback ownership remains separate. Full platform gates remain required.

## Synchronous sort-by key ownership

`sort-by` borrows its source and callback; callback evaluation uses the typed
borrowed-application path and returns one owned key per input element. Keys may
alias source values or captures. The generated wrapper passes its monomorphic
key destructor, or NULL for scalar keys; it never guesses ownership from bits.
FWP_FREE=0 uses the conservative raw decrement, and FWP_REUSE=0 keeps the
original sharing implementation. Keys are evaluated once in input order before
the existing stable merge sort. The copied result spine owns typed element
aliases. Scanned source/key/merge buffers stay live through allocations and are
explicitly released after their last use; key slots are cleared before release.

`tests/sort_callback_ownership.rs` checks effectful callback ordering, stable ties,
identity/allocated/nested keys, captured function values, empty/singleton inputs,
O1/O2, stack on/off, GC stress/verification and both reuse-poison modes. Both
conservative compilation switches preserve interpreter output. A C probe invokes
the actual emitted scalar-key wrapper with numeric words equal to a live counted
String address, and verifies that neither key release nor result adoption changes
that unrelated allocation's count.

The identical no-tracing loop frees 5.1 MiB by counts, versus 4.0 MiB when only
result sharing is restored and 4.7 MiB when only typed key destruction becomes
raw decrement (Apple Silicon, Apple Clang 17, O1, counters rounded to tenths,
zero collections). All variants retain the same callback and scratch-buffer
paths. This demonstrates result and key reclamation, not execution speed or
complete exception cleanup. Full platform gates remain required after parents.

## Owned scan and iterate state sequences

`scan` and `iterate` borrow their callback, initial state and list inputs. The
initial output takes an extra typed reference through actual callback parameter
metadata. Each later callback result already owns its output reference. Later
calls borrow the previous output, rather than transferring the reference stored
in that output as fold does. Repeated aliases and function states therefore
retain every earlier state. Output nodes are fresh and adopt those owned heads;
input/output scratch is scanned and released explicitly. Initial value addresses,
callbacks and input lists remain collector roots through allocating operations.

Scan returns its initial state even for an empty list. Iterate returns empty for
non-positive counts, taking no initial reference and invoking no callback; count
one returns only the initial state. Size arithmetic is checked before scratch
allocation. Conservative callback metadata retains sharing when its types are
unknown. Conservative compilation switches preserve their existing behavior.

`tests/state_sequence_ownership.rs` compares input/output aliases, unchanged and
replaced states, function states, callback effect order, empty scan and
non-positive/singleton iterate, including allocated initial values. Checks cover
O1/O2, stack on/off, collection stress/verification and both reuse-poison modes.
The no-tracing loop uses a direct head consumer to isolate sequence ownership:
7.9 MiB freed by counts versus 4.1 MiB when only scan/iterate result sharing is
restored (Apple Silicon, Apple Clang 17, O1, 0.1 MiB precision, zero collections).

An earlier map/sum consumer measured 4.1 MiB in both variants: its fused loop
still shares its list state before consuming it. That generated/runtime loop
boundary needs owned state transfer as separate phase-2 work; changing the
consumer isolates this regression, but does not fix the loop ownership gap.
Exceptional cleanup and full platform gates remain required.

## Owned normal and fused loop state

`loop` borrows the synchronous callback and consumes its state. Generic, direct
and captured callback paths transfer that state into each call. They take a typed
additional reference to the selected Step payload, then destroy the owned Step;
this preserves payloads even when the Step is shared or aliased. Captured values
borrow between iterations and get owned per-call copies. Existing tick placement
and source evaluation order are preserved. Conservative compilation switches keep
sharing/raw-drop behavior where ownership/freeing is disabled.

Known loop shapes keep state in locals and avoid Step allocation. Loading a
boxed record takes typed field references before releasing that box; nested
record fields can remain flattened. Rebuilding a nested record from its slots
owns additional child references, and its fresh outer reference replaces the
field-read's initial Dup. Otherwise field cleanup would invalidate the rebuilt
record or leave an extra outer owner. Boxed arguments passed to an unboxed
worker similarly release their original typed fields/storage after the worker
consumes duplicated fields.

Possible heap-pointer state and next-state slots have address fences across
allocating steps. Inline integers, F32/F64 and Bool fields need no root fences
and remain eligible for register promotion. Boxed numerics still need roots even
when their types have no counted destruction. Arrays start zeroed. This preserves
root safety without forcing every scalar slot into addressable storage; actual
register placement and speed still require assembly/benchmark evidence.

`tests/loop_ownership.rs` covers generic/direct/captured/optimized loops,
flattened records, shared/retained Step payload aliases, function states, effects,
O1/O2, stack on/off, GC stress/verification, poison and conservative switches.
An actual emitted scalar loop wrapper receives numerical words equal to a live
String address and leaves its count unchanged. Focused existing loop goldens
compare stdout, stderr and exit status, including nested state and traps.

The no-tracing map/sum sequence consumer now frees 8.5 MiB by counts versus
4.1 MiB after restoring only generated loop initial-state sharing. A fixture
that proves it uses boxed callback entries frees 2.7 MiB versus 1.2 MiB when
only typed boxed-to-worker argument release becomes raw outer decrement.
Both comparisons preserve other loop/sequence behavior, identical output and
zero collections (Apple Silicon, Apple Clang 17, O1, 0.1 MiB precision). An earlier
boxed counter was optimized past its intended callback entry; its 1.1/1.1 result
was not evidence of that boundary. These are reclamation results, not speed
claims or proof of exception/cancellation cleanup. Full platform gates remain
required after parent merges; old objects, retained runtime values and cycles
still prevent general execution without tracing.

## Nested structural list copies

`zip` borrows both lists and returns fresh counted list and pair nodes. Each
pair owns one typed reference to each borrowed element; unequal input lengths
still truncate to the shorter list. `unzip` borrows its pair list and returns a
fresh counted pair of fresh counted lists, each owning its selected elements.
`chunks` borrows its size and source list, builds counted outer and inner list
nodes, and owns one typed reference per element. It preserves empty inputs,
positive-size validation and failure order. The chunk count uses division and
remainder rather than overflowing a rounded-up addition.

The `CopiedStructure` contract selects wrappers with duplicate functions for
reference-bearing element types and NULL for scalar types. Existing borrowed
inputs remain live across allocation. Scratch item/output buffers are scanned
while in use and released after their values transfer into counted nodes.
Ownership-disabled builds retain the previous conservative sharing fallback.

`tests/list_structure_ownership.rs` checks retained inputs, nested lists,
function-valued elements, unequal and empty lists, large/invalid chunk sizes,
O1/O2, stack on/off, collection/reuse verification and fallback flags. Actual
emitted scalar wrappers are probed with numeric words equal to heap addresses.
With tracing disabled and identical outputs, changing only the emitted result
boundaries from owned to shared reduces count reclamation from 12.6 MiB to
8.2 MiB. This is scoped reclamation evidence, not a speed or general no-GC claim.

## Generated lists

`repeat` borrows its size and repeated value. Positive counts produce counted
nodes, each holding one typed reference to the borrowed element. Zero and
negative counts return empty without duplication. A monomorphic duplicate
function is supplied only for reference-bearing elements; scalar words that
look like addresses are never counted.

`range` borrows both numeric bounds and returns owned fresh list nodes. Its
backward construction preserves ascending results, empty/backward ranges and
integer endpoints without overflow. Numeric payloads retain their existing
representation: boxed I128/U128 allocations are still conservative numeric
storage, so owned range nodes alone do not establish payload reclamation.

`tests/list_generation_ownership.rs` checks repeated leaves/nested lists and
601 closure aliases, integer limits through 128 bits, GC/reuse verification,
fallback flags and actual scalar wrappers using address-shaped bits. With
tracing disabled, identical outputs and only result sharing restored in the
baseline, count reclamation improves from 1.7 to 4.4 MiB. Full-platform CI
follows the prepared parent chain; these are focused local measurements.

## Typed array element ownership

All array operations use monomorphic typed ownership boundaries. Array storage
owns one reference per reference-bearing element; last-reference destruction
releases those elements before storage. Scalars receive NULL duplicate/drop
operations, preserving words that happen to resemble heap pointers.

From-list/make borrow inputs and retain stored elements. Generate/map invoke
callbacks synchronously with borrowed inputs and store owned results. Fold
borrows its callback and array while consuming/transferring the accumulator,
including the unchanged empty-array result. Get returns fresh owned Some with
an owned selected element; to-list returns fresh counted nodes with owned
aliases. Slice/append/sort copy elements with typed references; sorting scratch
buffers are scanned while in use and explicitly released afterward.

Set/push borrow inserted values and consume arrays. Nonunique copies retain
all elements; unique growth or poison-copy transfers existing child ownership.
Replacing a field releases its previous reference. An invalid set releases the
array and does not retain the unused insertion value. Element duplication
precedes releasing a possibly aliased prior field. Poison-copy clears the old
array before dropping it so transferred elements are not released twice.

`tests/array_element_ownership.rs` exercises every array operation, retained
copies, nested arrays, callback/function accumulators, captured callbacks,
String/Bytes/function elements and 601-element sharing/growth. Native O1/O2,
stack on/off, GC/reuse verification and ownership-disabled fallbacks agree
with the interpreter. Actual generated scalar wrappers and destruction preserve
address-shaped bits. With identical output and zero collections, changing only
result sharing reduces count reclamation from 11.3 to 5.3 MiB. Old marked allocations and retained runtime boundaries remain separate work.

## Typed ordered map/set elements

Map/set boundaries borrow input keys/values and own stored typed references.
Insert/remove/update consume their collection reference; copies retain elements,
unique growth/poison-copy transfers existing child ownership, and last-reference
destruction releases keys/values by type. Inserting an equal key preserves the
first stored key and releases its old value. Remove releases discarded pairs;
a missing key transfers the unchanged input. From-list stable sorting selects
the first key and last value, retaining only the selected references and
releasing scratch buffers. Set merge results retain selected subject/argument
keys and release their scratch buffer. Empty outputs remain static.

Get/keys/values/to-list establish typed owned aliases. The optimized get match
still avoids constructing Some, retaining its selected value through the arm
and releasing that temporary owner afterward. Map-values/update invoke borrowed
callbacks and own returned values. An update's default is only borrowed for the
call, including the unused-default path. Duplicate/drop operations are NULL for
scalar types; pointer-shaped bits never acquire a reference count.

`tests/map_set_ownership.rs` checks all boundaries, duplicate keys, retained
copies, missing keys, nested array/function values, callback/effect order,
optimized lookup and unique growth under GC/reuse stress at O1/O2, stack on/off
and fallback flags. Native emitted-wrapper probes prove scalar preservation,
first-key/last-value identity and balanced replacement/destruction. Identical
output and zero collections: restoring sharing only in emitted wrappers reduces
count reclamation from 26.2 to 16.0 MiB. Retained runtime boundaries, old marked
allocation reclamation, exceptional cleanup and cycles remain separate work.

## Prepared task/channel contracts

Task spawn/scope/within callbacks retain explicit sharing. Channel send payloads
and native task/channel handles also remain shared. Await, within, receive and
timed receive own fresh Option wrappers and acquire typed payload references;
shared payloads keep count zero, scalar payloads receive no metadata operations.
These contracts reclaim wrapper storage while retained values still use tracing.

Sleep/within/timed-receive borrow their Duration argument. Deadline borrows both
arguments and returns an owned typed alias of the value. Scalars skip duplication;
records, functions and leaves preserve counted ownership. This prevents an ordinary
passthrough from promoting the whole input graph to runtime sharing.
`tests/task_ownership.rs` checks stress aliases, actual numeric-bit wrappers and
0.0 -> 0.5 MiB count reclamation with only the old deadline sharing boundary
restored as a control. See the handoff for flags and remaining retained lifetime
and exceptional cleanup work. Full CI remains required before merging.

## Prepared retained task thunks

`task.spawn` borrows its thunk and retains one counted closure owner. The task
transfers that owner to owned application on entry, or drops it when cancelled
before entry. Typed captures release on normal completion and nonlocal exit.
Scope/stack preparation protects the extra owner; a failed spawn publishes no
child. Unknown callback ownership metadata retains the conservative shared
fallback. Escape analysis still treats the thunk as escaping.

Task handles and counted results remain shared; scalar results never go through
generic sharing. `task.scope`, `task.within`, channels, cycles and complete task
result teardown remain separate work. Evidence and limits are recorded in
[ownership.md](ownership.md#prepared-retained-task-thunks).

Prepared task.within borrows its callback and retains one counted owner through
the deadline task, using the same protected preparation as task.spawn. Its
Option outer remains owned; counted results still share. Success, cancellation
and alias evidence is in
[ownership.md](ownership.md#prepared-retained-deadline-callbacks).

Prepared task.scope borrows its synchronous callback and transfers the typed
owned result. Separate scope and result cleanup protects cancellation, child
joining and recovered traps. Unknown callback metadata retains the sharing
fallback; task handles and spawned results still share. See
[ownership.md](ownership.md#prepared-scoped-callback-ownership).
