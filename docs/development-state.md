# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

[PR #156](https://github.com/e6qu/fun-with-pipes/pull/156) releases cached stream
values and moves captures from uniquely owned closures. Root branch
`release-stream-caches` has exact head `d19ab045d6ce136455d597b49773db7ef9c5721d`,
based on accepted #155, `45410bea4b59e2e6478632cf253f9c29cbd9863d`.
Production run `38996879616` is running; documentation `38996879603` passed.
Seven production jobs have passed; Linux AMD64 and regular Intel Mac remain running. Require all
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

## Next delivery preparation

`own-remote-transport-storage` in `/private/tmp/fwp-repeated-remote-calls`
contains request cleanup, repeated-call evidence and documentation. All six native
jobs passed at `997b23a9aa392a3cde8fb8bd5026c348545c06b2` in `39000228402`.
Tag `evidence/remote-request-ownership-20261017` preserves that measured source.
The report is `measurements/remote-request-ownership-2026-10-17.json`, with raw
checkpoint tables beside it. Baseline `ac95632b` remains independently preserved
by `evidence/repeated-remote-baseline-20261017`, run `38997585835`.

Full, partial and retained readers run 1/16/256 batches of 64 integers, three
processes each. Every created request/message releases; final managed bytes stay
constant in every mode: Linux AMD64 6,240, ARM64 19,296; either Mac 2,240; Windows
AMD64 3,392, ARM64 3,008. Baseline storage grew 240 bytes per call and partial
readers retained queued messages. Allocation requests/bytes are unchanged; the
new ownership adds one retain per call. The benchmark guide explains scope and
costs. These are focused results, not full delivery acceptance or checked ARC.

Counter sampling ends after root execution, child joins and cached-value cleanup,
while reusable connections and detached I/O tasks remain live. Do not call that
remaining connection storage a demonstrated leak. Other raw buffers, TLS/OS and
process memory, server storage and timing are excluded. Infinite active requests
are not a bounded-memory claim.

Request owners are the active list, reader and optional detached sender. Reader
release discards unread messages without cancelling the remote operation; the
list retains unfinished requests. Last release removes the weak finalizer and
frees metadata/raw storage. Native fixtures cover all terminal events, aliases,
sender cancellation, failed preparation, retries, decoder errors, count overflow
and deliberate missing cleanup. Windows API-header ordering and fatal OOM from
task stacks were repaired before the passing run. Superseded runs are historical
failures, not remaining next actions.

Reviewed Linux binaries show looped queued-message release and final request
cleanup. Request size/alignment is 232/8 bytes on all hosts; the flag uses padding.
Cache frames are 24 bytes AMD64 (excluding incoming return address), 64 ARM64
(including saved registers); request reader-release frames are 24/32 bytes.
Callee frames are additional. No downloaded executable ran locally.

## Compiler change to bundle with request cleanup

`move-boxed-projections` in `/private/tmp/fwp-boxed-projections` starts at `997b23a9`.
Published head `d1beb206ed4122afa9b575b5cf16989b684fa219` passed Linux `fields`
run `39000896503`. Real repeated-client probe `39001303292` passed at that head. For 256 full
reads, retains fall from 66,562 to 50,178; partial reads from 41,986 to 33,794;
retained readers from 116,226 to 99,586. Allocation requests and final managed
storage are unchanged. These are Linux AMD64 results until the native matrix passes. No second PR is open; bundle these related changes after measurement.

When a consumed heap record has only one counted field and one owner, the
compiler transfers that field and frees the parent without retaining it first.
Shared records keep their existing field owners. Stack aliases, resource frames,
virtual loop state, disabled freeing and planned storage reuse retain their
existing paths. Interpreter/native, unique/shared, scalar-bit, exact reclamation,
error cleanup and deliberately broken variants pass in the focused Linux suite.
No six-platform or timing claim yet.

A related service TLS-cache fix now checks construction allocation, keeps the
entry/name together and releases unpublished entries if TLS construction traps.
Its temporary name storage also accommodates complete environment-variable names,
removing the old 300-byte truncation. Tests add two injected failures, retry,
missing-cleanup detection and 1,024-character names. They are unvalidated until
the next native run. Stream suites now include these cache tests.

Next: publish the combined preparation and run all six `stream-repeat` jobs.
Use the retained `997b23a9` request report as baseline with `--projection-moves`.
Preserve actual measurement revisions. Then prepare one delivery from #156's
verified merge and run all production gates. One delivery PR remains active.

## Local verification and remaining work

All builds/native execution run on GitHub. The root `scripts/local-guard.py`
keeps fixed limits. Formatting checks passed in 1.1–1.4s; doc audits in 2.4–2.7s.
The six-host request collection passed in 27.55s; recollection with reviewed
binaries in 1.53s. Static inspection passed in 0.15s per Linux architecture.
Compiler collector syntax passed in 0.20s. Updated documentation audit
(`python3 scripts/check-roadmap.py` under the root guard) passed in 2.55s.
An initial invocation used a nonexistent audit filename; it made no changes.

Connection/pool/task owners, typed pending-sender values and retained server
handlers remain open. Establish closed-connection/explicit-drain measurements
before attributing live pooled storage to leaks. Private research is
`/private/tmp/fwp-next-connection-ownership.md`. Audit unused callback fields before
adding owners. Older fatal allocation paths using `exit` on task stacks and
other unchecked allocation paths also remain concrete follow-up work. The
service environment-cache construction fix above now has written failure tests.
Remote calls remain excluded from checked ARC; all seven roadmap areas stay open.

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
