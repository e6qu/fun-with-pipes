# Session handoff

## Next action

The user merged [PR #176](https://github.com/e6qu/fun-with-pipes/pull/176) as
`90f0ab9f6b30da75682f598ef5afd8f9fef7bfed` before production CI completed.
Its tree equals `ddff413a`; its message is one line with no trailers. Keep its
original production run `39371117507` running and fix any failures. Its focused
checks, benchmark gate and documentation pass; platform acceptance is unfinished.
Future merges still require all final-head gates, an explicit one-line subject
of at most 80 characters and empty body.

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
`unbox-channel-receives`, prepares the next change independently. Next: finish the struct-return comparison, audit focused ownership
`39371669060` on `78dc983e`, then publish the complete next delivery from merged
main. Fix every failure; #176's unfinished acceptance is still required evidence.

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
Linux Clippy and callback-effect checks pass; native/WASI ownership and counts
are still running. Review also found the
uncounted tracing receive removed its message before allocating `Some`; it now
reserves the result first, with a forced-failure/retry regression. Runs
`39371506883`/`39371509365` at `c4cc467d` were still entirely queued when replaced
to include this repair, so they provide no execution evidence.

The saved diagnostic interpreter rejects the new unannotated callback pipe with
an effect-row mismatch. An explicitly typed intermediate function runs with the
expected output (guarded 0.86s), but is not used to conceal the issue. The original
pipe remains in the fixture and callback-effect regression; the current compiler is checked independently on runners.
Both Linux callback-effect gates now pass on `78dc983e`, including the original
expression: the accepted compiler's repair already handles it. No new wrapper or
inference workaround was added. No local compiler build was run.

The [receive report](measurements/channel-receive-results.md) records the first
180 audited samples (guarded audit 1.54s), code sections and actual frames.
Text receives save one allocation per message; function-message counts do not
change. The receive helper's 16-byte frame increase motivates a two-word struct
return experiment. Its compiler/runtime/tests are changed locally, not measured
yet. Guarded formatting passes (1.76s). The previous measured revision is retained
as a revision tag before publication.

Duplicate post-merge runs `39372193646` and `39372193575` were cancelled only
after verifying #176's identical tree. Its original acceptance remains running.
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
mutual recursion need further proofs. Direct receive results are measured in this preparation, but full native/WASI
cleanup checks and final production acceptance remain required. JIT is excluded.
Follow [AGENTS.md](../AGENTS.md): one active PR, final-head gates, bounded local
work and one-line commits without trailers.
