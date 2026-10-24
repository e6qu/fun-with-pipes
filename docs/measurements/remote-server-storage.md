# Server memory after completed remote calls

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

**Work:** four loopback service operations: greet a 64-character name (71-character
response); return integers 1..64 (sum 2,080); sum 64 received integers (2,080);
or send `tick 1`..`tick 64` through a channel (total length 439). A channel passes
values between computations; this one writes to the remote client.

**Method for this server series:** 1/16/256 calls on one connection; three fresh
servers per case; native O2; collection off, freeing on. Counters start after
listener/routing/root setup and finish after client disconnect and task retirement,
with the listener still open. A measurement-only listener wake retires the last
finished stack. Revisions must use this same boundary. Raw wire buffers, stack
pools, allocator/TLS/OS metadata, process memory and elapsed time are excluded.
There is **no C/Rust baseline**. Native/interpreted responses must agree.

The [six-host baseline](server-call-baseline-2026-10-17.json),
`06432959`, leaves these managed bytes after 256 calls:

| Platform | Greeting | Returned iterator | Sent iterator | Output channel |
|---|---:|---:|---:|---:|
| Linux AMD64 | 721,248 | 2,486,624 | 1,753,440 | 971,104 |
| Linux ARM64 | 1,844,064 | 3,609,440 | 2,876,256 | 2,093,920 |
| macOS ARM64 or AMD64 | 423,488 | 2,188,864 | 1,455,680 | 673,344 |
| Windows AMD64 | 522,560 | 2,287,936 | 1,554,752 | 772,416 |
| Windows ARM64 | 489,536 | 2,254,912 | 1,521,728 | 739,392 |

On Linux AMD64 each additional call leaves 2,800/9,696/6,832/3,776 bytes for the
four operations. Binaries show unfreed task/job records and unowned method/result
calls. The [fixture guide](../../tests/fixtures/server-memory/README.md) explains the
programs. The following stages repair different owners; these old counts are
not the accepted compiler's remaining leaks.

### Freeing finished server tasks and keeping argument slots on the stack

The [six-host storage report](server-call-storage-2026-10-17.json)
compares `06432959` with `e6455c0d`, using the server method above. It frees
finished job/task records and puts temporary method arguments on the stack.
Each call saves one allocation and 24 requested heap bytes; retains are unchanged.

At 256 calls Linux final charge becomes 119,648/1,885,024/1,151,840/369,504 bytes
for greeting/returned stream/sent stream/output channel. macOS/Windows are 544
bytes lower. Memory still grows per call: method values and transport owners
remain unfinished at this stage. The one-argument helper uses 48 more stack
bytes, a measured heap/stack tradeoff, not a whole-program stack bound.

### Freeing method arguments and results: Linux measurement

The [Linux AMD64 intermediate report](server-method-values-linux-2026-10-17.json)
compares `e6455c0d` with `48ccd3d9` on the same server workloads. Typed cleanup
owns method arguments/results through errors and cancellation; methods receive
arguments directly, without a temporary function object. At 256 calls:

| Workload | Storage change | With argument/result cleanup |
|---|---:|---:|
| Greeting | 119,648 | 62,304 |
| Returned iterator | 1,885,024 | 62,304 |
| Sent iterator | 1,151,840 | 62,304 |
| Output channel | 369,504 | 365,408 |

Greeting/returned/sent streams still leave 240 extra bytes per call. Greetings
add one retain per call; received streams fall from 253 to 128. Every call saves
one allocation/eight bytes, with an additional allocation/24 bytes saved for sent
iterators. This stage covers one host; the following report extends the work.

### Freeing server values and output channels on all six hosts

The [six-host report](server-values-2026-10-17.json), `855fe3d1`,
compares against storage stage `e6455c0d` using the same method. It adds owned
method values and output channels that borrow each sent value. After 256 calls,
all four workloads leave 62,304 managed bytes on Linux and 61,760 elsewhere.
That is still **240 extra bytes per call**; request ownership is not yet fixed.

Against the original server baseline, each greeting/returned-stream call saves
two allocations; each sent-stream/channel call saves three. Requested-byte
savings are 32/32/56/32. Retains per call change from 0/64/253/0 to 1/64/128/64.
These are counts, not timings. The channel send loop still retains its channel
on each iteration, motivating the next borrowing change.

### Freeing server requests and borrowing fold captures

