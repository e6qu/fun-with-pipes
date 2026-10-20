# Session handoff

## Next action

PR #175 is the only active delivery. Its branch `queued-function-delivery` contains
combined channel proofs, consuming sends and the measured `tap` improvement.
Published repair `6511a50f` restores the frozen primitive baseline, explicitly checks
the consuming-send contract and assigns the new measurement target to native CI.
Production at `f3c6f8d9` failed those preflights. Do not merge it. Follow the primary
worktree handoff for the final acceptance run and merge; require all nine
production jobs and documentation for its exact final head.

This worktree (`/private/tmp/fwp-channel-transfers`) is now the independent
`flatten-channel-loop-state` experiment, based on `f3c6f8d9`. Next: audit `channel-proof` run `39364385408` at `16adc74b`, fix every failure,
and preserve the recorded comparison with PR #175's integrated measurements. Count run `39363807189` passes both hosts; its saved C and actual
machine code are inspected. Do not change the primary PR while its gates run.
Keep it separate while PR #175 is being validated; do not open another PR yet.
The inventory/schedule repair is included here. Final PR #175 production is
`39363423392`, documentation `39363423384`; its unchanged compiler/runtime has
focused ownership `39362626916` and counts `39362629293` at `f3c6f8d9`.
Superseded production `39359123801` and `39362628332`, focused `39361329677`
and docs `39362628337` were cancelled to free runners. Review their completed
portions for additional failures; cancelled checks are not acceptance.

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
No new syntax or runtime helper is added. [The count experiment](measurements/channel-loop-state.md) now passes on both
Linux hosts, with 180 audited samples: one fewer allocation per message in all
five cases, one fewer retain for fresh/closed values and two fewer for shared
values. Every ARC profile ends with zero charged storage. Cleanup and complete
platform acceptance remain pending; counts are not timing results.

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

The guarded report audit (`scripts/summarize-channel-costs.py --run 39363807189
--source 16adc74bc668312a60169a0c84f030fdac19ba49 --artifacts
/private/tmp/fwp-channel-loop-costs --output /private/tmp/fwp-channel-loop-counts.json`)
passes in 1.61s. Pending edits only document those results and correct stale
ownership comments; the measured compiler implementation remains unchanged.

PR #175's integrated count run `39362629293` also passes both hosts; its 180
samples were audited under the guard in 1.54s. Counts and managed memory match
the earlier tap experiment; binary sizes change with collector exclusion. The
new report compares like-for-like integrated sources. ELF inspection confirms
all five code sections shrink on both hosts, despite the AMD64 closed-function
file growing 4136 bytes due to unwind metadata and data-page alignment. The
document's example passes raw interpretation in 0.86s.

Review found an inline import in `tests/resource_frame_fields.rs`; it now sits
at the top of the file. The `fields` evidence suite uses GCC on Linux, matching
production. Run it on Linux ARM64 and AMD64 for the candidate: it checks retained
resource frames and match contexts as well as worker entry, field movement and
failure cleanup. Other suites retain their established compiler settings.
