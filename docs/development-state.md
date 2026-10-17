# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery and preparation

The root checkout is `own-client-requests`, ready PR #157, based on accepted
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

Second Linux probe `39003964943` at `c4747dc7` exposed a bad pointer in the
connection-overflow fixture setup; that is repaired. Third probe `39004273477`
at `53dd3314` passes the transport fatal-allocation and connection-owner tests.
Its remaining unique-task exit status is 204 (encoded process status 52224), not
203: completion succeeds, but raw storage remains. The new disposal function used
a counted-storage helper, which intentionally ignores zero-count objects.
Unique tasks now return their raw allocation directly, without inventing a count;
shared task handles keep their existing release policy. Physical-freeing-disabled
builds still retain object storage. The test records exact storage totals and
retains generated source/binaries for static review. This repair needs native
validation; no claim of candidate acceptance yet.

Root #157 head `57d2a09e` has passing documentation and benchmark; production
`39004098429` is still running, watched by `97557` with exact-head merge verification.

The baseline report now retains reviewed actual Linux ARM64/AMD64 binaries;
guarded static inspection took 0.15s per host and recollection 2.02s. The
benchmark guide explains connection/task allocations versus remaining storage,
different host task layouts and exclusions. Collector changes require the new
task, fatal-allocation and POSIX startup checks before accepting a comparison;
script syntax passed under the root guard in 0.20s.

The ongoing fatal-error audit extends the same repair to native allocator,
encoding and differentiation buffer failures. Fatal paths flush buffered output
before `_Exit(102)` without invoking library unload from a task stack. Fifteen
injection/size-error cases check the exact error, exit code and preceding output.
The no-GC/Wasm allocator fatal paths are not changed by this native repair.
These additional changes await native validation. Guarded formatting of the
extended tests passed in 1.03s.

Published `7d6ff905e3c82413f5ef0045fe0b8e56c05a149c` runs Linux
`connection-repeat` in `39004974271`. Next: inspect/fix this probe, then run all
six native hosts and
compare with the retained baseline. Also prove
pooled reuse, startup failure and last-owner cleanup before delivery. Rebase or
transfer the final patch onto accepted #157 before opening the next single PR.

Pending sender language values, server callbacks/channels, remaining host and
numerical ownership, cycle policies and all seven roadmap areas remain open.
The extended fatal-allocation cases still need native validation; do not
weaken library unload checks. JIT is excluded permanently.

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
