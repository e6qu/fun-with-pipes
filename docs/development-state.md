# Session handoff

Updated 2026-10-16 UTC. [PLAN.md](../PLAN.md) has seven unfinished project areas.
Remote-stream preparation is in `/private/tmp/fwp-stream-caches`, branch
`measure-remote-stream-storage`, based on `20f0f5f0`. There is no second PR.

## Current delivery

PR #154 merged as `11ae0f6350ba697c773fa49cb5700d9790931769` after all nine
production jobs, docs and both dependency jobs passed at `51354d10`. Duplicate
production `38984543299` was cancelled; leave Windows dependencies running.
The verified record is `/private/tmp/fwp154-merge-record.json`. The watcher's final
output parser stopped after the successful merge; do not retry the merge.

The next delivery is assembled in `/Users/zardoz/projects/fun-with-pipes`, branch
`remote-stream-delivery`, now based on accepted #154. Its handoff is current;
this worktree retains the measured preparation and warm focused-run caches.
No second PR has been opened yet.

## Current preparation and next action

Compact stream positions pass all six native hosts in `38982153357` at
`ab9a0a0e51994840707add835a60cdcab9a2be51`. The preceding separate-field version
passes all six in `38981730504` at `00c09cdc8fa0a42f829d2fb001f29fb765ada1c9`.
Both include source-description copying, in-place client formatting, source
lifetime, concurrent readers, cancellation and actual interpreted/native clients
and servers. The previous Windows header-order and harness failures are fixed.

The added native recursive-read check still needs CI. It mirrors the passing
interpreter check: recursion traps with the same message and preserves the
already-active receiver. Run a focused Linux check before starting full delivery
CI. Final production jobs will cover it on every platform.

A further repair preserves an unread message when its decoder is cancelled.
Both runtimes had already removed that message from the queue; cancellation could
free it before cache publication, making another reader skip it. Native unwind
cleanup now restores it without allocation, before waking the waiting reader.
The interpreter restores its owned message vector on decoder cancellation.

Next: publish and run this repair with `stream-owners` on all six hosts. New
interpreter tests cover ordinary/result streams. The native fixture cancels after
removing the first message, with both an already queued second message and a later
arrival that checks the restored queue tail. Disabling restoration must reproduce
the lost-message failure. Earlier six-host passes do not verify this repair.
Regenerate the compact report and inspect fresh ARM64/AMD64 binaries before the
combined PR's final full gates. The receive cleanup adds stack state, not per-value
heap storage; record any resulting frame-size change without claiming speed.

## Implemented behavior and remaining limits

A position represents either an unread source or a saved result. Native code now
uses the same storage word for these alternatives, selected by its existing
completion flag. It replaces the source only after constructing the complete
result; failures preserve the unread source. The interpreter releases the source
after its last unread owner disappears. Cached native results still rely on
tracing and lack explicit last-owner destruction.

Descriptions share their source's allocation. Client formatting writes there
directly, avoiding a temporary 1 KiB array, while preserving the existing
1,023-byte text limit. Forty method/address combinations compare truncation and
punctuation with the old formatter. Server descriptions keep their full length.

One task receives for a shared unread position; others wait for its saved result.
Completion, errors and cancellation release the receive guard and wake waiters.
Cancelling a waiting task leaves the receiver running. The cancellation fixture
uses a server request stream; cancelling a client receiver can still reset the
call. Borrowed task identities and scheduler wait lists add no per-value allocation.
The deterministic two-reader test must fail when synchronization is disabled.
A real client has two tasks sum 1..1024, both returning `Some 524800`, across all
interpreted/native client/server combinations. The services guide explains its
notation, output, cancellation and retention costs.

## Measurements and binary evidence

The [preceding report](measurements/remote-stream-shared-2026-10-16.json) and
[compact report](measurements/remote-stream-compact-2026-10-16.json) compare queued
messages containing 16-character strings at 1/32/128 values: complete/half reads,
repeated reads and retained earlier positions. On all six hosts:

| Cost | Separate fields | Shared word |
|---|---:|---:|
| Bytes per position, alignment 8 | 24 | 16 |
| Allocations per received value | 4 | 4 |
| Requested bytes per value | 89 | 81 |
| Allocator-charged bytes per value | 112 | 96 |
| Fixed setup charged bytes | 720 | 704 |
| Charged bytes after 128 values, including setup | 15,056 | 12,992 |

These exclude sockets, pooling, raw message/codec buffers, allocator pages,
process memory and elapsed time. They establish no C/Rust parity. Clearing C
references alone still leaves cache storage charged with collection disabled.

Artifacts: `/private/tmp/fwp-stream-before-union/38981730504` and
`/private/tmp/fwp-stream-compact/38982153357`. Actual AMD64 and ARM64 O2 fixture
and O1 service-client instructions use the shared source/result word; the common
receive frames remain. Both reports retain instruction excerpts and hashes.
No downloaded executable was run locally.

Reproduce compact collection through `python3 scripts/local-guard.py python3
scripts/collect-stream-measurements.py` with `--run`, `--head`, `--artifacts`,
`--baseline docs/measurements/remote-stream-shared-2026-10-16.json`, and `--output`.
The collector validates successful jobs, named tests, exact artifact revisions,
matching inputs, layouts, allocation deltas, CPU/actual compiler details and hashes.
The baseline collector is preserved at `00c09cdc` and privately at
`/private/tmp/fwp-collect-stream-before-union.py`.

## Checks and next ownership work

Guarded results: compact-layout formatting 1.23s; docs audit 2.52s; baseline
collection 21.05s; compact collection 23.76s; comparison and binary-excerpt update
1.56s. ARM64/AMD64 binary inspections pass in 0.13–0.14s. The handoff's missing
status table was repaired and its audit passed. Local limits remain unchanged:
64 GiB free disk, target below 2 GiB, aggregate RSS below 1 GiB, 180 seconds.

Next give cached results and continuations typed owners and bounded-stack
last-reference destruction, including partial construction and retained aliases.
Move a source owner forward when possible. Establish owners for pools, calls,
connections, streams and decoder captures; scheduler identities remain borrows.
The existing connection counter controls transport closure, not complete object
destruction. [Ownership](ownership.md#what-remains-before-remote-calls-can-use-arc)
records these distinctions. Remote calls remain excluded from checked ARC.
Retained host callbacks, GPU resources and all seven project areas remain open.

Every commit/squash message is one line, at most 80 characters, with an empty
body and no trailers or attribution. JIT is excluded. Failed tests are work to fix.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Typed stream and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
