# Remaining storage in gradient descent

This review records remaining costs and the proofs needed to remove them.
The [same-type conversion group](scalar-array-identities.md) is now selected for
implementation and verification, separately from the
[direct array-call experiment](direct-array-callbacks.md). Other candidates below
remain unselected. Each experiment keeps its own reference and measurements.

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
The complete runtime report and final platform matrix remain in progress;
[the handoff](../development-state.md) records exact sources and jobs. Both sides
of the frozen comparison include the scalar repair; the reference disables only
map removal. Passing allocation checks does not satisfy the separate speed goals.

The rewrite transfers the existing owner through the ordinary ownership pass.
Aliases retain their values, and failure/cancellation checks verify cleanup.
Keeping a slice can prolong its larger backing array's lifetime: the
[storage report](scalar-array-identities-2026-11-03/README.md#result-lifetime-and-allocation-traffic)
shows that cost alongside the removed allocation. Unknown/effectful callbacks
and non-F64 maps are outside this selection.

## Another opportunity: discard an unused iteration history

The benchmark's history source is `iterate count descend | last`: it builds
intermediate vectors even though only the last is returned. A selected compiler
transformation could keep only the current value when the iteration list has no
other use. This is not implemented by the current measured source.

For example, `0 | iterate 3 (add 1) | last` currently builds `[0, 1, 2]`
and returns `Some 2`. The count is the number of values, including the initial
value; it is not the number of callback calls:

| Count | Callback calls | Result from initial value 0 |
|---|---:|---|
| Negative or zero | 0 | `None` |
| 1 | 0 | `Some 0` |
| 3 | 2 | `Some 2` |

In [the standard library](../../lib/list.fwp), `last` is `reverse | head`, not a
primitive. [Native iteration](../../runtime/fwp_rt_prims.c) retains each state
in a scratch array before constructing the list. A future rewrite must recognize
the actual lowered producer/consumer, preserve the optional result and avoid
retaining intermediate states that have no remaining use. Evaluating the count,
callback expression and initial value still matters even when the callback is
never called. This source review does not select that rewrite yet.

Earlier destruction can be observable for files, locks or other resources. An
initial selection should exclude such states unless it proves that release timing
is preserved; numeric state alone does not need that broader promise.

Before selecting it, specify and test:

- Zero/negative counts, one value, and the exact number of callback calls.
- Evaluation of the count, callback construction and initial value, even when no
  callback executes; preserve effects and trap order.
- A callback returning an alias of its input, shared/captured values, failure,
  cancellation, and values whose destruction releases resources.
- Rejection when the history itself is returned, shared or inspected elsewhere.

Measure this separately from changing coordinate storage. If a later compiler
eliminates the history, label the comparison by the source forms (`iterate | last`
and a current-value loop), and report what each actually retains. Preserve the
older reports as observations of their recorded compiler; do not silently relabel
their data or treat their allocation counts as future semantic requirements.
