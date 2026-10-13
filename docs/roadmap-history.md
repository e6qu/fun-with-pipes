# Delivery evidence

[PLAN](../PLAN.md) records delivered scope and remaining engineering gaps;
[the handoff](development-state.md) records current work. This index supplies
verification references, not executable next actions. Superseded session plans,
repeated handoffs and under-specified timing tables have been removed from the
working documentation. Original records remain in the
[immutable pre-cleanup snapshot](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md).
[Preparation anchors](roadmap-queue.md) retain their original hashes and tags.

## Accepted deliveries

| Delivery | Evidence |
|---|---|
| Native macOS | [PR #74](https://github.com/e6qu/fun-with-pipes/pull/74), ARM/Intel native and interpreter gates |
| Runtime ownership and representation | [PR #124](https://github.com/e6qu/fun-with-pipes/pull/124), [#125](https://github.com/e6qu/fun-with-pipes/pull/125), [#126](https://github.com/e6qu/fun-with-pipes/pull/126); contracts in [ownership](ownership.md) and [primitive inventory](primitive-ownership.md) |
| Numerical kernels and autodiff | [PR #127](https://github.com/e6qu/fun-with-pipes/pull/127), [measurement report](measurements/numerical-kernels-2026-10-12.json) |
| Final ownership/ARC | [PR #128](https://github.com/e6qu/fun-with-pipes/pull/128), [measurement report](measurements/ownership-and-arc-2026-10-12.json) |
| Completion documentation | [PR #129](https://github.com/e6qu/fun-with-pipes/pull/129) |
| Tacit examples and macOS test shards | [PR #130](https://github.com/e6qu/fun-with-pipes/pull/130) |
| Iterator consumers and record projections | [PR #131](https://github.com/e6qu/fun-with-pipes/pull/131), source/gates below |

PR #128 merged as `7350a5566fa991c89916ea67ab693c2a0bba9327`, tree
`fcabfba0e0ca6b7a3e0ef0f7b99792bad7da8381`. All six jobs in
[CI 38256949765](https://github.com/e6qu/fun-with-pipes/actions/runs/38256949765),
[roadmap_docs 38256949763](https://github.com/e6qu/fun-with-pipes/actions/runs/38256949763)
and [merged-source audit 38268514619](https://github.com/e6qu/fun-with-pipes/actions/runs/38268514619)
passed. This completes the six-phase roadmap, including checked ARC for its
proved subset, not general collector-free execution.

PR #129 tested `bedbf8a1fe22127567305eb17be5efa3bc4366e7` and merged as
`592a5953b8351e67fe30ca637426007f8763b5a4` with identical tree
`fa17c2b3a29effe8876f0bb9ccf92a94144a05aa`. All six jobs in
[CI 38274773884](https://github.com/e6qu/fun-with-pipes/actions/runs/38274773884)
and [roadmap_docs 38274773721](https://github.com/e6qu/fun-with-pipes/actions/runs/38274773721)
passed before merge.

PR #130 tested `13886787b5b96c195595ad57b3a1f2689c2d7889` and merged as
`db10b9fd9849446475a68caaf832f17bfe76ba9e` with identical tree
`efd9d775b616e59074a9efdb0f04fc128f5706e8`. All six jobs in
[CI 38312668875](https://github.com/e6qu/fun-with-pipes/actions/runs/38312668875)
and [roadmap_docs 38312668877](https://github.com/e6qu/fun-with-pipes/actions/runs/38312668877)
passed before merge. Completed logs verified all 170 ordinary integration
targets once per macOS architecture, split 85/85, plus separate GC stress.
PR #131 subsequently raised that coverage to 171 targets, split 86/85.

PR #131 tested `a920caf9c3e84f039ac4e6850c607cb34dcf2585` and merged as
`8ae361a43f7634bf818ec8415d8c1ea95fdb74ed` with identical tree
`baeb50b1826a6593d838ff0ea7aa7bdc823d0ffb`. All six jobs in
[CI 38322220083](https://github.com/e6qu/fun-with-pipes/actions/runs/38322220083)
and [roadmap_docs 38322220076](https://github.com/e6qu/fun-with-pipes/actions/runs/38322220076)
passed before merge. Main documentation audit 38327360003 passed; duplicate
main CI 38327360005 was cancelled after verified tree parity and supplies no
passing gate. The complete squash message was one line:
`Add direct iterator consumers and record projection shorthand`.

## Archived numerics timing samples

The [original samples](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-numerics-timing-samples)
lack recorded processor/compiler/flags and allocation/live-memory data. They
are not a current baseline. Use the numerical measurement report above for
scoped accepted evidence.

## Archived tensor kernel timing samples

The [original samples](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-tensor-kernel-timing-samples)
include input construction on an unspecified loaded host. They cannot establish
current macOS performance or equal isolated interpreter/native kernel speed.

## Archived representation measurement detail

The [original layout and native-code probes](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-representation-measurement-detail)
record shape-specific ABI and allocation observations. Current representations
and their limits are specified in [ownership](ownership.md#accepted-numeric-representation).
Preparation evidence alone does not establish merged support or general speed.

## Archived primitive contract notes through queue18

The [original contract probes and controls](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-primitive-contract-notes-through-queue18)
preserve early ownership evidence. Current coverage and exceptions are specified
in [primitive ownership](primitive-ownership.md); do not treat early inventory
counts or preparation instructions as current work.

## Recovery evidence

Durable recovery branch: `roadmap/handoff-pr123-20261011`; last verified
checkpoint `3af176bc210cd9de367bbdf98d2eb49b2626098f`, audit 38285912566,
covering 275 targets / 31,127,348 bytes. On recovery, query the branch tip and
use its current-map.json and designated publisher. Restore through the
hash-checking restore-roadmap-recovery.py procedure; never rerun completed
publishers. The immutable snapshot above retains the detailed provenance.

## Ten-task platform and ownership bundle (PR #132)

Accepted 2026-10-13 in [PR #132](https://github.com/e6qu/fun-with-pipes/pull/132),
squash `c67800ec8530e44501c54c69719af26b0585bedc`, tested head
`7036ecebdbef50a5a8f851ed084378c830af1e79`, identical tree
`0ea780f684a8da12baa549986a4f5bc4feebbc47`.
[Production CI](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034611)
passed Linux ARM64/AMD64, bench and regular/GC macOS ARM/Intel jobs;
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034667) passed.
Four separately packaged native compilers passed outside-checkout execution.
The bundle delivered consumer fusion, known callback specialization, flat loop
state, counted CSV trees and I128/U128 leaves, and scoped autodiff ARC proof.
It fixed CSV generational root corruption, wide overflowing-result cleanup,
portable signed 128-bit multiplication and U64 multiplication overflow.
[Four-platform measurements](measurements/native-ownership-2026-10-13.json)
retain focused controls. At 1,000 elements, paired map/filter/fold requests fell
from 9,511 to 4,003; lazy producers still allocate. Warm AD workloads allocate
no new native workspace buffers but still allocate managed result arrays.
No general GC-free or zero-allocation claim follows from this acceptance.

## Seven-step reconstruction and numerics bundle (PR #133)

[PR #133](https://github.com/e6qu/fun-with-pipes/pull/133) contains the complete
seven-step implementation and records final exact-head production acceptance
and squash merge. Its scope covers documentation closeout, typed reconstruction,
scoped State, direct producers/callbacks, native wide workers, measured
numerical/AD improvements and the float-format decision.

The [measurement record](measurements/reconstruction-and-workers-2026-10-13.json)
retains hardware, compiler, flags, workloads, allocations and charged live
storage. At 08f4231, all four platforms passed the focused regression, iterator
instruction/allocation and inventory stages in
[38401069936](https://github.com/e6qu/fun-with-pipes/actions/runs/38401069936);
that run's old wide harness failed and is not a passing overall gate. Corrected
wide evidence passed all four platforms at 45ed2ce in
[38402851452](https://github.com/e6qu/fun-with-pipes/actions/runs/38402851452),
with unchanged compiler/runtime sources. The numerical/ARC/AD evidence is
[38401073468](https://github.com/e6qu/fun-with-pipes/actions/runs/38401073468).
Final ternary wire validation, stride-aware decoder controls and cold overflow
formatting are tested at 615e224 in
[38406723936](https://github.com/e6qu/fun-with-pipes/actions/runs/38406723936),
which also retains per-worker stack usage. These evidence runs do not replace
production acceptance on the final PR head.

For 1000 elements, requests fall from 6005 to 6 (fold), 7009 to 8 (State each)
and 9511 to 6 (map/filter/fold). The measurement includes CLI/printing and its
64 charged retained bytes, so it is not a checked ARC reclamation claim.
The I128 and U128 256-element workloads each fall from 513 to 2 requests and
4096 to 32 peak charged bytes, with no collections or retained charged storage.
Native instructions use register pairs and checked carry/overflow operations;
recursive workers still consume stack. Equivalent C/Rust and AD measurements
remain scoped to recorded workloads, with no universal speed claim.

The [float-format decision](float-formats.md) explicitly preserves current
F16/BF16-as-F32 and F128-as-F64 behavior until a coordinated precision and wire
migration. True formats, general cyclic/foreign ownership and Windows are
future directions, not claimed deliveries of this bundle.
