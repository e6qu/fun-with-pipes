# Session handoff

Current delivery: [draft PR #162](https://github.com/e6qu/fun-with-pipes/pull/162),
branch `http-client-delivery`, based on accepted PR #161 (`fd25a10c`).
The HTTP implementation is integrated as `5ba6e970`; its files match preparation
`828bf74c8c7484aabcf82962705ff50b103a3107`, retained by immutable tag
`evidence/http-client-owners-20261017`. This checkout is the current delivery.

PR #161 passed all nine production jobs (`39044644736`) and documentation
(`39044644846`) at `0e162dcd`. Its squash has the identical tree and the verified
one-line message without trailers. Duplicate production `39051585338` is cancelled.
See [history](roadmap-history.md) for the accepted work and failure audit.

## Next action

Next: publish the final evidence, mark #162 ready, and require all nine production
jobs plus documentation on that exact commit before squash merge. Both Windows
reruns at `aacecfd5` pass: [AMD64](https://github.com/e6qu/fun-with-pipes/actions/runs/39054383589)
and [ARM64](https://github.com/e6qu/fun-with-pipes/actions/runs/39054388163). All 24
targets completed, including the header repair and steady-memory assertion.
Keep one active PR. No HTTP delivery is accepted until final production passes.

The [combined six-host run](https://github.com/e6qu/fun-with-pipes/actions/runs/39052834580)
at `8770c03ef7eb36e04c1f412c13090270aaf11526` completed all 72 target executions.
Linux and both macOS hosts passed every step. Both Windows jobs failed only
`grpc_connect_cleanup`: its API version definition followed a system header.
Commit `aacecfd5` moves it before every include. Real HTTP comparisons, library
unload and all 216 memory samples pass on all six hosts. No skipped job counts
as platform acceptance.

## Batch scope and acceptance

HTTP client pool/caller/I/O-task owners, request cancellation/reset and typed
partial-response cleanup are implemented. Complete connection keys avoid the old
1,200-byte truncation. Client/server entry now transfers socket/TLS ownership only
after connection allocation succeeds. HTTP server handlers, Browser and async
WASI remain outside checked ARC; their ownership is separate work.

Require cleanup omission controls, O1/O2 with stress/verification, interpreted/native
cleartext/TLS comparisons, repeated memory samples, actual binary inspection and
all final production/docs gates. Preserve header/trailer order, body bytes,
status and observable failure order. No speed or C/Rust parity claim.

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

## Evidence and checks

The first [six-host run](https://github.com/e6qu/fun-with-pipes/actions/runs/39051530853)
at preparation `828bf74c` completed all 66 targets. Every real HTTP comparison
passed. Audit found a stale gRPC cleanup-injection needle on all hosts and two
Unix-only probes on Windows. The combined repair scoped the needle to gRPC,
ported native socket/loader checks and used the runner's OpenSSL executable.
All omission controls remain; both ported probes are in Windows production.
The second audit isolates the remaining Windows header-order issue above.

All local checks use `python3 scripts/local-guard.py`, serially; C/TLS probes use
`FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3`. Full gates run on GitHub.

- gRPC request cleanup and O1/O2 omission controls pass (25.93s including build).
- HTTP response and client startup controls pass (42.08s); expanded client/server
  startup controls pass (18.53s) after narrowing the server injection needle.
- `cargo test --no-fail-fast --test grpc_connect_cleanup --test library_resources`:
  both pass locally (23.92s); the repaired probe also passes on both native Windows architectures.
- Both HTTP/gRPC integration harnesses compile (1.46s); the memory assertion's
  harness compiles (1.21s). Repeated source passes ARC emission (1.10s), with an
  explicit concrete fold signature and `IoError` input errors. Formatting passes.
- Rust formatting, docs (2.86s), workflow lint (1.02s) and seven test-runner checks
  (0.99s) pass. Draft documentation `39054368844` passes at `aacecfd5`; the final evidence
  links pass the guarded local audit (3.04s).

Artifacts are at `/private/tmp/fwp-http-evidence/39052834580`; both complete log
audits are `/private/tmp/fwp-http-first-audit.json` and
`/private/tmp/fwp-http-second-audit.json`. All 216 rows cover tracing/ARC,
cleartext/TLS, 1/16/256 calls and three measured processes. Final managed storage
is constant within each host: Linux AMD64 6,368 bytes, Linux ARM64 19,424;
macOS both 2,368; Windows AMD64 3,520 and ARM64 3,136. Counts match between modes
with tracing disabled and physical freeing enabled. Each additional call costs
237 managed allocations and 543 retains in this full high-level client workload.
The final sample includes pooled connections/tasks and excludes raw transport,
TLS/OS/allocator metadata, process RSS and timing. These are remaining costs.

Static inspection of all 48 actual functional/repeated binaries finds tracing
symbols in the 24 tracing builds and none in the 24 ARC builds. No downloaded
binary was executed. JSON summaries and disassembly remain beside artifacts;
the tracked [report](measurements/http-client-owners-2026-10-17.json) and
[guide](benchmarks.md#http-clients-without-tracing) now explain these costs.
Linux HTTP entry frames are 664 bytes on AMD64 and 720 on ARM64 in both modes,
including saved registers, excluding callees and AMD64's incoming return address.
ARC executable text is larger; generic entry guards are a concrete review target.

The runtime/compiler source remains `8770c03e`; subsequent changes affect tests,
evidence and docs only. Keep this source distinction when reporting measurements.
