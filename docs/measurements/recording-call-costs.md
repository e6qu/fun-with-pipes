# Recording calls: source and GCC diagnostic

Freeze this contract before adding the diagnostic tool or changing production
code. Its question is whether GCC treats the recorded calls differently across
three versions. It is not a timing experiment and cannot establish a slowdown's
cause by itself.

## Inputs and comparison

| Version | Source | Saved programs |
|---|---|---|
| Previous candidate | `76690b385514c58ad94c5591da3553fa48218535` | `fwp-ad`, `fwp-ad-history` |
| Lookup reference | `31c04650527d7a3c9efdd63bd5b4eae8a15d5732` | `fwp-ad-reference`, `fwp-ad-history-reference` |
| Lookup candidate | Same source as reference | `fwp-ad`, `fwp-ad-history` |

Use session 1 for each native architecture: previous run `42074728167`; current
ARM64 run `42136888829`, AMD64 run `42137772065`. Their complete audited indexes
identify the original ZIPs, source files, commands and executable hashes.
Verify each ZIP digest and each selected C/executable hash before rebuilding.

Cases (coordinates/updates): 3/0, 3/1, 3/199, 3/1999, 33/199 and 129/199.
Current returns final coordinates; history computes successive values and selects
the last. This is 36 compilations per architecture, 72 total. Programs are not run.
Do not rebuild fwp or repeat any timing sample.

## Native compiler reports

Use native Linux ARM64/GCC 13.3 and AMD64/GCC 15.2, requiring the original full
compiler version string. Preserve recorded source/output paths and the complete
compile command: O2, GNU C11, no fast math, contraction off, reuse enabled, stack
usage, explicit `armv8-a`/`x86-64` target, original warning and linker settings.
Add only `-fopt-info-inline-optimized-missed=REPORT` with one explicit output per
compilation. [GCC documents this report](https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Developer-Options.html)
as including successful and missed inlining decisions.

CPU-model qualification is unnecessary for compilation-only inspection with these
explicit target flags. Architecture and toolchain matching remain required.
Require each rebuilt executable's SHA-256 to equal its own originally measured
image. Do not interpret a changed image as the original. A mismatch, failed
compiler, missing report or incorrect input digest fails the diagnostic and
must be investigated; do not weaken the check or substitute another compiler.

## Retain and interpret

Retain input identities, full commands/status/stdout/stderr, all inlining reports,
source and executable hashes, rebuilt images and stack reports. Exercise failure
controls for corrupt inputs, wrong commands, failed compilation, missing reports
and changed executables. Audit every compilation, not only the first failure.

Compare the selected worker, its generated wrapper and ordinary no-state calls
across all three versions and both result forms. Include successful and missed
inlining, and examples tied to exact source lines. No disassembly-led memory-safety
changes: inspect source contracts first. Counts or code size alone prove no speedup.

After review, select a coherent production change only if the source and compiler
evidence justify it. Freeze its proof, enabled/disabled reference, correctness,
cleanup and time/memory/compiler-cost limits before editing production code.
Preserve the [32 runtime misses](recording-lookup-time-2026-11-06/README.md) and
[inconclusive compiler-time control](recording-lookup-analysis-2026-11-06/README.md).

## Explicit input files

The shared diagnostic now takes `--plan` with committed JSON naming each source,
audited index, result suffix and whether to require inlining or merely observe it.
The [original lookup inputs](recording-call-inputs.json) preserve this contract's
three versions. Workflow `recording-call-analysis` requires `call_plan` explicitly;
there is no selected comparison when that input is omitted.

For the [new inlining candidate](recording-inline.md), create its input file only
from the completed, audited runtime sessions. Rebuild candidate/reference images
with identical flags, require each original image hash, and check GCC reports that
the candidate append was inlined in positive-update programs. Record all reports,
including the zero-update controls. This adds no native program execution or new
timing samples. The original 72-image diagnostic is not rerun.
