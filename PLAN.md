# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current work: preserve float bits and remove redundant array copies

[PR #254](https://github.com/e6qu/fun-with-pipes/pull/254) implements same-type
float conversion that preserves every bit, including signed zero and NaN payloads,
for F16, BF16, F32, F64 and F128. Cross-type conversion stays unchanged; generic
F128 results keep separate ownership.

A known `float.convert : F64 -> F64` map can transfer its input array's owner
instead of copying it. The rewrite checks existing concrete types before ownership
insertion and evaluates the array expression once. It adds no syntax or
whole-program analysis. [The contract](docs/measurements/scalar-array-identities.md)
was frozen before implementation.

- [Three-host native checks](docs/measurements/scalar-array-identities-2026-11-03/README.md)
  pass for exact bits, moves, aliases, slices, updates, traps and cancellation.
  Final platform CI must also verify the expanded storage probe and distinct
  BF16 NaN inputs; the frozen results retain their actual coverage.
- [All four runtime sessions](docs/measurements/scalar-array-identity-time-2026-11-03/README.md)
  and raw audits are complete. One array allocation is removed per selected update;
  the largest solve requests 206,960 fewer bytes. ARC counts and peak managed/raw
  storage are unchanged. All 32 required 5% speed gains are missed.
- [Compiler-time/memory limits](docs/measurements/scalar-array-identity-analysis-2026-11-03/README.md)
  pass. Both sides of the runtime comparison contain the scalar repair; the
  reference disables only map removal. No completed session was repeated.
- Returning a small slice can retain its larger backing array longer. The
  [storage probe](docs/measurements/scalar-array-identities-2026-11-03/README.md#result-lifetime-and-allocation-traffic)
  measures that tradeoff separately from requested bytes and process RSS.

Under the accepted policy, retain the verified reductions while leaving missed
speed goals open. [The handoff](docs/development-state.md) tracks final gates.
PR #253's verified merge and evidence are in [delivery history](docs/roadmap-history.md#direct-scalar-array-calls-pr-253).

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Define conversion and selection rules | Preserve same-type bits in all five formats; keep cross-type behavior and independently owned F128 boxes. Freeze the exact F64 map selection and measurements. |
| 2 | Verify owner transfer and observable behavior | Three native hosts pass O1/O2 checks, packed/reuse controls, source effects, alias updates, failure/cancellation and deliberately omitted cleanup. Retain emitted C and native image evidence. |
| 3 | Measure the isolated change | Remove at least one array allocation per selected update. Report traffic, ARC, live/raw memory, process RSS, timing, code and stack costs. Audit every frozen timing/noise, count, compiler-cost and stack limit; keep all missed speed targets open under the accepted policy. |
| 4 | Deliver one grouped PR | Include scalar fixes, map removal, storage observations, complete measurements and clear docs. Verify the expanded probes across supported native platforms; require all nine final-head production jobs plus documentation; audit all logs, squash and verify the tested tree. |

Keep older timing goals open against their original references. Do not repeat
completed sessions for a better result. [Remaining storage candidates](docs/measurements/remaining-gradient-storage.md)
include input records, coordinate lists and an unused iteration history. The
next section selects the history group; the representation candidates remain unselected.

## Next group: final list values without retained histories

The [frozen implementation contract](docs/measurements/final-iteration-storage.md)
groups four related changes. [The source review](docs/measurements/final-iteration-storage-2026-11-03/README.md)
confirms the actual gradient program's iteration, reverse copy and final-item read.
PR #254's Windows probe repair is awaiting its new final-head gates. Keep that
head intact while they run; open the next delivery PR only after its verified merge.
The changes below pass the grouped focused checks on Linux ARM64/AMD64 and macOS
ARM64 at `bb5433b6`. Compiler/runtime measurements use the immutable tag
`roadmap/final-iteration-measurement-2026-11-04`. All four runtime sessions and
their raw audits are complete: the largest history solve uses 97.7% less peak
managed storage and takes 5.1–5.9% less time. Five speed targets, one small-case
regression and one compiler timing control remain open. The final delivery matrix
is still required. The scalar control removes 2k list nodes and one temporary
pointer buffer; the complete-program report records its own net allocation costs.

| Task | Required result |
|---|---|
| Direct `last` | Borrow the list and return its final item in an owned option, without a reverse copy; preserve every supported element type. |
| Remove unused iteration histories | Select exact typed, single-use `iterate` → `last` calls for numeric states and numeric lists/arrays; transfer the current owner through unchanged callback order. Retained/shared histories remain intact. |
| Repair boundary failures | Match interpreter/native oversized-count rejection before callbacks; release a newly allocated optional wrapper if retaining its child fails. |
| Verify and measure together | Check aliases, effects, resource exclusions, wide numbers, cancellation and physical release. Require 2k fewer list-node allocations in the scalar control and ≥80% less peak managed storage for the large history solve; keep separate timing/compiler/stack limits. |
| Deliver | Update examples, contracts and benchmark explanations; audit all final-head native/benchmark/documentation gates before one squash merge. |

Input derivative-record packing and coordinate-list reuse remain unselected.
This group changes neither representation. Older timing goals remain open.
After delivery, complete the [matched-option ownership proof](docs/measurements/remaining-gradient-storage.md#follow-up-an-immediately-matched-optional-result):
saved C shows an allocated result wrapper that the caller immediately unpacks.
Use the existing field-return machinery for the proof, then freeze the selection
and comparison before implementing it. This is not a proven cause of the timing miss.

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
