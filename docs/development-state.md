# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Accepted delivery

PR #159 is squash-merged as `7c4634410f23fa106b8c8dac5ad750b05fab5251`.
All nine production jobs `39016595534` and docs `39016595480` passed at
`91398527812ce967302e7c4d04325a3c7d5d510a`. The merge parent is accepted #158,
`a96871c9e97e06da5a1187d53d198fbdfe6ed970`; the tested/merged tree is
`ad549863a6a0a080f016963defa0906dcdc924ce`. Complete message:
`Free streamed inputs after remote calls finish`. Duplicate postmerge production
`39022161689` is confirmed cancelled. The exact-head watcher completed; private
record `/private/tmp/fwp159-merge-record.json`. [History](roadmap-history.md)
records acceptance. Input ownership does not complete GC removal.

## Current server delivery

Root branch `free-server-call-values` starts at accepted #159. It combines:

- Explicit server job/task disposal and stack argument slots.
- Direct calls to compiled methods, with typed argument/result/error cleanup.
- Returned-iterator ownership that moves unique continuations and preserves aliases.
- Native output-channel cleanup and borrowed sends, without a larger header.
- Partial decoding/construction, traps, errors, blocked cancellation and retained-alias
  tests, including deliberately broken cleanup to prove the tests detect leaks.

The implementation was transferred from the channel preparation after `9a4e2ace`,
without replacing root's #158 allocation-test repairs, accepted history or handoff.
No server PR exists yet. Only this root branch owns current delivery work.
Preparation worktrees `/private/tmp/fwp-server-call-owners`,
`/private/tmp/fwp-server-value-owners` and `/private/tmp/fwp-server-channel-owners`
are evidence sources, not competing next tasks.

Next: freeze/publish the combined candidate and dispatch six-host `server-repeat`.
Collect actual ARM64/AMD64 binary reviews and the final report against the frozen
storage comparison. Fix failures. Then open one substantial server PR, with a
plain description of behavior, memory improvements, remaining count costs and
limits. Require all nine production jobs plus documentation on its final head
before authorized squash merge: one subject at most 80 characters, empty body,
no trailers or attribution. CI gates merging, not independent work.

## Focused evidence

The unchanged programs are greetings, returned integer iterators, sent integer
iterators and output-channel text, with 64 elements per streaming call. Native
servers receive 1/16/256 calls over one reused connection, three fresh processes
per case. Counters start after listener/root/routing setup and end after calls,
connection closure and task retirement, with the listener still open. Collection
is disabled and physical freeing enabled. Raw buffers, stack pools, TLS/OS and
allocator metadata, whole-process memory and elapsed time are excluded.
These compare fwp versions, not C/Rust performance.

- Baseline: `0643295938a432cefedb4a3d0c1f263aa9482ee2`, tag
  `evidence/server-call-baseline-20261017`, all-six run `39014733093`.
- Storage: `e6455c0ddcf692669af02d1eb67c7600de096977`, tag
  `evidence/server-call-storage-windows-20261017`, all-six `39018276989`.
  [Report](measurements/server-call-storage-2026-10-17.json) and 18 raw tables.
  One fewer allocation and 24 fewer requested bytes per call, unchanged retains;
  one-parameter call helpers use 48 additional stack bytes. Storage still grows.
- Typed values: `48ccd3d9965836ac3806ca528b12a893c8672669`, tag
  `evidence/server-values-direct-20261017`, Linux `39020484780` passes.
  [Linux-only report](measurements/server-method-values-linux-2026-10-17.json)
  and three raw tables retain actual AMD64 review. Three modes leave 62,304 bytes
  at 256 calls; channels leave 365,408. Greetings add one retain/call; sent streams
  fall from 253 to 128. Each call removes one closure allocation; sent streams
  also remove another 24-byte allocation. Direct method entry and stack owners
  are visible in actual instructions; frame costs are mixed.
- Channels: `f2529d20bd4d1d3ef8f32fd5b27de30fe7ed2df7`, Linux `39021584597`
  passes cleanup, stress/reuse, ordinary interpreter/native, explicit `FWP_REUSE=0`
  and measurement checks. All four modes leave 62,304 bytes at 256 calls, still
  growing by 240/call. Channel output removes one further allocation/call and
  adds 64 retains/call. Other three modes match typed-value measurements.
  A stale queue-drop mutation in `arc_tasks` was then repaired; the combined
  six-host workflow includes that target. Its repair is not yet native-verified.

The collector requires explicit comparison kinds. Use `--comparison server-values`
with the storage report for the final six-host report. `--linux-probe` explicitly
limits intermediate reports to Linux AMD64. Binary reviews must include greetings,
sent iterators and channel output for the combined report. No downloaded binary
has been executed locally. Private artifacts:
`/private/tmp/fwp-server-memory-evidence/{39018276989,39020484780,39021584597}`.

## Remaining boundaries

Server request and connection records still rely on tracing. Prove owners across
active request lists, jobs, incoming iterator sources, output channels and I/O
tasks before enabling their counts. Parsed request lists need an owner because a
later reset in the same network input can remove a request before task creation.
Incoming server-source cleanup must not accidentally apply client abandonment
semantics. Account for promoted uncounted graphs and preserve borrowed task/context
back-pointers without owning cycles. HTTP/2 has a separate handler graph.
The private audit is `/private/tmp/fwp-server-next-lifetimes.md`.

Keep all existing failure, cancellation, stress/reuse and negative controls.
Neither disabled collection nor these selected memory reductions establish
complete service ownership, remote checked ARC, zero-cost abstractions or speed
parity. Larger applications, host re-entry, numerical/derivative work, full GC
removal and the remaining seven work areas stay open. JIT is excluded.

## Local checks

Use `python3 scripts/local-guard.py COMMAND...` with fixed limits. Full builds,
suites and measurements run on GitHub. Channel-preparation formatting passed in
1.23s and documentation audit in 2.97s. Passing channel artifact download took
3.30s; guarded comparison took 0.14s. Root integration preserved both accepted
allocation-test repairs and `git diff --check` passed. Root formatting passed in 1.42s and the documentation audit passed in 2.89s
before publication.

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
