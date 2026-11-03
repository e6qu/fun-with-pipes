# Packed temporary records for derivative sums

`map` computes one result per input. `fold` combines those results, starting
from a **seed** value. When only the fold uses a mapped list of numeric records,
the compiler can store those records in one contiguous buffer. It finishes every
map call before folding the results.
Focused correctness, cleanup and allocation checks pass on native Linux
ARM64/AMD64. All four paired timings are audited; one limit remains unmet.
[PR #248](https://github.com/e6qu/fun-with-pipes/pull/248) is merged after all nine
production jobs and documentation passed; [gate identities](final-gates.json).

[Baseline](baseline.md) · [Frozen requirements](protocol.md) · [Verification](verification.md) · [Timing tables](timing.md)

## What changes

The [autodiff tutorial](../../tutorials/20-autodiff-and-devices/main.fwp) computes
Rosenbrock's function from adjacent coordinates. Each pair `(x, y)` contributes
`100 * (y - x*x)^2 + (1 - x)^2`:

```text
Coordinates:    [-1.2, 1.0, 0.5]
Adjacent pairs: (-1.2, 1.0), (1.0, 0.5)
Contributions:       24.2  +     25.0  = 49.2, mathematically
```

During differentiation, each result contains a floating-point value and an
integer identifying its recorded operation. [Tape](../../terminology.md#tape-and-backward-pass)
explains how those operations produce derivatives. Both mapping and summation
record operations, so their order must stay unchanged:

```text
map pair 1 → map pair 2 → obtain sum seed → add result 1 → add result 2
```

Only storage changes. Separate result records and list cells become adjacent
numeric fields in one buffer. Seed evaluation stays at its original position.
The buffer is released after the fold, or during failure/cancellation cleanup.
No new syntax or public collection API is needed.

Selection requires one consuming use and callbacks known to the compiler without
stored values from an enclosing scope. Fields must be machine-sized numbers.
Shared/escaping lists, functions chosen at runtime, captured values, strings,
nested records, boxed wide numbers and right folds keep the existing
representation. The [protocol](protocol.md) contains the exact boundaries and
acceptance limits.

## Allocation results

[Verified source](verified-counts.json.gz): `a4f3200c`, run
[41511493637](https://github.com/e6qu/fun-with-pipes/actions/runs/41511493637).
Both architectures agree across all six inputs, current/history forms, GCC O1/O2
and reusable derivative scratch storage (the **workspace**) off/on: 96 complete
observations.

An update subtracts `0.001 * gradient` from each coordinate. Initial coordinates
alternate -1.2 and 1.0. **Current** keeps only the latest vector; **history** keeps
all vectors before selecting the last. Both print the same complete final vector.

Whole-solve results below use current form, GCC O2 and workspace reuse off:

| Coordinates / updates | Managed requests before → after | Requested bytes before → after | Peak managed bytes before → after |
|---|---|---|---|
| 3 / 0 | 4 → 4 | 98 → 98 | 128 → 128 |
| 3 / 1 | 42 → 37 | 1,088 → 976 | 448 → 416 |
| 3 / 199 | 7,368 → 6,373 | 183,249 → 160,961 | 480 → 448 |
| 129 / 199 | 208,086 → 156,943 | 6,607,982 → 5,382,142 | 21,888 → 17,824 |

Requested bytes are cumulative allocation traffic. Peak managed bytes include
size-class rounding, but exclude allocator bookkeeping and separately measured
raw tape/workspace storage; they are not RSS. Reference-count increments
(**retains**), derivative operation counts and raw tape/workspace observations
stay unchanged. Final managed/raw storage is
zero in every case. All largest-frame growth limits pass.

For `n = coordinates - 1` adjacent pairs per update, the exact saving is:

| Storage | Baseline requests / bytes | Packed requests / bytes |
|---|---|---|
| Result records and list cells | `2*n` / `48*n` | 0 / 0 |
| Input-handle arrays: lengths `n` and `n+1`, each with one spare word | 2 / `16*n + 24` | 0 / 0 |
| Result buffer: eight-byte header, two eight-byte fields per result | 0 / 0 | 1 / `16*n + 8` |
| Total | `2*n + 2` / `64*n + 24` | 1 / `16*n + 8` |

That removes `2*n + 1` requests and `48*n + 16` requested bytes per update.
All 96 observations match. The frozen minimum stays unchanged. For the largest
O2 case, instruction bytes grow 46,876 → 46,908 on ARM64 and 49,602 → 50,226 on
AMD64. Neither fewer allocations nor smaller code establishes a speedup.

## What the timing experiment compares

| Implementation | Work |
|---|---|
| Candidate fwp | Complete differentiated solves using packed temporary results |
| Reference fwp | Same source and solves; only packed-record lowering is disabled |
| C and Rust | Explicit derivative formulas; no general autodiff recording/backward pass |

The same-source comparison isolates this transformation. C/Rust ratios also
include the cost of general autodiff, so they do not compare identical internal
work. The [Swift allocation comparison](../swift-allocations.md) is a separate
experiment.

Inputs are 3 coordinates with 0, 1, 199 or 1,999 updates, plus 33 and 129 coordinates
with 199 updates. Each process repeats complete solves and prints every result;
timing includes process startup, formatting and shutdown. Both current/history
forms run. The [shared protocol](../descent-costs.md) specifies solves per process,
98 balanced rounds, seven processes per role and two sessions per architecture.
Identical-copy noise and every missed timing limit remain visible. D2 stays open
until its separate requirements pass.

Three qualified sessions completed in
[41514265188](https://github.com/e6qu/fun-with-pipes/actions/runs/41514265188).
The fourth completed in
[41518220615](https://github.com/e6qu/fun-with-pipes/actions/runs/41518220615).
Both ARM64 sessions and AMD64 session 1 pass their timing limits. AMD64 session 2 misses one limit:
zero-update history is 2.024% slower, against a maximum 2% regression. Independent
archive audits pass, preserving that failure. Cases with at least 199 updates
use 5.1–14.2% less elapsed time. All identical-copy controls pass.
[Timing tables](timing.md) show every case, C/Rust ratios, RSS and code/stack costs.

Four assigned CPUs failed AMD64 session 1's qualification before building/timing.
The fifth attempt obtained the required EPYC 7763. No completed timing session
was repeated to seek a passing result. Retain the verified reductions while
leaving the failed timing limit open; the combined frozen timing rule is not met.
