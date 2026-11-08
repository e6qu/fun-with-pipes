# Fresh F64 output-store diagnostic

**Decision:** implement this narrow candidate and verify it. This diagnostic
does not complete the performance milestone. ARM64 large maps take 28–32% less
computation time; manual derivative updates at 33/129 coordinates take about 11%
less. Most AMD64 copy controls fail, so those ratios are inconclusive.

The [frozen protocol](../shared-loop-array-costs.md#fresh-output-diagnostic)
compares the same saved fwp-generated C with and without fresh-output view checks
and initialized-element bookkeeping. Captured-input metadata caching is disabled
on both sides. It changes no source arithmetic, callbacks, allocation or cleanup.
There is no C/Rust/Swift peer in this paired diagnostic.

[Run 42437082841](https://github.com/e6qu/fun-with-pipes/actions/runs/42437082841)
at `432d19715c87a5aae9681c4b7b3507847eb87a53` passes both producer jobs:
ARM64 `128599976437` and AMD64 `128599976447`. Each runs all 18 inputs, two
warmups and 24 rotated rounds with candidate/reference and byte-identical copies.
Native hosts are recorded in [summary.json](summary.json), with compiler flags,
hashes, phase medians and copy ratios. These are uninstrumented computation
measurements; allocation counters, RSS and compiler costs were not measured.

Percentages below are `(candidate / reference - 1) × 100`; negative means less
time. A dagger means identical-copy variation exceeded 2%, invalidating that
comparison. All original observations remain, including slower cases.

| Input | ARM64 computation | AMD64 computation |
|---|---:|---:|
| loop-0 | -0.06% | +1.29% |
| loop-16 | -0.62% | +0.54% † |
| loop-1000000 | -0.05% | -2.76% |
| loop-100000000 | -0.06% | +0.22% |
| array-0 | -0.18% | -8.08% † |
| array-16 | -8.87% | -1.57% |
| array-65537 | -31.51% | -14.17% † |
| array-262145 | -28.16% | -18.04% † |
| manual-3-0 | +0.08% | +0.99% † |
| manual-3-1 | -1.16% | -5.88% † |
| manual-3-199 | -4.35% | +18.91% † |
| manual-33-199 | -11.76% | -8.67% |
| manual-129-199 | -11.03% | -10.46% † |
| local-3-0 | +0.33% | +1.95% † |
| local-3-1 | -1.34% | -4.47% |
| local-3-199 | +0.59% | +0.35% † |
| local-33-199 | -1.41% | -6.77% † |
| local-129-199 | +0.01% | -7.95% † |

The retained archives contain every command, source patch, output, raw sample and
stack report from the diagnostic (excluding its duplicate original-input archive).
Job logs and summary match, and downloaded artifact digests/ZIP checks pass.
Complete independent source/image/sample auditing remains part of final delivery;
producer success alone does not establish that audit or speed acceptance.

Original source and images remain in artifacts `13600770461` (ARM64) and
`13600631455` (AMD64), identified by digest in the summary. The earlier
[metadata experiment](../borrowed-array-metadata-2026-11-08/README.md) is rejected,
not silently combined with this change.
