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

Saturating a reference count promotes the whole reachable graph to sharing,
not just the parent. Interior references are canonicalized to the allocation's
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

A runtime regression creates enough aliases to saturate a counted parent,
then attempts an update of its reachable child. Restoring the previous
saturation behavior corrupts the value observed through another alias;
the fixed boundary preserves it. The same regression protects interior
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
made. This foundation does not yet change map or retained runtime callbacks.
`tests/borrowed_callbacks.rs` checks the generated String/I64 argument metadata,
scalar bits resembling an allocation, exact and partial calls, overapplication
across a scalar-to-function boundary, captured/input aliases and a stack callback
at O1/O2 with collection stress/verification and both reuse-poison settings.
