# Session handoff

Updated 2026-10-13. The user authorized all seven steps in [PLAN](../PLAN.md)
as one combined PR. Active branch: `ownership-numerics-next`.
Publication and squash merge are authorized after all seven exact-head
production jobs and the documentation audit pass. Commit messages have one
line, at most 80 characters, no body, trailers or attribution.

## Accepted baseline

PR #132 is merged at `c67800ec8530e44501c54c69719af26b0585bedc`.
Its ten-task bundle is complete; all seven production gates and docs passed.
[History](roadmap-history.md#ten-task-platform-and-ownership-bundle-pr-132)
records heads and links. Linux/macOS ARM64/AMD64 packages are verified.
Windows remains deferred; universal binaries are not an objective.

## Remaining ownership deliveries

The active seven-step bundle is in progress. Code extensions remain pending execution acceptance.

- Docs: replaced obsolete PR #132 pending actions with its acceptance record.
- Reconstruction: inspect typed CSV/JSON/protocol graphs and partial failures.
- State/callbacks: typed State runtime owners exist; ARC still rejects run-state.
- Producers: consumer fusion exists; source tails still allocate/dispatch.
- Wide integers: counted boxed leaves exist; worker/local unboxing remains.
- Numerics/AD: preserve existing bounded workspace reuse; gather new evidence.
- Float formats: explicitly settle precision and wire-format policy.

## Checks and next action

`python3 scripts/local-guard.py cargo check --lib` passed (2.42 CPU seconds,
4.85 seconds elapsed). State scope analysis and direct known modify lowering
are implemented but execution checks remain pending. Existing debug compiler is stale;
do not treat it as validation of this branch. Full builds, suites, benchmarks
and large evidence generation run on GitHub. Local checks use
`python3 scripts/local-guard.py COMMAND...`, serially within existing limits.

Focused CI 38393812709 found a Clippy clone warning; fixed in b1c2a57.
Focused CI 38394225120 exercised the earlier changes and found an invalid State
fixture and missing producer fusion through optimizer bindings. Both are
corrected in the working tree; the new raw forcing-order regressions passed
on Linux AMD64. Decoder ownership is now implemented in the working tree,
including a new typed field cleanup runtime, JSON scratch arena, text/protocol
partial cleanup and typed CSV results. Added typed decoder alias/error tests
and injected construction/unwind controls; these need CI execution.

`python3 scripts/local-guard.py python3 /private/tmp/fwp-check-runtime.py`
passed C syntax validation of the edited runtime (0.08 CPU seconds). The new
decoder fixture ran in the old raw interpreter as an early syntax/oracle check;
the State fixture needs the current compiler because the local binary predates
the accepted higher-order State inference fix. This is not current-head validation.

Next: run decoder/State/producer checks on the current branch;
then producer specialization and wide-number lowering. Track actual outcomes
here, replace resolved failures, and keep the PR open until all seven steps
are accepted. Preserve raw interpreter/native semantics and inspect emitted C
and native instructions. Unsupported cycles/foreign boundaries remain explicit.
