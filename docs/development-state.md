# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for needed sharing. JIT is excluded.

## Accepted delivery and current work

[PR #203](https://github.com/e6qu/fun-with-pipes/pull/203) passed all nine
production jobs, docs and 5,118 binary inspections at `460e847b34a7b2691b69f89a4dfea84ea25950b7`.
Verified squash: `3e3ebd2717f4d77c8d8331e7df1936768546d1ed`. [History](roadmap-history.md#tasks-state-and-runtime-call-cleanup-pr-203)
and the [inspection record](measurements/task-cleanup-2026-10-23.json) retain evidence.

**Next:** finish this combined derivative/array delivery. Audit every final-head
production job and docs; inspect 1,161 saved images on each of six native hosts.
Only then squash merge with one subject of at most eighty characters and an
explicit empty body. Continue PLAN.md after the verified merge.

Worktree `/private/tmp/fwp-derivative-array-delivery`, branch
`derivative-array-cleanup-delivery`, is based on that verified merge. Native code,
tests, scripts and workflows exactly match `9e9662f93aa5e1f0ebd86b6a31d9396dffe13215` in
`/private/tmp/fwp-derivative-growth`. Its focused runs `40010961711`,
`40010966471` and
`40010970526` passed full log audits and
1,161-image inspection per host. The focused selection has 50 groups; Linux-only
storage tests are not Windows support.

## Scope and checks

Six groups verify detached derivative buffers, callback scopes, borrowed calls,
array values, buffer-growth failures and workspace cleanup. Repeated work checks
managed storage balances alongside raw numeric-buffer frees. Missing cleanup,
invalid scalar counts and stale tape
handles must fail. Alias/effect programs compare with raw interpretation; a
10,000-iteration array program checks exact ARC reclamation. The guide introduces
concepts before examples and distinguishes raw buffers, managed charges and speed.

All 308 new local ARM64 outcomes pass, including 116 growth/workspace checks.
Fourteen runner controls, formatting, docs/examples and inspection manifests pass.
The new derivative fixture's missing
scope and misplaced IO were repaired. Its mutable scope survives `longjmp` through
static storage. Fixture arrays, lists and optional results are released explicitly.
Windows output setup reports failure. No production runtime or language changes.
The first combined focused run failed Rust compilation on all three hosts because
the array test omitted its artifact helper declaration. All failure logs were
audited; the declaration and affected callers were checked before the passing
rerun. Saved C execution alone does not verify the Rust harness.

## Resume records

`/private/tmp/fwp-task-merge.json` records the prior accepted delivery.
`fwp-growth-preparation.json` identifies focused sources/runs; its acceptance
receipts and `fwp-growth-ownership-evidence` preserve logs and binary reports.
Earlier derivative and array preparations retain their focused logs; separate
975- and 1,045-image inspections are not claimed. `/private/tmp/fwp-derivative-array-publication.json`
will identify this delivery. Use `fwp-audit-derivative-array-final.py`,
`fwp-inspect-derivative-array-delivery-builds.py` and
`fwp-merge-derivative-array.py` for exact-head acceptance.
Read mutation receipts before resuming; never repeat completed publication/merge.

Use `python3 scripts/local-guard.py COMMAND...` serially. Full suites and builds
stay on GitHub; preserve CPU, RSS, disk and deadline limits. Keep immutable source
tags, reports and failure evidence. Only verified duplicate archives may be pruned.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

The largest measured descent case still takes about 10–14 times the C/Rust time.
Fewer allocations alone do not establish parity. Preserve measured controls and
separate callback, indexing, output and buffer costs before selecting changes.
