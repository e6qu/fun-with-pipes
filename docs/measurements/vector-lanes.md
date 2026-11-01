# Fixed-size lane calculations against C and Rust

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

A **lane** is one position in `Vec[N, F64]`; see the
[example](../../examples/vector-lanes.fwp). **Work:** fill lanes with the iteration
index, multiply by 0.5, sum lanes left to right, then sum iteration results.
Four lanes use 32,768 iterations; 64 lanes use 8,192. Values are exact for these
inputs, and output matches raw interpretation. C/Rust use fixed stack arrays
that optimization may remove; fwp uses ordinary vector/list abstractions and
checks the final optional integer conversion.

**Method:** O2, no fast math or multiply-add contraction. The
[baseline](vector-lanes-2026-10-16.json), [direct-dot stage](vector-direct-intermediate-2026-10-16.json)
and [scalar-splat stage](vector-scalar-splats-2026-10-16.json) each
use one warmup and sixteen balanced whole-process samples (elapsed and child CPU).
Startup, construction, arithmetic, conversion and printing are included.
Compilation, allocation profiles and process-memory sampling are separate.

Baseline `6be8f245` makes 262,147/65,539 managed requests for four/64 lanes.
Direct-dot `3577ba37` removes product vectors and list intermediates but still
builds two input vectors per iteration: 131,074/32,770 requests. Final `b1a34ea0`
removes those vectors when only the dot consumes them: two output/conversion
requests total, 40 requested bytes, 48 peak charged bytes, zero retains/final
charge. C/Rust count zero application heap requests in their narrower calculation
scope; this excludes their startup/printing internals.

The [paired run](vector-paired-2026-10-16.json) compares the same
baseline/final binaries and C/Rust on each host, with one warmup and twelve
balanced orders. Ratios are final ARC child CPU time divided by the named reference:

| Host | Four lanes / before | Four lanes / C | Four lanes / Rust | 64 lanes / before | 64 lanes / C | 64 lanes / Rust |
|---|---:|---:|---:|---:|---:|---:|
| Linux AMD64 | 0.161 | 1.954 | 1.576 | 0.313 | 1.432 | 1.311 |
| Linux ARM64 | 0.116 | 1.517 | 1.251 | 0.241 | 0.878 | 0.937 |
| macOS ARM64 | 0.327 | 1.230 | 0.996 | 0.416 | 1.070 | 0.855 |
| macOS AMD64 | 0.270 | 1.134 | 1.027 | 0.504 | 1.043 | 0.904 |

Linux AMD64 four-lane work is 83.9% faster than old fwp but still takes 95.4%
more CPU than C. The comparison covers the whole change, not each optimization
separately. Inspected ARM64 calculation loops have no calls, loads or stores;
independent iterations use vector instructions, then ordered scalar additions.
That is static code evidence, not a cache-miss or dynamic-spill measurement.
