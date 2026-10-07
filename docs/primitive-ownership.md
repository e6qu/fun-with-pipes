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
share keys because a key can be stored. Callback inputs/results remain shared:
a callback can return its input or a closure capturing it.

Fresh outer storage does not imply independently owned elements. Current
container destruction frees the outer buffer; it does not recursively release
its runtime-shared elements. Aliasing metadata records which arguments or their
elements can be reachable from the result, including callback captures. Typed
element ownership, complete leaf-result coverage, closure capture destruction, retained runtime results and
runtime cycles remain separate work in [ownership.md](ownership.md).

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
