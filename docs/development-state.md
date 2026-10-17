# Session handoff

Preparation: `http-server-owners` at `/private/tmp/fwp-http-server-owners`, based
on PR #162 final head `99d70deb`. PR #162 remains the only delivery PR; its root
checkout owns final CI and merge. Preserve that head and open no second PR until
it passes all nine production jobs plus docs and is squash merged.

## Next action

Next: publish the combined repair and measurement batch, then dispatch
`http-clients` and `http-server-memory` on all six native hosts and `entry-checks`
on both Linux architectures. Audit every failed job and completed target before
any repair push. Collect managed memory, process memory and actual machine code
before choosing an ownership-check optimization. No server acceptance claim yet.

## Scope and acceptance

HTTP connections, reader/writer tasks, active requests and H2Stream handles have
explicit owners. A handle also carries its task payload, replacing two allocations
with one. Jobs borrow the connection-owned handler; its captures survive failure
before children finish. Escaped handles preserve request/connection storage after
socket closure. The nonescaping 64 KiB receive buffer now lives on the reader
stack; actual frame sizes and memory costs still need runner evidence.

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
then five 4096-call batches per persistent server. Both memory modes have collection
off and freeing enabled. Managed counters and resident-memory samples have separate
scopes; final managed storage must stay constant and RSS growth after warm-up must
remain below 8 MiB. Source, raw rows and ordinary/instrumented binaries are retained.
No measurement results exist yet.

A separate experiment compares ordinary inlining with noinline on the existing
`fwp_rc_share` helper. Maintained loop/map/pipeline workloads have six alternating
elapsed samples and separate instrumented check counts; C verifies output only.
HTTP binaries provide code-size evidence. Instrumentation can prevent elimination,
so counted logical checks are not ordinary machine-call counts. No runtime
optimization is selected. General benchmark workflows explicitly select the
existing C/Rust comparison, leaving this experiment separately dispatched.

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
