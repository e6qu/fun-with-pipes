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
deliberately omitted frees. The repaired selections pass; the grouped gate is
still pending, including the fixture repairs below.

## Repair preflight

[Run 41830904200](https://github.com/e6qu/fun-with-pipes/actions/runs/41830904200),
job `126577546053`, tests `9ad9d1625751b84957a3dccfc9f8c31de197e2ab`.

- All twelve source compilations and selections pass. All three optimized
  gradient examples now select both packed helpers; controls remain unselected.
- Five scope tests and three existing packing tests pass. The new production
  generation test failed because its synthetic program omitted the recursive
  `List` type shapes required by ownership checking. Add those real shapes;
  keep the production ownership check and generated-code assertions.
- Clippy passes. The cleanup test passes all twenty ARM64 GCC images: both
  window orders, O1/O2, complete/disabled-reuse runs, missing input/output frees
  and corrupted-field controls. All image identities and statuses are audited.
- The output-comparison test passes both interpreters, then fails because
  `fwp run` does not accept `--memory`. Build explicitly with `--memory dynamic`
  at O1/O2, then execute each binary. Neither native output check passed yet.
- That failure was hidden by `cargo test | tee`: the step checked `tee`'s exit
  status. Add `set -o pipefail`. An audit found no other `tee` step in this
  workflow lacking either `pipefail` or an explicit Bash shell. The failed unit
  step kept the overall job red; a green step alone did not prove passing tests.

Keep the [complete source audit](repair-preflight/audit.json),
[native audit](repair-preflight/native-audit.json),
[full log](repair-preflight/job.log.gz),
[43-file source archive](repair-preflight/evidence.zip) and
[102-file native archive](repair-preflight/native.zip).
Source collection took 5.52s; native-image/log audit 3.30s; retention 0.13s.
The collector first rejected a mistyped source identity before accepting the
exact revision above. No benchmark has run.

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
