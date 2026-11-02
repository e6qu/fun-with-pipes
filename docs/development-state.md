# Current work

**Next:** finish and audit PR #242 at `f411df1f402c0f51f3fab8276edd43661f738299`,
then squash-merge with the authorized one-line subject and empty body. Production
run `41399968432` has benchmark success and eight platform jobs running; docs
`41399968400` passes. No final-head failures are reported. The full prior handoff
is retained at `f411df1f:docs/development-state.md`.

This independent preparation branch is `current-kernel-costs`, worktree
`/private/tmp/fwp-current-kernel-costs`, based on that exact #242 head. Do not open
a second PR or change #242 while its remaining gates run. After its squash merge,
rebase only this branch's new commits onto the verified merge tree.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | In progress | Protocol drafted; #242 final matrix still running |
| 2 | Pending | Implement paired compiler preparation and six-role evidence checks after the protocol commit |
| 3 | Pending | Two qualified sessions per architecture; keep every failed host/control |
| 4 | Pending | Publish current ratios/memory and exact-head full validation |

## Source findings

- Expanded kernel baseline `37da7441` precedes typed state `80edb379` (#227).
  The historical AMD64 array ratio around 3.3 times C is not current overhead.
- Current `src/fuse.rs` already uses proved wrapping increments for successful
  array reads. Do not repeat the rejected checked-bound experiments.
- Existing GCC reports already verify typed double accumulators on ARM64/AMD64.
  They make no speed claim. Current measurements are still needed.
- Retained #241 compiler emitted current array C under the local guard (0.25s),
  saved as `/private/tmp/fwp-next-array-kernel.c`. No local compiler build or timing.
  This source confirms native double state and cached F64 data, not a speed cause.

## CI audit carried forward

#242's prior production `41391756089`: Windows ARM/AMD, Linux ARM, both macOS ARM
jobs, Intel ownership and benchmark pass. All complete logs were audited; only
intentional TLS rejection/scheduler panic controls appear. Intel regular native
shard passes but its process-deadline control fails; repaired in `f411df1f`, which
passes that step on Intel. Linux AMD job `125104481395` still needs final audit.
Prior docs reference mismatch is repaired and final docs passes. No unresolved
compiler/runtime failure is currently known.

Final-head logs already audited: `/private/tmp/fwp-242-final-bench.log` and
`/private/tmp/fwp-242-repaired-docs.log`. Other logs and all earlier source IDs are
listed in the prior handoff. Full suites and benchmarks remain on GitHub; use
`python3 scripts/local-guard.py` for focused checks only.
