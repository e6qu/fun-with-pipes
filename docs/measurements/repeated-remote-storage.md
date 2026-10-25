# Memory left behind by repeated remote calls

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

**Work:** repeat the same 64-value remote call in one process for 1/16/256
batches. Full readers sum to 2,080; partial readers take 32 values and sum to 528.
Retained readers make two calls per batch, keeping the first iterator until a
reread: batch output 4,161. Three processes per case reuse one connection.
The [client counter boundaries](remote-client-storage.md) apply throughout this report.

The [baseline](repeated-remote-baseline-2026-10-17.json), `ac95632b`,
leaves 240 extra managed bytes per call on all six hosts. Full/retained readers
free queued messages, but partial readers leave 609 raw message bytes per call
in these samples: 155,904 after 256 calls. Queue occupancy can vary with scheduling.
Pooled connections and their I/O tasks are still live at the final sample;
their fixed storage is not a demonstrated leak. This identifies per-call
retention without measuring execution time.

### Releasing finished requests and unread messages

The [six-host request-owner report](remote-request-ownership-2026-10-17.json)
compares `ac95632b` with `997b23a9` on those identical repeated clients.
The connection's active list, reader and sender own the request. Releasing a
reader discards unread messages; it does not cancel an unfinished remote call.

Final charge becomes constant: 6,240 bytes Linux AMD64, 19,296 Linux ARM64,
2,240 either Mac, 3,392 Windows AMD64 and 3,008 Windows ARM64. Every request and
message releases, including the partial reader's previously retained 155,904
message bytes. Allocation counts are unchanged; one retain per call is added.
The 232-byte request header uses existing padding for its new flag.

Alias, failure and cancellation controls check every owner. The report measures
memory/counts, not time. Connections still needed separate cleanup at this
revision. Use `suite=stream-repeat` and
`scripts/collect-repeated-client-measurements.py` with the baseline report.

### Moving a selected field instead of retaining it again

**Comparison:** request cleanup at `997b23a9` versus `d7a161d1`, with the same
repeated-call programs and counters. Consuming a uniquely owned record can
transfer its selected owned field; shared records retain the field instead.
The [six-host report](remote-projection-moves-2026-10-17.json) records:

| After 256 batches, on every measured platform | Request cleanup alone: count increments | With compiler transfer | Reduction |
|---|---:|---:|---:|
| Full reads, 256 calls | 66,562 | 50,178 | 24.6% |
| Partial reads, 256 calls | 41,986 | 33,794 | 19.5% |
| Retained readers, 512 calls | 116,226 | 99,586 | 14.3% |

Allocation requests, bytes and final charge are unchanged; every request/message
releases. Actual AMD64/ARM64 code skips field retention on the unique path.
Other count lookups, result storage and dynamic calls remain. These percentages
are reductions in retain counts, not elapsed-time overhead.

### Memory after closing connections and finishing their I/O tasks

**Changed workload:** measurement hooks now close each connection and wait for
its reader/writer tasks before the next call. Keep the same full/partial/retained
clients, 64 integers, 1/16/256 batches and three processes. Ordinary interpreter
references still use pooling for output checks, so they do different transport
work. Compare revisions only with the same closure hooks.

In the [six-host baseline](closed-remote-baseline-2026-10-17.json),
`4103b0a0`, sockets close and tasks finish, but their records remain allocated:

| Platform | Connection allocation, charged bytes | Two I/O task allocations, charged bytes | Additional remaining bytes per connection |
|---|---:|---:|---:|
| Linux AMD64 | 320 | 3,584 | 3,904 |
| Linux ARM64 | 320 | 12,288 | 12,608 |
| macOS AMD64 and ARM64 | 320 | 1,280 | 1,600 |
| Windows AMD64 | 320 | 2,048 | 2,368 |
| Windows ARM64 | 320 | 1,792 | 2,112 |

