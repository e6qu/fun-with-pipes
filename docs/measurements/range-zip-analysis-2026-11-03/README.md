# Compiler cost of private range consumption

All ten program/architecture cases pass: candidate/reference elapsed time and
peak RSS are within 1.05, and identical-copy medians differ by less than 2%.
This measures compiler work, not generated-program speed.

## What was measured

- **Candidate:** frozen `3be9479c4150d7aae5695d7f7aa4ce3f84d0f738`.
  **Reference:** the same source with only `range_zip::lower` disabled.
  All earlier optimizations remain enabled; the audit reconstructs that exact patch.
- **Command:** `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  Timing includes startup, parsing, typing, optimization, ownership and C emission.
  It excludes compiling C and running the resulting program.
- **Inputs:** field-transfer fixture, autodiff tutorial, and complete derivative
  programs for coordinates/updates 3/0, 33/199 and 129/199. Source and generated-C
  hashes are recorded in each report.
- **Schedule:** two identical candidate copies and two reference copies; two
  warmups each, then ten balanced rounds. There are 240 commands per architecture.
  Time medians exclude warmups; maximum GNU time process RSS includes them.
- **Hosts/settings:** native four-vCPU Linux; ARM64 implementer `0x41`, part
  `0xd49`; AMD64 EPYC 7763. Rust 1.99.1 builds both compilers at production O1
  with debug assertions and overflow checks, two build jobs and `FWP_LTO=0`.
  Other FWP execution overrides are removed. CPU records and commands are saved.

## Results

Each ratio divides candidate by reference: 1.01 means 1% more time or memory.
These small differences verify the overhead bound; they do not establish a
separate compiler speed improvement.

| Input | ARM64 time | AMD64 time | ARM64 peak RSS | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 0.9985 | 1.0012 | 1.0003 | 0.9959 |
| autodiff-tutorial | 0.9975 | 0.9953 | 1.0015 | 1.0019 |
| derivative-3-0 | 0.9992 | 0.9961 | 1.0015 | 0.9990 |
| derivative-33-199 | 1.0017 | 1.0007 | 1.0002 | 0.9966 |
| derivative-129-199 | 0.9981 | 0.9966 | 1.0028 | 0.9994 |

Maximum elapsed increase: 0.17%; peak-RSS increase: 0.28%;
identical-copy variation: 1.08%. No completed measurement was rerun.

## Evidence

[Run 41603242667](https://github.com/e6qu/fun-with-pipes/actions/runs/41603242667):
ARM64 job `125806753941`, AMD64 `125806753716`. Both full logs are clean.
Independent audits verify all 480 commands, raw RSS, source/reference patches,
actual ELF image headers, executable/file hashes, generated C and recalculated
acceptance outcomes.

- Reports and samples: [ARM64](aarch64.json.gz), [AMD64](x86_64.json.gz).
- Full logs: [ARM64](arm.log.gz), [AMD64](amd.log.gz).
- [Original artifact identities and download URLs](artifacts.json).
- [Storage verification](../range-zip-storage-2026-11-03/README.md) and
  [runtime comparison](../range-zip-time-2026-11-03/README.md) are separate results.
