# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

Root [PR #158](https://github.com/e6qu/fun-with-pipes/pull/158), branch
`free-closed-connections`, is at `30036a1576aa537e2b882b7d166502f8bfa892f3`.
Production `39011071759` is running; docs `39011071706` pass. The root handoff
and `/private/tmp/fwp-watch-merge-158.py` own its exact-head acceptance and
already authorized one-line squash merge. Two stale allocation-test hooks from
the prior run were repaired. Keep one delivery PR at a time; this worktree has
no PR. #157 is accepted as `30668bf8`; see [history](roadmap-history.md).

## Sender input preparation

Worktree `/private/tmp/fwp-sender-input-owners`, branch `own-sender-inputs`,
starts at #158's earlier head `2e747ce6`. Transfer only its delta after #158 is
accepted; preserve the root's later allocation-test fixes and current history.
The compiler supplies concrete input destruction metadata. Cursors own current
and pending iterator nodes, keeping each element alive through lookahead and
encoding. Synchronous cursors live on the stack; detached senders embed them in
their existing record and uniquely own their record/task lifetimes.

The [six-platform baseline](measurements/sender-input-baseline-2026-10-17.json)
is `f6ebb2e9a8c0c8d5bffbc40f1f46e374e0acbd22`, tag
`evidence/sender-input-baseline-20261017`, passing run `39009268395`.
It measures 1/16/256 calls, up to 64 inputs, three processes per case, collection
off and freeing on. Each measured connection closes and its tasks drain before
the next call and final sample. Ordinary native/interpreter outputs use normal
pooling and do different transport work. Early completion can produce variable
input counts. [The guide](benchmarks.md#memory-retained-by-client-inputs-after-sending-finishes)
explains outputs and excluded memory; no timing or C/Rust comparison is claimed.

## Passing Linux probe and next optimization

`274b0a0238b438ce641080f58729cbd0ee176f26` passes Linux AMD64 run
`39011949370`, retained by `evidence/sender-input-owners-probe-20261017`.
The [probe report](measurements/sender-input-ownership-probe-2026-10-17.json)
retains raw tables and actual AMD64 machine-code review. It is one-host evidence,
not six-platform acceptance. Final managed storage stays at 1,792 bytes in all
sizes/modes, down from 1,820,416 synchronous or 3,356,416 bidirectional bytes at
256 calls. Stable full-input modes have unchanged allocation counts. Sender
records request 48 instead of 40 bytes but occupy the same charged 48-byte class.
At 256 calls, retains rise from 17,922 to 66,818 synchronous; 150,274 to 280,578
bidirectional; 181,762 to 344,834 with retained inputs.

The actual AMD64 code confirms borrowed continuation calls on every input.
The next candidate transfers the continuation from an exclusively owned node
and clears its old field before calling it. Shared nodes still use borrowed
application. Current elements remain owned until encoding finishes; evaluation
and failure order are unchanged. Controls detect missing field clearing and
incorrect mutation of shared nodes, alongside existing release/cancellation
checks. This optimization is implemented locally but not yet verified. Publish
it with the report/collector/docs changes and dispatch all six native hosts.

Passing Linux checks also include native request reset on input/encoding and
response-channel failures, real failing-input clients with interpreter/native
servers, retained upstream readers and chained senders. Both engines now check
pre-entry sender cancellation. An interpreter test proves cancelled input is
released without evaluation; a native missing-check control detects the old
behavior. Earlier failed runs `39009844155`, `39010422154` and `39011258349`
exposed fixture teardown/count assumptions and the real pre-entry cancellation
defect; these were repaired before the passing probe. The focused workflow now
runs sender regressions first, without removing or repeating coverage.

## Checks and next action

Native builds, full suites and measurements run on GitHub. Local commands use
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py` with fixed
limits. Latest formatting check passed in 1.30s; documentation audit in 3.22s.
The failing-input example typechecked with the prebuilt compiler in 0.27s.
Baseline collection passed in 24.24s; strengthened source/binary/disassembly
hash checks passed on recollection in 2.04s without rerunning measurements.
Linux probe download took 4.92s and static disassembly 0.15s. No local native
builds or downloaded program execution occurred.

The collector now requires exact-source manual ARM64/AMD64 binary reviews.
Private artifacts/logs are under `/private/tmp/fwp-sender-input-evidence` and
`/private/tmp/fwp-input-owner-passing-linux.log`. Require all six candidate jobs,
matching outputs, complete cleanup, bounded storage, measured remaining count
costs and both architecture reviews before preparing the next delivery. Root
#158's full production gates remain independent and must pass before merging.

After client input acceptance, measure server-process memory before selecting
server callback/channel/task ownership changes. Current client counters exclude
that memory. Host re-entry, numerical ownership, cycle policies and the broader
seven work areas remain open. Remote checked ARC is unsupported; JIT is excluded.

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
