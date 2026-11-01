# Fixed function values in the HTTP server

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

A function value can carry earlier arguments, called **captures**. If every
capture is itself a fixed function without captures, the compiler stores one
record in program storage instead of rebuilding it per request.

**Comparison:** the same ARC server before/after this change, `a141efd4` versus
`01ae40da`, then a paired repeat at `85988056` rebuilding the saved baseline C.
The [report](fixed-functions-2026-10-18.json) retains source/binary
hashes, hardware and every sample. Counts use the [HTTP-server protocol](remote-server-storage.md#http-server-ownership-and-memory):
1/16/256 `GET /hello` calls, three processes, cleartext/TLS. Slopes are the
256-call median minus the 16-call median, divided by 240; background work is included.

| Per additional HTTP request | Baseline | Candidate | Change |
|---|---:|---:|---:|
| Managed allocation requests | About 899 | About 722 | About 19.7% fewer |
| Actual reference-count increments | About 2,318 | About 1,901 | About 18.0% fewer |
| Allocations for classified fixed function records | 177 | 0 | 177 removed |
| Payload bytes for those records | 3,808 | 0 | 3,808 removed |

Both Linux hosts/transports agree. The tradeoff is 331 static records occupying
7,592 bytes and 618 startup address stores. Net data grows 5,240 bytes; code
shrinks 1.7% AMD64 / 1.4% ARM64. Final managed charge remains constant.

**Timing:** six fresh processes per version/transport, alternating order; 1,024
warm-up calls then 8,192 timed calls. The clock includes client startup, request/
response/network/server work; excludes compilation, server startup, warmup and
shutdown. Table entries are medians of six paired current/baseline ratios.
Clang 18.1.3, O2, `-ffp-contract=off`; EPYC 7763 and Neoverse-N2:

| Transport | AMD64 elapsed ratio | ARM64 elapsed ratio | AMD64 startup ratio | ARM64 startup ratio |
|---|---:|---:|---:|---:|
| Cleartext | 0.936 | 0.958 | 1.009 | 1.020 |
| TLS | 0.943 | 0.950 | 0.951 | 0.983 |

Request elapsed time falls about 4–6% in this run. Startup separately measures
spawn to listening announcement (roughly 1.4–2.3 ms cleartext, 4.2–5.7 ms TLS),
including loader/listener work; it does not isolate the address stores.
Six-host memory checks also pass, with at most 2 MiB sampled post-warmup RSS
growth. This is fwp versus older fwp, with **no C/Rust timing baseline**.
[PR #163](../roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records acceptance; use `suite=fixed-functions`.
