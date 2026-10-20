# Session handoff

## Next action

This is preparation on `prove-queued-function-ownership` in
`/private/tmp/fwp-channel-functions`, based on PR #174 head
`67f233467bc68fe9a690373af219253d45f4e3f8`. The primary checkout owns that PR.
Production `39342938663` is running; documentation `39342938600`, benchmarks
and both ARM macOS jobs pass. Keep that tested head unchanged. Require all nine
production jobs and documentation before squash merge, then verify its tree and
one-line message. The final-head benchmark is retained at
`/private/tmp/fwp-174-final-production-bench.md` for the next documentation update.

Next: publish the complete repair batch and rerun `channel-proof`; all eight
jobs in `39346219500` have been audited. After PR #174 passes and merges, deliver this
ownership work as the next single PR with current docs and full acceptance gates.
No new platform support is accepted yet.

## Queued-function implementation

The compiler now permits functions in ARC channel payloads when their actual
captures are proved immutable. Numbers, strings, containers and other proved
functions are supported by the new analysis. Captured channels, tasks, files,
connections and streams remain rejected. This conservative restriction can reject
safe programs; it is not a claim that all rejected programs contain cycles.

`arc_scope.rs` tracks known functions and an explicit unknown source through
captures, calls, queues and caught error values. Unknown sources survive union
with known functions. Calls use the receiver's State/autodiff scope. Queues of
one concrete type share a target set; aggregate fields and caught errors also
merge conservatively. External function-bearing queues remain unproved. Native
constructors need an explicit source model. There is no new syntax or runtime
implementation. See [the proof](ownership.md#next-proof-functions-stored-in-channels).

## Checks and outstanding repair

All builds and full suites run on GitHub:

- Initial proof `4ad0107a`, run `39344388657`: both Linux hosts passed 141 unit
  and 16 integration checks. Clippy found one unused binding; fixed in `0e291839`.
- `0e291839`, run `39345460745`: both Linux hosts passed Clippy, 141 unit and
  18 integration checks, none ignored.
- Expanded source `67839578`, run `39346219500`: both Linux native jobs pass.
  The three queued-function tests also pass on both Windows hosts and ARM macOS.
  Complete logs exposed missing OpenSSL setup in those three jobs: the HTTP-body
  unit check and State cleanup C probe could not compile. The pending batch adds
  the existing Windows TLS setup/cache and explicit macOS OpenSSL configuration.
  Windows production will also run its complete unit suite after dependency setup.
- Both WASI jobs finish with 13 passed and one obsolete rejection check failed.
  Actual execution/cleanup passes, including JSPI and Asyncify for WASI/Browser.
  The old test rejected an empty function queue; the pending replacement accepts
  that queue and rejects an actual self-capturing callback on both entry targets.
- Intel macOS also passes: 141 unit and 19 integration checks, none ignored.
  Every completed target on all eight hosts was audited before this repair.

Expanded tests cover records, nested queues, functions capturing functions,
receiver State, caught errors, cancelled blocked sends/receives, closed sends,
caught failure and undrained queues. A C probe checks unchanged charged memory
after each of 256 transfer/close/failed-receive cases at O0/O2; omitted releases
must fail. WASI separately counts physical allocations at shutdown. These are
cleanup checks, not speed benchmarks or proof of zero heap/counting overhead.

The pending batch also adds explicit unknown-producer/external-queue unit checks,
a caught-channel rejection and receiver autodiff test, plus a worked tutorial.
Native artifacts will retain disassembly as well as source/binaries. These new
checks have not run on the compiler yet.

Local work uses the primary `scripts/local-guard.py`, with unchanged limits:
formatting last passed in 1.62s; doc links/anchors passed in 2.56s; saved-compiler
raw interpretation of value/task fixtures passed in 0.35/0.27s; all five negative
fixtures are valid programs (0.86s); the updated tutorial output, formatting and
source excerpts pass (0.29/0.01/0.23s). These interpreter runs do not validate the
new ownership implementation. No local compiler build or benchmark ran.
The final PR #174 production benchmark is now retained in
`docs/measurements/numeric-output-peers-2026-10-20.md`, linked from the benchmark
guide with its C/Rust overhead and measurement limits.

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

All seven areas remain open. Persistent subscriptions, resource captures,
resource-owning tail frames and mutual recursion need separate proofs. JIT is
excluded. Follow [AGENTS.md](../AGENTS.md), including one active PR, all final-head
gates, bounded local work and one-line commits without bodies or trailers.
