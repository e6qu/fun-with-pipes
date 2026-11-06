# Inlining measurement controls

Fourteen suites, **107 tests**, pass at `a029797e3a158f9cbb2aaa3ff0ba78fbf3d62d84` in
[run 42157525720](https://github.com/e6qu/fun-with-pipes/actions/runs/42157525720),
job `127695118390`. They check exact reference edits, lookup/phase counters,
allocation and timing limits, compiler measurement failures, native prerequisites
and retained artifact/log integrity. The [inlining contract](../recording-inline.md)
keeps the same limits as its predecessor.

[All suite logs](artifact.zip), [artifact identity](artifact.json), [job metadata](job.json)
and the [complete job log](job.log.gz) are retained. Every suite ends successfully;
the ZIP digest, source identities and complete log diagnostics were checked.
This verifies measurement controls, not a runtime speedup or final platform support.
