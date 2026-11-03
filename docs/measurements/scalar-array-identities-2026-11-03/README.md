# Identity conversions: correctness and storage

This work makes same-type float conversion preserve every bit, then removes
selected `array.map float.convert` calls on F64 arrays. The
[contract](../scalar-array-identities.md) fixes selection, ownership and measurement
requirements. [The handoff](../../development-state.md) records current CI status.
[Compiler-cost limits](../scalar-array-identity-analysis-2026-11-03/README.md) pass.
Full platform verification and runtime timings remain pending.

## Focused native verification

[Run 41672290329](https://github.com/e6qu/fun-with-pipes/actions/runs/41672290329)
at `beddd406153f1976fed00847292207bff9053e22` passes on GCC Linux ARM64/AMD64 and
Clang macOS ARM64. [The complete index](native/index.json) links the full logs,
target logs, generated C,
observations and native image identities. Identical generated C is stored once
per archive, with original paths mapped in the observation record.

Each completed host passes:

- 50 integration tests across ten targets, plus the optimizer selection unit test.
- 800 native bit comparisons: five float formats, 20 input patterns, primitive
  and specialized entries, raw/optimized programs, O1/O2. Both interpreters agree.
- 48 owner observations: packed storage and reuse on/off at O1/O2, with the
  rewrite selected/rejected. Successful cases check moves, aliases, slices,
  immutable updates, recoverable traps and cancellation. Missing cleanup exits
  90; the fatal allocator path exits 102 with its exact diagnostic.
- Two source-program executions preserving values and effect order, plus eight
  existing float-text observations including deliberate corruption controls.

All new output/error/status transcripts match across all three hosts. All 948 saved
native images have checked architecture headers and hashes. The 32 GCC owner-probe
images also have saved entry inspection: generated C shows the selected function
returning its input with scheduler cleanup intact; native entries corroborate
removal of the replacement-array work. GCC sometimes inlines the source function
into its owned entry, so inspection records the actual retained symbols.

These are correctness and cleanup results. Compiler-cost limits pass in the separate report; runtime performance
acceptance still requires its frozen comparisons. Optional WebAssembly
execution in the focused core target is not evidence of WebAssembly support;
that coverage belongs to the complete production matrix.

## Result lifetime and allocation traffic

The local probe recompiles saved generated C from `beddd406` with an extended
storage probe. It uses Apple Clang at O1/O2, with packed arrays enabled/disabled,
for both the original map and the selected rewrite: eight executions and 32
storage observations pass. This checks the added C probe; it does not replace
three-host compiler verification or the final production matrix.
[The record](local-storage.json) retains compiler identity, commands, observations,
source/image hashes and the original GitHub artifact identity. Compressed sources
are linked from that record. No timing benchmark ran locally.

Each case returns 256 F64 values. A slice takes the first quarter of a
1,024-element backing array. Shared cases retain another reference to the input.
The original map allocates an independent result; the selected map returns its
input owner. These packed-array results agree at O1 and O2:

| Input | Original result live bytes | Selected result live bytes | Original peak bytes | Selected peak bytes |
|---|---:|---:|---:|---:|
| Unique array | 2,560 | 2,560 | 5,120 | 2,560 |
| Shared array | 5,120 | 2,560 | 5,120 | 2,560 |
| Unique slice | 2,560 | 10,272 | 12,832 | 10,272 |
| Shared slice | 12,832 | 10,272 | 12,832 | 10,272 |

**Live bytes** include the result and any retained aliases immediately after the
map. **Peak bytes** are the largest live total during the map. Both count allocator
slots, including rounding and view headers, rather than requested payload bytes
or process RSS. All cases return to zero additional live storage after cleanup.

The original map makes one allocation charging 2,560 bytes; the selected map makes
none. Neither adds retains during the map. Packed-off slices are independent
copies, so their storage follows the ordinary-array rows.

The unique-slice row shows why allocation savings do not establish lower live
memory: returning a view keeps its larger backing allocation alive. The original
map copies only the selected elements and releases that backing owner. This
tradeoff must remain explicit alongside future gradient timings, which use a
different ownership pattern.
