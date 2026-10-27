# Moving list elements and reusing array storage

Two ownership changes remove unnecessary copying and reference increments when
building and sorting an array. Focused checks pass on Linux, macOS and Windows,
each on ARM64 and AMD64. Integrated delivery passed in [PR #212](../roadmap-history.md#array-moves-and-the-gc-removal-checklist-pr-212). These are
storage/count savings, not a measured timing speedup or proof of C/Rust parity.

The current G5 checks use one counted configuration: eighteen executable
variants each for construction and sorting, including two output runs, four balanced/copy
observations and twelve deliberate faults per host. The readers require those
exact sets and check every image for collector symbols. This protocol passed integrated
validation in [#217](../roadmap-history.md#tracing-gc-removal-pr-217). The measurements
below retain their original source revisions and configuration sets.

## Behavior

```fwp
main = read-all () | words | array.from-list | array.sort | array.length | echo
```

`words` splits input into a list; `array.from-list` makes an array. Sorting orders
its elements, and `array.length` counts them. Input `c a b c a` therefore prints
`5`. Here the list's elements can move into the array, and sorting can reuse that
array because no other owner needs the original values.

Sharing must preserve earlier values. `both f g` applies both functions to the
same input and pairs their results; `id` returns its input unchanged:

```fwp
main = "c a b" | words
    | both (array.from-list | array.sort | array.to-list) id
    | echo
```

This prints `(["a", "b", "c"], ["c", "a", "b"])`. The first branch converts,
sorts and converts back to a list. The second keeps the original list. The new
implementation must preserve that unsorted list, rather than steal its elements.
The example was checked with the native compiler's interpreter.

A retain increments a reference count so another owner can keep a value alive.
Conversion moves only the **unshared prefix**: the nodes before the first shared
node. It retains elements in the remaining tail, because another owner can reach
all those descendants even when their individual node counts are one. The moved
nodes are released. Sorting copies shared arrays/views and reuses unique arrays;
empty and singleton arrays transfer directly. Source values remain immutable.

Inline 128-bit values need their bits, not their old scalar boxes. Conversion
copies the bits into array slots and releases those boxes. Sorting applies a
permutation in cycles with one sixteen-byte temporary, so writing one slot cannot
overwrite a value still needed elsewhere. Cleanup owners protect consumed inputs,
partial results and scratch storage through failure and cancellation.

## What was checked

Source `e0c4dd51bae37c0e09be10fcb373dd035279f815` passes all six native jobs in
[run 40100508025](https://github.com/e6qu/fun-with-pipes/actions/runs/40100508025).
Independent review covers [504 actual executable variants](array-construction-native-2026-10-24.json),
144 repeated observations and 288 deliberately broken controls. Logs are clean.
Checks use production GCC/Clang at O1/O2, automatic reference counting (ARC),
tracing stress/verification and reuse enabled, disabled or checked.

Each conversion observation checks 208 whole-list/tail-alias and bit-pattern
cases, plus 88 interrupted allocations/retains and cancellations. Controls expose
moves through shared tails, missing retains and missing input/result/node/wide-box
cleanup. Each sort observation checks 540 cases against an independent ordering
oracle and 232–272 interrupted operations; controls expose alias mutation,
overwritten wide values and missing cleanup. Language output is also compared
with interpretation before optimization. The earlier sort-only source remains
in [its native record](array-sort-native-2026-10-24.json).

## Allocation and count comparison

The same source passes both Linux jobs in
[run 40100509770](https://github.com/e6qu/fun-with-pipes/actions/runs/40100509770).
Hosts are AMD EPYC 7763 and ARM Neoverse-N2 with GCC 13.3. O1/O2 use
`-std=gnu11 -ffp-contract=off -fstack-usage`; link-time optimization is disabled.
[Raw results](array-construction-costs-2026-10-24.json) include all samples,
compiler commands, hardware, disassembly digests and stack reports.

The first program above runs normally and with only conversion changed to retain
every list element. Both versions sort by the same algorithm and return the same
count as interpretation. Word `i`, starting at zero, is `word` followed by
`(i * 17) % 103` as three digits; words have spaces between them and a final newline.
Separate correctness tests check element order and stability; counting alone does
not establish a correct sort.

Three fresh processes per input/version/optimization give identical counters.
Counting starts after constant initialization and includes parsing, construction,
sorting, output and language cleanup. It excludes allocator metadata, raw runtime
buffers, stacks and complete process memory. Both architectures/O1/O2 agree:

| Words | Retains, copying → moving | Requests, unchanged | Requested bytes, unchanged | Peak charged bytes, unchanged |
|---|---:|---:|---:|---:|
| 0 | 0 → 0 | 3 | 82 | 80 |
| 1 | 1 → 0 | 5 | 137 | 144 |
| 32 | 32 → 0 | 71 | 2,785 | 2,112 |
| 4,096 | 4,096 → 0 | 8,206 | 360,417 | 262,153 |

Every process ends at zero additional managed charge with no collection. Zero
retains here does **not** mean zero allocation or zero ARC machinery: ownership
counts are still checked and storage is released. Shared inputs still need retains.

A separate control changes only sorting to force an array copy. At 4,096 words,
reuse removes one request, 32,776 requested bytes and 4,096 retains; peak is
unchanged. These are separate paired comparisons, not additive timing claims.
The report also repeats the [scratch-buffer comparison](list-sort-storage.md).
[Earlier sort-only costs](array-sort-costs-2026-10-24.json) retain their original
source IDs and the conversion retains that remained before this change.

## Code and stack costs

Ordinary executables are compiled separately from counter-instrumented ones.
The table compares **copying list elements → moving them**, in bytes. Instruction
size is the executable's text section; the entry frame is one function's reported
stack storage, not maximum call-stack use.

| Host | Optimization | Instruction bytes | Entry frame bytes |
|---|---|---:|---:|
| AMD64 | O1 | 16,802 → 17,026 | 368 → 368 |
| AMD64 | O2 | 17,282 → 17,554 | 352 → 352 |
| ARM64 | O1 | 17,132 → 17,308 | 336 → 352 |
| ARM64 | O2 | 15,420 → 15,756 | 368 → 368 |

Retain savings trade against additional instructions, and ARM64 O1 adds sixteen
entry-frame bytes. The raw report also measures eight ordinary wide-sort objects
and their stack reports. That fixture now constructs its wide array from a list;
its paired control changes only sort reuse. It does not measure conversion timing.

## Separate C/Rust timing comparison

The same jobs run the seven [benchmark programs](../benchmarks.md#what-each-program-actually-does)
with equivalent-work C/Rust peers. These complete-program measurements are
separate from the conversion experiment and do not establish a conversion speedup.
Ratios use median elapsed time; above 1 means fwp takes more time. For example,
1.20 means 20% extra elapsed time. Startup, output algorithms and language rules
also contribute, so a ratio is not isolated compiler overhead. All repeated
samples and process-memory observations are retained in the raw report.

| Program | AMD64 fwp/C | AMD64 fwp/Rust | ARM64 fwp/C | ARM64 fwp/Rust |
|---|---:|---:|---:|---:|
| fib | 0.310 | 0.341 | 0.201 | 0.217 |
| loop | 1.019 | 1.197 | 0.744 | 1.147 |
| map | 0.874 | 1.079 | 0.921 | 1.018 |
| pipeline | 0.741 | 0.988 | 0.583 | 0.707 |
| range-set | 1.007 | 1.013 | 1.077 | 1.062 |
| strings | 0.044 | 0.044 | 0.042 | 0.042 |
| text-length | 1.436 | 0.943 | 1.948 | 1.066 |
