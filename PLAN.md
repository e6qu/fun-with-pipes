# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use automatic
reference counting (ARC) only for necessary sharing. Tracing garbage collection
has been removed. JIT compilation and backward compatibility are excluded.

## Current work: reuse consumed numeric storage

A gradient update scales a derivative array, then subtracts it from coordinates:

```text
coordinates [10, 20, 30], gradient [2, 4, 6], step size 0.5
scale the gradient → [1, 2, 3]
subtract it        → [9, 18, 27]
```

Reuse the gradient array when it has one owner; reuse the exclusively owned
prefix of the coordinate list after all callbacks finish. Shared arrays, views
and list suffixes keep their original values. “Consume” means transferring an
owner, not assuming there are no aliases. Both operations stay separate eager
stages. No new source syntax or public borrowing-contract change is required.

The [contract](docs/measurements/owned-numeric-updates.md) fixes last-use selection,
returned owners, constructor fields, failure cleanup and measurement limits.
[The shared-tail example](docs/measurements/remaining-gradient-storage.md)
explains why a node beneath a shared ancestor cannot be overwritten.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Freeze ownership and measurement rules | Define transferred owners, runtime uniqueness, aliases/views, callback order, exclusions and same-source reference before code. |
| 2 | Verify both consuming operations | GCC ARM64/AMD64 and Clang ARM64; actual calls in both complete gradient forms; O1/O2, float bits, both zip slots, views/shared tails, traps, cancellation, allocation failure, physical frees and deliberately broken controls. |
| 3 | Measure complete programs | First verify exact allocation predictions for all six cases, both result forms and workspace settings. Then measure compiler time/RSS and two timing sessions per architecture against the frozen limits. Preserve every outcome. |
| 4 | Deliver one grouped PR | Bundle code, regression repairs, docs and evidence. Pass nine exact-head production jobs plus docs, audit all full/target logs, squash and verify tree/message. |

Step 1 is frozen at `1c5e6a66`; the returned-owner/constructor-field extension at
`c99451ec` precedes its implementation. Step 2's complete-program selection and
new ownership controls pass on all three hosts. The [retained diagnosis and repair](docs/measurements/owned-numeric-selection-2026-11-04/README.md)
now check explicit borrowing and both consuming positions; all 285 units and
103 integrations pass. The expanded formatter check found one older layout issue,
now repaired to the exact saved output. Verify that repair before measurements.
Steps 3–4 remain open; no whole-solve savings or speedup is claimed.
The [handoff](docs/development-state.md) identifies the current source and runs.

For N coordinates and U updates, predict U fewer array requests and
N × max(U−1, 0) fewer list-cell requests per solve. The first coordinate list is
shared with the input, so it must be copied. At 129 coordinates / 199 updates,
that predicts **25,741 fewer requests and 819,968 fewer requested bytes**.
Any unexplained difference stops measurement review before timing. Compiler
time/RSS may grow at most 5%; identical-copy variation must stay within 2%.
Long solves require at least 5% less time; small cases allow at most 2% more.
Verified reductions may ship with timing goals explicitly open under the
accepted policy; failed limits remain failed.

[PR #257 is verified delivery](docs/roadmap-history.md#packed-derivative-inputs-pr-257):
private derivative inputs use one buffer. Its measured reductions and three
open AMD64 timing limits retain their own reference below. The new comparison
will not retroactively settle them.

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
