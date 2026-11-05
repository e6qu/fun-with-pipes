# Compiler cost of gradient-call storage reductions

**Both architectures pass all compiler-cost limits.** The largest increase is
0.44% in compilation time and 0.53% in peak compiler memory, against 5% limits.
Identical executable copies differ by at most 0.98%, against a 2% limit.
These measurements concern compilation, not the generated program's speed.

## Compared work

The candidate enables the [four gradient-call reductions](../gradient-call-storage.md).
The reference disables only those four changes; both retain earlier optimizations
and correctness repairs. Source `d494dd910723303f99992610895d9784968c79e8`, tag
`roadmap/gradient-call-timing-2026-11-05`. Its compiler/runtime/library/test trees
match the source that passed the focused native checks and allocation census.

The timer covers the complete compiler command through C emission: startup,
parsing, type checking, optimization, ownership handling and output generation.
GNU `time -v` reports peak process memory (RSS), including warmup commands.
This is not the memory usage of one compiler pass, and generated programs are
not executed in this measurement.

Seven inputs cover field-owner transfer, the autodiff tutorial, three gradient
programs, 64 calls through a shared worker and one large scoped worker. Two
byte-identical copies of each compiler alternate through two warmups and ten
measured rounds: 48 commands per input, 336 per host. Six untimed checks confirm
scope selection and preservation of the earlier consuming-storage optimization
on both candidate and reference.

## Results

Ratios are candidate / reference: 1.0044 means roughly 0.44% extra cost; a value
below one means lower cost. Reports retain exact seconds, KiB and all samples.

| Compiler input | ARM64 time | ARM64 peak RSS | AMD64 time | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 1.0044 | 0.9955 | 0.9965 | 1.0025 |
| autodiff-tutorial | 0.9938 | 0.9883 | 0.9967 | 0.9927 |
| derivative-3-0 | 0.9868 | 0.9843 | 0.9875 | 0.9907 |
| derivative-33-199 | 0.9831 | 0.9838 | 0.9824 | 0.9869 |
| derivative-129-199 | 0.9855 | 0.9852 | 0.9851 | 0.9930 |
| repeated-scopes | 0.9996 | 0.9941 | 1.0021 | 1.0053 |
| large-scoped-worker | 0.9998 | 0.9954 | 1.0034 | 1.0013 |

## Hosts and evidence

[Run 41967900961](https://github.com/e6qu/fun-with-pipes/actions/runs/41967900961):

- ARM64: Neoverse-N2, job `127049078568`.
- AMD64: AMD EPYC 7763, job `127049078840`.
- Rust 1.99.1; compiler build O1 with assertions and overflow checks.
- C emission: `build --memory dynamic --emit-c -O2`. LTO is off; value returns,
  frame fields, packed arrays, stack placement and array fusion are explicitly on.
- [Measurement driver](../../../scripts/measure-numeric-input-analysis.py).

The [ARM64 audit](aarch64-audit.json) and [AMD64 audit](x86_64-audit.json)
recompute summaries from raw samples and verify command order, outputs, resource
files, generated C, compiler-copy identity, native architecture and the exact
reference patch. All 336 commands and six untimed checks pass per host; complete
job logs contain no unexpected diagnostics.

Beside the audits are compressed reports/full logs, reference manifests,
`records.zip` files and retained-file hashes. Each archive contains 1,082 files:
inputs, generated C, timing/resource output and selection records. Compiler
binaries remain in the original digest-identified GitHub artifacts.

Runtime measurements and the final production matrix remain in [PLAN.md](../../../PLAN.md).
