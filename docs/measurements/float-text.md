# Reusing rounded digits when printing floats

The [repeated results](float-text-results.md) pass the predeclared speed screen
for the largest input on matching CPU models of both architectures. This changes
native F64/F32 text conversion while preserving the text printed by existing
programs. The [output experiment](descent-output-longer.md) motivates measuring
this cost; it does not establish the benefit of this particular change.

For example, `0.30000000000000004 | echo` must still print
`0.30000000000000004`. The formatter tries increasing decimal precision until
reading the text returns the same floating-point value. Previously, each attempt
first used scientific notation to choose the exponent, then converted the float
again for fixed notation. The candidate moves the decimal separator in those
already-rounded digits. Integer output and scientific output retain their
existing paths. No storage is allocated on the heap by this change; additional
local scratch space increases stack use, as measured below.

## Correctness checks

`tests/float_formats.rs` compares ordinary and JSON output with the raw
interpreter at C O1/O2, with ARC and tracing, including tracing stress. A second
probe compares a frozen copy of the previous formatter with the candidate:
signed zeros, infinities, NaNs, subnormals, binary and decimal boundaries, large
integers, deterministic bit patterns and all four C rounding directions.

It checks each precision from one to seventeen for finite F64 values. Deliberate
digit changes and writes into an adjacent canary must fail with distinct statuses.
The frozen implementation is a test oracle, not a runtime compatibility path.

All six native Linux/macOS/Windows ARM64/AMD64 correctness jobs passed at
`550ef3157720` ([run 40028991372](https://github.com/e6qu/fun-with-pipes/actions/runs/40028991372)).
Independent inspection checked all 72 saved binaries. Each host checked ordinary
and JSON output, ARC and tracing, and precision/corruption probes at O1/O2.
The precision probe checks 119,768 values and 1,017,484 precision cases with no
mismatches or boundary writes. The first Windows run exposed an LF-only summary
assertion; accepting one line with either platform ending repaired the harness.
Runtime and benchmark sources did not change in that repair.

The largest generated program's GCC formatter stack frame grows from 224 to 256
bytes on AMD64 (bounded dynamic stack use), and 208 to 288 bytes on ARM64 (static).
The caller's writer frame stays at 720/704 bytes respectively. Whole-program
text-section bytes grow from 33,010 to 33,826 on AMD64 and 30,972 to 31,516 on ARM64.

The byte counts measure the ELF `.text` section, including padding; the
historical raw field is named `instructionBytes`. These costs accompany a
possible elapsed-time gain; the change does not reduce
allocation counts. Local Clang ARM64 separately reports 240 to 288 bytes for the
formatter. These frame sizes describe individual functions, not total call-stack
use.

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
text-section bytes, executable sizes, sources and disassembly are also saved.

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
jobs.

To obtain a missing same-model repetition, select `native_runner=ubuntu-latest`
or `native_runner=ubuntu-24.04-arm` explicitly. GitHub's standard runners may
assign different CPU models; retain unmatched runs and repeat only the needed
architecture. A single selected host never establishes two-architecture coverage.
[Repeated results](float-text-results.md) retain every run, including unmatched
CPU models, and report stack/code-size costs alongside timing gains.

`suite=float-text-checks` runs only the six native correctness jobs, so a test
repair does not repeat unchanged benchmarks. The Windows probe uses CRLF in its
one-line summary; the Rust test parses a line rather than requiring LF bytes.
Ordinary fwp output still requires exact agreement with the interpreter.

See [benchmark guidance](../benchmarks.md) for interpreting ratios and
[PR #205](../roadmap-history.md#float-printing-and-numerical-cost-measurements-pr-205) for the passing delivery gates and retained source identities.
