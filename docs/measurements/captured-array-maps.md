# Reuse array storage with scalar callback captures

Status: implementation and verification in progress after PR #270. This extends
the existing same-type numeric `array.map` proof; it does not close #270's
unresolved AMD64 timing limits or change its original results.

## Programs and the cost to remove

A callback can use numbers supplied when the program runs:

```fwp
calibrate : F64 -> F64 -> Array[F64] -> Array[F64]
calibrate = fn scale -> fn offset -> fn readings ->
    readings | array.map (fn value -> value * scale + offset)

brighten : U8 -> Array[U8] -> Array[U8]
brighten = fn offset -> fn pixels -> pixels | array.map (add offset)
```

`calibrate 2.0 1.0` turns `[1.0, 3.0]` into `[3.0, 7.0]`.
`brighten 3u8` turns `[10u8, 20u8]` into `[13u8, 23u8]`.
Both return immutable values. An alias must still see the original input.

The consuming-map proof currently requires a callback with no saved arguments.
These callbacks save `scale`/`offset`, so they miss the proof even though those
numbers own no heap data. The extension passes them directly to the existing
private worker and consumes the array only at its last use. An exclusive ordinary
array supplies its output storage; shared arrays and views need independent
output. This does not permit a neighboring-coordinate update to overwrite inputs
that later coordinates still need.

## Selection and safety

- A known callback has exactly one unapplied argument. Captures, input and result
  are supported plain scalars; input/result types match. F16, BF16, F128, 128-bit
  integers, references and unknown callbacks remain outside this proof.
- Captures evaluate once, left to right, before the array argument. The partial
  internal call cannot execute its callback body yet. Preserve computed captures,
  effects, first traps and resource boundaries; add no syntax or conversion.
- Liveness proves the array has no later use. ARC still protects earlier owners
  and shared ancestors. Keep necessary runtime uniqueness and view checks.
- Preserve element order, checked overflow, float bits and callback effects.
  Existing protected owners cover allocation failure, traps and cancellation.
  Every physical allocation must be released exactly once.
- Keep the existing reverse liveness walk and rewrite. Capture handling is
  proportional to supplied arguments; do not add whole-program search.

## Verification before delivery

Use existing targets rather than adding a native shard:

| Check | Required evidence |
|---|---|
| Selection and order | IR tests for zero/one/multiple and computed captures, last uses, excluded types and partial-call arity; ownership validation after rewriting |
| Values and effects | Raw/optimized interpretation and native output; empty/singleton inputs, narrow overflow, computed capture order, aliases and slices |
| Cleanup and reuse | Actual allocation/free observer; allocation failure, callback trap/cancellation, reuse disabled and deliberately broken cleanup controls |
| Production compilers | Native ARM64/AMD64 GCC and macOS Clang; packing on/off, C O1/O2; formatting and lint |
| Delivery | Nine final-head production jobs, docs and complete log/artifact audit; report compiler scaling with runtime results |

## Measurement contract before collecting results

Compare a same-source reference disabling only captured callback selection;
keep no-capture optimization in both. No previous fwp build dependency.

- Applications: F64 sensor calibration and U8 pixel adjustment above, with
  runtime coefficients. Sizes: 0/16/65,537/262,145; exclusive input, retained
  alias and interior slice. Check every result and preserved input.
- Run one update and 199 updates. Construct input outside the work timer; work
  includes callbacks and consumed/intermediate cleanup. Time final release
  separately; retain whole-process observations.
- Aim for 10% less computation on both large exclusive-input applications, in
  two sessions per native architecture. Qualified controls must not regress over
  2%; identical-copy variation over 2% is inconclusive. Freeze host/toolchain,
  repeat counts and rotated schedule before running.
- Count requests, bytes, retains and peak/final live storage separately. Unique
  mapping should need no output allocation; aliases/views must preserve data.
  Counts do not prove speed. Record ordinary RSS, code/stack and compiler costs.
- Do not pool CPU models, rerun unchanged failed timings for a pass, or relax
  original limits. Preserve every miss and distinguish reductions from acceptance.

[PLAN.md](../../PLAN.md) owns the roadmap. [Ownership](../ownership.md) explains
immutable values and reuse; [benchmarks](../benchmarks.md) defines measurement
boundaries. The [fresh-output report](fresh-array-costs-2026-11-08/README.md)
remains the source for PR #270's gains and unresolved limits.
