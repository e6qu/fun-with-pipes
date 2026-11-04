# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use automatic
reference counting (ARC) only for necessary sharing. Tracing garbage collection
has been removed. JIT compilation and backward compatibility are excluded.

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
explains the order. Coordinate-list reuse is the separate next group below.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Define scoped specialization and private storage | Freeze exact types, body/work limits, two-window use proof, owner lifetimes and same-source reference before implementation. |
| 2 | Verify the complete compiler and cleanup | GCC ARM64/AMD64 and Clang ARM64, O1/O2, both interpreters, one/two fields, float bits, aliases, bounds, traps, cancellation, physical frees, count checks and deliberately broken observers. |
| 3 | Measure the grouped change | Audit predicted input savings of 2N requests / 40N bytes, ownership counts, raw storage, timing, compiler costs and stack growth against the frozen limits. Preserve every outcome; accepted reductions may ship with missed timing goals explicitly open. |
| 4 | Deliver the grouped PR | Keep code, controls, documentation and evidence together. Pass nine exact-head production jobs plus docs, audit every full/target log, then squash and verify tree/message. |

Step 1 is frozen at `cc425aba`; the subsequent binding proof at `3ccc9bf2`
precedes its implementation. [Step 2 passes on all three hosts](docs/measurements/packed-input-checks-2026-11-04/README.md):
277 units, 93 integrations and 34 new native controls per host, with all logs
and image identities audited. Earlier failures remain retained.
Step 3's [compiler comparison passes](docs/measurements/packed-input-analysis-2026-11-04/README.md)
on both architectures, including corrected live-work checks. The largest compiler
time increase is 4.32%; peak RSS grows at most 0.82%, both within 5%.
[Runtime audits also pass](docs/measurements/packed-input-time-2026-11-04/README.md):
the largest solve saves 51,541 requests and 597 retains; peak managed storage
falls from 19,360 to 15,232 bytes. Qualified longer solves take 14.5–23.1% less
time. Three AMD64 timing limits remain unmet, below. Step 4 still requires final
production gates and delivery. The
[handoff](docs/development-state.md) records exact sources, jobs and next actions.

