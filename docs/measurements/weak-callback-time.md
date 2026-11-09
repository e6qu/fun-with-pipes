# Queued callback service timing protocol

**[Both native sessions now pass](weak-callback-time-2026-11-09/README.md).** This measures the ordinary service
whose [results and ownership](weak-callback-service.md) are already checked. It
answers whether the isolated weak-reference costs matter in a complete queue
lifetime. It does not measure a concurrent network server.

## Equivalent work and included costs

Each invocation creates 64 or 4,096 pending messages with 16-integer payloads,
then processes one of four cases: all delivered, every fourth cancelled, target
expired before dispatch, or a handled error after the middle payload is delivered.
The receiver independently counts and sums delivered payloads. All pending
messages, payloads and weak registrations are released before returning statistics.

C uses explicit owners and heap arrays; Rust uses `Rc`/`Weak`, `Vec` and `RefCell`;
Swift uses a native weak reference, arrays and a thrown error; fwp uses a channel,
weak channel references, arrays, a pending list and a handled language effect.
These are ordinary representations of the same work, not identical data layouts.

The service module and its caller compile separately, without cross-module LTO.
fwp's generated unary owning entry receives an allocated `(population, mode)`
tuple and returns its ordinary result record. Its C caller copies the immediate
integer fields and releases the record; offsets come from the emitted type
descriptor. Tuple/result handling is included, not subtracted as estimated overhead.
No source-language adapter or replacement weak-reference API is introduced.

| Reported time | Included work |
|---|---|
| Service | Sum of clocks directly around each service call, including its allocations, delivery/error work and complete cleanup |
| Process | Launch, runtime initialization, all calls, checking/aggregating results, output and process exit |

The caller checks every returned field outside the service clocks and prints one
aggregate result. No observer counters, profiler or physical-allocation ledger
runs in ordinary timing builds. Their diagnostic builds run beforehand.

## Collection and qualification

- Native Linux ARM64/AMD64, explicit targets; GCC/Rust O2, Swift O with whole-module
  optimization. Record exact compiler versions, flags, images and source tag.
- Before collecting time, verify eight ordinary cases at both production settings,
  incorrect delivery/result controls, fwp entry cleanup, actual omitted result
  release, invalid arguments and backward-clock rejection.
- A C-only pilot tries 16, 64, 256, 1,024, 4,096 and 16,384 invocations. Choose the
  first with at least 50 ms of service time, or retain the cap if none qualifies.
  Use that same count for every implementation and both sessions. Finish all
  pilots before peer warmups.
- Two sessions per host; two warmup rounds and 16 measured rounds per case. Each
  round runs each executable and an identical copy. Balance all eight positions
  and preceding implementations over each eight-round cycle.
- For each duration independently, both copy medians must be at least 5 ms and
  their ratio at most 1.02. A comparison requires qualifying copies for fwp and
  that peer in both sessions. Keep every short/noisy case; no unchanged reruns.
- Report `fwp median / peer median` and equivalent extra time. A ratio of 1.20
  means 20% longer for this work; it is not a universal language-overhead figure.
- Collect three separate ordinary peak-RSS processes per peer/case/session.
  Retain allocation results separately, plus compile time/RSS, image sizes and
  native frame information. Static frame data does not establish maximum stack use.
- Retain partial output and all failures. Reconstruct schedules, pilot selection,
  binary identities, results, durations and RSS; corrupted records must fail the
  audit even if their manifest hashes are updated.

[The ownership comparison](ownership-peers.md) keeps this service, isolated weak
operations, parser workspace and returned-buffer evidence separate.
