# Current work

**Next:** publish the reference-patch audit repair, then rerun
`recording-capacity-compiler-report` against saved run `42179974129`, source
`51edfc0e7884e1a75201bc9876fd13cb8ca25eee`. Run full measurement-tool controls
on CI. Keep runtime `42179983250` running; all four qualified sessions are
measuring. Audit its saved samples with the repaired checker, without retiming.

Branch `recording-capacity-gate`, worktree `.worktrees/recording-capacity-gate`.
[PR #264](https://github.com/e6qu/fun-with-pipes/pull/264) is the only active PR,
currently draft. PR #263 is verified and merged. Keep status-only edits local during CI.

[Corrected checks and complete audit](measurements/recording-capacity-checks-2026-11-06/README.md)
pass: run `42177517863`, audit `42179352168` / job `127765102666`.
Each host passes 25 targets, 864 images and 880 observations; no diagnostics.
Artifact `13485166212` digest and all 8,304 retained records pass verification.
Corrected native jobs: `127759292851` (AMD64 GCC), `127759293082` (ARM64 GCC),
`127759293154` (macOS Clang). All three jobs pass, including formatting/lint and native checks. Docs `42177514724` / job `127759276595` pass; the complete
log has only its three deliberate runner-failure controls. Draft-only CI
`42177514756` is skipped, not native platform evidence.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | PR #263 delivery retained; capacity contract frozen before edits. |
| 2 | Verified | Corrected three-host checks and complete artifact/log audit pass; all 8,304 retained records verified. |
| 3 | In progress | Combined memory/compiler/runtime batch dispatched; original-image and capacity-inlining verification follows audited results. Retain every miss. |
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
  `rustfmt --check` passes. The corrected focused matrix and complete audit now pass; the
  original failed source remains recorded separately.

Local guarded checks pass: four complete reference/corruption tests (0.73s), six
compiler-report controls, 23 runtime-budget tests, nine phase/memory tests,
all-workload census control and historical-reference reader control. Workflow
syntax passes actionlint with shellcheck/pyflakes disabled. Two tracked fixtures
were restored for sparse-checkout tests. No local native build, full suite or
benchmark ran. About 79 GiB free at last check.

## Combined measurement batch

- Census `42179964294`: AMD64 `127767049412`, ARM64 `127767049900` pass.
  Complete-log diagnostics pass. Full audit `42181326578` / `127771398833` passes; all 4,038 retained
  record hashes pass. Allocation/work counts and maximum frames are unchanged.
- Compiler `42179974129`: AMD64 `127767078406`, ARM64 `127767078878` pass.
  Complete-log diagnostics pass. Full audit `42181226529` / `127771091070`
  failed on both architectures because Git and difflib align repeated braces
  differently. The patch reader now validates exact input/output and hunk
  counts/positions instead of one diff presentation. Numerical acceptance
  awaits the repaired audit of the original samples.
- Runtime `42179983250`: AMD64 session 2 `127767111269`, ARM64 sessions 1/2
  `127767111350` / `127767111433` qualified and are measuring. AMD64 session 1
  `127767111308` also qualified and is measuring. No timing rerun or replacement dispatched.

The batch uses explicit source and correctness run, all hosts and both timing
sessions. Preserve qualified samples; replace only hosts rejected before
building/timing. Freeze the image input plan from audited session 1 results before
`recording-call-analysis`. No speedup is established yet. Final production/doc
gates and complete audits still follow.

Local receipt verification passed all 8,304 records (0.13s); 59 links in four
updated Markdown files pass (0.13s). Complete census/compiler logs pass diagnostic
checks (0.13s each pair). No local build, full suite or benchmark ran.

Scratch: `../gradient-work/capacity-*`, `/tmp/fwp-capacity-*`,
`/tmp/fwp-retain-capacity-*`, `/tmp/fwp-retain-inline-delivery.py`.

[Audit defect and repair](measurements/recording-capacity-audit-repair-2026-11-06/README.md):
original failed artifact/log retained and digest checked. Local guarded checks:
four complete reference controls using a real Git diff pass (0.85s); 20 focused
shared-reader controls pass (0.94s), including alternate valid alignments and
malformed hunks/newline markers. A full local Python target encountered four
missing historical archives in the sparse checkout; leave that archive audit to
CI. No test assertion was disabled. Its other 20 controls pass. The small JSON
fixture was restored; no large archive or native build was downloaded/run.
