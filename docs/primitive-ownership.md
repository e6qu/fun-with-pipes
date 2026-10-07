# Native primitive ownership contracts

`src/ownership.rs` is the shared boundary inventory used by IR counting and
native code generation. Its container inventory covers every array/map/set
primitive declared in `lib/collections.fwp`; a coverage check detects newly
added declarations without contracts. Other primitives, foreign functions and
remote calls retain the conservative default: borrow arguments, promote counted
values to runtime sharing, and return runtime-shared values. Further inventories
must refine that default before extending deterministic reclamation.

Arguments have three modes: **borrow** for the call, **consume** an owned
reference, or **share** a borrowed value because it may escape into runtime
storage. Consume is checked by `src/rc.rs`; share is emitted by `src/cgen.rs`.
Result metadata distinguishes shared results, fresh outer containers and
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
element ownership, leaf-string/byte ownership, closure capture destruction and
runtime cycles remain separate work in [ownership.md](ownership.md).

## Evidence and remaining work

`tests/ownership.rs` checks interpreter/native agreement for record keys,
returned aliases, callbacks returning inputs and capturing them, failed
`array.set`, missing-key removal and updates with retained aliases. Native runs
use collection stress/verification and reuse poisoning. Generated wrappers must
borrow comparison keys and share inserted keys.

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
