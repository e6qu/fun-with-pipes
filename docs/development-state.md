# Session handoff

## Next action

Next: require all nine production jobs and documentation for the final head of
[PR #190](https://github.com/e6qu/fun-with-pipes/pull/190), audit every full log, then
squash merge. Keep one delivery PR. Continue through all seven open areas of
[PLAN.md](../PLAN.md) after each accepted merge.

## Current delivery

Worktree `/private/tmp/fwp-task-channel-owners`, branch `task-channel-owners`,
source `bf78c7ab8fcc052b5931165f28393450b9106d21`, immutable tag
`roadmap/revision-task-channels-bf78c7ab8fcc`. The final documentation/workflow
commit follows this measured source; the publication receipt records its head
and final production/documentation runs. Final gates must pass before merging. All six native and both WebAssembly jobs in focused run
`39666299981` passed; every complete log is audited, with no remaining failure.
Publication: `/private/tmp/fwp-task-channel-corrected-publication.json`.
Audit: `/private/tmp/fwp-audit-task-channel-corrected.py`; its separate acceptance
receipt records every completed job's full log. Early batch logs alone are not
job acceptance. Use `/private/tmp/fwp-audit-early-ownership.py` when needed.

The group transfers callbacks into tasks without redundant retains, proves queued
captured tasks/direct Task messages, rejects unproved result cycles, and checks
clock failure/range handling. Unknown producers and captured task-bearing queues
remain rejected. See [task messages](measurements/task-channels.md) and
[callback measurements](measurements/queued-task-handles.md).
The final commit records this evidence, corrects stale Task exclusions in the
reference docs, and repairs one auxiliary workflow argument-order error. Four Cargo test selections now precede the test-harness separator,
so the requested targets actually run. The running focused source is preserved.

Current-source inspection receipts are under
`/private/tmp/fwp-task-channel-evidence/bf78c7ab8fcc`; completed inspectors must not
be rerun over existing reports. Native helper:
`/private/tmp/fwp-inspect-task-channels.py --runner HOST --llvm-bin LLVM_DIR`.
WASM helper: `/private/tmp/fwp-inspect-task-channel-wasm.py --runner HOST`.
All six native and both WASM inspections are complete: 132 native binaries and
64 task-channel modules. The report is `docs/measurements/task-channels-2026-10-21.json`.

Earlier source `5542803e` failed exactly one diagnostic expectation; both WASM
jobs and all other Linux tests passed. The repaired expectation requires the
specific function-bearing queue diagnostic for a task result containing a callback.
No compiler proof was relaxed. Keep the failed-source receipt separate.

## Measurements and accepted parent

Callback source `521a160091040207067601ca3e57d7cc444e33f0` passed all eight focused
jobs in `39656585197`. All full logs, 132 native binaries and 64 task-capture WASM
modules were inspected. Five task creations use 10 → 5 retains, with allocation
requests and managed bytes unchanged. No timing or C/Rust-parity claim. The JSON
report/guide are in docs/measurements; raw evidence is under
`/private/tmp/fwp-task-owner-evidence/521a16009104`. That source predates direct
Task messages and the following await optimization.

PR #189 passed nine production jobs and docs at `4dfc2be3`, then merged as
`030fa3374e36459d9a774379e2116ac42ed5db1d` with identical tree and a verified
single-line subject. Receipt: `/private/tmp/fwp-189-final-acceptance.json`.
Redundant same-tree production jobs were cancelled before execution; post-merge
docs passed. The primary workspace stays detached at that merge, with only this
handoff dirty. Implementation belongs in the named worktrees.

## Next substantial group

Worktree `/private/tmp/fwp-task-await-fields`, branch `task-await-fields`.
Published source `bed604ef5275e6600028bd5f3892c927b6653cad`, corrected preflight
`39670240111` (Linux AMD64 and both WASM hosts). No second PR exists.
Publication: `/private/tmp/fwp-task-await-repair-publication.json`.
Audit: `/private/tmp/fwp-audit-task-await-repair.py`.

Immediate awaits can pass tag/payload fields directly instead of temporary Some
boxes; escaping options retain their representation and shared results their
required owners. The matched control restores 34 boxes. Counts and support must
be reported per source; inspect the Linux evidence before stating measured savings.
The group also separates partial captures created inside/outside State handlers
and scopes `rev.jacobian`'s output-counting pass. Regressions check escaped stateful
callbacks and repeated tape cleanup before shutdown. The ARC corpus now rejects
unexpected exclusions instead of silently counting them.

Previous preflight `39666813009`, source `82905d6b`, is fully audited: Linux passed;
both WASM hosts failed only eight ineffective missing-State controls each. This
fixture creates no State storage. The repair deliberately omits cached task-result
destruction instead. Preserve that failed-source receipt. No new Rust compiler
was built locally. Guarded formatting, frozen primitive inventory, eleven runner
unit checks, workflow/docs checks, 27 raw-interpreter derivative outputs and
library-doc generation pass. Compiler unit tests and the completed Linux ownership batch now pass at
`bed604ef`; the early batch log is fully audited. Corpus, transport and both WASM
jobs still need full audits. Early receipt:
`/private/tmp/fwp-task-await-repair-early-logs/ownership-log-ubuntu-latest.json`.

The accepted parent Linux corpus ran 75 of 86 programs, rejected eight, and checked
three compile errors. The two scope repairs address two of those rejections.
GPU, foreign-pointer and invalid cross-task AD reasons stay explicit. Evidence:
`/private/tmp/fwp-189-arc-corpus`; minimized cases/IR:
`/private/tmp/fwp-arc-corpus-isolation`. These Linux results are not all-platform
acceptance. The next group's own handoff contains its local probe details. Further prepared
repairs free leaked raw buffers in the C-interop example and require all 27 tape
cleanup observations to run. The repaired example and omitted-free control pass
raw interpretation/macOS ARM64 O0 checks with the prior verified compiler; those
additional changes still need publication and CI.

## Delivery and resource rules

Use the primary `python3 scripts/local-guard.py COMMAND...` for serial focused
checks. Preserve 64 GiB free disk, target below 2 GiB, sampled aggregate RSS below
1 GiB and the 180-second deadline. Full builds/suites/benchmarks stay on runners.
Fix every observed failure; do not weaken controls. Squash only after exact-head
nine production jobs plus docs pass, with one line ≤80 characters, empty body,
no trailers or attribution. Standing authorization applies. Continue the plan.

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
