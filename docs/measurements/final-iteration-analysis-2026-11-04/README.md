# Compiler cost of final-iteration storage

Nine of ten input/architecture timing cases pass. AMD64 field-owner transfer is
**inconclusive**: byte-identical candidate copies differ by 2.043%, above the frozen
2% noise limit. All observed candidate/reference time and memory increases are
below 5%; that does not override the failed noise control. No session was repeated.

## What is measured

- Source `bb5433b688c26c60f0b2561a59420deb0f0e95ed`, tag
  `roadmap/final-iteration-measurement-2026-11-04`.
- Same-source candidate/reference. The reference restores reverse/head and
  disables only unused iteration-history removal. Both contain count-validation,
  optional-wrapper cleanup and earlier ownership repairs.
- Timed command: `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  It includes compiler startup, parsing, typing, optimization, ownership analysis
  and C emission. Compiler builds, C compilation and program execution are outside
  this timer. Peak RSS covers the whole compiler process, not just this pass.
- Inputs: field-owner transfer, the autodiff tutorial, and derivative solves with
  coordinate/update counts 3/0, 33/199 and 129/199. All match the frozen source or
  generator exactly. These checks bound compiler overhead; they are separate from
  the runtime history-memory comparison.
- Two identical copies per compiler; two warmups and ten balanced measured rounds
  per copy. Time medians exclude warmups; peak RSS includes them. Each architecture
  runs 240 commands. Limits: copy variation ≤2%, time/RSS ratios ≤1.05.
- Native Linux ARM64 and AMD64; Rust 1.99.1, compiler O1, debug assertions and
  overflow checks enabled, two build jobs, `FWP_LTO=0`. The compiler-cost protocol
  checks architecture; the runtime protocol separately requires qualified CPUs.

## Results

Ratios divide candidate by reference: 1.01 means 1% more time or memory.
A small passing difference establishes the overhead bound, not a speed gain.

| Input | ARM64 time | AMD64 time | ARM64 peak RSS | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| Field-owner transfer | 0.9985 | 1.0008 (inconclusive) | 0.9970 | 1.0004 |
| Autodiff tutorial | 0.9989 | 1.0006 | 0.9984 | 1.0007 |
| Derivative 3/0 | 1.0010 | 0.9949 | 0.9986 | 1.0008 |
| Derivative 33/199 | 1.0016 | 0.9973 | 0.9989 | 1.0008 |
| Derivative 129/199 | 1.0004 | 0.9896 | 0.9976 | 0.9997 |

The noisy candidate copies have medians 0.355084 s and 0.362337 s. Their hashes
match exactly. The reference copies differ by only 0.052%. These observations
establish measurement variation, not its scheduling/hardware cause or a compiler
regression. Retain the case as open; any further diagnostic must declare its
sample/setup question before changing the protocol.

## Evidence

[Run 41729365239](https://github.com/e6qu/fun-with-pipes/actions/runs/41729365239)
passes ARM64 and reports the noise failure on AMD64. Independent audits reconcile
all 480 commands, raw time/RSS records, exact inputs, generated C, compiler image
hashes/architectures and the two-file reference patch. All compiler invocations
succeed. The AMD64 job's only failure is the final noise-limit assertion.

- ARM64: [samples](aarch64-report.json.gz), [full log](aarch64-job.log.gz),
  [reference manifest](aarch64-reference.json), [audit](aarch64-audit.json).
- AMD64: [samples](x86_64-report.json.gz), [full log](x86_64-job.log.gz),
  [reference manifest](x86_64-reference.json), [audit](x86_64-audit.json).
- [Native correctness](../final-iteration-storage-2026-11-03/README.md),
  [runtime measurements](../final-iteration-time-2026-11-04/README.md), and
  [frozen contract](../final-iteration-storage.md) are separate acceptance checks.
