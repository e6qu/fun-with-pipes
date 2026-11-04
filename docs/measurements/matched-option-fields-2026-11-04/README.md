# Matched optional results: native checks pass

The [contract](../matched-option-fields.md) removes the `Some(value)` allocation
when a list read or final-iteration result immediately enters a selected match.
List reads retain the selected element; iteration transfers its existing owner.
The payload may still own heap storage.

[Run 41808352672](https://github.com/e6qu/fun-with-pipes/actions/runs/41808352672)
passes at `fb46193306de9c377a644138df8d1480e7ca7db3` on Linux ARM64/AMD64
with GCC and macOS ARM64 with Clang. Each host passes:

- 268 compiler unit tests, with four deliberate ignores.
- 57 integration tests across 15 targets; seven selection/exclusion checks.
- 40 new native controls at O1/O2, including list/array payloads, aliases,
  retain overflow, callback traps, cancellation and failed result boxing.
- Raw/optimized interpreter agreement and boxed/direct-field native controls.
- Actual native image checks: 506 observations plus eleven other status records.

## What the allocation checks measure

Inputs, defaults and callbacks are constructed before counting the operation.
The result and all input owners are then released; final managed storage and
physical-allocation tracking must return to their starting values.

| Operation | Boxed control | Selected fields |
|---|---:|---:|
| Present `last` or `nth` result | 1 wrapper allocation | 0 |
| Missing `last` or `nth` result | 0 | 0 |
| Selected iteration with the tested identity callback | — | 0 additional allocations |

The list-read controls cover scalars, strings, F128, nested numeric lists, numeric
arrays and files. Iteration covers scalars, F128, numeric lists and arrays at counts
−1, 0, 1, 4 and 64. Count includes the initial value. Arbitrary callbacks may
allocate; these zero counts are not a promise about their work.

All three hosts agree on 960 list-read and 80 iteration observations, plus the
240 earlier scalar-iteration observations. Corrupted tags and deliberately
omitted releases fail their intended observers. An array-slice example confirms
that changing the selected result leaves the original array unchanged.

[Evidence index](native/index.json) links every full log, target log and audit.
Compressed archives retain generated sources, actual new-control executables,
outputs and statuses; repeated sources/images are stored once by digest.
[The first batch](fixture-repair/README.md) preserves its repaired fixture failure.

## Measurements pass; delivery remains open

Measurement source is `82963531dddb6d9a5f32ec26657dc220736f4055`, immutable tag
`roadmap/matched-option-measurement-2026-11-04`. Its compiler, runtime, library,
tests and build inputs match the passing focused source byte for byte.

The comparison disables only the three new field selections in its reference.
Both sides preserve earlier iteration optimizations and lifetime repairs. Both
measurement drivers explicitly set and record `FWP_VRET=1` and
`FWP_FRAME_FIELDS=1`; the reference disables the selected transformations in source.

[Compiler-cost measurements](../matched-option-analysis-2026-11-04/README.md)
pass all ten cases; all 480 commands and raw records are audited.
[All four runtime sessions](../matched-option-time-2026-11-04/README.md) and their
raw audits pass. Every history-form solve saves one allocation request, 16
requested bytes and one retain. Peak managed/raw storage is unchanged. Some
larger cases are up to 1.95% slower, within the frozen 2% limit; maximum frame
growth is 16 bytes. These reductions are not a general speedup and do not close
older timing goals. Four wrong-CPU hosts were rejected before building/timing;
all are retained and only their unmeasured sessions were replaced.

Final platform gates and delivery remain pending; [the handoff](../../development-state.md)
records the exact jobs and the one active delivery PR.