The [six-host report](server-borrows-2026-10-17.json), `8ed65cc7`,
compares the same four programs with `855fe3d1`. Requests and connections gain
explicit last-owner cleanup. Known fold callbacks borrow captured values kept
alive by the enclosing call, avoiding per-iteration count traffic.

| Native hosts | Previous stage, after 256 calls | With request/connection owners and borrowing |
|---|---:|---:|
| Linux ARM64 and AMD64 | 62,304 bytes | 544 bytes |
| macOS ARM64 and AMD64 | 61,760 bytes | 0 bytes |
| Windows ARM64 and AMD64 | 61,760 bytes | 0 bytes |

The old per-call growth disappears at all counts/repetitions. Allocation requests
and bytes are unchanged from the preceding stage. Retains still pay for sharing:

| Workload | Previous stage, retains per call | Combined change, retains per call |
|---|---:|---:|
| Greeting | 1 | 3 |
| Returned integer stream | 64 | 66 |
| Received integer stream | 128 | 132 |
| Output channel sending 64 texts | 64 | 4 |

There is also one retain per connection. Borrowing removes 64 retain/release
pairs per channel call. Actual Linux loops keep the channel in a register through
sends; other ownership/stack work remains. Instruction sections grow by
2,536 AMD64 / 2,352 ARM64 bytes. No speedup follows from counts or code size alone.

