# Compiler cost of direct scalar array calls

All ten input/architecture cases pass the compiler time and memory limits.
These measurements cover compiling fwp to C, not running the generated program.

## What is compared

- **Source:** `e649da78c41dab8fa6f191d7670b1efba79811b0`, tag
  `roadmap/scalar-array-map-measurement-2026-11-03`.
- **Candidate/reference:** two builds of the same source. The reference disables
  only direct calls to closed scalar array-map callbacks. Both retain all prior
  gradient-array, ownership and storage changes.
- **Timed command:** `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  It includes startup, parsing, typing, optimization, ownership analysis and C
  emission. Building the fwp compilers, compiling emitted C and running it are
  outside this timer.
- **Inputs:** field-owner transfer, the autodiff tutorial, and complete derivative
  solves with coordinate/update counts 3/0, 33/199 and 129/199. Saved inputs match
  their frozen fixtures or generator exactly.
- **Schedule:** two identical copies of each compiler; two warmups per copy and
  ten balanced measured rounds. Time medians exclude warmups; peak process memory
  includes them. Each host runs 240 commands. Identical-copy differences must stay
  within 2%; candidate/reference time and memory ratios must stay within 1.05.
- **Hosts/build:** native Linux ARM64 (implementer `0x41`, part `0xd49`) and AMD64
  architecture on Intel Xeon Platinum 8370C. Rust 1.99.1 builds both compilers at
  O1, with debug assertions and overflow checks, two build jobs and `FWP_LTO=0`.
  This compiler-cost protocol compares builds on each host; the separate runtime
  protocol requires its own qualified CPU models.

## Results

Ratios divide candidate by reference: 1.01 means 1% more time or memory.
Small differences establish the declared overhead bound, not a speedup claim.

| Input | ARM64 time | AMD64 time | ARM64 peak memory | AMD64 peak memory |
|---|---:|---:|---:|---:|
| Field-owner transfer | 0.9973 | 1.0049 | 0.9994 | 0.9990 |
| Autodiff tutorial | 1.0027 | 1.0066 | 1.0017 | 0.9996 |
| Derivative 3/0 | 0.9972 | 1.0001 | 0.9998 | 1.0003 |
| Derivative 33/199 | 0.9978 | 1.0026 | 1.0003 | 1.0013 |
| Derivative 129/199 | 0.9974 | 1.0069 | 1.0003 | 1.0018 |

The largest observed increases are 0.688% in elapsed time and 0.185% in peak
process memory. Maximum identical-copy difference is 1.288%. No completed
measurement was rerun. Peak process memory includes the complete compiler, not
just the new selector's storage.

## Retained evidence

[Run 41649281445](https://github.com/e6qu/fun-with-pipes/actions/runs/41649281445)
passes on both hosts. Independent audits reconcile all 480 commands, raw time/RSS
records, input and generated-C hashes, native ELF compiler images, exact reference
sources and recalculated limits. Both full logs have clean diagnostics.

- ARM64: [samples](aarch64-report.json.gz), [full log](aarch64-job.log.gz),
  [reference manifest](aarch64-reference.json), [job/artifact/audit](aarch64-audit.json).
- AMD64: [samples](x86_64-report.json.gz), [full log](x86_64-job.log.gz),
  [reference manifest](x86_64-reference.json), [job/artifact/audit](x86_64-audit.json).
- [Native semantics and cleanup](../direct-array-callbacks-2026-11-03/README.md)
  and [runtime acceptance rules](../direct-array-callbacks.md#frozen-performance-comparison)
  are separate checks.
