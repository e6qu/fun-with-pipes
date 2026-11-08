# Packed inputs: selection failure and repair

Historical failures and repairs leading to
[verified #257 delivery](../packed-input-checks-2026-11-04/platforms/final-gates.json).
The chronological checks below are complete records, not instructions to repeat them.

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
deliberately omitted frees. The repaired selections passed before the grouped
gate exposed the fixture repairs below.

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

## Grouped preflight

[Run 41834093801](https://github.com/e6qu/fun-with-pipes/actions/runs/41834093801)
at `adbe92abb855dfeea5c648fb122131433a1681f3` failed on GCC ARM64/AMD64 and
Clang ARM64. Each host passed 277 compiler unit checks (four ignored), primitive
contracts, all twelve selections and 92 of 93 integration tests across fifteen
targets. Both interpreters, native O1/O2 outputs, one-field records and all eight
F32/F64 bit-preservation images pass. No compiler warnings were found.

Three causes and repairs:

- **Allocation assertion:** the native export returns a boxed `Point`. The
  observer counted two buffers and a nonempty fold's box but omitted the export
  box. Generated `f0` calls the field-return worker, then allocates that result.
  The exact total is three objects for zero/one input and four for longer input.
  Keep this boundary cost visible; add a deliberately extra allocation to prove
  the counter rejects it. Cleanup and alias requirements are unchanged.
- **Missing history:** the new job's shallow checkout omitted the frozen commits
  and tags used by five raw-evidence assertions. Fetch full history, as the
  documentation gate already does; do not weaken the source-identity checks.
- **Invalid generated names:** `scope-0` parses as subtraction, not an identifier.
  Generate `scope0` through `scope63`. Check both cost inputs even if one fails,
  saving each command's output and status. The old loop stopped before the large
  worker input, so this run did not verify it.

The corrected inputs type-check (0.47s). Saved macOS C with the corrected
assertion passes O1/O2, including all failure/cancellation loops (0.82s).
These local checks do not replace regenerated three-host validation.

[Summary](grouped-preflight/summary.json) and per-host audits retain all target
results, 630 status records and hashes for every artifact file. The audit checked
all 619 native image machine types per host. Full job/target logs and the eleven
new probe images, C sources and outputs are retained in `*-controls.zip`; artifact
metadata identifies the complete downloaded archives. Collection took 78.18s;
hash/image/log audit and retention took 3.61s. Keep this failure after repair.

### Documentation gate repair

Documentation run `41838130161`, job `126602280596`, failed at `a001184a`:
five of six gradient-array reference tests could not apply their patch to the
interpreter. The patch's context predated the two new native-only buffer bodies.
Refresh those context lines without changing the transformation being disabled;
assert both new bodies and the packed-input pass remain in the reference.
The original patch remains frozen with each historical measurement source.

All six reference tests pass after repair (0.60s), as do the six related suites
skipped after that failure (22 tests, 1.08s). [Audit](grouped-preflight/docs-audit.json)
and [full log](grouped-preflight/docs-job.log.gz) preserve the failure. This is
test infrastructure repair, not evidence of a runtime speed change.

## Retained initial evidence

- [Audit](audit.json): all twelve commands, three failed selections, test totals
  and full-log digest.
- [Source archive](evidence.zip): raw/optimized intermediate code, generated C,
  inputs, command results and 43 file hashes; every hash verified.
- [Artifact identity](artifact.json), [job metadata](job.json) and
  [complete job log](job.log.gz).

Collection completed before resumption; guarded retention/full diagnostic audit
took 0.13 seconds. The only job error is the three failed selections above;
there are no compiler warnings. The original failure remains alongside the repair.
