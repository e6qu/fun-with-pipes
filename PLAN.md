# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current work: direct calls in scalar array maps

[PR #252](https://github.com/e6qu/fun-with-pipes/pull/252) merged with all nine
production jobs and documentation passing; every full and target log is audited.
It keeps private gradients in arrays. The largest solve saves 25,472 allocation
requests and 409,144 requested bytes, but all 32 required 5% speed gains remain
open. [Delivery and measurements](docs/roadmap-history.md#private-gradient-arrays-pr-252)
retain the exact sources, counts and timing misses.

The current grouped change removes generic function dispatch from selected
`array.map` calls. For example, `array.map scale` can call the known scalar
function `scale` directly for each element. It still allocates an independent
result array and preserves input aliases, effects, traps and cancellation.
This is an experiment, not an established explanation of earlier timing misses.

The [contract](docs/measurements/direct-array-callbacks.md) was frozen before code
changes. [Focused native verification](docs/measurements/direct-array-callbacks-2026-11-03/README.md)
passes on all three hosts. [Compiler costs](docs/measurements/direct-array-analysis-2026-11-03/README.md)
pass. Both ARM64 runtime sessions completed with five speed-target misses each;
the raw audit is running. AMD64 has no qualified measurement yet. [The failure record](docs/measurements/direct-array-callbacks-2026-11-03/README.md)
retains both repaired verification failures. Runtime measurements are in progress;
keep host rejections and every measured outcome.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Declare the direct-call experiment | Freeze selection, ownership rules and limits before implementation. Keep storage layouts and other optimizations unchanged. |
| 2 | Verify implementation and cleanup | GCC ARM64/AMD64 and Clang ARM64 pass O1/O2 comparisons with both interpreters, rejected cases, aliases/slices, eager order, allocation failure and cancellation. Audit selected direct calls and deliberately broken cleanup controls. |
| 3 | Measure the isolated change | Freeze a same-source reference disabling only direct scalar array-map selection. Audit compiler time/RSS, four qualified runtime sessions, every count, native image and failed limit. No allocation/ARC/live-storage increase; preserve timing, copy and stack limits. |
| 4 | Deliver the grouped PR | Publish one follow-up PR with implementation, repairs, evidence and current docs. Run the final nine production jobs plus docs, audit all logs, then verify the one-line squash and tested-tree equality. |

[History](docs/roadmap-history.md) and the linked reports preserve completed
storage changes and their source identities. Do not repeat completed timings for
a better result. Keep verified work reductions separate from unfulfilled speed
goals. [The remaining-storage review](docs/measurements/remaining-gradient-storage.md)
records the input/output ownership constraints and an unused-history candidate.
These changes remain unselected.

## Open performance goals

- **Gradient-array speed.** [Completed observations](docs/measurements/gradient-array-time-2026-11-03/README.md)
  miss every required 5% gain. Larger ARM64 cases improve by about 3–4%; AMD64
  gains are smaller, and small repeated updates slow down by roughly 1–2%.
  The direct-call experiment above tests one avoidable cost. Keep the original
  misses open until qualified evidence meets their limits; fewer allocations do
  not establish less elapsed time or whole-process memory use.

- **Private range consumption.** ARM64 misses the 5% target on 3/199 current
  in both sessions and history in session 1. AMD64 misses it on 3/199 and 3/1999
  history in both sessions. Those improvements are 3.97–4.98%.
  [Complete results](docs/measurements/range-zip-time-2026-11-03/README.md) retain
  every miss; all four raw audits are complete. Preserve verified reductions
  while leaving these goals open. Merged PR #252 implements the gradient-list group
  from the [remaining allocation sites](docs/measurements/range-zip-storage-2026-11-03/README.md#remaining-allocation-sites).
  Other storage groups still need separate lifetime proofs and measured costs
  before selection.

- **Scalar-buffer timings.** Both completed ARM64 sessions report a 3.32%
  zero-update current-only slowdown against the 2% limit; several small cases
  improve by less than the required 5%. [Complete results](docs/measurements/scalar-map-zip-time-2026-11-03/README.md)
  retain these failures. Saved C changes only the positive-update branch; no added zero-branch work
  was identified. Further source/driver diagnosis is needed before attributing
  a cause or selecting a correction. All four raw audits pass; both AMD64 sessions also miss four small-case
  speed goals. Allocation savings and passing compiler costs do not close this goal.

- **Callback-owner timings.** [The complete report](docs/measurements/callback-owners-2026-11-03/README.md)
  retains every outcome. Both architectures miss 5% on 3/199 and 3/1999 in both
  forms; AMD64 33/199 current also misses it. AMD64 3/1999 copy variation is
  2.12–2.21%, so that comparison is inconclusive. Keep the verified count
  reductions and larger-case speed gains, following the accepted policy; do not
  relabel missed limits as passed. Diagnose remaining allocation/work costs and
  the noisy case from saved phase/sample evidence before choosing another change.

- **AMD64 array consumption.** The original large-array copy controls pass,
  but consumption is 4.93–5.23% slower; small-array copy limits also fail.
  [Sample analysis](docs/measurements/array-sample-positions.md) and the
  [completed preparation diagnostic](docs/measurements/array-consumption-2026-11-02/README.md)
  preserve those failures. The [driver comparison](docs/measurements/array-observations-2026-11-02/README.md)
  separates observation changes from the complete preparation-capable driver. It
  justifies no ownership change and does not resolve original timing acceptance.
  Keep the entire driver fixed for future candidate/reference comparisons and
  report construction, consumption and enclosing work together.
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
