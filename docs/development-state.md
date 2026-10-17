# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery and preparation

The root checkout is `own-client-requests`, draft PR #157, based on accepted
#156 merge `29302bae30f6dbfae63166bb9171c7da5b237789`. Its combined request,
compiler and service-settings candidate `d7a161d1` passed all six focused native
jobs in `39001772549`, including the Intel Mac artifact-upload retry. The root
handoff owns final report collection, documentation and the nine production jobs
plus documentation required before squash merge. One active delivery PR only.

This worktree, `/private/tmp/fwp-client-connection-owners`, is the next
preparation branch `own-client-connections`. It starts at the frozen connection
baseline `4103b0a09f06cae69721c29151571ba9e9a621b9`; it is not another PR.

## Closed-connection baseline

All six native jobs passed in `39002767125`. The source is preserved by
`evidence/closed-remote-baseline-20261017`. The report
[closed-remote-baseline-2026-10-17.json](measurements/closed-remote-baseline-2026-10-17.json)
and raw checkpoint/drain tables are retained here. Guarded collection passed in
28.43s. Each connection closes and both I/O tasks finish before the next call;
all requests/messages release, but remaining managed storage grows per connection.
The increases are Linux AMD64 3,904 bytes, ARM64 12,608; either Mac 1,600;
Windows AMD64 2,368, ARM64 2,112. Linux AMD64 records 320 charged connection
bytes plus 3,584 charged bytes for two I/O task allocations per connection.
These category counters measure allocation, not live-object attribution.

The workload uses 1/16/256 batches, 64 response integers, full/partial/retained
readers and three processes per case. Retained readers make two calls per batch.
Ordinary native and raw interpreter output agree; only instrumented clients
force connection closure. They therefore do different transport work from the
pooled-client comparison. Raw TLS/OS/process storage, stack pools and timing
are excluded. Never relabel pooled live storage as a proved leak.

## Implementation under test

Client connection storage has independent pool, I/O, caller/source and sender
owners. The existing transport count still closes the socket when reader and
writer finish. Last storage release removes the weak finalizer, frees metadata
and raw connection storage. Requests carry their connection owner in existing
source/call structures; there is no new request-to-connection back-pointer cycle.

Detached client I/O tasks have one scheduler owner. Their storage releases after
stack and scheduler-link removal without task reference-count updates. Shared
language handles retain their counted policy; server/HTTP paths still use
tracing. Synthetic fixtures drain live task lists instead of awaiting already
freed I/O handles. WebAssembly fixtures use the explicit shared-task policy.

Acceptance needs physical release of closed connection and finished task storage,
constant final managed bytes across every measured size/mode, shared/retained
readers, failure/cancellation/overflow controls, native/interpreter agreement,
stress/reuse tests and all six hosts. Measure remaining allocation and count
traffic; do not call this zero-cost or enable remote checked ARC prematurely.

## Checks and next action

First candidate `4d595abf`, Linux run `39003608985`, failed two test fixtures:
the source-release mutation matched two sites instead of one, and the unique
C-task probe expected cancellation before calling the runtime cancellation check.
Both are repaired locally. Other focused runtime tests in that step passed;
later steps were skipped and are not validation. The repaired tests additionally
cover connection-count overflow and omitted source/sender/connection-storage
release, plus finalizer removal. Existing shared-task/ARC checks remain enabled.

All native builds run on GitHub. Root-guard formatting passed in 1.06–1.16s;
`python3 scripts/check-roadmap.py` passed in 2.60s. The root guard path is
`/Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py`; retain its fixed
limits. No downloaded executable has run locally.

Next: publish these fixes, run Linux `connection-repeat`, repair any failures,
then run all six native hosts and compare with the retained baseline. Also prove
pooled reuse, startup failure and last-owner cleanup before delivery. Rebase or
transfer the final patch onto accepted #157 before opening the next single PR.

Pending sender language values, server callbacks/channels, remaining host and
numerical ownership, cycle policies and all seven roadmap areas remain open.
Fatal allocation paths that call `exit` from task stacks also need repair; do not
weaken library unload validation. JIT is excluded permanently.
