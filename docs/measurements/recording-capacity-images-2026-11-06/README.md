# Checked capacity gate: native verification

All **48 original measured executables** reproduce byte for byte. GCC reports
capacity-check inlining in every positive-update candidate program, with no final
rejection for `fwp_tape_reserve`. This verifies the intended transformation in
the measured images; it does not replace correctness or timing measurements.

[Run 42184258186](https://github.com/e6qu/fun-with-pipes/actions/runs/42184258186)
passes on native ARM64 (`127780749617`) and AMD64 (`127780749478`). Diagnostic
source: `65b253e64a8cd5008274f2c8d1aee1f9fecc74bc`. The
[frozen plan](../recording-capacity-call-inputs.json) selects audited session 1
from each architecture, source `51edfc0e7884e1a75201bc9876fd13cb8ca25eee`.

The check rebuilds saved C using the original production flags, adding only GCC's
inlining report. It requires the original executable hash and audits compiler
output, source, stack and report hashes. It executes no native program and takes
no new timings. Each architecture supplies six cases × two result forms × two
versions = 24 executables.

In the 129-coordinate, 199-update case, both result forms show one capacity-gate
inlining decision in the candidate and none in the reference; the reference has
seven final rejected capacity-inlining sites. These are compiler decisions, not
dynamic execution counts. Append inlining remains enabled in both versions.

| Architecture | Results | Full log | Artifact |
|---|---|---|---|
| ARM64 | [summary](aarch64-summary.json) | [log](aarch64-job.log.gz) | [identity](aarch64-artifact.json) |
| AMD64 | [summary](x86_64-summary.json) | [log](x86_64-job.log.gz) | [identity](x86_64-artifact.json) |

`aarch64.zip` and `x86_64.zip` retain every source, image, stack report, compiler
command and inlining decision. Their digests and every member used by each
compilation were verified locally. Full producer logs contain no unexpected
diagnostics. [Runtime results](../recording-capacity-time-2026-11-06/README.md)
retain all missed limits; final platform delivery still follows.
