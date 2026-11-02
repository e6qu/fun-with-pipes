# Current work

**Next:** finish and audit PR #242 at `f411df1f402c0f51f3fab8276edd43661f738299`,
then squash-merge with the authorized one-line subject and empty body. Production
run `41399968432` has benchmark and both macOS ARM jobs passing; six platform jobs running; docs
`41399968400` passes. No final-head failures are reported. The full prior handoff
is retained at `f411df1f:docs/development-state.md`.

This independent preparation branch is `current-kernel-costs`, worktree
`/private/tmp/fwp-current-kernel-costs`, based on that exact #242 head. Do not open
a second PR or change #242 while its remaining gates run. After its squash merge,
rebase only this branch's new commits onto the verified merge tree.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | In progress | Published protocol `818731e3` and retained tag; #242 final matrix still running |
| 2 | Implemented | Paired preparation, runner, raw-evidence audit and workflow; focused local controls pass, published runner `b9da15a1`; execution and full evidence audit pending |
| 3 | In progress | Run `41404044761` at `b9da15a1`: two sessions per architecture dispatched; keep every failed host/control |
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
passes that step on Intel. Linux AMD job `125104481395` now passes; its full log and all 257 target logs are clean. The prior run is fully audited.
Prior docs reference mismatch is repaired and final docs passes. No unresolved
compiler/runtime failure is currently known.

Final-head logs already audited: `/private/tmp/fwp-242-final-bench.log` and
`/private/tmp/fwp-242-repaired-docs.log`. Other logs and all earlier source IDs are
listed in the prior handoff. Full suites and benchmarks remain on GitHub; use
`python3 scripts/local-guard.py` for focused checks only.

## Next-batch focused checks

Preparation `818731e3`, tag `roadmap/current-kernel-costs-protocol-2026-11-02`,
precedes the new runner. The schedule control caught fixed-position bias before
any measurements; the documented `(round + block) % 6` correction passes all
positions without changing counts or timing limits. No production compiler change.

Guarded local checks: three exact-reference tests (0.13s), seven scheduling/decision
controls (0.13s), eight corrupted-evidence controls (4.05s), actionlint (5.42s).
The workflow builds both compilers from Rust with production O1/assertion settings,
checks reference failure/cancellation in session 1, then measures both sessions.
Host qualification occurs before building or timing. Run `41404044761` is dispatched; no result is accepted yet.

Final #242 macOS ARM logs: `/private/tmp/fwp-242-f411-mac-arm-{regular,ownership}.log`,
with corresponding `-tests.zip` archives. All 131 regular and 126 ownership targets
pass. Brew's already-installed message is informational; no compiler warning.
Preceding Linux AMD: `/private/tmp/fwp-242-linux-amd-final.log` and
`/private/tmp/fwp-242-linux-amd-tests.zip`. Preserve #242 head `f411df1f`.

## Reference check repair in progress

Run `41404044761`, ARM session 1 job `125141953749`, fails two **layout assertions**:
`loop_preparation_ownership` and `nested_loop_boxing` demand `double v3`, while the
word-state reference deliberately emits `V v3`. All four numeric-array tests and
both loop-unwind tests pass; the complete log has no other failures or warnings.
Fix the isolated reference preparation to replace only those two expected type
strings, retaining every real alias/fault/cleanup and broken-observer check.
Production Rust tests and compiler sources stay unchanged. Reference source/test
patches and hashes are retained; four focused preparation controls pass (0.13s).

ARM session 2 job `125141953515` is measuring unchanged kernel programs. Preserve
its result: the repair changes test expectations, not compiler/runtime/library
source or timed work. Rerun session 1 after the repair because it never timed.
The initial AMD sessions and three replacements rejected wrong CPUs before any
build/execution; logs and qualification ZIPs are `/private/tmp/fwp-current-kernels-
rejected-JOB.{log,zip}` for jobs `125141953680`, `125141953814`, `125142541094`,
`125143340035`, `125143340076`. Runs: `41404044761`, `41404234063`, `41404489679`.
Replacement run `41405063750`: AMD session 2 job `125145128971` qualified and builds; session 1 job `125145128805` rejected before execution. Preserve the running second sessions. Only first sessions need dispatch after this test repair.

Final repair controls: four preparation tests (0.13s), ten evidence controls
(4.28s), including literal-only historical test-patch validation. No benchmark
program, compiler source, workload, timing boundary or acceptance limit changed.
