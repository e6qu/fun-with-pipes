# Current work

**Next:** prove why the measured local-edge call keeps two heap records, then
implement the bounded [direct numeric worker](measurements/direct-numeric-workers.md)
extension. All four first-prototype sessions are complete and audited; retain
[their five timing misses](measurements/local-derivative-time-2026-11-07/README.md).
Do not repeat unchanged timings. PR #269 remains draft pending this substantial
compiler improvement and final-head full validation.

Contract `524524bd3` precedes prototype `3f0cea6b8`. The prototype remains in
`tests/fixtures/descent_local_ad.fwp`; no public API or compiler/runtime behavior
has changed. [The experiment](measurements/local-derivatives.md) requires 20%
long-case gains, <=2% small-case regression and <=2% identical-copy variation.

[First checks](measurements/local-derivative-checks-2026-11-07/README.md), run
`42411789323`: native/interpreter semantics pass on GCC AMD64/ARM64 and Clang
ARM64. All three jobs fail only canonical fwp formatting; their identical patch
is applied. No timing jobs ran. All three full logs and artifacts were reviewed
and retained. The batch also adds a callback trap-order check, saves native
probes, verifies zero tape calls/storage and audits every saved timing observation.
All four complete local-derivative report audits now pass.

[Repaired checks](measurements/local-derivative-checks-2026-11-07/passing/README.md)
pass all three hosts, including callback trap order. All nine native probes,
generated C and full logs are retained and verified (0.20 s). The generic probe contains dynamic dispatch. The complete solve instead calls
the known edge directly, with two boxed Dual inputs per following edge. Its
407,552 excess requests equal two per edge/update/solve. No allocation-free claim.


Guarded local checks: four new measurement controls (0.12 s), 24 historical
budget controls (0.13 s), 13 historical report controls (6.68 s), Rust formatting
(0.13 s), retained semantic artifacts/Python syntax/changed links (0.13 s).
The exact 2% copy limit now compares ratios directly, avoiding subtraction
rounding that could reject the boundary. The first historical check lacked a
sparse-checkout JSON fixture; restoring the tracked fixture fixed the setup.

## Branch and sources

