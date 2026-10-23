# Comparable coordinate work in fwp, C and Rust

This is the predeclared protocol for the [completed comparison](coordinate-work.md).
It shipped with the callback changes in
[PR #198](../roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198).
The instructions below preserve the experiment's inputs and acceptance rules;
current work belongs in the [plan](../../PLAN.md).

The repeated-work comparison shows about 10–12 times C time in the largest
packed case, even after retain traffic reaches zero. It compares different
arithmetic arrangements and buffer policies. This experiment separates those
differences before selecting a compiler optimization.

Use the expanded compiler's saved, inspected C from numerical run `39816519529`,
source `927c6b1852a69748ae613291d89774bb8ae31121`. The driver checks its archive,
generated-source and compiler-source hashes. If #198's compiler changes,
regenerate the numerical inputs explicitly before using these results.
This experiment rebuilds saved C; it does not run a newly built fwp compiler.
Retain the six existing cases and their complete outputs. Add C and Rust programs
that compute one output coordinate from the previous, current and next input
coordinates, matching `descent_packed.fwp`'s operation order and boundary cases.
Keep the original edge-based peers as named controls. Do not replace them or
rewrite the fwp program to make a baseline favorable.

The six timed entries are current packed fwp, a byte-identical fwp copy,
coordinate-based C and Rust, and the original edge-based C and Rust. Each process
performs 512 fresh complete solves, with full output and cleanup. Initialization
and final runtime teardown happen once. The coordinate peers may reuse two
buffers, but that difference must remain explicit. Do not call their ratio pure
language overhead. Exclude profiling and compilation from timing.

An input has a vector of numbers and a count of gradient-descent updates. Keep
these cases: 3 numbers with 0, 1, 199 or 1,999 updates; 33 or 129 numbers with
199 updates. Each solve starts with alternating -1.2 and 1.0, then repeatedly
subtracts 0.001 times the Rosenbrock derivative and prints the entire final vector.

Use four warmups and 48 balanced six-round samples, seed 20261022, exact native
GCC O2/Rust O2 settings from the accepted protocol. Record every sample, CPU,
compiler, command, source/binary hash, instructions, stack records and resident
memory. The identical-copy ratio must stay within 0.98–1.02; failed controls and
slowdowns are results to preserve, not reasons to rerun for a desired answer.
Require two independent matching-CPU runs before any useful speed claim.

Check the coordinate formulas against the raw interpreter and independent
Python derivative. Include two-coordinate boundary cases in correctness checks,
plus zero/one/many updates, without substituting them for the six timed cases.
Native fwp must preserve its output exactly; each peer must preserve its own
output across all timed samples. Explain differences in decimal formatting.

Profile current fwp outside timing: require zero retains, no tracing, zero live
managed/raw storage after each solve, and the accepted allocation/peak budgets.
Keep the delayed-release control that demonstrates the final-only blind spot.
The C/Rust probes count only the two numerical buffers: two successful requests,
16 times the dimension count in requested and peak live bytes per solve, and
zero live buffer bytes after each solve. C probes the workload's allocations;
Rust observes actual vector allocation/deallocation with a system-allocator hook.
Formatting, allocator metadata and unrelated runtime storage are excluded. These
bytes are not directly comparable to fwp's total managed charge or process memory.
An omitted buffer release must fail on the first solve for both arrangements in
both languages. Probe binaries are never timed.

Save 72 executable images per host: eleven per case, plus six additional lifetime
controls at 33 dimensions/199 updates. Inspect their target, code and observations.
Inspect actual outer loops to ensure computation and allocations remain inside
repeated solves. The separate small peer checks cover two-coordinate boundaries
and deliberately malformed outputs; Clang checks are not GCC acceptance.

Before choosing an optimization, inspect scalar callback calls, repeated bounds
checks, spills and output allocation. The largest current count is 459 requests
per solve; identify their sites rather than assuming every request is an OS
allocation. Any optimization must preserve checked arithmetic, trap/effect order,
immutable values and cleanup during failure/cancellation. No blanket speed or
zero-allocation promise.

After recording the measurements, update the benchmark index and application
acceptance document with the observed ratios and their limitations. Keep older
results tied to their original source, workload and timing scope.
