# Compiler cost of scalar map buffers

All ten program/architecture cases pass the frozen limits: candidate/reference
elapsed time and peak RSS ≤1.05, with identical-copy medians within 2%.
This measures compilation, not the speed of generated programs.

## What was compared

- **Candidate:** `da510f18b089c3db5527466b349fec0f2f3ee9ef`, tree identical to
  merged PR #250. **Reference:** the same source with only
  `scalar_map_zip::lower` bypassed. Existing packed-record and numeric-input
  transformations remain enabled. The audit reconstructs the exact source patch.
- **Command:** `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  Elapsed time covers startup, parsing, typing, optimization, ownership and C
  emission. It excludes compiling C and executing the resulting program.
- **Inputs:** field-transfer fixture, autodiff tutorial, and current-only
  derivative solves with coordinates/updates 3/0, 33/199 and 129/199. Exact source
  hashes and generated C hashes are in each report.
- **Schedule:** two byte-identical candidate copies and two reference copies;
  two warmups per copy, then ten balanced rounds. There are 240 commands per
  architecture. Time medians exclude warmups; maximum GNU time RSS includes them.
  RSS covers the whole process, not only the selected compiler pass.
- **Hosts:** native four-vCPU Linux. ARM64 reports implementer `0x41`, part
  `0xd49`; AMD64 is EPYC 9V74. Rust 1.99.1 builds both compilers at production O1
  with debug assertions and overflow checks. `FWP_LTO=0`; other FWP overrides
  are removed. GCC versions recorded are 13.3.0 on ARM64 and 15.2.0 on AMD64.
  These compiler-cost hosts are separate from the runtime experiment's fixed CPUs.

## Results

Each ratio divides candidate by reference; 1.01 means 1% more time or memory.
The small differences establish the 5% overhead bound, not a separate speedup.

| Input | ARM64 time | AMD64 time | ARM64 peak RSS | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 0.9957 | 1.0053 | 0.9878 | 0.9984 |
| autodiff-tutorial | 1.0006 | 1.0115 | 0.9922 | 1.0025 |
| derivative-3-0 | 0.9998 | 0.9938 | 0.9887 | 1.0032 |
| derivative-33-199 | 0.9956 | 1.0015 | 0.9894 | 0.9988 |
| derivative-129-199 | 0.9982 | 0.9944 | 0.9891 | 0.9993 |

Across both hosts, maximum elapsed increase is 1.15%, peak-RSS
increase 0.32%, and identical-copy variation 1.64%.
No measurement was rerun to improve its result.

## Evidence

[Run 41591971248](https://github.com/e6qu/fun-with-pipes/actions/runs/41591971248):
ARM64 job `125770529929`, AMD64 `125770529588`. Both full logs are clean.
The independent audit checks all 480 commands, native ELF headers, copied
executable hashes, the exact single-call reference patch, every archived file,
generated C, raw RSS records and recalculated acceptance outcomes.

- Reports and samples: [ARM64](aarch64.json.gz) / [AMD64](x86_64.json.gz).
- Full logs: [ARM64](arm.log.gz) / [AMD64](amd.log.gz).
- [Artifact identities and download URLs](artifacts.json).
- [Frozen comparison](../temporary-list-storage.md#execution-of-the-frozen-comparison).
