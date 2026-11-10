# Borrowed compiler type walks: correctness and copy counts

**Both native Linux architectures pass.** The compiler makes about 1.1 million
fewer type-node copies per complete application, without changing traversal counts
or emitted C. These counts establish neither allocated bytes nor a speedup.
[Ordinary timing](../compiler-type-time-2026-11-10/README.md) now verifies all
complete-application targets and memory limits; four noisy growth comparisons
leave the [full frozen rule](../compiler-type-walks.md) open.

## Compared code and work

- Reference: `35a12dfee0266134237d03d1262649be69df7c41`, whose ordinary compiler
  sources equal merged PR #274.
- Candidate: `c65ecb37691538ef5a24619376f68b1d243cbdea`, retained by
  `roadmap/compiler-borrowed-types-2026-11-10`.
- Change: borrow input type trees during unresolved-variable search (`free_vars`)
  and substitution (`zonk`). Build the required substitution result once. Keep
  row flattening unchanged. [Examples](../../terminology.md#type-variables-and-substitution).
- Inputs: complete word-count, numerical tutorial, queued callback and HTTP API
  sources; twelve growing definition/generic/nesting inputs.

## Exact counts

Both hosts produce identical counts. Each row covers one complete compilation,
including library checking and later compiler passes.

| Application | Reference copies | Candidate copies | Copies removed |
|---|---:|---:|---:|
| Word counting | 3,470,860 | 2,376,227 | 1,094,633 (31.5%) |
| Numerical tutorial | 3,607,944 | 2,508,067 | 1,099,877 (30.5%) |
| Queued callbacks | 3,520,000 | 2,417,622 | 1,102,378 (31.3%) |
| HTTP API | 3,766,770 | 2,665,223 | 1,101,547 (29.2%) |

The unresolved-variable walk removes about 87% of its copies; substitution
removes about 85%. Remaining counts are roughly 105,000 and 73,000 respectively.
Rows still use the original copying implementation. Walk categories can overlap;
the total above comes from the independent total counter, not their sum.
Every application's walk-call counts match the reference exactly.

## Verification

[Run 42763406320](https://github.com/e6qu/fun-with-pipes/actions/runs/42763406320):
ARM64 job `129654174367`, AMD64 job `129654174360`. Both complete logs were audited;
there are no unexpected warnings, failures or ignored tests.

- Formatting and focused Clippy pass with production Rust O1 settings.
- Seven type tests pass, including four new controls for long variable chains,
  nested applications, row/effect order and recursive-type rejection.
- All eight compiler-option/report tests and the inferred-signature/error
  snapshot corpus pass.
- All sixteen reference/candidate generated-C comparisons are byte-identical.
  Early and late errors in each growth input retain exact diagnostics and locations.
- Each separately instrumented compiler preserves its ordinary compiler's C on
  all four applications. Observer patch/source hashes pass, and only the declared
  two diagnostic files differ in its checkout.

This focused run does not replace the final nine production jobs, documentation
and complete-log audit. It does not execute the generated applications or establish
runtime improvements; those applications' C is unchanged.

## Retained evidence

`arm/` and `amd/` contain complete compressed job logs, correctness/count reports,
source identity and observer patch/manifest. `counts.json` holds the shared counts;
`files.json` records byte sizes and hashes. Selected archive members passed ZIP
CRC, and report/source/patch checks were repeated locally within the resource guard.

`artifacts.json` retains GitHub archive digests and expiration. Whole archives
were not rehashed locally. Compilers, generated C and per-command diagnostics
remain in those named artifacts; small reports and complete logs are kept here.
