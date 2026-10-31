# Current work

**Next:** publish the array-to-list traversal candidate and dispatch
`array-list-measurements`; audit every completed job before further repairs.
Continue Swift allocation attribution and the remaining documentation review
while those numerical checks run. The user authorized all ten steps in
[PLAN.md](../PLAN.md), in draft [PR #236](https://github.com/e6qu/fun-with-pipes/pull/236).

Worktree: `/private/tmp/fwp-returned-callables`; branch `language-design-review`,
based on main `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`.
Preserve unrelated changes in the primary checkout. No final production matrix
has run for this PR; draft production skips are not acceptance.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Implemented | Preserve scope, effects and strict stages through integration |
| 2 | Implemented | Finish whole-repository documentation audit |
| 3 | Implemented | Preserve eight named/tacit cost pairs through integration |
| 4 | Implemented | Preserve alias, failure and zero/one-retain String loops |
| 5 | Implemented | Preserve four direct-representation probes |
| 6 | Implemented | Preserve named range/map/filter and eager-stage controls |
| 7 | In progress | Verify direct numeric array traversal and allocation limits |
| 8 | In progress | Measure gradient-list savings and full solve/phase costs |
| 9 | In progress | Original Swift archive retained; allocation attribution remains |
| 10 | Pending | Integrated applications and final-head production gates |

## Implemented language and ownership changes

Strict immutable `let`, single-input `fn`, named match patterns, tuple/record
destructuring and record shorthand work with explicit captures and monomorphic
local inference. Macros preserve scope and quote stages. Formatter, editor
navigation/rename, debugger and notebook dependencies recognize local names.
Tutorials and the reference introduce each concept before using it.

Local bindings expose known calls, immediate record/variant destructuring and
single-use ranges to existing optimizations. Flat loop fields remain visible to
ownership analysis; final moves may wait through proved borrows. Named input
annotations prevent the caller's IO from changing a pure callback parameter.
Curried stages preserve initializer effects, failures and resource release.

## Published verification

Head `a61addc640793a54f4bef19d4e2110bbc3196a54` passes focused run
`41251272638` on Linux ARM64/AMD64 GCC and macOS ARM64 Clang. All completed
targets and compiler diagnostics are audited: no unexpected warnings or failures.
This includes 54 RC unit tests, eleven REPL cases, all language/ownership targets,
tutorial programs and source copies, Python tools and the raw interpreter corpus.
The String loops meet zero/one-retain limits at 0/32/128; the other six new cost
cases and eight original named/tacit pairs also pass. Counts are not timings.
Logs: `/private/tmp/fwp-236-a61-{amd,arm,mac}.log`.

Documentation `41251273915` passes. Its deliberate failing-runner controls are
expected inside passing tests, not hidden failures; full log is
`/private/tmp/fwp-236-a61-docs.log`. The three failures in `41250023104` are repaired:
loop field/move visibility, pure callback input inference and an invalid affine
File fixture (replaced by a shareable socket disposal test). Earlier saved-REPL
closure, workflow-heading and evidence-reader failures are also repaired.

Swift retention `41251278856` passes all four original audits. Archive
`docs/measurements/swift-peers-2026-10-31.tar.xz` retains sources, commands,
reports and binaries from original measured source
`80a0504a97f7c96291e77be6e8f843d5cb8c7391`, run `41214191081`.
Its SHA-256 is `8ddb06a630969718322cacd10e3a3472f7e0da1c5da97106b8c0090806604118`.
The local audit recomputes timings and memory samples without executing binaries.

## Numerical candidate awaiting runner verification

`src/fuse.rs` directly traverses numeric arrays beneath eligible list map/filter
and fold stages, retaining actual floating conversions and arithmetic order.
The [protocol](measurements/array-list-traversal.md) freezes inputs and limits
before observations. New native probes use dynamic arrays, retained slices,
packed/word storage and O1/O2. Semantics controls cover rounding/NaNs, aliases,
eager effects, distinct traps and early stopping. Existing AD ownership and
precision targets accompany whole-solve measurements on both Linux architectures.
No count, timing or correctness claim is accepted for this new candidate yet.

`array-list-measurements` compares the same compiler with numeric array fusion
explicitly enabled/disabled. It measures six whole-solve cases and six runtime
phases, including original copy/noise controls. The final gradient list lies
outside those phase clocks; whole-solve allocation savings cannot be called a
recording-time reduction. Original D2 and N1/N2 timing requirements remain open.

## Local checks

All checks use the unchanged resource guard. No full compiler build ran locally.
Full builds, suites and benchmarks stay on runners; never raise local limits.

| Check | Result |
|---|---|
| `cargo fmt --all`, `git diff --check` | Pass |
| Workflow actionlint | Pass |
| `scripts/test-native-test-runner.py` | 21 pass, including target coverage |
| Frozen primitive inventory | 394 declarations, 384 symbols, no review symbols |
| `scripts/check-roadmap.py` | 192 doc link sets, 106 preparation pairs, ten steps pass |
| Standalone production parser/formatter | 17 tests and tutorial/new fixture round trips pass |
| Tutorial source copies and library reference generator | Pass |
| `scripts/test-collection-evidence.py` | Eight pass; new numeric test count included |
| `scripts/test-descent-budgets.py` | Nine pass, including exact new savings/timing limits |
| `scripts/test-swift-peer-records.py` | Five pass, including retained archive recomputation |

Standalone harnesses live under `/private/tmp/fwp-236-*`. They use Rust O1 with
assertions/overflow checks and do not verify inference, lowering or native output.

## Verified baseline and remaining evidence

The user merged [#235](https://github.com/e6qu/fun-with-pipes/pull/235). Its tree
`9eda0ac6113d18741d9b0f85c1dcadbba409b2ac` matches tested head
`adeb9794544cd12deae3f7050fef79cf874a3f55`. Production `41229416050` passes all nine
jobs; documentation `41229416071` passes. Completed logs are audited. The merge
subject is one line, 61 characters, with no body/trailers. Duplicate postmerge run
`41241035081` was cancelled after confirming this identity. Old run `38888712709`
listed all jobs as finished; GitHub rejected cancellation because it was complete.

GC removal is verified; broader ARC minimization remains incomplete. The
[callable measurements](measurements/callable-phases.md) retain all eight passing
RAM limits and the three original Xeon construction regressions (8.6–16.1%).
Swift allocation/count attribution is missing; RSS does not isolate ARC cost.
The separate paired run `41225841156` has 32 qualified/four short ARM phases and
19 qualified/17 inconclusive AMD phases on a different CPU. All twelve AMD
construction phases are too short. Preserve those limits and failures; do not
retry unchanged experiments or claim the different CPU settles the regression.

D2 derivative timing and N1/N2 kernel timing acceptance remain open. Verified
count/allocation reductions are independent of those timing failures. No runtime
patch was justified by the constructor investigation. Follow the ten concrete
steps in PLAN.md rather than reimplementing completed GC/ARC milestones.

Callable and whole-program Swift raw archives are checked in; their audit
recomputes original results without executing retained binaries. Earlier APFS deduplication
recovered about 1.2 GiB without changing any checkout's contents or status.
