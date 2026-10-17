# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

Branch `own-client-requests` starts at accepted #156 merge
`29302bae30f6dbfae63166bb9171c7da5b237789`. It combines request cleanup,
compiler field transfers and service TLS-cache construction fixes. No syntax
changes. [Draft PR #157](https://github.com/e6qu/fun-with-pipes/pull/157) is published
at `2844e493`. Make it ready after focused evidence and
final documentation are complete; require all nine final-head production jobs
and documentation before authorized squash merge. Use one subject, at most
80 characters, and an explicitly empty body. Verify the resulting tree/message.

#156 passed exact head `d19ab045` in production `38996879616` and docs
`38996879603`. Its tree, parent and one-line message were verified;
`/private/tmp/fwp156-merge-record.json` preserves the record. Duplicate production
`39001824256` is canceled. Acceptance details now belong in the history, not
another active next-action list.

## Retained request-cleanup evidence

`own-remote-transport-storage` in `/private/tmp/fwp-repeated-remote-calls`
contains request cleanup, repeated-call evidence and documentation. All six native
jobs passed at `997b23a9aa392a3cde8fb8bd5026c348545c06b2` in `39000228402`.
Tag `evidence/remote-request-ownership-20261017` preserves that measured source.
The report is `measurements/remote-request-ownership-2026-10-17.json`, with raw
checkpoint tables beside it. Baseline `ac95632b` remains independently preserved
by `evidence/repeated-remote-baseline-20261017`, run `38997585835`.

Full, partial and retained readers run 1/16/256 batches of 64 integers, three
processes each. Every created request/message releases; final managed bytes stay
constant in every mode: Linux AMD64 6,240, ARM64 19,296; either Mac 2,240; Windows
AMD64 3,392, ARM64 3,008. Baseline storage grew 240 bytes per call and partial
readers retained queued messages. Allocation requests/bytes are unchanged; the
new ownership adds one retain per call. The benchmark guide explains scope and
costs. These are focused results, not full delivery acceptance or checked ARC.

Counter sampling ends after root execution, child joins and cached-value cleanup,
while reusable connections and detached I/O tasks remain live. Do not call that
remaining connection storage a demonstrated leak. Other raw buffers, TLS/OS and
process memory, server storage and timing are excluded. Infinite active requests
are not a bounded-memory claim.

Request owners are the active list, reader and optional detached sender. Reader
release discards unread messages without cancelling the remote operation; the
list retains unfinished requests. Last release removes the weak finalizer and
frees metadata/raw storage. Native fixtures cover all terminal events, aliases,
sender cancellation, failed preparation, retries, decoder errors, count overflow
and deliberate missing cleanup. Windows API-header ordering and fatal OOM from
task stacks were repaired before the passing run. Superseded runs are historical
failures, not remaining next actions.

Reviewed Linux binaries show looped queued-message release and final request
cleanup. Request size/alignment is 232/8 bytes on all hosts; the flag uses padding.
Cache frames are 24 bytes AMD64 (excluding incoming return address), 64 ARM64
(including saved registers); request reader-release frames are 24/32 bytes.
Callee frames are additional. No downloaded executable ran locally.

## Compiler change to bundle with request cleanup

`move-boxed-projections` in `/private/tmp/fwp-boxed-projections` starts at `997b23a9`.
Published head `d1beb206ed4122afa9b575b5cf16989b684fa219` passed Linux `fields`
run `39000896503`. Real repeated-client probe `39001303292` passed at that head. For 256 full
reads, retains fall from 66,562 to 50,178; partial reads from 41,986 to 33,794;
retained readers from 116,226 to 99,586. Allocation requests and final managed
storage are unchanged. These are Linux AMD64 results until the native matrix passes. No second PR is open; bundle these related changes after measurement.

When a consumed heap record has only one counted field and one owner, the
compiler transfers that field and frees the parent without retaining it first.
Shared records keep their existing field owners. Stack aliases, resource frames,
virtual loop state, disabled freeing and planned storage reuse retain their
existing paths. Interpreter/native, unique/shared, scalar-bit, exact reclamation,
error cleanup and deliberately broken variants pass in the focused Linux suite.
No six-platform or timing claim yet.

A related service TLS-cache fix now checks construction allocation, keeps the
entry/name together and releases unpublished entries if TLS construction traps.
Its temporary name storage also accommodates complete environment-variable names,
removing the old 300-byte truncation. Tests add two injected failures, retry,
missing-cleanup detection and 1,024-character names. They are unvalidated until
the next native run. Stream suites now include these cache tests.

Combined head `d7a161d1328f78c54870688c6dd30cf24fa22aa0` is published.
Six-platform `stream-repeat` run `39001772549` is queued/running.
Watcher exec `71043`, `/private/tmp/fwp-watch-projection-moves.py`, verifies the exact six jobs
and collects the comparison only after success. Next: inspect and fix failures.
Use the retained `997b23a9` request report as baseline with `--projection-moves`.
Preserve actual measurement revisions. Then copy the accepted combined report into the root delivery and run all
production gates. One delivery PR at a time.

## Next preparation: own closed client connections and I/O tasks

Worktree `/private/tmp/fwp-client-connection-owners`, branch
`own-client-connections`, starts at frozen baseline `4103b0a0`. No implementation
is published yet. Keep this separate from active draft PR #157. Its root worktree
and current GitHub checks are authoritative for delivery status.

Linux baseline `39002262144` at `d802e102` passes. Closing connections and draining
I/O tasks leaves 3,904 additional managed bytes per connection: 5,696 after one,
1,001,216 after 256. All sockets close and request/message storage releases;
no connection finalizer runs. Baseline `4103b0a0` adds separate cumulative
connection/task allocation categories; six-platform run `39002767125` and watcher
`51721` retain its exact-source evidence. Do not relabel earlier artifacts.

Acceptance for this preparation: every closed connection physically releases,
completed client I/O task objects release, final charge stays constant across
1/16/256 batches and all reader modes, pooled/shared readers keep working, and
normal/failure/cancellation/overflow paths preserve output and cleanup order.
Measure new count traffic and preserve all native platforms, stress/reuse and
missing-cleanup controls. No admission of remote calls to checked ARC yet.

Client connections need explicit pool, I/O, call/source and sender owners.
Keep socket-liveness refs separate from storage ownership. Transfer a returned
connection owner with the stream; protect partial construction and acquired refs.
Drop request before connection, remove weak finalizers before physical freeing,
and keep scheduler links borrowed to avoid cycles. Server/HTTP connections remain
unproved paths. Private detailed notes: `/private/tmp/fwp-next-connection-ownership.md`.

The detached client reader/writer task objects have one scheduler owner and no
language-visible handles. Prefer an explicit unique-storage task policy and direct
cleanup after stack removal over adding reference counts to them. Preserve shared
language task handles and current tracing-dependent paths as distinct policies;
reuse the existing policy field rather than enlarging task headers without evidence.
Tests must distinguish those lifetimes, including startup failure before either
background task is published. Do not weaken old task-handle or ARC controls.

Next: implement these contracts, revise raw test handles that outlive a uniquely
owned task, and run focused Linux checks on GitHub. Keep the frozen baseline
worktree untouched. Fix failures and measure actual clients before publication.

## Local verification and remaining work

All builds/native execution run on GitHub. The root `scripts/local-guard.py`
keeps fixed limits. Formatting checks passed in 1.1–1.4s; doc audits in 2.4–2.7s.
The six-host request collection passed in 27.55s; recollection with reviewed
binaries in 1.53s. Static inspection passed in 0.15s per Linux architecture.
Compiler collector syntax passed in 0.20s. Updated documentation audit
(`python3 scripts/check-roadmap.py` under the root guard) passed in 2.55s.
An initial invocation used a nonexistent audit filename; it made no changes.

Connection/pool/task owners, typed pending-sender values and retained server
handlers remain open. Establish closed-connection/explicit-drain measurements
before attributing live pooled storage to leaks. Private research is
`/private/tmp/fwp-next-connection-ownership.md`. Audit unused callback fields before
adding owners. Older fatal allocation paths using `exit` on task stacks and
other unchecked allocation paths also remain concrete follow-up work. The
service environment-cache construction fix above now has written failure tests.
Remote calls remain excluded from checked ARC; all seven roadmap areas stay open.

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

## Candidate written; native validation pending

The candidate gives client connection storage separate pool, I/O and caller
owners. Socket closure still follows the reader/writer transport count. Response
sources and detached senders retain the connection until their own release.
Client I/O tasks have one scheduler owner and dispose storage after stack and
scheduler-link removal, without task retain/release operations. Server/HTTP
connections and pending sender language values remain unproved.

Existing synthetic tests now release owners returned by connection creation and
call opening. They drain the scheduler instead of awaiting freed I/O handles.
Task controls cover normal completion, cancellation before entry and after
suspension, with 64 repetitions, exact charged-storage recovery without GC,
stress/reuse checks and deliberate omitted/incorrect counted release. Existing
shared task and ARC tests remain enabled. The focused connection suite also runs
POSIX startup/failure controls. These tests are written, not yet passed.

Root-guard `cargo fmt --all` passed in 1.06s; guarded
`python3 scripts/check-roadmap.py` passed in 2.60s. No native builds ran locally.
Next: publish this preparation branch and run Linux `connection-repeat`; repair
failures before the six-platform comparison. Do not open another delivery PR
while #157 remains active. Acquisition-overflow cases and retained callbacks still
need review before acceptance.
