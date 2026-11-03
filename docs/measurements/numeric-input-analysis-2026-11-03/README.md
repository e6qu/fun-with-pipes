# Compiler cost of numeric callback inputs

All ten program/architecture cases pass the frozen limits: candidate/reference
compilation time and peak RSS ≤1.05, identical-copy time medians within 2%.
This measures the cost of compiling programs, not their execution speed.

## Comparison

- **Candidate:** `d903126f53545098519a36960c5704eb3fcdc8f0` with numeric callback
  inputs enabled. **Reference:** the same source with only that transformation
  and numeric packed-map input preparation disabled. Complete-field moves stay
  enabled in both. Saved source patches and compiler hashes prove the difference.
- Each command is `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  Timing includes process startup, parsing, typing, optimization, ownership and
  C emission. It excludes compiling C and running the resulting program.
- Five inputs: the complete-field transfer fixture, autodiff tutorial, and
  current-only derivative programs with coordinates/updates 3/0, 33/199, 129/199.
  [The runtime workload](../derivative-owner-transfers.md#what-is-measured)
  explains those inputs; exact source hashes are in each report.
- Two identical copies per variant, two warmups per copy, then ten balanced
  four-command rounds: 240 commands per host. Timing medians exclude warmups;
  maximum GNU `time -v` RSS includes them. RSS is whole-process memory, not
  memory allocated solely by the new analysis.
- Native four-vCPU Linux: Neoverse-N2 (GCC 13.3.0) and AMD EPYC 9V74 (GCC 15.2.0).
  Rust 1.99.1 builds both compilers at production O1 with debug assertions and
  overflow checks enabled. `FWP_LTO=0`; other FWP overrides are removed.
  These compiler-cost hosts are separate from the runtime experiment's qualified hosts.

## Results

Ratios divide candidate by reference; 1.01 means 1% more time or memory.
These small differences establish compliance with the 5% overhead bound, not
an independent speedup claim.

| Input | ARM64 time | AMD64 time | ARM64 peak RSS | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 0.9997 | 0.9909 | 1.0022 | 1.0034 |
| autodiff-tutorial | 0.9992 | 1.0000 | 0.9998 | 1.0034 |
| derivative-3-0 | 0.9998 | 1.0043 | 1.0002 | 1.0043 |
| derivative-33-199 | 1.0015 | 0.9941 | 1.0008 | 1.0021 |
| derivative-129-199 | 1.0008 | 1.0052 | 0.9973 | 1.0043 |

Across both hosts, the largest time increase is 0.53%, the largest peak-RSS
increase is 0.44%, and the largest identical-copy difference is 0.91%.
Median compilation takes 0.272–0.629 seconds. Candidate peak RSS ranges from
40.9 to 65.3 MiB. All limits pass without rerunning measurements.

## Evidence

[Run 41550965701](https://github.com/e6qu/fun-with-pipes/actions/runs/41550965701):
ARM64 job `125638155631`, AMD64 `125638155311`. Full logs have no diagnostics.
The independent audit verifies all 480 commands, copied native ELF images,
reference source changes, every archived file hash, generated C, raw RSS samples
and recalculated acceptance outcomes.

- Reports and samples: [ARM64](aarch64.json.gz) / [AMD64](x86_64.json.gz).
- Complete logs: [ARM64](arm.log.gz) / [AMD64](amd.log.gz).
- [Artifact identities and download URLs](artifacts.json).
- [Frozen protocol](../numeric-callback-input-protocol.md).
