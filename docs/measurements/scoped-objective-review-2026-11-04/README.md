# Known objective: the remaining binding boundary

[Run 41824802673](https://github.com/e6qu/fun-with-pipes/actions/runs/41824802673)
passes all 12 source-emission commands at `3c091d3f`. The full compiler log and
43 source/output hashes pass audit. [Archive](evidence.zip), [manifest](manifest.json),
[audit](audit.json). This checks emitted code, not runtime cleanup or performance.

The specialized `rev._grad-known-objective` now calls the known objective
directly. Its generated C exposes the indexed producer and neighboring-pair map
in the same function, with their original order. But typed intermediate code
still packages the producer in a temporary `(tape, inputs)` record and reads
that record's fields. C generation removes the outer wrapper later; the new
storage pass needs these bindings earlier.

The required normalization is:

```text
let pair = (let base = start-tape inputs in (base, make-inputs base inputs))
in use pair.0 pair.1

→ let base = start-tape inputs
  in let pair = (base, make-inputs base inputs)
  in use pair.0 pair.1
```

No call changes position relative to another call. Existing record scalar
replacement can then expose `make-inputs` as a typed local. Only bindings without
observable resource lifetimes may move outward; resource regions and anchored
locals must stop the normalization. Charge each rewrite to the existing
specialization budget. Test effect/trap order, resource exclusions and budget
exhaustion before accepting this extension.

This is an added proof requirement for the [packed-input contract](../packed-derivative-inputs.md),
recorded before implementing normalization. The original contract tag remains
unchanged. No library API change or global normalization pass is proposed.