A separate 32,000-call Linux ARM64 test originally exposed RSS growth from
17,104 to 49,420 KiB, despite the managed-counter improvements. The complete
repair passes the unchanged 8 MiB limit with five 8,136 KiB samples.
[PR #160](../roadmap-history.md#server-cleanup-and-borrowed-fold-values-pr-160)
records full acceptance. Use `suite=server-repeat`.

### Remote services without tracing and with fewer field retains

The [six-host report](remote-arc-field-moves-2026-10-17.json)
compares tracing code with collection disabled (`8ed65cc7`) against checked ARC
plus unique record-field moves (`efaab358`). Both use the same four server
workloads, inputs, O2 builds and counting boundary. ARC binaries omit tracing
scan/mark/sweep routines; all 216 memory rows match for allocations, bytes and
peak/final charge. Final charge remains 544 bytes Linux, zero elsewhere.

Moving a greeting record's string reduces retains from three to two per call;
other workloads keep 66/132/4 retains, plus one per connection. At 256 greetings,
769 retains become 513. This saves bookkeeping without removing message storage.
Instruction sections nevertheless grow 2.9% AMD64 / 3.4% ARM64, partly because
ARC ownership checks inline repeatedly. The later shared-check experiment below
addresses this cost. File-size jumps also include alignment padding.

The separate 32,000-call RSS test reports constant 16,084 KiB AMD64 and 8,144 KiB
ARM64. These process samples differ from managed counters and are not peak bounds.
No elapsed-time or C/Rust comparison was made.
[PR #161](../roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161)
records acceptance; use `suite=server-arc`.

### HTTP clients without tracing

**Comparison:** the same fwp HTTP client in tracing and checked ARC, source
`8770c03e`. **Work:** 1/16/256 sequential HTTP/2 requests to an interpreted
loopback server, consuming each body and summing status 200. One connection is
reused; test cleartext/TLS, three fresh client processes each. O2, separate
floating multiply/add rounding. [Six-host report](http-client-owners-2026-10-17.json).

Counts run after constant setup through entry/cached-value cleanup, before
runtime shutdown. Collection is disabled and freeing enabled in both modes.
They include iteration, options/URL handling and responses, not just transport.
All 216 rows match between modes. Each additional call costs **237 managed
allocations and 543 retains**. Final charge is constant; pooled connections/tasks
can still be alive:

| Native host | Final managed bytes | Peak managed bytes |
|---|---:|---:|
| Linux AMD64 | 6,368 | 9,392 |
| Linux ARM64 | 19,424 | 22,448 |
| macOS AMD64 | 2,368 | 5,392 |
| macOS ARM64 | 2,368 | 5,392 |
| Windows AMD64 | 3,520 | 6,544 |
| Windows ARM64 | 3,136 | 6,160 |

Raw wire buffers, TLS/OS/allocator state, server memory and process RSS are
excluded. No time was measured. ARC removes tracing symbols in 24 inspected
binaries, but the larger comparison client's code grows 11.1–14.1% through
repeatedly inlined ownership checks. This is code size, not measured cache cost.
Windows cancellation-probe header order was repaired before
[PR #162 acceptance](../roadmap-history.md#http-client-owners-and-complete-connection-keys-pr-162).
Use `suite=http-clients` and `scripts/inspect-http-client-binaries.py`.

### HTTP server ownership and memory

**Comparison:** the same [server](../../tests/web/server.fwp) in tracing and ARC,
`cd4f0b06`. **Work:** 1/16/256 sequential HTTP/2 `GET /hello` requests from a
native ARC client, then one HTTP/1.1 shutdown request and task draining. Three
fresh servers per count/mode/transport; cleartext and TLS; O2 with
`-ffp-contract=off`. [Six-host report](http-server-owners-2026-10-17.json).

Counters cover post-constant setup through main/cached-value cleanup, before
runtime shutdown, with collection off/freeing on. The original server costs
about 899 allocations and 2,318 retains per additional call; background work
causes small fractional slopes. Final charge stays constant:

| Host | Final managed bytes | Peak cleartext / TLS bytes | Largest RSS increase after warm-up |
|---|---:|---:|---:|
| Linux AMD64 | 1,792 | 19,824 / 19,840 | 2,048 KiB |
| Linux ARM64 | 6,144 | 45,936 / 45,952 | 44 KiB |
| macOS AMD64 | 640 | 12,464 / 12,480 | 192 KiB |
| macOS ARM64 | 640 | 12,464 / 12,480 | 128 KiB |
| Windows AMD64 | 1,024 | 14,896 / 14,912 | 60 KiB |
| Windows ARM64 | 896 | 14,128 / 14,144 | 16 KiB |

RSS (resident memory; Windows working set) is sampled separately in ordinary
servers after five batches of 4,096 requests, first batch warmup. Connection
replacement occurs at the normal 1,000-request limit. Every later sample stays
under 8 MiB growth. These are samples, not peak bounds; managed counters exclude
raw/TLS/OS storage and stack pools. No throughput baseline was collected.

All 36 inspected ARC binaries exclude tracing symbols; 24 tracing controls retain
them. The later [fixed-function storage comparison](fixed-functions.md) reduces
per-call costs.
[PR #163](../roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records acceptance. Use `suite=http-server-memory`.

### Keeping one copy of the ownership check

**Comparison:** identical ARC generated C with the ownership check inlined at
call entries versus one `noinline` copy of that existing helper. No check is
removed. The [two-host report](entry-check-code-costs-2026-10-17.json),
`e5bc8531`, uses Clang 18.1.3, O2, `-ffp-contract=off`, EPYC 7763 AMD64 and
Neoverse-N2 ARM64 (four virtual CPUs each). Instruction sections:

| Program | AMD64: copied → one check function | ARM64: copied → one check function |
|---|---:|---:|
| Integer loop | 18,194 → 15,938 bytes (−12.4%) | 16,780 → 14,828 bytes (−11.6%) |
| Numeric pipeline | 19,938 → 17,266 bytes (−13.4%) | 18,700 → 16,348 bytes (−12.6%) |
| Sorted map | 26,802 → 22,994 bytes (−14.2%) | 25,068 → 21,676 bytes (−13.5%) |
| HTTP client | 1,611,138 → 1,406,258 bytes (−12.7%) | 1,533,404 → 1,340,124 bytes (−12.6%) |
| HTTP server | 6,098,930 → 5,260,322 bytes (−13.8%) | 5,768,796 → 4,977,916 bytes (−13.7%) |

HTTP programs are compiled for size only. The loop/pipeline/map inputs are those
in the [complete-program comparison](../benchmarks.md#what-each-program-actually-does); C checks output but is **not timed** here.
One warmup then six alternating whole-process samples give these one-copy/copied
elapsed ratios:

| Program | AMD64 elapsed ratio | ARM64 elapsed ratio |
|---|---:|---:|
| Integer loop | 1.016 | 1.000 |
| Numeric pipeline | 0.933 | 0.993 |
| Sorted map | 1.020 | 0.975 |

Separate instrumented builds record zero check executions in these workloads;
timing differences therefore do not isolate check execution cost. Instrumentation
can affect compilation. No allocations, live-memory or RSS counters were collected.
The accepted result is smaller code, not a general speed gain. Use `suite=entry-checks`.
