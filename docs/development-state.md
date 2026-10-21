# Session handoff

## Next action

Next: publish the audited correction and run all six native hosts plus both
WebAssembly hosts on branch `task-channel-owners`, worktree
`/private/tmp/fwp-task-channel-owners`. Keep this combined ownership work in one
PR, then require all nine final-head production gates and documentation.

This group contains callback-owner transfer, clock fixes, captured-task proofs,
direct task messages and clearer measurement docs. The parent delivery is verified
#189 merge `030fa3374e36459d9a774379e2116ac42ed5db1d`. The separate next allocation
group remains local on `task-await-fields`; rebase it after this correction.

Read [the task-message contract](measurements/task-channels.md) and
[the callback measurements](measurements/queued-task-handles.md). Unknown task
producers and captured task-bearing queues remain rejected. Direct task messages
change the compiler proof, without new runtime representation or count operations.

## Checks and remaining work

Guarded rustfmt and `git diff --check` pass. The verified #188 compiler
`/private/tmp/fwp-check-compiler-fc138650/fwp` formats/type-checks the expanded
fixture; raw interpretation prints `task captures released`. Both new negative
examples also execute successfully under raw interpretation. These checks do not
validate the changed Rust proof or native ownership. Full builds stay on CI.

The documentation example prints `Some "ready"` under raw interpretation; the
frozen primitive inventory passes. The first roadmap check found this handoff
missing its required seven-row status table; that table is restored below.
The full preflight audit is complete for source
`5542803edd48496248c5eb547195f16f821bf3c6`, run `39659304312`. Both WebAssembly jobs
passed. Linux passed 169 compiler unit tests, all other ownership tests, four
queued gRPC checks, its 22-binary inspector and all 28 REST tests. Exactly one
new negative test expected the wrong diagnostic: a TaskResult callback makes
`Channel[Task[TaskResult]]` function-bearing, so that existing check rejects it
before the general task check. The correction requires the specific channel type
and correct ownership diagnostic for each case; no compiler rejection is relaxed.
Full logs and the failed-source receipt are preserved by
`/private/tmp/fwp-audit-task-channel-preflight.py`.

The full-matrix dispatcher stopped on that failure before publishing any tag or
starting jobs. The correction also publishes ownership batch logs before longer
transport tests, with pipefail preserving failure status. Focused native/WASM jobs
now use production's Rust O1 compiler/test profile with debug assertions and
overflow checks retained. Generated-C settings and coverage are unchanged.
Actionlint, diff and roadmap checks pass via `/private/tmp/fwp-check-task-channel-docs.py`;
recheck the corrected Rust test before publication. These scheduling changes have
no measured cycle-time result yet.
Both new negative programs pass raw interpretation and prior-compiler tracing
on macOS ARM64 O0 under GC/reuse stress. They are rejection tests, not examples of
supported ARC programs. Require the corrected full matrix before acceptance.

Separate next-group preparation now lives in `/private/tmp/fwp-task-await-fields`,
branch `task-await-fields`, based on this published source. Local commit `1da61ef1c1461fb7272eb71d9f2d83f02af95838` adds direct await
fields and matched allocation controls; the changed compiler is unverified.
Keep that preparation separate while this group's validation finishes. Private
`task.within` owner removal still needs a distinct lifetime proof.

## Preceding delivery evidence

PR #189 passed all final gates and squash-merged as
`030fa3374e36459d9a774379e2116ac42ed5db1d`, with identical tree and verified subject.
Its final head is `4dfc2be31c62c9e54271692ac8638fbb66ca786b`, production run
`39641372026`, docs `39641321443`. Audit with `/private/tmp/fwp-audit-189-final.py`
which preserves the accepted receipt and verified merge.
Rebasing onto `6e8d7aaee421a9c43891d368821783371e934906` is complete.
Preserve source `521a1600` and its immutable tag.

The preceding callback-owner source passed all six native and both WebAssembly
jobs; every full log was audited. Its source is
`521a160091040207067601ca3e57d7cc444e33f0`, focused run `39656585197`.
`/private/tmp/fwp-audit-task-owners-corrected.py` keeps its separate receipt.
All 132 native binaries and 64 task-capture WebAssembly modules were inspected.
The source-specific JSON and plain guide are ready in docs/measurements; five
creations show 10 → 5 retains with allocations/bytes unchanged. No timing claim.
Do not overwrite this source/report when extending the direct-task proof.

All seven areas in [PLAN.md](../PLAN.md) remain open. Continue substantial groups,
one delivery PR at a time, after exact-head gates pass. Every commit/merge subject
must be one line, at most 80 characters, with no body, trailers or attribution.
Use the primary workspace's `scripts/local-guard.py` for serial focused checks:
64 GiB free disk, 2 GiB target, 1 GiB aggregate sampled RSS and 180 seconds.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
