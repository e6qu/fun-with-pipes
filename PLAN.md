# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current work: private derivative inputs in one buffer

For inputs `[-1.2, 1.0, -1.2]`, a neighboring-pair objective reads the first two
values, then the last two. During differentiation each value also carries a
numeric tape ID. The middle record must stay available for both reads.

```text
Separate record boxes and list cells → one private numeric buffer
Finish input records → finish neighboring-pair results → fold results
```

The compiler exposes a known objective inside its existing derivative scope,
then proves that its private input records have only those two overlapping
views. It keeps immutable public lists and all three eager stages. Additional
uses, escapes, resource anchors and branch-crossing aliases exclude packing.
The [contract](docs/measurements/packed-derivative-inputs.md) fixes selection,
ownership, references and limits; the [pipeline](docs/compiler-pipeline.md)
explains the order. Coordinate-list reuse remains unselected.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Define scoped specialization and private storage | Freeze exact types, body/work limits, two-window use proof, owner lifetimes and same-source reference before implementation. |
| 2 | Verify the complete compiler and cleanup | GCC ARM64/AMD64 and Clang ARM64, O1/O2, both interpreters, one/two fields, float bits, aliases, bounds, traps, cancellation, physical frees, count checks and deliberately broken observers. |
| 3 | Measure the grouped change | Verify predicted input savings of 2N requests / 40N bytes; no added ARC or peak managed storage; unchanged raw tape profiles; zero final storage. At least 5% faster for ≥199 updates, no case >2% slower, copy variation ≤2%, compiler time/RSS growth ≤5%, frame growth ≤128 bytes. Retain every outcome. |
| 4 | Deliver the grouped PR | Keep code, controls, documentation and evidence together. Pass nine exact-head production jobs plus docs, audit every full/target log, then squash and verify tree/message. |

Step 1 is frozen at `cc425aba`; the subsequent binding proof at `3ccc9bf2`
precedes its implementation. [Step 2 passes on all three hosts](docs/measurements/packed-input-checks-2026-11-04/README.md):
277 units, 93 integrations and 34 new native controls per host, with all logs
and image identities audited. Earlier failures remain retained.
Before step 3, corrected compiler-cost fixtures must pass untimed checks for
actual live calls; the old fixtures compiled but did not exercise their intended
workload. No performance measurements have started. The
[handoff](docs/development-state.md) records exact sources, jobs and next actions.

[PR #256 is verified delivery](docs/roadmap-history.md#matched-optional-results-pr-256):
immediately matched list results avoid a temporary option box. Each measured
history solve saves one request, 16 bytes and one retain; peak storage is unchanged.
Some larger cases are up to 1.95% slower within that group's frozen 2% limit.
This is not a general speedup and does not settle older comparisons below.

## Open performance goals

- **Final-iteration compiler cost.** [The completed compiler comparison](docs/measurements/final-iteration-analysis-2026-11-04/README.md)
  passes nine timing cases and all observed memory limits. AMD64 field-owner
  transfer has 2.043% identical-copy variation against 2%, so that timing case
  remains inconclusive. Preserve its samples and failure. Declare any further
  sample/setup diagnostic before changing the protocol; do not repeat unchanged
  timings for a pass.

- **Final-iteration runtime.** [Four completed sessions](docs/measurements/final-iteration-time-2026-11-04/README.md)
  miss 5% on 3/199 history in both ARM64 sessions, and on 33/199 history in both
  ARM64 sessions and AMD64 session 1. AMD64 session 2's 3/1 history is 2.79%
  slower against a 2% limit. Preserve all six misses and the verified memory/ARC
  reductions. Diagnose the small-case source and saved sample progression before
  selecting another change; do not rerun unchanged timings or infer a safety
  failure from the timing ratio. All raw audits and identical-copy controls pass.

- **Identity array-map speed.** [Four completed sessions](docs/measurements/scalar-array-identity-time-2026-11-03/README.md)
  miss every required 5% gain on 3/199, 3/1999, 33/199 and 129/199, in both forms.
  Noise and zero/one-update regression limits pass. Keep all 32 speed misses open;
  the allocation reduction does not satisfy them. Select further work from the
  remaining storage costs and their lifetime proofs, not repeated timings.

- **Direct scalar array calls.** [The complete report](docs/measurements/direct-array-time-2026-11-03/README.md)
  retains 16 missed 5% gains: both 3/199 forms and 3/1999 current on all sessions,
  plus 3/1999 history and 129/199 history on ARM64. AMD64 session 2's 3/1 current
  has 3.53% identical-copy variation against 2%, making that case inconclusive.
  Keep these outcomes open; declare a source/sample diagnostic before changing
  the measurement or selecting another optimization. Larger-case gains do not
  close older comparisons with different references.

- **Gradient-array speed.** [Completed observations](docs/measurements/gradient-array-time-2026-11-03/README.md)
  miss every required 5% gain. Larger ARM64 cases improve by about 3–4%; AMD64
  gains are smaller, and small repeated updates slow down by roughly 1–2%.
  Merged PR #253 tested one avoidable callback cost. Keep the original
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
