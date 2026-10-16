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

The `stream-storage` run `38973859489` passes on Linux AMD64 at `deae732b`.
The [baseline](measurements/remote-stream-baseline-2026-10-16.json) records four
managed requests/89 requested bytes per 16-character value, charging 112 bytes
per value after allocator rounding. Setup charges 688 bytes. At 128 values,
15,024 managed bytes remain charged after clearing C roots. Every repeated read
uses the cache; deliberately disabling caching fails. Whole-library shutdown
frees all queued messages. Guarded artifact download passed (2.10s).

The actual AMD64 binary tests the forced flag and returns its saved value before
entering receive/decode work. Artifact hashes and exact-head CI success were
rechecked under the local guard (1.30s). The common function stack frame remains;
this is representation evidence, not a speed claim.

Next: design the cached result's owner and the incoming source's lifetime before
admitting remote calls to ARC. This controlled receive/cache measurement excludes
socket I/O, connection pooling and full remote-call performance. Existing cells
have no explicit release operation; clearing C roots does not pretend otherwise.
Do not mark stream ownership complete from a passing baseline.

Before combining after #154 acceptance, rebase only this branch's changes after
`20f0f5f0` and preserve any measured source under a remote evidence tag. Keep one
PR at a time. Full builds, native compilation and full tests belong on GitHub;
local checks use `python3 scripts/local-guard.py` at unchanged limits. Formatting
passes (1.09s). The focused new tests and workflow pass on Linux AMD64; broader hosts and real
networking remain to verify. Workflow lint (0.89s) and handoff audit (2.39s) pass.

Every commit/squash message is one line, at most 80 characters, without bodies,
trailers or attribution. JIT is excluded. Failing tests are work to fix.

## Remaining ownership questions

Candidate to investigate, not implemented: an unforced cell could own its
incoming source and move that owner into the next cell after a successful receive.
A forced cell would own its cached result instead. That may avoid a source
retain/release on every element, while cached continuations keep aliases valid.
Failed construction must leave the source with its original owner. Forced-end
cells must not keep a dead source merely for type information. Unique consumers
may later move results or reuse cell storage; aliases still require caching.

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
