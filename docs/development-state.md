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

Next: verify the stream-description lifetime repair, then design the cached
result's owner and incoming source's lifetime before admitting remote calls to ARC.
The client previously separately allocated its description without a matching
release; the server borrowed its handler's text. Both now copy description bytes
into the existing incoming-source allocation. Client truncation remains unchanged,
and formatting scratch returns before receive may suspend. The mutation,
stack-lifetime, size-overflow, one-allocation and deliberate borrowed-text controls
pass on Linux AMD64 in `38977205160` at `b84a7581`, along with actual interpreter/native
service calls. Artifacts are retained under
`/private/tmp/fwp-stream-description-evidence/38977205160` (guarded download 2.47s). No ARC eligibility
was expanded; the source object still follows its existing collector lifetime. This controlled receive/cache measurement excludes
socket I/O, connection pooling and full remote-call performance. Existing cells
have no explicit release operation; clearing C roots does not pretend otherwise.
Do not mark stream ownership complete from a passing baseline.

Before combining after #154 acceptance, rebase only this branch's changes after
`20f0f5f0` and preserve any measured source under a remote evidence tag. Keep one
PR at a time. Full builds, native compilation and full tests belong on GitHub;
local checks use `python3 scripts/local-guard.py` at unchanged limits. For the description repair, guarded `cargo fmt --all -- --check` passes (1.34s),
`actionlint .github/workflows/numerics.yml` passes (1.01s), and
`python3 scripts/check-roadmap.py` passes (2.40s). Native tests await CI.
The preceding measurement baseline passes Linux AMD64; broader hosts and actual
networking remain to verify for this preparation.

Every commit/squash message is one line, at most 80 characters, without bodies,
trailers or attribution. JIT is excluded. Failing tests are work to fix.

## Current source lifetime preparation

A successfully read position now retains only its cached value and continuation.
The next unread position retains the receive source; normal end and an error end
retain none. Failure before publishing a complete cache keeps the original
source. The interpreter expresses the two states directly, so a completed cell
cannot also own the source. The native runtime clears the source pointer only
after constructing its result. This does not yet add native reference counting
or make remote calls eligible for ARC.

Pending CI: real queued messages at 1/32/128 elements, repeated reads, retained
first positions, full/early consumption, status errors and malformed messages.
Interpreter weak references check that only the unread continuation owns the
source, that reaching end releases it even with a retained prefix, and that the
last early owner releases it. Native controls reject retained source edges and
missing caches; existing decode/copy traps must leave the original source intact.
Actual interpreter/native service combinations remain in the focused workflow.

Next give cached native values and continuations explicit typed owners, with
last-reference and partial-construction cleanup. The incoming source must own
its stream/connection and decoder captures. Define back-references and cycle
policy before permitting ARC remote calls. Connection pooling, retained tasks,
server contexts, cancellation and detached users remain separate boundaries.
Prefer moving the source into the next cell once construction succeeds; failure
must leave the original owner intact. Avoid per-element source ARC traffic where
that move suffices. Unique consumers may later move results or reuse cells;
aliases must retain immutable cached behavior.

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
