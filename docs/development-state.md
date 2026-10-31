# Current work

**Next:** implement the authorized lexical-binding package, then its compiler,
macro, tooling and tutorial integration before the consolidated validation batch.
The user approved all ten steps in the revised PLAN.md. New syntax is in progress,
not verified support; do not publish examples as runnable until checks pass.

Worktree: `/private/tmp/fwp-returned-callables`; branch `language-design-review`,
based on merged main `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`. Draft [PR #236](https://github.com/e6qu/fun-with-pipes/pull/236) is the sole active PR.
The primary checkout has unrelated preserved work; do not reset it.

## Latest delivery

The user merged [PR #235](https://github.com/e6qu/fun-with-pipes/pull/235).
Its merge tree `9eda0ac6113d18741d9b0f85c1dcadbba409b2ac` exactly matches tested
head `adeb9794544cd12deae3f7050fef79cf874a3f55`. The merge subject is one line,
61 characters, with no body, trailers or attribution.

All nine jobs in production run `41229416050` pass:

| Coverage | Job IDs |
|---|---|
| Linux ARM64 / AMD64 | `124620261881` / `124620262099` |
| macOS ARM64 regular / ownership | `124620262003` / `124620262156` |
| macOS AMD64 regular / ownership | `124620261993` / `124620262192` |
| Windows ARM64 / AMD64 | `124620261994` / `124620262055` |
| C/Rust benchmarks | `124620261780` |

Documentation run `41229416071`, job `124620261925`, also passes, including
nine phase, six context and six paired-record tests. Completed logs are audited:
all production test summaries pass, with no unexpected compiler diagnostics.
Windows scheduler panics and documentation runner failures are deliberate
negative controls, checked against their source/log context. The earlier
unstarted runs `41229143323` and `41229136089` were cancelled before the wording
repair; they are superseded, not pending work.

## Current implementation

The initial implementation adds source fn/let nodes, named and record patterns, lexical
monomorphic inference, resource duplication/capture constraints, and lifted
functions with explicit capture parameters. Quote/format traversal and initial
regressions are included. The first focused run `41242796910` failed compilation on all three platforms: the macro record-pattern decoder moved a field out of a value with a destructor. All failed steps were audited; none reached language tests. The repair borrows that field, validates macro-created patterns, captures lexical syntax in templates, and fixes scope-aware linting and pipe formatting. Support remains unverified. Documentation run `41242798221` passes.
Still required: finish macro/capture edge cases, formatter/tooling, ownership tests,
full documentation/tutorial audit and the remaining optimization batches.

Use `fn pattern -> body` and `let pattern = value in body`. Bindings are immutable,
strict and nonrecursive. In fn/let, `_` discards; existing match holes still forward
their values to arm bodies. Record patterns are irrefutable field selections.
The handoff changes from the previous design-review turn are preserved.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Complete and verify local bindings, named inputs and patterns |
| 2 | In progress | Update all syntax consumers, tooling and teaching material |
| 3 | Pending | Prove and measure named/tacit direct-call and capture equivalence |
| 4 | Pending | Extend measured borrowing/move cases |
| 5 | Pending | Extend direct tuple/record/variant representation |
| 6 | Pending | Extend eligible collection pipeline removal |
| 7 | Pending | Select and verify remaining numerical loop work |
| 8 | Pending | Attribute and remove a demonstrated derivative cost |
| 9 | Pending | Complete Swift attribution and qualified comparisons |
| 10 | Pending | Integrated application and final-head delivery gates |

## Performance and memory evidence

GC removal is verified; broader ARC minimization remains incomplete.
[Callable phases](measurements/callable-phases.md) retain the Swift/C/Rust
comparison, all raw archives and the original three AMD64 construction failures.
All eight original RAM limits pass. Swift allocation/count attribution is missing;
RSS and phase times do not isolate ARC cost. No production runtime patch was
justified by the constructor investigation.

Inside-one-process run `41225841156` at diagnostic source `73707460` passes
collection on ARM64 `124609688723` and AMD64 `124609689465`. ARM has 32 qualified
and four short phases; AMD has 19 qualified and 17 inconclusive phases on a
different CPU. All twelve AMD construction phases miss the duration floor.
Both hosts show order effects even without calls. Preserve original failures;
any new study needs explicit CPU qualification and work counts frozen through
reference-only calibration. Do not retry unchanged runs or relax thresholds.

D2/N1 timing acceptance and broader B1/B2/V1/V2 work remain open in [PLAN.md](../PLAN.md).
Selected count/allocation reductions remain verified independently of timing.
Prioritize removing intermediate storage, extending proved borrowing and direct
representations, and measuring numerical/AD work against equivalent peers.

## Local limits

Full builds, suites and benchmarks run on GitHub. The unchanged guard admits
this batch's focused checks: `cargo fmt --all` passes (CPU 1.05 s / 1.94 s elapsed);
`python3 scripts/test-native-test-runner.py` passes 21 tests (9.25 s elapsed),
including complete coverage for the new `local_bindings` target. The frozen
primitive inventory passes: 394 declarations, 384 symbols, no review symbols.
`python3 scripts/check-roadmap.py` passes 192 doc link sets, 106 immutable pairs
and ten roadmap steps (3.63 s elapsed). Inventory output is
`/private/tmp/fwp-lexical-inventory/candidate.json`. The first formatter attempt
could not sample `ps` inside the sandbox; rerunning the same guard with approved
process access passed. No resource limit was raised. Do not run full builds or
saved measurement executables locally.

Earlier byte-preserving APFS deduplication recovered about 1.2 GiB; all ten older
checkout statuses and the primary checkout were preserved. Earlier whole-program
Swift raw artifacts still expire in January 2027; their checked-in summary is not
a complete archive. The callable raw archives are retained in the repository.
