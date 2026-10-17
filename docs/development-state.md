# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery and next preparation

Root branch `free-closed-connections` has [PR #158](https://github.com/e6qu/fun-with-pipes/pull/158)
at `30036a1576aa537e2b882b7d166502f8bfa892f3`. Production `39011071759`
and documentation `39011071706` gate its authorized squash merge after repairing
two stale allocation-failure test hooks exposed by the prior Mac stress run. The root
handoff and `/private/tmp/fwp-watch-merge-158.py` own that acceptance. Do not
open a second PR. #157 is accepted as `30668bf8`; see [history](roadmap-history.md).

This worktree `/private/tmp/fwp-sender-input-owners`, branch `own-sender-inputs`,
prepares pending input ownership after #158. Its frozen baseline has the production runtime/compiler unchanged from #158.
The candidate adds typed input ownership and request failure cleanup. It measures
synchronous integer sending, bidirectional strings, retained original input
aliases and early server completion. The [fixture guide](../tests/fixtures/sender-inputs/README.md)
explains notation, outputs and scope. Do not infer lifetime safety from typechecking.

The baseline uses 1/16/256 calls of up to 64 inputs and three measured processes
per case, with collection disabled and physical freeing enabled. Native hooks
close connections and drain I/O/sender tasks before the next call and final
sample. Ordinary native/raw interpreter outputs provide functional references;
their pooling performs different transport work. A separate input-client drain
fixture admits sender tasks without weakening the response-only fixture.

Counters record allocation requests/charged bytes, retains, connection/request/
message cleanup, sender task completion, input values pulled/encoded and sender/
task allocation categories. Early completion can perform different work between
runs; retain actual input counts rather than impose equal allocation totals.
No elapsed-time, whole-process memory or C/Rust comparison is claimed. Retain
source, emitted C, binaries and raw checkpoints before modifying ownership.

Linux probe `39008824856` passed at `ef69079d`. On Linux AMD64, remaining
managed storage grows by 7,104 bytes per synchronous call and 13,104 per
bidirectional/retained-input call despite complete connection/request/message
release and finished sender tasks. At 256 calls that leaves 1,820,416 and
3,356,416 bytes respectively. Early completion performs variable input work.
Static actual-binary review confirms entry sharing and unowned iterator advance;
review and artifacts are under `/private/tmp/fwp-sender-input-evidence/39008824856`.
These are probe results, not six-platform acceptance or a speed comparison.

The frozen baseline tag `evidence/sender-input-baseline-20261017` points at
`f6ebb2e9a8c0c8d5bffbc40f1f46e374e0acbd22`; six-host run `39009268395`
passes on all six hosts. Its runtime, compiler and workloads match the Linux
probe. The [report](measurements/sender-input-baseline-2026-10-17.json) and raw
tables were collected through the root guard in 24.24s. Actual Linux ARM64 and
AMD64 binaries were inspected; no downloaded executable ran locally.
The baseline source is fixed while independent candidate work proceeds.

## Input ownership candidate

The local compiler supplies each streamed remote call's concrete iterator drop
function, including direct-only calls, and stops marking that input permanently
shared. Arguments remain borrowed at entry; the cursor acquires an independent
owner. It keeps current and pending nodes separately so the current element
survives next-step evaluation and encoding. A static client descriptor supplies
the type information; no additional input heap object is introduced.

Synchronous cursors live on the stack. Detached senders hold the same state,
release it and their raw record on completion/failure/cancellation, and use the
existing unique scheduler-task policy. Existing fixtures now use explicit empty
input descriptions and drain task lists without reading freed handles.
New negative controls omit input retains, each node release, sender freeing or
unique task disposal. Normal cases include retained aliases, continuation and
encoding traps, pre-entry cancellation and cancellation during encoding.
Candidate `27208c1ac7b83cc5e07a1dd03201877f41d28008` is published;
Linux run `39009844155` passed existing cleanup tests but failed a new negative
control: after detecting the deliberately missing input retain, returning from
main entered library teardown with the fixture's task still live and obscured
the intended exit 223. The fixture now uses static descriptor metadata like
production and exits immediately on a failed invariant. Its normal ownership
cases and client measurements were not reached; no candidate acceptance yet.
The next probe also includes failed input-retain acquisition and remote-output
pipelines, retained upstream readers and chained senders.

Repaired candidate `81e2586e0192a8d71bdac002a078122d8c1aa7de` runs in
Linux probe `39010422154` failed because the fixture expected a reset request
to retain its already-released active-list owner. The assertion now accounts for
whether the request is still listed. This is not candidate acceptance.

Review also found that native synchronous input failures and failed response
channel deliveries did not reset the request, unlike the interpreter. Scoped
reset cleanup now runs before dropping the caller's request owner. Tests cover
encoding/continuation traps, blocked sends and channel delivery, including
deliberately omitted resets. A real input-continuation failure runs with each
interpreter/native client/server combination. The failure and ownership changes
await the next runner probe; no native validation is claimed yet.

Next: publish the repaired candidate, inspect its Linux run, then compare memory
and reference-count totals before selecting any further optimization. Require six native
candidate jobs, matching outputs, complete input/sender/connection cleanup,
bounded remaining storage, failure controls and actual ARM64/AMD64 binary review
before preparing the next delivery. PR #158 remains the only active PR.

Local work uses the root guard with unchanged limits. Candidate formatting passed in 1.31s; fixture formatting in 0.01s and documentation
audit in 3.19s. The local six-host collector passed syntax parsing in 0.20s.
No local builds or native execution ran. All native measurement work belongs on
GitHub. Private design notes are `/private/tmp/fwp-next-connection-ownership.md`.
Do not copy this preparation's old plan/history over the active root handoff.

Pending sender values, retained server callbacks/channels, host re-entry,
numerical ownership and cycle policies remain open. Remote checked ARC remains
unsupported. All seven project work areas remain open; JIT is excluded.

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
