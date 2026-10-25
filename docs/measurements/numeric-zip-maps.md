# Mapping numeric pairs without building a temporary zip

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

**Comparison:** identical fwp programs with `FWP_ZIP_MAP=0` versus `1`, in tracing
and ARC. `xs | zip ys | map f` stops at the shorter list. For known numeric
callbacks, the optimized path avoids intermediate pairs and zip list nodes.

**Work:** 128 lists of 4,096 products `x * (x + 1)`, kept before summing;
512 derivatives over 4,096 inputs; and a twice-differentiated square over 256
inputs. **Method:** `-O2 -ffp-contract=off`, one warmup, eight alternating
whole-process samples. Startup, inputs and output are included; compilation and
profiles are separate. Other fusion and workspace reuse remain enabled.

[Four-host results](zip-maps-2026-10-16.json):

| Workload | Managed requests, disabled → enabled | Retains, disabled → enabled | Peak charged bytes, disabled → enabled |
|---|---:|---:|---:|
| Direct products | 2,106,373 → 1,057,669 | 524,672 → 384 | 17,208,584 → 17,077,512 |
| Repeated derivative | 23,087,625 → 18,892,809 | 10,492,416 → 8,395,264 | 840,888 → 840,888 |
| Nested derivative | 4,414 → 3,901 | 2,109 → 1,853 | 60,096 → 60,096 |

The [16-sample repeat](zip-map-cpu-2026-10-16.json) reuses verified
binaries and adds child CPU time. Direct-work CPU ratios are 0.519–0.655 and
derivative ratios 0.788–0.822 (enabled/disabled). ARM macOS nested ARC remains
slightly slower: 1.5805 → 1.6075 ms CPU, with overlapping samples.
Normal traced direct work collects twice in both variants; other cases collect
zero times. Profiles finish with zero managed/tape storage, but derivative peak
memory is unchanged. ARM64 direct products use vector multiply; AMD64 uses
unrolled scalar multiply. This compares fwp transformations, not C/Rust speed.
