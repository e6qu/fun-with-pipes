# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and
borrowing, and reserve ARC for necessary sharing. JIT is excluded.

## Current delivery and preparation

[PR #202](https://github.com/e6qu/fun-with-pipes/pull/202) is the only open PR,
at `46c26002b5f748529a2c6ad5977891cdc1593c06`. Production run `39981747930`
is running; docs `39981747884` and benchmarks pass. Audit all final jobs and
inspect 569 images on each of six hosts before merging. Do not alter that
passing head merely to add this next preparation.

**Next:** complete the four-group task ownership preparation, then run its
42-group focused suite on Linux AMD64 and both Windows architectures. Audit
all failures together. Prepare one delivery on the verified #202 squash after
its acceptance; do not open a second PR while #202 is active.

This worktree is `/private/tmp/fwp-task-handle-cleanup`, branch
`task-handle-cleanup-preparation`, based on callback preparation
`0c182d8b1aab3058f904511250b9f08f1692d200`. Its preserved tag is
`roadmap/preparation-task-cleanup-0c182d8b1aab`; the 41-group runs are Linux
`39984203331`, Windows AMD64 `39984208216` and Windows ARM64 `39984212932`.
They remain required evidence for that source, not this handle extension.

The four groups cover retained callbacks, deadlines, scopes and task handles.
Shared-owner probes repeat 32 rounds; sole-scheduler tasks repeat 64 rounds of
three completion/cancellation cases. ARC byte balances and deliberately missing
cleanup detect retention without collection. The evidence collector now requires
explicit ARC/tracing unique-task artifacts. Compiler/runtime are unchanged.
[The guide](measurements/record-cleanup.md#task-callbacks-and-cancellation) explains
examples and limits. Expected inspection: 711 images per host, including
142 callback/task outcomes; focused checks do not replace final gates.

## Checks and failures

Local ARM64 checks compare complete native programs with the raw interpreter,
execute missing-cleanup controls and inspect generated machine code. Retained
completion, failed creation, deadlines and scopes pass 78 outcomes. The handle extension adds 64 passing outcomes
(29.64s guarded); all saved ARM64 images are inspected. A new retained-probe variable
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

The task-callback and task-handle mutation helpers COMPLETED; do not rerun them. Original tests
are `/private/tmp/fwp-*_thunk_ownership-before.rs`. Local checks use
`/private/tmp/fwp-check-task-callbacks.py` and `fwp-check-task-handles.py`;
receipts live in `/private/tmp/fwp-task-callback-*` and `fwp-task-handle-current`.
`/private/tmp/fwp-task-preparation.json` records the published 41-group parent.
Its audit/inspection helpers cover 647 images, not this 711-image extension. The compiler is the accepted `5e17fc10` binary,
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
