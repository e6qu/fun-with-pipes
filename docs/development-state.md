# Session handoff

Active delivery: [PR #163](https://github.com/e6qu/fun-with-pipes/pull/163), branch
`http-server-delivery` in the root checkout. PR #162 is accepted at `1b542f32`:
all nine production jobs (`39055466891`) and documentation (`39055442588`) passed
at `99d70deb`. Its squash tree/parent/message were verified; duplicate postmerge
production `39062147625` is cancelled. [History](roadmap-history.md) keeps its record.
The old `/private/tmp/fwp-http-server-owners` worktree is inactive preparation.

## Next action

Next: repair and audit every failed production target before the combined push.
Production `39066387403` at `b5391748` failed its ARM macOS second shard in two
targets: `grpc_server_connections` matched both gRPC and HTTP writer startup;
`udp_ownership` counted readiness scratch as a returned-value allocation.
The gRPC hook is now scoped to its reader. Forced UDP readiness retries reproduce
the old failure locally; targeted injection now covers the header and all three
returned objects without shifting with scheduler allocations. The repair preserves
broken cleanup controls and saves failure artifacts before asserting. Focused UDP validation passes all 16 O1/O2/memory-mode/control cases and the
restored-global-ordinal negative control (28.33 s). The gRPC test passes (35.34 s)
with `FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3`; its first local attempt lacked
that documented include path and failed to compile. The UDP fixture also passes with
the integrated compiler (43.48 s including rebuild). Windows ARM production also reports the same gRPC
match failure; its other TLS/ownership targets all pass. The other production jobs are still being audited; do not
push only the first failure. Regular ARM macOS, benchmarks and documentation pass.
[The separate Intel HTTP check](https://github.com/e6qu/fun-with-pipes/actions/runs/39066088716)
already passed at `397931ce`.

A repaired final head must pass all nine production jobs and documentation before
squash merge. Use one subject, at most 80 characters, and an empty body; verify
the merge tree, parent and message, then cancel duplicate postmerge production.
Do not increase timeouts or reduce coverage. The local documentation corrections
also belong in this repair batch; `b5391748` is not mergeable with failed gates.

The Intel rerun passed both 25-minute jobs. Its full audit confirmed all 15
ownership/boundary targets, 40 native and 10 interpreted comparisons, and the
repeated client-memory measurement. Logs and metadata are in
`/private/tmp/fwp-server-split-audit.json` and `/private/tmp/fwp-server-split-*.log`.
The earlier combined job at `cd4f0b06` timed out after 15 passing targets and
30/40 comparisons. The split preserved every case and changed only scheduling
and progress logging; compiler/runtime sources match the six-host memory report.
All five other hosts passed all 17 targets. The [memory report](measurements/http-server-owners-2026-10-17.json)
preserves the earlier incomplete run explicitly. Draft production runs were
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

## Compiler optimization bundled into this delivery

Preparation `profile-closed-functions` at `85988056` is now integrated locally
into the root checkout. `src/cgen.rs` exactly matches that tested source
(SHA-256 `612913826d1a7494c4929fa8548374674a99b6a8f7456fe89d2a46c4386e67ad`).
The preparation worktree `/private/tmp/fwp-closed-functions` is no longer the
active implementation. Keep one delivery PR: production already needs a repair
round, so including the proved allocation change avoids a separate full cycle.

The [baseline profile](https://github.com/e6qu/fun-with-pipes/actions/runs/39066197415)
at `a141efd4` and [candidate profile](https://github.com/e6qu/fun-with-pipes/actions/runs/39067651911)
at `01ae40da` pass on both Linux architectures: about 177 fewer allocations,
3,808 fewer payload bytes and 417 fewer count increments per additional HTTP
request, leaving about 722 allocations and 1,901 retains. The compiler shares
static records containing only fixed, capture-free function references; runtime
data, effects and zero-argument evaluation keep their existing paths. It uses
ordinary closure layout and existing constant initialization, including WASI.

All eight [focused jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39068683031)
pass: six native hosts, both Linux GCC checks and WASI on both Linux architectures.
The initial run's three lint failures were one needless borrow, fixed at `85988056`;
all completed targets were audited before that push. The remaining obsolete
queued jobs were cancelled only after dispatching the complete replacement.
The new golden fixture additionally needed its function-result parentheses
normalized by `fwp fmt`; that correction is in the root integration.

[Paired timing](https://github.com/e6qu/fun-with-pipes/actions/runs/39068684995)
passes on ARM64, with AMD64 still running; do not claim timing savings before
analysing the samples. [Six-host memory](https://github.com/e6qu/fun-with-pipes/actions/runs/39068696985)
passes on both Windows and both macOS hosts; Linux jobs are running. Windows
managed storage stays flat and persistent-server RSS growth is 24 KiB on AMD64,
4 KiB on ARM64. Guarded inspection of the actual Windows data sections verifies
331 aligned function records, 7,592 bytes, in both modes; ARC omits tracing and
tracing controls retain it. Linux ELF checks additionally verify all 618 startup
capture stores against function symbol addresses. A deliberately wrong capture
is rejected on both architectures. The inspector's initial stack-address parsing
assumption was corrected, then normal and broken controls passed (about 4 s per
binary; 8.97 s for both broken controls).

Raw artifacts/reports are under `/private/tmp/fwp-function-profile` and
`/private/tmp/fwp-static-server-memory`. Root scripts summarize profiles, paired
timing and real binary storage without executing downloaded binaries. The
benchmark guide defines inputs, costs and limits. Publish the combined repair
for focused six-host gRPC/UDP/readiness checks, finish auditing all old production
results, then run all nine production jobs plus docs on the final PR head.

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
