# Compiler cost of gradient-array storage

All ten program/architecture cases pass. Compilation time and peak process
memory stay within the 5% limits; identical copies differ by at most 1.15%.
These measurements check compiler overhead, not generated-program speed.

## Comparison

- **Source:** `1f6a4ac80ed3e9e89106c27573d0c73d46bb6968`, frozen by
  `roadmap/gradient-array-measurement-2026-11-03`. The reference removes the complete
  gradient-array change from the same library, runtime and compiler source.
- **Command:** `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  Timing includes startup, parsing, typing, optimization, ownership and C emission.
  It excludes compiling C and running the generated program.
- **Inputs:** field-transfer fixture, autodiff tutorial, and complete derivative
  solves with coordinates/updates 3/0, 33/199 and 129/199. The audit checks each
  saved input against its frozen fixture or generator.
- **Schedule:** two identical candidate copies and two reference copies; two
  warmups each, then ten balanced rounds. There are 240 commands per host.
  Time medians exclude warmups; peak GNU time process memory includes them.
- **Hosts/build:** native Linux ARM64 (implementer `0x41`, part `0xd49`) and
  AMD64 EPYC 7763. Rust 1.99.1 builds both compilers at O1 with debug assertions
  and overflow checks enabled, two build jobs and `FWP_LTO=0`.

## Results

Each ratio divides candidate by reference: 1.01 means 1% more time or memory.
Small differences establish the overhead bound, not a separate speedup claim.

| Input | ARM64 time | AMD64 time | ARM64 peak memory | AMD64 peak memory |
|---|---:|---:|---:|---:|
| field-transfer | 0.9982 | 1.0001 | 1.0017 | 1.0010 |
| autodiff-tutorial | 0.9907 | 0.9904 | 0.9998 | 0.9996 |
| derivative-3-0 | 0.9932 | 0.9951 | 0.9977 | 0.9944 |
| derivative-33-199 | 0.9959 | 0.9968 | 1.0000 | 0.9976 |
| derivative-129-199 | 0.9945 | 0.9976 | 1.0001 | 1.0009 |

Maximum measured increases: 0.011% in elapsed compilation time and 0.174% in
peak process memory; maximum identical-copy difference is 1.153%. No completed
measurement was rerun. Whole-process peak memory is not isolated analysis heap use.

## Evidence

[Run 41629709664](https://github.com/e6qu/fun-with-pipes/actions/runs/41629709664)
passes on both hosts. The audit verifies all 480 commands, raw memory records,
file hashes, native ELF images, exact reference sources and recalculated limits.
Both full logs have clean diagnostics.

- ARM64: [report/samples](aarch64-report.json.gz), [full log](aarch64-job.log.gz),
  [source manifest](aarch64-reference.json), [job/artifact/audit record](aarch64-audit.json).
- AMD64: [report/samples](x86_64-report.json.gz), [full log](x86_64-job.log.gz),
  [source manifest](x86_64-reference.json), [job/artifact/audit record](x86_64-audit.json).
- [Allocation/cleanup results](../gradient-array-storage-2026-11-03/README.md)
  and [runtime timings](../gradient-array-time-2026-11-03/README.md) are separate checks.
