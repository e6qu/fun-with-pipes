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

While #156 validates, prepare `measure-repeated-remote-calls` in
`/private/tmp/fwp-repeated-remote-calls` from `d19ab045`. Measure repeated calls in one client process
before changing connection lifetimes. Use fixed 64-value responses and 1/16/256
calls, full/partial reads and retained earlier iterators. Add created/destroyed
connection and stream counts and raw message bytes, separate reusable pool
storage from per-call growth, and compare raw interpreter/native output. Then
assign owners to connections, streams, retained codecs and sender callbacks,
with borrowed scheduler links and explicit cycle handling. Whole remote calls
remain excluded from checked ARC; this cache change does not remove tracing.

## Repeated-call preparation

Branch `measure-repeated-remote-calls`, worktree `/private/tmp/fwp-repeated-remote-calls`,
starts at #156's tested candidate `d19ab045`. No second delivery PR is open.
The new ignored measurement requests fixed 64-value responses in 1/16/256 batches.
Full and partial batches make one call; retained batches sum an initial stream,
make and sum another call while keeping the first iterator, then reread its first
value. Their expected per-batch outputs are 2,080, 528 and 4,161 respectively;
retained batches make two calls. Counts distinguish actual requests from batches.

Instrumentation records managed requests/retains/charge, connection and stream
creation/finalization, and allocated/freed message bytes (headers and payloads).
It samples immediately before each request stream allocation and after entry/task
cleanup, before whole-runtime shutdown. Other raw buffers, TLS/OS/allocator pages,
server/process memory and timing are excluded. A deliberately omitted message
release must leave measured message bytes even when output is still correct.
Do not assert bounded memory or ARC support from this baseline.

Linux AMD64 probe `38997237145` checks `b2cc0915` with `suite=stream-repeat`.
Next preparation action: inspect its result, repair any failures, then validate
all six native hosts before choosing the next runtime ownership change. The
collector requires all six jobs and copies raw checkpoint tables beside the
report; guarded Python syntax passed in 0.20s. Runtime review found unchecked
raw message allocation in `g_split`; preserve the baseline, then add an injected
failure test and the established exit-102 out-of-memory handling. Full builds and
execution remain on runners. Exact measurement sources type-check locally with
the prebuilt compiler under the guard (0.51s). An earlier handwritten check used
unsupported semicolon match syntax; checking the exact generated source fixed
that test-only error. Guarded Rust formatting passed in 1.27s.

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
