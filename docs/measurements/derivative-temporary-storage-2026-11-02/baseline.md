# Recorded baseline

This is the compiler before packed temporary storage. Return to the
[results](README.md) for the candidate and current verification status.

Source: `bb2e5b29fa6f53b3f187c3fba3fd15d38ff4085b`.
[Run 41497441785](https://github.com/e6qu/fun-with-pipes/actions/runs/41497441785)
passes both native jobs. Full logs and archive digests are audited; all 96
observations agree across architectures. The [complete counts](baseline.json.gz)
retain every phase, allocation/ownership site, raw-storage observation, file hash
and binary/stack cost. [Artifact metadata](artifacts.json) identifies both complete
archives. The source/measurement protocol is [the existing phase observer](../derivative-forward-costs.md).

| Host | Compiler | Job / artifact |
|---|---|---|
| ARM64 Neoverse-N2 | GCC 13.3.0-6ubuntu2~24.04.1 | `125455982054` / `13168172282` |
| AMD64 EPYC 7763 | GCC 15.2.0-16ubuntu1 | `125455981525` / `13167838127` |

Each host runs six inputs, current/history forms, O1/O2 and workspace reuse off/on.
One observation performs one complete solve. An update subtracts `0.001 * gradient`
from each coordinate; initial coordinates alternate -1.2 and 1.0. Current retains
only the latest vector; history retains all vectors before selecting the last.
Both produce the same complete final vector.

For the current form at O2, workspace off:

| Coordinates | Updates | Whole-solve requests | Requested bytes | Peak managed charge | Pair-result records |
|---:|---:|---:|---:|---:|---:|
| 3 | 0 | 4 | 98 | 128 | 0 |
| 3 | 1 | 42 | 1,088 | 448 | 2 |
| 3 | 199 | 7,368 | 183,249 | 480 | 398 |
| 3 | 1,999 | 73,968 | 1,839,244 | 480 | 3,998 |
| 33 | 199 | 55,158 | 1,712,942 | 5,568 | 6,368 |
| 129 | 199 | 208,086 | 6,607,982 | 21,888 | 25,472 |

Final managed and raw storage are zero in every observation. Managed charge is
allocator-accounted live storage, not RSS. Raw tape/workspace storage is reported
separately; these are not additive peak-memory measurements.

The largest current solve spends 130,147 requests / 3,925,896 requested bytes in
forward calculation and recording. History has the same forward counts but a
larger whole-solve peak: 841,024 bytes rather than 21,888. This is expected retained
history, not a leak.

The [callback audit](callback-boxes.json) verifies all 48 generated sources and
96 observations. In the [largest saved ARM64 source](largest-current-arm64.c.gz):

| Result | Generated function | Record allocations over 199 updates |
|---|---|---:|
| Input derivative values | `f167` | 25,671 |
| Adjacent-pair results | `f164` | 25,472 |
| Final fold result | `fwp_record_fold127` | 199 |

`w28` builds the pair-result list, drops its input-list owners, obtains the cached
zero seed, then calls the fold. The intermediate list has no other consumer.
The fold already keeps its accumulator fields in locals. The proposed change
targets mapped results and their list cells, not those already-removed accumulator
boxes. Function numbers identify this saved source only.
