# Memory used by generated REST and MCP servers

These checks measure fwp against itself: an ordinary server, the same server
with allocation counters, and an intentionally broken release path. They do not
compare elapsed time with C/Rust or estimate language-wide overhead. The
collector-free implementation passed integrated validation in
[#217](../roadmap-history.md#tracing-gc-removal-pr-217).

[The test](../../tests/server_entry_ownership.rs) uses
[one service](../../tests/fixtures/server_entries.fwp). REST exposes its functions
through HTTP; MCP exposes tools through HTTP or standard input. The interpreter
establishes expected responses, including record aliases, malformed input,
notifications and caught errors. Native responses must match before memory
measurements are accepted. Numeric JSON/CSV cases also compare exact values and
traps at C O1/O2.

## Work and observation points

| Case | Input | Required observation |
|---|---|---|
| MCP standard input | 1, 16 and 128 repetitions of eight replies | Final managed storage stays constant. The otherwise identical C program with physical frees omitted must accumulate storage. |
| REST HTTP/TLS and MCP HTTP | 1, 16 and 128 cycles of three requests, three fresh measured processes each | Every response matches the interpreter; final managed storage stays constant. |
| Persistent HTTP servers | Five batches of 1,024 cycles: 3,072 requests per batch | Resident memory after each completed batch stays less than 8 MiB above the first batch. |

Allocation counters run after constant initialization through entry completion
and cached-value cleanup, before runtime teardown. They report allocation requests,
requested bytes, actual reference-count increments, peak charged bytes and final
charged bytes. They exclude raw transport/TLS buffers, OS storage, allocator
metadata and client memory. Endpoint differences divided by added replies or
requests estimate incremental allocation/count cost; they are not timings or
isolated primitive costs.

Resident memory includes those process-level costs. Each batch uses a fresh
client; the server's connection limit exercises connection replacement. Sampling
waits 100 ms after the client exits. Linux uses VmRSS, macOS uses `ps` RSS, and
Windows uses WorkingSet64. These are samples, not peak memory measurements.

## Reproduction and evidence

The runner-only tests require `FWP_SERVER_ENTRY_ARTIFACTS`; the HTTP test also
requires `FWP_ENTRY_INTERFACE=rest` or `mcp`. They use native C O2 and separate
floating-point multiplication/addition rounding. The workflow records source,
compiler, CPU and platform identities.
[The report reader](../../scripts/summarize-server-entries.py) requires all six
native hosts. Per host it checks six standard-input rows, 27 HTTP rows, 15 RSS
samples and four ordinary binaries, including the omitted-free control. Binary
headers must match the host; collector symbols must be absent. Source hashes,
section sizes and generated C accompany the results. A missing row or failed
control invalidates the report; historical data keeps its original schema.
