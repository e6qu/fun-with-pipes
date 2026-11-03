# Remaining storage in gradient descent

This is a source review, not a selected optimization or a performance claim.
Finish the [direct array-call experiment](direct-array-callbacks.md) before
choosing another implementation. Its reference and timings must remain isolated.

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

**Updated coordinates:** [the ownership contract](../../src/ownership.rs) makes
`zip-with` borrow both lists and return a fresh list spine. Its implementation
cannot overwrite or free an input under that contract. Reuse would require an
explicit compiler proof or an internal consuming operation, including shared-tail
checks where needed. Callbacks must finish in the same order; aliases must retain
their values. Failure and cancellation must release old input, partial output and
scratch exactly once, including when zip stops at the shorter input.

## Check redundant same-type conversions

The same report counts 199 replacement conversion arrays, totaling 206,960
requested bytes in the largest solve. `rev._backward-float` converts the backward
pass's F64 array to the requested scalar type. F32/F16/BF16 need real conversion;
for F64, investigate whether the map can be proven to leave every value unchanged.

An identity rewrite must preserve floating-point bits, including signed zero and
NaNs, and must transfer the existing owner correctly. Merely returning a borrowed
input would be unsafe when its caller releases it. Prove that the owned result
moves through the ordinary ownership pass without additional retains, preserve
aliases, and test cleanup before claiming removal of that allocation or traversal.
This is unselected and separate from direct callback dispatch.

## Another opportunity: discard an unused iteration history

The benchmark's history source is `iterate count descend | last`: it builds
intermediate vectors even though only the last is returned. A selected compiler
transformation could keep only the current value when the iteration list has no
other use. This is not implemented by the current measured source.

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
