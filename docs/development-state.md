# Current work

**Next:** implement and verify the [direct scalar array callback experiment](measurements/direct-array-callbacks.md)
on branch `direct-array-callbacks`, after committing its contract. This worktree is
`.worktrees/direct-array-callbacks`; PR #252 remains the only active PR, on
`gradient-array-results`. Monitor its production run `41635110882` and docs
`41635092370` at `e2d55aa81a7830cf7379570944ed7f307c55f7af`; keep that head fixed
unless a real failure needs repair. It is ready for review, not draft.
Publish the next PR only after #252 passes and merges. All four existing runtime
sessions and raw audits are complete; keep their missed timing limits open.

## Checkout and source identities

- Active worktree: `.worktrees/gradient-array-results`, branch
  `gradient-array-results`; [PR #252](https://github.com/e6qu/fun-with-pipes/pull/252)
  is the only active PR and remains draft until the final matrix is ready.
- Scratch/evidence: `.worktrees/gradient-work`. `/private/tmp` was cleared earlier;
  keep checkpoints here. Leave the detached primary checkout's recovery edits alone.
- Contract: `c191421e`, tag `roadmap/gradient-array-protocol-2026-11-03`.
  Initial implementation: `aed66f26`, tag
  `roadmap/gradient-array-first-attempt-2026-11-03`.
- Measurements: `1f6a4ac80ed3e9e89106c27573d0c73d46bb6968`, tag
  `roadmap/gradient-array-measurement-2026-11-03`. The frozen reference reverses
  exactly seven compiler/runtime/library files; it is not an older compiler.
- Focused native prerequisite: `41626196812` at `f00fb9dc`. Later measurement and
  documentation changes leave `src`, `runtime`, `lib`, Rust tests and build inputs
  unchanged. The runner verifies those trees before measuring.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Range-storage PR #251 merged; all gates, logs and merge verified |
| 2 | Verified | Private gradient arrays pass focused checks in both engines |
| 3 | Verified | Cleanup controls, 96 allocation observations and compiler costs pass |
| 4 | In progress | Reports complete; final platform gates, full log audit and squash merge remain |

## Verified results and repaired failures

- **Storage and cleanup:** [complete report](measurements/gradient-array-storage-2026-11-03/README.md).
  Run `41626196812`: ARM64 job `125884054605`, AMD64 `125884054997`.
  Each passes 19 units, 72 integration executions, 48 allocation observations,
  16 array-map/zip controls and 72 typed probes. Every full/target log is audited;
  all 525 saved images per host have native ELF headers and verified identities.
- **Largest current-only solve:** 105,203 → 79,731 allocation requests;
  3,736,014 → 3,326,870 requested bytes. Retains 995, peak managed bytes 14,976
  and final bytes 0 are unchanged. This includes all replacement arrays.
- **First-run repairs:** old cleanup instrumentation targeted the removed list
  builder; it now targets array-slot/input-owner transfers. The F128 expected
  value allocated an extra 32-byte array; making that value explicitly compile-time
  preserves every recording budget. All failing configurations and 32 original
  target logs are retained in the storage report. The harness now collects every
  failing type/optimization/workspace combination instead of stopping early.
- **Compiler costs:** [complete report](measurements/gradient-array-analysis-2026-11-03/README.md).
  Run `41629709664`: ARM64 job `125895872041`, AMD64 `125895871607`.
  All 480 commands and raw/source/image records reconcile. Maximum candidate/reference
  ratios: elapsed 1.0001024, peak RSS 1.0017344; identical copies 1.0115275.
  All frozen compiler-cost limits pass.
- **Audit repair:** Git and Python can produce different valid patch hunks. The
  checker now verifies patch application, exact resulting bytes, file inventory
  and hashes. Six tests include the real seven-file Git patch and corruption
  controls. This changes no measured compiler, driver or acceptance limit.

## Runtime observations and delivery

[Runtime report](measurements/gradient-array-time-2026-11-03/README.md): run
`41629714632` finished three qualified sessions; raw audit `41632779445`, job
`125906293485`, passes. Replacement AMD64 session 1 `41631438916` / `125901736888`
also completes; audit `41634286259` / `125911419160` passes. All four jobs fail
only the final speed assertion; 5,336 raw-file records reconcile.
Both ARM64 sessions show about 3–4% less time for 33/129-coordinate solves;
three-coordinate repeated updates are about 1–2% slower. Both AMD64 sessions
miss every 5% target. All 32 required speed improvements remain open. Count,
cleanup, zero/one-update, copy and frame limits pass separately. Whole-process
RSS does not consistently fall: AMD64 current-only observations rise about 9%.

AMD64 session 1 rejected EPYC 9V74 in runs `41629714632` and `41630230085`, then
EPYC 9V45 in `41630692989`, all before building or timing. The final replacement
qualified on EPYC 7763.
Preserve all three rejected hosts and every measured outcome. The accepted policy
keeps verified reductions while leaving timing goals open.

Source review finds generic application in scalar `array.map`, where the earlier
buffer map called its known callback directly. This is a next experiment, not a
proven timing cause. [PLAN.md](../PLAN.md#open-performance-goals) defines its scope.

PR #251 merged as `296ec5b4c3540c6d57671d076d2a39247b2389f4` from `cea8debc`.
All nine jobs `41610112980` and docs `41610097425` pass; full/target logs, exact
merge tree and one-line message are verified in the
[delivery record](measurements/range-zip-storage-2026-11-03/platforms/final-gates.json).
Duplicate same-tree main run `41625843765` was cancelled with no failed steps.

## Local checks and limits

Guarded focused checks pass: primitive inventory/stdlib, Clang typed cleanup,
formatting, workflow lint, count/reference fault controls, compiler/timing driver
controls, evidence/group/retention checks and documentation links. Corrected
reference tests: 6 in 0.61s. Compiler-report audits: AMD64 57.85s, ARM64 49.47s;
compact runtime report/log hashes: 0.25s; all four derived reports: 0.72s.
The scratch retention helper first needed the scripts import path and a diagnostic
pattern that distinguishes the expected `AssertionError` from compiler errors;
both are repaired and the complete check passes. Final native checks run on GitHub.
Final local documentation check: 236 link sets, 106 immutable preparation pairs
and four roadmap steps pass in 2.68s; whitespace and unchanged implementation
trees also pass.

Use `python3 scripts/local-guard.py` serially. Preserve 64 GiB free, target data
below 2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline.
Last free space about 87 GiB. Never raise or bypass limits.
Squash only after all final-head gates pass: one line, ≤80 characters, empty body,
no trailers or attribution; verify the commit and tree. Continue the plan afterward.
