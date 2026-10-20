# Counting channel ownership operations

This experiment asks how much reference-count work remains when a program sends
a value through a channel. A retain increments the count of owners keeping a
value alive. A temporary value may be movable into the queue; a value still used
elsewhere needs sharing. Measurements must distinguish those cases before a
transfer optimization is selected. No runtime change or speedup is claimed yet.

## First measured baseline

[Run 39354805966](https://github.com/e6qu/fun-with-pipes/actions/runs/39354805966)
passed on both Linux architectures at source `2b56fd1c`, preserved by
`roadmap/revision-channel-counts-2b56fd1c`. Each host passed nine callback-effect
tests, the complete type-checker snapshots and all five measured programs.
[The audited report](channel-count-baseline-2026-10-20.json) retains 180 count
samples and hashes of 20 ordinary binaries, their C and disassembly.

Every fresh text/function message had one counted owner at queue insertion,
yet the queue performed one retain per message. Total ARC retains were four
per fresh-text exchange and five per fresh-function exchange. Deliberately shared
text/function cases used seven/nine total retains per exchange, with one inside
the queue; their payloads already had multiple owners. Closed sends performed
zero queue retains and two other retains per attempt. All ARC cases finished
with zero charged storage and no collections.

The fresh cases' peak charge rose by 48 bytes between 16 and 1024 messages:
the first input reaches 16-character messages, while the larger input reaches
the full 64-character cycle. Shared cases had unchanged peak charge. This
identifies a bounded payload-size difference, not accumulating queue storage.
It does not measure total process memory. The next change should transfer the
sender's existing owner into the queue and preserve independent aliases, then
repeat these profiles and failure/cancellation checks.

## Programs and inputs

`tests/fixtures/channel_transfer_*.fwp` contain five small programs. Each exported
`work` function accepts a message count and returns that count after checking
every result. The channel has capacity one. Each successful send is followed by
its receive in the same task, so there are no blocked sends or scheduling races.
An explicit `loop` advances an integer counter without allocating a list of input
indices. `Again` continues with the next loop state; `Stop` returns the result.

| Case | Message | What remains alive outside the queue |
|---|---|---|
| Unique text | A fresh string of 1–64 `x` characters, cycling with the index | No deliberate message alias |
| Unique function | A fresh constant function capturing that fresh string | No deliberate function alias |
| Shared text | One string containing the decimal input count | The same string is used in every exchange |
| Shared function | One constant function capturing the decimal count string | The same function is used in every exchange |
| Closed function | A fresh function/string sent to an already closed channel | Nothing is accepted; each rejection must clean up |

The names describe the source's intended sharing, not a compiler guarantee.
Native counters record whether the payload actually has one counted owner at
insertion. The fixtures check received lengths or text; a missing receive fails.
Closed sends must return `False`. Constant functions use `const`: `const value`
returns a function that ignores its later argument and returns `value`.

## Method and recorded units

Run the explicit `channel-costs` suite in `numerics.yml`. It uses native Linux
AMD64 and ARM64 runners, GCC, `-O2`, and both checked ARC and ordinary tracing
builds. `compile_c` also supplies `-std=gnu11 -ffp-contract=off -w` and native
runtime links. Artifacts identify the exact source, CPU, kernel and tool versions,
and retain fwp source, generated C, ordinary and instrumented binaries and actual
ordinary-binary disassembly. They include ordinary binary file size in bytes.

For each program, input counts are 0, 16 and 1024. Raw interpretation with
`FWP_NO_OPT=1` establishes the expected result. Ordinary generated binaries must
match it before three fresh executions of each instrumented binary. Counts must
be identical between repetitions. The zero-message case records entry, channel
and loop setup costs; report it alongside nonzero cases rather than treating all
allocations as message allocations.

Counters start after constant initialization and finish after runtime cleanup.
The existing managed-allocation probe records request count, requested bytes,
effective retains, peak and final charged bytes, and collection count. Charged
bytes are the runtime's memory accounting, not resident process memory: allocator
metadata, raw buffers, executable pages and thread stacks are excluded. Allocation
wrappers sample after allocations; peaks are sampled, not a complete OS trace.
ARC runs must end with zero additional charge and zero collections.

Additional counters record send calls, accepted queue insertions, payloads with
one counted owner at insertion, and effective retains performed by the queue's
typed duplication operation. They exclude caller retains and later receive/call
work; total retains include those operations. Native sinks and blocked/cancelled
transfers are outside this sequential experiment and retain their separate
[ownership correctness tests](../ownership.md).

`counts.tsv` stores all samples. A higher message count with bounded live program
data tests whether measured peak charge grows; constant peak charge is a result
to verify, not an assumption. The ordinary and instrumented versions perform the
same language work, but instrumented runtime bookkeeping changes machine code.
These are operation counts, **not timings**. There is no C/Rust implementation in
this experiment and it establishes neither a speedup nor C/Rust parity. Any later
speed claim needs a separate equivalent-work timing comparison.

Return to [the plan](../../PLAN.md), [current work](../development-state.md) or
[benchmark methods](../benchmarks.md).
