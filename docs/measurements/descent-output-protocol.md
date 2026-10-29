# Separating numerical work from output construction

The [matched-formula comparison](coordinate-work.md) measures complete gradient
descent programs. Its largest fwp case takes about 10–14 times the C/Rust time.
That includes input creation, numerical updates, output and cleanup. It does not
identify how much time any one of those parts takes.

This diagnostic changes only how the final vector is consumed. It is a
measurement tool, not a proposed language or compiler optimization. The
[initial result](descent-output-initial.md) preserves five inconclusive timing
rows. The [longer repetitions](descent-output-longer.md) pass both runs' controls
for nine of twelve input/host pairs; three AMD64 pairs remain inconclusive.
Neither diagnostic measures a compiler speed improvement.

## Two ways to consume the same result

A solve starts with alternating -1.2 and 1.0 values and repeatedly subtracts
0.001 times the Rosenbrock derivative. The derivative is an explicit formula;
these programs do not record an automatic-differentiation tape. Each process
performs fresh solves, including input creation and cleanup after each one.
Use 32,768 solves for 3 coordinates with 0 or 1 update, and 4,096 solves for each
remaining input. These explicit per-input counts lengthen the short checksum
cases; the initial 512-solve run had several failing timing controls.

For each language, compare:

- **Full output:** the existing program prints every coordinate after each solve.
  fwp's source converts the final array to a list for display, but numeric-array
  fusion removes that intermediate list and formats the array directly.
  The C and Rust peers format their final numerical buffer directly.
- **Checksum output:** a separately compiled C function reads every coordinate
  before its owner releases the buffer. It mixes the exact float bits into a
  64-bit checksum, rejects nonfinite values, and prints the solve count and
  checksum once at process end.
  All three languages link the same consumer object without link-time
  optimization. It reads bytes to accommodate fwp's word-backed float storage.

The checksum prevents unused results from being discarded. It also costs time;
its final print can use internal C-library storage, outside the numerical-buffer
observer's scope.
The formatters differ: fwp searches decimal precisions until parsing the result
returns the original float, C uses `printf("%.17g", value)`, and Rust uses its
ordinary `Display` formatter. Checks compare parsed coordinates, not identical
text across languages. Full-output ratios therefore include different formatting
algorithms; they do not isolate compiler overhead.
Therefore, subtracting these timings does **not** give pure formatting time.
The checksum variant still includes input creation, all updates, bounds checks,
allocation, cleanup, runtime startup and the checksum itself. With numeric-array
text fusion enabled, neither fwp mode builds an output list. The older results
before this optimization also included list construction in their full-output
mode; keep that difference explicit when comparing revisions.

The [fwp program](../../tests/fixtures/descent_packed.fwp) and coordinate-based
[C](../../tests/fixtures/descent_coordinate.c) and
[Rust](../../tests/fixtures/descent_coordinate.rs) peers keep their existing
formulas. C/Rust allocate two numerical buffers per solve and reuse them during
its updates. fwp builds immutable result arrays; the optimized literal input is
initialized once per process and reused across solves. Those storage, input-setup
and checked-access differences remain part of each ratio.

The runner writes `environment.json` before starting workloads, recording the
source and file hashes, compiler binary, hardware, toolchain versions and explicit
settings. `build-commands.json` is updated after every compiler attempt. A failed
run therefore keeps its identity and completed `results.json` rows; it does not
produce a successful final comparison report. A failure-control test verifies
that a real compiler-process error preserves both records.

## Correctness and memory

Before timing, an untimed consumer prints each coordinate's exact 64-bit
representation. The runner checks every coordinate and every solve against the
numerical reference with relative and absolute tolerances of `1e-10`, then
independently computes the checksum of those bits. Precisely, the accepted error
is at most `max(1e-10, 1e-10 * max(abs(actual), abs(expected)))`. Full fwp output
must additionally match its raw interpreter byte for byte.
Each implementation must reproduce its own checksum on every timed run. Decimal
formatting and small allowed numerical differences do not require equal checksums
across languages. Missing, extra, changed beyond tolerance, nonfinite or malformed coordinates
must be rejected. A consumer that deliberately omits the last coordinate must
produce a different checksum.

Separate instrumented programs observe storage after every solve. fwp must have
zero managed and raw derivative storage at each checkpoint, zero retains and
no collector entry points in the actual image. C/Rust must release both numerical buffers at each
checkpoint. Controls deliberately retain a value or omit a buffer release; the
observer must fail at the first checkpoint, even if final cleanup would hide it.

fwp's managed allocation counts include runtime values. The C/Rust observer
counts only their two numerical buffers and excludes formatting/runtime storage.
Instrumentation can prevent allocation elimination: the initial uninstrumented
AMD64 Rust zero-update image eliminates an unused buffer. Profile counts are
observations of instrumented programs, not allocation traces of the timed images.
These scopes cannot establish a total-memory ratio. Record process peak resident
memory separately for every timed entry. Memory probes are excluded from timing.

## Timing and acceptance

Run on native Linux AMD64 and ARM64 with GCC O2, baseline architecture, no
floating contraction, fast-math or LTO. Rust uses O2, generic CPU, checked integer
overflow and no LTO. Record exact source and binary hashes, compiler versions,
CPU model, commands, generated C, disassembly, code sizes and C stack records.
Inspect actual instructions, including the external consumer and complete solve
loops. The ARC images must exclude tracing scan/mark/sweep routines.

Keep the six existing inputs: 3 coordinates with 0, 1, 199 or 1,999 updates;
33 or 129 coordinates with 199 updates. Time eight entries: full and checksum
fwp, a byte-identical copy of each fwp executable, and full/checksum C and Rust.
Use four warmups, 48 samples and seed 20261023. Every eight-sample block balances
positions and ordered immediate predecessors; block boundaries are not balanced.
Compilation, validation and memory probes are untimed. Elapsed time covers the
whole process, including captured output and final shutdown.

The workflow explicitly allows 180 seconds per compiler command and 60 seconds
per execution. Compilation has a separate deadline because GCC exceeded the old
shared 60-second limit on an ARM64 input that was byte-identical to an earlier
successful build. This does not change measured-program limits or local resource
limits. `build-commands.json` records each build's command, elapsed wall time,
status and diagnostics, including failed attempts. A timed-out compiler and its
children are terminated. Build times include host scheduling delays and remain
outside the program timing samples; report them separately.

Report checksum/full ratios within each language and fwp/C and fwp/Rust ratios
for both output modes. A ratio of 2 means twice the time, or 100% extra time.
Preserve every sample, slowdown and failing control. Both identical-fwp ratios
must lie within 0.98–1.02 for an input's timing to be considered stable. Require
two independent runs on matching CPU models before drawing a repeatable timing
conclusion. Even then, this diagnoses the named implementations; it does not
prove general language overhead or justify an optimization by itself.

The [`descent-output` workflow](../../.github/workflows/numerics.yml) runs the
[untimed controls](../../scripts/test-descent-output.py) before the
[measurement](../../scripts/measure-descent-output.py). Select `native_runner=all`
explicitly: this suite requires both Linux architectures. Full runs stay on
GitHub; local work is limited to guarded, untimed controls.

Compiler timeout, interruption and unsuccessful exit all terminate the compiler's
process group before recording the failure. This includes a child that has closed
its inherited output pipes: EOF alone does not prove that child exited. A real
child-process control checks this case alongside timeout cleanup and metadata
persistence. This policy does not claim to contain tools that deliberately detach
into a different process group.
