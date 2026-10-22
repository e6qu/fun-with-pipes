# Moving strings through a list map

`words | map normalize` first splits input into strings, then transforms each
string. The existing map borrows its input list and gives each callback another
counted reference to its string. That reference can prevent an otherwise private
string from being changed in place.

This preparation selects fully applied `map` calls with a known, uncaptured
`String -> String` callback. Before reference-count insertion, the compiler gives
that call an internal contract that consumes the input list. A unique node moves
its string and tail to their next owners. At the first shared node, map keeps the
remaining list alive and gives callbacks separate string references. Existing
list, tail and element aliases therefore keep their values. Output nodes remain
fresh: a callback can collect, so changing older immutable nodes would require a
separate collector proof. Changed ASCII case conversions can reuse unique young
string storage; shared, static and older storage is copied.

Other element types, captured callbacks and unknown callbacks keep their current
contract. No syntax or public primitive is added. Resource-bearing inputs need
separate lifetime reasoning; this change does not establish it.

## Evidence so far

The compiler changes are not yet verified on runners. A local check inserts the
new runtime helper into previously generated C for the maintained word-frequency
program. Apple Clang 17 compiles it at O1 on ARM64 macOS. The input has 64 words
and eight base words, with varied case and punctuation. Both versions
must match an independent Python word-count result.

| Whole-program observation | Previous code | New helper plus unique case conversion |
|---|---:|---:|
| Managed allocation requests | 296 | 274 |
| Requested bytes | 9,058 | 8,630 |
| Counted retains | 194 | 130 |
| Peak charged storage | 7,744 | 5,376 |
| Final charged storage / collections | 0 / 0 | 0 / 0 |

Separate checks retain the whole list, its tail or one string and verify that
those aliases remain unchanged. Failure and cancellation checks release source
nodes, completed results and scratch storage; deliberately omitting source or
result cleanup is detected. These small local diagnostics are not native-platform
acceptance, elapsed-time measurements or comparisons against C/Rust performance.

## Required acceptance

The `string-map` evidence suite must pass on six native hosts using production
compilers. It compares raw/optimized interpreter output with native O0/O2,
tracing stress/reuse verification and ARC. It retains generated C and binaries
for the cleanup tests and their broken controls. Check the actual machine code,
then repeat the [word-frequency comparison](wordfreq.md) on named Linux ARM64
and AMD64 hosts with the same C/Rust programs, inputs and timing scope. Keep
slower results and known differences in work. Final production and documentation
checks must pass before delivery.
