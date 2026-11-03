# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: deliver private index-list removal

[PR #251](https://github.com/e6qu/fun-with-pipes/pull/251) generates private zip
indices directly. The largest verified solve makes 25,870 fewer allocations and
requests 823,064 fewer bytes; retains stay at 995 and managed peak falls from
17,824 to 14,976 bytes. Larger timed solves take 7.1–10.0% less time, while small
cases miss the speed target. Measurements and raw audits are complete; final
platform validation remains. Predecessor #250 is now fully platform-verified.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Merged implementation platform validation complete | All nine jobs in `41591834975` and docs pass on `a8a5568d`; every full/target log is audited. [Gate records](docs/measurements/temporary-list-storage-2026-11-03/platforms/final-gates.json). |
| 2 | Scalar-buffer measurements complete; timing goals open | All 480 compiler commands and four runtime sessions are independently audited. Compiler limits pass; small-case speed requirements and ARM64 zero-update regression limits fail. [Complete results](docs/measurements/scalar-map-zip-time-2026-11-03/README.md) retain every outcome. |
| 3 | Direct consumption of a private index range — contract frozen | [Contract](docs/measurements/range-zip-storage.md): evaluate I64 bounds once; one zip consumer, known scalar captures, scalar or flat numeric-record outputs. Expected reduction: `(d+1)*u` requests and `(32*d+8)*u` bytes. Contract tag `roadmap/range-zip-protocol-2026-11-03` predates implementation. The isolated same-source reference is published and has passing controls. |
| 4 | Implement, verify and deliver the next substantial batch | Corrected GCC/Clang semantics, cleanup and all 96 count observations pass at `3be9479c`. [Evidence](docs/measurements/range-zip-storage-2026-11-03/README.md). All four runtime sessions and raw audits are complete, with small-case timing goals open. Run all nine final-head production jobs plus docs, audit logs and verify the one-line squash. |

The range comparison is frozen at `3be9479c`, tag
`roadmap/range-zip-measurement-2026-11-03`; the completed scalar-buffer comparison
remains at `da510f18`, tag `roadmap/scalar-map-zip-measurement-2026-11-03`.
Both use an isolated same-source reference. No completed timing is repeated for
a better result. [Range results and retained failures](docs/measurements/range-zip-storage-2026-11-03/README.md).

## Open performance goals

- **Private range consumption.** ARM64 misses the 5% target on 3/199 current
  in both sessions and history in session 1. AMD64 misses it on 3/199 and 3/1999
  history in both sessions. Those improvements are 3.97–4.98%.
  [Complete results](docs/measurements/range-zip-time-2026-11-03/README.md) retain
  every miss; all four raw audits are complete. Preserve verified reductions
  while leaving these goals open. Select further work from the
  [remaining allocation sites](docs/measurements/range-zip-storage-2026-11-03/README.md#remaining-allocation-sites)
  after the current delivery; prove the selected lifetime boundary before editing.

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
