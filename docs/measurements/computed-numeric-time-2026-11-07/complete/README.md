# Complete improved-program observations

[Retention run 42419504241](https://github.com/e6qu/fun-with-pipes/actions/runs/42419504241)
passes for producer `42417868388`, source
`8b24da94a4e54c023f5e4b2341896d97dff092b9`. No measurements were repeated.

Each `*-observations.tar.xz` retains every saved process observation, source,
native executable, disassembly, counter, phase observation, RSS and stack report
for its session. The runner verifies all original hashes and all six cases,
including exact request/retain parity with handwritten arrays and zero tape
activity. Original producer audits and complete job logs are retained separately.

[index.json](index.json) records original jobs/artifacts, archive hashes and the
one inconclusive copy control. [artifact.json](artifact.json) identifies the
downloaded retention bundle. Its digest and all four retained archive hashes
were verified under the local guard (0.13 s). See [the results](../README.md).
