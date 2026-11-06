# Compiler cost of the checked capacity gate

All 14 input/architecture comparisons pass. Elapsed-time and peak-memory ratios
are below the 1.05 limit, and identical-copy controls meet the 2% limit. These
results measure the compiler; they do not establish runtime performance.

## What was measured

- Source `51edfc0e7884e1a75201bc9876fd13cb8ca25eee`. The same-source reference
  recombines the checked capacity gate and unchanged tape-growth body.
- Timed command: `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  Scope: compiler startup through C emission. Excludes building the compilers,
  C compilation and program execution.
- Seven inputs: field-owner transfer, the autodiff tutorial, three derivative
  solves, 64 shared-scope callback calls and a worker with 5,120 callback calls.
- Two identical copies per compiler, two warmups and ten measured rounds each:
  336 commands per architecture, plus six untimed source/selection checks.
  Medians exclude warmups; maximum process RSS includes them.
- Linux ARM64 and AMD64; compiler builds use O1, debug assertions and overflow
  checks, two build jobs and no LTO. Reports retain hardware, toolchain and
  environment records.

Ratios divide candidate by reference: 1.01 means 1% more elapsed time or peak RSS.
`33/199` means 33 coordinates and 199 updates.

| Input | ARM64 time | AMD64 time | ARM64 RSS | AMD64 RSS |
|---|---:|---:|---:|---:|
| field-transfer | 1.0003 | 1.0048 | 0.9999 | 1.0014 |
| autodiff-tutorial | 0.9954 | 1.0044 | 1.0005 | 0.9990 |
| derivative-3-0 | 0.9981 | 1.0107 | 0.9981 | 0.9991 |
| derivative-33-199 | 1.0020 | 1.0017 | 0.9991 | 0.9984 |
| derivative-129-199 | 1.0016 | 1.0070 | 0.9991 | 1.0011 |
| repeated-scopes | 1.0036 | 0.9960 | 0.9983 | 1.0006 |
| large-scoped-worker | 0.9924 | 1.0064 | 1.0017 | 1.0001 |

## Verification

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42179974129)
and [repaired complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42182313740)
pass. All 672 compiler commands succeed. The audit verifies every input, command,
resource record, generated-C hash, reference edit and complete job log.

The [first audit's patch-format defect](../recording-capacity-audit-repair-2026-11-06/README.md)
is fixed. This audit uses the original samples; no timing was repeated.

- ARM64: [samples](aarch64-report.json.gz), [audit](aarch64-audit.json),
  [log](aarch64-job.log.gz), [reference](aarch64-reference.json).
- AMD64: [samples](x86_64-report.json.gz), [audit](x86_64-audit.json),
  [log](x86_64-job.log.gz), [reference](x86_64-reference.json).
- Each `*-records.zip` retains 1,081 input/source/command records, with hashes
  in `*-retained-files.json`. All 2,162 retained hashes and the audit archive
  digest were independently verified locally. Original compiler images remain
  in the identified CI artifacts.

[Artifact](artifact.json) · [Audit job](audit-job.json) ·
[Full audit log](audit-job.log.gz) · [Contract](../recording-capacity.md)
