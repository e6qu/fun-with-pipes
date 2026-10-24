# List and array sort storage

Removing redundant sort buffers saves allocation requests and requested bytes.
The measured whole-program peak and retain counts do not change. This compares
two versions of fwp; it does not measure speed or overhead against C/Rust.
These are the historical scratch-buffer results. The later
[array ownership comparison](array-sort-ownership.md) separately removes the
result copy and per-element retains; it preserves this evidence.

## Programs and comparison

Both programs read words from standard input, sort them, and print their count:

```fwp
main = read-all () | words | sort | length | echo
```

```fwp
main = read-all () | words | array.from-list | array.sort | array.length | echo
```

`words` splits text into a list. The second program converts it to an array
before sorting. Sorting preserves the count: 32 input words print `32`.
The fixture uses 0, 1, 32 and 4,096 words. Word number `i`, starting at zero,
is `word` followed by `(i * 17) % 103` as three decimal digits. Words are
space-separated with a final newline, so duplicates occur at the larger size.
The interpreter with optimizations disabled and both native versions must agree
on output.

The **shared-buffer version** uses the same element buffer for keys and values,
because plain sorting compares the elements themselves. The **separate-buffer
control** restores two extra buffers for lists and one for arrays. Both versions
keep the new failure cleanup; this isolates redundant buffers from the leak fix.
Neither changes the merge algorithm. See [cleanup](list-copy-cleanup.md).

Source `851c7a774b92532292c4c6df068a39a863137242` passes
[run 40089544249](https://github.com/e6qu/fun-with-pipes/actions/runs/40089544249)
on Linux AMD64 (AMD EPYC 9V45) and ARM64 (Neoverse-N2). GCC 13.3 compiles
ordinary and counter-instrumented executables separately at O1 and O2, with
`-std=gnu11 -ffp-contract=off -fstack-usage`, automatic reference counting (ARC)
and no link-time optimization (LTO). Three fresh
instrumented processes per input/version/optimization must report identical
counts. Independent review checked all 32 sort executables, source changes,
machine instructions, stack reports and observations. Final production acceptance
is separate from these focused results.

## Allocation and live storage

Counters start after constant initialization and include reading/parsing,
construction, sorting, printing and language cleanup. Requested bytes sum managed
allocation sizes; peak charged bytes track simultaneously charged managed storage.
Neither includes raw runtime buffers, allocator metadata, stacks or complete
process RSS. The historical JSON says “from constant initialization”;
the instrumentation activates **after** initialization. The generator label is
corrected for subsequent reports; the original observations remain unchanged. The two Linux hosts and both optimization levels agree exactly.
Each table entry is **separate-buffer control → shared-buffer version**.

| Program | Words | Requests | Requested bytes | Retains, unchanged | Peak charged bytes, unchanged |
|---|---:|---:|---:|---:|---:|
| list | 0 | 3 → 3 | 82 → 82 | 0 | 80 |
| list | 1 | 6 → 6 | 161 → 161 | 1 | 144 |
| list | 32 | 104 → 102 | 3,817 → 3,289 | 32 | 2,880 |
| list | 4,096 | 12,303 → 12,301 | 491,497 → 425,945 | 4,096 | 360,456 |
| array | 0 | 4 → 4 | 90 → 90 | 0 | 80 |
| array | 1 | 6 → 6 | 153 → 153 | 2 | 144 |
| array | 32 | 73 → 72 | 3,313 → 3,049 | 64 | 2,112 |
| array | 4,096 | 8,208 → 8,207 | 425,969 → 393,193 | 8,192 | 262,153 |

At 4,096 words, the list saves 65,552 requested bytes and the array 32,776.
Peak storage can stay unchanged because other program phases determine its
maximum. All measured processes finish at zero additional managed charge,
without collection. Empty and singleton inputs need no merge scratch.

## Ordinary executable and stack costs

These sizes come from the binaries without counters. Instruction bytes are the
whole executable's `.text` section. File sizes include other sections and linking
choices. Each pair is **separate control → shared version**, in bytes.

| Host | Program | Optimization | Instruction bytes | File bytes |
|---|---|---|---:|---:|
| AMD64 | list | O1 | 15,634 → 15,506 | 52,112 → 52,056 |
| AMD64 | list | O2 | 16,578 → 15,938 | 51,736 → 51,728 |
| AMD64 | array | O1 | 16,546 → 16,498 | 52,160 → 52,152 |
| AMD64 | array | O2 | 17,410 → 17,090 | 51,872 → 51,864 |
| ARM64 | list | O1 | 15,820 → 15,724 | 82,056 → 82,008 |
| ARM64 | list | O2 | 14,652 → 14,316 | 81,520 → 81,512 |
| ARM64 | array | O1 | 16,828 → 16,796 | 82,104 → 82,096 |
| ARM64 | array | O2 | 15,564 → 15,372 | 81,664 → 81,648 |

At O1, the list's entry-thread frame shrinks from 384 to 368 bytes on AMD64 and
352 to 336 on ARM64. At O2 it remains 352/368 bytes, respectively. Array entry
frames stay unchanged. One recursive sort frame remains 128/144 bytes on AMD64
at O1/O2 and 144/160 on ARM64. These are compiler frame reports, not maximum
call-stack measurements. Full reports retain every function frame.

## Timing limits and remaining gaps

These instrumented counts establish neither a speedup nor C/Rust parity.
The same run separately repeats the [seven checked-peer comparisons](checked-peers.md)
with one warmup and six rotating samples per implementation. They include
startup, construction, computation and output, excluding compilation.
The loop remains 22.3% slower than Rust on AMD64 and 14.6% on ARM64;
direct character counting remains 58.6%/94.4% slower than C. The peer algorithms
and formatting differ as documented; these ratios do not isolate compiler cost.
No change is inferred by comparing absolute times from separate runner sessions.

[Raw evidence](list-sort-storage-2026-10-24.json) includes every count, binary/source
hash, compiler/CPU setting, frame, timing sample and comparison ratio. The run
also checks 42 timed images, 22 peer-control images and ten deliberately corrupted
artifact cases. Use the [benchmark index](../benchmarks.md) for earlier results.
