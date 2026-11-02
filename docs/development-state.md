# Current work

**Next:** finish PR #243's documentation audit, mark it ready, then monitor its
nine final-head production gates. Keep head `ea976b7e19c26c5be0ad9e748e284cc97a269379`
unchanged. Squash-merge only after all gates pass, with an explicit one-line subject
at most 80 characters and empty body; verify the merge message and tree.

PR: https://github.com/e6qu/fun-with-pipes/pull/243
Docs run `41411731331`, job `125166069914`, is running without a failed step.
Draft production run `41411731289` is skipped; it establishes no platform support.
The published worktree is `/private/tmp/fwp-current-kernel-costs`.

This independent preparation is branch `matrix-calculation-costs`, worktree
`/private/tmp/fwp-matrix-calculation`, based on that #243 head. Do not open another
PR. Preserve measured source tags before rebasing onto #243's verified squash tree.
The previous full handoff remains at `ea976b7e:docs/development-state.md`.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | In progress | Source safety audit and explicit diagnostic protocol written; publish before runner edits |
| 2 | Pending | Reuse the GCC-report runner for current artifacts and explicit binary paths; inspect both native architectures |
| 3 | Pending | Select a source-level candidate from evidence; no speculative runtime change |
| 4 | Pending | Freeze candidate/reference before two-session timing; preserve all failed controls |
| 5 | Pending | Deliver coherent changes after #243; exact-head full matrix/docs and verified squash merge |

## Established facts

- #242 merged as `10b9bbff`, all nine production jobs and docs pass; tested tree
  and one-line 58-character message verified. Duplicate merge-tree CI/docs were
  cancelled after tree equality. No unresolved #242 failures remain.
- #243 measures source `b9da15a1` / `9f6d0f7c` (same compiler/runtime trees).
  Independent audit `41407524129` passes. Four ARM speed and nine AMD copy limits
  remain unmet; full data and logs are committed, not retried or hidden.
- The large-matrix calculation gap passes copy controls in both sessions: about
  65% more time than C on AMD64 and 6% more on ARM64. Effective retains are zero.
- Matrix records are outside that timer; task-free scheduler polling is already
  eliminated. Byte-copy alias safety, shared views, shape guards, arithmetic order
  and unwind cleanup are required. See the [protocol](measurements/matrix-calculation-costs.md).
- Scratch source audit: `/private/tmp/fwp-matrix-source-audit.md`. No local build,
  benchmark or timing has been run. Use the local guard for focused checks only.
