# Remaining storage in gradient descent

Private derivative-input packing is implemented and
[its measurements are audited](packed-input-time-2026-11-04/README.md), with three
AMD64 timing limits open. Its [contract](packed-derivative-inputs.md) is frozen;
final production delivery is pending in PR #257. The following group implements
[consuming array maps and coordinate-list reuse](owned-numeric-updates.md), with
native checks and measurements pending. [The plan](../../PLAN.md) owns acceptance.

## Measured costs

The older [gradient-array census](gradient-array-storage-2026-11-03/README.md),
source `1f6a4ac8`, counted 25,671 allocation requests and 616,104 requested bytes
for each group in one 129-coordinate, 199-update solve:

| Historical group | Current status |
|---|---|
| Input derivative records | Selected private one/two-field numeric records now use a shared buffer; other uses keep their ordinary representation. |
| List of input derivative records | The selected neighboring-pair consumer borrows overlapping windows of that buffer. |
| Updated coordinate list | A private consuming entry can reuse an exclusive prefix. Its frozen proof and new tests still need native verification and measured counts. |

These historical totals measure allocation traffic, not live memory or process
RAM. Do not reuse them as current measurements. For the complete packed-input
group, the [new count report](packed-input-time-2026-11-04/verified-memory-counts.json)
verifies 51,541 fewer requests and 1,031,616 fewer requested bytes per largest
solve. Public `grad` still returns a list.

## Following group: consumed numeric storage

For example, subtracting adjustments `[1, 2]` from coordinates `[10, 20, 30]`
produces `[9, 18]`: zip stops at the shorter input. Suppose another value keeps
the original tail `[20, 30]`. The compiler may reuse the first coordinate cell,
but must copy the second result cell:

```text
Before: caller ──► A:10 ──► B:20 ──► C:30
                             ▲
        saved ───────────────┘

After:  result ──► A:9 ──► D:18
        saved  ──► B:20 ──► C:30
```

Letters identify physical cells. `A` is reused; `D` is new. `B` and `C` keep
their original values. Even if `C` has just one incoming link, the saved tail
can still reach it through `B`, so checking `C` alone would be unsafe. The new
entry checks the whole prefix and stops at the first shared cell.

`zip-with` borrows its input lists and returns a fresh list spine. Under that
[ownership contract](../../src/ownership.rs), its implementation cannot overwrite
or free an input. The next group uses separate private consuming operations;
the [frozen contract](owned-numeric-updates.md) specifies:

- Last-use selection before ownership insertion; consuming an owner does not
  imply exclusive storage. Retained histories and aliases keep their values.
- Array views/shared storage use independent output. List reuse stops at the
  first shared ancestor, even when descendants have counts of one.
- Preserve callback, arithmetic and trap order. Do not turn an eager stage into
  streaming computation across another stage's effects.
- Release old input, scratch and partial output exactly once on failure or
  cancellation, including unequal list lengths and empty inputs.
- Same-source references, predicted counts, frozen timing/compiler limits and
  raw/optimized interpreter versus native O1/O2 checks.

Both consuming operations are implemented in preparation, not verified delivery
or a promised speedup. Allocation predictions still require observed counters.
The current packed-input proof covers private flat numeric records. F128, nested
`Rev`, resources and general escaping record arrays need separate representation
and lifetime proofs; changing a public list to an array does not remove record
boxes by itself.

## Completed neighboring work

| Group | Verified result | Remaining limit |
|---|---|---|
| [Same-type scalar conversion](scalar-array-identities.md), PR #254 | Removes a private F64 identity map; preserves float bits and independent owned results where needed. | All 32 original speed targets remain unmet. |
| [Final iteration value](final-iteration-storage.md), PR #255 | Removes an unused history and reverse copy when only the final value is read. Resource-bearing states remain excluded. | Six runtime limits and one compiler-noise case remain open. |
| [Immediately matched optional results](matched-option-fields.md), PR #256 | Removes a temporary option wrapper; all production gates and frozen runtime limits pass. | Peak storage is unchanged; some cases remain slightly slower within the allowed limit. |
| [Private input packing](packed-derivative-inputs.md), PR #257 | Native correctness, compiler-cost and complete raw runtime audits pass; input packing preserves all three eager stages. | Three AMD64 timing limits and final production delivery remain open. |

Each group keeps its own reference and measured outcomes. A gain against a newer
reference does not settle an older comparison. [The input source review](numeric-record-inputs-2026-11-04/README.md)
records the preparation evidence that led to packing; it is not another backlog.
