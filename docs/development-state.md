# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

[PR #155](https://github.com/e6qu/fun-with-pipes/pull/155) fixes shared stream reads
and bounds cleanup stack use for ordinary wrapped chains. Its exact head is
`e71a2295b1d0d0a5d51fb90b6cbe442364aee431`. Production `38990872293` has eight
completed passing jobs; Linux AMD64 has passed its tests and is finishing
measurement/packaging. Documentation `38990872208` passes. Wait for all nine jobs.
The root watcher in exec session `9247` checks exact-head acceptance and supplies
one-line subject `Fix shared stream reads and bound cleanup stack use` with an
empty body. It verifies the merge tree, parent and message and saves
`/private/tmp/fwp155-merge-record.json`. Preserve Windows dependency jobs.

## Next delivery: release cached values and move closure captures

Worktree `/private/tmp/fwp-closure-capture-moves`, branch
`move-unique-closure-captures`, contains the combined preparation. The final
measured source is `afd7d460fcbc5a897ee4b4b960a3735830fe52a1`, preserved as
`evidence/remote-capture-moves-20261017`. All six native jobs pass in `38996238360`.
The retained report is
[remote-client-capture-moves-2026-10-17.json](measurements/remote-client-capture-moves-2026-10-17.json).
Report/documentation changes after that revision do not relabel its source.

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

Next: finish #155's exact-head gate and verify its authorized squash merge. Then build
one substantial delivery from accepted main containing the cache ownership,
capture transfers, portable tests, reports and doc cleanup. Keep report source
IDs unchanged. Update PLAN/history/handoff and require all nine final production
jobs plus documentation before merging. Do not open a second active delivery.

While that next delivery validates, measure repeated calls in one client process
before changing connection lifetimes. Use fixed 64-value responses and 1/16/256
calls, full/partial reads and retained earlier iterators. Add created/destroyed
connection and stream counts and raw message bytes, separate reusable pool
storage from per-call growth, and compare raw interpreter/native output. Then
assign owners to connections, streams, retained codecs and sender callbacks,
with borrowed scheduler links and explicit cycle handling. Whole remote calls
remain excluded from checked ARC; this cache change does not remove tracing.

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
