# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This is independent remote-stream measurement preparation, not another PR.
The active delivery is [PR #154](https://github.com/e6qu/fun-with-pipes/pull/154)
in `/Users/zardoz/projects/fun-with-pipes`, branch `service-iteration-delivery`.
Its focused six-host/WebAssembly runs pass. Final head is `51354d10`; production
`38977201910`, docs `38977126983` and Windows dependencies `38977201787` are
the acceptance runs. Docs and benchmarks pass; the remaining jobs are running.
The root has an authorized exact-head merge watcher (exec session `96582`),
`/private/tmp/fwp-watch-154.py`; inspect its output/merge record before taking any
merge action. It stops on a failing gate and never merges skipped checks.

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

## Receive serialization preparation

Two tasks may ask for the same unread position while the first receive is
suspended. The existing cache check alone occurs before that suspension. The
new interpreter/native receive guard lets the second task wait for publication
and then read the cache. Only the receiving task clears the guard; error and
cancellation release it and wake waiters. Cancelling a waiter must not cancel the
receiver. Task pointers here are borrowed identities, not owning back-references.
Recursive reading of the same source traps explicitly. This does not add ARC
eligibility or native cache destruction.

Runner verification is pending. A deterministic native fixture starts two
readers before publishing two messages: both readers must see the first message,
and the second message must remain queued. It also cancels the receiver or its
waiter independently. Removing serialization must fail with different results;
a ten-second task deadline bounds broken wakeups. O1/O2 stress/reuse checks retain
actual binaries. Interpreter controls cover recursive/cancelled waiters and guard
release on failure. A shared-stream client sums 1..1024 in two tasks against
interpreted/native servers; both must print `Some 524800`.

The accepted prebuilt compiler formats this client (0.01s) and type-checks it
(0.24s) under the guard. Rust formatting passes (1.36s), workflow lint passes
(1.01s). No compiler or C program was built locally. Run `stream-storage` first,
repair any failures, then `stream-owners` on all six native platforms and retain
fresh measurements. The collector now requires the concurrency controls too.
The preceding six-host source-lifetime run remains tied to `d9ba5154`; it cannot
validate this newer change.

## Current source lifetime preparation

A successfully read position now retains only its cached value and continuation.
The next unread position retains the receive source; normal end and an error end
retain none. Failure before publishing a complete cache keeps the original
source. The interpreter expresses the two states directly, so a completed cell
cannot also own the source. The native runtime clears the source pointer only
after constructing its result. This does not yet add native reference counting
or make remote calls eligible for ARC.

Focused run `38977738266` passes at `451cc94e45343962a10e66605a763618edb07c51`: real queued messages at
1/32/128 elements, repeated reads, retained
first positions, full/early consumption, status errors and malformed messages.
Interpreter weak references check that only the unread continuation owns the
source, that reaching end releases it even with a retained prefix, and that the
last early owner releases it. Native controls reject retained source edges and
missing caches; existing decode/copy traps must leave the original source intact.
Actual interpreter/native service combinations remain in the focused workflow.

Six-host run `38978268787` is running at `d9ba5154`; both Linux hosts pass.
Next verify the other four hosts and retain its report before expanding ownership.
The collector was checked against the passing one-host run (4.93s) after rejecting
an incorrect full commit argument; evidence is under
`/private/tmp/fwp-stream-source-evidence/38977738266`. The measurement fixture now uses the production source
constructor, including its copied description; compare setup bytes separately
from per-element receive costs. Client formatting now takes explicit method and
address arguments instead of a variadic format interface; truncation is unchanged.
`collect-stream-measurements.py` verifies exact-head successful jobs, named unit/
native/service tests, allocation rows, environment and artifact hashes. It does
not execute downloaded binaries. Use it through the local guard after CI passes.
Recent guarded checks: formatting 1.10s, workflow lint 1.03s, docs 2.51s. Earlier
actual description-format helper inspection passed in 0.20s; its bounded scratch
frame returns before receive. The explicit-argument revision needs fresh evidence.

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
