# Next candidate: keep each tape operation's fields together

The shared-scope change removes most tape lookups but misses thirty of 32
5% speed targets across ARM64 and AMD64. The next candidate is a **storage-layout experiment**, not
another lookup shortcut. It has not been implemented or measured.

## Why this candidate

Saved observations place most instrumented derivative time for 129
coordinates / 199 updates in recording and reverse traversal:

| Current-result case | Session / CPU | Recording share | Reverse traversal share | Instrumented / ordinary process time |
|---|---:|---:|---:|---:|
| 129 / 199 | ARM1 / N2 | 56.97% | 37.19% | 1.0339 |
| 129 / 199 | ARM2 / N2 | 56.99% | 37.27% | 1.0207 |
| 129 / 199 | AMD1 / 9V45 | 55.23% | 38.42% | 0.9787 |
| 129 / 199 | AMD2 / 7763 | 59.95% | 33.61% | 1.0042 |
| 3 / 1999 | ARM1 / N2 | 27.56% | 16.16% | 1.4894 |
| 3 / 1999 | ARM2 / N2 | 27.15% | 16.04% | 1.4224 |
| 3 / 1999 | AMD1 / 9V45 | 23.75% | 17.25% | 1.5738 |
| 3 / 1999 | AMD2 / 7763 | 25.47% | 14.26% | 1.2034 |

Source: [ARM reports](recording-context-time-2026-11-06/run-42224669329/summary/index.json)
and [AMD reports](recording-context-time-2026-11-06/run-42251223529/summary/index.json),
candidate `fwp-ad`, `phaseObservations`. Each phase value is the median of twelve
measured diagnostic processes. A share divides that median by the sum of the six
phase medians. The last column is the separately retained ratio of diagnostic
and ordinary process medians. These are **shares of instrumented derivative
phases**, not the full program's CPU time. Startup, printing and other work lie
outside them. Small-case instrumentation adds 20–57%, so it cannot establish a
small-case bottleneck. The AMD1 large diagnostic runs about 2.1% faster than its
ordinary copy: these diagnostics are perturbations, not an exact additive model
of runtime cost. Nothing here proves cache misses or explains a slowdown.

## Current storage and proposed change

A tape operation stores two parent node indices and two local derivatives
(weights). For `z = x * y`, the weights are `y` for parent `x`, then `x` for
parent `y`. The backward pass applies those contributions in that order.

The [runtime](../../runtime/fwp_rt_kernel.c) currently keeps four columns:

```text
parent allocation:  [first parent for every operation][second parent for every operation]
weight allocation:  [first weight for every operation][second weight for every operation]
```

Appending writes all four columns. Backward traversal reads all four columns.
Growing capacity moves the second half of each allocation to a new offset.
Investigate one contiguous record per plain numeric operation instead:

```text
[parent 1, parent 2, weight 1, weight 2] [next operation ...]
       two I32 indices, two F64 weights: 24 payload bytes
```

The payload remains 24 bytes per operation. Potential benefits are fewer
independent buffer addresses, one allocation instead of two, and removal of
the two column-shifting moves during growth. These are hypotheses to test;
the bounded workspace already reuses buffers across many updates, so allocation
savings alone cannot establish faster long solves. Contiguous columns may also
benefit some access patterns; do not assume the record layout wins.

## Required design and verification before implementation

- Preserve node IDs, parent checks, exact weight bits, append order and backward
  multiplication/addition order. Combining equal parents or reassociating weights
  would change floating-point results and is outside this experiment.
- Preserve the separate ownership of F128/nested weights and callbacks. Define
  their parent storage explicitly; do not give each typed node unused F64 fields.
- Account for alignment, 32-bit size overflow, capacity limits, moving growth,
  partially completed typed growth, failure/cancellation, detached backward
  storage and the bounded workspace. A 24-byte allocation needs its own checked
  byte-size calculation; the old two-allocation bound cannot simply be reused.
- Freeze the exact source reference and expected allocation/storage changes.
  Require observed record size/alignment and physical cleanup on supported native
  targets and WebAssembly. No previous executable or compatibility adapter.
- Keep representative inputs and arithmetic fixed. After the whole layout change
  passes focused ownership/numeric checks, measure runtime, allocations, peaks,
  stack and compiler cost together once. Retain all failed speed/copy limits.

Complete [the current verification group](../../PLAN.md) before freezing this
experiment. All four sessions locate substantial large-case work in recording
and reverse traversal, but they do not prove that layout causes its cost.
This note selects a concrete source
investigation; it is not an accepted speedup or a substitute for that verification.
