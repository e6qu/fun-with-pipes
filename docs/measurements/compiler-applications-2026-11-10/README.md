# Compiler costs in complete programs, November 10

**All four applications preserve emitted C on Linux ARM64 and AMD64.**
This diagnostic attributes compilation work; it measures no runtime performance
or compiler speedup. [Investigation and commands](../compiler-checking.md).

Source: `ea531da149d085dbb146a64cd6ff1f92b61b170b`, retained by
`roadmap/compiler-application-attribution-2026-11-10`.
[Both native jobs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42741790147).

## Observations

One fresh release-compiler process builds each original program with
`--target native --emit-c -O2`, first ordinary then with phase reporting. No GCC
compilation or program execution follows. GNU time records process peak RSS.
These are single observations, with no warmup, copy controls or overhead claim.

Each program checks the same 1,590 library bindings. Library checking takes
208 ms on Neoverse N2 and 229–234 ms on EPYC 7763. Its internal work needs further
attribution before choosing an optimization. No checking is skipped or cached.

Times below are milliseconds; RSS is the entire observed process's high-water
memory, not memory attributable to a particular phase.

| Host | Program | fwp process | Library checking | User checking | Peak RSS (MiB) |
|---|---|---:|---:|---:|---:|
| Neoverse N2 | words | 282.0 | 208.1 | 0.3 | 41.6 |
| Neoverse N2 | numerical | 588.3 | 208.3 | 1.7 | 65.7 |
| Neoverse N2 | callbacks | 378.8 | 208.6 | 2.1 | 56.5 |
| Neoverse N2 | http | 1214.0 | 207.9 | 2.3 | 127.1 |
| EPYC 7763 | words | 313.3 | 231.0 | 0.3 | 42.1 |
| EPYC 7763 | numerical | 629.0 | 233.6 | 1.9 | 66.2 |
| EPYC 7763 | callbacks | 410.0 | 229.0 | 2.5 | 57.1 |
| EPYC 7763 | http | 1372.8 | 231.7 | 2.8 | 127.6 |

The remaining process time includes loading/parsing, collecting declarations,
specialization, optimization, ownership and C emission. Library checking dominates
the small word-count program, but does not explain the HTTP server's whole cost.

## Inputs and evidence

- **Words:** maintained word-frequency CLI, `examples/wordfreq.fwp`.
- **Numerical:** the complete autodiff tutorial, including tensor operations and
  Rosenbrock descent, `docs/tutorials/20-autodiff-and-devices/main.fwp`.
- **Callbacks:** all eight original service cases in
  `tests/fixtures/weak_callback_service.fwp`.
- **HTTP:** `examples/server/api.fwp`, with its original connection limit.

Each input retains its original `main` and import path. The runner compares actual
C bytes. All eight reports partition library/user groups and binding counts;
none has a mixed group. No instrumentation cost was subtracted.

`arm/` and `amd/` retain complete summaries, commands, identities and build settings.
`analysis.json` contains the table values; `audit.json` records sources, successful
jobs and artifact identities. Both complete job logs are retained. `files.json`
records retained-file hashes and sizes; `.gz` files use lossless gzip.

Individual phase reports, C, source copies and process logs remain in the recorded
CI artifacts until their recorded expiration dates. Selected ZIP members passed
CRC; whole-archive hashes come from GitHub and were not independently recomputed.
This receipt is compiler attribution, not full-platform delivery or a paired
performance comparison.
