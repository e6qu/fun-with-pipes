# Current work

**Next:** publish the single formatting repair and updated delivery/plan records,
open one draft PR for the capacity-call group, and run `recording-capacity-checks`
on all three hosts at that repaired source. Audit all results before measurements.

Branch `recording-capacity-gate`, worktree `.worktrees/recording-capacity-gate`.
PR #263 is merged; no new PR is open yet. Keep status-only edits local during CI.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | PR #263 delivery retained; capacity contract frozen before edits. |
| 2 | In progress | Implementation/tools complete. Initial native targets pass, but formatting failed; verify the repaired source and complete artifacts. |
| 3 | Pending | Combined memory/compiler/runtime batch, then original-image and capacity-inlining verification; retain every miss. |
| 4 | Pending | Final nine-job matrix, docs, complete audits and verified squash merge. |

## Verified previous delivery

[PR #263 receipt](measurements/recording-inline-delivery-2026-11-06/README.md):
merge `53bd2d78e7a19afc5c7f697bf22ee380c4f9b2ac` exactly matches tested
`a90f793e485aa91736156ae87dfc3ae36ec9cbad`, tree
`c7bef970b64dc07dc487592a14402b8d46ccf388`. The actual message is
`Inline checked scalar derivative recording` (42 characters, no body/trailers).

All nine production jobs `42166013453` attempt 1, docs `42166011721` / job
`127722548913`, and complete audit `42175642051` / job `127753356730` pass.
The audit digest, all ten receipts and retained log hashes pass. Duplicate
postmerge runs `42176031595` and `42176031748` were cancelled after tree equality
was verified. Keep all 19 runtime misses, the inconclusive compiler-time control
and older PLAN.md limits open. Do not retime unchanged work.

## Capacity implementation and identities

[Contract](measurements/recording-capacity.md), frozen at `10b275c0` before edits:
inline the checked no-growth gate; share the unchanged allocation/recovery body.
Both F64 and typed recording retain bounds, parent checks, growth order, failure
cleanup and workspace behavior. The reference reconstructs the previous runtime
byte for byte. Boundary controls cover invalid requests before early return,
zero/exact capacity and O0/O1/O2 ordinary/inline declarations.

Initial source `4e8fbfd9411b097d54e7ea89202416f53f75a8b7` is preserved by tag
`evidence/recording-capacity-initial-2026-11-06`. Rebased head `d0f443a4` has its
identical tree `919c315f60bee2e2555228c660d04a02f4fa055f` on the verified merge.
The only subsequent test change is Rust line wrapping; runtime, compiler,
library and measurement scripts remain unchanged.

## Initial checks and repair

- [Measurement controls](measurements/recording-capacity-controls-2026-11-06/README.md):
  run `42173881295`, job `127747768088`, passes: 15 suites / 114 tests.
  Complete logs, source receipt and archive digest are verified and retained.
- [Focused run and full audit](measurements/recording-capacity-initial-2026-11-06/README.md):
  run `42173870504`; jobs `127747735095` (ARM64 GCC), `127747735400` (AMD64 GCC),
  `127747735804` (macOS Clang). Each passes 25 native targets, 864 images and
  880 observations, but fails the formatting/lint step.
- Audit `42176157617`, job `127754988370`, retains that failed status. All 8,304
  retained records pass verification. Its only findings are the three format-step
  failures; clippy, native targets and image checks pass.
- Repair: wrap `early_shortcut` in `autodiff_capacity_bounds.rs`. Local guarded
  `rustfmt --check` passes. Rerun the focused matrix before measurements; the
  failed source does not establish a passing correctness gate.

Local guarded checks pass: four complete reference/corruption tests (0.73s), six
compiler-report controls, 23 runtime-budget tests, nine phase/memory tests,
all-workload census control and historical-reference reader control. Workflow
syntax passes actionlint with shellcheck/pyflakes disabled. Two tracked fixtures
were restored for sparse-checkout tests. No local native build, full suite or
benchmark ran. About 79 GiB free at last check.

After focused checks/audit pass, dispatch `recording-capacity-census`,
`recording-capacity-analysis` and `recording-capacity-time` with explicit source,
correctness run, all hosts and both timing sessions. Preserve qualified samples;
replace only hosts rejected before building/timing. Freeze the image input plan
from audited session 1 results before `recording-call-analysis`. No speedup is
established yet. Final production/doc gates and complete audits still follow.

Scratch: `../gradient-work/capacity-*`, `/tmp/fwp-capacity-*`,
`/tmp/fwp-retain-capacity-*`, `/tmp/fwp-retain-inline-delivery.py`.
