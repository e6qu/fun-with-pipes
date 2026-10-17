# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery and preparation

Root PR #158 at `30036a1576aa537e2b882b7d166502f8bfa892f3` is awaiting
production `39011071759`; docs `39011071706` pass. Root's handoff and
`/private/tmp/fwp-watch-merge-158.py` own its authorized exact-head squash merge.
Keep one active delivery PR at a time.

Sender preparation `/private/tmp/fwp-sender-input-owners` is independently
validating continuation moves at `06f3ac6ff8fbf2ee5616511c6b968388fac4f3f2`,
six-native-host run `39013126818`. Its first Linux ownership probe passes with
bounded memory but increased reference-count traffic; see that worktree's
handoff. Complete its evidence and delivery before server ownership changes.

This worktree `/private/tmp/fwp-server-request-baseline`, branch
`measure-server-request-lifetimes`, starts at root PR #158's `30036a15`.
It prepares measurement only; production runtime/compiler are unchanged.
No server ownership fix or measured improvement is claimed yet.

## Server baseline design

Client memory measurements exclude server memory. The ignored test
`server_measurement::repeated_server_call_memory` in `tests/grpc.rs` measures
four native-server programs: a 64-character greeting, 64 returned integers,
64 sent integers and 64 strings delivered through a channel. Each process
serves 1/16/256 calls over one reused connection, with three fresh processes per
case. Native clients check matching output against interpreted and ordinary
native servers. Generated C and binaries use `-O2` and are retained with raw logs,
hardware/toolchains and tables. [The fixture guide](../tests/fixtures/server-memory/README.md)
introduces notation, expected outputs and sampling limits.

Allocation/reference-count counters reuse the existing client instrumentation,
but begin after server/listener/root-task setup. Per-call samples run after
serving-task stack/list removal. The final sample requires the expected calls
to finish, the client connection to close and no serving/I/O/other tasks to remain.
It precedes listener/process shutdown. Record storage can still remain even
when its task has finished; tracing is disabled and physical freeing enabled.
Selected job/task/argument-array categories count cumulative allocations,
not identities of live objects. Raw buffers/messages, stack pools, TLS/OS/allocator
metadata, whole-process memory and timing are excluded. No C/Rust comparison.

The `server-repeat` workflow suite can select one native runner or all six.
Native execution is unverified. The four workload expressions typechecked in
0.76s under the root guard after adding concrete input types and explicit channel
effects. Formatting passed in 1.30s and the documentation audit in 3.49s.
Next: publish the measurement branch and dispatch a Linux AMD64 probe; fix sampling
or execution failures before collecting a six-platform baseline. Do not change
production server ownership before that baseline is frozen.

## Local work rules

Use `python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py` with
fixed limits. Full builds, native tests and measurement run on GitHub. No local
native build or downloaded executable execution has occurred. Keep root and
sender handoffs current; do not replace them with this preparation's old plan
or history when transferring changes.

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
