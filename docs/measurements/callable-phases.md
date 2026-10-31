# Where returned functions spend time

A returned function keeps captured values alive after its factory returns.
For example, a factory capturing `7` can return a function that adds `7` to each
later input. The [existing comparison](returned-callables.md) checks results,
cleanup, allocations and reference counts. This experiment measures elapsed time
and resident memory separately. It extends the [Swift comparison](swift-peers.md).

## Fixed experiment

Freeze this protocol before collecting samples. No results exist yet.
Use native Linux ARM64 and AMD64, with two sessions sequentially on each same
runner. Record actual CPU and toolchains; do not combine different CPU models.
Both sessions rebuild from the same source, using GCC O2, Rust O2 and Swift `-O`
with checked arithmetic. Factory and caller compile separately, without LTO.
The common C clock uses `CLOCK_MONOTONIC` and fails if the clock cannot be read;
its failed-clock controls run before measurements. Process timing uses the
existing deadline-aware child runner, without polling sleeps.

Compare five implementations and one byte-identical copy of each:

- C returns a function pointer and inline integer capture.
- Rust implements the same record through `core`, linked to the C caller. This
  measures Rust functions, not startup of a complete Rust standard-library app.
- Swift returns its native escaping function value. A typed native buffer stores
  the values; initializing and deinitializing slots delimit their lifetimes.
  There is no extra class wrapper or C representation of Swift closures.
- Current fwp uses the merged borrowed-call optimization.
- The fwp reference uses the same generated C with only that optimization's
  condition disabled. It is not an old compiler or a second supported runtime.

Each process runs 256 batches. Each batch constructs 4,096 functions capturing
`index + 7`, calls every function for inputs 0 through 15, then destroys the
whole population. Two cases compute `capture + input` and
`2 * (capture + input)`. Every process checks the exact sum. The input never
overflows; factories retain their checked operations. Timing includes checksum
accumulation, but no per-call clocks or allocation counters.

Four clock readings per batch separate construction (including buffer allocation),
invocation, and release (including freeing the buffer). Aggregate each phase
across all 256 batches; report nanoseconds for that complete workload and clearly
state any per-operation conversion. Process time additionally includes startup,
clock calls, cleanup checks and output. Construction includes 1,048,576 factories;
invocation includes 16,777,216 calls. C/Rust record release is trivial; do not add
artificial work to match ARC languages. Swift's manually initialized buffer is a
measurement device for precise phase boundaries, not a recommended application API.

Two warmup rounds precede 20 measured rounds. Ten-round blocks balance the
positions and preceding programs for all ten executable labels. Every duration,
output and status is retained. A copy ratio above 1.02 makes that implementation's
phase inconclusive. An aggregate phase below 5 ms is also inconclusive. Pairwise
claims require both implementations and their copies to qualify; a cheap C
release does not invalidate a separate fwp/reference invocation comparison.
Do not rerun unchanged noisy results, relax limits or remove failed samples.

## Candidate acceptance and memory

For **both operations, sessions and architectures**, require qualified invocation
time at least 5% below the same-source reference. Qualified construction, release
and complete-process time must be no more than 2% above the reference. If a
required phase fails its copy or duration control, timing acceptance stays open.
This is a new performance assessment; it does not rewrite the original rejected
ARM O1 code-size budget. Retain executable sizes and section reports as context.

Three additional runs per implementation/case measure peak resident RAM with
GNU time. These are separate from timed samples and include runtime, allocator
and mapped libraries. Require current fwp's maximum no more than 1 MiB above its
reference's maximum in each session. Do not call RSS an allocation count.
Separate diagnostic executables retain the existing single-closure construction,
invocation, release, intentionally omitted release and failure/retry controls.
They must show unchanged payload requests/storage and zero invocation retain/
release pairs for current fwp, versus one pair per call in the reference.
The diagnostic ledger is not used for the 4,096-closure population.

Keep every source, generated-C variant, native executable, command, raw timing,
RSS sample, count record and digest. Audit samples against command output, source
identity and byte-identical executable copies. Successful collection means the
records are complete, not that performance acceptance passed. Swift allocation
and ARC-operation counts remain missing; phase timings alone cannot attribute
its costs specifically to ARC. Its reference-capture lifetime controls and scalar
overflow controls remain in the earlier Swift suite.

## Delivery status

PR #234 was user-merged as `219e3a0130c18d60750fd55ec9c0a684c1dcefd4` before the
full production matrix. Main run `41218527464` owns those pending checks. Do not
mark them verified or cancel them as duplicates. The new PR will include these
measurements, any repairs and final-head production validation.
