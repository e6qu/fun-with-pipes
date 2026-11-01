# Memory used by complete remote-stream clients

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

**Work:** a native client receives integers 1..N from an interpreted loopback
HTTP/2 server. N is 64, 1,024 or 16,384. Clients either sum the stream, keep the
first iterator and reread its first value after summing, or consume only 32
values. For N=64 they print `2080`, `(2080, [1])` and `528`.

**Method for client memory reports:** three fresh processes per case; O2;
collection off, freeing on. Counts start after constant setup and finish after
entry/cached-value cleanup, before runtime shutdown. They include managed
requests, bytes and retains, not raw wire buffers, allocator pages, TLS/OS state,
server memory or total process memory. These are memory checks, with **no timings
or C/Rust baseline**. Ordinary native/raw interpreter outputs must agree first.
Reports with forced connection closure say so; that changes the transport work.

The [baseline](remote-client-memory-baseline-2026-10-17.json),
`456f2dbd`, leaves 64 managed bytes per consumed integer. The
[cache-owner change](remote-client-cache-ownership-2026-10-17.json),
`886dad3b`, releases each position's saved values after its last reader:

| Native client | Baseline final charge, 16,384 values | Candidate final charge, each tested size | Candidate one-pass peak, each tested size |
|---|---:|---:|---:|
| Linux AMD64 | 1,055,296 bytes | 6,480 bytes | 6,832 bytes |
| Linux ARM64 | 1,068,352 bytes | 19,536 bytes | 19,888 bytes |
| macOS AMD64 | 1,051,296 bytes | 2,480 bytes | 2,832 bytes |
| macOS ARM64 | 1,051,296 bytes | 2,480 bytes | 2,832 bytes |
| Windows AMD64 | 1,052,448 bytes | 3,632 bytes | 3,984 bytes |
| Windows ARM64 | 1,052,064 bytes | 3,248 bytes | 3,600 bytes |

At every tested size, one-pass peak and final charge are constant. Keeping an
old iterator intentionally keeps history until released. At 16,384 values,
retains rise from 16,385 to 81,921: cleanup gains cost extra bookkeeping.
Five managed allocations per additional integer remain. These are single-call
results; repeated calls and unread transport queues need their own tests.

Alias, cancellation, failure and deliberately missing-release controls accompany
the profiles. Use `suite=stream-clients`,
`scripts/collect-stream-client-measurements.py` and, for static code evidence,
`scripts/inspect-stream-client-binaries.py`. The collectors inspect artifacts;
they do not execute downloaded binaries locally.

### Moving captured values instead of retaining them again

A closure carries values for a later call. Consuming its only owner can move
those captures; a shared closure must preserve them for other callers.
The [six-host report](remote-client-capture-moves-2026-10-17.json)
compares cache ownership with capture moves at `afd7d460`, using the identical
clients and counting boundary above. Three processes agree:

| Received integers | Original tracing-dependent cache | Explicit cache ownership | Cache ownership plus capture moves |
|---|---:|---:|---:|
| 64 | 65 | 321 | 194 |
| 1,024 | 1,025 | 5,121 | 3,074 |
| 16,384 | 16,385 | 81,921 | 49,154 |

At 16,384 values, moves remove about 40% of the new ownership path's retains,
but still leave about three times the tracing-dependent baseline's count traffic.
Final charge is unchanged and one-pass peak falls 64 bytes per host. Retained
histories still preserve older values. Actual AMD64/ARM64 code tests uniqueness
and skips capture retention only on that branch; dispatch and stack storage
remain. No timing was measured. Collector option `--capture-moves` checks this
comparison against the cache-owner report.
