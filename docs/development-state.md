# Current work

**Next:** monitor and audit the remaining native gates for PR #259, then
squash merge only if every final-head gate passes. In parallel, run the prepared
next branch's focused correctness batch; no new timing measurements or second PR
before parent delivery.

## PR #259: final gates running

Head `e3a2e1d34eaa9364ff22273ed10fef7afb98204e`, branch `gradient-call-storage`,
worktree `.worktrees/owned-numeric-updates`.

- Production `41986867960`: C/Rust benchmark job `127109553431` passes; full-log
  audit passes (3.23s). All four macOS jobs, Linux ARM64 and Windows ARM64 pass; their log audits
  remain. Linux AMD64 and Windows AMD64 are running without reported failures.
- Documentation `41986867893`, job `127109552583`: passes; full-log audit passes
  (3.71s). Only the three expected negative-runner diagnostics occur.
- Preserve this exact head. Final receipts stay local until the next PR.
- Complete/target collector: `../gradient-work/collect-gradient-call-final-platforms.py`.
  Run serially through `python3 scripts/local-guard.py`, supplying
  `--run 41986867960 --source e3a2e1d34eaa9364ff22273ed10fef7afb98204e`
  `--host HOST --docs-job 127109552583`
  `--output ../gradient-work/gradient-call-final-repaired`.
  Hosts: linux-arm/linux-amd, mac-arm/mac-amd, mac-arm-ownership/mac-amd-ownership,
  windows-arm/windows-amd, bench/docs. Do not repeat already completed audits.

[Original failures and repairs](measurements/gradient-call-checks-2026-11-05/README.md)
are retained: `4160061c` failed lint/formatting across production; all job/target
logs were audited before repair. `946069cd` then failed an older comparison
patch's formatting context. Only context changed, all payload edits stayed
identical; 13 reference/budget scripts pass. That run's benchmark passed; eight
native jobs were deliberately canceled, with their partial logs retained and
no claim of final support. Three packaging failures followed cancellation before
evidence directories existed. Exact source IDs and receipts are in the linked
report. Do not rerun old native measurements.

## Roadmap status

[PLAN.md](../PLAN.md) and this table track the same five current delivery steps.

| Step | Status | Work |
|---|---|---|
| 1 | Implemented | Borrow scoped gradient inputs; focused lifetime controls and allocation counts pass. |
| 2 | Implemented | Pass fold fields directly; seed/order/precision controls and counts pass. |
| 3 | Implemented | Seed backward directly; scalar/owned-weight and failure controls pass. |
| 4 | Implemented | Consume derivative scratch; alias/view, both positions and unwind controls pass. |
| 5 | In progress | Audit all final production gates, then squash merge PR #259. |

## Next batch: grouped native checks running

Branch/worktree `packed-pair-storage`, implementation `6e02c048019642b6f6eb52c9ae6fef5fa8f2f3f7`.
Focused run `41991479079` requests suite `packed-pair-checks` and native runner
`all`: Linux AMD64/ARM64 and macOS ARM64. All three jobs pass: ARM64 `127124490103`, AMD64 `127124489898` and macOS
`127124490467`. Full-log, target and native-image audits remain.
No second PR is open; no timing started.
Sparse checkout excludes large historical
measurement folders; full native builds, suites and evidence generation stay on
runners. Contract `3b7954eef411b7b621d09718ae2aad41e72e744e`, tag
`roadmap/packed-pair-storage-protocol-2026-11-05`, precedes all implementation.
The [contract](measurements/packed-pair-storage.md) freezes the proof and limits.

- Consume the private pair input and update IR, borrow inference and escape
  analysis. Returning reused storage must not keep the old no-escape annotation.
- Equal-width storage reuses the fresh sole owner without a runtime count query;
  unequal widths allocate. Both paths protect input before possible failure and
  transfer one output owner. Logical shrink does not change physical charge.
- Expanded existing native probes cover equal/narrow output layouts, both pair
  orientations, no-reuse, partial failure/cancellation, bit patterns, aliases,
  cleanup corruption and extra allocation. No new native test target.
- Strict one-constant same-source reference keeps the consuming contract on both
  sides. Real-program selection checks include missing-marker controls.
- Focused suite `packed-pair-checks` reuses the existing three-host gradient-call
  group: all compiler units, production lint, repository/fixture formatting,
  source references and 25 relevant native targets. No full gate after each edit.

Bounded local checks pass: formatting (0.67s), fixture formatting (0.13s), all 14
collection references/budgets plus workflow syntax/diff checks (14.88s).
Reference results: `../gradient-work/packed-pair-reference-checks.json`.
Public inventory (397 declarations), native shard assignment (255 targets),
Rust formatting and Python syntax also pass (1.28s).
The matching previously verified formatter is identified by the parent report's
`production-repair/formatter-use.json`. No local compiler build/native suite.
A fresh sparse-worktree setup error was corrected before implementation or
publication; the active PR was untouched.

