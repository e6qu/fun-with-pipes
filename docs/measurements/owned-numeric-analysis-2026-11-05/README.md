# Compiler cost of consuming numeric storage

**Both architectures pass every frozen compiler-cost limit.** The largest
candidate/reference ratio is 1.005943 for elapsed time and 1.011100 for peak
process memory. Identical executable copies differ by at most 1.05994%.
Limits are 5% extra time/memory and 2% identical-copy variation.

## What is measured

The candidate enables consuming array maps and coordinate-list reuse. The
reference comes from the same source with only those two transformations disabled.
Both keep every earlier optimization. Source: `07541ff956d582bb9c3936b86261e43fa25b0b2f`,
immutable tag `roadmap/owned-numeric-measurement-2026-11-05`.
[The contract](../owned-numeric-updates.md) and [allocation census](../owned-numeric-census-2026-11-05/README.md)
precede these measurements.

Time covers the complete compiler command: startup, parsing, type checking,
optimization, ownership handling and C emission. Generated programs are not
executed. Peak RSS is the maximum process memory reported by GNU `time -v`,
including warmups; it is not the isolated memory cost of this compiler pass.

Seven inputs exercise field-owner transfer, the autodiff tutorial, three generated
gradient programs, 64 calls through a shared worker and a large scoped worker.
Two byte-identical copies of each compiler alternate through two warmups and ten
measured rounds: 48 commands per input, 336 per host. Four untimed checks verify
scope specialization; two more verify all seven consuming exports and the retained
input's borrowing exclusion. The reference keeps the earlier scope optimization.

## Observed ratios

Each ratio is candidate / reference. For example, 1.0034 means about 0.34% extra
cost. Ratios below one mean lower cost. See the compressed reports for exact
seconds, KiB and every sample.

| Compiler input | ARM64 time | ARM64 peak RSS | AMD64 time | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 0.9991 | 1.0111 | 1.0021 | 1.0008 |
| autodiff-tutorial | 1.0012 | 1.0068 | 0.9982 | 1.0002 |
| derivative-3-0 | 1.0008 | 1.0080 | 1.0059 | 0.9995 |
| derivative-33-199 | 1.0015 | 1.0100 | 1.0034 | 1.0003 |
| derivative-129-199 | 1.0034 | 1.0099 | 1.0016 | 0.9998 |
| repeated-scopes | 1.0010 | 1.0107 | 1.0055 | 0.9966 |
| large-scoped-worker | 1.0011 | 1.0059 | 0.9981 | 1.0012 |

These results bound compilation overhead for these inputs. They do not establish
program speed, allocation counts or universal compiler complexity.

## Hosts, settings and evidence

[Run 41926855499](https://github.com/e6qu/fun-with-pipes/actions/runs/41926855499):

- ARM64: Neoverse-N2, job `126913414500`.
- AMD64: AMD EPYC 7763, job `126913414809`.
- Rust 1.99.1, compiler build O1 with assertions and overflow checks.
- C emission: `build --memory dynamic --emit-c -O2`; LTO off; value returns,
  frame fields, packed arrays, stack placement and array fusion explicitly on.
- [Measurement driver](../../../scripts/measure-numeric-input-analysis.py).

Independent review verifies every scheduled command, raw stdout/stderr, resource
file, source and generated-C hash, compiler-copy identity and native architecture.
It recomputes summaries from all raw samples and checks both selection preflights.
The exact reference patch and preserved ownership/runtime sources match. Both full
job logs contain no unexpected diagnostics.

[ARM64 audit](aarch64-audit.json) and [AMD64 audit](x86_64-audit.json) identify the
jobs and original artifacts. Each host has a compressed report/full log, reference
manifest, `records.zip` and retained-file hashes. The archives preserve all inputs,
generated C, raw timing/resource files and preflight records. Compiler binaries
remain in the original artifacts with verified hashes rather than being duplicated.

The evidence-only commit `cecbaeaf` also passes documentation run `41927585967`.
Its [job receipt](docs-job.json) and full compressed log retain only the three
expected negative-runner diagnostics.

Next: audit both runtime sessions per architecture, then final production gates.
[The handoff](../../development-state.md) tracks the active runs.
