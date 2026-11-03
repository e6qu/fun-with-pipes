# Current work

**Next:** monitor PR #254's final production run `41694728758` at `9061744b`,
audit every completed full/target log, then squash and verify its tree/message
once all nine production jobs and documentation pass. Docs and benchmarks passed
with full-log audits; the eight native jobs are running. Keep the head unchanged,
the 32 missed speed targets open, and completed timing sessions unrepeated.

**Preparation branch:** `.worktrees/iteration-final-value` / `iteration-final-value`.
While the final gates run, inspect the [final-iteration candidate](measurements/final-iteration-storage.md)
with `suite=iteration-storage-review` here. No rewrite is selected or implemented.
The runner saves real raw/optimized IR and C without timing programs. Workflow
lint passed through the guard in 6.50 seconds. Collector state for #254 is in
scratch `platforms-254`. Open no second delivery PR before #254 is merged.

The old list-iteration page now distinguishes its completed seven-sample report
from the current eight-sample reproduction schedule; it no longer claims a new
run is pending.

## Checkout and sources

- Worktree/branch: `.worktrees/scalar-array-identities` / `scalar-array-identities`.
  [PR #254](https://github.com/e6qu/fun-with-pipes/pull/254) is the only active PR.
  Scratch collectors and downloaded evidence: `.worktrees/gradient-work`.
- Base: PR #253 merged as `ed5b8830a3cb90a4b6a248464d279ac8d1d0ccc7` with all
  gates/logs verified. Its [delivery history](roadmap-history.md#direct-scalar-array-calls-pr-253)
  retains the tested source, merge-message check and duplicate-main cancellation.
  Leave the primary checkout's recovery edits and old worktrees alone.
- Frozen contract: `97c47a422a029e9913953ecba5aa6f4cb81414f4`, tag
  `roadmap/scalar-array-identities-protocol-2026-11-03`, before implementation.
- Native checks and measurements: `beddd406153f1976fed00847292207bff9053e22`, tag
  `roadmap/scalar-array-identity-measurement-2026-11-03`. Compiler/runtime/library
  and measurement tooling are unchanged since that source. Later changes add
  docs, the storage probe, distinct BF16 inputs and documentation CI repair.
- Same-type conversion preserves all bits under the stated working rule; no
  alternative instruction arrived. Cross-type behavior is unchanged. Generic
  F128 results keep independent ownership.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve the conversion rule, exact F64 selection and frozen reference |
| 2 | Verified | Keep three-host correctness/cleanup evidence; final matrix checks the expanded probes |
| 3 | Verified | Measurements/audits are complete; keep all 32 missed speed targets open |
| 4 | In progress | Publish the report; nine exact-head production jobs plus docs; audited squash |

## Verification and measurements

- [Focused native run `41672290329`](measurements/scalar-array-identities-2026-11-03/README.md):
  GCC ARM64/AMD64 and Clang ARM64 pass 50 integration tests and the selector unit.
  All full/target logs and 948 image identities are audited. Exact bits, moves,
  aliases, slices, updates, recoverable traps, cancellation and fatal OOM controls
  pass. The fault probe declares a task so actual unwind code is exercised.
- Final tests also cover the expanded result-lifetime probe and 20 distinct signed
  bit patterns per format. The frozen BF16 test had 18 because payload `0x42`
  already set its quiet bit; the repaired test uses `0x21` and rejects duplicates.
  Saved-C storage checks pass locally; their Rust-generated form needs final CI.
- [Compiler-cost run `41678571054`](measurements/scalar-array-identity-analysis-2026-11-03/README.md):
  all 480 commands and both raw audits pass. Maximum time increase 0.832%, peak
  RSS increase 0.142%, identical-copy difference 1.767%.
- [Runtime report](measurements/scalar-array-identity-time-2026-11-03/README.md):
  ARM64 sessions use `41678576958`, audited by `41682284697`; AMD64 session 1
  uses `41688990925`, audited by `41692822388`; session 2 uses `41679275708`,
  audited by `41684684676`. All 5,336 raw-file records and four complete logs
  reconcile. Six hosts were rejected before building/timing; all are retained.
- All 48 case/form/session count comparisons, with and without workspace reuse,
  remove exactly one allocation per update. The largest solve requests 206,960
  fewer bytes. ARC, managed peaks and raw storage are unchanged; cleanup reaches
  zero. No reported frame grows. Every required 5% gain is missed; noise and
  zero/one-update regression limits pass. Accepted policy keeps reductions with
  speed goals open. The slice probe separately shows prolonged backing storage.

## Documentation CI repair

[Both timeouts and the repair](measurements/scalar-array-identities-2026-11-03/documentation-repair/README.md)
are retained. Full-history fetching consumed most of the first five-minute job;
`blob:none` then caused separate historical-source fetches during checks. Fetch
small historical files together with `blob:limit=1m` and allow ten CI minutes for
setup plus validation. All checks remain, including the identity reference test.
Run `41689453129` at `24f86ddf` passes all 62 steps and full-log audit in 9m29s.
The packed-record check returned to three seconds; checkout took 5m27s. Do not
claim uniformly faster cloning. Draft production runs were skipped, not gates.

## Final delivery controls

Preserve a passing final head while remaining gates run. Repair every failure in
one batch after auditing all completed jobs/targets. Require Linux ARM64/AMD64,
regular and ownership-stress macOS ARM64/AMD64, native Windows ARM64/AMD64,
C/Rust benchmarks and documentation. `collect-final-platforms.py` in scratch takes
explicit `--run`, `--source`, `--docs-job` and `--output`; it retains full logs and
audits each native target. Mark PR ready only after the complete report is pushed.

Squash subject: `Preserve float bits and remove redundant F64 array copies`.
Supply an empty body; verify one line, at most 80 characters, no trailers or
attribution, and a merged tree equal to the tested head. Then continue with a
separately declared group from [remaining storage](measurements/remaining-gradient-storage.md).
Private packed-record consumers and general numeric-record arrays have different
lifetime obligations; neither is selected by this experiment.

## Local checks and limits

Guarded formatting, reference/budget/evidence controls, primitive inventory,
workflow lint and documentation checks pass. The latest link audit covers 247
doc sets, 106 preparation anchors and four plan steps. Compact runtime reports,
all rejected-host records and memory/count summaries reconcile. Full builds,
suites and benchmarks stayed on GitHub; no unchanged timing session was rerun.

Use `python3 scripts/local-guard.py` serially: 64 GiB free disk, target data below
2 GiB, sampled RSS below 1 GiB, 180 seconds. Do not raise or bypass these limits.
Old run `38888712709` is a service-status ghost: all six jobs completed October 16;
its failures were repaired by `9bf203d7` and verified in #252. It has no active work.
