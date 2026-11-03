# Current work

**Next:** publish the grouped gradient-array implementation for focused GCC/Clang
runner checks; audit all affected targets and fix every failure. Keep monitoring
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
  Owned-array results, direct array/list consumers, typed cleanup controls and
  semantic fixtures are implemented locally. The changed Rust/compiler paths
  have not yet been built; native integration and measurements remain unverified.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | #251 benchmarks/docs and both ARM64 macOS jobs pass with logs audited; six jobs run |
| 2 | In progress | Implementation and initial controls written; build and verify the complete compiler paths |
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
| macOS ARM64 regular | 125829594788 | Pass; full log and 131 target logs audited |
| macOS AMD64 regular | 125829594612 | Running tests |
| macOS ARM64 ownership | 125829594640 | Pass; full log and 126 target logs audited |
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
- `/private/tmp/fwp-audit-251-platform.py LABEL` passes for both macOS ARM64 jobs
  (0.13/0.14s); the other jobs remain pending. Labels:
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

Implementation and focused checks on the next branch:

- `src/fuse/array_zip.rs` selects one private numeric array-to-list conversion,
  optionally one eager map, and one zip. Both slots and aliases are covered;
  shared/conditional/unknown/boxed cases stay ordinary. Typed array accessors
  preserve packed values and slices. Visit-count controls cover long aliases and
  many separate producers.
- Internal backward results use owned arrays in the library, C and interpreter.
  Public list conversion follows the derivative scope. Typed result controls
  cover normal owners, shared zeros, partial-array failure and cancellation.
- The bounded Clang O1/O2 replay `/private/tmp/fwp-gradient-owners-replay.py`
  passes 20 ordinary/deliberately-broken outcomes with workspace 0/1 (5.16s).
  It transplants the changed runtime routine into verified #250 emitted C;
  this is **not** verification of the new compiler or complete library.
- Frozen primitive inventory passes: 394 declarations, 384 symbols, 40 explicit
  aliases (1.09s). `cargo fmt --all` passes (1.89s).
- `scripts/test-gradient-array-reference.py` passes three isolation/corruption
  controls (0.37s). Its frozen patch reverses all seven affected source files,
  retaining unrelated changes and the earlier range/scalar-buffer optimizations.
  Measurement source/reference identities still need freezing before timing.
- The standard-library generator was compiled standalone, regenerated its output
  and passed the unblessed comparison (0.72s); no whole compiler build.
- Both new semantic fixtures pass with the verified unoptimized interpreter.
  The complete gradient example prints seven `True` results (0.25s). Its initial
  use of the reserved name `update` was fixed to `step` before publication.
- The dedicated `gradient-array-checks` runner route checks GCC/Clang semantics,
  nested/F128 derivatives, cleanup, inventory, reference isolation and all-target
  lint. It has not been dispatched. Array-consumer fault controls and all 96
  allocation observations remain required before measurement/delivery.

Use `scripts/local-guard.py` serially: keep 64 GiB free disk, generated targets
below 2 GiB, sampled RSS below 1 GiB and 180s. Last free space about 65 GiB, no
local target data. Never bypass limits. Full validation belongs on GitHub runners.
