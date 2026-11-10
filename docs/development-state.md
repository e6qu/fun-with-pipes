# Current work

**Next: complete final-head delivery of [PR #276](https://github.com/e6qu/fun-with-pipes/pull/276).**
Publish the combined compiler/profiler changes, runtime/load reports and corrected
memory diagnostic, then require nine production jobs, documentation and the
complete-log audit on that exact head. Squash only after they pass: one subject,
at most 80 characters, empty body, no trailers. Verify equal trees and the message.

Worktree `.worktrees/service-cpu-costs`, local branch `service-cpu-costs`.
The last published PR head is `d80357c8c81d206c9d9934b141b5a5fafe97c430`.
Diagnostic branch `service-memory-diagnosis` at `94882ca7c860771ee9106211fc2567789c187070`
kept the earlier passing PR head intact while the additional investigation ran.
Do not repeat unchanged timings to obtain qualification or erase missed limits.

## Delivered implementation and measured limits

`src/cgen/resource_borrows.rs` proves when an enclosing resource owner protects an
inner parameter through initialized aliases and immutable projections. Scoped
rollback separates branches; reassigned IDs and loop/tail rebinding reject selection.
All three native result representations use it. Ordinary argument owners and
interpreter/debugger metadata remain intact. A frame disappears only when the
proof removes its last parameter and it has no bindings.

- [Ordinary service/compiler measurements](measurements/nested-resource-time-2026-11-10/README.md),
  run `42798403679` at `d80357c8c`: 31/32 service comparisons qualify and meet their
  targets, using 16–21% less time. Compiler cost qualifies in 63/64 comparisons.
  One runtime and one compiler comparison are noisy. Four ARM64 RSS limits miss 5%.
- [Counts and cleanup](measurements/nested-resource-counts-2026-11-10/README.md),
  run `42790112990` at `c49af8a6e`: 29.7–36.9% fewer large-case cleanup registrations,
  4.85–5.34% fewer actual count increments/decrements, unchanged heap requests/peak.
- [Omitted-owner control](measurements/nested-resource-lifetime-2026-11-10/README.md),
  run `42792514554` at `cd661ff84`: removing a necessary file hold exposes premature
  closure at O1/O2 on both architectures.
- [HTTP correctness](measurements/nested-resource-http-checks-2026-11-10/README.md),
  run `42793407188` at `cd661ff84`: responses, cancellation, physical cleanup,
  broken counters and real slow-client backpressure pass.
- [HTTP load](measurements/nested-resource-http-load-2026-11-10/README.md),
  run `42797169205` at `cd661ff84`: all 34 trials pass, 26,228,542 attempts without
  failures, successful shutdowns and flat sampled RSS. This is not an HTTP speedup.

Production compiler/runtime/library/input sources are unchanged from `c49af8a6e`
through the final report/diagnostic work; static diffs verify this. The ordinary
reference is `65719f7fc2277a5b97c5a790df941fea6c5eb4d7`, built from Rust source.
The separate proof observer preserves exact C on all 16 application/growth inputs.

## Memory investigation and observer repair

[Initial diagnostic](measurements/nested-resource-host-memory-2026-11-10/README.md),
run `42810648965` at `4eeb66992`: controls pass, but it used host libraries while
original measurements used a container. Preserve that limitation and its data.

[Corrected diagnostic](measurements/nested-resource-memory-2026-11-10/README.md),
run `42812351743` at `94882ca7c`: both jobs pass with the original container digest
and libc package. Each host runs all 128 original-binary executions. Five observer
controls, eleven mapping-reader tests, real omitted-touch/unmap controls, raw audits
and three altered-report controls pass. Complete logs are clean.

Candidate resident-page peaks are lower in every case. Fast RSS matches every
page walk. The original four high-water misses remain unexplained: do not call
counter error proved or substitute snapshots for their acceptance limits. No
compiler repair or relaxed gate follows from these data. `wait4` includes pre-exec
memory; an actual allocate-then-exec control verifies this. It is not fwp-only RSS.

## Production checks and retained evidence

[All pre-publication gates pass](measurements/nested-resource-prepublication-gates-2026-11-10/README.md)
at `d80357c8c`: production `42798426347`, docs `42798426476`, complete-log audit
`42810654258`. All ten reports have no issues. The small complete audit archive
passes local size/SHA/CRC verification. Later combined publication needs exact-head gates.

[CPU attribution](measurements/service-cpu-attribution-2026-11-10/README.md) passes
native replay `42781360626` and independent reconstruction. The Linux reader's
address-marker repair decodes saved recordings without resampling. Earlier failed
attempts remain recorded. CPU samples selected this proof; they are not speed ratios.

Small reports, complete logs, identities and checked readers are retained with each
measurement. Full timing and page-walk archives remain on GitHub. Local readers
reconstruct reference timing/compiler/load summaries and one raw memory snapshot
per host; full raw-data and binary audits ran on runners. Keep these scopes explicit.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load; all gates | Recorded observation limits apply |
| 6 | In progress | #275 borrowed types; application speed/memory targets; all gates | Four noisy growth comparisons |
| 7 | In progress | #276 nested lifetime borrowing, gains and memory diagnosis | Original noisy/RSS acceptance; final combined-head delivery |

Do not treat this PR or the earlier delivered code as completing every timing goal.
[PLAN.md](../PLAN.md) owns scope; measurement contracts retain original limits.

## Local checks and preservation

All checks use `python3 scripts/local-guard.py` serially. Formatting, focused Python
reader tests, changed-workflow actionlint and documentation checks pass. New observer
syntax and reader tests pass; macOS skips its three Linux process controls, which
pass on both native runners. Final `python3 scripts/check-roadmap.py` verifies
469 doc link sets, 106 preparation anchors and seven milestone statuses. The
shortened handoff initially omitted the required status column; restoring it fixes
the check. `git diff --cached --check` passes. No local full suite or build was run.

Keep 64 GiB free, generated targets below 2 GiB, sampled workload RSS below 1 GiB
and the 180-second guard deadline. Last free space: about 107 GiB. Preserve unrelated
root edits, old worktrees, stash `451bbf713d451f2d62d80fd7676839404875846a` and backup
`540b0682408d751afb6e439d58a3b887bdcba373`.