## Measurements and unresolved goals

Parent focused checks `41962981349` at `8c0e4b0e` pass on three hosts.
The [census](measurements/gradient-call-census-2026-11-05/README.md) preserves the
original phase-budget failure `41964853201`; corrected report-only audit
`41967470333` passes. Scratch reserves N+1 words; total savings are unchanged.
[Compiler costs](measurements/gradient-call-analysis-2026-11-05/README.md)
`41967900961` pass at `d494dd91`. [Runtime](measurements/gradient-call-time-2026-11-05/README.md)
`41967904120` retains 17 timing misses; report-only audit `41970153152` passes.
No unchanged timing reruns. All earlier goals stay separate in PLAN.md.

Fresh 129/199: 2,121 -> 727 requests; 1,265,230 -> 1,034,366 requested bytes;
398 fewer retains. Three-coordinate long solves improve 14.3–25.2%. Sixteen
larger cases miss 5%; one AMD64 zero-update case slows 2.1822%, beyond 2%.
Final managed/raw bytes are zero; process RSS is mixed. Keep verified reductions
with failed timing limits explicitly open under the accepted policy.

## Delivery and resources

Require nine exact-head production jobs plus docs, complete log audits and an
explicit squash subject <=80 characters with an empty body. Verify merge message
and tree. PR #258 merged at `68115090b161f198e11fb625946259f65f781580`;
its four AMD64 timing misses remain separate. After #259 merges, update the plan
and retain its final receipts in the next PR before new measurements.

Keep 64 GiB free, target data below 2 GiB, workload RSS below 1 GiB and the guard's
180s deadline. Remove only verified duplicate task downloads after evidence
retention. Never raise limits. Current free space is close to the reserve;
check before downloading native artifacts. Cleanup retained full audits and
observations, verified remote original artifacts, then removed 1,820.39 MiB of
old task-download copies. Receipt:
`../gradient-work/removed-verified-downloads-2026-11-05-pair-preparation.json`.
Free space afterward: 65.416 GiB. Other worktrees are unrelated.

## Runner log audit after the disk guard stopped local collection

Local free space fell again below the 64 GiB reserve after verified cleanup
(39.26 GiB at the latest check). The guard
correctly refused the macOS ARM64 ownership audit; do not bypass it. Native
builds/tests remain on runners. A new `production-log-audit` numerical-workflow
suite runs the existing full-log/target/artifact audit on GitHub instead.

Supply every input explicitly: `evidence_run=41986867960`,
`source_revision=e3a2e1d34eaa9364ff22273ed10fef7afb98204e`,
`production_attempt=1`, `documentation_job=127109552583`, and `audit_host`.
Use `all` only after all gates complete; incomplete jobs make the audit fail.
Controls reject wrong sources, failing conclusions and unexpected diagnostics.
Large Windows probe downloads stay on runners; uploaded receipts retain full
job/target logs, original artifact IDs and hashes. Local audit tests were not
run below the disk reserve; the workflow runs their controls before collection.

Runner audit request `41992495791`, job `127127789847`, source
`f545f5d30f1d698fa4c0e6293e6b2767635aad82`: explicit `mac-arm-ownership` selection
for parent run `41986867960`, attempt 1. It was canceled while still queued after an ARM64 replacement was dispatched.
Once all parent gates finish, request `audit_host=all` and require its full audit
before merge. Native parent gates are still on e3a2e1d3; focused next-batch
checks stay on 6e02c048. f545f5d3 changes only audit tooling/workflows/handoff.

The focused audit now runs on GitHub too: `focused-storage-audit`, with explicit
`evidence_run=41991479079`, `source_revision=6e02c048019642b6f6eb52c9ae6fef5fa8f2f3f7`
and `production_attempt=1`. It checks all three hosts, every target summary,
artifact source/digest and native image architecture, retaining all observations.
Audit controls run first on the runner; local checks remain paused below reserve.
Production log auditing uses ARM64 runners too; this does not replace any native
platform test. The older AMD64 audit request was canceled without starting.

Audit requests on `ed5e89867ae3b8c1ca36a3a1e7cd695228810e86`: focused
`41997987727` / job `127145820337`; production macOS ownership `41997992690` /
job `127145834232`. Both are queued. The next census implementation is being
prepared with exact repeated/fresh counts and phase attribution controls; no
measurements have started. Local controls remain unrun below the disk reserve.

Prepared `packed-pair-census` now covers repeated solves and independent fresh
O1/O2 phase observations. `packed-pair-analysis` keeps the seven compiler inputs
and 48-command schedule. New `storage-measurement-controls` runs the reference,
count, phase, timing-budget and evidence-rejection tests without a native compiler
build. These additions are not yet runner-verified; dispatch the small controls
batch first. Native measurements still require parent delivery and focused audit.
