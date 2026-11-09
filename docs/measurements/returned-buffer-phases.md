# Returned buffers: phase measurement protocol

**Correctness and native storage verified; no timings collected.** This extends the
[returned-buffer correctness checks](ownership-peers.md#returned-buffer-preparation).
[Both native architectures now pass the phase and release checks](returned-buffer-phases-2026-11-09/README.md).
Retain the exact measurement source under an immutable tag before collection.

## What runs

A factory (an array-building function) returns integers `0` through `length - 1`. A separately
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
`CLOCK_MONOTONIC` helper, which measures elapsed time without wall-clock adjustments,
and its failed-clock controls. Slot initialization/destruction
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

## Current preparation

The native phase callers and their record reader now pass on both architectures.
`returned-buffer-phases` checks outputs/arguments, actual wrong sums and
a separately linked clock that moves backward. Its runs are correctness controls;
they collect no peer ratios. C/fwp and Swift use reusable typed pointer slots;
Rust uses a preallocated `Vec` and forward draining. Their slot initialization
and release bookkeeping are included in the corresponding phases.

The [collector](../../scripts/measure-returned-buffers.py) implements the fixed
C-only pilot and both sessions, with separate compile/RSS runs and a reader that
reconstructs every result from raw commands. It requires an immutable
`roadmap/returned-buffer-time-…` tag matching its exact source. It has not collected
an experiment. Native correctness/storage and timing-reader controls now pass.
The reusable timing workflow repeats phase checks for its exact source before
the pilot and requires the explicit immutable source tag.

Whole-process elapsed time starts before launching the child and ends after
waiting for its output; it includes launch/wait overhead. The three internal
phases use the native monotonic clock. Recorded binary section sizes and unwind
tables are available for review, not asserted maximum stack-use bounds.

## Native storage check before timing

`returned-buffer-profiles` profiles the same separate C/Rust/Swift factories at
GCC/Rust O2 and Swift `-O`, adding debug information for allocation stacks. It
uses the phase callers with 4,096 simultaneous buffers, 16 batches, and lengths
0 and 16. Empty buffers reveal metadata costs; length 16 keeps 512 KiB of element
data alive per batch. There are two profiles per case and owner-release variant:

| Variant | Unique | Shared |
|---|---|---|
| Ordinary | Release every array | Release first owners, read surviving owners, release them |
| Omit first | Keep the array owner | Keep the first owner even after releasing the second |
| Omit last | Not applicable | Release first owners and read survivors, but keep their owners |

The omissions change actual ownership operations. C omits the release call;
Rust uses `mem::forget`. Swift frees the caller slots without destroying their
Array values, then allocates fresh uninitialized slots for the next batch. This
avoids initializing over live values. The control's extra slot allocations are
outside the array factory; whole-process totals still include them. No class
wrapper replaces Swift's Array.

Use the previously verified heaptrack/unwinder setup and its independent
allocation/free controls. Retain raw allocation stacks, traces, commands and
source/binary hashes for all 60 profiles, including failures. Attribute factory
stacks to `returned_buffer_make`, Rust's native v0 symbol for
`returned_buffer::make`, or Swift's `bufferMake`:

- Ordinary release must leave zero array-storage bytes at exit.
- Omitting either owner must retain storage, with the same factory allocation
  count. Nonempty cases must retain at least all 65,536 arrays' element bytes.
- Empty cases can allocate nothing. If they allocate native storage, omitting
  release must retain observable factory storage; missing attribution cannot
  qualify a nonempty case.
- Report attributed bytes at the **process heap peak**, not as an independently
  measured factory maximum. These profiles are neither timing nor ARC counts.

Retain the entire factory subtree and show array storage and runtime metadata
separately. The first run exposed two observer errors: Rust names were not
demangled, and Swift's generic type initialization was counted as leaked arrays.
The corrected reader recognizes the pinned Rust compiler's actual factory symbol.
For Swift it identifies the concrete-type initialization subtree separately from
the contiguous-array allocation path; an unfamiliar factory path fails for review.
Ordinary and omitted-release cases must have equal metadata allocation and exit
byte counts. Metadata is reported, not subtracted from whole-process totals.
[The original failures and stacks](returned-buffer-phases-2026-11-09/README.md#first-native-allocation-run)
remain available. Fresh profiles and complete original-archive audits now pass
on both architectures; the [result table](returned-buffer-phases-2026-11-09/README.md#verified-results)
keeps native storage and one-time metadata costs separate.

fwp's managed arrays live in its reserved heap. Its runtime unmaps that reservation
at shutdown, so native allocation leaks at process exit cannot prove timely
managed-array release. Preserve the existing managed live-byte and omitted-release
checks; report reservation/commitment/RSS separately. Do not label fwp payload
bytes and native C/Rust/Swift allocation requests as the same measurement.
