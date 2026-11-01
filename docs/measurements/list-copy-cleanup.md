# Cleaning up interrupted list copies

A list consists of linked cells, each holding an element and the next cell.
Copying cells must preserve the original elements while releasing an unfinished
copy if an allocation, retain or callback fails. Cancellation needs the same
cleanup. An owner is responsible for releasing storage. Automatic reference
counting (ARC) releases a value when its last owner lets it go.

The current G5 protocol requires ten binaries per host: two program runs, two
balanced cleanup probes and six omitted-cleanup controls at O1/O2. It has one
counted ownership model. Its updated artifact reader passed integrated validation in
[#217](../roadmap-history.md#tracing-gc-removal-pr-217). Older results below retain
their original source and tracing configurations.

This program sorts words by a newly allocated key string. `attempt` catches the
error raised for `"b"`, so the result is `Err "expected"`:

```fwp
bad : String -> String ! {Error[String]}
bad = if (eq "b") (const "expected" | fail) (concat "owned:")
main = "c b a" | words | attempt (sort-by bad) | echo
```

`const "expected"` ignores the current word and supplies the error text; values
do not implicitly become constant functions. The key for `"c"` must be released
when the callback rejects `"b"`. The old native implementation returned the
right error but retained 80 managed bytes in a dynamic-input reproduction.

## Repair

`sort-by` protects completed keys and all scratch buffers as it proceeds.
`sort`, `reverse`, `append`, `flatten`, `take` and `unique` also construct owned
cells incrementally, instead of waiting for a successful return to count them.
The compiler explicitly supplies the functions that release each element and list.
Borrowed source values remain unchanged. Flattening transfers each partial tail
instead of retaining it again.

Plain list sorting now uses one input buffer and one temporary merge buffer;
values are also the comparison keys. Typed array sorting likewise uses one
temporary merge buffer. This
removes redundant scratch allocations without changing the merge algorithm.
[Measured storage and binary results](list-sort-storage.md) show fewer requests
and smaller code; whole-program peak and retain counts stay unchanged. No
elapsed-time improvement is claimed.

## Checks and limits

`tests/sort_callback_ownership.rs` includes the list-copy fixture from
`tests/support/list_copy.rs`. It compares native results with the interpreter with optimizations disabled
and interrupts every allocation/retain in all seven list operations, both by
trap and by task cancellation. It separately interrupts the first, middle and
last key callback.

Independent aliases must remain valid; eight rounds must
return ARC storage to the starting balance. Tracing runs force frequent collection, verify collector consistency and
exercise reused memory. Deliberately missing key, scratch and partial-list releases
must fail the allocation ledger, which records allocations and explicit releases
so collection cannot hide missing cleanup.

The local runtime-only reproduction passes on macOS ARM64 Clang O1: handled
failures and success end at zero managed charge; omitting key release leaks
16, 32 or 48 bytes. It uses saved #206 emitted C with the current runtime and new
call applied explicitly.

It does **not** validate current Rust code generation,
GCC or other hosts. The `list-copy` focused run `40088243982` tests source `883f1c140089` at
production settings. Linux and macOS pass on both architectures. Both Windows
jobs pass the new cleanup tests but expose a scalar-key probe that expected LF
while writing through Windows text mode.

It now selects binary stdout, matching
the generated program convention. All three list targets are added to Windows
production coverage. Source `851c7a774b92` passes both complete repair runs:
[Windows AMD64](https://github.com/e6qu/fun-with-pipes/actions/runs/40089546129)
and [Windows ARM64](https://github.com/e6qu/fun-with-pipes/actions/runs/40089548269).
All completed logs are audited. Independent review covers [144 actual binaries](list-copy-native-2026-10-24.json)
across the six hosts: six balanced observations and twelve deliberately missing
cleanup controls per host.

Windows uses the repaired test revision; compiler,
runtime and library sources match the four Unix jobs. [PR #210](../roadmap-history.md#collection-cleanup-and-interpreter-shutdown-pr-210) records the later passing final CI and user merge.
Independent final-head binary review was not completed before that merge.

The separate `list-copy-costs` measurement uses 0, 1, 32 and 4,096 input words
through `read-all | words | sort | length` and the analogous array conversion.
It compares the repair with extra separate scratch lanes restored, keeping the
new cleanup in both. Counts include parsing, result construction and output;
ordinary and instrumented binaries are separate, each at O1/O2.

Three fresh
processes must agree on counts and finish with zero managed charge. No timing
measurement is inferred from these instrumented runs. Both Linux jobs and
independent binary reviews pass; [results](list-sort-storage.md) give exact
counts, code sizes, stack frames and the unchanged peak storage.