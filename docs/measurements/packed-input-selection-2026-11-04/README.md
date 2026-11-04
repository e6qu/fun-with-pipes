# Packed inputs: selection failure and repair

The first storage preflight failed at `0b274ca8f404800e5c2dd9f1a90f7fcabaffd746`:
[run 41827593617](https://github.com/e6qu/fun-with-pipes/actions/runs/41827593617),
job `126566218264`. Compilation succeeded, as did five scoped-specialization and
three storage-proof unit tests. All twelve emitted programs compiled; the three
optimized gradient cases failed the required packed-input selection. The other
nine controls passed. No timing programs ran.

## Cause

The source and intermediate code show the input producer exposed correctly.
The pair callback still forwards whole records to a numeric worker:

```text
pair(left, right) → worker((right, left))
```

Existing numeric-parameter lowering replaces the worker's nested record with
four numeric fields. Only then can the pair callback accept unboxed fields:

```text
pair(left, right) → worker(right.value, right.id, left.value, left.id)
```

The new storage pass ran too early and correctly rejected the earlier body.
Its unit fixtures read fields directly, so they missed this pass dependency.

The repair runs numeric-parameter lowering before packed-input selection. It
does not relax the field-use or ownership proof. A production-generation unit
test now includes the forwarding shape. Native controls add both window orders,
aliases, eager stage order, failure/cancellation, allocation failure and
deliberately omitted frees. The repair and these controls still need CI results.

## Retained evidence

- [Audit](audit.json): all twelve commands, three failed selections, test totals
  and full-log digest.
- [Source archive](evidence.zip): raw/optimized intermediate code, generated C,
  inputs, command results and 43 file hashes; every hash verified.
- [Artifact identity](artifact.json), [job metadata](job.json) and
  [complete job log](job.log.gz).

Collection completed before resumption; guarded retention/full diagnostic audit
took 0.13 seconds. The only job error is the three failed selections above;
there are no compiler warnings. Keep this failure when the repair passes.