[PR #269](https://github.com/e6qu/fun-with-pipes/pull/269), branch
`tape-record-evidence`, worktree `.worktrees/recording-capacity-gate`.
User merged #268 at `96efba2a9d743a3109ae417f05301ab50a63019c`.
Its tree `1b3b8ea77217834de2cad5904847b3967d4e963a` equals reviewed head
`74d49922a0246fede5f579a455bdb971def5d5ab`; the squash subject is one line
without trailers. All nine production jobs `42372334679` and docs `42370758241`
pass. Full production-log audit `42388428687` passes with attempt 1,
documentation job `128398200623`, source `74d49922a0246fede5f579a455bdb971def5d5ab`.

Contract `036662872` precedes runtime implementation `b4b291e31` (#267).
Measured source `621653b6394f49dc229a2956b6b61476c82c9aac` uses the same native
sources as focused correctness. Both peers use the current compiler; only the
frozen #266 tape section differs. AMD EPYC 7763/9V74/9V45 authorization persists.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | Verified | Runtime record layout merged with nine passing production jobs. |
| 2 | Verified | Three focused native jobs and complete artifact audit pass. |
| 3 | Verified | Runtime/compiler audits pass; reports, all 48 peer/memory rows and all 32 speed misses retained. |
| 4 | In progress | Original images and carried audit verified; expanded PR still needs final-head gates. |

## Audit failure and repair

Runtime audit `42370476364`, job `128397393227`, failed in all four sessions at
`check-descent-baselines.py::check_observations`. It expected the old
`missing-parent-free` control instead of the producer's `missing-operation-free`.
The reader now takes an explicit `columns` or `records` layout and requires its
exact control set, failure code, diagnostics and image counts. All callers were
updated; older retained measurements still use `columns`.

Checks under `scripts/local-guard.py`:

- `python3 scripts/test-descent-groups.py`: 13 historical evidence tests pass
  (6.79 s), preserving their original timing failures.
- `python3 scripts/test-tape-records-reference.py`: 10 tests pass (1.26 s).
  The real AMD64 session 1 report passes; eight mutations reject renamed/missing/
  extra controls, a successful control, empty diagnostics, missing image,
  unreleased storage and the wrong declared layout.
- Original AMD64 artifact digest and saved report hash pass (0.24 s).
  Scratch extraction initially assumed an unpacked archive; the retained bundle
  is tar.xz, so the report was read directly from the original ZIP instead.
  The scratch reader needed `PYTHONPATH=scripts`; production imports are unchanged.
- Compiler audit digest and all 2,162 retained file hashes pass (0.13 s).

No production code or measured source changed. Repair `0c3b03e99` passes docs
`42389023493`. Runtime re-audit `42388963241`, job `128452299039`, passes every
original archive; no measurements were repeated. Summary artifact `13580578087`
is retained with four verified report hashes and four full job-log hashes.
The [memory/peer tables](measurements/tape-record-time-2026-11-07/README.md) and
`costs.csv` cover all 48 rows; guarded derivation passes (0.24 s).
#268's [production audit](measurements/tape-record-delivery-2026-11-07/followup-268/README.md)
is retained: ten job logs and 1,456 target/probe logs verified (0.13 s).

## Measurements and next verification

[Results](measurements/tape-record-results.md): ARM64 improves 0.71–3.58%; AMD64
ranges from 2.90% faster to 1.35% slower. All reported small/copy limits pass;
all 32 long-case speed targets remain open. Runtime producer `42369288345` has
four complete sessions. Failed-audit summary artifact: `13573108879`;
retained bundle: `13574171048`. Preserve the failure provenance.

[Compiler evidence](measurements/tape-record-analysis-2026-11-07/README.md):
producer `42369286155`, complete audit `42369871217`, artifact `13573526746`.
All fourteen comparisons pass. Full reports, logs, host/reference identities
and observation archives are retained in the repository.

Image run `42389849116` passes: jobs `128454948857` (AMD64) and
`128454949013` (ARM64). Its `tape-record-image-inputs.json` selects session 1 for each
architecture and both versions, protocol `tape-records`.
Rebuild saved C with the same GCC/flags, require byte-identical executables and
scalar append inlining in both versions. [All 48 images and complete compiler/log evidence](measurements/tape-record-images-2026-11-07/README.md)
are verified and retained (guarded hash check, 0.25 s).
No new timings were taken. The verifier's
seven controls already pass from #268.

## Carried evidence and limits

[#267 production](measurements/tape-record-delivery-2026-11-07/README.md) and
[focused cleanup checks](measurements/tape-record-checks-2026-11-06/README.md)
are verified and retained. Earlier timing misses in [PLAN.md](../PLAN.md) remain
open; a new comparison never erases an old result.

Free disk recovered to 90 GiB; minimum 64 GiB. Local checks stay guarded, serial
and bounded; full builds, suites, large audits and benchmarks stay on GitHub.
Stop on guard refusal. Remove disposable downloads only after retaining verified
evidence. Hosted slots can be busy: do not restart queued work or infer billing.

Keep one PR for repairs, retained comparisons, image checks and docs. Only squash
after nine final-head production jobs, docs and complete audits pass. Use one
commit line <=80 characters, no body/trailers/attribution; verify tree/message.
The user expanded this PR to include a meaningful performance experiment.
The [local-derivative contract](measurements/local-derivatives.md) now defines
that work; saved phase shares establish no ARC/cache cause on their own.

PR #269 is draft while the prototype is tested. Superseded full matrices
`42407505153` and `42411792736` were canceled to avoid spending runner time on
intermediate heads. No failure had been reported; canceled runs establish no
final platform support. Run the complete matrix on the finished batch.

Documentation run `42413373915` failed at two links to the moved
`PLAN.md#open-performance-goals` section. A full tracked-file search found both
references (one was absent from the sparse checkout); both now point directly
to `docs/measurements/unmet-comparisons.md`. No other completed step failed.
The prior documentation run `42411792755` passes.

All four runtime archives/report hashes and 144 peer rows are retained and
verified (guarded check, 0.25 s). Documentation repair run `42415160614` passes.
