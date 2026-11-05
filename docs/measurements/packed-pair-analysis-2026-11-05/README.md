# Compiler cost of private pair reuse

Both architectures pass. The largest increases are 0.66% in compilation time
and 0.16% in peak compiler memory, against 5% limits. Identical compiler copies
differ by at most 1.63%, against 2%. These are compilation costs, not program speed.

## Equivalent work

Source `a1f189478abadf0da30d8386bee2bc234e0668cf`, tag
`roadmap/packed-pair-timing-2026-11-05`. The reference disables only the private
pair-reuse constant; ownership and earlier optimizations remain the same.
The timer covers the whole compiler through C emission: startup, parsing,
type checking, optimization, ownership analysis and output. GNU `time -v`
records peak process memory, including warmups.

Each of seven inputs uses two identical copies per compiler, two warmups and
ten balanced measured rounds: 48 commands per input, 336 per host. Six untimed
checks verify scope selection and the earlier consuming-storage transformation.
Compilation uses Rust 1.99.1 at production O1 with assertions/overflow checks.
fwp emits C with `build --memory dynamic --emit-c -O2`; LTO is off and value
returns, frame fields, packed arrays, stack placement and array fusion are on.
Native hosts: Neoverse-N2 ARM64 and AMD EPYC 7763 AMD64.

## Results

Each ratio is reuse / allocating reference. For example, 1.0066 means 0.66%
more time. Reports retain exact seconds, KiB and all samples.

| Input | ARM64 time | ARM64 peak RSS | AMD64 time | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 1.0008 | 1.0016 | 0.9989 | 1.0014 |
| autodiff-tutorial | 1.0030 | 0.9991 | 1.0004 | 1.0002 |
| derivative-3-0 | 1.0042 | 1.0015 | 1.0016 | 0.9972 |
| derivative-33-199 | 0.9980 | 1.0000 | 1.0066 | 0.9987 |
| derivative-129-199 | 1.0019 | 1.0003 | 1.0060 | 1.0013 |
| repeated-scopes | 1.0009 | 1.0000 | 1.0044 | 1.0007 |
| large-scoped-worker | 0.9999 | 0.9991 | 0.9963 | 0.9973 |

## Retained evidence

[Measurement run 42005106056](https://github.com/e6qu/fun-with-pipes/actions/runs/42005106056)
and [full artifact audit 42008507459](https://github.com/e6qu/fun-with-pipes/actions/runs/42008507459)
pass. The [ARM64 receipt](aarch64-audit.json) and [AMD64 receipt](x86_64-audit.json)
verify all commands, generated C, output/resource records, compiler identities,
architecture and the exact reference patch. Full job logs contain no unexpected
diagnostics. The adjacent reports, manifests, logs and 1,081-file observation
archives preserve the results. Compiler binaries remain in the original artifacts.

[Retention artifact 13405474251](https://github.com/e6qu/fun-with-pipes/actions/runs/42008507459/artifacts/13405474251):
12,315,774 bytes, SHA-256
`88adb417ba1f86cddb7dfc0881078c753ddbd491566ddc96f35a442c2d949e8e`.

These results describe the first implementation. The later
[cleanup-record repair](../packed-pair-cleanup-repair.md) requires new checks;
these measurements are retained unchanged, not attributed to the repair.
