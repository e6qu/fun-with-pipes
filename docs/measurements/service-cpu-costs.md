# Locate queued-service CPU costs before changing its implementation

**Recordings collected; decoder repair pending.** [The first native run](service-cpu-first-2026-11-10/README.md)
verifies all outputs but rejects six fwp stack reports. PR #275's delivery gates
remain the immediate priority.
The [complete service comparison](weak-callback-time-2026-11-09/README.md) found
that delivering 4,096 messages takes about 19–20 times C's service time and 5–7
times Swift's. Different queues, representations and synchronization prevent
calling that difference an ARC cost. This experiment locates work before choosing
a compiler, library or language change.

## Programs and invariants

Reuse `tests/fixtures/weak_callback_service.*` and their existing timing callers.
All peers construct a pending queue, deliver or discard messages, validate actual
received payloads and release service-owned storage. Each payload already uses
16 contiguous integers in fwp's `Array[I64]`; it is not a linked payload list.
fwp's pending queue is a list of `(index, weak channel, payload)` records.

Correctness covers both 64 and 4,096 messages in all four cases:

| Mode | Required behavior |
|---|---|
| Delivered | Every message reaches the receiving channel; sent/received checksums agree. |
| Cancelled | Every fourth message is discarded before upgrading the weak channel. |
| Expired | The strong receiver owner dies before dispatch; every weak upgrade fails. |
| Handled error | The middle payload is sent, its error is handled, and later dispatch stops. |

Preserve channel close/drain behavior, failed-send cleanup, weak expiration,
caller-visible result fields and complete service release. Reuse the independently
computed expectations and physical-ownership controls. A smaller result or omitted
queue work is a correctness failure, not a faster implementation.

## First observation: the four large cases

Profile the 4,096-message cases in fwp, C, Rust and Swift on native Linux ARM64
and AMD64. The smaller cases remain correctness controls. This is attribution,
not a repeat of the accepted timing comparison and not an optimization candidate.

- Build the same separate service/caller sources with the existing O2-equivalent
  settings, no LTO and explicit baseline architectures. Add debug information for
  stack decoding; retain source, compiler versions, commands, binary hashes and
  actual ELF machine identity. Use GCC 13.3, Rust 1.99.1 and Swift 6.4.2,
  matching the existing native service comparison; record installed versions.
- Probe CPU-clock sampling and user-stack decoding before long builds. Use only
  the command's process tree, explicit general-purpose registers, a 32 KiB stack
  snapshot, 256 KiB event buffer and 997 Hz. Unsupported recording is a failed
  observation; do not change the application or silently substitute another tool.
- Choose each implementation's recording batch independently from the existing
  explicit batch ladder (16 through 16,384), stopping at the first ordinary trial
  with at least one second of service work. Retain all calibration trials. Failure
  to reach the minimum fails that observation. Different batch counts mean these
  profiles cannot supply peer elapsed-time ratios.
- Run one ordinary and one sampled invocation at the chosen batch count. Require
  the existing exact results for both; keep their differing timer values. Pin
  each to one allowed logical CPU, without claiming exclusive use, and preserve
  an explicit 120-second child deadline.
- Retain every user-CPU sample, including caller/runtime work and unnamed frames.
  Require matching raw/decoded sample counts and periods, no recorded loss, and
  resolved service frames. Preserve failed diagnostics and quantify unresolved
  work instead of assigning it to a convenient category.

Do not add counters, profiling callbacks or no-inline boundaries to the service.
A program sampled with debug information is not an ordinary timing result. The
existing service allocation profiles and fwp ownership counters answer separate
questions; sampled CPU percentages are neither allocation bytes nor ARC counts.

## Report phases and operations separately

Each sample contributes once to a phase and once to an operation category.
For example, freeing a temporary during dispatch belongs to **dispatch** and
**release**, not to an invented later cleanup interval.

| Phase | Source work to identify |
|---|---|
| Construction | Build pending records, payload arrays and weak registrations. |
| Dispatch | Iterate pending messages, upgrade weak handles, calculate checksums, handle errors and send. |
| Drain | Close the channel, receive queued payloads and validate their contents. |
| Remaining service work | Entry/result handling and work outside the identified source functions. |
| Caller/runtime/unknown | Startup, the checking caller, unmatched or unresolved samples; keep these visible. |

Within each phase, show identified allocation, ownership/release, channel/queue,
error-handler, payload-computation and remaining work. Classifications must cite
actual retained symbols/source mappings. fwp may erase a phase boundary by inlining before emitting C, so C debug
information alone cannot reconstruct that boundary. Keep such samples in the
remaining-service category until actual source evidence separates them. Missing
frames also limit attribution; overlapping source ranges cannot be counted twice. Do not label all
`malloc` work as ARC or all unmatched samples as compiler overhead.

## Reader and source evidence

The [collector](../../scripts/service_cpu_collect.py) reuses the existing separate
service/caller builder. The [reader](../../scripts/service_cpu_samples.py) keeps
both the leaf symbol and the actual ancestor used for each classification.

- fwp phase names come from its emitted function-ID table; anonymous functions
  remain anonymous. C, Rust and Swift callbacks need their actual service parent.
- Allocation, release and count operations use the functions defined in
  `runtime/fwp_rt_heap.c`; channel/weak operations use `runtime/fwp_rt_task.c`.
  libc allocation/free, pthread synchronization and known Swift runtime symbols
  are separate operations. Unrecognized Rust/Swift internals remain unclassified.
- A release within dispatch is still dispatch. Payload arithmetic with no surviving
  function boundary stays in remaining work; the reader does not infer a phase
  from an instruction name or assume unmatched CPU time is ARC overhead.
- Every row contributes once. Unnamed frames and entirely missing stacks keep
  their sample counts and periods. The independent [audit](../../scripts/service_cpu_audit.py)
  reconstructs results, pilots and attribution from retained raw records.

`service-cpu` in the [evidence workflow](../../.github/workflows/numerics.yml)
requires an immutable `service_cpu_tag`. It runs both native Linux architectures
in the existing Swift image with `CAP_PERFMON`, for process-local CPU sampling.
LLVM addr2line is selected explicitly for source names. Perf's script command
locates it through a dedicated tool-directory symlink; the collector verifies
that the resolved executable matches its required setting. The capability probe
must pass before compiler builds. Sampling records, binaries,
source mappings, commands and all failures are retained. No production source
changes or new service profiling boundaries are part of this observation.

## Select the next change from evidence

Deliver the profile reader with controls for lost samples, altered totals,
missing applications and false phase attribution. Reconstruct the retained
reports independently, audit complete job logs, and explain the largest observed
costs with source examples. Keep profiler limitations explicit.

Only then select a concrete change and freeze its correctness, whole-service
elapsed-time, memory and compiler-cost targets against an immutable source.
Check whether the same mechanism occurs in the maintained HTTP endpoint before
claiming a shared improvement. Existing sustained-load checks provide its latency,
throughput, slow-client and cleanup baselines. Source/API changes are allowed;
never preserve an expensive representation solely for backward compatibility.

The `service-cpu-replay` suite uses explicit recording run/source and a decoder
source tag. It verifies retained hashes and every original service output, restores
the matching binaries for decoding, and replays all sixteen profiles without
executing the service again. The original failed reports remain separate evidence.
