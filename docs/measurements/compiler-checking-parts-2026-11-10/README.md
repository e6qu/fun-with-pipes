# Where library-checking time goes, November 10

**Expression bodies dominate the observed library-checking time on both hosts.**
No compiler algorithm changed. [The investigation](../compiler-checking.md)
defines each operation and the next attribution step.

Source `7761a41544c0c9538880f75cb5b1a177de3d2f6c`, tag
`roadmap/compiler-checking-parts-2026-11-10`.
[Both native jobs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42743138148):
eight compiler-report contracts per host at production Rust O1, followed by
release-compiler observations of four unchanged complete applications.

Each row is one observed emit-C process, without timing controls. Values are
milliseconds. Ordinary and observed builds emit identical C; neither executes
the application here. Process CPU/RSS and all phase counts remain in summaries.

| Host | Application | Library total | Bodies | Constraints | Validation | Remaining group work |
|---|---|---:|---:|---:|---:|---:|
| Neoverse N2 | words | 209.47 | 156.82 | 18.05 | 30.61 | 3.99 |
| Neoverse N2 | numerical | 210.63 | 158.03 | 18.23 | 30.33 | 4.04 |
| Neoverse N2 | callbacks | 208.39 | 155.77 | 18.16 | 30.62 | 3.84 |
| Neoverse N2 | http | 209.75 | 157.00 | 18.34 | 30.57 | 3.84 |
| EPYC 9V45 | words | 142.64 | 108.58 | 11.50 | 20.25 | 2.30 |
| EPYC 9V45 | numerical | 142.72 | 108.48 | 11.51 | 20.42 | 2.31 |
| EPYC 9V45 | callbacks | 144.75 | 110.21 | 11.75 | 20.55 | 2.25 |
| EPYC 9V45 | http | 138.54 | 104.88 | 11.35 | 20.13 | 2.18 |

Bodies include expression inference, binding preparation and signature unification.
Validation includes sizes, literal ranges, effects and resource captures. Remaining
work includes deferred operations, generalization and group setup/cleanup. Every
group's parts sum exactly to its inclusive time; all 1,590 library bindings remain
checked. Nested checks and failure reports retain their accounting tests.

The AMD64 host is **EPYC 9V45**, whereas the preceding application receipt used
EPYC 7763. Lower numbers are not a compiler speedup or an architecture ranking.
These instrumented boundaries do not measure observer overhead or identify which
individual body-checking operations consume CPU. Profile that region before
choosing an implementation; constraint lookup alone cannot explain its cost.

`arm/` and `amd/` retain full summaries, invocation commands, identities, toolchain
and build settings. Both complete job logs are clean and retained as gzip.
`analysis.json` has the table values; `audit.json` records jobs and artifact
identities; `files.json` lists retained hashes and sizes. Individual spans, C and
process logs remain in the identified CI artifacts until their recorded expiration.
Selected ZIP members passed CRC; whole-archive hashes come from GitHub.
