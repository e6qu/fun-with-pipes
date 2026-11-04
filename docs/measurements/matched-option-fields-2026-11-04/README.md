# Matched optional results: verification in progress

The [contract](../matched-option-fields.md) removes the `Some(value)` allocation
when a list read or final-iteration result immediately enters a selected match.
List reads retain the selected element; iteration transfers its existing owner.

The first three-host batch found a fixture type error and formatting mismatch.
[The failure record](fixture-repair/README.md) preserves every target outcome,
including the native owner controls that passed. The fixture is repaired;
expanded list/array controls still need native verification. No runtime or
compiler-cost measurements have run, and this group is not accepted yet.

The comparison uses the same compiler source with only the three field selections
disabled in its reference. Both sides preserve earlier iteration optimizations
and lifetime repairs. Allocation counts, elapsed time and live memory are separate
results; none substitutes for another.

Both new measurement drivers explicitly set `FWP_VRET=1` and
`FWP_FRAME_FIELDS=1`: direct variant returns and resource-frame fields are enabled
on both sides. Those settings are recorded and checked, rather than inherited
from the runner. The reference disables only the three new selections in source.
