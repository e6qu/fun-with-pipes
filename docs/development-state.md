# Session handoff

## Next action

Next: finish [draft PR #178](https://github.com/e6qu/fun-with-pipes/pull/178) on
`simplify-local-match-inputs`. Verify the batched test repair in a new channel count/effect run, inspect actual C and
binaries, then run all nine production gates and documentation on the final head.
Fix all failures. Squash merge only after acceptance, with one explicit subject
of at most 80 characters and an empty body.

## Accepted baseline

The user merged PR #177 as `44f9eb6eeb787df378b159b33f113bffd69b216e`.
Its tree equals tested head `a5828518f92da3112fde13157a0dcc964d6c3cb9`;
the merge message is one line without trailers. All nine production jobs
`39374128066` and documentation `39374119890` pass. PR #176's retained production
`39371117507` and documentation `39371117707` also pass. All 20 complete logs
were audited with hashes in `/private/tmp/fwp-176-177-acceptance.json` (37.42s).
Only duplicate post-merge PR #177 production `39393021237` was cancelled;
post-merge documentation `39393021033` had already completed.
[History](roadmap-history.md) records the completed deliveries and source IDs.

[Receive measurements](measurements/channel-receive-results.md) are the baseline:
fresh-text allocations 1/message, shared text 0, fresh functions 5, shared functions
3, closed functions 2. ARC retains remain 2/4/3/7/1 respectively. Counts use the
finite difference from 16 to 1024 messages, not a universal cost model or timing.
The selected struct reports are from source `a44d52a1`, run `39372647179`.
Artifacts remain under `/private/tmp/fwp-channel-receive-struct-costs`.

## Current work

Generated C shows the function-message receive wrapped in a temporary tuple
alongside a partially applied callback. That hides both the direct match and the
known callback. Extend the existing tuple-match simplification: bind nontrivial
fields once, in order, using their checked types, then match the tested field.
Do not change patterns that inspect multiple fields or whole tuple values.
Original resource scopes retain their protection.

Review also found the old simplification considered arity-zero function entries
trivial, although they evaluate constants and can trap. Regression cases cover
ignored and ordered constants, effects in unused fields, both Option branches,
and a known callback becoming a direct call. The source examples use tacit hole
patterns; holes supply arguments to the arm's function, not named variables.

## Checks and resources

Guarded `cargo fmt --all` passes (1.63s). A saved diagnostic compiler verifies
only the new example's raw interpreter syntax/output (0.95s): `5`, `0`, `left`,
`right`, `4`. Its first syntax attempt used unsupported named patterns; corrected
to tacit holes before publication. This older binary does not verify new compiler
behavior. Current code, native cleanup and count savings still need runner checks.
Both complete logs for first run `39394019143` at `a3baa690` were audited.
The only failure on each host was the new test enabling tracing stress for ARC;
the runtime correctly rejected that setting. The repair explicitly enables GC
stress/verification only in tracing mode, with reuse checks in both. It also adds
the direct IR regression for an ignored trapping constant. All other completed
targets and both count steps passed, but the failed workflow is not acceptance.
Exploratory ARM64 counts show fresh-function allocations 5 → 2 and shared-function
allocations 3 → 1, each with one fewer retain; other cases are unchanged. Repeat
and audit on a passing run before publishing those as the selected result.
The raw-example audit passes (5.40s); its temporary script first needed a blank-line
parsing correction. No compiler or runtime change was needed for either check fix.

Use `python3 scripts/local-guard.py COMMAND...` for focused serial checks.
No local build was run. Full builds, native compilation, suites and measurements
belong on runners. Preserve 64 GiB free disk, generated target data below 2 GiB,
and sampled aggregate RSS below 1 GiB. Stop on guard limits, never raise them.

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
mutual recursion still need proofs. Default native execution retains tracing;
zero additional shared-text allocations do not eliminate setup storage or ARC.
JIT is excluded. Follow [AGENTS.md](../AGENTS.md).
