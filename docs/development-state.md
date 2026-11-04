# Current work

**Next:** publish the batched Windows probe repair for PR #254, then monitor all
nine production jobs and documentation at the repaired head. Run `41694728758`
at `9061744b324ad5b4e7c84866ca36cfcf8597d34a` is complete: seven production jobs
and docs (`41694638618`, job `126121832983`) pass; both Windows jobs fail two
probes because their custom C entry points omitted binary-stream setup. Every
completed full/target log has been audited. The [retained failure analysis](measurements/scalar-array-identities-2026-11-03/windows-repair/README.md)
checks every failed observation; the repair preserves exact-byte assertions.
Compiler/runtime/library and all completed measurements remain unchanged. Do not
repeat timing sessions; keep the 32 missed speed targets open. Squash only after
the repaired head passes every gate, then verify the merged tree/message.

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
audits each native target. The complete report and final description are published; PR #254 is ready for
review. The earlier same-head draft CI run `41694638643` was skipped and is not
a production gate.

Full logs, target archives and audits for the completed production run are in
scratch `platforms-254`. The collector audited the remaining Linux/macOS jobs in
14.04 guarded seconds and correctly rejected both Windows failures. A separate
guarded diagnostic audit (0.13 seconds) verifies 1,600 bit-pattern rows and 32
fatal-allocation exits: only CRLF differs. The TLS rejection is an intentional
negative control, not another failed test.

Separate branch/worktree `iteration-final-value` has a completed source-inspection
run `41698313044` at `13df0962` and a frozen next-group contract at `2a257a3e`
(`roadmap/final-iteration-storage-protocol-2026-11-03`). Its uncommitted direct-last,
history-removal, count-validation and optional-wrapper cleanup changes are saved
there, formatted and inventory-checked, but not compiler-tested. Resume that
group after repairing #254; open no second delivery PR before this one merges.

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
For the Windows-only stream repair, guarded `rustfmt --check --edition 2021
tests/float_formats.rs` passes (0.13 seconds), and `python3 scripts/check-roadmap.py`
passes (2.52 seconds). The compiler/runtime/library diff from the measured source
is empty. Native verification is delegated to the full repaired-head CI matrix.

Use `python3 scripts/local-guard.py` serially: 64 GiB free disk, target data below
2 GiB, sampled RSS below 1 GiB, 180 seconds. Do not raise or bypass these limits.
Old run `38888712709` is a service-status ghost: all six jobs completed October 16;
its failures were repaired by `9bf203d7` and verified in #252. It has no active work.
