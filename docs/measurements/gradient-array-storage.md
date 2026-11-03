# Keep private gradient results in arrays

**Status:** implementation, focused cleanup/allocation checks and compiler-cost
audits pass on both native Linux architectures. [Runtime results](gradient-array-time-2026-11-03/README.md)
have missed speed targets; final platform acceptance is pending. PR #251 is merged
as `296ec5b4`, with all production gates and the complete log audit passed.
The implementation baseline is `cea8debcd8caf067bf210fd612c559b265157b91`, retained
by `roadmap/range-zip-final-checks-2026-11-03`.
Tag `roadmap/gradient-array-protocol-2026-11-03` preserves this contract before
compiler/runtime edits.

## Cost and proposed change

The [remaining allocation census](range-zip-storage-2026-11-03/README.md#remaining-allocation-sites)
finds 25,671 gradient-list cells requesting 616,104 bytes in a 129-coordinate,
199-update solve. Before this change, the private F64 gradient followed this path:

```text
backward array → converted gradient list → close derivative scope
               → scaled numeric buffer → zip with old coordinates → new list
```

Keep the intermediate values in owned arrays instead:

```text
backward array → converted gradient array → close derivative scope
                → scaled numeric array → zip with old coordinates → new list
```

For sum-of-squares at `[-1.2, 1.0, -1.2]`, both gradients are
`[-2.4, 2.0, -2.4]`. Subtracting `0.001` times each gradient gives
`[-1.1976, 0.998, -1.1976]`; an alias of the input must remain unchanged.

## One grouped implementation

1. **Return owned arrays from the internal backward protocol.** Update floating,
   F128 and nested derivative paths, interpreter and native runtime together.
   Keep required float conversions inside the derivative scope. Public `grad`,
   `value-and-grad` and `vjp` still materialize their documented list results
   after that scope when the caller needs a list. Remove the old internal list
   representation; add no compatibility primitive or list-to-array adapter.
2. **Consume private numeric array conversions directly.** Before list fusion
   hides the conversion, prove a sole `array.to-list` use by a known scalar map
   and then a sole zip consumer, or directly by zip. Follow straight-line aliases
   and support both zip slots. Keep map execution eager; retain a real list for
   shared, captured, escaping, reference-bearing or unproved uses.
3. **Reuse existing typed array ownership and zip machinery.** Read packed arrays
   and slices through their accessors. Preserve conversion/capture evaluation,
   all intervening effects and every map callback before zip starts, even when
   the other list is empty or shorter. Keep the ordinary output list.
4. **Verify the whole change together.** Publish the isolated reference and its
   corruption controls before measurement. Then run focused semantic/cleanup
   checks, complete measurements, and one final nine-job platform matrix plus docs.

The existing scalar-buffer zip IR operation can also describe a typed numeric
array input. Any such extension must give it explicit interpreter semantics and
use its actual array element descriptor in native code. Do not expose the
native-only map buffer to the interpreter or assume all arrays contain I64 words.
Index uses once; bound candidate traversal and test visit-count scaling. Avoid
whole-program cloning, larger inlining budgets or new syntax to reach this case.

## Ownership proof and required controls

- The ordinary backward runtime copies adjoints into an independent result array
  before retiring tape buffers. No returned view may refer into retired storage.
- Typed backward transfers each adjoint once. Its shared zero sentinel needs a
  result owner; initialized array slots need cleanup on every partial failure.
  Preserve F128's inline bits and release temporary boxes exactly once.
- Nested derivatives retain valid enclosing-scope values, while invalid escaped
  values, mixed tapes and cross-task use still fail. Changing the container must
  not change scope rules or backward arithmetic order.
- Compare unoptimized interpretation, optimized interpretation and native GCC/
  Clang O1/O2: empty/one/many values, both slots, shorter/empty second input,
  captures, effects/traps, aliases, packed arrays and slices. Test rejection of
  unsupported consumers as well as selected cases.
- Cover F16/BF16/F32/F64/F128 and nested `Rev`: gradients, value-and-grad, VJP,
  Jacobian, checkpointing and higher derivatives. Retain all rounding behavior;
  do not assume every same-type floating conversion is a bitwise identity.
- Exercise callback traps, cancellation, allocation failure, partial result
  construction, shared zeros and reuse disabled. Deliberately missing cleanup
  must be detected. Final managed and raw derivative storage must both be zero.
- Update the reviewed primitive inventory, low-level callers, examples and
  generated docs with the internal result contract. Do not loosen unrelated checks.

## Frozen measurement requirements

Use the complete Rosenbrock solves, six coordinate/update pairs, both current-only
and history forms, GCC O1/O2 and workspace 0/1 from the
[range experiment](range-zip-storage.md). Keep arithmetic, outputs and timing scope
unchanged. The reference must undo the complete grouped implementation and no
unrelated change; disabling only the consumer would hide new protocol costs.

For each `d`-coordinate, `u`-update F64 solve:

- The attributed gradient-list group must lose exactly `d*u` cells / `24*d*u`
  requested bytes. Report all replacement arrays and other changed sites.
- Allow at most one additional `8+8*d`-byte conversion array per update: total
  requests must fall by at least `(d-1)*u`, requested bytes by `(16*d-8)*u`.
  At 129/199 these minima are 25,472 requests and 409,144 bytes. Report exact totals.
- Retains and managed peak must not grow; zero-update counts stay unchanged.
  Measure raw derivative buffers and process RSS separately; never add their peaks.
- Preserve the prior timing protocol: two qualified ARM64/AMD64 sessions each,
  identical-copy control ≤2%, zero/one-update regression ≤2%, and ≥5% less time
  for larger cases. Keep failed/inconclusive outcomes and the accepted policy of
  retaining verified reductions while leaving missed timing goals open.
- Compiler-time and RSS increases each ≤5%; largest reported frame growth ≤128
  bytes. Report code size separately. Use the existing complete-program compiler
  workload and retain commands, source/binary hashes, logs and raw samples.

The input-record boxes/list and output coordinate list remain separate candidates.
The objective callback can alias its inputs, and history observes earlier outputs;
this contract does not authorize replacing those owners or mutating their aliases.
