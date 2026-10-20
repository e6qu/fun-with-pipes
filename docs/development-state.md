# Session handoff

## Next action

PR [#175](https://github.com/e6qu/fun-with-pipes/pull/175), branch
`queued-function-delivery`, is frozen at `d1df84d96642c5f097f915f63cb58bf82fcb855f`.
Production run `39353280539` has passed benchmarks; eight native jobs remain in
progress. Documentation run `39353280537` passed. Require every final-head gate,
audit failures together, then squash merge with an explicit one-line subject and
empty body. Verify the resulting tree/message before cancelling redundant CI.

Independent preparation is on `measure-channel-transfers`, worktree
`/private/tmp/fwp-channel-transfers`. Keep one active PR. The next concrete action
here is an ownership-transfer implementation selected from the measured counts.
Next: make typed sends consume their message owner, preserve aliases and all
failure/cancellation checks, then repeat counts while preserving PR #175's head.
[The protocol](measurements/channel-transfer-protocol.md) defines what is counted.

The new examples exposed later-stage Error/IO effects leaking into an earlier
stored callback's type during composition. Open both temporary call rows with
known effects from the other stage; keep the stored callback's own effects intact.
Run `39354805966` at immutable `2b56fd1c` passed on Linux ARM64 and AMD64:
nine callback-effect checks, all type snapshots and five count-profile cases on
each host. All completed logs were audited. The report validates 180 samples and
20 ordinary binaries. Fresh payloads have one owner yet incur one queue retain
per message; shared payloads have multiple owners. ARC ends with zero charged
storage and no collections. Full production validation of this repair remains
required in its eventual delivery.
Local guarded fixture checks: three cases pass interpretation and ARC C emission;
the two function-receive cases reproduce the old inference failure. The saved
compiler predates the repair. Formatting passed; no local compiler/native build
or timing run was performed. The five fixtures use explicit constant-stack loops,
without building an input list. Incidental function-local imports in `cgen.rs`
and `tests/exec.rs` were moved to their module import blocks.

PR #175 compiler source `c04f01fbeb1dc0f1a1efc07473bcc894b864175a` is preserved by
`roadmap/revision-queued-functions-c04f01fb`. Focused macOS ARM64 `39352725240` and
Linux AMD64 `39352728274` each pass 144 unit, seven queue and one generated-entry
check, none ignored. Later delivery changes are documentation only.

PR [#174](https://github.com/e6qu/fun-with-pipes/pull/174) is accepted as
`3ec71969089a7ab95ff065f7b611c74534fbe326`: all nine jobs and docs passed;
merge tree/message were verified. [History](roadmap-history.md#numeric-hashing-and-integer-output-pr-174)
retains results. Older `prove-queued-function-ownership` preparation is historical;
do not resume it.

## Implementation

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
included, using `FWP_NO_OPT=1` so optimization cannot erase the empty map.
The diagnostic now identifies the function where proof fails.
Review also found unbounded structural comparison of recursive record types.
The saved compiler exceeded the local 1 GiB guard on a small reproducer and was
stopped; do not rerun that check locally. `ir::same_type` now visits each type
pair once. Unit tests check equivalent shapes, mismatches after recursive fields
and distinct variant names. Those tests and the native/interpreter regression
pass on the focused macOS runner.

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
- `a1162f87`, focused runs `39352051384` and `39352344445`: generated entries
  and all five queue checks pass on macOS ARM64 and Linux AMD64. This verifies
  the empty-origin repair before the additional recursive-type regression.
- Final compiler source `c04f01fb`, focused run `39352725240`: all 152 checks
  pass on each of macOS ARM64 and Linux AMD64, including the two additional
  program regressions and recursive type units. No new platform support is accepted
  until the final production gates pass.

Tests cover returned/nested functions, scopes, errors, cancelled transfers,
closed/undrained queues and repeated work. A C probe checks unchanged charged
memory after each of 256 cases at O0/O2; omitted releases must fail. WASI counts
physical allocations and exercises JSPI/Asyncify. Native artifacts retain C,
binaries and disassembly. These are cleanup checks, not speed or zero-heap claims.

Local checks use `python3 scripts/local-guard.py COMMAND...`, unchanged limits.
Formatting last passed in 1.36s; documentation in 2.82s. Saved-compiler raw
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
