# Returned buffers: phase measurement protocol

**Preparation; no timings collected.** This extends the
[returned-buffer correctness checks](ownership-peers.md#returned-buffer-preparation).
Finish those checks and native release observations before collecting timings.
Retain the exact measurement source under an immutable tag before collection.

## What runs

A factory returns an array containing `0` through `length - 1`. A separately
compiled caller sums it, then releases it. The shared case creates a second
owner, reads through the first, releases the first, reads through the surviving
owner, then releases it. For length 4, the unique checksum is `6` and the shared
checksum is `12`. Neither case mutates elements or measures copy-on-write.

Use ordinary C, Rust, Swift and current fwp, with the representations and entry
costs listed in the [comparison scope](ownership-peers.md#returned-buffer-preparation).
Factory and caller compile separately without LTO. No previous fwp compiler is
required. C/generated C use GCC O2; Rust uses O2 with overflow checks; Swift uses
`-O`. Preserve checked addition in every reader.

Each batch keeps a population of returned arrays alive simultaneously:

| Array length | Buffers per batch | Element bytes alive, excluding headers/capacity |
|---:|---:|---:|
| 0 | 4,096 | 0 |
| 16 | 4,096 | 524,288 |
| 4,096 | 256 | 8,388,608 |
| 262,144 | 4 | 8,388,608 |

Two owners share the same elements. The table does not include the caller's
slots, runtime, reference metadata or allocator rounding.

## Phase boundaries

Allocate reusable caller slots before measuring batches; free them afterward.
Use native value slots, not an extra per-buffer reference wrapper. Initialize
and release arrays in increasing slot order. Each batch measures:

| Phase | Unique | Shared |
|---|---|---|
| Construction | Construct every array and initialize its slot | Also create and store each second owner |
| Reading | Sum every array and accumulate the checksum | Sum first owners; after releasing them, sum surviving owners |
| Release | Release all owners | Release first owners, then surviving owners after their reads |

Four clock readings delimit a unique batch; six delimit a shared batch. Add the
two reading intervals and two release intervals in the shared case. Do not read
the clock per element or per array. Use the existing separately compiled
`CLOCK_MONOTONIC` helper and failed-clock controls. Slot initialization/destruction
belongs to its phase; slot allocation, startup and final output belong only to
whole-process time. Check the exact checksum in every process.

## Pilot and samples

- Native Linux ARM64 and AMD64, two sessions sequentially on each same host.
  Record CPU, OS, toolchain versions, explicit architecture flags and source hashes.
- Before peer timing, use only the ordinary C executable to select batch counts
  for each length/owner mode. Try 16, 64, 256, then 1,024 batches, stopping at the
  first whose construction + reading + release reaches 50 ms, or at 1,024.
  Preserve every pilot result. Use those counts for every peer and both sessions.
- Two warmup rounds, then 16 recorded rounds per case/session in two balanced
  eight-round blocks. Balance order and preceding executables for eight labels:
  each language and a byte-identical copy.
  No manual rerun to qualify a noisy result; preserve all observations.
- For each phase, require both original and copy medians to reach 5 ms and their
  larger/smaller ratio to be at most 1.02. A peer ratio needs both languages to
  qualify. Report short or noisy phases as inconclusive; cheap release does not
  invalidate a separately qualified reading phase. Do not increase the pilot cap
  after seeing peer ratios to force release to qualify.
- Report absolute phase/process medians and fwp/peer ratios. A ratio of 1.20 means
  fwp takes 20% longer for this work. These comparisons introduce no new universal
  speed target and do not replace older failed acceptance results.

## Memory and retained evidence

Run three additional ordinary processes per peer/case/session under GNU time for
peak RSS. Keep these outside timing samples. RSS includes runtime, allocator and
mapped libraries; it is not the element bytes in the table or an ARC count.

Use separate diagnostic runs to attribute allocations, live storage and release.
Verify actual omitted release before trusting the observer. Keep the checkpoint
after the first shared release: storage must remain usable until the last owner.
Do not interpret profile durations as ordinary execution time.

Retain original/prepared sources, commands, raw pilot/samples, actual binaries,
identical-copy digests, source/tag identity, compile elapsed time/RSS and code/frame
reports. State unmeasured boundaries explicitly. Interpret any result as the cost
of these external factory/reader/release boundaries, not of all local array code.
