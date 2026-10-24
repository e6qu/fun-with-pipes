# Generated REST and MCP server memory

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

REST exposes functions as HTTP endpoints; MCP exposes them as tools over HTTP or
standard input. The [six-host report](server-entries-2026-10-18.json)
compares tracing/ARC at `8dfc014d`, including the exact-number JSON repair.
An earlier lossy-number implementation would not be equivalent work.

**Work:** [record/alias/error fixtures](../../tests/fixtures/server_entries.fwp).
Standard-input MCP cycles produce eight replies, including invalid requests;
notifications produce none. HTTP cycles make three requests (copy, alias, caught
error), followed by normal shutdown. Test 1/16/128 cycles, three fresh HTTP servers
per mode/count/transport; REST cleartext/TLS and MCP cleartext. Outputs match raw
interpretation. Builds use O2 and separate floating multiply/add rounding.

Counters cover post-constant setup through normal cleanup, including shutdown/
background work. Collection off, freeing on. Slopes between 16 and 128 cycles
are per additional reply/request, not isolated primitive costs:

| Workload | Managed allocations per additional reply/request | Reference-count increments |
|---|---:|---:|
| MCP standard input, eight-reply mix | 237.375 | 457.625 |
| REST HTTP/TLS, three-request mix | about 874.3–874.5 | about 2,426–2,427 |
| MCP HTTP, three-request mix | about 796.3–796.6 | about 1,969–1,970 |

Standard-input modes finish with zero counted bytes. A no-free control leaves
58,400/897,680/7,164,304 bytes, demonstrating detection of missing cleanup.
HTTP final charge is constant at the root-task totals: Linux AMD64/ARM64
1,792/6,144; macOS 640; Windows AMD64/ARM64 1,024/896 bytes.
Ordinary servers separately handle five batches of 1,024 cycles (15,360 requests),
sampling RSS after 100 ms settling. Largest post-warmup growth is 2 MiB; the limit
stays 8 MiB. These samples are not memory peaks.

Managed counters exclude raw/TLS/OS/allocator state and client memory. All 18
inspected ARC files omit tracing; 24 tracing controls retain it. **No time was
measured**, and these are not C/Rust overhead ratios.
[PR #164](../roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164)
records acceptance. Use `suite=server-entries`.
