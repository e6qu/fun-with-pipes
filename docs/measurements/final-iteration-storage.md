# Returning the final iteration value

**Implemented and verified on three focused native hosts; measurements and final delivery gates remain open.**
This contract was frozen at `2a257a3e` with
`roadmap/final-iteration-storage-protocol-2026-11-03` before implementation.
PR #254 must finish its gates before
another delivery PR opens. [Source evidence](final-iteration-storage-2026-11-03/README.md)
records the actual compiler input, native checks and scalar allocation counts,
including selection in the real gradient program.

```fwp
0 | iterate 3 (add 1) | last
```

`iterate` builds `[0, 1, 2]`: its count includes the initial value. `last` returns
`Some 2`. Its previous definition, `reverse | head`, also built a reversed list.
The selected change reads an ordinary list's final item directly. When an eligible
iteration has no other consumer, it keeps only the current value instead of a history.

| Count | Callback calls | Result from initial value 0 |
|---|---:|---|
| Negative or zero | 0 | `None` |
| 1 | 0 | `Some 0` |
| 3 | 2 | `Some 2` |

## Implementation contract

1. Make `last` a typed primitive that borrows the input list, walks to its final
   node and returns `None` or an owned `Some` result. It preserves the public
   signature and all supported element types. Keep the input alive during the
   walk; retain only the returned element. Do not construct a reversed list.
2. In the existing fusion pass, select `last (iterate count callback initial)`
   or an immediately consumed, single-use local with those exact typed calls.
   Match primitive identities, arities and types, not user display names.
   Initially admit numeric scalar states, including boxed wide numbers, and
   `List`/`Array` states with numeric scalar elements. Reject resource-bearing,
   callable, unknown and other state types. A returned/shared history keeps its
   producer; its separate `last` call can still avoid the reverse copy.
3. Lower selected iteration to an internal operation that borrows the callback,
   consumes the initial state and returns an owned option. Transfer each current
   state to the callback using existing typed argument ownership; keep its result
   until the next call. Support dynamic and captured callbacks without changing
   their construction or invocation order. Returning an input/captured alias
   must remain safe. Protect the current owner through failure and cancellation.
4. Evaluate count, callback construction and initial value once, in original
   order, before validating the count. Keep negative counts empty and preserve
   native `iterate too large` rejection before callbacks. Apply the same bound
   in the interpreter. Do not add scheduler entries or change arithmetic order.
5. Repair fresh optional-result cleanup: if retaining a borrowed child fails,
   release acquired child references and the new wrapper. Never release a child
   whose reference was not acquired. Reuse existing cleanup helpers.

The source/API remains single-argument, curried and data-last. No new syntax,
array layout, GC, global escape analysis or compatibility adapter is needed.
The eligibility check uses existing types and a bounded set of shapes.

## Required verification

- Raw/optimized interpreter and native O1/O2: empty, negative, one and many
  iterations; exact numeric bits, wide boxes, lists/arrays, aliases and captures.
  Verify input/construction effects, callback order, traps and count rejection.
  Test the oversized boundary with a callback that fails immediately, never a
  huge successful allocation or loop.
- Preserve histories that are returned or used twice; reject unsupported state
  types and unrelated user functions named `last`. Test generic `last` with
  owned elements, including observable resources, independently of fusion.
- Check physical release, wide-count overflow, recoverable failure, cancellation,
  unique/shared inputs and reuse on/off. Missing-cleanup controls must fail.
  Verify both generated code and actual native executables on GCC ARM64/AMD64
  and Clang ARM64. Audit primitive contracts against their unchanged baseline.
- Group focused checks after the related implementation is ready. Require the
  complete nine-job native/benchmark matrix and documentation on the final head;
  audit full and target logs before squash merge.

## Measurements and acceptance

Freeze a same-source reference restoring `last = reverse | head` and disabling
only history removal. Both sides include the count-validation and cleanup repairs.
Retain exact source/patch identities and controls rejecting an incomplete reference.

Use the existing six coordinate/update pairs, current/history source forms,
98-sample balanced schedule, seven processes per sample and two qualified sessions
per architecture. Keep GCC flags, workspace policy, outputs and driver fixed.
Require identical-copy variation ≤2%, zero/one-update regression ≤2%, and ≥5% less
elapsed time on larger history cases. Current-value cases must not regress by
more than 2%. Compiler time/RSS increases must stay within 5%; reported frame
increases within 128 bytes. Report code size separately from performance.

For a scalar identity iteration producing k positive values, remove both k-node
list spines: 2k allocations. A standalone `last` removes its n-node reverse copy.
For the 129-coordinate/199-update history solve, require at least 80% less peak
managed storage; report raw storage and process RSS separately. Do not increase
ARC counts or allocation traffic in current-value controls. Report all count,
traffic, live-memory, timing and stack results, including rejected cases.

Do not repeat completed timing sessions for a pass. Accepted policy permits
verified cost reductions with missed timing limits explicitly open. Older goals
keep their original references. If the history disappears, describe what the
new compiler actually retains; never relabel old measurements as current behavior.
