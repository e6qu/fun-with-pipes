# Optional results without a temporary box

**Implementation prepared; fixture repair verification and measurements are pending.**
[The first three-host batch](matched-option-fields-2026-11-04/README.md) passes
its native owner controls but fails the source fixture and formatting; both are
repaired locally. Expanded list/array controls still need verification.
The contract was frozen at `4ec13baa`, tag
`roadmap/matched-option-fields-protocol-2026-11-04`, before implementation. This follows
[final-iteration delivery](final-iteration-storage.md). Keep PR #255's head
unchanged while its platform checks run; open one subsequent grouped PR only
after that delivery. The source reviewed here is `19b91c05`.

An `Option` says whether a value exists: `Some value` or `None`. A box is a heap
allocation holding that choice and its value. A caller that immediately examines
the choice can instead receive two ordinary C fields: a tag and a payload.
The payload can still own heap storage; removing its wrapper does not remove
that ownership.

```fwp
0 | iterate 3 (add 1) | last | match
    Some value -> value + 10
    None -> 0
```

This returns 12. The three iteration values are 0, 1 and 2; only 2 is needed.
The current compiler already removes the history, but its internal primitive
still builds `Some 2` before the caller unpacks it.
[Saved C](final-iteration-storage-2026-11-03/optional-result-review.json) records
the same boundary in the gradient program. That observation does not establish
the cause of any timing regression.

## Selection and ownership proof

Group three exact primitive calls. Match their primitive identities, arities,
concrete argument/result types and the existing small-variant shape. Do not
select by user names. Keep the existing `only_matched` / `variant_uses` rules
for uses, aliases and returned fields; do not add a whole-program analysis.

| Call | Input ownership | Successful field result |
|---|---|---|
| `last xs` | Borrow `xs` through the walk and result retain | Retain the final element once if its type owns storage |
| `nth index xs` | Borrow `xs`; evaluate index and list once, in order | Retain the indexed element once if its type owns storage |
| Internal `list._iterate-last count callback initial` | Borrow callback; consume initial state | Move the final state owner; do not retain it again |

`None` carries no payload owner. A negative/out-of-range `nth` and an empty list
still return `None`. Iteration count validation, callback order, captures,
numeric-state selection and cancellation points remain those of #255. This
does not admit resource-bearing states into history removal.

The proof has four ownership boundaries:

1. **Borrowed list read.** The caller keeps the list alive through traversal and
   the fallible retain. Use the type's retain operation: a `File` needs
   `fwp_file_dup`, not an untyped substitute. Until the retain succeeds, the
   result owns nothing. If it fails, caller unwind releases caller owners;
   no optional wrapper exists to leak. After success, the field owns exactly
   the reference that the boxed result would own.
2. **Consumed iteration state.** The runtime guard owns the current state.
   Before a callback, responsibility transfers to the existing owned application
   entry; on return, the guard takes the callback's result. At normal completion,
   remove the guard and transfer that same owner into the returned field. On
   empty iteration, release the initial owner. Count errors and callback failure
   retain the current cleanup behavior.
3. **Match.** Reuse `vlocals`, `vhelper` and the existing matched-payload move
   rule. A consumed single-payload variant can transfer its field; shared uses
   still need their individual owners. Original resource-frame holders keep
   their separate references and lexical lifetime. Do not remove their counts
   by extending the ordinary last-use rule.
4. **Whole-value boundary.** Stored, captured, passed-as-a-value or otherwise
   boxed results retain a real `Option`. If an owned field must be boxed, protect
   it until allocation succeeds, then transfer it into the box. The existing
   typed boxing helper already has this cleanup contract. Partial and indirect
   calls keep their ordinary value representation.

The current generator already implements the corresponding rules for matched
array/map reads and channel/task results. `begin_call` protects remaining caller
owners; consumed arguments belong to the callee. `end_call` only removes that
protection. No allocating or yielding action may be inserted between transfer
of the result and installation of its next owner.

## Implementation boundaries

- Extend the existing C generator's lookup/result selection. Check both the
  parameter type and `Option` payload type; malformed layouts must not select.
