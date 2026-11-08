# Array callback inlining: no accepted gain

[Run 42433452458](https://github.com/e6qu/fun-with-pipes/actions/runs/42433452458)
passes 18 cases on each native Linux architecture at
`7a8d24c2efe475dacf6018fda03340253a4d7559`. Both versions preserve checked outputs;
all C builds finish without diagnostics. This tests a generated-C attribute,
not a production compiler change. [The protocol](../shared-loop-array-costs.md)
defines inputs, roles and measurement boundaries.

| Largest case: 129 coordinates, 199 updates, 32 solves | ARM64 | AMD64 |
|---|---:|---:|
| Manual derivative, extra process time with inlining | 1.11% | 1.59% |
| Local automatic derivative, extra process time with inlining | 2.04% | 1.17% |

These four comparisons pass their copy controls but show no gain. Many shorter
cases fail the 2% copy limit. The unchanged-source loop controls also vary,
including a 9.9% AMD64 difference at one million iterations. Short whole-process
timings cannot establish a computation speedup; no observations were discarded
or rerun for acceptance. Forced inlining is not selected for implementation.

| Host | Complete evidence | Convenient readers |
|---|---|---|
| ARM64 | [Archive](arm.zip), [artifact identity](arm-artifact.json), [job log](arm-job.log.gz) | [All results](arm-summary.json), [CPU/compiler/settings](arm-identity.json) |
| AMD64 | [Archive](amd.zip), [artifact identity](amd-artifact.json), [job log](amd-job.log.gz) | [All results](amd-summary.json), [CPU/compiler/settings](amd-identity.json) |

Both downloaded archive digests match GitHub's metadata. Archives retain source,
patches, binaries, GCC inlining/stack reports, every command and output. In this
first diagnostic, the single-solve interpreter input path was subsequently
overwritten by its documented 32-solve version. Its original body can be recovered
by removing that repetition wrapper. The script now retains the two input files
separately; the original archives remain unchanged.

The next candidate caches borrowed array metadata explicitly. It keeps bounds
checks and arithmetic, and requires separate correctness and performance evidence.
