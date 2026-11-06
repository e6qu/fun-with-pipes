# Correct the runtime reference inventory audit

[Audit 42163629822](https://github.com/e6qu/fun-with-pipes/actions/runs/42163629822)
failed for both ARM64 sessions of measurement run `42162092035`. The checker
correctly validated the runtime declaration edit, but a second file-list check
still expected `source/src/cgen.rs`. This comparison stores the changed file at
`source/runtime/fwp_rt_kernel.c`. It was an audit integration bug, not a native
program failure.

The repair moves file-list validation into the complete reference validator and
gives this protocol its exact runtime path. Existing protocol inventories remain
unchanged. The reference controls now cover the valid bundle, an extra compiler
source, a substituted source path, changed body/patch and missing preserved source.
No assertion or required file was removed. Saved native measurements are re-audited;
qualified timing sessions are not repeated.

[Failed index/log summary](failed-summary.zip), [full job log](job.log.gz),
[job metadata](job.json) and [artifact identities](artifacts.json) preserve both
failures and the two previously rejected hosts. The original complete archive
remains identified there. [Corrected audit 42164603033](https://github.com/e6qu/fun-with-pipes/actions/runs/42164603033)
passes and retains the verified contents in the [runtime results](../recording-inline-time-2026-11-06/README.md).
The eight ARM64 speed-target misses remain separate from this repair.

Four focused reference tests pass locally (0.71s). Eighteen evidence-reader tests
also pass; the historical archive test needs four large sparse-checkout fixtures
and passes in [documentation run 42164607195](https://github.com/e6qu/fun-with-pipes/actions/runs/42164607195)
at repair source `66aed9ac`. No native rebuild was needed.
