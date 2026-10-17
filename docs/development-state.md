# Session handoff

Updated 2026-10-17 UTC. [PLAN.md](../PLAN.md) has seven unfinished project areas.
Current branch: `remote-stream-delivery`, based on accepted #154
(`11ae0f6350ba697c773fa49cb5700d9790931769`). This batch is ready for publication
and final production validation; focused passes do not authorize merge.

## Next batch preparation: bounded chain destruction

Preparation branch `bounded-chain-destruction` in `/private/tmp/fwp-chain-destruction`
starts from PR #155's final head. The current compiler loops when a node directly
owns another node of exactly the same type; a chain crossing a record and an
`Option` instead recursively calls two destructors. The proposed workload owns
one string and one optional next link per position. Before changing code, measure
stack use at 64 and 1,024 links, verify physical reclamation with collection off,
and compare its small language example with the interpreter. Initial run
`38987057363` failed in the fixture lookup: generated type comments use `Link`,
not its module-qualified name. The lookup now matches the existing convention;
no stack result was collected from that run. The corrected lookup then reached
the native program in `38987243134`, but the fixture incorrectly enabled retained
storage poisoning in checked ARC, which explicitly rejects that combination.
The physical-reclamation measurement now disables poisoning; separate hybrid-mode
checks will cover it. Neither failed run establishes the baseline. Run native builds
on GitHub only. Acceptance requires bounded cleanup stack use, correct retained
aliases and partial cleanup, no new heap work, and full final-head gates. This
preparation does not admit native remote calls to checked ARC.

## Current delivery

PR #154 passed all nine production jobs (`38977201910`), documentation
(`38977126983`) and Windows dependencies (`38977201787`) at `51354d10`.
Its merge tree, parent and one-line message are verified in
`/private/tmp/fwp154-merge-record.json` and [delivery history](roadmap-history.md).
Duplicate production run `38984543299` was cancelled. Main-branch Windows
dependency run `38984543101` also passed; preserve its caches.

This batch fixes shared stream readers consuming different messages, cancelled
decoders losing the message already received, and receive failures leaking error
text. Descriptions belong to their source. Completed positions replace the source
with their saved result in the same word. One cleanup record restores a cancelled
message, releases receive storage and wakes waiting readers. Waiting-reader
cancellation leaves the receiver running; client-receiver cancellation can still
reset the remote call. No new per-value allocation is added.

Next: collect the six-platform wrapped-chain baseline before implementing a fix.
For PR #155, watch production `38986731253` and docs `38986731302`; publish this delivery with `/private/tmp/fwp-stream-pr-body.md`, require all
nine production jobs and documentation on its exact final commit, fix any failures,
then squash-merge with one line of at most 80 characters and an explicitly empty
body. Record the verified merge and continue the ownership work below. Cancel
only duplicate postmerge production CI; leave Windows dependency jobs running.

## Verified focused evidence

Final six-host run [38985903147](https://github.com/e6qu/fun-with-pipes/actions/runs/38985903147)
passes at `4c26f21fe717c4df35a4439e59c1812a5edb449d`: Linux, macOS and Windows,
each on ARM64 and AMD64. Runtime, interpreter, fixtures and collector match that
preparation source. The immutable tag is
`evidence/remote-stream-cancellation-20261017`; earlier measurements remain in
`evidence/remote-stream-before-delivery-20261016`. Preparation worktree:
`/private/tmp/fwp-stream-caches`, branch `measure-remote-stream-storage`.

Checks include O1/O2, collector stress/verification and reuse, source lifetime,
concurrent readers, recursive-read traps, cancellation before/during decoding,
restoring an empty queue before later arrival, and partial-failure cleanup.
Negative controls deliberately omit restoration, register cleanup too late,
disable caching/synchronization or restore the larger layout; each must fail.
The final run also passes the rendering cleanup test whose stale hook caused the
preceding run to fail. No unresolved focused failure remains.

An actual service has two tasks sum 1..1024; both return `Some 524800` across all
interpreted/native client/server combinations. [The guide](services.md#reading-the-same-stream-in-two-tasks)
introduces each function and notation before explaining output and memory limits.

## Measurements and binary inspection

The [preceding report](measurements/remote-stream-shared-2026-10-16.json), from
`38981730504` at `00c09cdc`, and [final report](measurements/remote-stream-compact-2026-10-17.json)
compare queued 16-character values at 1/32/128 elements, repeated reads, partial
consumption and retained earlier positions. All six hosts agree:

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
references still leaves cache storage charged with collection disabled.

Static inspection of actual AMD64/ARM64 executables confirms the shared word.
O2 fixture stack frames fall from 360/368 to 344/336 bytes respectively;
O1 service-client frames fall from 232/272 to 216/240. The
[benchmark guide](benchmarks.md#storage-for-received-stream-values) explains the
counting convention and scope. No downloaded executable ran locally.
Artifacts: `/private/tmp/fwp-stream-before-union/38981730504` and
`/private/tmp/fwp-stream-final/38985903147`. Reports retain instruction excerpts,
hashes, layouts, inputs, allocation counts and actual compiler/CPU details.

Guarded checks: final collection 23.71s; each architecture inspection 0.15s;
report refresh with binary observations 1.56s; roadmap/docs audit 2.71s
(50 link sets, 106 immutable anchors and seven roadmap steps pass). Commands used
`python3 scripts/local-guard.py python3 scripts/collect-stream-measurements.py`
with run/head/artifacts/baseline/output arguments and
`python3 scripts/local-guard.py python3 /private/tmp/fwp-inspect-stream-binaries.py`
with each Linux artifact folder. Full builds and native execution stay on CI.
Local limits remain 64 GiB free disk, target below 2 GiB, sampled aggregate RSS
below 1 GiB and 180 seconds; do not increase them.

## Next ownership work

Next give cached results and continuations typed owners and bounded-stack
last-reference destruction, including partial construction and retained aliases.
Move a source owner forward when possible. Establish owners for pools, calls,
connections, streams and decoder captures; scheduler identities remain borrows.
The existing connection counter controls transport closure, not complete object
destruction. [Ownership](ownership.md#what-remains-before-remote-calls-can-use-arc)
records these distinctions. Remote calls remain excluded from checked ARC. Compiler work must review
`CGen::drop_body`, lowering of `grpc._force` and RPC result descriptors together.
Native `g_decode` still uses unowned `fwp_decode`; custom decoder callbacks need
a reviewed result contract too. Marking the primitive reviewed alone cannot
safely establish ownership.

A promising next contract consumes a position: when it has one owner, transfer
its saved result directly; when shared, return another result owner. Keep type
information in generated code or existing method descriptors instead of adding
a destructor pointer to every position. For long chains, release a position,
its optional-result wrapper and its tuple iteratively while each is uniquely
owned; stop at a shared wrapper. Decode results and partial construction need
owners before publication. Runtime calls into `grpc._iter` must use the owned
application machinery and transfer arguments exactly once. These are proposed
implementation constraints, not completed work. Measure actual language clients
as well as C fixtures: retaining an earlier iterator intentionally retains its
saved sequence, so dropping C roots alone cannot prove bounded consumption.
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
