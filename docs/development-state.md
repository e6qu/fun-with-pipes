# Session handoff

## Next action

This is isolated preparation on `prove-queued-function-ownership` in
`/private/tmp/fwp-channel-functions`, based on final PR #174 head
`67f233467bc68fe9a690373af219253d45f4e3f8`. The primary checkout owns PR #174:
production `39342938663` is running; documentation `39342938600` passed, as did
the production benchmark job. Do not modify or merge that PR without auditing
all nine exact-head jobs. Its measured compiler is `0bb385ab`; the difference
is retained reports and documentation only.

Next: run the expanded queued-function checks on all six native hosts and both
Linux WASI hosts, inspect every result, and fix any failure before publication.
This preparation is not accepted support. `src/arc.rs` now permits function
payload types only with the separate capture and call-scope proof.

## In-progress implementation

`src/arc_scope.rs` now distinguishes a known function plus supplied-argument
count from an explicit unknown source. Set union must retain unknown sources
when mixed with known functions. The existing finite analysis also records
function values sent through each concrete channel type and returns those
values at receive operations, so calls are checked in the receiver's scope.
Unit checks cover receiver State scope, mixed known/unknown targets, nested
capture owners and functions carried by caught errors. The prototype follows
error payloads separately from ordinary returns and rejects unknown producers.
It checks immutable captures recursively, rejecting resource captures for now.
Initial proof-only source `4ad0107a` ran in `39344388657`: both Linux architectures
passed 141 compiler unit checks and all 16 existing integration checks. Both
failed Clippy solely on an unused pattern binding; the complete logs were audited
and that binding is removed. Formatting passed under the primary guard (1.57s).
Source `0e291839` then passed `39345460745` on both Linux architectures: Clippy,
141 compiler unit checks and 18 integration checks each, none ignored. This
verifies the initial eligibility subset and three rejection examples. They compare
raw interpretation with ARC/tracing O0/O2, check undrained capture reclamation,
require an omitted-release control to fail, inspect collector symbols, and reject
self, returned and nested channel captures. WASI's physical-allocation suite now
includes the same positive fixture. No runtime implementation has changed.

The next source expands that fixture with nonempty records and nested queues,
functions capturing functions, caught error values and receiver State scope.
New tests cover cancelled blocked sends/receives, closed sends, caught failure,
64 repeated drained/undrained batches, and a C probe checking constant charged
memory after each of 256 transfer/close/failed-receive cases. Missing-release
controls must fail. WASI/Browser checks run ordinary and instrumented binaries
with JSPI and Asyncify; these additions are not verified yet. The runner jobs
retain actual C/binaries and source IDs. Windows permanently runs the new test.

Local checks use the primary guard: formatting 1.58s; saved-compiler raw
interpretation of the task/expanded-value fixtures passes in 0.27/0.35s. These
interpreter runs verify source semantics, not the new compiler's ownership proof.

Still required before claiming support:

- Verify the implemented capture and unknown-source rules against real lowered
  programs, including external inputs and modeled gRPC iterator constructors.
  Do not erase existing native/service support. Runtime producers need explicit
  sources; an alias contract must not conceal a newly manufactured function.
- Verify activation for function-bearing channels even without State/AD and
  distinction between empty queues and unknown functions. Check every send,
  nested/returned/error-carried callback, aggregate, alias and partial application.
- Verify the new eligibility rule and replacement of obsolete blanket-rejection
  tests; add native/WASI lifetime, failure, cancellation and repeated bounded-live
  evidence. Negative controls
  must include self/two-queue cycles, unknown sources and calls after State/AD
  scopes end. Keep task/HTTP-stream payload restrictions.

The design is in [ownership](ownership.md#next-proof-functions-stored-in-channels).
The runtime already owns queued closures and their captures in tracing mode;
existing `tests/channel_queue_ownership.rs` checks transfers and cleanup.
`mono.rs` lowers const/curry/compose into ordinary IR. Native gRPC explicitly
creates iterator closures; its generated IR constructor must remain modeled.
Do not infer safety from a whole-program absence of resource types or an empty
function-target set.

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

All seven areas remain open. JIT is excluded. Follow [AGENTS.md](../AGENTS.md):
keep local checks serial under the primary `scripts/local-guard.py`, preserve
its fixed limits, and put full builds, suites and benchmarks on GitHub.
