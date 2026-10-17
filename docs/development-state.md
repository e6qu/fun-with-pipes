# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

Branch `free-sender-inputs` starts at accepted #158 squash
`a96871c9e97e06da5a1187d53d198fbdfe6ed970`. #158 passed all nine production jobs
in `39011071759` and docs in `39011071706` at `30036a15`. Its tested tree,
parent and complete one-line message were verified. Duplicate postmerge
production `39016152665` is confirmed cancelled; preserve dependency jobs.
Private acceptance record: `/private/tmp/fwp158-merge-record.json`.

This delivery combines input cleanup, failure/cancellation repairs, unique
continuation moves and the six-platform server baseline. It transfers preparation
`9a4e2ace` from `/private/tmp/fwp-sender-input-owners` while preserving #158's
later allocation-test repairs. No server ownership implementation is included.
Keep one delivery PR at a time. Publication/full production acceptance is next.
Transfer checks preserved both accepted allocation-test repairs. Root formatting
passed in 1.29s and documentation audit in 3.34s; `git diff --check` passed.

## Input ownership evidence

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

Next: finish transfer checks and publish this one delivery PR with a plain
explanation of the memory improvement and remaining count costs. Require all
nine production jobs plus documentation on its final commit before authorized
squash merge. Use one subject of at most 80 characters, an empty body and no
trailers or attribution. Fix failing checks; queued CI gates merge, not preparation.

## Server baseline bundled with this delivery

The measurement foundation from `/private/tmp/fwp-server-request-baseline` is
included in this worktree: the ignored server test, fixture, workflow suite,
strict collector and static-binary inspector. Its report and raw tables are
[retained here](measurements/server-call-baseline-2026-10-17.json). All six hosts
pass run `39014733093` at `0643295938a432cefedb4a3d0c1f263aa9482ee2`, tag
`evidence/server-call-baseline-20261017`. Production server ownership is unchanged.

Four workloads measure server memory after 1/16/256 completed calls and client
connection closure. A measurement-only wake of the existing listener lets the
scheduler retire its last finished task; this creates no extra task/connection.
Storage grows on every host. At 256 calls Linux AMD64 retains 721,248 / 2,486,624 /
1,753,440 / 971,104 bytes for greetings / returned streams / sent streams /
channel output. Actual ARM64/AMD64 reviews confirm traced task/job retention and
unowned user-method/response-iterator application. These measurements exclude
client memory and timing. Collection passed under the root guard in 21.62s.

Independent preparation `/private/tmp/fwp-server-call-owners`, branch
`own-server-call-storage`, starts at input preparation `9a4e2ace`. Candidate
`ebc1590d` failed Linux probe `39016150516`: the peer-lifetime fixture renamed
the allocator function definition along with its calls. Ordinary networking
checks passed; repair the fixture before collecting server measurements. It frees job/task records while
preserving retained serving contexts and scoped task identities. It has no PR
and is unverified; do not copy it into this validated input delivery. Its handoff
tracks candidate controls and remaining server values/connections. Transfer only
its later delta after input acceptance, preserving current root fixes/history.

Combined sampler probe `39015439403` passes on Linux at `9a4e2ace`, validating
integration of the server instrumentation with input ownership. Its final table
comparison with the frozen server baseline is still to collect.

## Checks and artifacts

Use the root `scripts/local-guard.py` with fixed limits. Native builds, full
suites and measurements run on GitHub; no downloaded executable has run locally.
Final report collection passed in 13.06s; each architecture's static inspection
passed in 0.15s. Completed Windows/ARM Mac artifact collection took 11.50s. Formatting passed
in 1.30s; the combined documentation audit passed in 3.37s. Report-wide
checks confirmed stable server repetitions and unchanged complete-input allocation
counts in 0.14s.
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
