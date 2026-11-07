# Current work

**Next:** monitor original-image verification `42389849116` at source
`de895a714`, then retain both native jobs' image/source/stack hashes and compiler
reports. Final-head production/doc gates follow the completed batch. Do not
repeat the runtime timings.

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
| 4 | In progress | Verify measured executables, carried production audit and final-head gates. |

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

Image run `42389849116` is queued: jobs `128454948857` (AMD64) and
`128454949013` (ARM64). Its `tape-record-image-inputs.json` selects session 1 for each
architecture and both versions, protocol `tape-records`.
Rebuild saved C with the same GCC/flags, require byte-identical executables and
scalar append inlining in both versions. Take no new timings. The verifier's
seven controls already pass from #268.

## Carried evidence and limits

[#267 production](measurements/tape-record-delivery-2026-11-07/README.md) and
[focused cleanup checks](measurements/tape-record-checks-2026-11-06/README.md)
are verified and retained. Earlier timing misses in [PLAN.md](../PLAN.md) remain
open; a new comparison never erases an old result.

Free disk recovered to 68 GiB; minimum 64 GiB. Local checks stay guarded, serial
and bounded; full builds, suites, large audits and benchmarks stay on GitHub.
Stop on guard refusal. Remove disposable downloads only after retaining verified
evidence. Hosted slots can be busy: do not restart queued work or infer billing.

Keep one PR for repairs, retained comparisons, image checks and docs. Only squash
after nine final-head production jobs, docs and complete audits pass. Use one
commit line <=80 characters, no body/trailers/attribution; verify tree/message.
After delivery, follow [the next bounded investigation](measurements/tape-record-next-work.md):
compare automatic and handwritten derivatives within current fwp before selecting
another optimization. Saved phase shares locate work but establish no ARC/cache cause.
