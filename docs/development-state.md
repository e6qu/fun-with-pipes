# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

[PR #156](https://github.com/e6qu/fun-with-pipes/pull/156) releases cached stream
values and moves captures from uniquely owned closures. Root branch
`release-stream-caches` has exact head `d19ab045d6ce136455d597b49773db7ef9c5721d`,
based on accepted #155, `45410bea4b59e2e6478632cf253f9c29cbd9863d`.
Production run `38996879616` is running; documentation `38996879603` passed.
Both ARM Mac jobs, Windows AMD64 and benchmarks have passed so far. Require all
nine production jobs and docs on this exact head before merging.

Watcher exec session `37246` runs `/private/tmp/fwp-watch-156.py` and
`/private/tmp/fwp-merge-156.py`. It verifies the exact base/head and passing gates,
squash-merges with subject `Release unused stream values and reduce memory bookkeeping`
and an empty body, then verifies tree, parent and complete message. Its result
belongs at `/private/tmp/fwp156-merge-record.json`. If it exits on failure, repair
and restart for the new exact head. Do not infer success from a missing watcher.
Cancel only superseded/duplicate production runs; preserve Windows dependency jobs.

The root handoff remains a local status change to avoid restarting production
for documentation-only progress. Keep one active delivery PR. After acceptance,
start the next delivery from the verified merge and transfer the preparation
below; preserve its actual measurement revisions. Record acceptance in
[history](roadmap-history.md) and replace the current delivery in the plan.

PR #156's focused source is `afd7d460`, tag
`evidence/remote-capture-moves-20261017`, all six native jobs passing in
`38996238360`. [Its report](measurements/remote-client-capture-moves-2026-10-17.json)
compares actual clients over 64/1,024/16,384 integers. Remaining managed memory
is constant across those sizes; moving unique captures reduces retains from the
cache-only change by about 40%, but still leaves about three times the original
tracing-dependent count and five allocations per integer. Raw transport storage
and timing are excluded. Details and earlier acceptance belong in the benchmark
guide/history, not a second next-action list.

## Next preparation: release finished request storage

Worktree `/private/tmp/fwp-repeated-remote-calls`, branch
`own-remote-transport-storage`, published at `c2cfaf1a`.
Linux probe `38999330000` passed all checks with `numerics.yml`, `suite=stream-repeat`.
All-six run `38999756987` found Windows fixtures selecting an older API contract
before generated code. `grpc_connection_addresses` and `grpc_tls_pool_identity`
now select the required Windows 10 contract before includes and join regular
Windows production. The new stream-owner controls passed on Windows ARM64; that
job stopped before repeated-client measurements. Watcher `52202` exits on this
failure; do not collect or accept this run. Publish the repair and run a fresh
six-host matrix for its exact head.
Focused runtime checks now precede closure checks so failures surface sooner.
No second delivery PR is open.

The untouched baseline is `ac95632b8c77cc8c52f35a451f3c7451d0e29b06`, tag
`evidence/repeated-remote-baseline-20261017`. All six native jobs passed in
`38997585835`; branch `measure-repeated-remote-calls` preserves it.
The next worktree contains the report
`docs/measurements/repeated-remote-baseline-2026-10-17.json` and raw checkpoint
TSVs beside it. Inputs are 1/16/256 batches of 64 integers in one client process:
full sum (2,080), first-32 sum (528), or retaining an iterator across a second call
and rereading its first value (4,161; two calls per batch). Three measured processes
per case follow raw interpreter/ordinary native output agreement.

All six hosts retain 240 additional managed bytes per call. One connection is
reused; no request streams are finalized. Partial readers also leave 609 requested
message bytes per call in these samples. Collection is disabled; counters end
after root execution, child-task joins and cached-value cleanup, before
whole-runtime shutdown. The pool and detached I/O tasks remain live; their
remaining storage is not evidence of an unreachable connection. Other raw buffers,
TLS/OS/allocator storage, server/process memory and timings are excluded.
Queue occupancy may vary with scheduling. This establishes work, not bounded memory.

The implementation gives client request streams references from the active
connection list, receive source and detached sender. Source release discards
unread input without cancelling the remote operation. The list holds unfinished
requests until completion/reset/connection death. Last release frees metadata
and raw request storage and removes the weak collector finalizer. Existing
allocator count metadata is reused; native layout measurements check the new flag.
The sender's unused function-encoder field/branch is removed because its sole
production caller always supplies a static request description.

Server/HTTP streams, connections, pending sender values and retained callback
contexts still require tracing. Remote calls remain excluded from checked ARC.
Infinitely many active remote operations are not a bounded-memory claim.

## Failures repaired; validation still required

- `38998638008` at `ad089a73`: new stream-owner injection matched an unrelated
  finalizer cleanup too. Narrowed it to the request destructor. Other selected
  runtime/closure tests and queued-message OOM passed.
- `38999032272` at `4a1823ac`: all stream-owner modes pass, including physical
  release, GC/reuse stress, no-free controls, sender cancellation, failed sender
  preparation, count overflow and deliberate missing releases. The expanded
  receive fixture incorrectly used server cancellation rules; it now uses client
  status/reset behavior. TLS pool-key OOM printed the right message but aborted
  because `exit` invoked library unloading from a live task. The two new fatal
  OOM branches now use `_Exit(102)`; plain/gzip message failures run on task stacks.
- Review removed duplicate layout output. The latest probe also includes the
  existing request-encoding failure tests after simplifying the sender.

Next: inspect all-six run `38999756987` and fix any failures. The passing Linux
probe leaves 6,240 managed bytes at all measured call counts/modes, finalizes
every created stream/message, and adds one retain per call with unchanged
allocation requests. Its request header is 232 bytes with 8-byte alignment;
the new flag uses trailing padding. Sender storage is 40 bytes. These are Linux
results until the full native matrix verifies them. Use
`scripts/collect-repeated-client-measurements.py --baseline-report` to require
all exact-source jobs, output agreement, complete stream/message release and
constant final managed bytes across measured sizes. Keep both baseline and
candidate identities. Inspect actual ARM64/AMD64 binaries with
`scripts/inspect-stream-client-binaries.py`; review layouts and instruction paths.
The collector fingerprints evidence and copies raw checkpoints; it never executes
downloaded programs. Full production acceptance of the combined PR is separate.

After this request-storage work, assign connection/pool/task owners and typed
pending-sender/handler owners, with borrowed scheduler links and explicit cycle
handling. Review old fatal allocation paths that call `exit` from tasks, and
unchecked environment-option allocation. These remain concrete follow-up fixes.
Audit whether retained codec fields have real production callers before adding
owners for them; do not preserve unused machinery merely to count it.

## Local checks

Full builds and native execution stay on GitHub. Focused local work uses
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py` with unchanged
limits. Baseline source type-check passed in 0.51s; formatting checks passed in
1.1–1.4s and doc audits in 2.4–2.7s. Baseline report collection passed in 26.87s;
updates using retained downloads passed in 1.7s. Static Linux AMD64/ARM64 inspection
passed in 0.15s per host. Reviewed cache destruction loops have 24-byte AMD64 and
64-byte ARM64 frames, with callee storage separate; dynamic application retains
argument storage and dispatch. No downloaded executable ran locally.

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
