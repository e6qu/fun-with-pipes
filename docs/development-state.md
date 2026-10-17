# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Delivery sequence

Root PR #158 at `30036a15` awaits production `39011071759`; documentation passes.
The root handoff and `/private/tmp/fwp-watch-merge-158.py` own its authorized
exact-head merge. Do not create a competing PR or alter that final-gate head.

Input preparation `/private/tmp/fwp-sender-input-owners` is published at
`9a4e2ace`. Its six-host ownership evidence passes at `06f3ac6f` in `39013126818`;
it bundles the six-host server baseline and is the next delivery after #158.
Combined sampler probe `39015439403` passes on Linux at `9a4e2ace`.
Root transfer must preserve #158's later allocation-test repairs, which are not
in the input preparation's earlier ancestry. See that worktree's handoff.

## Server call storage preparation

This worktree `/private/tmp/fwp-server-call-owners`, branch
`own-server-call-storage`, starts at input preparation `9a4e2ace`. It is isolated
preparation, with no PR. Transfer only its later delta after input acceptance.

The [server baseline](measurements/server-call-baseline-2026-10-17.json) is
`0643295938a432cefedb4a3d0c1f263aa9482ee2`, retained by
`evidence/server-call-baseline-20261017`; all six hosts pass `39014733093`.
Four workloads retain increasing memory after calls/tasks finish and the
connection closes. Actual Linux ARM64/AMD64 instructions show traced task/job
retention. Client memory and timing are excluded; this is not checked ARC.

The first candidate targets the large job and task records before decoded values
and response iterators. A serving context becomes the first member of its job,
so its existing peer-user count owns the whole allocation. Detached senders keep
that allocation alive; ordinary joined children borrow it. Last-owner cleanup
frees peer/status text and the job. No new allocation or reference counter.

Serving-task completion clears the request's borrowed task pointer and the
retained context's task pointer before releasing its job owner. A later failure
through a surviving context still traps, without dereferencing a freed task.
Server reader/writer and serving tasks use unique scheduler ownership when no
scope retains their identity. With a scope, scheduler and scope are two explicit
owners and use the existing counted policy. These are actual owner relationships,
not fallback implementations. Request/connection records remain tracing-owned.

Tests are being adapted to observe actual managed frees without reading freed
records. Controls cover omitted job/task disposal, premature cleanup and loss of
scope ownership. Retained sender context, status replacement, pre-publication
failure and counter overflow remain covered. Assertion failures exit immediately
so library teardown cannot mask their diagnostic with a secondary error.
The server workflow now runs all real gRPC tests plus peer/status/receive/response/
send/task ownership regressions before measuring repeated calls.

Expected result: no extra allocation requests, released job and serving/I/O task
records, and lower per-call retained bytes. Remaining arguments, results, incoming
sources, request/connection records and channels are outside this first change;
remaining memory is not expected to be constant yet. Do not claim server GC
removal or lower execution time from a smaller memory total.

Next: review the candidate and fixtures, run guarded formatting/docs checks,
publish this branch and dispatch a Linux server probe. Fix failures, then measure
all six hosts and review actual ARM64/AMD64 instructions. Keep the input delivery
moving independently; publish only one delivery PR at a time.

## Checks and artifacts

Use `python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py` with
fixed limits. Native builds, full suites and measurement run on GitHub.
Candidate formatting passed in 1.32s and documentation audit in 3.20s;
runtime and tests are not yet verified.
No local native build or downloaded executable execution occurred.
Baseline artifacts: `/private/tmp/fwp-server-memory-evidence/39014733093`.
The baseline preparation's handoff retains deeper lifetime-review notes.

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
