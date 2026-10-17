# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

Root [PR #158](https://github.com/e6qu/fun-with-pipes/pull/158), branch
`free-closed-connections`, is at `30036a1576aa537e2b882b7d166502f8bfa892f3`.
Production `39011071759` is running; docs `39011071706` pass. The root handoff
and `/private/tmp/fwp-watch-merge-158.py` own its exact-head acceptance and
already authorized one-line squash merge. Both stale allocation-failure hooks
are repaired; the superseded run finished with only those same two failures.
Keep one delivery PR at a time. This preparation has no PR.

## Input ownership ready for delivery

Worktree `/private/tmp/fwp-sender-input-owners`, branch `own-sender-inputs`,
starts at #158's earlier head `2e747ce6`. Transfer its delta after #158 is
accepted, preserving root's later allocation-test fixes and current history.

The compiler supplies concrete input destruction metadata. Cursors own current
and pending iterator nodes, keeping elements alive through lookahead and encoding.
Synchronous cursors stay on the stack; detached senders embed them in their
existing records. Sender records and scheduler task records have unique owners.
Unique iterator nodes move their continuations; shared nodes preserve them for
older readers. Native request reset on input/channel failures now matches the
interpreter, and both engines check cancellation before a sender evaluates input.

All six native hosts pass run `39013126818` at
`06f3ac6ff8fbf2ee5616511c6b968388fac4f3f2`, retained under
`evidence/sender-input-ownership-20261017`. The
[final report](measurements/sender-input-ownership-2026-10-17.json) includes raw
tables and actual Linux ARM64/AMD64 instruction reviews. Its
[baseline](measurements/sender-input-baseline-2026-10-17.json) is `f6ebb2e9`,
tag `evidence/sender-input-baseline-20261017`, six-host run `39009268395`.

Across 1/16/256 calls, all four modes leave constant final managed bytes:
Linux AMD64 1,792, Linux ARM64 6,144, either Mac 640, Windows AMD64 1,024,
Windows ARM64 896. Collection is off and physical freeing on. All connections,
requests and messages release, and sender/I/O tasks finish. Complete-input
allocation counts are unchanged; background sender headers request eight more
bytes each but occupy the same allocator class. At 256 calls, count increments
are 18,946 synchronous, 184,322 bidirectional and 248,578 with retained input,
versus baseline 17,922 / 150,274 / 181,762. These exceed the baseline but improve
on the first ownership probe's 66,818 / 280,578 / 344,834.

[The guide](benchmarks.md#input-owners-and-moves-bounded-memory-with-measured-count-costs)
explains outputs, sizes, remaining costs, variable early-completion work and
excluded memory. There is no timing or C/Rust comparison. Count-one checks still
read runtime allocation metadata; remote checked ARC remains unsupported.

Passing checks cover retained input, chained senders, real failing-input clients
against both server engines, continuation/encoding traps, blocked writes,
pre-entry cancellation, retain overflow, GC stress and reuse. Deliberately broken
variants prove detection of missing releases, mutation of shared nodes and
omitted cancellation/reset. Earlier failures are repaired; no focused check is
outstanding. Full production acceptance remains required on the delivery head.

Next: after #158 passes and merges, transfer this batch onto its accepted squash
commit, reconcile PLAN/history/handoff and publish the single next delivery PR.
Use `/private/tmp/fwp-sender-input-pr-draft.md` as a plain-language starting point;
fill in final validation and require all nine production jobs plus documentation
before the authorized squash merge. Preserve one-line messages of at most 80
characters, with an empty body and no trailers or attribution.

## Independent server measurement

`/private/tmp/fwp-server-request-baseline`, branch
`measure-server-request-lifetimes`, is frozen at `06432959`, tag
`evidence/server-call-baseline-20261017`. Six-host run `39014733093` is running.
The Linux probe passes at `e0baca20` in `39014302981`; server memory grows after
all calls/tasks finish and the connection closes. This changes no production
compiler/runtime and has no PR. Its own handoff tracks measurements, sampling
boundary repair, actual AMD64 review and strict collection. Finish input delivery
before server ownership changes. Client measurements exclude server memory.

## Checks and artifacts

Use the root `scripts/local-guard.py` with fixed limits. Native builds, full
suites and measurements run on GitHub; no downloaded executable has run locally.
Final report collection passed in 13.06s; each architecture's static inspection
passed in 0.15s. Completed Windows/ARM Mac artifact collection took 11.50s. Formatting passed
in 1.30s; the final documentation audit passed in 3.38s.
Private artifacts are under `/private/tmp/fwp-sender-input-evidence`.

Server/HTTP lifetimes, host re-entry, numerical ownership, cycle policies and
the broader work areas remain open. JIT is excluded.

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
