# Session handoff

Current batch: HTTP server ownership and smaller ARC ownership checks, on
`http-server-delivery` in the root checkout. This is the active workspace.
PR #162 is accepted at `1b542f32f352ecd34553f17fcce2de25b6f0bbb2`: all nine
production jobs (`39055466891`) and documentation (`39055442588`) passed at
`99d70deb9c9daa8fc041964f9cbee51e48047c38`. The squash parent, identical tree
`0ff25a71b1b10a177d7f3a5dccc331861efdfa3c` and one-line message were verified.
Duplicate postmerge production `39062147625` is cancelled.

Server preparation `09f9b6ef` and `e5bc8531` is integrated here as `5ad59d96`
and `75b8c91a`. The measured code-size change, scheduler repair and reports are
published in `cd4f0b06`. Current local edits collect the final evidence/handoff.
The old `/private/tmp/fwp-http-server-owners` worktree is a preparation copy;
continue in this root checkout. [PR #163](https://github.com/e6qu/fun-with-pipes/pull/163)
is a draft at `cd4f0b06e23d768100f8e5f3cfcf4d9cc0b383a6`. All nine final-head
production jobs and documentation are required before squash merging.

## Next action

Next: rerun the complete Intel macOS HTTP suite with ownership checks and
HTTP comparisons in separate jobs, preserving the 25-minute limit and every case.
At `cd4f0b06`, [server memory](https://github.com/e6qu/fun-with-pipes/actions/runs/39063863085)
passed on all six hosts. [HTTP checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39063860925)
passed all 17 targets on five hosts. Intel macOS passed its 15 ownership/boundary
targets and 30 of 40 native comparisons, then hit the job limit before finishing
comparisons and starting client-memory measurement. No completed target failed.
The full twelve-job audit is `/private/tmp/fwp-server-repeat-partial-audit.json`;
logs and artifacts are under `/private/tmp/fwp-server-evidence`. Splitting the two
independent groups addresses the overloaded job without dropping coverage or
raising limits. The comparison now logs each build and client/server case.

Collect all six memory reports and inspect actual binaries, then publish the
final evidence/handoff and run all nine production gates plus documentation.
Documentation `39063862201` passed; production `39063862325` was skipped for the
draft PR and is not acceptance. Keep `cd4f0b06` memory evidence distinct from the
workflow-only repair's source revision. The earlier measured check-placement
experiment at `e5bc8531` remains recorded in the tracked code-cost report.

An isolated follow-on measurement is being prepared at
`/private/tmp/fwp-closed-functions`, branch `profile-closed-functions`, based on
`cd4f0b06`. It counts executed allocations for partial applications that capture
only known functions. No optimization or second PR is selected. This root checkout
remains the active delivery; finish its acceptance before another delivery PR.

The underlying scheduler imposed 10 ms sleeps before retrying sockets on macOS
and Windows, and did not query their readiness during preemption. The repair
waits on all parked descriptors using poll/WSAPoll, bounded by real timers only;
preemption uses a zero-time query. Wait records live on parked task stacks and
unlink before cancellation unwinds. One leaf event array grows with concurrent
waiters and frees when the last waiter leaves. Local close notifications remain
explicit. Linux epoll and WebAssembly fibers keep their existing platform paths.
The regression observes actual wait arguments (not noisy elapsed thresholds),
checks batch growth, preemption, close, cancellation, deadlines and poll errors,
and uses deliberately delayed/starved controls. Native platform CI remains needed.

## Scope and acceptance

HTTP connections, reader/writer tasks, active requests and H2Stream handles have
explicit owners. A handle also carries its task payload, replacing two allocations
with one. Jobs borrow the connection-owned handler; its captures survive failure
before children finish. Escaped handles preserve request/connection storage after
socket closure. The nonescaping 64 KiB receive buffer now lives on the reader
stack. Actual Linux binaries use 67,240-byte AMD64 and 67,264-byte ARM64 serve
frames including the 64 KiB buffer; these exclude callees. The requested handle
payload is 24 bytes, replacing separate 32-byte handle and job payloads. Allocator
metadata/rounding are excluded. The code-cost report records this binary evidence.

Compiler changes emit concrete handle destruction, preserve resource lifetimes
and check handlers under fresh State/AD task scopes. Shutdown signals have scalar
contracts. Checked ARC rejects channels containing HTTP stream handles, including
nested handles: a captured channel could otherwise keep its handler/connection
alive through a queued handle. Ordinary handle aliases remain permitted.

Functional checks build clients and servers in tracing/ARC at O1/O2, compare
cleartext/TLS with the interpreter and verify graceful shutdown. Probes cover
startup failures, cancellation, scope-owned tasks, escaped handles and TLS release,
with deliberate missing-owner controls and GC/reuse verification.

Runner-only server measurements use 1/16/256 calls, three fresh processes per case,
then five 4096-call batches per persistent server. The default 1000-request limit
also exercises connection replacement within each batch. Both modes have collection
off and freeing enabled. Managed counters and resident-memory samples have separate
scopes; final managed storage must stay constant and RSS growth after warm-up must
remain below 8 MiB. Source, raw rows and ordinary/instrumented binaries are retained.
All six hosts completed the unchanged memory workload; the tracked report is
being assembled. Final production acceptance remains pending.

The entry-check experiment passed on both Linux architectures. Static review of
20 ordinary binaries finds HTTP client instruction sections 12.6–12.7% smaller
and server sections 13.7–13.8% smaller with one noinline copy of the same check.
All three numerical workloads recorded zero check executions in separate
instrumented binaries; timing differences do not establish a speedup. Source
`e5bc8531` is preserved by `evidence/http-server-costs-20261017`. The tracked
[report](measurements/entry-check-code-costs-2026-10-17.json) retains hardware,
flags, raw samples, hashes and limitations. Local static inspection used the root
guard (AMD64 9.21 s, ARM64 9.62 s); no downloaded binary was executed.

Working-tree follow-up selects noinline on the existing native ARC helper's
forward declaration, leaving tracing unchanged. The experiment explicitly
reconstructs the ordinary-inlining control after that selection. A new O1/O2
behavioral probe accepts scalars/uncounted storage and requires a counted owner
to trap at an uncounted boundary; it passes locally (17.65 s including rebuild).
Formatting passes. All preparation HTTP results were audited before this combined
follow-up. General benchmark workflows explicitly select the
C/Rust comparison; the code-arrangement experiment is separately dispatched.

Acceptance requires all six native hosts, actual ARM64/AMD64 binary inspection,
stable memory and nine final production jobs plus documentation. All seven roadmap
areas remain open; this batch does not remove tracing from every program.

## Complete first-run audit

Preparation `09f9b6eff3ca1c159b651696a27d844082eaf1b6` ran
[39057316310](https://github.com/e6qu/fun-with-pipes/actions/runs/39057316310).
All 84 target executions finished (14 per host). Linux/macOS passed all tests but
artifact upload rejected quoted filenames. Windows also failed one server probe
because stdint preceded the required Windows API definition; the HTTP comparison
stopped at its first quoted filename write. Remaining Windows comparisons were
not exercised. Client memory checks passed everywhere.

The combined repair inserts fixture declarations after the generated value type,
without prepending headers, and uses plain display labels in filenames. Logs and
all target results are in `/private/tmp/fwp-http-server-first-audit.json` and
`/private/tmp/fwp-http-server-first-*.log`. These two causes account for every
observed failure. Follow-up validation must exercise the complete Windows matrix.

## Local checks

All checks run serially through
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`.
C/TLS probes set `FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3`. Full gates, benchmarks
and large evidence generation run on GitHub with unchanged local limits.

- Server/body/peer probes: all four passed (31.55 s). Expanded server controls
  passed with stack storage (37.62 s), then parent cancellation (18.78 s).
- Existing HTTP client controls: two passed (27.48 s).
- `cargo test --lib arc_scope::tests::asynchronous_callbacks_do_not_inherit_dynamic_scopes -- --exact`: passed (14.30 s).
- `cargo test --test arc_execution arc_rejects_unproved_runtime_boundaries_and_disabled_counting -- --exact --nocapture`: all cases passed, including direct/nested handle cycles (25.32 s).
- Representative server `build --gc arc --emit-c` passed after shutdown-route and
  cycle-policy changes (3.04 s). Web/bench harness compilation passed (1.22 s).
- Primitive inventory passed (1.09 s): 355 contracts, 19 templates, three scalar
  declarations and one runtime-review primitive, `device.gpu-run`.
- Seven native-runner checks passed (1.08 s); server target is assigned to regular
  macOS and native Windows. After the final repairs, server probes passed
  (18.64 s), formatting passed (1.20 s), workflow lint passed (1.44 s) and the
  documentation audit passed.
- `cargo test --no-fail-fast --test native_sockets --test http2_server_ownership --test grpc_connect_cleanup --test library_resources -- --nocapture`:
  connection cancellation (8.17 s), both server controls (16.19 s) and library
  cleanup (9.82 s) passed. Stopped the later socket constructor probe through the
  guard after it exposed allocation unwinding past a registered wait record.
  Moved event-array allocation before registration. Constructor injections now
  target acquired results/optional wrappers, excluding scheduler scratch.
- `cargo test --test native_sockets -- --nocapture`: all six passed after repair
  (41.33 s including rebuild). The scheduler regression covers both optimization
  levels, real sockets, batch growth, queued close/cancel omissions, interrupted
  and failed OS polls. Three deliberately broken controls detect the 10 ms delay,
  missing preemption readiness and allocation after registration. GC stress,
  verification and reuse verification remain enabled. The initial probe's wrong
  callback signature was corrected before these results.
- Full memory audit passed (0.15 s); every completed row and all six job logs
  were inspected before the repair push. Measurement progress is now logged per
  build, managed case and RSS batch.
- `cargo test --test grpc_connect_startup -- --nocapture`: passed (15.46 s).
  Its missing-unlink control now detects the stale record before the task stack
  is freed, so the control cannot become an accidental use-after-free probe.
- Final formatting (1.34 s), web/bench harness compilation, workflow lint and
  documentation links/history passed. Primitive inventory and all seven native
  runner checks passed (1.53 s); the inventory needs an explicit output path.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | HTTP server owners; remaining host boundaries/cycles; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps and measured code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

Use guarded serial focused local checks; full builds and suites run on GitHub.
Implementation is in progress; nothing in this batch is accepted yet.
