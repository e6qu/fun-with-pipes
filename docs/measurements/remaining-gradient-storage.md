# Remaining storage in gradient descent

This review records remaining costs and the proofs needed to remove them.
The [same-type conversion group](scalar-array-identities.md) awaits final delivery,
separately from the
[direct array-call experiment](direct-array-callbacks.md). Final-iteration consumption is the
[selected next group](final-iteration-storage.md); record packing and coordinate
reuse remain unselected. Each experiment keeps its own reference and measurements.

## Measured costs

The [gradient-array report](gradient-array-storage-2026-11-03/README.md) measures
source `1f6a4ac8`. In one 129-coordinate, 199-update solve, each group below makes
25,671 allocation requests for 616,104 requested bytes:

| Group | Why it exists | Constraint on removing it |
|---|---|---|
| Input derivative records | Each `Rev` pairs a coordinate value with a derivative-node number | Ordinary floating values have numeric fields; nested derivatives can contain owners that must be preserved. |
| List of input derivative records | The objective accepts `List[Rev[t]]` | The Rosenbrock objective reads overlapping neighboring pairs. One mapped producer does not imply one traversal or no aliases. |
| Updated coordinate list | Each step returns immutable coordinates | Current-only iteration can discard old coordinates; retained histories and other aliases still need their original values. |

These are allocation traffic totals, not simultaneously live memory or process
RSS. The public `grad` still returns a list. PR #252 removes only selected private
gradient-list materialization; it does not remove these three groups.

## Ownership decisions needed

**Input records and their list:** `rev._seed-float` and `rev._seed-owned` in
[autodiff.fwp](../../lib/autodiff.fwp) construct the objective's inputs. A packed
representation would need to preserve overlapping reads, callback evaluation
order and the entire objective call's lifetime. It must reject unsupported escapes
or provide correct ownership for them. Start any proof with ordinary scalar fields;
F128 and nested `Rev` require their own representation and cleanup evidence.
Changing the public objective type is permitted in this pre-alpha, but changing
`List` to `Array` alone does not prove that record allocations disappear.

The existing [packed-record lowering](../../src/cgen/packed_records.rs) handles
an eager map whose only consumer is a numeric-record fold. The objective's
overlapping reads do not match that pattern. Extending it needs a representation
and lifetime proof for those reads, not just adding `Rev` to an eligibility list.

Current arrays pack scalar numeric values, including F128 bits. A `Rev[F64]` element
still occupies a pointer-sized slot referring to a separate record. The
[runtime array operations](../../runtime/fwp_rt.c) therefore need more than a
library type change to store `Rev[F64]` as adjacent value/node-number fields.
Two possible scopes have different proof costs:

| Approach | Work required before selection |
|---|---|
| Extend private packed-record lowering | Recognize overlapping reads in a known consumer; keep the producer and callback order; prove that the buffer and borrowed fields cannot escape. |
| Make numeric-record arrays a general representation | Define record layout and alignment; update every load/store, slice, comparison, encoding and cleanup path; give escaped records independent owners. |

F128 arrays already distinguish borrowed payload reads from independently owned
escaping values. That is a useful lifetime example, not proof that record reads
can use the same representation unchanged. Neither approach is selected yet.

**Updated coordinates:** [the ownership contract](../../src/ownership.rs) makes
`zip-with` borrow both lists and return a fresh list spine. Its implementation
cannot overwrite or free an input under that contract. Reuse would require an
explicit compiler proof or an internal consuming operation, including shared-tail
checks where needed. Callbacks must finish in the same order; aliases must retain
their values. Failure and cancellation must release old input, partial output and
scratch exactly once, including when zip stops at the shorter input.

## Selected conversion change

The measured source above makes 199 replacement conversion arrays per large
solve, requesting 206,960 bytes. The current implementation removes that F64
identity map before ownership insertion. It also repairs same-type scalar
conversion to preserve all bits, including signed zero and NaN payloads.
Cross-type conversions still round; generic F128 results keep independent owners.
[Conversion rules](../float-formats.md#current-contract) explain the semantics.

[Three-host native checks](scalar-array-identities-2026-11-03/README.md) and
[compiler-cost checks](scalar-array-identity-analysis-2026-11-03/README.md) pass.
[The runtime report](scalar-array-identity-time-2026-11-03/README.md) and four
raw audits are complete; all 32 required speed gains are missed. The final
platform matrix remains pending. [The handoff](../development-state.md) tracks it. Both sides
of the frozen comparison include the scalar repair; the reference disables only
map removal. Passing allocation checks does not satisfy the separate speed goals.

The rewrite transfers the existing owner through the ordinary ownership pass.
Aliases retain their values, and failure/cancellation checks verify cleanup.
Keeping a slice can prolong its larger backing array's lifetime: the
[storage report](scalar-array-identities-2026-11-03/README.md#result-lifetime-and-allocation-traffic)
shows that cost alongside the removed allocation. Unknown/effectful callbacks
and non-F64 maps are outside this selection.

## Selected next group: discard an unused iteration history

The benchmark's history source is `iterate count descend | last`: it builds
intermediate coordinate lists although only the final one is returned. The
[source review and native checks](final-iteration-storage-2026-11-03/README.md)
confirm that the original compiler constructs both the history and a reverse
copy. The new selection removes both when only the final value is used. Its
shared-history control retains a second use that must remain available.

The [implementation contract](final-iteration-storage.md) now selects direct
`last`, eligible numeric-state history removal, matching count validation and
an incidental optional-result cleanup repair as one group. Implementation and
three-host focused verification are complete. The
[four-session report](final-iteration-time-2026-11-04/README.md) verifies lower
memory and ARC costs, with six timing limits still open. Final platform gates
remain required. Resource-bearing states are excluded from history removal;
general `last` passes separate ownership checks for those values.

This is measured separately from coordinate representation. Comparisons label
the source forms: the candidate history-form program retains only its current state.
Preserve older reports as observations of their recorded compiler; their history
allocation counts are not future semantic requirements.
