# Session handoff

Current branch: `http-client-delivery`, based on accepted PR #161 (`fd25a10c`).
The HTTP implementation is integrated as `5ba6e970`; its files match preparation
`828bf74c8c7484aabcf82962705ff50b103a3107`, retained by immutable tag
`evidence/http-client-owners-20261017`. This checkout is the current delivery.

PR #161 passed all nine production jobs (`39044644736`) and documentation
(`39044644846`) at `0e162dcd`. Its squash has the identical tree and the verified
one-line message without trailers. Duplicate production `39051585338` is cancelled.
See [history](roadmap-history.md) for the accepted work and failure audit.

## Next action

Next: publish the combined repairs and repeat the six-native-host HTTP suite,
including memory measurements. The [first run](https://github.com/e6qu/fun-with-pipes/actions/runs/39051530853)
(source `828bf74c`) finished every target and real HTTP comparison. All six hosts
passed interpreted/native cleartext/TLS calls. The complete failure audit found
one stale gRPC injection target on all hosts, plus two Unix-only probes on Windows.
Repairs preserve their negative controls and add both probes to Windows production.
A separate startup review found client/server socket/TLS transfer happened before
connection allocation; the candidate now transfers only after success, with a deliberate
premature-transfer control. Final HTTP acceptance is still pending.

Publish the next PR after focused validation; inspect actual binaries and retain
repeated memory evidence before all final-head production/docs gates. No HTTP
delivery has been accepted yet.

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

Preparation checks used the root checkout's `scripts/local-guard.py` from the
isolated worktree, sharing its target and resource limits. Set
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

## Combined repair and measurement checks

All six original jobs completed ten ownership targets and one real-HTTP target
(66 target executions). All failures are accounted for above. The HTTP comparison
passed everywhere; no platform is accepted with its failed ownership step.

- Guarded `cargo test --test grpc_client_requests`: passes (25.93s including build),
  with the omission scoped to gRPC and all O1/O2 controls retained.
- Guarded `cargo test --test http2_client_ownership`: both tests pass (42.08s),
  including socket/TLS preservation when allocation fails and a negative control
  that deliberately transfers too early.
- Guarded `cargo test --no-fail-fast --test grpc_connect_cleanup --test library_resources`:
  both pass (23.92s). Probes use native socket widths, explicit Windows/Unix
  loader APIs and real loopback peers; no test is skipped for Windows.
- Added a runner-only repeated HTTP measurement: tracing/checked ARC, cleartext/TLS,
  1/16/256 calls and three measured processes per case. Counts include managed
  allocations, retains and charged peak/final storage; raw transport/TLS/OS memory
  and timing are excluded. It compares current fwp modes, not C/Rust or a prior
  compiler. Runtime results and actual binary review remain pending.

Final startup rerun after adding the server-side control passes (18.53s); its
first local attempt exposed an ambiguous injection needle, now scoped to the
server entry. Both integration harnesses compile (1.46s). The repeated source
passes ARC code emission (1.10s) after adding its concrete fold signature and
using `IoError` consistently for input/network errors; source formatting passes.
Rust formatting, documentation (2.86s) and workflow lint (1.02s) pass. The complete
first-run log audit is retained locally at `/private/tmp/fwp-http-first-audit.json`.
