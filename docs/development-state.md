# Current work

**Next:** finish checking and publish the frozen temporary-record requirements on
`derivative-temporary-storage`, then implement that selection. Keep monitoring
[PR #247](https://github.com/e6qu/fun-with-pipes/pull/247); squash merge only after
all nine exact-head production jobs and documentation pass and logs are audited.

## Branch and delivery

- Worktree `/private/tmp/fwp-array-consumption`, branch
  `derivative-temporary-storage`, based on PR #247 head
  `bb2e5b29fa6f53b3f187c3fba3fd15d38ff4085b`. Primary checkout untouched.
- PR branch `array-observation-diagnostics` remains unchanged at that head.
  Production run `41497408964` is in progress. Benchmark job `125455860614`
  and documentation `41497408857` pass; their complete logs are audited.
  Keep one active PR.
- Full documentation log `/private/tmp/fwp-247-final-docs.log` is audited:
  73 Python test groups / 465 tests, 213 link sets, 106 immutable pairs/tags and
  five plan steps. Deliberate runner failures match their tests; no unexplained
  diagnostic. Guarded audit: 0.14s.
- Target archive auditor `/private/tmp/fwp-247-audit-targets.py` checks this exact
  head. The full-log helper is `/private/tmp/fwp-audit-full-job.py`; review every
  diagnostic it reports, including warnings in passing logs.
- [PR #246](roadmap-history.md#array-preparation-diagnostic-pr-246) is verified and
  merged as `7e48e438`, with matching tested tree and one 61-character message.
  Its duplicate same-tree main runs were cancelled. Full audits are in history;
  no unresolved production failure carried into this batch.

## PR #247: driver-comparison evidence

- Frozen [protocol](measurements/array-observation-boundaries.md): `c583459b`, tag
  `roadmap/array-observation-protocol-2026-11-02`.
- Measured source `d1f18ff74727a62cffa85506fc912597a8a3d7e6`, tag
  `roadmap/array-observation-runner-2026-11-02`. Original identities survive rebase.
- [Report](measurements/array-observations-2026-11-02/README.md): four native sessions
  and full archive audits pass; four CPU-only rejections are retained. All 96 roles
  and thirteen failed small-AMD64 copy limits remain explicit. No compiler/runtime
  change, new timing acceptance or completed-session rerun.
- Added observations alone retain the early large-AMD64 pattern. The complete
  zero-preparation driver changes it but increases total timed work 7.7–9.8%.
  ARM64 consumption becomes 4.5–5.4% slower. Close this diagnostic without hidden
  preparation or a speculative ownership change; keep original timing goals open.

| Session | Run / job | Artifact | Full local audit |
|---|---|---|---|
| ARM64 1 | `41483622413` / `125408109437` | `13160584315` | Pass, 4.51s |
| ARM64 2 | `41483622413` / `125408109314` | `13162246109` | Pass, 4.56s |
| AMD64 1 | `41483622413` / `125408109605` | `13162735018` | Pass, 4.63s |
| AMD64 2 | `41487610457` / `125421960114` | `13163836448` | Pass, 4.82s |

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Frozen three-driver boundaries and exact source reconstruction |
| 2 | Verified | Native numerical, ownership, omitted-destruction and failed-clock controls |
| 3 | Verified | Four complete archives audited; every host rejection preserved |
| 4 | Verified | Complete 96-role report preserves timing limits and failures |
| 5 | In progress | PR #247 documentation passes; nine production jobs and merge remain |

## Next batch: temporary derivative records

[Baseline and candidate requirements](measurements/derivative-temporary-storage-2026-11-02/README.md)
retain counts, current C, logs and artifact identities. Both native jobs in
`41497441785` pass at `bb2e5b29`: AMD64 `125455981525`, ARM64 `125455982054`.
Full logs/digests pass (0.14s); independent archive replay covers all 96 observations
(4.10s), which agree across architectures (0.13s). Full archives remain at
`/private/tmp/fwp-current-derivative-{arm64,amd64}.zip`.

The largest solve still creates 25,472 pair-result records and 199 final fold
records. Replace the temporary mapped list only after proving its sole consumer;
keep all mapping before summation and preserve seed evaluation and caller cleanup.
The existing observer includes scratch allocations through `fwp_mem_alloc`.
No compiler change has been made for this candidate.

The callback-box auditor now requires an explicit accumulator layout. Current
counts pass (0.27s). The old #239 report reproduces exactly; both wrong layouts
and an omitted pair-result count are rejected (0.38s). All 214 document link sets, 106 immutable pairs/tags and five plan steps pass
(3.02s). Publish the preparation commit/tag before compiler edits. Source-review notes and the
one-off current summary helper remain `/private/tmp/fwp-derivative-storage-notes.md`
and `/private/tmp/fwp-current-derivative-summary.py`.

The ARM64 macOS ownership job `125455860392` was cancelled without a runner
or executed step. GitHub reports hosted-runner capacity exhaustion; annotations
are saved in `/private/tmp/fwp-247-macos-arm-ownership-cancellation.json`. A targeted
retry was refused with HTTP 403 because the parent workflow is still running.
Retry only that job when the run completes; do not restart successful jobs or
count this cancelled job as a native pass. Benchmark full-log audit: two passing
Rust summaries, no diagnostics (0.14s).

## Resources and merge rules

No local build, full suite or benchmark. Use the guard serially and preserve
64 GiB free. Completed #243/#244/#245 checkouts were removed after tree verification;
#245's uncommitted handoff/patch are saved in
`/private/tmp/fwp-245-worktree-handoff-preserved`. Commits and evidence remain.

Merge only after final-head gates and audits pass, with one subject of at most
80 characters and an empty body, no trailers/attribution. Verify tree and raw
message, cancel only verified duplicate same-tree main checks, and continue PLAN.md.
