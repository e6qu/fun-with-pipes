# Gradient storage after PR #258

Private derivative-input packing is implemented and
[its measurements are audited](packed-input-time-2026-11-04/README.md), with three
AMD64 timing limits open. [PR #257 is verified delivery](../roadmap-history.md#packed-derivative-inputs-pr-257).
PR #258 delivered
[consuming array maps and coordinate-list reuse](owned-numeric-updates.md), with
[native checks](owned-numeric-checks-2026-11-05/README.md) and
[exact allocation counts](owned-numeric-census-2026-11-05/README.md) verified.
[Compiler-cost limits pass](owned-numeric-analysis-2026-11-05/README.md);
[runtime results are audited](owned-numeric-time-2026-11-05/README.md), with four
AMD64 speed targets open. [All final production checks passed](owned-numeric-checks-2026-11-05/platforms/final-gates.json).
This report explains that measured starting point. Later work removed
[gradient-call containers](gradient-call-time-2026-11-05/README.md), reused
[private pair buffers](packed-pair-cleanup-time-2026-11-05/README.md), and passed
[computed numeric inputs directly](computed-numeric-time-2026-11-07/README.md).
[The plan](../../PLAN.md) owns current priorities.

## Allocation breakdown at that revision

The [source-site report](gradient-storage-2026-11-05/README.md) audits one
fresh 129-coordinate/199-update solve: 2,121 managed requests, 1,265,230 requested
bytes and 398 retains. Eight requests per update occur during forward recording;
the derivative result and coordinate scratch add one each. Peak managed storage
is 9,280 bytes; peak raw derivative storage is 33,904 bytes with workspace reuse.
Neither counter is whole-process RAM.

Its fresh input is exclusive. The repeated timing driver shares its initial input
between solves, so their absolute counts differ. Use each report's own driver and
reference. The report names the remaining fold record, singleton seed containers,
coordinate scratch and two retain sites. Those observations selected the later
gradient-call changes linked above; they are not another backlog.

## How consumed storage preserves aliases

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
or free an input. This group uses separate private consuming operations;
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

Both consuming operations pass native correctness and exact allocation checks.
Runtime measurements show 3.36–10.50% less time for long solves, with four AMD64
5% targets missed. All final production gates passed. At 129 coordinates
and 199 updates, the census confirms 25,741 fewer requests and 819,968 fewer
requested bytes per solve. Retain counts and raw derivative storage are unchanged.
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
| [Private input packing](packed-derivative-inputs.md), PR #257 | Native correctness, compiler-cost, complete raw runtime audits and all final production gates pass; input packing preserves all three eager stages. | Three AMD64 timing limits remain open. |

Each group keeps its own reference and measured outcomes. A gain against a newer
reference does not settle an older comparison. [The input source review](numeric-record-inputs-2026-11-04/README.md)
records the preparation evidence that led to packing; it is not another backlog.
