# Session handoff

## Next action

This is isolated preparation on `prove-queued-function-ownership` in
`/private/tmp/fwp-channel-functions`, based on final PR #174 head
`67f233467bc68fe9a690373af219253d45f4e3f8`. The primary checkout owns PR #174:
production `39342938663` is running; documentation `39342938600` passed, as did
the production benchmark job. Do not modify or merge that PR without auditing
all nine exact-head jobs. Its measured compiler is `0bb385ab`; the difference
is retained reports and documentation only.

Next: complete the queued-function capture proof, add positive/negative lifetime
and cleanup tests, then run focused checks on runners. This preparation is not
accepted support. ARC still rejects function channel payloads in `src/arc.rs`.

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
Formatting passed under the primary guard (last run 1.54 seconds). Compiler
integration is not tested yet; dispatch `channel-proof` on the preparation branch.
No runtime or eligibility relaxation has been made.

Still required before relaxing rejection:

- Verify the implemented capture and unknown-source rules against real lowered
  programs, including external inputs and modeled gRPC iterator constructors.
  Do not erase existing native/service support. Runtime producers need explicit
  sources; an alias contract must not conceal a newly manufactured function.
- Verify activation for function-bearing channels even without State/AD and
  distinction between empty queues and unknown functions. Check every send,
  nested/returned/error-carried callback, aggregate, alias and partial application.
- Only then permit proved function payloads in `src/arc.rs`, update obsolete
  blanket-rejection tests, and add native/WASI lifetime, failure, cancellation,
  undrained/closed-queue and repeated bounded-live evidence. Negative controls
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
