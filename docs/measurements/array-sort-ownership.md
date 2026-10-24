# Reusing an unshared array during sorting

Sorting can reuse an array when no other owner needs its original values. This
preparation removes one array copy and its per-element reference increments.
Six-host correctness checks and both Linux cost comparisons pass. Full delivery
acceptance is still required; no timing speedup or C/Rust parity is claimed.

## Behavior

```fwp
main = read-all () | words | array.from-list | array.sort | array.length | echo
```

`words` splits input into a list; `array.from-list` makes an array. Sorting puts
its elements in order, and `array.length` counts them. Thus `c a b c a` prints `5`.
The intermediate array has one owner, so sorting can reuse its storage. If a
program also keeps the unsorted array, sorting must copy and preserve that alias.
An array view also keeps its backing values unchanged. Empty and singleton arrays
are already sorted and transfer their existing reference.

A retain increments an ownership count so another owner can keep a value alive.
Moving an unshared array does not need to retain each element. Shared copies still
do. This is an internal ownership change: ordinary immutable source semantics and
single-argument functions stay the same.

A 128-bit floating-point sort key borrows its original array slot. Writing sorted
values back one by one could overwrite a value still needed later. The new code
applies the permutation in cycles, using one sixteen-byte temporary. Input, result
and scratch buffers have cleanup owners through allocation, comparison and
cancellation. Reuse verification can force a copy of unique storage; that copy
transfers children without extra retains.

## Native correctness

