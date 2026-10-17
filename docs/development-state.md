# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

PR #155 is accepted as `45410bea4b59e2e6478632cf253f9c29cbd9863d`, with all nine
production jobs `38990872293` and docs `38990872208` passing at `e71a2295`.
The verified merge has the tested tree, parent `11ae0f63`, and exactly the subject
`Fix shared stream reads and bound cleanup stack use`, with no body or trailers.
The watcher completed and saved `/private/tmp/fwp155-merge-record.json`.
Duplicate production `38996775271` was canceled; Windows dependency jobs remain.

[PR #156](https://github.com/e6qu/fun-with-pipes/pull/156), root branch
`release-stream-caches`, starts at that accepted merge and adds cache ownership,
unique closure capture transfers, Windows portability fixes, reports and clearer
docs. Exact head: `d19ab045d6ce136455d597b49773db7ef9c5721d`. Production
`38996879616` and documentation `38996879603` are running. Require all nine jobs
plus docs on this exact head. Do not treat focused evidence as production acceptance.
The watcher in exec session `37246` runs `/private/tmp/fwp-watch-156.py`, which
checks the exact base/head and gates, squash-merges with the one-line subject
`Release unused stream values and reduce memory bookkeeping` and empty body,
then verifies the tree, parent and message. Its record is
`/private/tmp/fwp156-merge-record.json`. If it ends on failure, fix and restart
with the new exact head. This local handoff update intentionally remains
uncommitted to avoid restarting the full matrix for status-only changes.

The combined preparation is published at `a49ffe3e` on
`move-unique-closure-captures`, worktree `/private/tmp/fwp-closure-capture-moves`.
Its final measured source is `afd7d460fcbc5a897ee4b4b960a3735830fe52a1`, preserved
as `evidence/remote-capture-moves-20261017`. All six native jobs pass in
`38996238360`. [The report](measurements/remote-client-capture-moves-2026-10-17.json)
retains that measured source; report/doc changes do not relabel it.

The comparison uses the same real loopback clients at 64/1,024/16,384 integers,
three processes per case, including one-pass, retained-history and first-32-only
reads. Raw unoptimized interpretation and ordinary compiled output agree.
Managed counters run with collection disabled, from constant initialization to
entry cleanup before whole-runtime shutdown. Raw buffers, server/whole-process
memory and timing are excluded. The earlier baseline is `456f2dbd`, run
`38991578784`; the cache-only component is `886dad3b`, run `38994414068`.
Both pass all six native hosts and have retained evidence tags/reports.

Typed cache ownership removes the baseline's 64-byte-per-consumed-integer
remaining growth. Final managed charge is constant in each tested mode and size:
Linux AMD64 6,480 bytes, Linux ARM64 19,536, either Mac 2,480, Windows AMD64 3,632
and Windows ARM64 3,248. Keeping an earlier iterator intentionally keeps its
history until released. These single-call clients do not prove bounded repeated
calls or unread network queues. Five allocations per integer remain.

Moving captured values from consumed unique closures reduces one-pass retains
from 81,921 in the cache-only component to 49,154 at 16,384 integers on every
host. This remains above the original tracing-dependent baseline's 16,385.
Unique captures move through partial/full calls; shared captures still acquire
typed references. The destination is ready before transfer, with no intervening
allocation, suspension or recoverable trap. Error/trap cleanup remains owned.
One-pass peak drops another 64 bytes per host; Linux AMD64 is now 6,768 bytes.
No timing, zero-cost or C/Rust parity claim.

Controls cover 16,384-position chains and aliases to positions/wrappers, physical
reclamation without collection, collector/reuse stress, decoder errors/traps,
12 capture-sharing/application/failure combinations at O1/O2, scalar bits that
resemble pointers, cancellation and reference-counter overflow. Deliberately
omitted cleanup, recursive destruction, restored duplicate captures and stolen
shared captures must fail. Actual Linux AMD64/ARM64 binaries show capture-count
one branches bypassing duplicate callbacks and looped cache cleanup. Cleanup
frames are 24 bytes on AMD64 excluding the incoming return address and 64 bytes
on ARM64 including saved registers; helper frames are separate. Dynamic dispatch,
argument copying and stack storage remain.

## Repaired failures and local checks

Earlier probe `38994754283` exposed two test assumptions: reversed expected
concatenation and rounded freed-byte statistics. The failure-loop test now
requires exact zero remaining managed bytes after 10,000 failures and detects a
missing closure release. Six-host run `38995678897` then passed Linux/macOS but
found Windows CRLF diagnostics and Unix-only stack failure injection. Repairs
normalize only fixture diagnostics and inject native `CreateFiberEx` failures on
Windows. All seven closure/unwind test targets now join Windows production.
Those repairs pass `38996238360`; no focused failure remains unresolved.

Full builds and native execution stay on GitHub. Every local check uses
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py` with unchanged
limits. Formatting passed in 1.05s, docs in 2.53s, collector syntax in 0.19s;
final report collection passed in 21.59s. Linux AMD64/ARM64 downloads passed in
2.90s/2.95s and static inspection in 0.15s/0.14s. No downloaded executable ran.

## Next action

Next: monitor #156, fix every discovered failure and wait for complete final-head
acceptance.
Squash-merge with the explicit one-line subject and empty body, then verify the
merge tree, parent and message. Preserve Windows dependency jobs; cancel only
superseded or duplicate production runs. Keep one active delivery PR.

While #156 validates, prepare `own-remote-transport-storage` in
`/private/tmp/fwp-repeated-remote-calls`. Keep one delivery PR open.

## Repeated-call baseline and next implementation

The untouched baseline is `ac95632b8c77cc8c52f35a451f3c7451d0e29b06` on
`measure-repeated-remote-calls`. All six native jobs passed in `38997585835`.
It records 1/16/256 batches of fixed 64-value responses: full sum, first-32 sum,
and retaining an initial iterator across a second call before rereading it
(two calls per retained batch). Raw interpreter and ordinary native output agree.
Counters separate managed storage, connection/stream construction/finalization
and raw queued message bytes. Checkpoints precede each new request stream.
A deliberately missing raw-message release is detected. Collection is disabled;
whole-runtime shutdown, other raw buffers, TLS/OS memory and timing are excluded.

All six baseline hosts (and the earlier Linux probe `38997237145`) find 240 extra managed bytes
per call, one reused connection and no finalized streams. Full reads release all
queued messages; partial reads leave 609 requested message bytes per call in
these samples. Queue occupancy can vary with scheduling. The six-host report is preserved at
`docs/measurements/repeated-remote-baseline-2026-10-17.json`, with raw checkpoints
beside it and source tag `evidence/repeated-remote-baseline-20261017`.
Guarded collection passed in 26.87s.
These measurements establish remaining work, not bounded memory or checked ARC.

The preparation adds explicit owners for client request streams: the active
connection list, the response source and a detached sender each keep their own
reference. Losing the response reader discards unread messages without cancelling
the remote operation; the active-list owner lasts until completion/reset/death.
Server streams, connections and retained codec/sender graphs still need tracing.
Do not admit remote calls to checked ARC yet.

The first Linux probe `38998638008` at `ad089a73` passed the existing closure,
receive, request, peer and context controls and the new message-allocation
failure test. The stream-owner fixture stopped before native compilation because
its finalizer-removal injection matched an unrelated cleanup site too. The
marker now includes the request destructor call, so it selects one site.
Probe `38999032272` at `4a1823ac` passes all new stream owner/control modes,
including stress, sender cancellation and overflow. Two added controls fail:
the receive fixture used server cancellation rules for an owned client request,
and TLS-key OOM called `exit` on a task stack, where the library unload destructor
aborts. The fixture now uses client status/reset rules; the two new fatal OOM
branches use `_Exit(102)` and both message encodings are tested on a task stack.
The second probe also exposed duplicated layout output in fixture review; it is
now emitted once. Repeated client measurements still need a passing probe.
Controls cover completion, reset, connection loss, sender completion/cancellation,
failed sender preparation, reference overflow and deliberately omitted releases.
An unchecked queued-message allocation now reports the established exit-102
out-of-memory error; plain and gzip fault-injection tests accompany it.
TLS pool-key allocation also now checks for failure, with a targeted exit-102
control in the existing pool-identity fixture. That fixture now releases its
client stream through the new owners. Receive tests additionally count final
request release after retry, malformed responses, decoder traps and cancellation.
A native layout table records structure size, alignment and field offsets.
The unused detached-sender encoder field/branch is removed: its only production
caller always supplies a static request description. Existing request-encoding
and exceptional-buffer tests join the probe. Other older fatal allocation paths
still use `exit`; audit their task-stack behavior in the connection-lifetime work.
Next: publish these repairs and controls, run the focused Linux native checks, fix failures,
then measure all six native hosts and inspect actual generated binaries.

Local checks use the unchanged root guard. Baseline source type-checking passed
in 0.51s, formatting in 1.36s, docs in 2.54s, collector syntax in 0.20s.
The current ownership preparation formatting check passed in 1.12s.
No native build or downloaded executable ran locally.

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
