# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and
borrowing, and reserve ARC for necessary sharing. JIT is excluded.

## Current delivery and preparation

[PR #202](https://github.com/e6qu/fun-with-pipes/pull/202) is the only open PR,
at `46c26002b5f748529a2c6ad5977891cdc1593c06`. Production run `39981747930`
is running; docs `39981747884` and benchmarks pass. Audit all final jobs and
inspect 569 images on each of six hosts before merging. Do not alter that
passing head merely to add this next preparation.

**Next:** validate this grouped task-callback preparation, publish an immutable
preparation tag and run the 41-group focused suite on Linux AMD64 and both
Windows architectures. Fix every failure before one batched push. Keep one PR;
prepare the next delivery on the verified #202 squash only after its acceptance.

This worktree is `/private/tmp/fwp-task-callback-cleanup`, branch
`task-callback-cleanup-preparation`, based on the published #202 head. Three test
groups cover retained callbacks, deadlines and scopes: 32 rounds of completion,
cancellation, failed creation and exact cleanup, plus deliberate breakages.
Fixtures explicitly own raw injected tasks and durations; ARC rejects missing
callback ownership metadata. Compiler/runtime and language semantics are unchanged.
[The guide](measurements/record-cleanup.md#task-callbacks-and-cancellation) explains
an example, observations and limitations. Expected inspection: 647 images per
host, including 78 callback outcomes; focused checks do not replace final gates.

## Checks and failures

Local ARM64 checks compare complete native programs with the raw interpreter,
execute missing-cleanup controls and inspect generated machine code. Retained
completion, failed creation, deadlines and scopes pass all 78 outcomes,
including four added byte-balance controls. A new retained-probe variable
was declared inside the repeated loop but used afterward. Its declaration was
corrected and the affected checks pass. Preserve the failed compile output;
this was a fixture error, not a production runtime defect.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused work. Full
suites stay on GitHub; keep every CPU, memory, disk and deadline limit.

## Resume records

`/private/tmp/fwp-call-publication.json` identifies PR #202 and its runs.
`/private/tmp/fwp-audit-call-final.py` audits all final jobs and full logs.
`/private/tmp/fwp-inspect-call-delivery-builds.py` expects 569 images per host.
`/private/tmp/fwp-merge-call.py` requires all exact-source gates and inspections.
Do not use expanded preparation counts to accept the earlier delivery.

The task-callback mutation helpers COMPLETED; do not rerun them. Original tests
are `/private/tmp/fwp-*_thunk_ownership-before.rs`. Local checks use
`/private/tmp/fwp-check-task-callbacks.py`; receipts live in
`/private/tmp/fwp-task-callback-*`. The compiler is the accepted `5e17fc10` binary,
with current compiler/runtime identity verified before each focused invocation.

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
