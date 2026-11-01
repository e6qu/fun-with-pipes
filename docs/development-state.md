# Current work

**Next:** audit focused run `41359574645` on GCC Linux ARM64/AMD64 and Clang
macOS ARM64. If compilation and focused controls pass, dispatch
`record-fold-measurements` for all six count/memory cases and the added unwind
controls. Audit those results before dispatching `record-fold-time`, then run the
complete final matrix. Fix all observed failures together before another push.

[Draft PR #240](https://github.com/e6qu/fun-with-pipes/pull/240) uses branch
`derivative-record-callbacks` in `/private/tmp/fwp-returned-callables`.
Preserve unrelated edits in the primary checkout. Compiler source is unchanged
since `0c404719`; `dbe3d39f` adds unwind controls and count requirements.
This batch adds same-source timing/audit support and clearer design examples.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Source/count audit verifies all 96 observations and 48 C hashes; input/pair results escape into lists, addition accumulators stay within the fold |
| 2 | Verified | Preparation `7b300717` and tag `roadmap/derivative-record-fold-protocol-2026-11-02` freeze selection and requirements before compiler edits |
| 3 | In progress | Direct numeric-record left fold, alias/empty/effect tests, physical-release controls, traps, allocation failure and cancellation implemented; native results pending |
| 4 | Pending | Native counts and paired timing evidence, all nine final production jobs and documentation; squash merge |

## Candidate and CI

The [protocol](measurements/derivative-record-folds.md) defines selection, exact
budgets, reference compiler, workflows and acceptance. [Design](design.md#numeric-record-fold-accumulators)
explains the transformation with an example. No new savings or speedup is verified.

Focused run `41359574645` tests source
`0c404719ce7e339440cea6c1ed2e0b124cc02b26`. At 23:11 UTC November 1 all three
jobs remain queued, with no executed steps or failures:

| Native host/compiler | Job |
|---|---|
| Linux ARM64/GCC | `125006882519` |
| Linux AMD64/GCC | `125006882790` |
| macOS ARM64/Clang | `125006882685` |

Do not restart this queued run for documentation/tool changes: its compiler is
current. Superseded run `41359119118` was cancelled before execution. New unwind
probes in `dbe3d39f` will run in count measurements and final production CI.
Draft PR production jobs are skipped intentionally; skips do not count as support.

Candidate checks cover 512 count/alias/size combinations per native image,
384 unwind combinations per image, and seven excluded shapes/calling conventions.
Deliberately omitted seed/result releases must fail. Seed destructor registration
now precedes destructor emission, including callbacks without generic entries.
The caller retains list owners and existing exceptional-exit cleanup.

## Local verification

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
