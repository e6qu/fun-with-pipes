# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current work: final list values without retained histories

```fwp
0 | iterate 3 (add 1) | last
```

This returns `Some 2`: the count includes initial value 0, followed by two calls
to `add 1`. Ordinary `last` now walks directly to a list's final node. For an exact,
single-use numeric iteration, the compiler keeps only its current value instead
of building a history and reverse copy. Shared histories remain intact; iteration
states containing resources are excluded. No new syntax or global analysis.

The [contract](docs/measurements/final-iteration-storage.md) was frozen before
implementation. The group also aligns interpreter/native oversized-count errors
and protects a new optional wrapper when retaining its borrowed child fails.

- [Three-host native checks](docs/measurements/final-iteration-storage-2026-11-03/README.md)
  pass on GCC ARM64/AMD64 and Clang ARM64: types, values, aliases, effects, callback
  order, resources, cancellation, physical cleanup and actual native images.
- [Four runtime sessions](docs/measurements/final-iteration-time-2026-11-04/README.md)
  and every raw audit are complete at `bb5433b6`, immutable tag
  `roadmap/final-iteration-measurement-2026-11-04`. The largest history solve uses
  97.7% less peak managed storage and runs 5.1–5.9% faster. Each 199-update solve
  saves 400 allocation requests and 399 retains. Raw storage is unchanged.
- Five speed targets and one small-case regression remain open. The
  [compiler comparison](docs/measurements/final-iteration-analysis-2026-11-04/README.md)
  has one noisy timing case; observed memory ratios pass. Keep all failures under
  the accepted policy of retaining verified reductions without claiming timing acceptance.
- The final nine-job production matrix and documentation are still required.
  [The handoff](docs/development-state.md) records the exact head and current gates.
  PR #254's verified merge belongs in [delivery history](docs/roadmap-history.md#float-bits-and-identity-array-maps-pr-254).

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Define selection and ownership | Exact typed `iterate` → `last`, numeric states only, single history use. Preserve public `last` types, argument/callback order and count rejection. Freeze the reference and limits. |
| 2 | Verify behavior and physical cleanup | Three native hosts pass raw/optimized interpreter and O1/O2 checks, alias/reuse controls, wide values, resource exclusions, failure/cancellation and omitted-cleanup controls. Retain C and native image identities. |
| 3 | Measure and record every outcome | Verify the scalar 2k-node saving, large-case managed peak reduction and complete-program ARC/traffic. Audit every timing/noise, compiler and stack limit; leave missed goals explicit. |
| 4 | Deliver the grouped PR | Include ownership repairs, examples and complete evidence. Require all nine final-head production jobs plus docs, audit every full/target log, squash and verify the tested tree and one-line message. |

## Next proof: immediately matched optional results

[Saved C](docs/measurements/remaining-gradient-storage.md#follow-up-an-immediately-matched-optional-result)
shows the new internal primitive allocating `Some(final)` before the caller
immediately unpacks it. This is a remaining boundary cost, not a proven cause of
the small timing regression.

Complete the ownership proof for internal final-iteration results and borrowed
list `last`/`nth` reads using the existing field-return machinery. Preserve empty
results, aliases, callback order, resource lifetimes and failure/cancellation.
Then freeze selection and measurements before implementation: one fewer wrapper
per selected match, no added ARC, correct storage for escaping values, bounded
compiler cost and explicit runtime/stack results. No new syntax or global analysis.

Input derivative-record packing and coordinate-list reuse remain unselected.
[Their lifetime requirements](docs/measurements/remaining-gradient-storage.md)
and older timing goals retain their original evidence and references.

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
