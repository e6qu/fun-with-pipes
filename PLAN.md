# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: verify scalar-buffer costs and choose the next storage reduction

[PR #250](docs/roadmap-history.md#temporary-scalar-map-buffers-pr-250) is merged.
Its focused native checks verify 25,870 fewer allocations and 823,064 fewer
requested bytes in the largest solve. Retains and peak managed storage stay
unchanged. The user merged before performance measurements and the full platform
matrix; complete those checks before treating the delivery as fully verified.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Complete the merged implementation's platform validation | Audit all nine jobs in run `41591834975` and docs. Fix every failure in this batch; preserve the original evidence. |
| 2 | Measure scalar-buffer compiler and program costs | Complete the [frozen comparison](docs/measurements/temporary-list-storage.md#execution-of-the-frozen-comparison): five compiler inputs, all six runtime inputs, two native sessions per architecture. Independently audit raw evidence and retain every missed limit. |
| 3 | Freeze direct consumption of a private index range — selected | [Contract](docs/measurements/range-zip-storage.md): evaluate I64 bounds once; one zip consumer, known scalar captures, scalar or flat numeric-record outputs. Expected reduction: `(d+1)*u` requests and `(32*d+8)*u` bytes. Publish the isolated same-source reference before measurement. |
| 4 | Implement, verify and deliver the next substantial batch | Bundle the selected storage change, incidental repairs and reports. Compare unoptimized/ordinary/native behavior, shared/escaping inputs and failure/cancellation/physical-free controls. Measure the isolated change, run all nine final-head production gates plus docs, audit logs and verify the one-line squash. |

Current measurements use retained source `da510f18`, tag
`roadmap/scalar-map-zip-measurement-2026-11-03`; its tree equals merged `a8a5568d`.
No production edit is part of that comparison. Replace only hosts rejected
before measurement; do not rerun completed noisy observations for a pass.
[Focused results and retained failures](docs/measurements/temporary-list-storage-2026-11-03/README.md).

## Open performance goals

- **Scalar-buffer timings.** Both completed ARM64 sessions report a 3.32%
  zero-update current-only slowdown against the 2% limit; several small cases
  improve by less than the required 5%. [Results and running audits](docs/measurements/scalar-map-zip-time-2026-11-03/README.md)
  retain these failures. Inspect the saved zero-update source and driver before
  selecting a correction or attributing a cause. Complete AMD64 and the raw
  audits; allocation savings and passing compiler costs do not close this goal.


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
