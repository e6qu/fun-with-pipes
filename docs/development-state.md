# Current work

**Next:** publish the repaired native-call probes and independent evidence audits,
then check those probes and retain the original/repaired measurements. Next
verify two numerical sessions per architecture on the integrated compiler and
run the final production matrix. The user authorized all
ten steps in [PLAN.md](../PLAN.md), in
draft [PR #236](https://github.com/e6qu/fun-with-pipes/pull/236).

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

## Numerical candidate and root-cause repair

`src/fuse.rs` directly traverses numeric arrays beneath eligible list map/filter
and fold stages, retaining actual floating conversions and arithmetic order.
The [protocol](measurements/array-list-traversal.md) freezes inputs and limits
before observations. New native probes use dynamic arrays, retained slices,
packed/word storage and O1/O2. Semantics controls cover rounding/NaNs, aliases,
eager effects, distinct traps and early stopping. Existing AD ownership and
precision targets accompany whole-solve measurements on both Linux architectures.
The first candidate `dc0a6407b5e5aa23517a86db71a3221a418cc7d6` fails the new
allocation limit. Numerical run `41252379702` session 1 is fully audited on both
Linux architectures: 33 tests pass, one cost test fails. At length one the mapped
list saves only 16 bytes; at length 129 it still creates 258 list cells. Retained
C shows a reversed result followed by the borrowing `reverse` primitive, which
copies it. Direct folds allocate nothing. Original requirements are unchanged.

Published `9a2e954e` visits a numeric array backward only for list results
whose callbacks are total/pure and whose captures are scalar. Prepending builds
the final list directly. Folds and potentially trapping/effectful callbacks keep
forward order. New cost diagnostics collect both storage modes before failing.
Focused `41252383957` also fails only the same cost test on all three hosts.
All completed logs and diagnostics are audited; other targets, tutorials, Python
tools and the raw corpus pass without unexpected warnings.
Documentation `41252374022` passes and its completed log is audited. Both original
session-2 timing jobs in `41252379702` have finished. All six cases pass timing,
copy, raw-tape, cleanup, code/stack and phase controls; both list forms fail the
allocation/byte limits in all five updated cases (20 failures per host).
Both logs are audited. Artifacts: ARM `13062585975`, AMD `13061623214`.

At `9a2e954e`, numerical run `41253549233` session 1 fails only the list probe on
both hosts. It now reaches packed slices: the probe frees the view header without
releasing its backing owner and exits 181 at length 129. Word-array cases pass
O1/O2 cost limits. The repair published at `a33c8ba9` calls an exported typed array destructor
for inputs/backing arrays. All word/packed, offset-slice and alias controls now
pass O1/O2 on Linux ARM64/AMD64 and macOS ARM64. No runtime patch or relaxed
limit was needed.
Both numerical logs and focused logs from `41253554264` are audited; other targets
pass. Both numerical session-2 jobs pass all six frozen budgets; completed logs
are audited. Session 1 has no timings because its probe failed. Documentation `41253482421` and
ownership budgets `41253562992` pass; completed logs contain no compiler warnings.


`array-list-measurements` compares the same compiler with numeric array fusion
explicitly enabled/disabled. It measures six whole-solve cases and six runtime
phases, including original copy/noise controls. The final gradient list lies
outside those phase clocks; whole-solve allocation savings cannot be called a
recording-time reduction. Original D2 and N1/N2 timing requirements remain open.

## Swift attribution and remaining review

New `swift-allocations` jobs profile the pipeline and map peers with heaptrack
on native Linux ARM64/AMD64. They retain exact allocator-stack totals and require
an independent three-allocation/omitted-release control. fwp's direct-mapped
managed heap is outside malloc tracking, so its existing managed observer runs
separately; never call malloc-only bytes complete fwp heap use or add independent
peaks. Run `41253559042` passes on AMD64, including allocation/release controls.
ARM64 fails the control because all traces have zero instruction addresses
(`??` stacks). Both logs are audited. At `a33c8ba9`, run `41254571983` passes both
architectures with pinned libunwind 1.8.3, including allocation/release controls.
Standalone direct unwinding also passes with the system library: it does not
reproduce heaptrack's missing frames. The next observer check runs the full
heaptrack controls with both libraries on the same host and retains both.
Unused coredump/ptrace helper libraries emitted upstream implementation warnings;
their builds are removed. This does not disable allocation stack collection.
The [protocol](measurements/swift-allocations.md) introduces each metric and the
actual peer algorithms. Three local damaged-record/unwinder tests pass.

Source review found that type-spine arity can delay a saturated top-level function
constructor. Published `stage_arity` at `a33c8ba9` follows checked aliases, subtracts supplied
arguments from the constructor's current stage and keeps composition at one input.
New cases require division by zero before a later argument effect for top-level
application, pipe application and composition. Raw/native constructor trap-order cases pass on all three focused hosts in
`41254567543`. Its only failure on each host is the functional-cost probe's old
assumption that every arrow in a type belongs to one C entry. The repaired helper
uses the actual construction stage, then consumes returned functions as needed.
The returned-callable measurement adapter had the same assumption and is repaired
without changing its source algorithms. Next `lexical-probes` verifies both helpers
on the three native hosts, without repeating the unchanged full language corpus.
Ownership `41254575615` passes Linux and Intel macOS, including all 229 unit
checks and analysis budgets. Docs `41254565452` passes; its deliberate failing-runner
controls are expected. All focused, Swift, ownership and docs logs are audited
(`/private/tmp/fwp-236-a33-*.log`); no additional failures remain unexamined.

The unpublished `check-array-list-evidence.py` recomputes process totals, medians,
ratios, profiles, phases, RSS, stack reports and actual ELF instruction-section
sizes. It preserves failed budgets instead of treating rejected experiments as
corrupt evidence. New report workflow retains raw files, job identities and logs.
The first AMD session-2 report is checked in; three corruption tests and all twelve
older derivative archive tests pass. Full directory audits and durable raw archives
remain to run on CI. Retain a33 Swift profiles only with their recorded source;
the next collector adds same-host system heaptrack controls to its format.

## Local checks

All checks use the unchanged resource guard. No full compiler build ran locally.
Full builds, suites and benchmarks stay on runners; never raise local limits.

| Check | Result |
|---|---|
| `cargo fmt --all`, `git diff --check` | Pass |
| Workflow actionlint | Pass |
| `scripts/test-native-test-runner.py` | 21 pass, including target coverage |
| Frozen primitive inventory | 394 declarations, 384 symbols, no review symbols |
| `scripts/check-roadmap.py` | 194 doc link sets, 106 preparation pairs, ten steps pass |
| Standalone production parser/formatter | 17 tests and tutorial/new fixture round trips pass |
| Tutorial source copies and library reference generator | Pass |
| `scripts/test-collection-evidence.py` | Eight pass; new numeric test count included |
| `scripts/test-descent-budgets.py` | Nine pass, including exact new savings/timing limits |
| `scripts/test-swift-peer-records.py` | Five pass, including retained archive recomputation |
| `scripts/test-swift-allocation-records.py` | Three pass, including incomplete-stack, omitted-release and unwinder controls |

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
Swift allocation attribution passes ARM64 and AMD64 controls; RSS and native
allocator calls do not isolate ARC-operation costs.
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
