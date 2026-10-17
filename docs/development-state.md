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
[PR #160](https://github.com/e6qu/fun-with-pipes/pull/160) is ready for review at
`1f1a928738ae32d88bcd2a7ac1fff1e0004e0f3c`. Final production `39023664259`
failed the regular ARM macOS state-restoration fixture; docs `39023663596` passes. Draft sync run `39023663629` skipped and
is not acceptance. Keep this exact head stable; do not push status-only updates.
Only this root branch owns current delivery work. The exact-head merge watcher (session 47124)
stopped on that failure and must be recreated for the repaired head. It uses `/private/tmp/fwp-watch-merge-160.py` and `/private/tmp/fwp-merge-160.py`;
record `/private/tmp/fwp160-merge-record.json` is written only after verified merge.
The failing `state_slot_probe.c` still called the previous six-argument service
helper. It now supplies function index zero, a unit argument array and explicit
owned-entry metadata to the five-argument direct helper. The success, typed-error,
trap, real-collection and task-cancellation checks and deliberately broken clearing
controls remain intact. The focused server suite now includes this fixture.
Formatting passed in 1.27s and docs in 2.73s under the root local guard.
Publish this repair, then require fresh full production/docs at its final head.

Preparation worktrees `/private/tmp/fwp-server-call-owners`,
`/private/tmp/fwp-server-value-owners` and `/private/tmp/fwp-server-channel-owners`
are evidence sources, not competing next tasks.

Combined candidate `855fe3d18a16fd771dac322cdabcf9ebcfbe8493` is published as
`evidence/server-values-combined-20261017`; all-six `server-repeat` run
`39022416616` passes all six native hosts.
[The final report](measurements/server-values-2026-10-17.json) retains 18 raw
tables and actual ARM64/AMD64 reviews, against frozen storage `e6455c0d`.
Next: finish the final-head production/docs gates, fix failures and squash-merge
only after all pass. Independent request work can continue while these run. Its description must state memory improvements, count/stack costs and remaining
request/connection work in plain language. Require all nine production jobs plus documentation on its final head
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
  six-host workflow includes that target; it passes all six native hosts.

The final combined run gives 62,304 bytes at 256 calls on Linux and 61,760 on
macOS/Windows for every workload. Every case/repetition has the same 240-byte
per-call growth. Relative to the original server baseline, the delivery removes
2 / 2 / 3 / 3 allocations and 32 / 32 / 56 / 32 requested bytes per call; retains
change from 0 / 64 / 253 / 0 to 1 / 64 / 128 / 64. These are not timing ratios.
Method dispatch uses 16 fewer fixed stack bytes on both Linux architectures,
while its caller uses 16 more on AMD64 and 64 more on ARM64 than the storage
candidate. Channel-loop code confirms one remaining retain per send.

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

Independent request preparation `/private/tmp/fwp-server-request-owners`, branch
`own-server-requests`, is published at `4b7ecb8bb16583f48ae8fc9d85f0cda5c623b23e`.
Linux `39024071318` passes all focused checks and measurements, including source
construction failures. The earlier move revision also passes `39023556994`.
Every request finalizes; all four workloads leave a constant 864 managed bytes at
1/16/256 calls. Retains per call are 2 / 65 / 130 / 66. Allocations and requested
bytes match the #160 candidate. This moves the parser-pending owner into its job,
rather than adding a job retain. Checks cover reset-before-dispatch, pending
connection death, cancellation, retained/early input sources, parser unwinding
and count overflow, with omitted-owner controls. Guarded artifact download
passed in 3.60s and exact comparison in 0.20s. This is Linux evidence only.

Connection preparation `/private/tmp/fwp-server-connection-owners`, branch
`own-server-connections`, freezes runtime `7770db9a9c2bebee455d9c02dd748fbd7e54fb11`
as `evidence/server-owners-modes-20261017`; all-six `39025450771` is running.
It adds accepted startup, reader/writer and serving-job connection owners;
retained input/output callbacks already acquire them. Startup moves its owner
into the reader. Linux `39024793754` passes new request/connection, existing
startup/listener, channel and task tests, then fails an older output-channel
negative control whose source anchor now matches twice. Its repair names the
sink context explicitly and preserves the required failure on omitted cleanup.

A subsequent review found unconditional accepted-connection counting unsafe in
explicit no-reuse builds, whose channels retain a traced graph. Counting now
requires resource ownership, with an actual no-reuse compiler subprocess testing
a channel retained after I/O closes and a deliberately broken count control.
Superseded all-six `39025166581` at `d3d68598` is confirmed cancelled. The current
run includes this fix, portable client-startup socket checks, explicit Mac/Windows
production target assignments and stricter final request/connection measurements.
The native test-runner's seven tests pass in 1.16s; Cargo metadata covers all 236
targets (0.14s). Formatting passes in 1.28s. A missing `Next:` handoff marker
caused an audit failure in 2.51s; it is repaired and the audit passes in 2.66s.
The preparation branch publishes that documentation-only correction separately
from the frozen runtime. Neither preparation belongs to PR #160. Next: fix probe
failures, retain six-host comparisons and actual binary reviews, then integrate
after #160 merges while preserving its final reports and acceptance record.

Keep all existing failure, cancellation, stress/reuse and negative controls.
Neither disabled collection nor these selected memory reductions establish
complete service ownership, remote checked ARC, zero-cost abstractions or speed
parity. Larger applications, host re-entry, numerical/derivative work, full GC
removal and the remaining seven work areas stay open. JIT is excluded.

## Local checks

Use `python3 scripts/local-guard.py COMMAND...` with fixed limits. Full builds,
suites and measurements run on GitHub. Channel-preparation formatting passed in
1.23s and documentation audit in 2.97s. Passing channel artifact download took
3.30s; guarded comparison took 0.14s. Combined ARM64 artifacts downloaded in
3.47s and AMD64/ARM Mac in 4.88s; each actual-binary inspection and the retained
review check passed in 0.14s. Both Linux reviews identify the per-send channel
retain and direct method entry, including stack-frame costs. Root integration preserved both accepted
allocation-test repairs and `git diff --check` passed. Initial root formatting passed in 1.42s and docs in 2.89s. Final six-host
report collection passed in 12.05s; a report-wide slope check passed in 0.14s.
Final publication formatting passed in 1.34s and docs in 2.84s. Windows artifact collection
passed in 5.25s. Request-move formatting passed in 1.28s and docs in 2.77s.

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
