# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.
This is preparation state; the root worktree owns the active delivery handoff.

## Delivery and prerequisites

Root input cleanup PR #159 is at `91398527`, production `39016595534` and docs
`39016595480`. Linux AMD64 and regular Intel macOS remain in progress; other
production jobs and docs pass. Its exact-head watcher owns authorized merge.
Keep one delivery PR at a time; there is no server PR yet.

This worktree `/private/tmp/fwp-server-channel-owners`, branch
`own-server-channels`, starts at typed-value candidate `48ccd3d9`. That candidate
passes Linux `39020484780`, retained by `evidence/server-values-direct-20261017`.
Its real service comparisons include interpreted, ordinary native and explicitly
uncounted native servers. Dedicated cleanup/alias/cancellation controls pass.
Three measured workloads retain 62,304 bytes after 256 calls, growing by 240
bytes per call; channel output retains 365,408. Greeting retains rise from zero
to one per call; sent-stream retains fall from 253 to 128. These are fwp version
comparisons, not timing or C/Rust claims. All-six evidence remains required.

The earlier storage change has passing six-host evidence at `e6455c0d`, run
`39018276989`, with [retained measurements](measurements/server-call-storage-2026-10-17.json)
and actual ARM64/AMD64 instruction reviews. These reports are already included.
Transfer only later implementation deltas after input preparation `9a4e2ace`,
preserving root's #158 allocation-test repairs, acceptance wording and history.
Never replace the root handoff with a preparation file.

## Native output channels

A native output channel sends through a C callback instead of storing values in
a queue. Its only production callback encodes a value and keeps no language
value after returning. The candidate makes this a borrowed-value contract:
callbacks that retain values must acquire their own typed owners. Sending no
longer marks these values for indefinite tracing.

Queue-element cleanup and native-context cleanup occupy alternative fields in
the channel header. It keeps the direct send-function pointer, so native sends
gain no extra table lookup and the header does not grow.
The gRPC context lives after the channel header in the same allocation, removing
one allocation per output-channel call. Last-owner cleanup releases its separate
request/connection references and then the whole channel. Construction protects
partial ownership if a retain overflows. No new language syntax or fallback.

The candidate is unverified. The native channel test covers aliases, closed
sends, blocked-send cancellation, encoding traps, both retain-overflow positions,
and independently retained values. Deliberately omitted context/transport cleanup,
omitted construction cleanup and forced tracing must be detected. The queue test
also checks borrowed native sends and last-alias context disposal. An obsolete
synthetic channel-drop fallback was removed from that fixture.

The workflow runs response and channel cleanup first, then the existing client,
peer, receive, sender and task checks, real networking and measurements. Preserve
all coverage. Count increments may rise where channels now have actual shared
owners; measure and explain them rather than claiming all ARC is gone.

Next: format/audit, publish this candidate and run Linux `server-repeat`. Fix
failures; compare all four unchanged workloads with `48ccd3d9` and the six-host
storage baseline. Once stable, freeze the combined candidate and run all six
native hosts, inspect actual binaries and collect evidence before production
acceptance. The collector still has storage-only expectations and must explicitly
support the new comparison using actual results.

## Remaining boundaries and local checks

Connection/request objects still depend on tracing. Their ownership must account
for jobs, retained iterators, channel callbacks and I/O tasks together, including
any promotion to an uncounted graph. Borrowed scheduler/task back-pointers must
not create owning cycles. HTTP/2 has a separate handler graph. Neither these
changes nor collection-off measurements establish remote checked ARC support.
The private investigation is `/private/tmp/fwp-server-next-lifetimes.md`.

Local checks use the root `scripts/local-guard.py` with fixed limits. Channel
formatting passed in 1.29s and documentation audit in 2.69s. Full builds/tests/measurements run on GitHub. No
downloaded program executes locally. The typed candidate's artifact collection
passed in 3.44s and comparison in 0.21s; artifacts are under
`/private/tmp/fwp-server-memory-evidence/39020484780`. JIT is excluded.

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
