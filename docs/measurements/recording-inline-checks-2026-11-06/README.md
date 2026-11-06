# Scalar append inlining: focused native checks

Linux ARM64/AMD64 with GCC and macOS ARM64 with Clang pass at
`39a9f806891b524042b391b85480cbafc022afbc`. The [frozen change](../recording-inline.md)
substitutes the existing checked append body at its call sites; it adds no new
ownership proof or unchecked path.

[Correctness run 42156552424](https://github.com/e6qu/fun-with-pipes/actions/runs/42156552424)
passes format, Clippy, compiler units, primitive contracts and 25 native targets
per host. The native targets have no failures or ignored tests. Compiler units
retain their four existing ignored tests. Forced and ordinary append declarations
are compared at O1/O2; O0 controls also pass. Checks cover exact bits, gradients,
tape lifetime/validation, capacity growth, trap order, failure cleanup, nested
and typed derivatives, task boundaries and reuse policies. Deliberately broken
observers/validation must return their specified failure codes.

| Host | Correctness job | Images audited | Probe observations |
|---|---|---:|---:|
| Linux ARM64 | `127691972751` | 856 | 872 |
| Linux AMD64 | `127691973009` | 856 | 872 |
| macOS ARM64 | `127691973129` | 856 | 872 |

[Complete audit 42158479402](https://github.com/e6qu/fun-with-pipes/actions/runs/42158479402)
passes at tool source `a029797e3a158f9cbb2aaa3ff0ba78fbf3d62d84`, job
`127698194745`. It checks every native image header, source/artifact identity,
complete job/target log and recorded probe. The retained [audit bundle](audit.zip),
[metadata](artifact.json), [job](audit-job.json), [job log](audit-job.log.gz) and
[summary](summary.json) have verified digests; all retained nested record hashes
match. No unexpected compiler diagnostics or unresolved correctness failures.

The first audit dispatch, run `42158262680`, omitted the required attempt number.
Argument parsing failed before any artifact was created, so upload also failed.
[Its complete log](dispatch-error.log.gz) is retained. Supplying attempt 1 fixed
the dispatch; only the saved artifacts were re-audited. Native tests were not rerun.

These checks are prerequisites for measurement. They do not establish a speedup
or replace the final nine-job platform matrix and documentation audit.
