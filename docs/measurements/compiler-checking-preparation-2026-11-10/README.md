# Library and user checking: first attribution, November 10

**Focused correctness passes on Linux ARM64/AMD64.** This is preparation for the
[next compiler investigation](../compiler-checking.md), not a delivered speedup.
Source: `f43dfcd1c52292dfe84253cba5801bf3749597e6`; tag:
`roadmap/compiler-checking-preparation-2026-11-10`.

The added report spans separate checking library definitions, checking the user's
program, dependency ordering and trait prerequisites. A group contains definitions
that must be checked together. Counts partition every type-check invocation,
including nested macro checking; they do not prove library checking is independent
of the user's type environment.

## What the diagnostic shows

Every input checks 1,590 library bindings. Their observed checking cost stays near
206–210 ms on Neoverse N2 and 223–227 ms on EPYC 7763. Dependency ordering takes
about 3–5 ms. This points the next investigation at library checking itself;
optimizing ordering alone would leave most of the fixed cost in place.

Each row is **one observed compilation**, with fresh release fwp, GCC 13.3.0 O2,
explicit architecture and no LTO/fast math/contraction. Times are milliseconds.
They are diagnostic boundaries, not medians or qualified speedup comparisons.
GCC execution is checked separately and excluded from fwp time below.

| Host | Input | fwp process | Library checking | User checking | Dependency ordering |
|---|---|---:|---:|---:|---:|
| Neoverse N2 | definitions-16 | 278.7 | 209.2 | 0.5 | 3.3 |
| Neoverse N2 | definitions-1024 | 421.8 | 206.3 | 59.0 | 4.5 |
| Neoverse N2 | generic-8 | 278.1 | 208.7 | 0.3 | 3.3 |
| Neoverse N2 | generic-512 | 400.8 | 208.0 | 30.1 | 3.7 |
| Neoverse N2 | nesting-8 | 275.9 | 207.6 | 0.2 | 3.3 |
| Neoverse N2 | nesting-512 | 459.5 | 207.6 | 48.9 | 5.0 |
| EPYC 7763 | definitions-16 | 292.1 | 225.4 | 0.5 | 3.3 |
| EPYC 7763 | definitions-1024 | 431.9 | 222.8 | 67.3 | 4.4 |
| EPYC 7763 | generic-8 | 289.8 | 225.1 | 0.3 | 3.3 |
| EPYC 7763 | generic-512 | 407.3 | 222.6 | 33.9 | 3.6 |
| EPYC 7763 | nesting-8 | 289.4 | 224.3 | 0.2 | 3.2 |
| EPYC 7763 | nesting-512 | 498.0 | 224.4 | 56.9 | 5.4 |

The process also loads/parses sources, collects declarations, specializes,
optimizes and emits C. That is why the displayed phase times do not add to the
whole-process column. Trait prerequisite checks are below 0.5 ms in these samples.
All twelve input sizes, error observations, phase counts and process memory
remain in the retained summaries. No cost was subtracted for instrumentation.
This run does not measure the new observer's overhead, actual application
compilation cost, or which operations inside library checking dominate.

## Correctness and retained evidence

- [Application/observer checks](https://github.com/e6qu/fun-with-pipes/actions/runs/42736751196):
  eight compiler-option contracts, three SDK applications, eight integer-output
  checks and O0–O3 inspection pass on both hosts. Browser checks pass on AMD64.
- [Release growth checks](https://github.com/e6qu/fun-with-pipes/actions/runs/42737726682):
  all twelve sizes per host preserve ordinary/observed C, outputs and early/late
  diagnostics. All 72 success/error report summaries have exact binding/group
  partitions. There are no mixed library/user groups in these inputs.
- `audit.json` records exact jobs, sources and artifact identities; `analysis.json`
  records the 24 positive observations. Four complete job logs are retained.
- `arm/` and `amd/` retain identities, source/build settings, command ledgers,
  complete summaries and artifact member lists. Large text uses lossless gzip.
- `files.json` records each retained file's SHA-256 and size.

Selected ZIP members passed CRC. Whole-archive hashes are GitHub metadata, not
independently recomputed here. Individual span reports, generated C and binaries
remain in the identified CI artifacts with their recorded expiration dates.

Native checks validate the report and unchanged behavior; they do not finish the
next performance milestone. Measure representative application inputs and
attribute the expensive library work before selecting an optimization. Preserve
macro behavior, diagnostics and type/effect constraints; do not skip validation
or add a cache based only on this result.
