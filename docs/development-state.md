# Session handoff

All seven PLAN.md areas remain open. Prefer ownership and borrowing, reserve ARC
for needed sharing and remove tracing. JIT is excluded.

## Current work

**Next:** publish and audit the focused state/deadline preparation on Linux AMD64
and native Windows ARM64/AMD64. Check every completed target and saved image.
Keep one active PR: #202 remains the current final delivery. Merge it only after
all nine production jobs, documentation and six-host binary inspection pass.

This worktree is `/private/tmp/fwp-state-cleanup`, branch
`state-cleanup-preparation`, based on `8ad428aae8c759c1a0bb7650a9305d6d7a0b6c80`.
The parent four-group task/callback preparation passed all three focused runs:
`39985541831`, `39985545882`, `39985550071`, plus 711 image inspections per host.
It is ready for delivery after #202; this independent preparation must not delay
that accepted batch. Its parent evidence remains under the immutable tag
`roadmap/preparation-task-handles-8ad428aae8c7`.

PR #202 source is `46c26002b5f748529a2c6ad5977891cdc1593c06`, production run
`39981747930`, docs `39981747884`. Final delivery helpers and acceptance receipts
are in `/private/tmp/fwp-call-*`; the live primary handoff has its latest status.

## State/deadline changes

Two test groups add explicit ARC checks while preserving tracing controls:
32-round state replacement/unwind/task switching; 32-round deadline/channel
aliases; and complete reclamation of a 10,000-value deadline loop. Missing
retains, missing releases and extra owners must fail. [The guide](measurements/record-cleanup.md#state-deadlines-and-channel-values)
introduces the state and task concepts and states exactly what is measured.
Compiler/runtime and language syntax are unchanged.

Local Apple Clang ARM64 checks pass 44 state probe outcomes, 12 state-program
comparisons and 28 deadline/channel outcomes. They use the accepted compiler
`5e17fc10e860b1971ffc9cd9cb57fcb795ccad24`; compiler/runtime/library identity is
unchanged. Every actual binary is inspected. These do not replace native GCC,
Windows or final six-host checks. The expanded focused suite selects 44 groups
and expects 795 saved images per host.

A new fixture initially retained 32 bytes because its final string count was
lowered without destroying the value. The repaired fixture explicitly frees it,
and a control omitting that release fails. Failed and diagnostic evidence remains
in `/private/tmp/fwp-deadline-current`; passing evidence is in `fwp-deadline-v2`.
State receipts are `fwp-state-probe/results.json` and `fwp-state-source/results.json`.
Formatting-only changes after those state observations do not change their C.
No known unresolved local failure; focused Rust/Clippy and native checks remain.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused checks, keeping
all resource limits. Full builds and suites run on GitHub. Never treat skipped
Linux-only storage cases as Windows support. Preserve exact source tags, reports
and failed-control evidence; do not repeat completed mutation helpers.

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
