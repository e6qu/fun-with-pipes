# Session handoff

## Next action

This is isolated preparation on `task-channel-owners` at
`/private/tmp/fwp-task-channel-owners`, based on `521a1600` from
`queued-task-captures`. PR #189 is merged. Group this proof extension with the preceding callback-owner
work in one next PR after validation. The primary
workspace and `/private/tmp/fwp-queued-task-captures` keep those live handoffs.

Read [the candidate contract](measurements/task-channels.md). The working tree
removes the blanket Task-message ban and proves known task computations/results
instead. Captured task-bearing queues stay rejected. Unknown queues that may own
a task/callback remain distinct from unknown data-only queues; only checked types
can narrow that distinction. External task-bearing queues trigger proof even when
no task is spawned locally. No runtime representation or reference counts change.

## Checks and remaining work

Guarded rustfmt and `git diff --check` pass. The verified #188 compiler
`/private/tmp/fwp-check-compiler-fc138650/fwp` formats/type-checks the expanded
fixture; raw interpretation prints `task captures released`. Both new negative
examples also execute successfully under raw interpretation. These checks do not
validate the changed Rust proof or native ownership. Full builds stay on CI.

The documentation example prints `Some "ready"` under raw interpretation; the
frozen primitive inventory passes. The first roadmap check found this handoff
missing its required seven-row status table; that table is restored below.
Next: finish reviewing proof entry points and unknown origins, then publish a compiler/unit and focused Linux preflight with both
WebAssembly hosts. Audit all failures before a correction. Extend to all six native
hosts and inspect actual artifacts before delivery. The existing repeated fixture
and physical-owner failure controls now cover direct task handles and task fields.
Do not treat the preceding source's measurements as acceptance of this branch.

Related future investigation: `/private/tmp/fwp-next-task-queue-proof.md` records
where immediate task-await results could avoid temporary Option boxes and why
private task ownership needs a separate lifetime proof. Neither optimization is
implemented. Keep changes grouped when their validation can share one delivery.

## Preceding delivery evidence

PR #189 passed all final gates and squash-merged as
`030fa3374e36459d9a774379e2116ac42ed5db1d`, with identical tree and verified subject.
Its final head is `4dfc2be31c62c9e54271692ac8638fbb66ca786b`, production run
`39641372026`, docs `39641321443`. Audit with `/private/tmp/fwp-audit-189-final.py`
which preserves the accepted receipt and verified merge.
Rebase this branch onto `6e8d7aaee421a9c43891d368821783371e934906` after committing
its changes, using old base `521a1600`; the preceding branch has already been
rebased onto the merge. Preserve source `521a1600` and its immutable tag.

The preceding callback-owner source is
`521a160091040207067601ca3e57d7cc444e33f0`, focused run `39656585197`.
`/private/tmp/fwp-audit-task-owners-corrected.py` keeps its separate receipt.
Do not overwrite its source/report when rebasing or extending this preparation.

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
