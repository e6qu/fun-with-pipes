# Current work

**Next:** verify all nine production jobs and documentation for the delivery
PR from `scoped-lifetimes`, fix every failure, then squash-merge its exact passing head. Worktree:
`/private/tmp/fwp-scoped-lifetimes`. Squash only after those gates pass, with subject
`Verify scoped subscription lifetimes and cleanup`, empty body and no trailers.
Do not repeat A1/G1 or merge based only on local macOS checks.

## This group

[Lesson 24](tutorials/24-subscriptions/README.md) builds a streaming subscriber
from existing task/channel primitives. The task owns its callback; its queue holds
data. Finish closes/drains through the worker, then joins. Stop closes, cancels
and joins, preserving messages held by other queue owners. No new lifetime API,
weak handle or implicit cleanup policy is introduced.

`subscriptions_join_active_callbacks_and_release_each_round` in `tests/arc_tasks.rs`
checks success, callback failure, cancellation before entry and during a callback
with a child task, callback reentry, scope failure and cancellation after completion.
Eight and 64 rounds must restore their initial managed-byte balance after every
outer scope and reach zero charge after scheduler cleanup. Four omitted-release/
join mutations must fail at C O1/O2. ARC binaries are checked for absent collector
symbols; tracing stress/reuse controls retain their existing coverage.

The task documentation now states that cancellation does not erase a result
already produced. Library reference regeneration comes from `lib/task.fwp`.
[The cycle contract](ownership.md#cycle-and-retention-contract) spells out graph-ID
deletion and the unsupported C-retention case. It does not claim arbitrary C
violations can be diagnosed. Remaining tracing-only graph decisions are still
explicitly listed in [the admission matrix](ownership-admission.md).

## Checks and source

Baseline is #212's merge `eff5146e8d6d373771d18cb2f206d40bc36c6e06`, whose tree
matches tested head `dc9cf3bfb846d5a6632fbd6424cc8509b5d560cb`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40159979066)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40159979067)
passed. Duplicate postmerge production `40175968644` was cancelled;
postmerge documentation `40175968599` passed. A1 and G1 are delivered.

All local workloads use `python3 scripts/local-guard.py`:

- Verified the #212 macOS ARM64 package against its manifest: compiler SHA-256
  `7019362859a59005dabe4869f973df3d225539ce6eeea188febb4ba1f0091990`.
  Path: `/private/tmp/fwp-compiler-212/fwp-macos-arm64/fwp`.
- Formatted the two new programs; raw interpretation matches their expected output.
- Extracted the new Rust test body and built it at Rust O1 with debug/overflow
  checks. Its local-only shim supplies a temporary directory and invokes Apple
  Clang with the production C flags. O1/O2 ARC and tracing stress runs, per-round
  ledgers and all four broken cleanup controls pass. Artifacts are under
  `/private/tmp/fwp-subscription-checks-final/subscriptions`. This is not a full
  Cargo-target build and does not verify GCC or Windows.
- `cargo fmt --all` passed. Built the actual `tests/stdlib_doc.rs` standalone,
  regenerated the reference with `FWP_BLESS=1`, then passed without blessing.

- Tutorial README/source/output copies pass the exact extracted comparison test.
  Lesson 24 matches raw/optimized interpretation and native ARC at O1/O2.
- Primitive inventory passes its frozen baseline: 392 declarations, 382 symbols,
  371 contracts, 19 lowered templates and two flat scalar signatures; no review
  symbols. Report: `/private/tmp/fwp-scoped-lifetime-inventory/candidate.json`.

- Documentation audit passes: 157 link sets, 106 immutable preparation records
  and eight roadmap steps. Formatting and whitespace checks pass.

Integrated native CI remains. No full local
build, suite or benchmark was run. Required CI will compile the actual Rust target
and use production compilers on all six native hosts.

## Unresolved issue and preserved work

The intermittent Intel macOS compiler abort remains unexplained. Preserve
[its evidence](measurements/compiler-abort.md); earlier interpreter repairs and
passing reruns are not an established cure. Investigate source lifetimes on
recurrence, without restarting allocator-cookie/disassembly-led experiments.

The primary checkout remains detached at #209 with an operational handoff and an
untracked abort report; preserve it. Old #212 worktrees remain at their delivered
head. Its conditional publisher completed; do not restart it. Independent Linux
benchmark inspection passed, but a separate manual review of every final platform
artifact was not completed before user merge; see [history](roadmap-history.md).

## Roadmap status

Concrete unfinished tasks and acceptance criteria live in [PLAN.md](../PLAN.md).

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | G2–G3: finish lifetime decisions/checks; G4 replace diagnostics; G5 delete tracing |
| 2 | In progress | A2–A5: account for residual counts, remove redundant ownership work/boxes, prove count-free unique storage |
| 3 | In progress | F1–F3: cost fixtures, proved tail-frame extensions and mutual-recursion decision |
| 4 | In progress | P1–P3: checked comparisons and per-workload CPU budgets |
| 5 | In progress | D1–D3: AD recording/workspace costs and precision/nesting checks |
| 6 | In progress | N1–N2: accuracy and performance budgets for selected CPU kernels |
| 7 | In progress | B1–B2: repeated baselines and enforced evidence/budget rules |
| 8 | In progress | V1–V2: execute the finite application acceptance matrix |
