# Current work

**Next:** implement the frozen gradient-array contract: internal owned-array
results and direct numeric array/map/zip consumption together. Keep monitoring
PR #251; audit each failed step and completed target. Merge it only after all
nine exact-head production jobs plus docs pass, using one subject ≤80 characters
and an empty body. Verify the message/tree before publishing the next PR.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `gradient-array-results`;
  primary checkout untouched. This next branch has no PR yet. It starts at
  `cea8debcd8caf067bf210fd612c559b265157b91`, the unchanged final head of
  [PR #251](https://github.com/e6qu/fun-with-pipes/pull/251).
- Branch `scalar-buffer-performance` and tag
  `roadmap/range-zip-final-checks-2026-11-03` preserve that CI head. Do not push new
  work there while its gates run. After its squash merge, rebase only the next
  branch's commits onto the verified merge; keep one open PR.
- [Next contract](measurements/gradient-array-storage.md) is retained by
  `roadmap/gradient-array-protocol-2026-11-03` before implementation edits.
  No compiler/runtime/library edits have been made on this branch yet.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | #251 benchmarks/docs pass and full logs are audited; eight platform jobs run |
| 2 | Pending | Implement owned-array derivative results and the sole-use array consumer |
| 3 | Pending | Isolated whole-change reference, focused semantics/cleanup, scaling and exact counts |
| 4 | Pending | Compiler/runtime measurements, independent audits, final platform matrix and delivery |

## PR #251 final gates

Production run `41610112980` tests `cea8debc`; all nine jobs exist. The draft-push
run `41610097600` skipped by design; the ready-for-review run is the required one.

| Gate | Job | Last observed result |
|---|---:|---|
| Benchmarks | 125829594182 | Pass; full log audited |
| Linux ARM64 | 125829594542 | Running tests |
| Linux AMD64 | 125829594545 | Running tests |
| macOS ARM64 regular | 125829594788 | Running tests |
| macOS AMD64 regular | 125829594612 | Running tests |
| macOS ARM64 ownership | 125829594640 | Running tests |
| macOS AMD64 ownership | 125829594596 | Running tests |
| Windows ARM64 | 125829594942 | Running native resource/ownership checks |
| Windows AMD64 | 125829594720 | Running native resource/ownership checks |
| Documentation | 125829540129 | Pass in run 41610097425; full log audited |

No failed production steps observed. Requery actual state; this table is a snapshot.
Docs contain only three intentional runner-failure diagnostics. Benchmark checks
include 21 native binaries, 14 ARC images, 21 RSS distributions, seven leak
controls and 32 sort-storage images/comparisons. Guarded log audits pass in
0.13/0.14s. Evidence is in `/private/tmp/fwp-251-platforms`.

Prepared audit helpers:

- `/private/tmp/fwp-audit-251-docs.py` and `fwp-audit-251-bench.py` already pass.
- `/private/tmp/fwp-audit-251-platform.py LABEL` is prepared, not yet run. Labels:
  `linux-arm`, `linux-amd`, `mac-arm`, `mac-amd`, `mac-arm-ownership`,
  `mac-amd-ownership`, `windows-arm`, `windows-amd`.
  Supply completed downloads `/private/tmp/fwp-251-production-LABEL.log` and
  `...-LABEL-targets.zip`, plus current `...-jobs.json` / `...-artifacts.json`.
  It checks source, archive digest, all target/full logs and the exact previously
  inspected Homebrew notice. Review any unexpected diagnostic instead of hiding it.
- Wait for each download's exit 0 before reading its file. Full logs:
  `gh api repos/e6qu/fun-with-pipes/actions/jobs/JOB/logs --allow-escape-sequences`.
  Keep current-head gate records for the next PR; do not restart CI for status edits.

## Completed range evidence

[Native checks and allocation savings](measurements/range-zip-storage-2026-11-03/README.md),
[compiler costs](measurements/range-zip-analysis-2026-11-03/README.md) and
[all runtime sessions](measurements/range-zip-time-2026-11-03/README.md) are complete.
Measurement source `3be9479c4150d7aae5695d7f7aa4ce3f84d0f738`, tag
`roadmap/range-zip-measurement-2026-11-03`; contract tag
`roadmap/range-zip-protocol-2026-11-03` predates edits. The failed first attempt
and both repaired causes remain in the report. No measurements need rerunning.

- Both native hosts: 17 unit / 37 integration executions, 32 cleanup outcomes,
  204 image checks, 118 clean C compiler logs and all 96 count observations pass.
- Largest solve saves 25,870 requests / 823,064 requested bytes; retains stay 995;
  managed peak 17,824 → 14,976 bytes, final storage zero.
- All 480 compiler commands and four runtime sessions are independently audited.
  Compiler time/RSS limits pass; larger solves take 7.1–10.0% less time. Small-case
  timing limits remain open under the accepted retain-reductions policy.
- All 5,336 runtime file inventories reconcile. Largest reported frame growth
  112 bytes ≤128. Reported process RSS observations are separate from allocator
  counts and do not prove a whole-process memory reduction.
- #250 is fully verified: all nine production jobs in `41591834975` and docs
  `41591834978` pass at `a8a5568d`; every full/target log is audited.
  Earlier timing goals in PLAN.md remain open independently.

## Next-batch preparation and local limits

Source facts and detailed proof obligations are in
`/private/tmp/fwp-next-gradient-storage.md`; the maintained contract above selects
this batch. The bounded F64 probe `/private/tmp/fwp-gradient-array-probe.fwp`
passes optimized/unoptimized interpretation (0.26/0.25s) and C emission (0.25s).
The extracted, verified #250 compiler is `/private/tmp/fwp-range-diagnostic-compiler`.
Its emitted C still constructs the scaled list, proving that moving the scope's
result to an array alone is insufficient. This is no native ownership or speed
verification. The initial probe's unsupported semicolon was corrected to a tuple.

Latest next-batch doc check passed: 233 link sets, 106 immutable preparation
pairs and four steps (3.12s).
The roadmap-edit helper's mismatched file delimiter was corrected before running;
its guarded execution passes (0.13s). No full local build, suite or benchmark.

Use `scripts/local-guard.py` serially: keep 64 GiB free disk, generated targets
below 2 GiB, sampled RSS below 1 GiB and 180s. Last free space about 65 GiB, no
local target data. Never bypass limits. Full validation belongs on GitHub runners.
