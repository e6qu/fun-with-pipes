# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current work: finish range delivery, then remove gradient-list storage

[PR #251](https://github.com/e6qu/fun-with-pipes/pull/251) generates private zip
indices directly. The largest verified solve saves 25,870 allocation requests
and 823,064 requested bytes; larger timed solves take 7.1–10.0% less time.
Small-case speed goals remain open. Documentation, benchmarks and both macOS ARM64 jobs pass on its final head;
six native platform jobs are still running. Keep that head fixed.

The next grouped batch keeps private gradient results in owned arrays and reads
those arrays directly during the following map/zip. The
[implementation contract](docs/measurements/gradient-array-storage.md) defines
scope cleanup, typed/nested derivatives, selection limits and measurement budgets.
The implementation is in progress, with focused native compiler checks next.
No performance gain is claimed yet. Keep one open PR: prepare this batch independently,
then publish it after #251 passes, is audited and is squash-merged.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Finish range-storage delivery | All nine jobs in `41610112980` and docs pass at `cea8debc`; audit every full/target log, squash-merge and verify the one-line message and tree. [Range evidence](docs/measurements/range-zip-storage-2026-11-03/README.md). |
| 2 | Keep internal gradient results in owned arrays | Floating, F128 and nested reverse paths agree in both engines; public list results materialize when needed. Select sole-use numeric array conversions for map/zip before list fusion hides them. Preserve eager order, aliases and scope cleanup. |
| 3 | Verify the grouped storage change | Freeze the contract before edits and the isolated whole-change reference before measurements. GCC/Clang O1/O2 semantic, failure, cancellation, reuse, physical-free and compiler-scaling controls pass. All 96 allocation observations meet the declared net budgets with exact attribution. |
| 4 | Measure and deliver the next substantial PR | Compiler costs and four qualified runtime sessions are independently audited; retain every missed limit. Complete the final nine-job matrix plus docs, audit all logs, and verify the one-line squash. |

The completed range comparison remains frozen at `3be9479c`, tag
`roadmap/range-zip-measurement-2026-11-03`; the scalar-buffer comparison remains at
`da510f18`, tag `roadmap/scalar-map-zip-measurement-2026-11-03`.
[Completed results](docs/measurements/range-zip-storage-2026-11-03/README.md) and
[history](docs/roadmap-history.md) retain source IDs and failed outcomes. Predecessor
#250 passes all nine production jobs and docs, with every log audited.
Do not repeat completed timings for a better result.

## Open performance goals

- **Private range consumption.** ARM64 misses the 5% target on 3/199 current
  in both sessions and history in session 1. AMD64 misses it on 3/199 and 3/1999
  history in both sessions. Those improvements are 3.97–4.98%.
  [Complete results](docs/measurements/range-zip-time-2026-11-03/README.md) retain
  every miss; all four raw audits are complete. Preserve verified reductions
  while leaving these goals open. The next batch selects the gradient-list group
  from the
  [remaining allocation sites](docs/measurements/range-zip-storage-2026-11-03/README.md#remaining-allocation-sites)
  for owned-array results and direct consumption. The other groups still need
  separate lifetime proofs before selection.

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