- Share the existing two-field `fwp_option_result` definition in the common
  runtime section: list primitives precede the task section where it currently
  lives. Do not introduce another equivalent result struct.
- Give the iteration algorithm one implementation returning owned fields. Its
  existing generic primitive entry boxes only when its value ABI requires it,
  with protected payload ownership. Keep the count-bound and callback algorithm
  identical. No duplicate loop or old-version adapter.
- Borrowed list walks return a found flag and borrowed payload; C generation
  performs the typed retain under caller protection. Never use payload bits to
  distinguish `None`: zero is a valid scalar payload.
- Preserve the primitive inventory's argument/result obligations and its frozen
  baseline. Field return changes representation, not source-level ownership.
- Add bounded checks to existing traversals; no new global inference iteration.
  Review resource-frame selection because it uses the same result classifier.

## Verification before delivery

Run grouped focused checks after all three paths and their controls are ready.
Use GCC on Linux ARM64/AMD64 and Clang on macOS ARM64, at generated O1 and O2;
the final nine production jobs and documentation must pass the final PR head.

| Boundary | Required checks |
|---|---|
| Selection | Direct calls, named aliases and immediate matches select; whole-value uses and unrelated names keep correct storage. `FWP_VRET=0` preserves the boxed control. |
| Values | Empty/missing/present results; payload zero; every scalar float width and wide integer; numeric lists/arrays, strings, closures, nested values and files for list reads. Compare raw interpreter, optimized interpreter and native results. |
| Owners | Unique/shared source lists; retained history; escaped payload; repeated matches; resource-frame fields on/off; packed arrays and reuse on/off. Caller aliases keep their values. |
| Failure | Wide-count retain overflow, argument traps, oversized iteration, callback failure/cancellation and an injected recoverable boxing failure. Check zero residual storage and empty cleanup stacks after recovery. Actual allocator exhaustion remains terminal: check its existing exit/diagnostic contract separately. |
| Observer controls | Deliberately omit a payload release and corrupt a returned tag; require the intended leak/value observer to reject each control. |
| Representation | Retain generated C and actual ELF/Mach-O/PE identities. Verify zero wrapper allocations for selected present scalar results; do not infer this from source size or disassembly alone. |

Reuse and extend the existing iteration, list-option, retain-unwind and resource
test targets. Review their fault injection before changing generated snippets:
a control that no longer reaches a selected boundary must be repaired, not
silently accepted. Record all failed batches and their causes.

## Comparison and acceptance

Freeze this contract before implementation. The same-source reference disables
only the three new direct-field selections; both sides retain direct `last`,
history removal, count validation and every cleanup repair. Do not disable all
variant returns: that would also change unrelated array/map/channel/task work.
Reference controls must reject missing, duplicate and changed selection edits,
retain both sources and their hashes, and verify that all other bytes agree.

- **Boundary counts:** each selected present result removes one wrapper request;
  `None` removes none. A matched owned iteration result adds no payload retain.
  A borrowed read retains the necessary payload owner. Escaping boxed controls
  preserve their required allocation. Measure ARC, requested bytes, peak live
  storage and final zero storage separately.
- **Whole program:** use the existing six coordinate/update pairs, both source
  forms, two qualified sessions per architecture, two warmup rounds and 98
  balanced rounds of seven processes per sample. Preserve workload, GCC flags,
  outputs, workspace policy and repetition counts from the
  [iteration report](final-iteration-time-2026-11-04/README.md#what-is-compared).
  Require identical-copy variation ≤2% and no case more than 2% slower. One
  wrapper per solve cannot reasonably promise a 5% large-solve speedup; report
  the measured difference without treating it as closure of older 5% goals.
- **Other costs:** compiler elapsed time and sampled RSS increases ≤5%; reported
  frame growth ≤128 bytes. Report native text size and process RSS separately.
  Current-form counts must not increase. No new tracing or permanent retention.

Preserve all older timing failures against their original references. New results
do not overwrite them. Keep failed/noisy measurements; never repeat a completed
session to obtain a pass. Accepted policy allows verified count reductions with
missed timing goals explicitly open, not a claim that those goals passed.
