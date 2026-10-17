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

## Independent compiler preparation

Worktree `/private/tmp/fwp-boxed-projections`, branch `move-boxed-projections`,
starts at request-ownership preparation `997b23a9`. That component's six-host
run is `39000228402`; its live report/handoff remains in
`/private/tmp/fwp-repeated-remote-calls`. Do not overwrite that worktree or its
running evidence collector. Keep one delivery PR; no compiler PR is open.

Actual Linux `c2cfaf1a` client C shows `grpc._iter` retaining a selected
`GrpcCell[I64]` field, then dropping its tuple parent. The parent has just one
counted field; its other field is an I64. The new backend path transfers that
field when the consumed heap tuple has one owner and frees only the tuple.
Shared tuples retain the selected field before dropping the parent reference.
Use the existing exceptional owner guard around that retain. Preserve stack
aliases, virtual loop state, resource frames, disabled freeing and prospective
allocation reuse on their existing paths. No new runtime wrapper or syntax.

`boxed_projection_ownership` compares raw interpretation with native behavior,
checks unique/shared parents, pointer-like scalar bits, exact live storage,
traps after selection and deliberately restored retains/stolen shared fields.
Both O1/O2 and checked ARC/ordinary memory modes are covered; stress checks run
with tracing. The fixture and implementation are written but unvalidated.

Next: publish this preparation and run the focused Linux `fields` suite on CI.
Fix failures, then measure actual stream clients against `997b23a9` before making
any retain/allocation/performance claim. The ordinary stream suite must also
retain the new compiler controls. Full builds stay on GitHub. Local formatting
passed under the unchanged root guard in 1.05s; run the doc audit before publish.

Connection/pool/typed-sender ownership remains open. The live pool and detached
I/O tasks remain alive at the current client measurement endpoint. Establish
closed-connection and explicit-drain measurements before treating those bytes
as leaks. Private design notes are `/private/tmp/fwp-next-connection-ownership.md`.

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
