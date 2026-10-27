# Storage for received stream values

The G5 probe owns its cache and drops it after the read sample. Its eleven-field
report includes bytes after owner release, which must be zero; all queued
messages must be freed. Omitting the cache drop must exit 40. Borrowed reads keep
the root alive throughout, so this measures cache representation, not consuming
iteration or network performance. Integrated validation is pending. The results
below use their original source and collection-era schema.

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

**Comparison:** separate source/result fields (`00c09cdc`) versus one shared
storage word (`4c26f21f`) in a received stream position. **Work:** queued messages
with 16-character strings; consume 1/32/128 values, reread each position, stop
halfway, or keep the first position while consuming the rest. Both versions
include the same shared-reader repairs. Collection is disabled for counting.
The [preceding](remote-stream-shared-2026-10-16.json) and
[compact](remote-stream-compact-2026-10-17.json) reports cover six hosts:

| Measurement | Separate source/result fields | Shared storage word |
|---|---:|---:|
| Bytes per position, aligned to 8 bytes | 24 | 16 |
| Managed allocation requests per received value | 4 | 4 |
| Requested bytes per received value | 89 | 81 |
| Bytes charged after allocator rounding, per value | 112 | 96 |
| Fixed setup bytes charged | 720 | 704 |
| Bytes charged after consuming 128 values, including setup | 15,056 | 12,992 |

This measures fwp storage, not elapsed time or C/Rust overhead. Socket I/O, raw
codec buffers, allocator pages and process memory are excluded. At this historical
stage clearing C references still leaves the cache charged without collection;
[last-owner cache cleanup](remote-client-storage.md#memory-used-by-complete-remote-stream-clients) later
fixes that. Actual binaries confirm the saved result moves from offset 16 to 0.
Reproduce with `suite=stream-owners` and `scripts/collect-stream-measurements.py`;
use its `--help` for the required baseline, run and source arguments.
