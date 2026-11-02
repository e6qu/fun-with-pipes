# Matrix calculation: source investigation

## Measured problem

The [current comparison](current-kernel-costs.md#results-november-2-2026) finds a
repeatable calculation-only gap for 257×259 by 259×255 products: current fwp takes
about 65% more time than the matched C peer on AMD64, and 6% more on ARM64.
Both sessions pass their identical-copy controls for this case. The runtime uses
zero effective retains during this workload. No new candidate is selected yet.

The computation multiplies each left row by each right column. For example,
`[1, 2]` dotted with `[3, 4]` gives `1*3 + 2*4 = 11`. Each output cell must keep
its increasing inner-index order, including the order of multiplication and
addition; rearranging floating-point sums can change their result.

## Source facts and safety boundaries

- `fwp_p_matrix_valid_f64` checks signed dimensions, bounded products and actual
  input lengths. The specialized primitive is compiler-internal. Invalid runtime
  casts retain the original library behavior.
- The calculation allocates a fresh output and protects it with cleanup before
  computation. Inputs remain owned by the caller; they can share backing storage.
- Fixed-size byte copies preserve alignment and C aliasing rules for array data
  and views. Do not substitute `double *` casts without a valid representation proof.
- Only fresh output has a `restrict` promise: it cannot overlap either live input.
  The two input matrices can overlap each other.
- The 32-wide tiles still visit each cell's inner index in increasing order.
  Keep separate multiplication/addition, no contraction or reassociation.
- Task-free programs already omit scheduler polling. Existing `blocked_matrix`
  tests force an expired budget and check this explicitly. For task-using programs,
  preserve polling and failure cleanup before changing loop structure.
- The benchmark's two input records are allocated outside the calculation timer.
  Removing them cannot explain this calculation-only gap. Allocation-inclusive
  input setup uses a C driver, not source-compiled `array.generate`.

## First diagnostic, fixed before implementation

Reuse the existing GCC-report runner with the **current** retained executable
paths. Replace its obsolete old-baseline dispatch; historical reports keep their
recorded source and data. Do not maintain an implicit old-format fallback.

| Input | ARM64 | AMD64 |
|---|---|---|
| Measured source | `b9da15a1a323ae3f5d3ff247e0b6b4c59ab73528` | same |
| Run / session | `41404044761` / 2 | `41405063750` / 2 |
| Full measurement artifact | `13123885145` | `13123941925` |
| Native compiler | GCC 13.3.0 | GCC 15.2.0 |
| C target | `armv8-a` | `x86-64` |

The artifact identities and SHA-256 values are retained in the current report's
[index](current-kernels-2026-11-02/index.json). Verify the downloaded archive,
source and binary hashes before use. Rebuild C/fwp timing programs for all four
existing cases: the two arrays serve as controls, and both matrices are required.

Keep their original O2, C11, contraction, target, reuse and profile settings. Add
only GCC's vectorization explanation and optimized intermediate-code reports.
Require every rebuilt executable to match its measured binary byte for byte.
Run it once to check the exact result hash and live-storage result. Preserve all
printed data, but do not aggregate or accept these diagnostic durations as new
performance samples. No completed timing session is being repeated for a pass.

This diagnostic requires the original compiler version and native architecture,
not the original CPU model: it accepts no timing claim. Record the actual host.
Keep all partial failures, compiler reports, commands, source files and binaries.
Use the reports to locate a source-level difference; neither a compiler remark
nor a disassembly observation establishes a safe or faster transformation.

## Candidate selection and delivery

After this inspection, freeze one bounded source change and its exact reference
before implementation/timing. Use the [plan](../../PLAN.md) for semantic, alias,
cancellation and memory coverage. Any candidate must improve large-matrix AMD64
calculation time by at least 5%, keep every measured case/scope within 2% extra
time, and add no allocations, retains or peak storage. Both architectures and
independent copies are required. Keep a rejected candidate's results; do not ship
speculation as a speed improvement.

Group the justified change, probes, measurements and readable docs into one PR.
PR #243 remains the sole active PR until its complete final-head matrix passes
and it is squash-merged. This preparation does not change that tested head.
