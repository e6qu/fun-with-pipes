# Current work

**Next:** audit focused run `41369894377` and count run `41369934860`, both at
`a690733e88790c20261f21dcf24f601aefe5e73c`, for [PR #241](https://github.com/e6qu/fun-with-pipes/pull/241).
The unchanged compiler allows count/cleanup checks alongside the fixture repair.
Once complete, use `record-fold-count-report` to audit both archives on GitHub;
then run paired `record-fold-time` and final production CI.
Keep the frozen requirements and earlier failed timings unchanged.

Branch `numeric-fold-validation` starts at merged #240 (`5fbd6bea`) in
`/private/tmp/fwp-returned-callables`. Preserve unrelated primary-checkout edits.
No compiler change has been made since `0c404719`; this batch fixes coverage,
clarifies the selection boundary and completes the outstanding validation.

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
The design example now states this limitation. No compiler repair is yet indicated.

The [protocol](measurements/derivative-record-folds.md) defines exact count,
cleanup, code/stack and timing budgets. Whole-solve savings and speed remain
unverified. Do not repeat unchanged noisy timing runs to seek a pass.

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