Source `e78069765ac5798f71d7e11d216bcb71d6850d21` passes all six native jobs in
[run 40095196564](https://github.com/e6qu/fun-with-pipes/actions/runs/40095196564).
Independent review checks [252 actual executables](array-sort-native-2026-10-24.json),
72 repeated observations and 144 deliberately broken controls. Every job log is
clean. Tests use production GCC/Clang at O1/O2, automatic reference counting (ARC),
tracing stress/verification, and reuse enabled, disabled or checked.

Each observation checks 540 alias/bit-pattern cases, including 0, 1, 2, 3, 17 and
257 elements, distinct string identities, numeric views and 128-bit values.
An independent insertion-sort oracle checks ordering and unchanged aliases.
Each observation also cleans up 232–272 injected allocation/retain/comparison
failures and cancellations. Controls must detect shared mutation, overwritten
wide values, missing input/result/scratch cleanup and missing retains. Programs
are compared with the interpreter with optimizations disabled.

## Allocation comparison

Source `d763c34c824fc8aaf7d4e76aba9ae29cbf950d9e` passes
[run 40096410788](https://github.com/e6qu/fun-with-pipes/actions/runs/40096410788).
Its compiler/runtime/tests are unchanged from the correctness source. The hosts
are AMD EPYC 7763 and ARM Neoverse-N2, both using GCC 13.3. O1/O2 use
`-std=gnu11 -ffp-contract=off -fstack-usage`, with link-time optimization disabled.

The program above runs normally and with only the sort's uniqueness decision
changed to force a copy. Input word `i`, starting at zero, is `word` followed by
`(i * 17) % 103` as three digits; words are space-separated with a final newline.
Both variants return the same count as the interpreter. Separate native tests,
not this count output, check sorted element values and stability.

Three fresh processes per input/version/optimization produce identical counts.
Counting starts after constant initialization and includes input parsing,
construction, sorting, output and language cleanup. It excludes allocator
metadata, raw runtime buffers, stacks and complete process memory. Both hosts
and O1/O2 agree. Entries show **forced copy → reuse**.

| Words | Allocation requests | Requested bytes | Retains | Peak charged bytes, unchanged |
|---|---:|---:|---:|---:|
| 0 | 3 → 3 | 82 → 82 | 0 → 0 | 80 |
| 1 | 5 → 5 | 137 → 137 | 1 → 1 | 144 |
| 32 | 72 → 71 | 3,049 → 2,785 | 64 → 32 | 2,112 |
| 4,096 | 8,207 → 8,206 | 393,193 → 360,417 | 8,192 → 4,096 | 262,153 |

At 4,096 words, sorting saves one request, 32,776 requested bytes and 4,096
retains. Other phases still determine whole-program peak memory. Every process
finishes at zero additional managed charge with no collection. Empty/singleton
inputs transfer directly in both variants; this control does not restore their
older unnecessary copy. The raw report also repeats the separate
[list/array scratch-buffer comparison](list-sort-storage.md).

## Code and stack costs

The word-count program's ordinary executable is compiled separately from its
counter-instrumented version. Code size below is its instruction section; the
frame is the generated language entry's compiler-reported stack size.
Entries remain **forced copy → reuse**, in bytes.

| Host | Optimization | Instruction bytes | Entry frame bytes |
|---|---|---:|---:|
| AMD64 | O1 | 16,610 → 16,802 | 368 → 368 |
| AMD64 | O2 | 17,186 → 17,282 | 352 → 352 |
| ARM64 | O1 | 16,892 → 17,100 | 336 → 336 |
| ARM64 | O2 | 15,436 → 15,420 | 368 → 368 |

A separate ordinary fixture contains string and 128-bit sorts. Its unlinked
objects expose the wide permutation's code and stack costs. External floating
libraries are excluded; a function frame is not maximum call-stack use.

| Host | Optimization | Object instruction bytes | Sort function frame bytes |
|---|---|---:|---:|
| AMD64 | O1 | 34,775 → 34,931 | 256 → 256 |
| AMD64 | O2 | 42,918 → 43,174 | 304 → 304 |
| ARM64 | O1 | 35,300 → 35,436 | 256 → 256 |
| ARM64 | O2 | 39,196 → 39,324 | 304 → 288 |

The wide fixture adds code; its measured sort frame stays unchanged except for
a sixteen-byte reduction at ARM64 O2. These costs accompany the allocation/count
savings and are not a timing result. Independent review checks all 48 sort-storage
executables and eight wide objects across both hosts.

## Separate C/Rust timings

The same runs repeat the [checked-arithmetic complete-program comparison](checked-peers.md).
These seven workloads are different from the array-sort counter fixture. Ratios
below compare whole-process elapsed medians, including startup and output;
`1.19` means fwp takes 19% more time. Runtime setup, algorithms and language rules
also contribute, so the ratio is not pure compiler overhead.

| Program | AMD64 fwp/C | AMD64 fwp/Rust | ARM64 fwp/C | ARM64 fwp/Rust |
|---|---:|---:|---:|---:|
| fib | 0.318 | 0.351 | 0.202 | 0.219 |
| loop | 1.014 | 1.191 | 0.744 | 1.148 |
| map | 0.882 | 1.093 | 0.913 | 1.021 |
| pipeline | 0.774 | 1.047 | 0.579 | 0.705 |
| range-set | 1.039 | 1.041 | 1.051 | 1.056 |
| strings | 0.047 | 0.048 | 0.042 | 0.042 |
| text-length | 1.427 | 0.939 | 1.952 | 1.063 |

Slower loop, range and character-counting results remain visible. These separate
runs do not establish that array reuse improves elapsed time. The [raw evidence](array-sort-costs-2026-10-24.json)
contains all samples, inputs, flags, compiler/hardware details, stack reports and
independent reviews of 112 executables plus eight objects. Full production gates
and final-head binary review remain required before merge.

## Next experiment: move list elements into the array

The verified sort above still retains elements when it constructs its input array.
The next prototype consumes the input list and moves elements from its unshared
prefix. A prefix is the sequence of nodes before the first shared node. Once a
shared node is reached, the conversion copies the remaining elements: another
owner can reach all of that tail, even if individual descendant counts are one.

For example, `"c a b" | words | array.from-list` can transfer all three string
references. If the program also keeps the original list, conversion retains those
strings and leaves the list unchanged. Inline 128-bit elements copy their bits
into array slots and release the old scalar boxes.

This prototype is not yet verified. Its checks cover whole-list and tail aliases,
empty/singleton inputs, exact wide bits, interrupted allocation/retains and
cancellation. Deliberately broken variants must expose missing cleanup or moves
through a shared tail. The `array-built` measurement compares the same generated
program with moves enabled against a control that retains every list element;
parsing, construction, sorting, output and cleanup are included in both. It records
allocation/count differences and code/stack costs, not a C/Rust timing speedup.
The earlier tables refer only to their named revisions and do not establish the
prototype's results.
