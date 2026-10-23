# Session handoff

All seven PLAN.md areas remain open. Prefer ownership and borrowing, reserve ARC
for necessary sharing and remove tracing. JIT is excluded.

## Accepted work and current delivery

[PR #202](https://github.com/e6qu/fun-with-pipes/pull/202) passed nine production
jobs, docs and 3,414 binary inspections at `46c26002b5f748529a2c6ad5977891cdc1593c06`.
Verified squash: `ff1bfcc8a294a488b9cb043622143233a903d068`. [History](roadmap-history.md#cached-values-aliases-and-failed-calls-pr-202)
and the [inspection record](measurements/call-cleanup-2026-10-23.json) retain evidence.

**Next:** finish this grouped task ownership delivery. Audit every final-head
production job and documentation; inspect 853 saved images on each of six native
hosts. Only then squash merge with one subject of at most eighty characters and
an explicit empty body. Continue PLAN.md afterward.

Worktree `/private/tmp/fwp-task-delivery`, branch `task-cleanup-delivery`, is based
on that verified merge. Native code, tests, scripts and workflows exactly match
preparation `a447d6a7e99887be5f02506669bc3b499de298f5` in `/private/tmp/fwp-runtime-call-cleanup`.
Its Linux run `39996376457` and both Windows runs
`39996381026` / `39996385840`
passed focused checks, full log audits and 853 saved images per host. The Linux
suite selects 45 groups; Linux-only storage tests do not establish Windows support.

## Scope and checks

Seven groups cover callbacks, task handles, state, deadline/channel values and
runtime-selected calls. Shared owners repeat 32 rounds; tasks owned only by the
scheduler repeat 64 rounds of three completion/cancellation cases. Missing cleanup must fail, and ARC must reject a
counted value crossing an uncounted boundary. Fixtures now own their injected
tasks and duration records explicitly. [The guide](measurements/record-cleanup.md#task-callbacks-and-cancellation)
explains examples and exact observations. No compiler/runtime or syntax change;
these are storage-cleanup checks, not speed or complete-GC-removal claims.

All 284 local ARM64 observations pass, including native/interpreter comparisons
and actual binary inspection. Fourteen runner controls, formatting, docs/examples
and artifact-consumer checks pass. A variable-scope mistake and a missing final
fixture release were fixed; failed and repaired evidence remain preserved.
The guide states the shared test protocol once and introduces notation before
each example, retaining controls and measurement limits. A function-valued
pipe example was corrected to an explicit `apply` call and executed successfully.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused checks. Full
suites stay on GitHub. Preserve every local resource limit.

## Resume records

`/private/tmp/fwp-call-merge.json` records the prior verified merge.
`/private/tmp/fwp-runtime-preparation.json` identifies the focused source/runs.
Its `fwp-runtime-focused*acceptance.json` receipts retain complete log audits;
853-image reports are in `fwp-runtime-ownership-evidence`.
`/private/tmp/fwp-task-publication.json` will identify this delivery.
`fwp-audit-task-final.py`, `fwp-inspect-expanded-task-delivery-builds.py` and
`fwp-expanded-merge-task.py` require final-source acceptance before merge.
Preparation mutation helpers completed. Read the publication receipt before
resuming publication; never repeat a completed mutation.
The Windows AMD64 artifact transfer reset during download. An automatic download
in the inspector overwrote its partial transfer; both failed files are preserved.
Inspectors now require an explicit digest-verified download, and the recovered
archive passed all 853 inspections. No CI rerun was needed.
Keep immutable tags and source/binary inspection reports. Older callback-only
helpers expect 647 images; they must not accept this expanded 853-image delivery.

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
