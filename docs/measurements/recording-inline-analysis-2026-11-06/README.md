# Compiler cost of scalar append inlining

Thirteen of fourteen input/architecture cases qualify. AMD64's zero-update
three-coordinate input is **inconclusive**: identical reference compiler copies
differ by 2.0494%, above the frozen 2% limit. Every observed candidate/reference
time and peak-memory ratio is below 1.05. The failed copy control stays open;
no timing was repeated.

## What was measured

- Source `ecfd740be6289b365dd2a1bb9e2f60980ab27c8f`. The reference changes only
  the scalar append declaration; both versions retain every runtime check.
- Timed command: `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  It covers compiler startup through C emission. It excludes compiler builds,
  C compilation and program execution; runtime results are measured separately.
- Seven inputs: field-owner transfer, the autodiff tutorial, three derivative
  solves, 64 shared-scope callback calls and a large worker with 5,120 callback
  calls. `33/199` means 33 coordinates and 199 updates.
- Two identical copies per compiler, two warmups and ten measured rounds each:
  336 commands per architecture, plus six untimed source/selection checks.
  Medians exclude warmups; maximum process RSS includes them.
- Linux ARM64 implementer `0x41`, part `0xd49`, and AMD EPYC 7763. Both compiler
  builds use O1, debug assertions and overflow checks, two build jobs and no LTO.
  Complete CPU, toolchain and environment records are in the reports and logs.

Ratios divide candidate by reference: 1.01 means 1% more elapsed time or peak RSS.
The limits are 1.05 for each, plus at most 2% variation between identical copies.

| Input | ARM64 time | AMD64 time | ARM64 RSS | AMD64 RSS |
|---|---:|---:|---:|---:|
| field-transfer | 1.0025 | 0.9995 | 1.0010 | 0.9995 |
| autodiff-tutorial | 1.0024 | 1.0031 | 1.0009 | 0.9979 |
| derivative-3-0 | 0.9963 | 0.9972 (inconclusive) | 1.0018 | 0.9995 |
| derivative-33-199 | 0.9995 | 0.9975 | 0.9986 | 0.9992 |
| derivative-129-199 | 1.0011 | 1.0019 | 1.0016 | 0.9992 |
| repeated-scopes | 1.0039 | 1.0003 | 1.0000 | 1.0000 |
| large-scoped-worker | 1.0060 | 1.0019 | 0.9983 | 1.0002 |

## Review of the failed copy control

The [saved-sample review](sample-review.json), reproduced by
[this script](sample-review.py), inspects all 48 original commands for the AMD64
zero-update case, including warmups and process resource records.

| Copy | Median seconds | First five rounds | Last five rounds |
|---|---:|---:|---:|
| Candidate 1 | 0.386554 | 0.384718 | 0.388651 |
| Candidate 2 | 0.387002 | 0.386880 | 0.387613 |
| Reference 1 | 0.391746 | 0.386726 | 0.394841 |
| Reference 2 | 0.383879 | 0.381520 | 0.389443 |

All copies become slower in the second half. Each copy occupies only two of four
execution positions, so identity and position are partly confounded. Compiler
copies are byte-identical within each version and emit identical C within that
version. Median major faults are zero and output-write counts match. CPU records
have 0.01-second resolution. These observations establish variation, not its cause.
A future diagnostic must separate position and copy identity before changing the
setup; do not rerun this unchanged comparison for a pass.

## Evidence

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42158777078)
and [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42160109377).
All 672 compiler invocations succeed. The AMD64 job fails only its final copy-limit
assertion; the successful audit preserves that failure and checks every command,
input, generated-C hash, reference edit, resource record and complete job log.

- ARM64: [samples](aarch64-report.json.gz), [audit](aarch64-audit.json),
  [log](aarch64-job.log.gz), [reference](aarch64-reference.json).
- AMD64: [samples](x86_64-report.json.gz), [audit](x86_64-audit.json),
  [log](x86_64-job.log.gz), [reference](x86_64-reference.json).
- Each `*-records.zip` retains 1,081 input/source/command records; hashes are in
  `*-retained-files.json`. Compiler images remain in the original CI artifacts.
- [Audit job](audit-job.json), [full log](audit-job.log.gz) and
  [artifact digest](artifact.json) identify the complete audit. All retained
  hashes were also verified locally under the resource guard.

[Protocol](../recording-inline.md) ·
[Work and memory](../recording-inline-census-2026-11-06/README.md) ·
[Handoff](../../development-state.md)
