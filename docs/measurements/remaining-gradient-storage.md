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
The [new preparation contract](scalar-array-identities.md) selects an initial
F64 case separately from direct callback dispatch.

### Conversion semantics to settle first

Source inspection at `89394229` found different same-type NaN behavior:

| Path | What the code does |
|---|---|
| Interpreter, F64 → F64 | Widens through the software F128 core and narrows again. That core replaces NaNs with a canonical positive quiet NaN. |
| Native, F64 → F64 | Loads and stores F64 directly, preserving its bits. |
| Native specialized F128 → F128 | Returns the incoming bit structure unchanged. |
| Generic boxed F128 → F128 | Copies the bits into a new owned box; returning the borrowed box would break its ownership contract. |

A NaN is a floating-point non-number value. Several bit patterns represent it,
including a sign and payload. For example, F64 bits `0xfff8000000000042` encode
a negative quiet NaN with payload `0x42`; `0x7ff8000000000000` is the canonical
positive quiet NaN. Ordinary numeric equality cannot test this distinction,
because a NaN does not compare equal even to itself. Tests must inspect bits.

The [float contract](../float-formats.md) describes canonical arithmetic and
conversion NaNs for the software formats, but does not distinguish same-type
conversion from changing formats. A pending design decision asks whether every
same-type conversion should preserve bits. Cross-type conversion rules are not
part of that proposed change. Do not remove a conversion until its rule is explicit
and the interpreter, generic native entry and specialized worker agree.

### Proposed bounded implementation and checks

If same-type conversion is defined as an identity:

1. Make that scalar behavior consistent for F16, BF16, F32, F64 and F128. Keep
   the generic F128 result owned; preserving bits does not permit returning a
   borrowed box. Test finite values, signed zero, subnormals, infinities and
   positive/negative quiet/signaling NaNs through raw-bit inputs.
2. Initially remove only `array.map` of a statically known primitive
   `float.convert : F64 -> F64`. Match its concrete argument/result types and
   arity at the existing optimizer call site. Do not follow arbitrary callbacks
   or add a whole-program analysis. Cross-type maps, dynamic functions and
   effectful callback construction must remain unchanged.
3. Replace the selected map with its input expression before ownership insertion.
   Evaluate that input exactly once. Prove a unique input moves to the result;
   a shared input gains the ordinary result owner, and slices keep their backing
   storage alive. Test subsequent immutable updates, aliases and repeated release.
4. Compare raw and optimized interpreter results with GCC/Clang O1/O2, packed
   arrays enabled/disabled, empty and sliced arrays, effects, traps, failure and
   cancellation. Check primitive dispatch and scheduling so the rewrite removes
   no observable callback action. Native counts must show no replacement array
   or element traversal, with zero final managed/raw storage.
5. Freeze a reference disabling only array-map removal. Both sides must include
   the same scalar correctness fix. Measure the existing gradient cases and
   compiler scaling workload; do not compare changed float semantics as though
   they were only a performance optimization. Keep old timing misses open.

Relevant implementation points are [the optimizer](../../src/opt.rs),
[interpreter](../../src/interp.rs), [generic numeric runtime](../../runtime/fwp_rt_num.c),
[wide workers](../../src/cgen_wide.rs) and
[ownership contracts](../../src/ownership.rs). The linked contract freezes this initial F64 array scope before implementation;
it does not promise elimination for every numeric representation.

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