Counts stop after task draining and cached-value cleanup, before runtime shutdown.
Collection is off; freeing is on. Stack pools, raw buffers, allocator/TLS/OS state,
server/process memory and time are excluded. Empty task lists alone do not prove
that task records were freed; retained binaries confirm the missing release paths.

### Freeing closed connections and finished tasks

The [six-host comparison](closed-remote-ownership-2026-10-17.json)
compares `4103b0a0` with `3a773a85`, using the same forced-close workload.
Connections gain explicit owners; finished internal I/O tasks free directly
after removal from scheduler lists and stacks.

| Platform | Before: remaining managed bytes after 256 full reads | After: remaining bytes at 1, 16 or 256 batches |
|---|---:|---:|
| Linux AMD64 | 1,001,216 | 1,792 |
| Linux ARM64 | 3,233,792 | 6,144 |
| macOS AMD64 and ARM64 | 410,240 | 640 |
| Windows AMD64 | 607,232 | 1,024 |
| Windows ARM64 | 541,568 | 896 |

The constant remainder matches one still-live root-task allocation. Every
connection/request/message releases. Allocation requests are unchanged, but
sharing adds three retains per connection: 50,178 → 50,946 for 256 full reads,
about 1.5% more. Task disposal adds no task count updates. These are counting
costs, with no elapsed-time or C/Rust comparison. Failure, cancellation and
missing-release controls pass. Use `suite=connection-repeat` for this workload.

### Memory retained by client inputs after sending finishes

**Work:** 1/16/256 remote calls, three processes each, with forced connection
closure/task draining. Four inputs test distinct lifetimes: sum integers 1..64
(output 2,080); uppercase `word-1`..`word-64` (total length 439); keep and reread
those strings (878); or offer 64 integers while the server returns only the
first three ×10 (60). Early completion sends a scheduling-dependent input count.

The [six-host baseline](sender-input-baseline-2026-10-17.json),
`f6ebb2e9`, already frees connections, requests and received messages but leaves
input/sender storage. Each additional complete synchronous call leaves 7,104
managed bytes; bidirectional/retained calls leave 11,952–17,456 depending on host.
Actual binaries show unowned iterator advancement and missing sender input cleanup.
The client-memory counter boundaries/exclusions apply; there is no timing
comparison. Ordinary output checks use pooling and cannot substitute for these
forced-close ownership measurements.

### Input owners and moves: bounded memory with measured count costs

The [six-host final report](sender-input-ownership-2026-10-17.json),
`06f3ac6f`, uses those same clients and forced-close hooks. Final managed charge
is constant for every tested size/mode: 1,792 bytes Linux AMD64; 6,144 Linux ARM64;
640 either Mac; 1,024 Windows AMD64; 896 Windows ARM64. Those totals match the
still-live root-task category. All transport/sender owners release.

An [initial Linux probe](sender-input-ownership-probe-2026-10-17.json)
bounded memory by retaining each continuation (the function producing the next
iterator node). The final compiler moves a unique node's continuation instead;
shared nodes preserve it. At 256 complete-input calls:

| Input mode | Original baseline | First ownership probe (Linux AMD64) | Final owners and moves | Extra versus baseline |
|---|---:|---:|---:|---:|
| Synchronous | 17,922 | 66,818 | 18,946 | 1,024 (+5.7%) |
| Bidirectional | 150,274 | 280,578 | 184,322 | 34,048 (+22.7%) |
| Retained original input | 181,762 | 344,834 | 248,578 | 66,816 (+36.8%) |

Allocation counts stay unchanged. Sender records request eight more bytes each,
within the same allocator size class. Early completion can consume different
input counts, so its deltas are not equal-work comparisons. Runtime uniqueness
checks and shared counts remain; the percentages above are **count overhead,
not time overhead**. [PR #159](../roadmap-history.md#streamed-input-cleanup-and-continuation-moves-pr-159)
records acceptance. Use `suite=sender-repeat`.
