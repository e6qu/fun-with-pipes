# Shared tape access: original executable verification

Both architectures reproduce all **48 original measured executables** byte for byte. This checks the actual images used for the measurements;
it takes no new timings and does not establish a speedup.

[Run 42256902374](https://github.com/e6qu/fun-with-pipes/actions/runs/42256902374)
uses diagnostic source `3595f4b0cec1e37bc7874fca5e09bb176c87a1af`.
The [input plan](../recording-context-call-inputs.json) selects session 1 from
each architecture: ARM source `319782736b0a983022f2a48879b35c9e57992949`,
AMD source `1720c3b8cd06d7756295186233181cd64544bf44`. The later source changes
measurement policy and docs; its compiler/runtime/library/test trees are identical.

Each architecture rebuilds six cases × two result forms × two versions:

- Use saved C, the same GCC version and original production flags.
- Add only GCC's inlining report; require the original executable hash.
- Require scalar append inlining in both reference and candidate, with no final
  rejection. Positive-update programs must report successful inlining.
- Retain source, executable, stack and inlining hashes; require empty compiler
  stdout/stderr. Execute no generated program.

ARM job `128026386626` and AMD job `128026386739` pass. All 48 source/image/stack/inlining hashes,
original commands and the complete log also pass bounded local verification
(0.25 s ARM, 0.90 s AMD). There are no unexpected diagnostics. Inlining report entries describe
compiler decisions, not executed call counts or elapsed time.

| Architecture | Results | Full log | Artifact |
|---|---|---|---|
| ARM64 | [summary](aarch64-summary.json) | [log](aarch64-job.log.gz) | [identity](aarch64-artifact.json) |

| AMD64 | [summary](x86_64-summary.json) | [log](x86_64-job.log.gz) | [identity](x86_64-artifact.json) |

`aarch64.zip` and `x86_64.zip` retain every source, image, command and compiler report.
[Runtime results](../recording-context-time-2026-11-06/README.md) retain every
missed limit. Final production acceptance remains separate.
