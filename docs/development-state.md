# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This is independent remote-stream measurement preparation, not another PR.
The active delivery is [PR #154](https://github.com/e6qu/fun-with-pipes/pull/154)
in `/Users/zardoz/projects/fun-with-pipes`, branch `service-iteration-delivery`.
Its current six-host run is `38973106656`; actual WebAssembly is `38973110352`.
Keep its root handoff current and require final nine production jobs, docs and
the two newly introduced Windows dependency jobs before its authorized squash.

## Current action

Workspace: `/private/tmp/fwp-stream-caches`, branch `measure-remote-stream-storage`.
Base: `20f0f5f0`. The added test and fixture measure `g_force`/`g_cell` with real
queued protobuf messages containing 16-character strings. Cases consume all
1/32/128 elements, stop after roughly half, or keep the first position alive.
Every position is read twice; the second read must return the same value without
receiving or allocating again. A deliberate removal of caching must fail.

The test records setup allocations separately from receive/cache allocations,
charged managed storage before/after clearing C roots, and unread queued
messages. Library shutdown must release every raw queued message. It runs at
O1/O2 with collection disabled for measurements and stress/verification enabled
for semantics. It does not change runtime behavior or add ownership.

Next: run the `stream-storage` focused suite on this branch and inspect failures,
then retain its baseline. This controlled receive/cache measurement excludes
socket I/O, connection pooling and full remote-call performance. Existing cells
have no explicit release operation; clearing C roots does not pretend otherwise.
Do not mark stream ownership complete from a passing baseline.

Before combining after #154 acceptance, rebase only this branch's changes after
`20f0f5f0` and preserve any measured source under a remote evidence tag. Keep one
PR at a time. Full builds, native compilation and full tests belong on GitHub;
local checks use `python3 scripts/local-guard.py` at unchanged limits. Formatting
passes (1.09s). New tests and the workflow are not verified yet.

Every commit/squash message is one line, at most 80 characters, without bodies,
trailers or attribution. JIT is excluded. Failing tests are work to fix.

## Remaining ownership questions

A cached value and continuation need independent owners for aliases, early stop
and retained positions. The incoming source must keep its stream/connection and
codec captures alive. Define back-references and cycle policy before permitting
ARC remote calls. After baseline collection, add last-reference cleanup and
partial-allocation/error/cancellation controls, then actual interpreter/native
service comparisons. Keep the existing immutable iterator behavior and syntax.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Remote-stream cache and connection ownership; remove tracing |
| 2 | In progress | Remaining functional allocation and state bookkeeping |
| 3 | In progress | Equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU ownership |
| 6 | In progress | Repeated comparable measurements |
| 7 | In progress | Larger representative applications |
