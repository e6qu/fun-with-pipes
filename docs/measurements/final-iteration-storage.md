# Returning the final iteration value

**Source review in progress. No rewrite or performance claim yet.**
This is the next candidate from the [remaining storage review](remaining-gradient-storage.md).
PR #254 must finish its final platform gates before another delivery PR opens.

```fwp
0 | iterate 3 (add 1) | last
```

`iterate` builds `[0, 1, 2]`: its count includes the initial value. `last` returns
`Some 2`. Its current definition, `reverse | head`, also builds a reversed list.
When only that final result is used, a loop could keep the current value instead
of the full history. This matters when each value is a large coordinate list.

| Count | Calls to `add 1` | Result |
|---|---:|---|
| Negative or zero | 0 | `None` |
| 1 | 0 | `Some 0` |
| 3 | 2 | `Some 2` |

## Establish the actual compiler input first

The `iteration-storage-review` suite in the
[numerical workflow](../../.github/workflows/numerics.yml) saves source, raw and
optimized intermediate representation (IR), and emitted C. IR is the compiler's
typed description of operations before native code generation.

The [inspection script](../../scripts/inspect-iteration-storage.py) covers:

- An integer state and a list of floating-point values.
- A history also returned to the caller, which must remain available.
- The real gradient program with 3 coordinates/2 updates and 129/199.
- The current-value version of the large program for structural comparison.

It builds the unchanged compiler with production Rust settings on a Linux ARM64
runner. It generates C at O2 but does not execute or time the programs. This
establishes where a rewrite could apply; it proves neither correctness nor speed.

## Questions to settle before implementation

- Recognize actual typed operations, not a user function named `last`.
- Preserve evaluation of count, callback construction and initial value, even
  when the count is zero. Invoke the callback exactly as often and in the same
  order, including its effects, traps and possible nontermination.
- Preserve native count validation before callbacks. Native iteration rejects
  counts too large for its temporary array; the interpreter currently has no
  corresponding guard. Resolve that discrepancy without attempting huge allocations.
- Start with states whose release has no observable effects. Files, sockets,
  weakly observed channels and closures holding resources need separate proofs.
- Handle callbacks returning their input or a captured alias. Keep shared
  histories intact. Verify normal completion, failure, cancellation and cleanup.

After this review, freeze the exact selection, ownership rules, rejected cases
and measurement limits before changing the compiler. Measure allocation traffic,
live memory and elapsed time separately. If the history disappears, say so in the
new comparison; retain older reports as observations of their recorded sources.
