# Session handoff

## Next action

Next: finish [PR #176](https://github.com/e6qu/fun-with-pipes/pull/176), the only
active PR, on `flatten-channel-loop-state-delivery`. Require all nine production
jobs and documentation on its exact final head. Focused checks below pass;
full acceptance starts when this PR is marked ready. Fix every failure, audit completed
logs, then squash merge with an explicit one-line subject of at most 80 characters
and empty body. Verify the merged tree/message before cancelling redundant runs.

[PR #175](https://github.com/e6qu/fun-with-pipes/pull/175) is accepted as
`b9cfbbe656baacf30864c8a84b0184ca683ff5b6`, the base of this branch.
All nine production jobs `39363423392` and documentation `39363423384` passed
on tested head `6511a50f`. The merge has the same tree and a verified 58-character
subject with no body or trailers. Redundant post-merge runs `39370566486` and
`39370566329` are cancelled. [History](roadmap-history.md#function-queues-and-cheaper-sends-pr-175)
records the accepted queued-function proof, consuming sends and `tap` optimization.
Do not reopen their preparation branches as new work.

## Receive-result preparation

This worktree `/private/tmp/fwp-channel-receives`, branch
`unbox-channel-receives`, prepares the next change independently. Do not open a
second PR or move PR #176's stable head. Next: run focused ownership and count
checks on this preparation; fix all failures before making any support claim.

The shared-text loop still allocated `Some message` after each receive. The
candidate gives immediately matched receives their tag and payload directly,
using the existing variant-field cleanup machinery. Generic callers retain boxed
Options. An explicit runtime result-form argument selects the representation;
both forms share the receive loop. Boxed allocation still precedes dequeue so a
failed allocation leaves the message available for retry. No new surface API,
tracing fallback or primitive ownership-contract change is introduced.

Tests extend cancellation/close coverage to both result forms, check zero-valued
messages separately from empty results, verify timed ready/empty receives, and
confirm that direct fields move one owner without allocating an Option. Existing
boxed allocation-failure and negative cleanup controls remain. The shared native
and WASI fixture adds timed function receives and a failure after calling one.
These changes are not yet compiled or verified on runners. Review also found the
uncounted tracing receive removed its message before allocating `Some`; it now
reserves the result first, with a forced-failure/retry regression. Runs
`39371506883`/`39371509365` at `c4cc467d` were still entirely queued when replaced
to include this repair, so they provide no execution evidence.

The saved diagnostic interpreter rejects the new unannotated callback pipe with
an effect-row mismatch. An explicitly typed intermediate function runs with the
expected output (guarded 0.86s), but is not used to conceal the issue. The original
pipe remains in the fixture and callback-effect regression; runner checks will
establish whether the accepted compiler's existing inference repair handles it.
Any remaining inference defect must be fixed. No local compiler build was run.

Production PR #176 run `39371117507` is in progress on `ddff413a`;
documentation `39371117707` passes. The draft synchronization run `39371117777`
skipped its jobs and is not acceptance. All seven roadmap areas remain open.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open.

| Step | Status | Work |
|---|---|---|
| 1 | In progress | Ownership and GC removal |
| 2 | In progress | Functional overhead |
| 3 | In progress | Machine performance |
| 4 | In progress | Autodiff |
| 5 | In progress | Numerical kernels |
| 6 | In progress | Reproducible comparisons |
| 7 | In progress | Larger applications |

Persistent subscriptions, resource captures, resource-owning tail frames and
mutual recursion need further proofs. Shared-text channel exchange still allocates
its receive result; removing it would need evidence for failure, cancellation and
call boundaries. That change is not implemented in this delivery. JIT is excluded.
Follow [AGENTS.md](../AGENTS.md): one active PR, final-head gates, bounded local
work and one-line commits without trailers.
