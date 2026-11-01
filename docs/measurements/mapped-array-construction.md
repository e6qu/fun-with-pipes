# Building numeric arrays without temporary list nodes

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

**Comparison:** the same fwp compiler with mapped-array combining off/on, in
tracing and ARC modes. `map f | array.from-list` normally builds a result list;
the optimized path stores numeric results directly, preserving callback order.
Known callbacks call directly. There is no C/Rust baseline in this experiment.

**Work and method:** direct work doubles 4,096 F64 elements, builds an array and
sums it, 128 times. The derivative case computes 512 gradients over 4,096 inputs;
a small control differentiates a first-element square twice over 256 inputs.
Builds use `-O2 -ffp-contract=off`, with other fusion and workspace reuse enabled.
After one warmup, eight alternating whole-process samples include startup,
inputs, calculation and output. Compilation and allocation profiles are separate.

The [main report](mapped-arrays-2026-10-16.json) retains both final-code
runs and an earlier indirect-callback implementation. Compare enabled/disabled
within each revision. Counts agree across four Linux/macOS hosts and both modes:

| Workload | Managed requests, disabled → enabled | Retains, both | Peak charged bytes, disabled → enabled |
|---|---:|---:|---:|
| Direct numeric | 532,996 → 8,708 | 256 | 300,312 → 294,920 |
| Repeated derivative | 25,184,777 → 23,087,625 | 10,492,416 | 840,888 → 840,888 |
| Nested derivative | 4,415 → 4,414 | 2,109 | 60,096 → 60,096 |

The two final-code runs roughly halve direct numeric elapsed time; ARC derivative
time falls 6–11%. Intel macOS traced derivatives are 7%, then 2%, slower, with
overlapping ranges. A [16-sample CPU repeat](mapped-array-cpu-2026-10-16.json)
reuses the verified binaries and measures child user+system time alongside elapsed
time. That slowdown does not repeat: traced derivative CPU ratios are 0.904–0.925.
Tiny nested cases remain mixed, including 6.8%/8.9% more CPU on ARM macOS in
tracing/ARC. Earlier slower samples remain in the reports.

Profiles exclude initial constants; final managed/tape storage is zero.
Retains and derivative peak storage do not improve. Actual ARM64/AMD64 binaries
retain vector doubling instructions, but this does not measure cache misses or
prove that every callback is faster.
