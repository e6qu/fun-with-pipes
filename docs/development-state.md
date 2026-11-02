# Current work

**Next:** publish the `attempt` specialization repair and run the expanded
`record-fold-checks` suite (now including `call_effects`). Audit count run
`41369934860` at `a690733e` independently; verify updated-compiler counts before
paired timings and the final matrix. [PR #241](https://github.com/e6qu/fun-with-pipes/pull/241)
contains all repairs, measurements and remaining validation.

Branch `numeric-fold-validation` starts at merged #240 (`5fbd6bea`) in
`/private/tmp/fwp-returned-callables`. Preserve unrelated primary-checkout edits.
The fold codegen is unchanged since `0c404719`. This batch repairs its fixtures
and extends the existing known-callback specializer to `attempt`, keeping captures
outside and callback execution inside the handler. Native repair checks are pending.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Source/count audit verifies all 96 observations and 48 C hashes; input/pair results escape into lists, addition accumulators stay within the fold |
| 2 | Verified | Preparation `7b300717` and tag `roadmap/derivative-record-fold-protocol-2026-11-02` freeze selection and requirements before compiler edits |
| 3 | In progress | Native allocation/release controls pass; repair semantic fixture selection and verify added failure/cancellation probes |
| 4 | Pending | Native counts and paired timing evidence, all nine final production jobs and documentation; squash merge |

## Merged implementation and active CI

The user merged #240 as `5fbd6beab2087f003eb8a1f45461e1fbaba71fd2`.
Its tree `5d460780aecbb876360dc42cc1b8e4a81fad5da7` matches final PR head
`20deddfdcdba4ca1087637997ee1a0cee31c3dc6`; the squash message is one line,
under 80 characters, with no body/trailers. Documentation `41361067737` passes.
Full production run `41369348762` started at merge time. Its benchmark job
passed and was audited; remaining jobs were cancelled before completion because
the head contains the known failing semantic fixture. No other failed step or
completed job was reported at cancellation. Run one final matrix for #241 after
focused repair checks and measurements finish; cancelled jobs establish no coverage.
Duplicate post-merge production `41369360785` was cancelled after verifying tree
identity and no failed jobs. Post-merge documentation `41369360748` remains enabled.

Focused run `41359574645` at `0c404719` completed with the same sole failing
test on all three hosts:

| Host/compiler | Job | Result |
|---|---|---|
| Linux ARM64/GCC | `125006882519` | 22 passed, one semantic selection assertion failed |
| Linux AMD64/GCC | `125006882790` | Same |
| macOS ARM64/Clang | `125006882685` | Same |

All seven target logs and compiler diagnostics were audited. Formatting/lint,
512 count/alias/size combinations per image, omitted-release controls, exclusions,
worker preparation/boxing and derivative precision/nesting/scope tests pass.
The new record-fold unwind test in `dbe3d39f` was not part of this older run.
Logs: `/private/tmp/fwp-240-focused-{arm,amd,mac}.log`.

Root cause: the semantic fixture destructured an accumulator before its next
`fn`, leaving a returned closure and boxed worker result. That is excluded by
the direct-worker contract. Generated C from the retained compiler confirms the
call path. The repaired fixture uses field projections for all three selected
callbacks, retains a destructured semantic comparison and shares the seed within
its input list. Managed/nested/wide and other excluded cases now isolate their
intended boundary. Source/C and native outputs are retained for future failures.
The design example now states this limitation. The first repair exposed a second missing boundary, described below.

The [protocol](measurements/derivative-record-folds.md) defines exact count,
cleanup, code/stack and timing budgets. Whole-solve savings and speed remain
unverified. Do not repeat unchanged noisy timing runs to seek a pass.

## Follow-up results and compiler repair

Focused run `41369894377` at `a690733e` completes on all three native hosts with
23 passed tests and one failed assertion: only two of the three expected fold
helpers were selected. Exact counts, reuse, traps, allocation failure and real
cancellation pass. Logs: `/private/tmp/fwp-241-focused-{arm,amd,mac}.log`.
AMD64 artifact `13108972861` SHA-256
`41628f3ca84c555d603f64e701cef1eb660852d6f1faf967254d3f7626624b75` retains the
failed generated source at `record_fold_values/stack-0.c`.

That C shows `attempt (fold fail-step seed)` using the generic fold entry.
`attempt` was missing from `rewrite_hofs`' existing synchronous-handler selection.
The repair adds it there, preserving handler creation and capture evaluation.
Keep the stronger three-helper assertion. `call_effects` now compares raw and
optimized interpretation with native O0/O1/O2, including capture/input order and
capture failure caught by an outer handler. New fixture outputs match the retained
raw interpreter (0.24s); formatting passes (1.99s).

Count run `41369934860` uses the pre-repair compiler at `a690733e`.
AMD64 job `125038021591` passes all six inputs/forms/O1/O2/workspace observations
and unwind controls; complete log audit finds no warnings or unexpected failures.
ARM64 job `125038021895` is still running. Use `record-fold-count-report` with
that run and exact source to independently verify archives on GitHub; preserve
this pre-repair evidence. Do not label it verification of the changed optimizer.

## Local verification

Follow-up checks: count-audit workflow lint passes (5.34s), embedded Python
parses (0.13s), and refreshed roadmap audit passes (3.13s).
All ten revised fixture sources type-check (1.86s); the retained
compiler emits direct record-returning workers for all three selected callbacks
and prints expected values (0.36s). These verify the fixture repair, not the new
fold helper. Formatting passes (1.98s); roadmap links/status pass (3.13s).
Production benchmark job `125036266818` passes with no unexpected diagnostics;
its allocation-failure and deliberately omitted-release controls pass. Log:
`/private/tmp/fwp-240-production-bench.log`.


All commands use `python3 scripts/local-guard.py`; no candidate compiler build,
full native suite or benchmark has run locally. Keep those workloads on GitHub.

| Check | Result |
|---|---|
| Source/count audit | 96 observations, 48 C hashes and both archive hashes pass; 0.24s |
| Corrupt audit controls | Five altered source/count inputs rejected; 0.97s |
| `cargo fmt --all -- --check` | Pass; 1.88s |
| `scripts/test-derivative-ownership-profile.py` | 10 tests pass, including each count budget boundary; 13.03s |
| `scripts/test-record-fold-reference.py` | 3 exact-patch controls pass; 0.13s |
| `scripts/test-descent-budgets.py` | 11 timing/count/layout controls pass; 0.13s |
| `scripts/test-array-list-evidence.py` | 9 retained-evidence and exact-patch controls pass; 49.74s |
| `actionlint` on the two edited workflows | Pass; 5.74s |
| `scripts/test-descent-groups.py` | 12 retained-report controls pass; 6.21s |
| `scripts/test-retain-derivative-evidence.py` | 3 download/host controls pass; 0.13s |
| `scripts/check-roadmap.py` | 198 link sets, 106 preparation pairs/tags, four plan steps pass; 2.96s |

All ten new fwp fixture sources type-check with the verified #239 macOS ARM64
compiler; raw interpretation prints the expected alias/empty/scalar/error results.
This checks fixture validity, not changed compiler behavior. Commands:
`/private/tmp/fwp-240-check-fixtures.py` (1.66s), raw interpreter (0.25s).
Package directory: `/private/tmp/fwp-240-baseline-macos/`; artifact `13098119213`.
ZIP SHA-256: `505952c57b3203075452526493a60c401775c7fa7305013b8658af85a81b305f`;
compiler SHA-256: `6ae32e315ded657cb8e7b5d9b518fc337d527204bf2164733c9c4c273c6cb3b3`.
Both match the final #239 manifest.

## Verified baseline and unresolved results

PR #239 merged as `1f35824928abc2d468a469c03622f095ce2a4742`, with the exact
tested tree of `9e326ce8db9ba5d0b404c1d9b77641c9e51fd484`.
All nine production jobs `41342124001` and documentation `41342116834` pass;
post-merge documentation `41351222111` also passes. The squash subject obeys the
one-line, 80-character limit with no body/trailers. Redundant production run
`41351222101` was cancelled after verifying tree identity and no failed steps.
[History](roadmap-history.md#numeric-record-zipmap-fusion-pr-239) records delivery;
[measurements](measurements/derivative-forward-costs.md) retain the evidence.

The user accepted #239's allocation reduction with ten timing limits still open:
eight one-update cases miss 5%; AMD64 zero-update is 2.54–2.72% slower.
D2 remains open. Preserve these outcomes and original thresholds. Do not rerun
unchanged noisy timings to seek a pass or make speculative allocator changes.

Saved count inputs for #240: source `b094fdd8`, run `41324329567`, summary
`docs/measurements/derivative-record-zip-counts-2026-11-01.json.gz`, archives
`/private/tmp/fwp-239-record-derivative-forward-evidence-{aarch64,x86_64}.zip`.
Largest ARM64 generated-C SHA-256:
`b820f990003376116f544c3d638688543ad6154519da34c879444e7eb4aa700a`.
Final #239 logs: `/private/tmp/fwp-239-final-*.log`; detailed audit:
`/private/tmp/fwp-239-delivery-handoff.md`. Preserve current evidence and worktrees.
