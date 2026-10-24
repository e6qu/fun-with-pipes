# Checked arithmetic in the benchmark peers

The [seven complete-program comparisons](../benchmarks.md#fwp-compared-with-c-and-rust)
compare fwp with handwritten C and Rust. Previously, most C/Rust peers did not
check signed overflow while fwp did. This preparation makes subtraction,
multiplication and accumulated sums explicit checked operations in all three.
It changes the comparison programs, not the fwp compiler or runtime.

## Contract and remaining differences

The inputs and expected outputs are unchanged. C uses overflow builtins with
`-std=c11 -O2 -ffp-contract=off`; Rust uses `checked_*` with
`--edition=2021 -O`. fwp uses checked ARC, `-O2` and `FWP_LTO=0`.
Fixed loop bounds keep index increments in range. `range-set` deliberately uses
wrapping unsigned hash multiplication; that is part of its algorithm.

For example, the loop's state is an index and an accumulated sum. Each iteration
first subtracts one from the index, then multiplies the old index by three,
then adds its remainder modulo seven to the sum. At the minimum signed integer,
subtraction must fail before multiplication runs. At index zero the loop stops,
including when the sum is already the maximum signed integer.

Sorting algorithms, array/vector construction and text formatting still differ.
Matching arithmetic does not make these identical implementations or isolate
language overhead. C exits and Rust panics on overflow; their diagnostics and
cleanup paths differ. Successful fixed-input timing does not measure those paths.
No timing improvement to fwp can be inferred from making a peer slower.

## Checks and measurements

[`check-benchmark-peers.py`](../../scripts/check-benchmark-peers.py) extracts the
actual C/Rust loop bodies, compiles them at the comparison settings and supplies
51 dynamic inputs around the signed boundaries. An arbitrary-precision integer
oracle checks results and which operation fails first. Removing each of the
three checks must be detected: six broken programs alongside two ordinary ones.
These derived executables are saved but never included in timing samples.
This tests the loop body, not every possible execution of every benchmark.

The C map and pipeline now reject failed allocations. The pipeline releases its
first buffer if allocation of the second fails. Three further derived programs
inject those failures and track outstanding buffers; deliberately removing that
release must leave one buffer and fail the check. This is a cleanup test, not a
whole-process allocation measurement.

Both native Linux architectures must run these controls and all seven output
comparisons. Each complete program gets one warmup and six rotating elapsed
samples. Process startup, input construction, computation, storage and output
are timed; compilation is recorded separately. Three additional runs measure
peak resident memory. Separate fwp images measure managed storage and detect
intentional leaks; their times are excluded. Preserve actual executables,
compiler/CPU metadata, all samples, source hashes and independent binary reviews.

## Status

Implementation and workflow wiring are in preparation. No new runner result or
performance ratio is accepted yet. The [dated ARC comparison](arc-comparison.md)
retains its original peer sources, arithmetic differences and slower results.
