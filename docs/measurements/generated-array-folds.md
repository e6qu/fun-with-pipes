# Remove an immediately consumed numeric array

**Proposed next implementation; not delivered.** The [current buffer results](buffer-current.md)
retain all four sessions, including their failed timing controls. This work
targets a remaining allocation, without claiming that the measurements already
establish a stable speed comparison.

## Program and opportunity

```fwp
sum-generated = flip array.generate id | array.fold add 0
```

`array.generate` calls its function with each index from zero through length
minus one. `id` returns that index. `flip` lets this definition bind `id` before
the pipe supplies the length. `array.fold add 0` adds the elements from left to
right, starting at zero. Thus `sum-generated 4` returns `6`.

The current native code allocates and fills the array, then reads it in a second
loop. When nobody else uses that array, one loop could generate each number and
immediately add it. Stored arrays still need the direct fold delivered in #231;
this proposal concerns only a producer consumed at this call site.

## Required proof

- The generator, intervening numeric maps and fold callback are known, pure and
  terminating. Reuse the compiler's existing memoized behavior analysis; reject
  unknown calls, recursion, effects and distinguishable reordered failures.
- Elements, accumulator and captures are inline numbers. Exclude F128, resources,
  shared containers and captures needing ownership changes from this first step.
- Preserve argument evaluation: initial value, producer count and callback
  captures keep their original order. Evaluate each once. Preserve the order of
  checked additions; do not replace the sum with a closed-form formula.
- Negative lengths remain empty. The same target-dependent oversized-array
  boundary must fail before any generator call, even though storage disappears.
  A zero length still evaluates its arguments but invokes neither callback.
- Only the immediately consumed result disappears. Arrays reused elsewhere,
  unknown callbacks and rejected proofs keep their existing implementation.

The implementation should extend `src/fuse.rs` and its existing loop lowering.
If the size check needs an internal operation, share the real constructor's
count rule with that operation. Do not duplicate a host-size constant or silently
omit validation because allocation was removed.

## Acceptance declared before implementation

Use the same scan entry and lengths 0, 16, 4,096 and 262,144. The frozen reference
is `377cf9ce25c65afba595b6413e5bb1d50721ea7a`, the #231 head under final
production validation. Its compiler/runtime match the measured `3ca66b54`; only
wait tests, workflow ordering and documentation changed. #231 must pass before
this next delivery merges. If a compiler repair changes the reference, declare
that source before candidate runs. Do not change the C/Rust programs, arithmetic,
production flags or sample counts.

| Requirement | Passing evidence |
|---|---|
| Values and failures | Raw interpreter, optimized interpreter and native O1/O2 agree on output, exit status and first failure |
| Storage | The selected entry makes zero managed allocation requests and zero count updates, with zero peak/final payload and no retained count slot |
| Mechanism | Generated C and actual binaries contain the fused loop; disabling the transformation restores the materialized array and its observed allocation |
| Cleanup | Failure and cancellation preserve outer owners; a deliberately omitted cleanup must fail the check |
| Code and stack | At most 5% instruction-byte growth against the reference; no larger reported frame component or new dynamic-frame requirement |
| Compiler cost | Both existing G2 analysis-budget hosts pass without raising limits |
| Production | All nine native production jobs and documentation pass on the final head |

Test empty and negative counts, the first oversized count, initial/count/capture
evaluation order, distinct generator/fold traps, effectful and unknown callbacks,
numeric element/accumulator differences and a reused input. Exercise both array
packing settings and enable/disable controls. Add these cases to existing native
targets, then check shard coverage; avoid running the full matrix per edit.

Timing uses the existing paired scalar-scan protocol: two sessions per native
architecture, byte-identical copy variation at most 2%, and at least 10% less
elapsed time in every qualified session. A failed control or speed budget keeps
timing acceptance open; retain every observation and do not retry an unchanged
experiment. Verified allocation removal and timing acceptance are separate
results. Neither establishes parity with C/Rust or a bound on total stack usage.
