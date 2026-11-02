# Field-owner transfer requirements

Frozen before compiler edits by `roadmap/field-owner-transfer-protocol-2026-11-02`.
This is the first implementation stage of the
[grouped ARC batch](derivative-owner-transfers.md). Callback-input borrowing is
a separate proof in that batch; do not change its contract under this protocol.

## Selected expression

Use the typed ownership expression and the backend's already-separated fields.
Select consecutive local bindings that read every field of one record exactly
once, ending with release of that record. Require:

- An owned parent represented by separate fields; two to eight fields.
- Every selected field needs reference counting. Reject observable resources,
  resource slots, borrowed parents and loop-state representations.
- Each binding has only its field read, retain and resulting local. The last
  binding also releases the parent. No intervening call, trace, branch, allocation
  or other ownership operation; no remaining parent use.
- Destination names are distinct. Preserve the ownership checker's validated
  expression; emit the equivalent moves only after proving the complete group.

```text
Before: retain field 0; name field 0; retain field 1; release parent; name field 1
After:  move field 0 to its name; move field 1 to its name
```

The existing final-field transfer already removes one retain. The new complete
transfer must remove the earlier retain/release pair without changing owners at
the next call. Boxed entry cleanup remains at its original position. If any
condition fails, use the existing correct lowering; no runtime ownership guess.

## Checks and count requirements

Reuse the audited `a4f3200c` source/count baseline; no compiler source changed
between that measurement and the parent of this preparation. For every one of
its 96 observations, with `p = (coordinates - 1) * updates`:

- Remove the tuple-projection site's `p` retains. Mapper input sites stay `2*p`.
- Whole-solve effective retains fall by at least `p`; attribute any extra saving.
  Never hide an increase at another phase or allocation site.
- Do not increase managed requests, requested bytes, peak storage, raw tape or
  workspace storage. Preserve derivative operations and complete output. Final
  managed/raw storage remains zero; zero-update observations remain unchanged.
- Report code size and static frames on both architectures. Maximum frame growth
  is 128 bytes; code size alone is not a performance acceptance criterion.

Compare raw/optimized interpretation and native GCC/Clang O1/O2. Exercise direct
and function-value entries; distinct/shared child boxes; retained input aliases;
reordered fields; two/eight fields; repeated, partial and interrupted transfers;
borrowed/resource exclusions. Verify exact owners and physical cleanup on ordinary
return, traps, cancellation and allocation failure. A deliberately omitted
release must fail the control.

Keep the selection bounded: at most eight consecutive bindings, each with the
fixed projection shape above. Inspect cheap eligibility before walking a group;
do not add a whole-function scan for every unrelated binding. Check the original
ownership expression and keep call-liveness identities valid after the group.

Run focused correctness/count checks for this stage. Run paired timings after
the related ARC changes are complete, using the existing whole-solve driver,
two qualified sessions per architecture and unchanged 2% copy/regression and 5%
large-case improvement limits. Preserve failed/inconclusive results. Complete
one final platform matrix for the combined implementation, evidence and docs.
