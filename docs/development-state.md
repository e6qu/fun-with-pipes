# Session handoff

## Next action

Preparation branch `prove-queued-function-ownership` lives in
`/private/tmp/fwp-channel-functions`, based on PR #174 head
`67f233467bc68fe9a690373af219253d45f4e3f8`. The primary checkout owns that PR.
Production `39342938663` has eight passing jobs; Linux ARM64 remains running.
Documentation `39342938600` passes. Keep its head unchanged.
Require all nine production jobs and documentation, squash merge, then verify
identical trees and a one-line message. The prepared final audit is
`/private/tmp/fwp-audit-174-combined-final.py` (run from the primary checkout
through its local guard). Only then publish the next ownership PR.

Next: finish native/WASI run `39349638508` and server run `39349641747`, both
at `ca3c9c0f6c33b79885c936996f3e4f72e3031cf9`. The autodiff repair passes on
all six native hosts. Each has 20 passing integration checks; its only failure
is the added gRPC test reusing a C-file path for a split-build directory.
All six complete logs were audited. Distinct output paths repair that test.
The compiler itself is unchanged; the next PR's full native gates must execute
the repaired case. Keep the current WASI/server runs for their unchanged source.
Earlier server run `39348422141` is fully audited: its new fixture's exposure
annotation was misplaced and is fixed in `ca3c9c0f`; all other entry checks and
all three REST API/authentication/multipart checks pass.
Audit every completed target and failure before the next repair push. No new
platform support is accepted yet.

## Queued-function implementation

ARC queues now admit known functions with proved immutable captures. This
includes numbers, strings, containers and other proved functions. Captured
channels, tasks, files, connections and streams remain rejected, even when a
particular program might be safe. No new syntax or runtime implementation.

`arc_scope.rs` tracks known and unknown function sources through captures,
calls, queues and caught errors. Unknown sources survive union with known ones.
Calls use the receiver's State/autodiff scope. Queues of one concrete type,
aggregate fields and caught errors merge conservatively. External function-bearing
queues remain unproved. Native constructors need an explicit source model.
See [the proof and worked example](ownership.md#next-proof-functions-stored-in-channels).

The latest repair uses checked function types to exclude incompatible targets
mixed from neighboring fields. Previously, the wrapper in
`option.map (ad.scope (apply 1))` was confused with queued `ad.tape`, falsely
calling that target outside its scope. The original failing test remains; a
unit assertion verifies that refining types never removes unknown sources.
A new emit-only regression accepts a local iterator, accepts a remote iterator
with tracing, and requires ARC to reject its captured `GrpcCell` stream owner.
It does not make network requests or establish new gRPC execution support.

## Validation and evidence

Full builds and suites run on GitHub. Earlier preparation:

- `4ad0107a` / `39344388657`: both Linux jobs passed 141 unit and 16 integration
  checks; unused-binding Clippy failure fixed in `0e291839`.
- `0e291839` / `39345460745`: both Linux jobs passed Clippy, 141 unit and
  18 integration checks, none ignored.
- `67839578` / `39346219500`: all eight jobs audited. Both Linux and Intel macOS
  pass. ARM macOS and Windows lacked OpenSSL for two unrelated probes; fixed
  in `e497f639`. Both WASI jobs passed 13 checks but rejected the now-valid empty
  function queue; replaced with acceptance plus real cyclic-capture rejection.
- `e497f639` / `39348144254`: TLS setup repairs pass on all six native hosts.
  Only the new receiver-autodiff check fails; all six complete native logs were
  audited (19 integration checks pass per host). The type refinement addresses
  its cause. Both full WASI jobs pass all 14 tests, with none ignored.
- `a3cdf5d8` replaces the same obsolete blanket rejection in REST/MCP entry tests,
  executes a queued function through MCP, and rejects captured channels. It is
  test-only; the measured compiler matches `e497f639`.

Tests cover returned/nested functions, State, autodiff, caught errors, cancelled
blocked transfers, closed sends and undrained queues. A C probe checks unchanged
charged memory after each of 256 transfer/close/failed-receive cases at O0/O2;
omitted releases must fail. WASI separately counts physical allocations at
shutdown and exercises JSPI/Asyncify. Native artifacts retain C, binaries and
actual disassembly. These are cleanup checks, not speed or zero-allocation claims.

All local workloads used the primary `scripts/local-guard.py`. Formatting last
passed in 1.55s. `python3 scripts/check-roadmap.py` passes in 2.61s after restoring
the required status table and next-action marker; an initial mistyped script name
did not run a check. Saved-compiler raw interpretation
validated the value/task fixtures, five rejection examples and updated tutorial;
it does not validate the new proof. Saved-compiler C emission for the remote
iterator fixture passed in 0.40s, without compiling native code. No local compiler
build or benchmark ran. Full logs are under `/private/tmp/fwp-queued-corrected-*`.
The earlier ARM64 artifact (`e497f639`, 17 MiB unpacked) was inspected locally:
ARC disassemblies have no collector routines, while allocation, dynamic calls
and count operations remain. It is partial evidence from a failed preflight;
the current compiler still needs complete acceptance.

The final PR #174 benchmark is retained in
[the C/Rust comparison](measurements/numeric-output-peers-2026-10-20.md), including
slower cases and measurement limits. The benchmark guide links it.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven areas in [PLAN.md](../PLAN.md) remain open. Persistent subscriptions,
resource captures, resource-owning tail frames and mutual recursion need further
proofs. JIT is excluded. Follow [AGENTS.md](../AGENTS.md): one active PR, all
final-head gates, bounded local work and one-line commits without trailers.
