# Ordered-sort experiment results

Neither candidate met the predeclared screen. Keep the current merge algorithm.
The [protocol](map-order-protocol.md) explains the candidates, inputs and thresholds;
the [raw report](map-order-2026-10-24.json) retains every sample, source and binary hash,
toolchain, instruction size, compiler stack report and stability observation.

## What was compared

These are fwp-versus-fwp experiments. `ordered-merge` skips a merge when its two
sorted halves are already in order. `ordered-range` also checks the whole range
before recursing. A byte-identical copy of the baseline tests measurement drift.
The same workflow separately checks the [C/Rust peers](checked-peers.md); their
ratios are not the effect of either sorting change.

Source `cbacdff5e8cb33772dec72bfba7f2c7b027b4229`, focused run
[40085991550](https://github.com/e6qu/fun-with-pipes/actions/runs/40085991550).
Both native Linux jobs pass. Independent review checked 128 actual binary files,
including 64 candidate/stability images, and reproduced all timing screens.
Each candidate preserves all 60 stability/alias cases per host; deliberately
omitting merges is detected. This is bounded semantic coverage, not full delivery.

Each of four allowed CPUs was measured separately: two warmups, then 32 samples
per program and variant in rotating/reversed order. Timing covers the complete
process, including startup and output. Both elapsed and child CPU time had to
show at least 5% map improvement, no more than 3% slowdown elsewhere, and no more
than 3% drift for the identical copy. Native code used GCC 13.3, O2, no LTO and
`-ffp-contract=off`.

## Map results

Ranges below cover the four CPUs, not confidence intervals. A ratio below 1
means faster than the same host/CPU baseline; 0.95 was the required maximum.

| Host | Baseline elapsed ms | Ordered merge / baseline | Ordered range / baseline |
|---|---:|---:|---:|
| AMD EPYC 7763 64-Core Processor | 334.13–350.74 | 0.9688–0.9749 | 0.9713–0.9826 |
| Neoverse-N2 | 442.27–464.64 | 1.0035–1.0164 | 1.0121–1.0135 |

AMD64 improves only about 2.5–3.1% for ordered merge and 1.7–2.9% for
ordered range. ARM64 slows down about 0.4–1.6% and 1.2–1.3%, respectively.
The map copy controls are stable on both hosts; neither candidate reaches 5%.

AMD64 also has inconclusive loop CPU-time and string timing cells because the
identical copy drifts beyond 3%. Those cells stay failed, not discarded or
reinterpreted as compiler changes. ARM64 copy controls pass throughout.

The AMD64 host here is EPYC 7763, different from the EPYC 9V45 checked-peer
baseline. Do not compare those absolute times as a revision speedup.

## Code and stack costs

| Host | Map instruction bytes: baseline / merge / range | Sort frame bytes: baseline / merge / range |
|---|---:|---:|
| AMD EPYC 7763 64-Core Processor | 14306 / 14354 / 14434 | 64 / 80 / 80 |
| Neoverse-N2 | 13612 / 13660 / 13724 | 64 / 80 / 80 |

Stack sizes describe one generated function frame, not peak recursive stack.
Allocation/RSS changes were not measured for these candidates; they change
comparison/control flow and retain the existing scratch allocations. They are
not part of the runtime repair in [list-copy cleanup](list-copy-cleanup.md).
No optimization rule or general C/Rust parity claim follows from this experiment.
