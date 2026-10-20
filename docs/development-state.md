# Session handoff

## Next action

PR #175 is the only active delivery. Its branch `queued-function-delivery` contains
combined channel proofs, consuming sends and the measured `tap` improvement.
Local repair `6511a50f` restores the frozen primitive baseline, explicitly checks
the consuming-send contract and assigns the new measurement target to native CI.
Production at `f3c6f8d9` failed those preflights. Do not merge it. Follow the primary
worktree handoff for the final acceptance run and merge; require all nine
production jobs and documentation for its exact final head.

This worktree (`/private/tmp/fwp-channel-transfers`) is now the independent
`flatten-channel-loop-state` experiment, based on `f3c6f8d9`. Next: validate the
candidate with `channel-proof` and `channel-costs` on runners, audit every result,
and compare counts, generated C and actual binaries with the existing reports.
Keep it separate while PR #175 is being validated; do not open another PR yet.
Bring the inventory/schedule repair into this branch before its full acceptance.

## Candidate and limits

The [measured channel programs](measurements/channel-transfer-protocol.md) still
allocate their loop-state tuple on every iteration. Generated `unique-text` C
uses `V st[1]` and calls `fwp_record(3, ...)` in the loop. The preceding `tap`
action leaves a match around the next record, so existing `Again` normalization
cannot expose that record to field-by-field loop lowering.

The candidate carries `Again` through a match only when every arm's terminal
value is a record. It keeps the scrutinee, patterns, evaluation order and existing
ownership boundaries. Existing loop-shape checks still decide whether state can
be held as fields; whole-value uses keep their established representation.
No new syntax or runtime helper is added. Allocation savings and cleanup are
not yet verified. Do not claim success from the source change alone.

The expanded loop regression compares raw interpretation with O1/O2 native,
stack allocation on/off, tracing stress, reuse checks, no-reuse/no-free settings
and checked ARC. It includes observable actions, branches choosing different
records, retained aliases and caught failures. Existing preparation/unwind and
nested-loop cases must also pass. Runner counts must include all five fixtures,
three inputs and repeated samples, with zero final ARC managed charge.

## Checks

`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py env
FWP_NO_OPT=1 /private/tmp/fwp-queued-diagnostic-compiler/fwp run --interp
/private/tmp/fwp-branched-loop-reference.fwp` passes in 0.82s with stdin closed.
The new branch case prints `branches`, `branches?`, `branches?!`, then
`("branches?!?", (3, "branches"))`: effects run in order and the alias is unchanged.
This is interpretation only. No local compiler rebuild or native build was run.
Keep the fixed guard limits, especially the nearby 64 GiB free-disk floor.

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
