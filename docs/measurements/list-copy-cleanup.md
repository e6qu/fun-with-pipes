# Cleaning up interrupted list copies

A list consists of linked cells, each holding an element and the next cell.
Copying cells must preserve the original elements while releasing an unfinished
copy if an allocation, retain or callback fails. Cancellation needs the same
cleanup.

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
The compiler passes the result's element/list cleanup descriptor explicitly.
Borrowed source values remain unchanged. Flattening transfers each partial tail
instead of retaining it again.

Plain list sorting now uses one input lane and one merge lane; values are also
the comparison keys. Typed array sorting likewise uses one merge lane. This
removes redundant scratch allocations without changing the merge algorithm.
No elapsed-time improvement is claimed; allocation, peak, code-size and stack
measurements remain required before delivery.

## Checks and limits

`tests/sort_callback_ownership.rs` includes the list-copy fixture from
`tests/support/list_copy.rs`. It compares native results with the raw interpreter
and interrupts every allocation/retain in all seven list operations, both by
trap and by task cancellation. It separately interrupts the first, middle and
last key callback. Independent aliases must remain valid; eight rounds must
return ARC storage to the starting balance. Tracing runs retain stress, verifier
and reuse checks. Deliberately missing key, scratch and partial-list releases
must fail the allocation ledger, which records explicit cleanup rather than
letting collection hide a leak.

The local runtime-only reproduction passes on macOS ARM64 Clang O1: handled
failures and success end at zero managed charge; omitting key release leaks
16, 32 or 48 bytes. It uses saved #206 emitted C with the current runtime and new
call applied explicitly. It does **not** validate current Rust code generation,
GCC or other hosts. The `list-copy` focused workflow runs current source at
production compiler settings on six native hosts; acceptance is pending.
