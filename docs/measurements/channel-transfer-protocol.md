# Counting channel ownership operations

This experiment asks how much reference-count work remains when a program sends
a value through a channel. A retain increments the count of owners keeping a
value alive. A temporary value may be movable into the queue; a value still used
elsewhere needs sharing. Measurements must distinguish those cases before a
transfer optimization is selected. The consuming-send and temporary-tuple changes
have measured count savings and passed
[production acceptance in PR #175](../roadmap-history.md#function-queues-and-cheaper-sends-pr-175).
No execution-time speedup is claimed.

Later reports use this same protocol for [loop-state tuples](channel-loop-state.md),
[direct matches](channel-match-results.md), [moving matched payloads](channel-variant-moves.md)
and [borrowing across calls](channel-direct-borrows.md), then
[temporary local names](channel-local-borrows.md). Each identifies its
comparison revision, measured savings, remaining costs and acceptance status.

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
It does not measure total process memory. This baseline selected transfer of the
sender's existing owner into the queue, with independent aliases preserved.

## Transfer result and remaining costs

[Run 39356051237](https://github.com/e6qu/fun-with-pipes/actions/runs/39356051237)
repeats the protocol at `34568f3d`, preserved by
`roadmap/revision-channel-transfers-34568f3d`. The
[transfer report](channel-count-transfers-2026-10-20.json) audits both native
hosts and another 180 samples. Linux AMD64 used an AMD EPYC 7763; ARM64 used
Neoverse-N2. Both used their recorded GCC versions with the same compilation
settings and source-level work as the baseline.

| ARC case, 1024 messages | Total retains before → after | Queue retains before → after |
|---|---:|---:|
| Fresh text | 4096 → 3072 | 1024 → 0 |
| Fresh function | 5120 → 4096 | 1024 → 0 |
| Shared text | 7168 → 7168 | 1024 → 0 |
| Shared function | 9216 → 9216 | 1024 → 0 |
| Closed function | 2048 → 2048 | 0 → 0 |

Both architectures give these counts. A queue receives the existing owner;
shared cases acquire the needed extra owner at the caller instead. Fresh text
therefore removes one of four retains per exchange; fresh functions remove one
of five. Allocation request counts and sampled peak charge are unchanged. Every
ARC profile still ends with zero charged storage and zero collections. The
smaller channel header does not reduce the allocator's charged size in these
profiles. Heap allocation and other retains remain; this is not a zero-cost
channel claim.

Code size and stack use have tradeoffs. Ordinary ARC executable file size changes
on AMD64 are +72/+64/+144/+144/+4160 bytes in table order; ARM64 changes are
0/−24/+80/+80/−24 bytes. File size includes linker layout and is not just executed
instruction bytes. Inspecting the fresh-text binaries' actual disassembly:

- AMD64 `exchange` (`f17`) keeps its 320-byte stack subtraction plus five saved
  registers. The executing loop is in `work` (`w0`), which keeps 584 bytes plus
  six saved registers (632 bytes total, excluding the return address).
- ARM64 `exchange` grows from a 336-byte frame to 352 bytes. `work` keeps
  544 bytes: 448 local bytes plus 96 bytes for saved registers. These ARM frame
  sizes include the saved registers.

These are those functions' own frames, excluding callees and total task stacks.
The transfer must keep a pending message protected until insertion or cleanup.
The standalone `step` wrapper also remains in the binary, but is not the loop's
executed body. The generated loop already avoids allocating `Step` variants;
its state tuple and the tuple passed to `exchange` still allocate. Those are
separate costs from queue ownership. No execution-time improvement is established,
and no C/Rust peer was measured. Separate ownership and full production checks
passed in PR #175; the count experiment alone does not establish cleanup safety.

The [next loop-state experiment](channel-loop-state.md) measures the remaining
state tuple separately. Focused ownership checks pass on all six native platforms
and both WASI hosts. Its full delivery acceptance is recorded in
[PR #176 history](../roadmap-history.md#loop-state-and-known-function-calls-pr-176).

## Removing a temporary tuple after `tap`

`value | tap action | next` runs `action` on the value, discards the action's
result, then passes the original value to `next`. The optimizer can remove an
internal alias of that original value while keeping the action first. This lets
the existing direct-call optimization pass `exchange` its channel and counter
separately, without constructing their temporary tuple.

[Run 39360310385](https://github.com/e6qu/fun-with-pipes/actions/runs/39360310385)
at `f0747ab2`, preserved by `roadmap/revision-channel-tap-f0747ab2`, passes both
Linux hosts. [Its report](channel-count-tap-2026-10-20.json) audits another 180
samples. The table compares it with the consuming-send revision above. These
per-message counts are finite differences between inputs 16 and 1024; startup
costs remain in the report.

| ARC case | Allocation requests per message, before → after |
|---|---:|
| Fresh text | 4 → 3 |
| Fresh function | 7 → 6 |
| Shared text | 3 → 2 |
| Shared function | 5 → 4 |
| Closed function | 3 → 3 |

Both architectures agree. Each successful case removes one allocation per
message and reduces sampled peak charge by 32 bytes. Shared-text retains also
fall from seven to six per message; other retain totals are unchanged. Every
ARC profile finishes with zero charged storage and zero collections. The
loop-state tuple still allocates, and `Step` was already unboxed. Closed sends
do not call `exchange`, so their counts are unchanged.

The fresh-text machine code now calls `exchange` through worker `w17`. Its own
frame grows from 360 to 376 bytes on AMD64 (including saved registers, excluding
the return address), and from 352 to 368 bytes on ARM64. The enclosing `work`
frame shrinks from 632 to 504 bytes on AMD64 and from 544 to 464 bytes on ARM64.
These are individual frames, not total task-stack peaks. In table order, ARC
executable file sizes change by −8/0/−4416/−48/+48 bytes on AMD64 and
−16/−8/−280/−120/+48 on ARM64. No execution timing or C/Rust comparison was run.
The expanded cleanup tests and their test-setting repairs passed final production
acceptance in PR #175. These count results remain evidence of the measured revision.

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
AMD64 and ARM64 runners, GCC and `-O2`, with counted ownership.
The current protocol produces 45 samples per host (five programs × three input
sizes × three repetitions) and five ordinary binaries. Historical reports below
used two memory modes; reproduce those with their recorded source revision. `compile_c` also supplies `-std=gnu11 -ffp-contract=off -w` and native
runtime links. The workflow explicitly sets `FWP_LTO=0`, disabling link-time
optimization. The recorded baseline and first transfer run also compiled without
it: their C files are below the compiler's automatic size threshold of 1,000,000
bytes. This keeps future counts independent of that threshold.
Artifacts identify the exact source, CPU, kernel and tool versions,
and retain fwp source, generated C, ordinary and instrumented binaries and actual
ordinary-binary disassembly. They include ordinary binary file size in bytes.

For each program, input counts are 0, 16 and 1024. Raw interpretation with
`FWP_NO_OPT=1` establishes the expected result. Ordinary generated binaries must
match it before three fresh executions of each instrumented binary. Counts must
be identical between repetitions. The zero-message case records entry, channel
and loop setup costs; report it alongside nonzero cases rather than treating all
allocations as message allocations.

Counters start after constant initialization and finish after entry execution and
cached-value cleanup, before whole-runtime shutdown.
The existing managed-allocation probe records request count, requested bytes,
effective retains, and peak and final charged bytes. Charged
bytes are the runtime's memory accounting, not resident process memory: allocator
metadata, raw buffers, executable pages and thread stacks are excluded. Allocation
wrappers sample after allocations; peaks are sampled, not a complete OS trace.
Every measured run must end with zero additional charge.

Additional counters record send calls, accepted queue insertions, payloads with
one counted owner at insertion, and effective retains performed by the queue's
insertion ownership work (the baseline used a typed duplication operation).
They exclude caller retains and later receive/call
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
