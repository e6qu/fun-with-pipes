# Session handoff

## Next action

The primary checkout is on `queued-function-delivery`; no PR is open yet.
Next: finish focused runs `39352051384` (macOS ARM64) and `39352344445` (Linux
AMD64) at `a1162f87`, validate the recursive-type repair below, fix remaining failures,
then publish the ownership PR and require all nine final-head production jobs
plus documentation before squash merge. Preserve passing heads while other gates
run. Audit every failed job and completed target before a combined repair push.

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) is accepted as
`3ec71969089a7ab95ff065f7b611c74534fbe326`. All nine jobs and docs passed; its
merge tree matches tested head `67f23346`. The message is one line, 73 characters,
without body or trailers. Redundant post-merge production `39351187907` was
cancelled after verification. [History](roadmap-history.md#numeric-hashing-and-integer-output-pr-174)
and [the C/Rust comparison](measurements/numeric-output-peers-2026-10-20.md)
retain actual results and remaining performance gaps.

Preparation branch `prove-queued-function-ownership` remains in
`/private/tmp/fwp-channel-functions`; the primary branch contains its changes
on accepted main and now owns further work. Do not resume the older worktree.
Immutable `roadmap/revision-queued-functions-ca3c9c0f` preserves earlier evidence.

## Implementation and current repair

ARC queues admit known functions with proved immutable captures: numbers,
strings, containers and other proved functions. Captured channels, tasks, files,
connections and streams remain rejected, even when a particular program might
be safe. There is no new syntax or runtime implementation.

The compiler tracks known and unknown sources through captures, calls, queues
and caught errors. Unknown sources survive union with known ones. Calls use the
receiver's State/autodiff scope. Queues of one concrete type, aggregate fields
and caught errors merge conservatively. Checked function types exclude incompatible
origins from neighboring fields. External function-bearing queues stay rejected.
See [the proof and worked example](ownership.md#next-proof-functions-stored-in-channels).

Generated REST/MCP wrappers exposed a separate false rejection: a call through
`uncurry` with no possible incoming function. Empty origin sets represent
unreachable calls, such as mapping over an empty function collection; unmodeled
runtime/foreign values carry an explicit unknown source. `a1162f87` separates
these cases and retains unknown-source rejection. A standalone regression is
also prepared, using `FWP_NO_OPT=1` so optimization cannot erase the empty map.
The diagnostic now identifies the function where proof fails.
Review also found unbounded structural comparison of recursive record types.
The saved compiler exceeded the local 1 GiB guard on a small reproducer and was
stopped; do not rerun that check locally. `ir::same_type` now visits each type
pair once. Unit tests check equivalent shapes, mismatches after recursive fields
and distinct variant names; a native/interpreter regression is prepared for CI.

## Validation

- `ca3c9c0f`, run `39349638508`: all six native hosts pass Clippy, unit checks
  (142 Linux/macOS, 143 Windows) and 20 integration checks. Their only failure
  was a new gRPC test using one path for both a C file and a split-build directory.
  `7ccf6654` fixes that path. Both WASI jobs pass all 14 tests, none ignored.
- Server run `39349641747`: all completed targets audited. Existing entry checks
  and all three REST API/authentication/multipart checks pass. The new queued
  endpoint fails the empty-origin proof above. Earlier TLS setup and exposure
  annotation failures were repaired and verified; they are not outstanding tasks.
- Focused run `39351589390` at `cb99e36a`: all five queued-function tests pass,
  including the repaired gRPC capture rejection and receiver-autodiff test.
  The generated entry still fails at `uncurry`. Its runner-built macOS compiler
  is saved in `/private/tmp/fwp-queued-diagnostic-compiler/fwp`.
- Focused replacement `39352051384` runs only generated queued entries and queue
  regressions on macOS ARM64. Its result is pending. Full final-head native/WASI
  acceptance remains required; no new platform support is claimed yet.

Tests cover returned/nested functions, scopes, errors, cancelled transfers,
closed/undrained queues and repeated work. A C probe checks unchanged charged
memory after each of 256 cases at O0/O2; omitted releases must fail. WASI counts
physical allocations and exercises JSPI/Asyncify. Native artifacts retain C,
binaries and disassembly. These are cleanup checks, not speed or zero-heap claims.

Local checks use `python3 scripts/local-guard.py COMMAND...`, unchanged limits.
Formatting last passed in 1.54s; documentation in 2.56s. Saved-compiler raw
interpretation validates fixtures/tutorials. The minimal empty-map example prints
`[]` (0.64s), while old ARC C emission reproduces the `uncurry` rejection (0.76s).
Standalone endpoint C emission passes (1.00s); MCP reproduces the failure (10.14s).
No local compiler rebuild, native build or benchmark ran. Complete logs are saved
under `/private/tmp/fwp-queued-*`. Earlier ARM64 binaries omit collector routines
in ARC but retain allocation, dynamic calls and count operations.

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
