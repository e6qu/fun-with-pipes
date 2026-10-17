# Session handoff

Preparation branch: `http-server-owners`, isolated at
`/private/tmp/fwp-http-server-owners`, based on PR #162 final head `99d70deb`.
PR #162 is still in production acceptance. The root checkout owns its handoff
and merge watcher; preserve that head and open no second PR before acceptance.

## Next action

Next: validate HTTP server connection, handler/job, request and writer ownership
as one lifetime contract, with cleanup on preparation failure, traps, cancellation,
peer reset, shutdown and loader unload. Prove when handlers run before admitting
`http2.serve/respond/data` to checked ARC. Keep HTTP/1.1, h2c upgrade, TLS/ALPN,
compression, streaming and concurrent behavior consistent with the interpreter.

## Scope and acceptance

The preparation implements connection/reader/writer owners, active request owners
and counted H2Stream handles. The handle also serves as the task payload, removing
a separate per-request job allocation. Jobs borrow the connection-owned handler;
one retain per connection survives serve unwinding before its children finish.
Cleanup cannot suspend, so borrowing the caller frame across that failure path
is invalid. Task links clear after joined children finish; escaped handles retain
request/connection storage. The #162 socket-transfer allocation fix stays covered.

Compiler changes count H2Stream values, emit their concrete destructor, preserve
resource lifetimes and check HTTP handlers under fresh State/AD task scopes.
Shutdown signal primitives now declare their scalar-only memory contract. Checked
ARC server admission is implemented but not accepted. The HTTP comparison now
builds both client and server at O1/O2 in tracing/ARC modes and compares all
cleartext/TLS pairings with interpreted output. Runner validation remains pending.

Also investigate the measured generic function-entry code growth: in the HTTP
client, ARC inlines repeated ownership checks into 532 common entries, adding
204,649 instruction bytes on Linux AMD64. Measure an alternative code arrangement
and actual call frequency before selecting an optimization. Preserve contract
failures; do not remove checks without proof or claim speed from code size alone.

Acceptance needs O1/O2 omission/failure/cancellation controls, stress and reuse
verification, interpreted/native HTTP comparisons, repeated managed memory plus
long-running process memory, actual ARM64/AMD64 machine-code review and all six
native hosts. Final production remains nine jobs plus documentation. Establish
remaining allocation/count/code/stack costs; this does not finish all seven areas.

Use the root guard explicitly for all local checks:
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`.
It shares the root target and fixed resource limits. Full suites and measurement
regeneration belong on GitHub. No native-support claim yet.

## Focused checks and remaining validation

All commands below use the root guard prefix above.
- `cargo test --test http2_client_ownership --no-run`: passed, 24.09 s.
- `env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 cargo test --test http2_server_ownership -- --nocapture`: two probes passed, 36.62 s, with O1/O2, GC stress/verification/reuse and deliberate missing-owner controls. The startup fixture now invokes a generated typed closure with a captured string. An initial invocation lacked the OpenSSL path; a test-only untyped closure was replaced with a generated typed closure/capture.
- `cargo fmt --all`: passed, 1.30 s.
- Representative server ARC C emission first rejected missing shutdown signal contracts; those are now explicit. `env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 cargo run --quiet -- build --gc arc --emit-c -o /private/tmp/fwp-http-server-arc.c tests/web/server.fwp`: passed, 19.34 s.
- `cargo test --lib arc_scope::tests::asynchronous_callbacks_do_not_inherit_dynamic_scopes -- --exact`: passed, 14.30 s.
- `cargo test --test web --no-run`: expanded harness compiled, 16.75 s.
- With the OpenSSL environment above, `cargo test --no-fail-fast --test http2_server_ownership --test http2_body_roots --test http2_peer_cleanup -- --nocapture`: all four tests passed, 31.55 s. Server-only rerun after adding scoped-task, post-connection handle and TLS-failure checks passed in 19.06 s.
- With the same environment, `cargo test --test http2_client_ownership -- --nocapture`: both existing client controls passed, 27.48 s.
- `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-http-server-inventory.json`: passed, 1.09 s; 378 declarations, 355 contracts, 19 templates, three scalar-only declarations and one runtime-review primitive (`device.gpu-run`). This count does not complete the roadmap.
- `python3 scripts/check-roadmap.py`: passed, 2.68 s; links, handoff, immutable anchors and commit subjects.
- `actionlint .github/workflows/numerics.yml .github/workflows/windows.yml`: passed, 1.32 s.
- `python3 scripts/test-native-test-runner.py`: all seven checks passed, 1.08 s; new server target assigned to regular macOS and native Windows.

Next: complete focused scope/type/cleanup checks and audit all affected HTTP
fixtures; run actual server comparisons on six native runners, add repeated
server memory/RSS evidence and inspect binaries. Generic-entry code size work
has no implementation yet. Do not publish another delivery PR until #162 merges.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | HTTP client owners; remaining host boundaries/cycles; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps and measured code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

Use guarded serial focused local checks; full builds and suites run on GitHub.
Implementation is in progress; nothing in this batch is accepted yet.
