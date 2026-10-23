# Session handoff

All seven PLAN.md areas remain open. Prefer ownership and borrowing, reserve ARC
for necessary sharing and remove tracing. JIT is excluded.

## Current work

**Next:** publish and audit the expanded focused ownership preparation on Linux
AMD64 and native Windows ARM64/AMD64, including all completed test targets and
853 saved images per host. Keep one active PR: #202 is the current final delivery.
It needs nine production jobs, documentation and six-host binary inspection before
squash merge. The live primary handoff records its latest status.

This worktree is `/private/tmp/fwp-runtime-call-cleanup`, branch
`runtime-call-cleanup-preparation`, based on
`67415f551edc05cd6602a3ee1a55b32d66f815f9` (state/deadline preparation).
That parent is preserved under `roadmap/preparation-state-cleanup-67415f551edc`;
its focused runs are `39993997300`, `39994002186`, `39994007156`.
The earlier task/callback source `8ad428aae8c759c1a0bb7650a9305d6d7a0b6c80`
passed all three focused runs and 711-image inspection on each host. It is ready
for delivery after #202. Do not postpone accepted work solely for this separate
preparation; combine related groups when their checks are ready.

## Changes and verification

Five runtime-call tests now exercise explicit ARC and tracing: 10,000 failed
calls; 32-round capture aliases, pending arguments, primitive traps and cancelled
entries; native/interpreter comparisons; and deliberate missing-owner controls.
They add 58 saved outcomes to the prior state/deadline and task/callback groups,
for 853 images per host. Compiler/runtime and syntax are unchanged.
[The guide](measurements/record-cleanup.md#calls-chosen-while-a-program-runs)
explains the source example, internal call behavior and precise measurements.

All 58 local Apple Clang ARM64 observations pass, including actual binary
inspection. Guarded checks took 5.75s (failed), 9.35s (captures), 7.59s (pending
arguments), 4.99s (primitive traps), and 2.93s (cancellation). Their receipts are
`/private/tmp/fwp-runtime-call-{failed,captures,overapply,primitive,cancelled}/results.json`.
They use accepted compiler `5e17fc10e860b1971ffc9cd9cb57fcb795ccad24`, with
unchanged compiler/runtime/library sources. GCC, Windows and the Rust harness
remain pending. Local results do not establish final native support.
The documentation example initially used a function-valued pipe that inferred
composition; it now uses explicit `apply 3 (choose True)`. The failed source is
preserved in `/private/tmp/fwp-runtime-doc-example-failed.fwp`.

The parent state/deadline preparation passed 84 local observations. Its fixture
repair explicitly frees a final string; an omitted-string control detects the
old retained charge. Failed evidence remains in `fwp-deadline-current`, repaired
evidence in `fwp-deadline-v2`; state receipts are in `fwp-state-probe` and
`fwp-state-source`. These are cleanup checks, not timing or process-memory claims.

Use `python3 scripts/local-guard.py COMMAND...` serially, preserving all local
resource limits. Full builds/suites stay on GitHub. Keep exact source tags,
inspection reports and failed-control evidence. Do not rerun completed mutation
or publication helpers; inspect receipts before resuming.

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
