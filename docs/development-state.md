# Session handoff

Updated 2026-10-17 UTC. All seven areas in [PLAN.md](../PLAN.md) remain open.
The root checkout owns one combined delivery, PR #160. Preparation branches and
historical measurements are evidence sources, not separate next actions.

## Accepted baseline and current PR

PR #159 is accepted as `7c4634410f23fa106b8c8dac5ad750b05fab5251`, after all nine
production jobs **39016595534** and docs **39016595480** passed at `91398527`.
Parent/tree/message were verified. Duplicate postmerge **39022161689** is cancelled.
Complete message: `Free streamed inputs after remote calls finish`.
[History](roadmap-history.md) records acceptance.

[PR #160](https://github.com/e6qu/fun-with-pipes/pull/160), root branch
`free-server-call-values`, is **not accepted**. Its previous head `1e1773b6` failed
production **39025708821** on Linux ARM64: `grpc_server_runs_in_bounded_memory`
grew from 17,104 to 49,420 KiB over 32,000 calls, exceeding the unchanged 8 MiB
limit. Six other production jobs and docs **39025708823** passed before discovery;
remaining jobs were cancelled; cancellation is confirmed. The exact-head merge
watcher **82509 exited without merging**. Do not reuse its old merge command.
Earlier production **39023664259** exposed a stale state fixture; its repaired
method signature preserves all cleanup controls and remains in the root.

To fix the remaining storage growth without another separate delivery cycle,
the root now includes the combined request/connection ownership and borrowed
callback preparation, plus the final #160 reports and state/allocation repairs.
This delivery publishes that integration in the existing PR. No second PR is open.
The previous plan to merge #160 before transferring that preparation is obsolete.

Next: finish the native ARM64 long-running regression probe below and the combined
PR's production checks, fixing any failure. Read the latest PR head and require
all nine production jobs and docs for that exact commit. Squash-merge with an
explicitly supplied one-line subject (at most
80 characters) and empty body, then verify parent/tree/message and cancel duplicate
postmerge production. Do not weaken the memory limit or treat short measurements
as a substitute for the production test.

## Combined implementation and checks

The root includes these changes:

- Server task/job storage, stack argument slots, direct method calls, concrete
  argument/result/error cleanup and owned native output channels.
- Parser lists protect newly parsed requests against reset before task startup,
  then move their owners into serving jobs. Reader/writer tasks, jobs and retained
  iterators/channels independently own connection storage. Closing a socket is
  separate from freeing its last storage owner. Borrowed task pointers clear
  before release; explicit no-reuse mode retains its existing policy.
- Known fold/fold-right callbacks borrow captures (values kept for later calls)
  and input elements while owning the running result. Escaping values acquire
  owners. The verifier distinguishes external borrows from local references;
  entry/unwind cleanup excludes borrows. Recursive callbacks and resource-close
  scopes retain their existing compilation. No new language syntax or wrapper.
- Socket shutdown explicitly wakes polling-platform waiters. Wait records live
  on task stacks and unlink before cancellation unwinds. Timeout, cancellation,
  task deadline and multiple-reader tests have bounded completion. Deliberately
  omitted wake/unlink operations must fail. No added heap object/task fields.

The combined runtime/compiler is **`8ed65cc7b29fe356200a00a3de9771666d0bb184`**,
tag **`evidence/server-borrows-controls-20261017`**. Six-host focused run
**39029223789 passes on all six native hosts**. All artifacts are downloaded
under `/private/tmp/fwp-server-memory-evidence/39029223789`. Actual AMD64/ARM64
binary reviews are retained there; downloaded binaries were never executed.

The additional long-running probe is **39030258307**, native Linux ARM64,
source **`58822d542b096921ccb6158c617d611f6703edd0`**, tag
**`evidence/server-memory-repair-20261017`**. It runs the original failing check
before the focused ownership suite. Runtime/compiler code is unchanged from
`8ed65cc7`; test diagnostics now retain five RSS samples and verify every client's
output. The same check runs early in future Linux server-repeat probes. The
worktree `/private/tmp/fwp-borrow-fold-captures` is now on
`server-memory-repair-probe`. Root has the same test, with its workflow command
moved into a separate visible step so future runs expose its result promptly.

The strict collector passed in 9.45s with `--comparison server-borrows` against
the preceding server-values report. The final report is
`docs/measurements/server-borrows-2026-10-17.json`, with 18 raw tables and actual
instruction reviews. [Benchmarks](benchmarks.md#freeing-server-requests-and-borrowing-fold-captures)
explains costs and limits. Next: finish the long-running regression probe and
the combined PR's production acceptance. Do not run a separate
intermediate ownership-only six-host matrix.

## Measurement scope and current findings

These compare identical fwp server programs across revisions, not fwp with C/Rust.
Each fresh server receives 1, 16 or 256 calls over one connection, three repetitions;
streams contain 64 elements. Counters start after listener/routing/root setup and
end after disconnect/task retirement while the listener stays open. Collection is
off and physical freeing on. Raw buffers, task-stack pools, OS/TLS/allocator
metadata, whole-process memory and elapsed time are excluded. The failing
production test measures whole-process resident memory separately.

The earlier #160 preparation `855fe3d1` passed all six focused hosts in
**39022416616**. Its committed [report](measurements/server-values-2026-10-17.json)
leaves 62,304 managed bytes on Linux and 61,760 on macOS/Windows at 256 calls,
still growing 240 bytes per call. Retains per call are 1 / 64 / 128 / 64 for
greeting / returned stream / received stream / output-channel text.

Intermediate Linux ownership **39025894808** (`72a3cee0`) and borrowing
**39027507441** (`f7aeb774`) pass. All requests/connections finalize, with 544
constant final managed bytes and unchanged allocation requests. Ownership costs
3 / 66 / 132 / 68 retains per call plus one per connection; borrowing reduces
the channel case to 4. Windows shutdown probe **39027501833** (`96fa4e2c`) passes
with zero final managed bytes, before combined borrowing. The final six-host report
at `8ed65cc7` confirms 544 constant bytes on both Linux architectures and zero on
both macOS/Windows architectures, with the expected count changes and unchanged
allocation requests in every row.

Actual final Linux instructions keep the channel in `rbx` (AMD64) or `x19`
(ARM64), with no per-send channel retain/drop. The caller frame grows from
200 to 280 bytes on AMD64 (excluding the incoming return address), and from
240 to 336 on ARM64. It no longer nests the old 184/208-byte callback frame.
Other callees still need frames. Compared with `855fe3d1`, text grows by 2,536
bytes on AMD64 and 2,352 on ARM64; data/bss are unchanged. Connection/parser
ownership adds 16/32 bytes to reader frames. These are not timing or total-stack
claims. Reviews are in each Linux artifact's `binary-observations.json`.

## Resolved probe failures and local validation

Preparation caught and fixed ambiguous test hooks, uncounted no-reuse connection
handling, a missing fixture schema, Windows API header order and a Windows local
shutdown hang. Borrowing tests fixed an invalid IR equality assertion and an
incorrect prepend/append input. An added deadline check was redundant: the scheduler
already cancels expired tasks. It was removed, with deadline coverage retained.
The unlink negative control originally affected earlier connection teardown;
`8ed65cc7` scopes it to its intended waiter tests and still requires exit 43.
Superseded focused runs **39026702591**, **39027091673**, **39028415848** and
**39028994457** are confirmed cancelled. Preserve immutable tags.

Consolidated root formatting passed in 1.34s and the documentation audit in 2.75s.
Probe formatting passed in 1.10s. ARM64/AMD64 static inspection
passed in 0.15s each; review consistency checks passed in 0.14s each. Use
`python3 scripts/local-guard.py COMMAND...` for focused local checks. Full builds,
suites and large regeneration run on GitHub. Preserve 64 GiB free disk, target
data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline.
Do not increase limits.

The CI timing investigation found two workers already active; merely reordering
fixed-duration targets would save about 24 seconds on Linux or four minutes on
Intel macOS, not a measured speedup. No scheduling/coverage change was made.
Private timing evidence: `/private/tmp/fwp159-ci-target-times.json`.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server/external owners, escaped cycles, HTTP and host re-entry; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

Remote checked ARC and complete GC removal remain open. JIT is excluded.
Choose the next optimization from measurements, rather than assuming every
remaining reference count is avoidable.
