# Session handoff

Updated 2026-10-17 UTC. This is request-ownership preparation, not the root delivery.
All seven work areas in [PLAN.md](../PLAN.md) remain open. JIT is excluded.

## Current preparation

Worktree `/private/tmp/fwp-server-request-owners`, branch `own-server-requests`,
starts at combined server candidate `855fe3d1`. Root branch `free-server-call-values`
owns draft PR #160; all-six `39022416616` now passes. PR #159 is accepted as
`7c463441`; its nine production jobs and docs passed, tested/merged tree and exact
one-line message were verified, and duplicate production `39022161689` cancelled.
Keep one delivery PR at a time; this preparation has no PR.

The request candidate gives accepted gRPC requests an active-list owner. Pending
parser lists independently retain each request until a serving job starts, since
a reset in the same input can unlink it first. The job now receives the pending-list owner by a move, avoiding an extra
reference-count update, and releases it with its final service-context owner. Incoming
server sources hold their own request/connection references; disposing server
input does not apply client response-abandonment semantics. Existing native
channels already acquire these references. HTTP uses the same pending-list
container but its records remain traced; no native HTTP ownership claim.

New tests cover normal calls, reset before dispatch, connection death while
pending, task cancellation, retained input after completion, early source disposal
and job-startup failure. An added two-request parser test traps before dispatch
and proves cleanup of both the transferred owner and still-pending requests. Deliberately omitted fresh/list/job owners,
incorrect client abandonment, omitted parser cleanup and omitted construction
cleanup must fail. Existing
client and peer fixture mutation anchors are updated, without reducing assertions.
The first candidate `c3c8fd8b` passes Linux `39022894056`, including all real
service comparisons and measurements. It duplicated a request for its job. The
subsequent ownership move and parser-unwind coverage remain unverified.

Next: format/audit and publish the ownership-move revision, run Linux
`server-repeat`, repair failures and
compare the unchanged four workloads against `855fe3d1`. Expected outcome:
request storage no longer grows with call count, while connection storage stays
constant for one reused connection. Record count increments instead of claiming
zero runtime cost. Complete source-retain overflow checks as
needed before final acceptance. Full builds/tests run on GitHub.

## Remaining work and validation

Connection ownership, promoted uncounted graphs, HTTP callbacks and cycles still
need proofs. No remote checked ARC claim. Borrowed scheduler/task pointers must
not become owning cycles. The independent channel loop still increments its
reference count once per send; a later compiler borrowing improvement should
address that measured overhead without changing ordinary inference or syntax.

Local work uses the root `scripts/local-guard.py` with fixed limits. Worktree
creation passed in 0.31s, formatting in 1.23s and docs in 2.79s. Native
checks pass for `c3c8fd8b`; the later move/unwind revision is pending.
Downloaded binaries must only be inspected, never executed locally.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server requests/connections and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
