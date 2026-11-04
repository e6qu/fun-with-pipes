# Remaining storage in gradient descent

Private derivative-input packing is implemented and
[its measurements are audited](packed-input-time-2026-11-04/README.md), with three
AMD64 timing limits open. Its [contract](packed-derivative-inputs.md) is frozen;
final production delivery is pending in PR #257. Coordinate-list reuse remains
unselected. [The plan](../../PLAN.md) owns current work and acceptance.

## Measured costs

The older [gradient-array census](gradient-array-storage-2026-11-03/README.md),
source `1f6a4ac8`, counted 25,671 allocation requests and 616,104 requested bytes
for each group in one 129-coordinate, 199-update solve:

| Historical group | Current status |
|---|---|
| Input derivative records | Selected private one/two-field numeric records now use a shared buffer; other uses keep their ordinary representation. |
| List of input derivative records | The selected neighboring-pair consumer borrows overlapping windows of that buffer. |
| Updated coordinate list | Still returns immutable coordinates. Reuse needs its own ownership proof and a fresh count at the current source. |

These historical totals measure allocation traffic, not live memory or process
RAM. Do not reuse them as current measurements. For the complete packed-input
group, the [new count report](packed-input-time-2026-11-04/verified-memory-counts.json)
verifies 51,541 fewer requests and 1,031,616 fewer requested bytes per largest
solve. Public `grad` still returns a list.

## Ownership decisions needed

`zip-with` borrows its input lists and returns a fresh list spine. Under that
[ownership contract](../../src/ownership.rs), its implementation cannot overwrite
or free an input. Reusing updated coordinates would require a compiler proof or
an internal consuming operation. Before selecting it:

- Identify current allocation sites and count their cost on the measured source.
- Prove that the old coordinate owner is consumed after its last read. Retained
  histories, other aliases and shared tails must keep their original values.
- Preserve callback, arithmetic and trap order. Do not turn an eager stage into
  streaming computation across another stage's effects.
- Release old input, scratch and partial output exactly once on failure or
  cancellation, including unequal list lengths and empty inputs.
- Freeze selection, exclusions, same-source reference and cost limits before
  implementation; then check both interpreters and native O1/O2 cleanup.

This is a possible next group, not a selected optimization or a promised speedup.
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
