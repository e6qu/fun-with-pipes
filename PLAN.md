# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; reserve ARC for
necessary sharing. GC is removed; JIT and backward compatibility are excluded.

## Current batch: complete the benchmark driver comparison

[PR #246](docs/roadmap-history.md#array-preparation-diagnostic-pr-246) is verified
and merged. Its preparation experiment changes faults and early timings without
resolving the original consumption limits. The separate
[three-driver comparison](docs/measurements/array-observations-2026-11-02/README.md)
is implemented and fully audited; deliver its tools, evidence and documentation
as the next substantial PR. No production compiler/runtime change is selected.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Freeze original, observation-only and zero-preparation drivers | Exact retained sources; unchanged numerical work; no preparation code in observation-only driver |
| 2 | Prove every version before timing | Exact outputs, ownership profiles, actual omitted-array-destruction controls and failed clocks on both GCC architectures |
| 3 | Collect and independently audit four native sessions | All raw samples, commands, source/binary identities, copies, memory and stack costs retained; every rejected host preserved |
| 4 | Explain driver effects and preserve failed goals | Complete 96-role table; distinguish consumption from total work; keep all original limits and 13 new small-AMD64 copy failures open |
| 5 | Deliver the combined tools/evidence/docs batch | One PR; all nine exact-head production jobs and documentation pass, all logs audited, then verified one-line squash merge |

Steps 1–4 are verified. Added observations alone retain the early large-AMD64
pattern. The complete zero-preparation driver changes it, but raises total timed
work by 7.7–9.8%. Close this diagnostic without hidden warming or an ownership
change. Keep the entire driver fixed in future candidate/reference comparisons;
report construction, consumption and enclosing work together.

After this delivery, return to a source-level allocation opportunity in derivative
work, described below. Do not extend the driver investigation merely to chase a
passing old timing limit. Matrix timing needs a separately declared experiment.

## Open performance goals

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

## Next compiler investigation: temporary derivative lists

The [record-fold work](docs/measurements/derivative-record-folds.md) removes boxes
between addition callbacks. Its adjacent-pair results still form a list before
summation. Preserve that order: ordinary map/fold fusion could interleave recording
and addition, changing effects and derivatives.

Investigate one narrower boundary: a known mapper returns a flat numeric record,
and only a following known fold uses the mapped list. A private packed temporary
buffer could retain all mapped values without a separate record/list allocation
for each element, while still finishing every map call before any fold call.

- The [fresh baseline and candidate requirements](docs/measurements/derivative-temporary-storage-2026-11-02/README.md)
  verify all six inputs, both forms, GCC O1/O2 and workspace modes on native
  ARM64/AMD64. All 96 observations agree. The largest solve still creates 25,472
  pair-result records; its final fold creates only 199 accumulator records.
  These current source/count facts justify the temporary-storage candidate.
- Prove the intermediate list does not escape, has no observable aliases, and
  contains only immediate numeric fields. Keep dynamic callbacks, resource-bearing
  records and escaping/shared lists outside the initial selection.
- Before compiler edits, freeze the selection, expected counts, timing limits and
  storage accounting. Include any length traversal, capacity growth, raw-buffer
  requests and stack/code costs; moving allocations to an uncounted buffer is no
  saving. If current code already removes the boundary, record that result.
- Preserve map-before-fold order, seed evaluation, callback counts, arithmetic,
  traps and effects. Verify empty inputs, aliases, callback failure/cancellation,
  allocation failure and physical buffer release with deliberate broken controls.
- Only after correctness/count checks pass, run the declared paired timings with
  unchanged drivers and original cases. Report all regressions and copy failures;
  fewer allocations alone do not complete D2 or prove C/Rust parity.

This names a candidate to prove, not an implemented optimization or a promise to
eliminate arbitrary lists. Bundle its source analysis, any justified implementation,
regression controls and measured results into one PR after the current delivery.

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
