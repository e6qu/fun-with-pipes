# Session handoff

Preparation branch: `owned-http2-client`, isolated at
`/private/tmp/fwp-owned-http2-client`. PR #161 is still awaiting final acceptance;
no second PR is open. The root checkout retains its merge watcher and final-head
CI status. This branch is preparation for the next delivery.

## Next action

Next: publish this preparation commit and run `http-clients` in the numerical
and ownership workflow on all six native hosts. Inspect all failed jobs/targets
before batching repairs. Keep PR #161's tested head unchanged; integrate this
branch and open the next PR only after #161 is accepted. Retain actual binary
inspection and repeated memory evidence before final-head production acceptance.

## Batch scope and acceptance

The current HTTP/2 client starts unowned reader/writer tasks, leaves request
storage to tracing, and constructs response headers/body without typed temporary
owners. Address startup failures, pooled connections, cancellation/reset and
partially constructed responses together. Preserve header/trailer order, status,
body bytes and transport behavior. Avoid redundant owners and pointer scratch
arrays when response fields can be constructed directly.

Require failure controls that detect omitted cleanup; normal and poisoning modes
at O1/O2; interpreted/native HTTP comparisons including pooled/TLS calls; repeated
managed/live-memory counts; actual ARM64/AMD64 binaries; all six native hosts and
all final-head production/documentation gates. Checked ARC admission depends on
proved ownership; HTTP server handlers, Browser and asynchronous WASI remain
separate work. Record measured remaining costs without claiming C/Rust parity.

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

## Local checks and pending validation

All commands use the root checkout's `scripts/local-guard.py` with this worktree
as the working directory, sharing its target and resource limits. Set
`FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3` for C/TLS probes; the initial HTTP
probe could not find headers until the installed prefix was supplied.

- `cargo test --no-fail-fast --test http2_client_ownership --test grpc_connection_addresses`:
  three tests pass (26.30s), including O1/O2, partial allocation, reset, real task
  cancellation, startup reservation failures, long keys and deliberate missing
  cleanup/truncation. The gRPC copy-failure injection was updated for the new
  constructor; no assertion was weakened.
- `cargo test --test web --no-run`: the expanded integration harness compiles
  (1.18s). Its full cleartext/TLS and interpreted/native combinations run on CI.
- `fwp build tests/web/arc-client.fwp --gc arc --emit-c -o /private/tmp/fwp-http-client-arc.c`:
  eligibility/code emission passes (1.11s); it is not executed native support.
- `fwp fmt --check tests/web/arc-client.fwp`: passes (0.49s).
- `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-http-client-inventory.json`:
  passes (1.23s): 350 declarations have contracts; four still need runtime review.
- `actionlint .github/workflows/numerics.yml .github/workflows/windows.yml`:
  passes (1.33s). The `http-clients` suite covers six native hosts and preserves
  generated C, binaries and actual results. Full PR acceptance remains separate.

Found and fixed while reviewing callers: HTTP pool keys were truncated in a
1,200-byte buffer. The common connection constructor now accepts an explicit
prefix and copies prefix/key into its one existing allocation; all call sites
and affected test probes use the new internal interface. Keys differing after
the old limit no longer collide. No compatibility wrapper was added.

Final HTTP control rerun passes both tests (37.83s including build), with explicit
source-root protection during connection-key copying and transport preparation.
Final Rust formatting, documentation audit (2.64s) and workflow validation pass.
Run the whole six-host preparation suite. Retain measurements and
actual machine-code review before claiming allocation, stack or code-size costs.
