# Compiler and HTTP preparation checks

**Correctness evidence, not sustained timing results.** Both Linux architectures
exposed two bounded failures. Their original reports remain here; repairs need
new native verification. [Remaining protocol](../application-tooling.md).

| Check | Recorded source | Result |
|---|---|---|
| Compiler reports and applications | `5f8dd5a881821a4471d176e8347681a630289079` | Both hosts pass: four command contracts, Clippy, SDK applications, integer boundaries and O0–O3 inspection; AMD64 browser passes |
| Report-file safety repair and applications | `e560937cbdb2b5e8072c7a2fe46fe2e4dd69e969` | Both hosts pass, including the fifth contract for a missing import |
| Compiler growth inputs | `a51a837f268feccbfaa366749868e83aab6e50e6` and `e560937cb` | Eleven of twelve cases pass on both hosts; 512 independent generic uses hit the old global instance cap |
| HTTP driver and physical cleanup | `e560937cb` | Native driver success/wrong/partial/timeout controls, heap/socket/cancellation checks, item allocation counts and disabled-counter rejection pass on both hosts |
| One-second API check | `e560937cb` | Both hosts reject the example's intentional close after 1,000 requests per connection |

[First application run](https://github.com/e6qu/fun-with-pipes/actions/runs/42711448460),
[repaired application run](https://github.com/e6qu/fun-with-pipes/actions/runs/42715261073),
[first growth run](https://github.com/e6qu/fun-with-pipes/actions/runs/42712222725),
[repeated growth checks](https://github.com/e6qu/fun-with-pipes/actions/runs/42715266501),
[HTTP checks](https://github.com/e6qu/fun-with-pipes/actions/runs/42715271649).
Documentation passes at [the first observer source](https://github.com/e6qu/fun-with-pipes/actions/runs/42711453469)
and [the combined source](https://github.com/e6qu/fun-with-pipes/actions/runs/42715276966).

## What failed and why

- **Generic uses:** `keep : a -> a` with 512 distinct record types triggered the
  global 500-instance limit. There is no recursive call in this input. The repair
  tracks dependent instantiations along an expansion path, keeping the same
  recursion bound. Parent links follow queued and lifted work.
- **HTTP connections:** each worker records exactly 1,000 attempts. Its final
  response contains `connection: close`; both streams together have 1,998 normal
  responses and two rejected closures. The measurement will explicitly configure
  10,000,000 requests per connection, retain the changed source and keep retries
  disabled. The maintained example's policy is not a server bug.
- **Failure reporting:** blank assertion summaries made the second failure hard
  to diagnose. Raw records exposed the cause; subsequent summaries retain full
  tracebacks and command diagnostics.

All completed targets and complete job logs were inspected. No compiler warning
is hidden by these outcomes. ResourceWarning text in command lines selects a
Python error policy; it is not an emitted warning.

## Allocation and memory scope

The item diagnostic verifies 344 correct `/items/42` replies over eight cohorts.
It also checks incomplete POST disconnects and cancellation separately. After
every cohort, the server retains **2,640 managed heap bytes**, one listener task
and **532 metric-table bytes**. Final managed charge returns to zero and all
72 accepted sockets close. These are measured diagnostic states, not a promise
of zero process memory after shutdown.

| Quantity, complete diagnostic run | ARM64 | AMD64 |
|---|---:|---:|
| Heap allocation events, including slot reuse | 118,943 | 120,850 |
| Charged and reclaimed heap bytes | 3,714,800 | 3,760,320 |
| Peak live heap-slot bytes | 27,760 | 27,792 |

Totals include connection setup, the item cohorts, partial requests, metrics
polling and cancellation. Packet boundaries and scheduling can change allocation
counts. Do not divide these totals by 344 and call the result isolated per-item
cost. Raw C buffers, stacks, allocator pages and process RSS are separate; each
host retains its RSS table. This instrumentation is outside ordinary load timing.
The deliberately disabled allocation counter fails its intended observer.

## Retained files

- `audit.json` reconstructs both complete 2,000-attempt streams and checks their
  final response bytes. Warmup is zero in these one-second correctness checks.
- Each host retains compressed complete HTTP/growth logs, original growth
  summaries and the exact generic failure, small HTTP reports, raw compressed
  attempts, response dictionaries and physical cleanup records.
- `application-*.log.gz` retains complete successful application job logs.
- `files.json` records sizes and SHA-256 for the evidence files. Small extracted
  artifact members passed ZIP CRC checks. Complete generated C and binaries stay
  in the linked runs' artifacts; they are not duplicated in this compact receipt.

No paired compiler timing, 30-second service trial or five-minute soak is covered
by this receipt. Later source changes require their own checks.
