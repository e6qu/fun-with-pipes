# HTTP load after nested resource borrowing

**All 34 trials pass: 26,228,542 attempts, no failed requests, flat sampled server
RSS within every trial.** Source `cd661ff84b88736ceec83c75e0e2ecf7e6de551d`;
[run 42797169205](https://github.com/e6qu/fun-with-pipes/actions/runs/42797169205).
This checks sustained behavior. It does not compare speed with the old compiler,
Swift, C or Rust.

## Work and settings

The maintained server receives `GET /items/42` over plain HTTP/1.1 on loopback.
Every successful reply must contain the exact body `{"id":42,"name":"item 42"}`.
Each persistent connection waits for its complete response before sending again.

- Two sessions per architecture, two 30-second trials at 1/8/32/64 connections.
  Each trial starts a fresh server and has five seconds of warmup. Session 2
  reverses connection-count order; session 1 adds a 300-second, 32-connection soak.
- GCC 13.3.0 O2; explicit `armv8-a` or `x86-64`; no LTO, fast math or contraction.
  Rust 1.99.1 builds the compiler. The copied application explicitly allows
  10,000,000 requests per connection; no reconnect/retry hides failures.
- Server and generator use distinct allowed logical CPUs. Exclusive physical
  cores are not established. Requests have a five-second deadline; shutdown has
  a twenty-second deadline. All servers shut down successfully.
- Throughput counts correct replies completed inside the measurement window.
  Latency includes sending the request and consuming its reply, excluding setup
  and waiting to issue it. Logging costs throughput, outside request latency.

The [full protocol](../../benchmarks.md#sustained-service-load) explains the limits.
[Separate correctness controls](../nested-resource-http-checks-2026-11-10/README.md)
verify physical cleanup, cancellation, allocation observation and slow clients.

## Five-minute soaks

RSS is sampled process-resident memory, not managed heap or allocation traffic.
Here **p99** means 99% of successful replies completed within the given time.

| Host | Replies/second | p99, ms | Server RSS, MiB | Generator CPU, cores |
|---|---:|---:|---:|---:|
| ARM Neoverse-N2 | 18,813 | 2.564 | 11.15 | 0.200 |
| AMD64 Intel Xeon Platinum 8370C | 13,507 | 3.436 | 12.20 | 0.204 |

All one-second RSS samples are flat within each of the 34 trials. Across trials,
server RSS ranges from 8.78 to 15.33 MiB. This does not establish zero allocations,
absence of transient peaks between samples, or a bound for all programs.

The second AMD64 session uses an **AMD EPYC 9V74**, not the Intel CPU above.
Keep sessions separate; their throughput difference is not a compiler regression.
Both ARM64 sessions use Neoverse-N2. All individual throughput, latency, CPU and
memory results remain in [analysis.json](analysis.json).

## Evidence

| Host/session | Job | Full artifact |
|---|---|---|
| ARM64 / 1 | `129765193815` | `13754559527` |
| ARM64 / 2 | `129765193736` | `13754054734` |
| AMD64 / 1 | `129765193955` | `13755333926` |
| AMD64 / 2 | `129765193799` | `13754653088` |

Four `*-reports.zip` files retain summaries, identities and complete process traces;
four `*-job.log.gz` files retain complete logs. No unexpected test failure or
compiler warning appears in those logs. [Run](run.json), [artifact](artifacts.json)
and [file](files.json) receipts record identities and hashes.

[review-traces.py](review-traces.py) independently reconstructs trial accounting,
throughput and every process-memory/CPU summary. Extract a report ZIP and run it
with explicit `--input DIRECTORY --output SUMMARY.json` arguments. All four pass.
Each runner checks every raw HTTP attempt. Those millions of attempts were not
reread locally; raw streams and native binaries remain in the full CI artifacts.
Only small selected members were downloaded and ZIP-CRC-checked, not entire ZIPs;
whole-artifact digests are recorded GitHub metadata, not locally verified hashes.

[The ownership contract](../nested-resource-owners.md) still requires ordinary
service timing, compiler-cost measurements and final platform gates.
