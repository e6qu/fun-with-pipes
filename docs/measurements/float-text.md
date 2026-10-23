# Reusing rounded digits when printing floats

This is a candidate optimization, not an accepted speed improvement. It changes
native F64/F32 text conversion while preserving the text printed by existing
programs. The [output experiment](descent-output-initial.md) motivates measuring
this cost; it does not establish the benefit of this particular change.

For example, `0.30000000000000004 | echo` must still print
`0.30000000000000004`. The formatter tries increasing decimal precision until
reading the text returns the same floating-point value. Previously, each attempt
first used scientific notation to choose the exponent, then converted the float
again for fixed notation. The candidate moves the decimal separator in those
already-rounded digits. Integer output and scientific output retain their
existing paths. No storage is allocated on the heap by this change; additional
local scratch space still needs measurement in actual machine code.

## Correctness checks

`tests/float_formats.rs` compares ordinary and JSON output with the raw
interpreter at C O1/O2, with ARC and tracing, including tracing stress. A second
probe compares a frozen copy of the previous formatter with the candidate:
signed zeros, infinities, NaNs, subnormals, binary and decimal boundaries, large
integers, deterministic bit patterns and all four C rounding directions.
It checks each precision from one to seventeen for finite F64 values. Deliberate
digit changes and writes into an adjacent canary must fail with distinct statuses.
The frozen implementation is a test oracle, not a runtime compatibility path.

Local Clang ARM64 checks passed twelve generated-C cases. The precision probe
checked 119,768 values and 1,017,484 precision cases with no mismatches or boundary
writes. These checks patched the exact runtime function in C emitted by an
accepted compiler. Production CI must still build and check the changed Rust
compiler/test harness, GCC on Linux, and native macOS/Windows targets.

## What the performance comparison measures

`scripts/measure-float-text.py` runs complete numerical descent programs. Each
solve starts with a vector, computes derivative-driven updates and prints every
final coordinate. The [coordinate comparison](coordinate-work.md) explains the
matched formulas and the C/Rust implementations. C and Rust reuse two buffers;
fwp uses immutable arrays. Their ratios compare complete implementations, not
isolated language or compiler overhead.

For each input the script produces six timed executables:

- fwp with the candidate formatter and fwp with the frozen formatter. Only
  `fwp_format_g` differs in their generated C. Every output byte must agree with
  the raw interpreter, including the final newline.
- One byte-for-byte identical executable copy of each fwp version. Differences
  between a version and its copy measure noise, not an optimization.
- The matched C and Rust programs, with their ordinary numeric output. Each
  coordinate is checked against the analytic result; text need not match fwp's
  spelling because the implementations use different formatters.

The inputs are 3 coordinates with 0, 1, 199 or 1,999 updates, and 33 or 129
coordinates with 199 updates. The first two inputs repeat 32,768 solves per
process; the others repeat 4,096. Each executable gets four warmups and 48 timed
samples. Within each block of six samples, every executable occupies every
position and precedes every other executable once. Blocks use seed 20261024;
adjacent pairs across block boundaries are not balanced.

Timing covers process startup, input creation, arithmetic, output captured through
a pipe, and cleanup. Compilation, correctness probes, allocation observation and
resident-memory measurement are excluded. All timed outputs are rechecked.
GCC uses O2, the host architecture baseline, no fast math, no floating-point
contraction and no link-time optimization. Rust uses O2, a generic target CPU,
checked overflow, one code-generation unit and no link-time optimization.

Separate instrumented runs check zero live fwp managed/derivative bytes after
every solve, and count the C/Rust numerical buffers. Instrumentation may prevent
allocation elimination, so these counts are not traces of the timed binaries.
C/Rust buffer counts and fwp managed/raw counts cover different storage scopes.
Whole-process maximum resident memory, compiler-reported C stack frames,
instruction bytes, executable sizes, sources and disassembly are also saved.

## Decision rule, fixed before timing

Both identical-copy ratios must be within 2% of one. The candidate should reduce
the largest case's median elapsed time by at least 5% on both Linux architectures
in two independent runs on matching CPU models. Report every smaller case,
including regressions and inconclusive results. A failed noise control is not
evidence of either a gain or a regression. Investigate stable regressions rather
than averaging them away. Review stack and code-size costs before acceptance.

The workflow's `float-text` suite checks all six native hosts and runs both Linux
measurements. Invoke it with `native_runner=all`. A successful job means the
experiment completed; the saved `meetsSingleRunScreen` field is not final
acceptance. Repeat measurements with `suite=float-text-costs` and
`native_runner=all`; this does not repeat the unchanged six-host correctness
jobs. No speed result has been established yet.

See [benchmark guidance](../benchmarks.md) for interpreting ratios and
[the handoff](../development-state.md) for current source and run identities.
