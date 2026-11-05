# Scalar constants: compiler costs

**Both hosts and the full artifact audit pass.** Maximum observed compilation-time
increase is 1.78%; peak compiler memory increases at most
0.06% (5% limits). Identical copies vary at most
1.22% (2% limit). These are compiler costs, not runtime speed.

## Comparison and timing scope

Source `76690b385514c58ad94c5591da3553fa48218535`. Compare scalar replacement
enabled versus disabled, with all other compiler passes unchanged. Seven inputs
use two identical copies per compiler, two warmups and ten balanced measured
rounds: 48 commands per input, 336 per host. Six additional untimed checks verify
the prior storage transformations; scalar selection is checked after the first
warmup for both large derivative inputs.

Each timed command runs from compiler startup through emitted C: parsing, type
inference, optimization, ownership analysis and output. GNU `time -v` records
peak RSS. Rust 1.99.1 builds fwp at production O1 with assertions and overflow
checks. Commands use `build --memory dynamic --emit-c -O2`, LTO off and explicit
representation settings. No generated executable runs in this timing scope.

Hosts: GitHub Linux ARM64 (CPU implementer `0x41`, part `0xd49`) and AMD EPYC
7763 AMD64. The reports retain full CPU descriptions, compiler versions,
commands, every sample and peak-memory observation.

## Results

Ratios are candidate / cached reference. For example, `1.0178` means about
1.78% more compilation time; a value below 1 means less.

| Input | ARM64 time | ARM64 peak RSS | AMD64 time | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 0.9982 | 0.9926 | 1.0111 | 0.9974 |
| autodiff-tutorial | 0.9989 | 0.9931 | 1.0110 | 0.9990 |
| derivative-3-0 | 0.9994 | 0.9900 | 1.0093 | 0.9973 |
| derivative-33-199 | 0.9946 | 0.9906 | 1.0077 | 0.9990 |
| derivative-129-199 | 0.9976 | 0.9918 | 1.0178 | 1.0006 |
| repeated-scopes | 0.9975 | 0.9936 | 1.0107 | 0.9982 |
| large-scoped-worker | 0.9944 | 0.9954 | 1.0056 | 0.9986 |

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42074639596)
and [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42076024832)
pass. [ARM64](aarch64-audit.json) and [AMD64](x86_64-audit.json) receipts verify
all commands, untimed checks, reference edits, outputs and source/image identities.
All job diagnostics were audited with no unresolved warnings or failures.
[Retention](retention.json) identifies the verified archive; adjacent records keep
full logs, reports and observations. Compiler binaries remain in the original
artifacts identified by each receipt.

[Allocation and stack checks](../scalar-constant-census-2026-11-05/README.md)
also pass. [Runtime measurements](../scalar-constant-time-2026-11-05/README.md)
retain 27 missed speed targets; final production delivery remains pending.
