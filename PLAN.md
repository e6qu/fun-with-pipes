# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: explain early numerical timing differences

[PR #245](docs/roadmap-history.md#direct-numeric-array-callbacks-pr-245) is verified
and merged. Direct numeric array callbacks reduce qualified ARM64 construction
time by 84.5–84.9%, with unchanged managed storage. AMD64's original consumption
and copy limits remain open. [PR #244](docs/roadmap-history.md#paired-matrix-columns-pr-244)
also leaves small-AMD64 matrix copy limits open.

The [retained samples](docs/measurements/array-sample-positions.md) locate much of
the array difference in early process samples. The next question is whether
identical preparation changes that pattern. This is a diagnostic, not a promise
that warming a process fixes production performance.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Analyze every retained array sample | Replay all four baseline and candidate sessions, keep each position and within-process differences, preserve original failures |
| 2 | Prove preparation and observation code | Frozen protocol; unchanged numerical work; exact outputs, caller ownership, zero retained storage, omitted-release and failed-clock controls on both GCC architectures |
| 3 | Run the declared four sessions | Qualified hosts; explicit 0/1,024 preparation counts; balanced process order; every sample, wall/CPU time, faults/switches, storage, RSS, code and stack costs retained and independently audited |
| 4 | Explain the findings and choose a bounded next action | Compare all settings/copies without dropping early samples; distinguish an observed preparation effect from a CPU/cache explanation; preserve original timing limits and state what remains unproven |
| 5 | Deliver the combined diagnostic batch | Include tools, regression controls, findings and updated plan; all nine final-head production jobs and documentation pass and their logs are audited before squash merge |

Use the [declared diagnostic](docs/measurements/array-consumption-setup.md).
Reuse audited generated C; no compiler rebuild is needed for these measurements.
Fix all harness/native-control failures before timing. Do not repeat a completed
noisy measurement for a pass or change runtime ownership without a demonstrated
source-level need. [All four results](docs/measurements/array-consumption-2026-11-02/README.md)
are now audited: preparation shifts page-fault work outside timing and narrows
some copy differences, but does not resolve the original consumption regression.
Next, freeze the [three-driver comparison](docs/measurements/array-observation-boundaries.md)
to separate observation changes from the complete preparation-capable driver. Do not add
hidden warming or change runtime ownership. Apply a related matrix investigation
only after declaring its scope.

## Open performance goals

- **AMD64 array consumption.** The original large-array copy controls pass,
  but consumption is 4.93–5.23% slower; small-array copy limits also fail.
  [Sample analysis](docs/measurements/array-sample-positions.md) and the
  [completed preparation diagnostic](docs/measurements/array-consumption-2026-11-02/README.md)
  preserve those failures. Separate observer and preparation-call effects next,
  using the bounded comparison above; do not infer a source safety bug from time.
- [Small AMD64 matrix timing](docs/measurements/matrix-columns-2026-11-02/README.md):
  six identical-copy failures remain at 2.6–8.3% against the frozen 2% limit.
  [Retained-sample analysis](docs/measurements/matrix-sample-positions.md) locates
  much of the mismatch in early within-process samples, without establishing its
  cause. Declare a setup/sample-progression diagnostic before changing the timing
  protocol. Do not repeat unchanged timings or
  infer a runtime safety bug from these timing differences. ARM64 and large AMD64
  gains do not settle this separate case.
- [D2 derivative speed](docs/measurements/descent-costs.md): original 5% limits
  remain open. Typed-owner count reductions do not settle the ordinary F64
  Rosenbrock timings. The array-to-list change's AMD64 copy control also remains
  inconclusive; do not repeat unchanged noisy runs for a pass.
- [N1/N2 numerical kernels](docs/measurements/kernel-baselines.md): preserve
  qualified-host, arithmetic-order and identical-copy requirements. Diagnose
  measurement resolution before accepting an optimization on those cases.
- [Closure construction](docs/measurements/callable-phases.md): retain the original
  Xeon regressions; another CPU does not settle them. Freeze qualified work counts
  before selecting a new candidate.
- Broader ARC minimization needs specific escaping/alias boundaries and measured
  costs. There is no goal of count-free arbitrary sharing, universal stack storage
  or automatic reclamation of all owning cycles.
- [Swift comparisons](docs/measurements/swift-allocations.md) measure allocator
  traffic and selected fwp-managed storage separately. Individual Swift ARC
  operations remain unmeasured. Do not infer them from RSS or elapsed time.

## Maintained guarantees and evidence

GC removal, scoped A1–A6 ARC reductions, F1–F3 call/recursion coverage, decimal-count
improvements, D3 derivative accuracy and #236's selected transformations are
verified deliveries. [Ownership](docs/ownership.md), [functional costs](docs/functional-costs.md)
and [history](docs/roadmap-history.md) record their scope. Keep their failure,
cancellation, reuse, application and binary checks as current regression coverage.

The [intermittent Intel compiler abort](docs/measurements/compiler-abort.md) has
no established root cause. Preserve its evidence and diagnose a recurrence from
its input/source path. Passing reruns are not a repair, and speculative
disassembly-led allocator changes are not justified.
