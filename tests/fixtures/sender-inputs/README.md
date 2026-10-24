# Measuring input iterators held by remote calls

An iterator produces values as they are requested. A client-streamed call sends
those values to a server. A bidirectional call sends inputs in a background task
while the caller reads responses. These fixtures measure the storage left after
each completed call and connection; they do not measure elapsed time.

Each program takes a batch count on the command line. `const 1` ignores the batch
number and supplies one, so each batch constructs a fresh sequence. `iter.take 64`
limits it to 64 values. `step` adds each call's result to the running total;
`curry` adapts its tuple-taking body to the two successive arguments used by fold.
`main` parses the count, runs that many batches and prints their combined result.

- `synchronous` sends integers 1 through 64 and receives their sum, 2080.
- `bidirectional` sends strings word-1 through word-64 and receives them
  uppercased. Their lengths sum to 439: 64 prefixes of five characters, nine
  one-digit suffixes and 55 two-digit suffixes.
- `retained-input` keeps the original input iterator while the remote call uses
  it, then reads that original again. The two sums add to 878. `both` applies
  its two functions to the same value; `uncurry add` adds the resulting pair.
- `early-completion` offers 64 integers, but the server returns only the first
  three multiplied by ten, giving 60. Scheduling can change how many extra
  inputs are evaluated or encoded; the instrumentation records those counts.

The runner supplies the existing greeter service alongside these sources.
Raw interpretation and ordinary native execution provide output references using
normal connection reuse. Instrumented native clients deliberately close each
connection and drain its reader, writer and sender before the next call. They
therefore perform different transport work. Compare ownership revisions only
with the same closing hooks. There are three independent measured processes for
each program at 1, 16 and 256 batches, with collection disabled and freeing enabled.

Counters cover managed allocation requests, charged storage, reference-count
increments, connection/request/message release, sender task completion and input
values pulled/encoded. Category totals count allocations, not live identities.
Scheduler stack pools, raw buffers other than queued messages, TLS/OS/allocator
metadata, server/process memory and timings are excluded. These fixtures do not
establish checked ARC, zero-cost abstractions or speed parity with C/Rust.

[Recorded protocol and results](../../../docs/measurements/repeated-remote-storage.md) name the
measured revisions. [The plan](../../../PLAN.md) tracks current acceptance work.
