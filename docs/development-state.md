# Session handoff

Active delivery: [PR #163](https://github.com/e6qu/fun-with-pipes/pull/163), branch
`http-server-delivery` in the root checkout. PR #162 is accepted at `1b542f32`:
all nine production jobs (`39055466891`) and documentation (`39055442588`) passed
at `99d70deb`. Its squash tree/parent/message were verified; duplicate postmerge
production `39062147625` is cancelled. [History](roadmap-history.md) keeps its record.
The old `/private/tmp/fwp-http-server-owners` worktree is inactive preparation.

## Next action

Next: finish [Intel HTTP validation](https://github.com/e6qu/fun-with-pipes/actions/runs/39066088716)
at `397931ce`, then require all nine production jobs and documentation for the
final PR head before squash merge. Use one subject, at most 80 characters, and an
empty body; verify the merge tree, parent and message. Cancel duplicate postmerge
production. Failing checks are work to fix: audit every failed job and completed
target before a repair push. Do not increase timeouts or reduce workload coverage.

The Intel rerun splits independent ownership and HTTP comparison work into two
25-minute jobs. The earlier combined job at `cd4f0b06` passed all 15 ownership/
boundary targets and 30/40 native HTTP comparisons before timeout; client-memory
measurement had not started. All five other hosts passed all 17 targets. The
repair only changes workflow scheduling and progress logging; language/compiler/
runtime sources are unchanged. The [memory report](measurements/http-server-owners-2026-10-17.json)
preserves that incomplete functional run explicitly. Draft production runs are
skipped and do not count as acceptance.

## What this delivery changes

HTTP connections, active requests, escaped stream handles and writer tasks have
explicit owners. One connection-owned handler outlives child jobs, which borrow
it. A 24-byte handle includes task payload, replacing separate 32-byte handle and
job allocations, excluding allocator overhead. The nonescaping 64 KiB receive
buffer stays on the stack; actual Linux serve frames are 67,240 bytes on AMD64
and 67,264 on ARM64, excluding callees. Typed destruction and fresh callback
State/AD scopes preserve cleanup and isolation. ARC rejects channels containing
stream handles, directly or nested, because they could form a handler cycle;
ordinary immutable aliases remain supported.

macOS/Windows socket waits now use poll/WSAPoll readiness and real deadlines,
including readiness checks during task preemption. Stack-local wait records
unlink before cancellation. A reusable event array frees when no waiters remain;
it is allocated before registering a stack record so allocation failure cannot
leave a dangling link. Local close remains explicit. Linux epoll is unchanged.

Keeping one copy of the existing ARC ownership check reduces measured Linux HTTP
instruction sections by about 13%, without removing the check. The
[code-cost report](measurements/entry-check-code-costs-2026-10-17.json) records
`e5bc8531`, tag `evidence/http-server-costs-20261017`, hardware, flags, repeated
samples and binary evidence. No speedup or C/Rust parity is established.

## Verified evidence and remaining limits

At `cd4f0b06`, [server memory](https://github.com/e6qu/fun-with-pipes/actions/runs/39063863085)
passes on all six native hosts: 36 managed rows, 20 RSS rows and 48 separate
ownership-check rows per host. Final managed storage is constant across counts;
all persistent servers complete 20,480 calls per case within the unchanged
8 MiB RSS growth bound. The largest observed increase is 2 MiB. All 60 saved
binaries were inspected as data with `scripts/inspect-http-server-binaries.py`;
36 ARC binaries exclude tracing routines and 24 tracing controls retain them.
The [benchmark explanation](benchmarks.md#http-server-ownership-and-memory)
defines scope, inputs, costs and limitations. Approximate per-call costs remain
899 managed allocations and 2,318 retains, including background activity.

All twelve jobs and completed targets were audited before the scheduling repair:
`/private/tmp/fwp-server-repeat-partial-audit.json`; logs/artifacts are under
`/private/tmp/fwp-server-evidence`. Earlier failures were fixed at their causes:
Windows declaration order, quoted artifact names, periodic socket sleeps and
allocation unwinding past a registered wait record. Missing-unlink controls now
detect stale links before task-stack disposal, avoiding accidental use-after-free.

Local checks use `python3 scripts/local-guard.py COMMAND...`, serially:
all six native socket tests passed (41.33 s); gRPC startup controls passed
(15.46 s); both HTTP server controls, connection cancellation and library cleanup
passed. Probes retain O1/O2, GC stress/verification, reuse and deliberate broken
controls. Formatting, web/bench harness compilation, workflow lint, primitive
inventory and seven native-runner checks passed. The scheduling repair passed
formatting (1.42 s), workflow lint (2.06 s) and the twelve-job audit (0.20 s).
Static binary checks took 28–34 s per host. Two checks attempted while the last
inspection still ran were refused by the serial guard; both passed after it ended.
Full builds, suites and benchmarks stay on GitHub; local limits remain fixed.

## Follow-on work

Preparation `/private/tmp/fwp-closed-functions`, branch `profile-closed-functions`,
is published at `a141efd4`, based on `cd4f0b06`, with no second PR. Its
[Linux profile](https://github.com/e6qu/fun-with-pipes/actions/runs/39066197415)
counts executed partial applications capturing only fixed functions, using the
same server and 1/16/256 requests. A partial application supplies some arguments
and returns a function waiting for the rest. No optimization is selected yet;
inspect measured sites and costs before choosing static storage or routing work.
Preparation has a separate handoff; finish PR #163 acceptance in this checkout.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server acceptance, remaining host owners and tracing removal |
| 2 | In progress | Remove functional intermediates and unnecessary counts |
| 3 | In progress | C/Rust gaps, register/cache use and code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Dependable repeated performance comparisons |
| 7 | In progress | Larger representative applications |

All seven [plan](../PLAN.md) areas remain open. HTTP server support alone does not
complete any of them. Browser, asynchronous WASI, REST/MCP entries and retained
host callbacks remain ownership work.