[PR #256 is verified delivery](docs/roadmap-history.md#matched-optional-results-pr-256):
immediately matched list results avoid a temporary option box. Each measured
history solve saves one request, 16 bytes and one retain; peak storage is unchanged.
Some larger cases are up to 1.95% slower within that group's frozen 2% limit.
This is not a general speedup and does not settle older comparisons below.

## Next group: consumed numeric storage

Prepare [numeric array and coordinate-list reuse](docs/measurements/owned-numeric-updates.md)
on a separate branch while #257's final gates run. Keep one active delivery PR.
Both operations transfer an input owner explicitly, reuse only exclusive storage,
and preserve aliases and eager callback order. The contract fixes last-use
selection, shared tails/views, failure cleanup, count predictions and measurement
limits before implementation. Both operations and their focused controls are now
implemented in preparation; native verification and measurements remain pending.

## Open performance goals

Allocation reductions do not establish a speedup or lower process RAM. Preserve
all failed limits and inconclusive results. Do not repeat unchanged timings for
a passing result. A comparison with a new reference does not settle an older one.
Declare the source/workload diagnostic before changing code or measurement setup.
Here `3/199` means three coordinates and 199 updates. “Current” returns final
coordinates; “history” produces successive values and selects the last (unused
history can be optimized away). Copy controls compare identical executable bytes.

| Goal and evidence | What remains; next action |
|---|---|
| [Packed derivative inputs](docs/measurements/packed-input-time-2026-11-04/README.md) | AMD64 session 1 copy variation is 2.3628% / 2.7833% on 3/199 and 3/1999; session 2 slows 3/1 current by 2.3095%, against 2% limits. [Saved samples](docs/measurements/packed-input-time-2026-11-04/amd64-sample-review.md) establish no cause. Verify the consumed-storage group next; retain these separate misses. |
| [Final-iteration compiler cost](docs/measurements/final-iteration-analysis-2026-11-04/README.md) | AMD64 field-owner transfer copy variation is 2.043% against 2%; other observed limits pass. Inspect retained sample/setup progression before proposing a new measurement. |
| [Final-iteration runtime](docs/measurements/final-iteration-time-2026-11-04/README.md) | Five history cases miss 5%: ARM64 3/199 and 33/199 in both sessions, plus AMD64 session 1 33/199. AMD64 session 2 slows 3/1 history by 2.79%. Compare small-case source and saved sample progression before selecting a repair. |
| [Identity array maps](docs/measurements/scalar-array-identity-time-2026-11-03/README.md) | All 32 required 5% gains remain unmet; copy controls and small-case regression limits pass. Use remaining allocation sites and lifetime proofs to choose the next reduction. |
| [Direct scalar array calls](docs/measurements/direct-array-time-2026-11-03/README.md) | Sixteen required 5% gains remain unmet. AMD64 session 2 3/1 current has 3.53% copy variation. Inspect source and saved samples before changing the protocol; larger gains do not close these cases. |
| [Gradient-array speed](docs/measurements/gradient-array-time-2026-11-03/README.md) | Every required 5% gain remains unmet; small repeated updates slow roughly 1–2%. PR #253 tested direct callbacks. Keep this original comparison open while measuring the remaining storage costs. |
| [Private index ranges](docs/measurements/range-zip-time-2026-11-03/README.md) | Seven cases improve only 3.97–4.98% against 5%. PR #252 addresses the gradient-list group; other [allocation sites](docs/measurements/range-zip-storage-2026-11-03/README.md#remaining-allocation-sites) need separate lifetime proofs and measured costs. |
| [Scalar buffers](docs/measurements/scalar-map-zip-time-2026-11-03/README.md) | Both ARM64 sessions slow zero-update current by 3.32%; small cases also miss 5%. Saved C changes only the positive-update branch. Diagnose source/driver behavior before attributing a cause; AMD64's small-case misses remain open too. |
| [Callback owners](docs/measurements/callback-owners-2026-11-03/README.md) | Both architectures miss 5% on 3/199 and 3/1999 in both forms; AMD64 33/199 current also misses. AMD64 3/1999 copy variation is 2.12–2.21%. Use saved phase/work counts to select the next change. |
| [AMD64 array consumption](docs/measurements/array-consumption-2026-11-02/README.md) | Large arrays are 4.93–5.23% slower despite passing copy controls; small-array copy controls fail. [Sample progression](docs/measurements/array-sample-positions.md) and [driver comparison](docs/measurements/array-observations-2026-11-02/README.md) establish no ownership repair. Keep the complete driver fixed; account for construction and consumption together. |
| [Small AMD64 matrices](docs/measurements/matrix-columns-2026-11-02/README.md) | Six copy controls fail at 2.6–8.3% against 2%. [Saved samples](docs/measurements/matrix-sample-positions.md) locate mismatch early in processes but establish no cause. Diagnose measurement setup before selecting an optimization. |
| [Derivative speed](docs/measurements/descent-costs.md) | Original 5% limits remain open; typed-owner savings do not settle ordinary F64 Rosenbrock speed. The array-to-list AMD64 copy result is still inconclusive. Preserve its samples rather than rerunning unchanged work. |
| [Numerical kernels](docs/measurements/kernel-baselines.md) | Diagnose timer resolution first. Keep qualified-host, arithmetic-order and identical-copy requirements before accepting a kernel optimization. |
| [Closure construction](docs/measurements/callable-phases.md) | Original Xeon regressions remain open. Freeze qualified work counts before choosing another candidate; a faster result on another CPU does not settle them. |

Broader ARC minimization needs an explicit alias/lifetime boundary and measured
costs. Count-free arbitrary sharing, universal stack storage and automatic
reclamation of every owning cycle are not goals.
[Swift comparisons](docs/measurements/swift-allocations.md) distinguish allocator
traffic from fwp-managed storage. Swift ARC operation counts remain unmeasured;
RSS and elapsed time cannot supply those counts.

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
