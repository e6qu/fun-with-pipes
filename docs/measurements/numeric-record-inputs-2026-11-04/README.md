# Removing temporary derivative input records: source review

This is the historical source review that led to
[private input packing](../packed-derivative-inputs.md). Its observations below
describe the recorded source, before implementation; they are not a new backlog
or current allocation counts. [Current measurements](../packed-input-time-2026-11-04/README.md)
are recorded separately.
[Run 41818502246](https://github.com/e6qu/fun-with-pipes/actions/runs/41818502246)
compiled six inputs with and without optimization at
`82963531dddb6d9a5f32ec26657dc220736f4055`. All 12 commands, 43 hashed files and
the full job log pass audit. [The archive](evidence.zip) contains the inputs,
typed intermediate code, generated C and exact commands;
[the manifest](manifest.json) and [audit](audit.json) identify them.

## What still allocates

A derivative input pairs a number with its node number in the derivative tape.
The tape records operations needed to calculate derivatives backward. For three
inputs, the current preparation builds three boxed records and three list cells:

```text
coordinates:       [a, b, c]
derivative inputs: [(a, node0), (b, node1), (c, node2)]
neighboring pairs: [(input0, input1), (input1, input2)]
```

The middle record is read twice. Packing must preserve these overlapping reads;
it cannot consume each record after its first use.

In `descent-large-optimized.c`, the relevant functions are:

| Function | Current behavior |
|---|---|
| `f25` | Prepares inputs inside the derivative scope, then calls the objective indirectly through `fwp_apply_owned`. |
| `w160` / `f160` | Computes the value and checked node number as two fields, then boxes them. |
| `f169` | Calls that producer for each input, using scratch storage, then builds a list. |
| `w14` | Computes every neighboring-pair cost, then folds those costs into the result. |
| `f166` / `f167` | Already store pair costs in a flat numeric buffer and fold that buffer. |

The base-node capture uses a stack closure. Removing a supposed heap closure here
would target a cost that does not exist. The remaining input boxes and list cells
are visible in generated C, independently of machine-code interpretation.

## Proposed next group

1. **Expose a known objective inside its scope.** Specialize a known scoped
   worker for its known objective, using bounded, cached specialization. Keep
   scope entry and argument evaluation in place; do not run effectful partial
   applications before entering the scope.
2. **Pack its private numeric inputs.** Store value/node fields in one owned
   buffer using the existing field-return convention. Complete the input
   producer before invoking the objective, including checked index arithmetic.
3. **Borrow overlapping windows.** For a proved neighboring-pair consumer, read
   two windows of that buffer. Keep the buffer alive through every pair read,
   then release it before folding the completed pair-cost buffer.

```text
finish input packing → finish every pair cost → fold in original order
```

Streaming these three stages together could change the first trap, tape
operations or floating-point accumulation order. That is outside this proposal.
No public list-to-array API change is needed for this exact private use.

The current packed-record pass accepts a closed map callback and one fold
consumer. It runs before private range consumption. Supporting this producer's
numeric capture and the overlapping reads therefore needs an explicit extension;
adding a type to an eligibility list is insufficient.

## Proof and measurement before acceptance

- Start with records containing machine-sized numeric fields. F128, nested
  derivative records, resources, unknown callbacks and escaping uses need their
  own proof; do not silently select them.
- Verify empty/singleton inputs, overlapping reads, aliases, checked overflow,
  traps, cancellation and scope failure. Compare interpreter and native O1/O2
  behavior; check physical frees and deliberately omitted-cleanup controls.
- Verify every input field stays borrowed only while its buffer lives. A result
  escaping that buffer must have independent storage or exclude the rewrite.
- Freeze the exact selection, reference and compiler/runtime/stack limits before
  implementation and timing. Include bounded-specialization and code-growth checks.
- Predict, then count: for N inputs, the present producer uses N record boxes,
  N list cells and one scratch allocation. A private buffer could replace these
  with one allocation. Even N=0 currently allocates scratch; verify that case
  rather than inventing a special empty representation.

The older census measured each record/list group at 25,671 requests per
129-coordinate, 199-update solve. Those are [historical counts](../remaining-gradient-storage.md#measured-costs),
not a fresh measurement at this source. This review establishes the remaining
code paths, not the eventual allocation saving or speedup. Coordinate-list reuse
is a separate ownership question.
