# Consume an index range without constructing its list

**Status:** contract frozen at `e86ee4cc` before edits; implementation and
controls are written in PR #251, with native verification and measurements pending.
This is the next storage change after the scalar-map buffer. Keep its reference
separate from the ongoing [scalar-buffer comparison](temporary-list-storage.md).

## Observed cost

`enumerate` pairs each value with its zero-based index:

```fwp
[10.0, 20.0] | enumerate
# [(0, 10.0), (1, 20.0)]
```

Its library definition is `fork zip id (length | range 0)`. Derivative input
seeding maps those pairs to records holding the value and its tape position.
Existing fusion removes the pair boxes but still constructs the index list:

```text
input values → length → list of indices ─┐
input values + known tape offset ────────┴→ zip callback → derivative input records
```

The [constructor census](temporary-list-census-2026-11-03/README.md) attributes
`d*u` cells to `fwp_p_range_owned` for `d` coordinates and `u` updates. The
[scalar-buffer verification](temporary-list-storage-2026-11-03/README.md) leaves
that input path unchanged. At 129/199 it creates 25,671 range cells, plus one
scratch copy per update when zip reads the range.

## Selected implementation boundary

Replace a private `range` list with its two evaluated I64 bounds. Zip generates
each index when needed and keeps its ordinary output list:

```text
Before: evaluate bounds → allocate index list → copy indices → zip
After:  evaluate bounds → retain two scalar bounds ──────────→ zip
```

- Select only the existing I64 `range` primitive: lower bound inclusive, upper
  bound exclusive; upper ≤ lower means empty. Do not change the public API.
- Require one zip consumer through a complete single-use, straight-line alias
  chain. Shared/escaping ranges and unproved control-flow paths keep their
  ordinary implementation. Support either zip input slot.
- Resolve a known two-argument callback, including a known partial application
  with machine-scalar captures. Require the non-index input to be a machine
  scalar. Accept scalar results or flat one/two-field numeric records, including
  `Rev[F64]`. Exclude unknown callbacks, reference-bearing captures/inputs,
  nested/wide result fields and unsupported records.
- Evaluate each bound exactly once, at the original range creation, in its
  original order. Preserve callback construction, intervening effects and the
  other zip argument's evaluation. A scalar bound is not recomputed at zip.
- Generate the same indices and data-last callback arguments. Use an unsigned
  distance and index calculation with a proof that every used index is below
  the exclusive upper bound; avoid signed overflow at I64 extremes.
- Keep callback scheduling checks. Borrow the other list and callback; scalar
  captures need no extra owners. One protected scratch buffer holds completed
  callback results before ordinary list construction. Protect numeric record
  boxes and partial list output through traps, cancellation and allocation failure.
- Do not mutate source aliases, add retries, or introduce new public syntax.
  Index uses and callback origins once; follow disjoint alias chains. Keep the
  analysis bounded and test its visit-count scaling.

## Exact prediction and reference

For one complete solve, remove `(d+1)*u` allocation requests and `(32*d+8)*u`
requested bytes: `d*u` range cells at 24 bytes each, plus `u` scratch arrays of
`8*(d+1)` bytes. Retains, output and derivative work must match; managed peak
must not grow; final managed/raw storage must be zero. Zero-update counts stay
unchanged. Do not infer whole-process RSS or speed from these counts.

At 129/199, current-only, the predicted change is:

| Cost | Verified scalar-buffer source | Range consumer prediction |
|---|---:|---:|
| Allocation requests | 131,073 | 105,203 |
| Requested bytes | 4,559,078 | 3,736,014 |
| Retains | 995 | 995 |

Use a same-source reference that bypasses only `range_zip::lower` after the
scalar-map buffer selection and before numeric-parameter lowering. Keep every
previous optimization enabled in both builds. Publish and verify that isolated
source rewrite before measuring. `scripts/prepare-range-zip-reference.py`
removes that call only; its three isolation/corruption controls pass locally.

## Controls and acceptance

- Empty, reversed, unequal-length and negative ranges; both input slots; all
  supported scalar inputs; scalar and record outputs; scalar captures.
- I64 minimum/maximum bounds and cross-zero ranges with a short other list.
  Check results without asking the ordinary implementation to allocate a huge list.
  Use finite boundary-sized ranges for ordinary/unoptimized/native parity.
- Bound evaluation count/order, callback/capture effects, intervening effects,
  argument order and callback traps. Unknown, shared, escaping and reference-
  bearing cases must be excluded from selection.
- Shared input aliases, partial callback results, result-construction failures,
  cancellation, allocation failure and deliberately omitted destruction. Verify
  physical frees, not just reference counters.
- Native GCC/Clang O1/O2, ordinary/unoptimized interpretation, all 96 saved count
  combinations, independent reconstruction of counters/source/images and the
  existing scalar-map and fold regression targets.
- Compare compiler cost on the five fixed inputs. Compare complete solver
  runtime on all six inputs with two sessions per qualified architecture.
  Keep 2% identical-copy/regression, 5% large-case speed and 5% compiler time/RSS
  limits. Report code size and allow at most 128 bytes of static-frame growth.
  Preserve every failed outcome and keep previous timing goals open.

Finish implementation and focused controls before the grouped measurement and
final platform runs. Bundle the change with scalar-buffer reports and any CI
repairs in the next substantial PR.
