# Delivery history

A compact index of merged changes. [PLAN.md](../PLAN.md) lists unfinished tasks;
[the handoff](development-state.md) records current work. A merge, focused check
and complete platform validation are different events. Measurements retain their
original source and settings; old numbers are not measurements of current main.
The linked PRs, runs and data records supply the detailed evidence.

## Decimal counting and current derivative baselines (PR #225)

The [exact decimal-threshold tree](measurements/decimal-count.md) reduces the
measured character-counting time by 33.8–34.8% on ARM64 and 38.6–39.6% on AMD64
against previous fwp, while still taking 25.0–26.2% longer than C. The accepted
sessions retain code/stack costs, unchanged arithmetic and all rejected controls.
Startup checks now handle thread/signal-stack failures. Evidence upload verifies
its ZIP before publication; the Windows decimal oracle uses a newline-free marker.
[Derivative baselines](measurements/descent-costs.md) and
[output comparisons](measurements/descent-output-current.md) identify remaining
costs, differing work and unreliable short timings; they claim no AD speedup.

Final source `fbed316b9f31bf792702c0e6914fbb77c86ba643` passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40821277777)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40821277750).
Complete logs are audited: 981 tests per Linux host, 619 per regular macOS host,
359 per ownership macOS host, 799 per Windows host and two benchmark tests.
The original artifact-stream error and older Intel compiler abort remain unexplained.

Squash `6735c4e3841ad4991f99c3c413daeb9d432c709c` matches tested tree
`f70bc35d25a9e8fb566ed085f8afab65fb2a9f48`. Its verified message has one line,
no body and no trailers. Only duplicate post-merge CI `40830143795` was cancelled.
Next is D1–D3: reliable derivative budgets, stack recording arguments and accuracy.

## Scalar boundary checks and rejected CPU experiments (PR #224)

The [paired scalar experiment](measurements/proved-scalar-bounds.md) rejected
both proposed removal-of-checks optimizations under the unchanged CPU budgets.
The merged compiler/runtime remain identical to #223; retained tests cover
runtime integer boundaries and checked length overflow at O0/O1/O2/O3. All
observations, including noisy controls and rejected hardware, remain available.

Final head `b4e004d5788f2b2479b085a7dc6a48c435cce477` passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40790143419)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40790141513).
Every target and diagnostic was audited: 978 passing tests per Linux host, 618
per regular macOS host, 357 per ownership macOS host, 798 per Windows host and
two benchmark tests. The Windows TLS unknown-CA message is the tested rejection
of a rogue client certificate, not a failed test.

Squash `52e8da582644a93d996816d344894fdf5435a92f` matches the tested tree
`baca4d6d34a96828c49c3200ba942ef3375754e2`; its message is one line with an empty
body and no trailers. P2/P3 remain open: a rejected experiment is useful evidence,
not an accepted performance improvement.

## Fixed CPU baselines (PR #223)

[Six retained sessions](measurements/cpu-baselines.md) establish repeated
Neoverse-N2 and EPYC 7763 baselines for the checked loop and character-counting
programs, with equivalent C/Rust peers. The frozen limits reject incomplete
records, mismatched hosts and silent budget resets. No compiler speedup is claimed.

Final head `a4cceb8d5a219ab7d691127844bc3ddc23a24001` passes all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40771179934)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40771144344).
Every completed test target and compiler diagnostic was audited: 977 passing tests
per Linux host, 617 per regular macOS host, 357 per ownership macOS host and 797
per Windows host. The benchmark job's two targets and all evidence controls pass.
No failed target or compiler warning remains; Brew's already-installed notice is
informational. Draft-skipped runs are not acceptance.

Squash merge `330a08939ea68a7967aecdc60a2c77ac9b55a1bb` has the same tree,
`e3774208e2da356915f479688e5839d37d404b79`, and a single-line message with no body
or trailers. B1/P1 and the B2 integrity controls are complete for these two programs;
P2/P3 and broader A/D/N baselines remain open.

## Functional calls and recursion (PR #222)

[The call/recursion report](functional-costs.md) verifies eight known/boundary
pairs, weak-metadata frame reuse and restricted scalar mutual loops. Strong or
unknown captures retain cleanup boundaries. POSIX stack handling now stores a
numeric address instead of a pointer to an expired local. Callback guard controls
remain detectable under production C optimization. The historical Intel abort's
cause remains unknown; this repair does not close that defect.

Final head `b69f111e03802ab4041cf9f6d7fbfce94194c379` passes all nine production
jobs [40721714559](https://github.com/e6qu/fun-with-pipes/actions/runs/40721714559),
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/40721714558) and both
[G2 hosts](https://github.com/e6qu/fun-with-pipes/actions/runs/40721764744).
Every complete log is audited without compiler warnings or failed targets:
977 passing tests per Linux host, 617 per regular macOS host, 357 per ownership
macOS host and 797 per Windows host. Benchmark comparison and rejection controls
also pass. These counts include separate test invocations, not unique source tests.
[Raw G2 evidence](measurements/ownership-analysis-2026-10-28-final.json) preserves
unchanged limits, equal lifetime facts and both hosts' timing samples.

The longer [timing run](https://github.com/e6qu/fun-with-pipes/actions/runs/40721041382)
at `98a1d8eb` passes every original limit. Independent review verifies its samples,
outputs, actual binaries, flags, profiles and stack reports. The final head changes
only documentation from that source. The short noisy session remains recorded as
inconclusive; it was not relabelled or used to loosen acceptance.

The user merged as `17978b97373f3e9236468ac19c1b8e0d290816d7`, tree
`5a434a44f164e664b31c70a8d7b1db9e8dc8ab5d`, identical to the tested head. The
squash message is one line, at most 80 characters, with no body or trailers.
Postmerge production `40749834807` and docs `40749834937` also report success;
acceptance above relies on the audited final-head runs. F1–F3 are complete for
the stated cases; B/P/D/N and application work remain in the plan.

## Scoped parser storage and analysis work (PR #221)

A selected parser invocation owns aligned storage blocks; integer/link tree nodes
need no individual counts. [The report](measurements/parser-workspace.md) records
18–28% less parser time than previous fwp, alongside 4–14% more allocated bytes
and the remaining C/Rust gap. The [analysis repair](measurements/ownership-analysis.md)
rechecks changed dependencies and preserves every lifetime fact and budget.

The user merged #221 as `ef037415f401cdf9ed44c7deffe735edfa99e0cd` before final
production verification. Its tree `531fcffc2796aed8fb8b06b00145dddf2e7309d9`
matches focused-tested head `50dd674aa7f764d9e2a0ef75dbc736ace3e4f9c1`; its message
is one 49-character line with no body or trailers. Both G2 hosts `40685939711`
and docs `40685831377` passed. Earlier parser native/WASI checks and four timing
sessions are independently audited in the report. **A6 is verified:** all nine
production jobs `40691815018` and docs `40691814677` pass on the merged tree.
Every completed log is audited, including compiler warnings and test targets:

| Host/job | Passing test summaries | Tests passed |
|---|---:|---:|
| Linux ARM64, AMD64 (each) | 257 | 969 |
| Regular macOS ARM64, AMD64 (each) | 132 | 610 |
| Ownership macOS ARM64, AMD64 (each) | 127 | 356 |
| Windows ARM64, AMD64 (each) | 202 | 790 |

No compiler warnings/errors or unexpected failures remain in those logs.
The benchmark passes output and invalid-evidence controls. Its current-host
loop ratio is 1.392× Rust and text-length ratio 1.905× C; these are not paired
cross-revision regression measurements. The deliberate missing-cleanup leak is
an expected control. Raw logs are retained under `/private/tmp/fwp-221-ef037-*.log`.
The original intermittent Intel compiler abort remains unexplained; preserve
[its evidence](measurements/compiler-abort.md) and diagnose any recurrence from
source/input. Passing reruns do not establish its cause.

## Temporary record owners and sort keys (PR #220)

Scalar projections and known sort callbacks remove two temporary owners per
word-frequency key. Contiguous integer/string keys remove another owner and one
allocation. The [A3 report](measurements/sort-key-ownership.md) and
[A4 report](measurements/inline-sort-keys.md) retain exact counts, cleanup/binary
controls and repeated timing. Sorting and result cleanup took 49–56% of the
previous fwp path's time; input construction and whole-program execution are not
included. The initial noisy short timing control remains a rejected observation.

All nine production jobs `40516763516`, docs `40516754393`, both G2 hosts
`40516769076` and both timing hosts `40516778004` passed on final head
`06e3a92375bf2a3802853766998e5f0dcbe265ff`. The first longer timing run
`40514452443` also passed; both complete artifact sets were independently audited.
Completed production logs contained 256 passing target summaries per Linux host,
132 per regular macOS host, 126 per ownership macOS host and 201 per Windows host.

Squash `56d5aac63a9963ae6b16574f10d6dc3087a08d8a` has the identical tested tree
`1c824b804dddd30460bb11b2f5a9a40dd9fe16b4`. Its message is one 55-character line
with no body/trailers. Duplicate postmerge CI `40552108647` was cancelled after
that verification. Separate postmerge docs `40552108553` exposed a guard-test
fixture depending on 64 GiB of real runner free space. The next batch isolates
its test readings and adds refusal/boundary controls in #221; the production
guard's limits are unchanged. [The handoff](development-state.md) tracks acceptance.

## Unique local arrays without counts (PR #219)

Selected local `Array[I64]` values now have a compiler-proved single owner,
no count storage and direct cleanup. Other array shapes keep counted storage.
The [report](measurements/unique-array-storage.md) covers proof boundaries,
metadata allocation, code/stack costs, native/WASI probes and compiler cost.
It makes no execution-speed or general count-free-array claim.

All nine production jobs `40498383568`, documentation `40498379836` and both
analysis hosts `40498382182` passed at `aab8fe71f4f08ff4dcc8a13624dcfdacfd45e031`.
Completed logs were audited, including 256 passing target summaries per Linux
host, 126 per macOS ownership host and 201 per Windows host. Squash merge
`413a10ebe1b2b08375383bebae8272129043d94a` has the identical tested tree
`5653457a60d29370c82bad2367f17816860ddba0`. Its message is one 56-character line
with no body or trailers. Duplicate postmerge CI `40511055857` was cancelled
after that verification. A5 is complete for the declared local-array shape.

## Static array callbacks and remaining ARC costs (PR #218)

Creating N array elements through a known capture-free callback no longer makes
N no-op retain attempts and callback-release checks. Effective owner counts,
allocation requests and live bytes are unchanged. The
[cost report](measurements/arc-residual-costs.md) attributes remaining owners and
records smaller code but larger entry frames; no speedup is claimed.

Merged as `cd0b53e27ff71bb266658415886c7bfc117ce9cb`, with tree
`3f2051728853f89c28225d16824f47f2bdf314e7`, identical to tested
`4e504ee381d1d85f2172b508459d026300013ba5`. All nine production jobs `40480893046`,
docs `40480892776` and both analysis hosts `40480891997` passed; completed logs
were audited. The squash subject is one line, 69 characters, with no body or trailers.
Duplicate postmerge CI/docs runs were cancelled after verifying the identical tree.
This delivered A2 and the first A3 class; later entries record further ARC work.

## Tracing GC removal (PR #217)

The collector and `--gc` selection are deleted. Native programs use compiler
ownership, typed destruction and counts where sharing remains. Weak links and
rejection of unproved owning cycles preserve the agreed lifetime model. Native
and WASI tests retain physical-free, alias, cancellation, failure and reuse
controls; tools and reports use the same memory policy.

All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40433794313),
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40433794300) and
both [analysis-budget hosts](https://github.com/e6qu/fun-with-pipes/actions/runs/40433851517)
passed on `2721bf14a389f685e3dd64f5bf3d6921f61a6212`. Every completed production
log was audited for failed targets. [PR #217](https://github.com/e6qu/fun-with-pipes/pull/217)
was squash-merged as `9dfa014596e1954e3e67c653123dad77a14f5241`; its tree matches
the tested tree, and its message is one 57-character line without trailers.

Repairs addressed missing cleanup in protocol fixtures, portable trap/failure
controls, Windows header ordering and a slow Ubuntu package mirror that prevented
the required WASI tool installation. Fully supplied ownership-analysis calls
now join existing captures directly instead of copying temporary sets. Both
analysis hosts pass the unchanged count/time budgets; see the
[analysis measurements](measurements/ownership-analysis.md). No timing budget
was raised or required test skipped. The older intermittent Intel compiler abort
remains unexplained; [its evidence](measurements/compiler-abort.md) is retained.

G1–G5 are complete. ARC minimization remains A2–A6. Historical benchmark results
are not relabeled as measurements of this source.

## Shared lifetime checks and clearer guides (PR #216)

Interpreter and native entries now enforce the same ownership rules before
executing effects. Separate callback creations no longer get merged into a false
cycle, and complete analysis caches keep the maintained REST examples within the
ten-second budget. Memory-server tests bound startup and drain logs while waiting.
Guides explain pipes, ownership, parser stages and measurement comparisons.

All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40274667944),
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40273010537) and both
[analysis-budget jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40273030485)
passed on `1dd5fcaed7792b5505283b1037a9c22d788a3be5`.
[PR #216](https://github.com/e6qu/fun-with-pipes/pull/216) was squash-merged as
`f5621cb46828273f7ce8edf92be4062ccec0f17c`; the tree and one-line message were
verified. G2 is complete. Collector deletion and further ARC reduction remain.

## Weak channels and retained callbacks (PR #215)

Weak channels observe a queue without keeping it alive. Retained C callbacks
own an explicit registration, preserve results and finish active calls before
releasing captures. Cleanup checks cover weak metadata, count overflow, files,
sockets, real library unload and WASI allocation tables. Independent fault
controls detect omitted or premature cleanup. [Memory diagnostics](ownership-diagnostics.md)
records the checks that let G5 delete tracing without losing safety coverage.

All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40221722197)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40221722121)
passed at `bd77d65f58d8c5117ea678cb86cf15fbcf9231f7`. The user merged
[PR #215](https://github.com/e6qu/fun-with-pipes/pull/215) as
`4e7b74be8e11634fac9309e67cb4efccfb34d360`, with an identical tree.
G3/G4 are complete; tracing still exists.

## Ownership checks without retaining freed objects (PR #214)

A test-only address ledger checks live allocations without keeping freed storage
around. It catches invalid frees, operations on dead owners and unsafe reuse;
independent byte accounting catches a free that fails to return storage.

All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394961)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394939)
passed at `1591ec72553a1168bc52d5745d1865059c15fede`. Squash merge
`6ee33396459986a0fa08464b182d23fd2fe6c136` has the same tree.
[PR #214](https://github.com/e6qu/fun-with-pipes/pull/214).

## Scoped subscriber lifetimes (PR #213)

[Lesson 24](tutorials/24-subscriptions/README.md) uses an independently owned task
and a data queue for a persistent subscriber. Native checks cover finish, failure,
active/unstarted cancellation, child-task cleanup and reentry. Eight and 64 rounds
restore their memory balance; omitted release/join controls fail. Task docs now
explain that cancellation does not erase a result already produced.

All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40177475991)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40177475958)
passed at `0ac1f6f714a1a9a5f62d3d4b14a8db806358d140`. The guarded merge
produced `11a0f5ac3baea83609577c00d9a9dd7a67f627a3`, with an identical tree
and the verified single-line subject `Verify scoped subscription lifetimes and cleanup`.
[PR #213](https://github.com/e6qu/fun-with-pipes/pull/213).

## Array moves and the GC-removal checklist (PR #212)

List-to-array conversion moves an unshared prefix; array sorting reuses eligible
unique storage while preserving aliases and wide-number bits. The 4,096-word
conversion removes 4,096 retains. A separate sort control removes a 32,776-byte
copy request and 4,096 retains. Peak storage does not fall; code/stack costs are
reported without a timing claim in [the array report](measurements/array-sort-ownership.md).
The [entry checklist](ownership-admission.md) maps supported entries and precise
rejections to tests, including raw/optimized rejection controls.

The user merged `eff5146e8d6d373771d18cb2f206d40bc36c6e06`, with the same tree
as tested head `dc9cf3bfb846d5a6632fbd6424cc8509b5d560cb`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40159979066)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40159979067)
passed. Production inspectors passed; independent Linux benchmark binary review
also passed. A separate manual review of every final platform artifact was not
completed before merge. [PR #212](https://github.com/e6qu/fun-with-pipes/pull/212).

## Concrete roadmap and documentation overhaul (PR #211)

The plan separates GC removal from ARC minimization into concrete implementation
tasks and acceptance checks. Guides distinguish current behavior from proposals;
benchmark protocols and historical results have separate, linked explanations.
Tutorials correct stale platform and ownership claims. The link audit now ignores
headings inside code examples. Compiler and runtime behavior are unchanged.

The user merged `afebaac99f9b45235df369a6460f8e4c081ec5b3`, with the same tree
as tested head `9f36f2f5ae4a1a2361a2c9ed8cb8bcc27a7680b3`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40139343820)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40139343796)
passed. [PR #211](https://github.com/e6qu/fun-with-pipes/pull/211).

## Collection cleanup and interpreter shutdown (PR #210)

Interrupted list copies and sorting release partial values and scratch storage.
Redundant sort buffers are removed. Interpreter entries join child/background
tasks before borrowed program data or writers expire, including panic cleanup.
The benchmark peers now check signed arithmetic consistently. The original Intel
macOS allocator abort remains [unexplained](measurements/compiler-abort.md).

[PR #210](https://github.com/e6qu/fun-with-pipes/pull/210) was merged by the user as
`380fa8412327e52db420b96918d20e2528bbfc7c`, with the same tree as tested head
`36924807f0343c79c38ef42c4254a721afa60613`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40124698815)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40124698740)
passed. Independent final-head binary review was not completed before that merge.
Details: [list copying](measurements/list-copy-cleanup.md),
[sort storage](measurements/list-sort-storage.md), [checked peers](measurements/checked-peers.md).

## Map peak storage and explicit benchmarks (PR #209)

Map construction now releases sort scratch before allocating its final storage.
For the 500,000-entry map, peak managed storage falls from 24,000,008 to
16,000,008 bytes on both Linux hosts. Requests, retains and final balance stay
unchanged. Timing, RSS and managed counts use separate measurements with
explicit compiler/memory settings; no speedup is claimed. The
[comparison report](measurements/arc-comparison.md) preserves algorithms,
arithmetic differences, slower rows and rejected arithmetic experiments.

[PR #209](https://github.com/e6qu/fun-with-pipes/pull/209) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40082867710) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40082867648) · [Acceptance records](measurements/arc-map-delivery-2026-10-24.json)

## API memory, stack guards and connection cleanup (PR #208)

The maintained JSON API now has bounded request/disconnect/shutdown checks.
Linux task stacks avoid huge-page backing, failed Unix guard setup releases its
mapping before exit, and Windows test clients keep one socket owner so unrelated
compiler children cannot inherit a duplicate connection. Memory budgets and
deadlines remain unchanged; deliberately missing frees and closes are detected.

[PR #208](https://github.com/e6qu/fun-with-pipes/pull/208) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40074183388) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40074183289) · [acceptance record](measurements/http-memory-delivery-2026-10-24.json)

## File cleanup and HTTP example checks (PR #207)

Task-file tests repeat edits and errors at 128 and 4,096 UTF-8 items. Deliberately
missing frees and closes must fail; output and final file contents are checked.
HTTP example tests bound startup/shutdown, verify the slow handler entered before
shutdown and clean up children after failure. Measurement docs distinguish
allocator charge, process memory and binary section size from speed comparisons.

[PR #207](https://github.com/e6qu/fun-with-pipes/pull/207) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40064764447) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40064764348) · [acceptance record](measurements/file-http-delivery-2026-10-24.json)

## Array output, storage and startup stack (PR #206)

Eligible array display/JSON operations no longer build temporary lists. Numeric
literal arrays use static storage; unchanged strings and iterator state avoid
copies. One reusable type descriptor per array removes the earlier roughly
15 KiB startup frame. [Examples](measurements/array-text.md) explain the eligible
patterns; [native results](measurements/array-native-results.md) retain allocation,
layout, code-size and stack costs. [C/Rust comparisons](measurements/array-output-results.md)
still show substantial complete-program gaps, especially with full output.

[PR #206](https://github.com/e6qu/fun-with-pipes/pull/206) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40055774892) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40055774862) · [acceptance record](measurements/array-delivery-2026-10-24.json)

## Float printing and numerical cost measurements (PR #205)

Float printing searches fewer candidate decimal formats while preserving the
round-trip value and existing output. The [formatter report](measurements/float-text.md)
explains the algorithm and edge cases; the [timing report](measurements/float-text-results.md)
retains repeated controls, slower/noisy results, and stack/code costs. Whole
numerical programs still take substantially longer than the C/Rust comparisons.
Their output/checksum experiments separate output work from other costs without
calling the checksum program pure arithmetic. A local process-monitor race is
also repaired and covered by controls.

[PR #205](https://github.com/e6qu/fun-with-pipes/pull/205) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40037426686) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40037426647) · [acceptance record](measurements/float-output-delivery-2026-10-24.json)

## Derivative storage, arrays and borrowed callbacks (PR #204)

Six groups extend cleanup checks to derivative buffers and scopes, borrowed
callbacks, array values, failed buffer growth and workspace caches. Repeated
computations must release their temporary values; deliberately omitted cleanup
must fail. The examples explain what owns each value. Compiler/runtime behavior
is unchanged; these are correctness checks, not a timing improvement.

[PR #204](https://github.com/e6qu/fun-with-pipes/pull/204) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40019873535) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40019873426) · [inspection record](measurements/derivative-array-cleanup-2026-10-24.json)

## Tasks, state and runtime call cleanup (PR #203)

Seven groups check task callbacks, handles, state, deadlines, channel values and
runtime-selected calls with ARC and tracing. Repeated storage balances and
omitted-release controls detect retained values after completion, errors and
cancellation. Fixtures explicitly own their injected tasks, durations and strings.
The cleanup guide introduces notation and examples; compiler/runtime are unchanged.

[PR #203](https://github.com/e6qu/fun-with-pipes/pull/203) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40002922119) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40002921896) · [inspection record](measurements/task-cleanup-2026-10-23.json)

## Cached values, aliases and failed calls (PR #202)

Ten groups now check cleanup with ARC and tracing: fields, matching, returned
aliases, reusable storage, partial calls, folds, loop cancellation, cached values,
escaping functions and temporary containers. Repeated byte balances and deliberate
missing releases detect retained storage. Windows gained five omitted test groups;
a runner control now checks production coverage. Compiler/runtime are unchanged.

[PR #202](https://github.com/e6qu/fun-with-pipes/pull/202) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39981747930) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39981747884) · [inspection record](measurements/call-cleanup-2026-10-23.json) · [The guide](measurements/record-cleanup.md)

## Failed loops and collection cleanup (PR #201)

Loop, map, filter/take-while and zip probes now check repeated cleanup with ARC
and tracing, including allocation failures, failed callbacks and cancellation.
Deliberately omitted buffer cleanup and final releases must fail. Thirteen
related tests save generated C, binaries and results before asserting success,
so a failing run retains its evidence. Compiler behavior is unchanged.

[PR #201](https://github.com/e6qu/fun-with-pipes/pull/201) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39955074782) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39955074824) · [inspection record](measurements/collection-cleanup-2026-10-23.json) · [The guide](measurements/collection-cleanup.md)

## Repeated constructor and call cleanup (PR #200)

Six tests now repeat constructor, call and variant failures with ARC and tracing.
ARC must return managed storage to its starting charge without collection;
deliberately omitted releases and cleanup steps must fail. A fixture selector
bug had run the variant case twice instead of checking the record case. Distinct
failure statuses now prevent that false pass. Windows gained the missing
constructor-allocation test and exact binary output handling.

[PR #200](https://github.com/e6qu/fun-with-pipes/pull/200) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39939679368) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39937419223) · [inspection record](measurements/constructor-cleanup-2026-10-23.json) · [explained examples](measurements/record-cleanup.md)

## Checked native defaults and ARC metadata (PR #199)

Native commands, modules and compiler APIs use checked ARC by default. Unproved
ownership is rejected; explicit tracing remains. ARC omits tracing mark storage,
age checks, collector stack discovery and late poisoned-storage diagnostics.
[Page metadata](measurements/arc-metadata.md) falls from 4,648 to 4,128 bytes,
with the 4,096 count bytes unchanged. This establishes layout, not a timing gain.

[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199) · [record cleanup checks](measurements/record-cleanup.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39924646271) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39924644039) · [inspection record](measurements/native-default-2026-10-23.json)

## Local callback captures and repeated numerical work (PR #198)

Known generators and folds keep captures in local values; direct calls no longer
retain unused generic adapters. Boundary tests preserve stored/reused callbacks,
effects, empty inputs and cleanup on failure/cancellation. Windows gained missing
callback coverage and corrected saved-executable paths.

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) · [Callback measurements](measurements/callback-locals.md) · [Per-solve observers](measurements/descent-observers.md) · [Matched C/Rust formulas](measurements/coordinate-work.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39845348815) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39845348589)

## Borrowed array captures (PR #197)

Known numeric array-generation callbacks borrow caller-owned captures. Temporary
parameter records and last-read aliases no longer add owners; escaped values,
recursive callbacks and resource scopes keep their required ownership. Tests
preserve effect order, aliases, errors, cancellation and partial-array cleanup.

[PR #197](https://github.com/e6qu/fun-with-pipes/pull/197) · [ownership report](measurements/array-capture-borrows.md) · [numerical comparison](measurements/array-capture-descent.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39793823991) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39793823875)

## Array-owner moves and copied callback strings (PR #196)

Synchronous C callbacks copy incoming strings into fwp-owned storage, including
partial conversion, invalid UTF-8 and error cleanup. A dying stack record can
transfer its sole numeric-array owner instead of retaining it again. Shared aliases
and observable failure/cancellation behavior are preserved. The C-interop tutorial
now includes its complete callback program and console sessions.

[PR #196](https://github.com/e6qu/fun-with-pipes/pull/196) · [Ownership checks](measurements/stack-array-ownership.md) · [copied-input checks](measurements/callback-inputs.md) · [C/Rust derivative comparison](measurements/descent-peers.md) · [packed arrays](measurements/packed-descent.md) · [array-owner measurements](measurements/array-owner-moves.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39775586712) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39775586540)

## Native commands and test recovery (PR #195)

Native run/exec/test/serve/pipe commands accept explicit ARC or tracing selection.
Root test failures release error messages, state and pending task owners before
continuing to the next test. Child traps/exits remain process-fatal. Tracing was still the default at this
revision; #199 later switched native commands to checked ARC. Concurrent executable publication and Windows server/cache
cleanup are repaired. Missing C compilers fail explicitly.

[PR #195](https://github.com/e6qu/fun-with-pipes/pull/195) · [Command checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39752987389) · [Derivative-storage measurements](measurements/ad-application.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39753716407) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39753716342)

## String map ownership and native reuse checks (PR #194)

Known string-map callbacks now move unique input strings, and ASCII case changes
reuse private young storage. Shared aliases retain their original values. Large
allocation age checks are repaired; Windows reuse tests execute instead of
silently skipping when native compilation fails. WASI tests verify physical
cleanup as well as output.

[PR #194](https://github.com/e6qu/fun-with-pipes/pull/194) · [report](measurements/string-map-ownership.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39737931809) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39737931776)

## Manual C pointers and foreign storage cleanup (PR #193)

Checked ARC accepts manually managed C pointers in scoped calls, synchronous
callbacks and exported libraries. Pointers do not own their pointees; callers
must keep addresses valid and release raw storage. Managed C-string callback
results still require a separate lifetime contract.

[PR #193](https://github.com/e6qu/fun-with-pipes/pull/193) · [report](measurements/manual-pointers.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39725180238) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39725180233)

## String ownership and repeated file cleanup (PR #192)

Unchanged text transformations now transfer their existing string owner. Count,
index and byte-size guards reject or clamp large inputs before 32-bit narrowing.
The [word-frequency comparison](measurements/unchanged-text.md) records fewer
allocation requests and lower medians, while retaining the remaining C/Rust gaps
and differences in normalization work. It does not establish C/Rust parity.

[PR #192](https://github.com/e6qu/fun-with-pipes/pull/192) · [Repeated file programs](measurements/file-applications.md) · [autodiff application](measurements/ad-application.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39714665578) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39714665552)

## Task results and explicit CPU execution (PR #191)

Immediate task-result fields avoid a temporary `Some` box. The measured fixture
uses 34 fewer allocation requests and 544 fewer requested bytes, with unchanged
retains and peak storage; [the report](measurements/task-await-fields.md) records
the native/WebAssembly controls and limits. State callback scopes, Jacobian tape
cleanup and C-interop buffer releases are also repaired.

[PR #191](https://github.com/e6qu/fun-with-pipes/pull/191) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39688998592) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39688998567) · [focused GCC check](https://github.com/e6qu/fun-with-pipes/actions/runs/39688997806)

## Queued task owners and callback transfers (PR #190)

Queued callbacks and messages can retain proved task handles without tracing.
The compiler rejects unproved result cycles and unknown task producers. Task
creation transfers callback ownership directly: the five-task comparison uses
10 → 5 retains with unchanged allocations. [Task-message checks](measurements/task-channels.md)
and [callback measurements](measurements/queued-task-handles.md) record the limits,
all eight focused jobs, and independent native/WebAssembly binary inspection.

[PR #190](https://github.com/e6qu/fun-with-pipes/pull/190) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39673092514) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39673088884)

## Compact task records and repaired native validation (PR #189)

ARC task records are 32 bytes smaller on each measured native host. Allocation
and retain counts stay unchanged; allocator size classes make peak savings vary.
[The report](measurements/task-records.md) preserves those limits, tracing-mode
results and actual binary inspection. Windows output assertions and dependency
fetching are repaired without dropping checks.

[PR #189](https://github.com/e6qu/fun-with-pipes/pull/189) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39641372026) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39641321443)

## Cancellation buffers and Windows ARC fibers (PR #188)

[PR #188](https://github.com/e6qu/fun-with-pipes/pull/188) was merged by the user
before full validation finished. Merge `ffcf04763990356fb3cb3913d6414082e00aa178`
has the same tree as head `fc1386501955109b1f1271429a57b6ea42022aec`.
The [cancellation-only comparison](measurements/task-cancellation.md) has earlier
six-host evidence. The added Windows fiber probe passed its first execution but
its assertion expected LF instead of the C runtime's CRLF output on both Windows
architectures. That stopped the remaining variants and left incomplete artifacts.
The completed [production run](https://github.com/e6qu/fun-with-pipes/actions/runs/39635039734)
has six passing jobs, these two Windows failures, and a macOS ARM64 GC-stress
failure resolving crates.io before compilation. Every full log was audited;
documentation passed. This merge is not full platform acceptance.
[PR #189](https://github.com/e6qu/fun-with-pipes/pull/189) repairs the assertion
and dependency fetching, and reruns every variant with the
[compact-record measurements](measurements/task-records.md). PR #189 has full production
acceptance as recorded above; this earlier merge alone does not.


## Smaller Linux task heap records (PR #187)

Saved CPU state moves from heap task records into existing child stacks and root
static storage. The [comparison](measurements/task-contexts.md) counts those bytes
separately and retains mixed timings, larger files and remaining ARC operations.
This is a storage improvement for the measured programs, not GC removal or
proof of C/Rust performance parity.

[PR #187](https://github.com/e6qu/fun-with-pipes/pull/187) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39613713414) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39613713402)

## Queued service responses and bounded server startup (PR #186)

Queued callbacks can retain a response channel supplied by an actual gRPC service
entry. Unknown producers retain their existing restrictions. Repeated delivery,
failure and cancellation checks release request owners; the
[report](measurements/queued-grpc-responses.md) separates the still-live listener.
REST startup now kills and reaps a silent child, and tests reuse compiled fixtures
while starting fresh server processes.

[PR #186](https://github.com/e6qu/fun-with-pipes/pull/186) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39597478599) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39597478465)

## Queued callbacks retaining data queues (PR #185)

Callbacks stored in channels can retain locally created data-only queues,
including through aliases and nested queues. The compiler tracks actual creators
and all values sent into nested queues; unknown producers cannot acquire a known
origin merely by sharing a type. The [report](measurements/queued-data-channels.md)
records native and WebAssembly cleanup and deliberate missing-release controls.
This extends checked ARC support without changing runtime layouts or syntax.

[PR #185](https://github.com/e6qu/fun-with-pipes/pull/185) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39584128319) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39584128240)

## Queued socket callbacks and handler inference (PR #184)

Queued functions can retain UDP sockets, TCP listeners and connections under
checked ARC. Existing owners keep each socket alive and close it on final release.
Error/state handler inference also preserves handled effects through callbacks
and returned records, while keeping unrelated effects required. The
[focused report](measurements/queued-callbacks.md) records native cleanup,
actual-binary inspection and WASI handler checks; these are correctness results,
not timing or C/Rust parity claims.

[PR #184](https://github.com/e6qu/fun-with-pipes/pull/184) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39570320517) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39570319685)

## Checked-product bounds (PR #183)

Signed I64/ISize multiplication keeps its overflow check, then exposes the safe
product expression to C optimization. The [report](measurements/checked-products.md)
records lower O2 counting-loop CPU time on EPYC 7763/N2, smaller instruction
sections and removal of AMD64's normal entry frame. Matched C remains faster;
AMD64 comparisons with Rust vary by CPU. O0/O1 emit an extra product. These
limits remain part of the result, and tracing is still present.

[PR #183](https://github.com/e6qu/fun-with-pipes/pull/183) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39543123372) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39543123369)

## Grouped integer counting and U32 overflow (PR #182)

Integer display lengths now count decimal digits in groups. Ordinary inline
hints remove counting-helper calls in the measured loop. The [report](measurements/integer-counting.md)
records roughly 48% less child CPU time on Xeon 8573C/N2, remaining matched
C/Rust gaps, a larger instruction section and AMD64's fixed 40-byte entry frame.
Managed counting-workload allocations remain zero; tracing remains in the binary.

[PR #182](https://github.com/e6qu/fun-with-pipes/pull/182) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39533108586) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39532459370)

## Temporary channel borrows and failure cleanup (PR #181)

Temporary channel names can borrow an owner still needed after the operation,
including calculations inside record fields. The measured shared-text loop
reduces retains from three to two per message; closed sends reduce one to zero.
Allocations and peak accounted storage stay unchanged. Changed error and task-scope
fields also remain valid after C `longjmp`, preserving failure/cancellation cleanup.
[The report](measurements/channel-local-borrows.md) records counts, actual stack
frames and code sizes, plus C/Rust timing gaps that remain unexplained.

[PR #181](https://github.com/e6qu/fun-with-pipes/pull/181) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39488574062) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39488538767)

## Function-channel borrows and integer text (PR #180)

Direct calls can borrow a channel carrying functions while its original owner
keeps the queue and callback data alive. In the measured fresh-function program,
this removes one retain/release pair per message, with unchanged allocation and
peak storage. Capture, cycle and resource-scope checks remain.

[PR #180](https://github.com/e6qu/fun-with-pipes/pull/180) · [integer-text report](measurements/integer-text.md) · [channel measurements](measurements/function-channel-borrows.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39457866569) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39457866666)

## Matched payload moves and direct-call borrows (PR #179)

Matching a single-payload variant can transfer its owner into the arm. A direct
call can borrow input storage when every caller still needs that same storage
afterward. Last uses consume their inputs; generic entries retain their ordinary
ownership rules. Failure, cancellation and original resource scopes stay covered.

[PR #179](https://github.com/e6qu/fun-with-pipes/pull/179) · [The channel comparison](measurements/channel-direct-borrows.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39438167856) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39438167895)

## Direct matches and callbacks (PR #178)

A match on a temporary tuple can test the relevant field directly, after
evaluating every field once in order. This exposes known callback calls and
receives whose tag and payload can stay in locals. Ignored constants still
evaluate and trap; whole-tuple uses and original resource scopes stay protected.

[PR #178](https://github.com/e6qu/fun-with-pipes/pull/178) · [The five-program comparison](measurements/channel-match-results.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39397311012) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39397297724)

## Receive results without temporary wrappers (PR #177)

Immediately matched receives can keep the `Option` tag and message in local
fields, transferring the queued owner without allocating a `Some` wrapper.
Whole-value uses remain boxed. Both use the same receive loop and preserve
timeout, cancellation and cleanup. Boxed receives allocate before dequeue;
this also repairs retry after allocation failure in uncounted tracing mode.

[PR #177](https://github.com/e6qu/fun-with-pipes/pull/177) · [Counts and binary inspection](measurements/channel-receive-results.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39374128066) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39374119890)

## Loop state and known function calls (PR #176)

Loops can now keep state fields in locals even when an action or branch precedes
`Again`. For example, printing a string before updating `(count, text)` no longer
forces a new state tuple on each iteration. Known capture-free function aliases
also expose direct calls; constants that can evaluate or trap stay in order.
[Examples and measurements](measurements/channel-loop-state.md) explain the
five channel programs, counts, generated C and actual machine-code comparisons.
Each saves one allocation per additional message from loop-state lowering.
The alias change saves no further allocations or retains; it removes generic
dispatch and reduces the fresh-text exchange frame by 48 bytes on both hosts.
These are fwp count/representation comparisons, not timing or C/Rust parity claims.

[PR #176](https://github.com/e6qu/fun-with-pipes/pull/176) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39371117507) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39371117707)

## Function queues and cheaper sends (PR #175)

Checked ARC accepts queued functions whose immutable captures are proved safe.
For example, sending `add 3`, receiving it and applying it to `5` produces `8`.
Calls still need the correct state/derivative scope. Unknown functions and
resource-bearing captures remain rejected; no ownership syntax is added.
Sends move an existing owner into the queue, preserving aliases and cleanup on
failure/cancellation. A `tap` optimization also removes a temporary argument tuple.
ARC preprocessing excludes tracing routines even with GCC at O0.

[PR #175](https://github.com/e6qu/fun-with-pipes/pull/175) · [Measurements](measurements/channel-transfer-protocol.md) · [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39363423392) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39363423384)

## Numeric hashing and integer output (PR #174)

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) merged as
`3ec71969089a7ab95ff065f7b611c74534fbe326`, with identical files to tested head
`67f233467bc68fe9a690373af219253d45f4e3f8`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39342938663)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39342938600)
passed before squash merge. The verified message is one line, 73 characters,
with no body or trailers. Only redundant post-merge production `39351187907`
was cancelled after checking the identical tree.

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) · [final C/Rust comparison](measurements/numeric-output-peers-2026-10-20.md)

## Direct integer range sets (PR #173)

[PR #173](https://github.com/e6qu/fun-with-pipes/pull/173) merged as
`eb03eb58fb642500234b9bbe647adbcf59765415`, with identical files to tested head
`3e4d0a372a79461d5482503b4d1b454ed7b7e347`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39312560218)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39312560173)
passed before squash merge. The one-line message and identical tree were checked;
only redundant post-merge production run `39328932163` was cancelled.

[PR #173](https://github.com/e6qu/fun-with-pipes/pull/173) · [binary audit](https://github.com/e6qu/fun-with-pipes/actions/runs/39311772543) · [million-key comparison](measurements/range-set-peers-2026-10-19.md)

## Compact set storage (PR #172)

[PR #172](https://github.com/e6qu/fun-with-pipes/pull/172) merged as
`c3f7f75591a0a073f443fed45855a1b084963729`, with identical files to tested head
`a6dd760904c5d72c09a5fcf720d8f255a19de1f1`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39297062257)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39297062240)
passed before the squash merge.

[PR #172](https://github.com/e6qu/fun-with-pipes/pull/172) · [binary audit](https://github.com/e6qu/fun-with-pipes/actions/runs/39301336981)

## Mixed tail recursion (PR #171)

[PR #171](https://github.com/e6qu/fun-with-pipes/pull/171) merged as
`f3f3bd811c6d3935cd84fca2f7e6e877dc13c3d0`, with identical files to tested head
`13210b757db74379c4f1d9893fd0049d2e774916`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39276733207)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39276733233)
passed.


## Acyclic nested channel ownership (PR #170)

[PR #170](https://github.com/e6qu/fun-with-pipes/pull/170) merged as
`903482e856e33f4206a04f1cd1ddf73123fc6c29`, with the same files as tested head
`142117d22e140049032dba4e2c61676210649373`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39259766176)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39259766267)
passed before the squash merge.


## Static constants and complete shutdown checks (PR #169)

[PR #169](https://github.com/e6qu/fun-with-pipes/pull/169) merged as
`bbb3d530e497549316d563671f1c74c51b772934`, with the same files as tested head
`2429292d6f82d0cde46519fe7cb23c7527887e8d`.
All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39233047574),
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39232286485),
[language/tools](https://github.com/e6qu/fun-with-pipes/actions/runs/39232335383)
and [Linux/ARM Mac/Intel Mac shutdown checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39232331253)
passed before the merge.


## Self-tail recursion and shutdown repairs (PR #168)

[PR #168](https://github.com/e6qu/fun-with-pipes/pull/168) was merged by the user
as `5258c6efd0418f19add23f5e2a763563178af823`, with the same tree as
`59845d042277a0ea04f990cb4751c6ba87aa0c1e`, before complete acceptance.
It adds eligible self-tail frame reuse in both engines, cycle-proof diagnostics,
lesson 23, scheduler disposal and network connection closure before task draining.

[PR #168](https://github.com/e6qu/fun-with-pipes/pull/168) · [Language/tools](https://github.com/e6qu/fun-with-pipes/actions/runs/39211377606) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39211352992) · [Shutdown checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39211372965)

## Earlier delivery table
Earlier deliveries established native macOS ([PR #74](https://github.com/e6qu/fun-with-pipes/pull/74)),
ownership and representation ([#124](https://github.com/e6qu/fun-with-pipes/pull/124),
[#125](https://github.com/e6qu/fun-with-pipes/pull/125),
[#126](https://github.com/e6qu/fun-with-pipes/pull/126)), numerical kernels
([#127](https://github.com/e6qu/fun-with-pipes/pull/127)), checked reference counting
([#128](https://github.com/e6qu/fun-with-pipes/pull/128)), documentation and tacit
examples ([#129](https://github.com/e6qu/fun-with-pipes/pull/129),
[#130](https://github.com/e6qu/fun-with-pipes/pull/130)), and direct iterator
consumers ([#131](https://github.com/e6qu/fun-with-pipes/pull/131)). Their original
source IDs and gate links remain in the
[immutable record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#accepted-deliveries).

The following accepted merges have the same files as their tested heads. Before
PR #136 the production matrix had fewer jobs and did not establish complete
native Windows support. From #136 onward it requires all nine production jobs
plus documentation.

| PR | What changed | Merge / tested head | Passing production / docs |
|---|---|---|---|
| [#132](https://github.com/e6qu/fun-with-pipes/pull/132) | Linux ARM64, fewer iterator temporaries and more counted values | `c67800ec` / `7036eceb` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034611), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034667) |
| [#133](https://github.com/e6qu/fun-with-pipes/pull/133) | Owned decoding results and direct wide-number functions | `d14ec10d` / `70de8497` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073356), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073506) |
| [#134](https://github.com/e6qu/fun-with-pipes/pull/134) | More C/WASM ownership, numeric foundations and Windows groundwork | `5c0287c9` / `29b48c31` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38460359221), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38458685467) |
| [#136](https://github.com/e6qu/fun-with-pipes/pull/136) | Complete Windows native support, float formats, nested derivatives and checkpointing | `2684241d` / `26f2c68a` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38583750060), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38583749770) |
| [#137](https://github.com/e6qu/fun-with-pipes/pull/137) | Store/scan only the derivative prefix needed by requested outputs | `38da1401` / `37104959` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38604595248), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38604594927) |
| [#138](https://github.com/e6qu/fun-with-pipes/pull/138) | Stop storing operation metadata for original derivative inputs | `d77b3fea` / `f251fbd1` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38666526202), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38666481103) |
| [#139](https://github.com/e6qu/fun-with-pipes/pull/139) | Grow the active-tape table in chunks and preserve reusable buffers | `5d05cdd6` / `917d28a3` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38690176314), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38690140952) |
| [#140](https://github.com/e6qu/fun-with-pipes/pull/140) | Skip tape-table slots already known to be unavailable | `09f1a029` / `cdb76905` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38710624989), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38710579729) |
| [#141](https://github.com/e6qu/fun-with-pipes/pull/141) | Pair derivative metadata arrays to reduce allocation requests | `41f30475` / `f31f7b66` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38728631817), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38728600304) |

PR #135 was merged before complete platform acceptance. PR #136 fixed the
remaining failures and supplied the full passing gate; #135's merge alone is
not support evidence. These deliveries completed the previous implementation
batch. The remaining memory and performance objectives are in [PLAN.md](../PLAN.md).

## Interactive tools and cached-map borrows (PR #167)

Cached numeric-map reads avoid repeated retains: 2,000,001 become one in the
500,000-entry/two-million-query workload. The matching Xeon 8573C comparison
reproduces PR #166's layout penalty and measures the combined change 2.67% faster
than the old separate-layout program. These are fwp-versus-fwp results, not C/Rust
parity; [the benchmark report](measurements/numeric-collections.md#rechecking-the-original-xeon-slowdown)
retains slower cases, repeated samples and binary evidence.

[PR #167](https://github.com/e6qu/fun-with-pipes/pull/167) · [nine production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39141587973) · [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39141587926) · [four-host terminal probes](https://github.com/e6qu/fun-with-pipes/actions/runs/39141595653) · [language, Python, disassembly and browser checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39141618594)

## Numeric map and set construction (PR #166)

Numeric map/set construction skips temporary lists and eligible tuples, calls
known callbacks directly, and joins related buffers. At 65,536 inputs with at
most 257 keys, map requests fall 196,614 → 5 and set requests 131,077 → 4.
An unnecessary second compiler build caused the Intel macOS timeout and was
removed without reducing coverage. **At this revision, Xeon 8573C full-map tracing
was 4.4–4.6% slower**; allocation savings do not resolve that result. Cached-map
borrowing candidate `774d838c` is not part of this merge. PR #167 above supplies
the subsequent implementation and matching-host repair evidence.

[PR #166](https://github.com/e6qu/fun-with-pipes/pull/166) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39109626103) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39109626314)

## Owned C results and failure cleanup (PR #165)

C callers can own returned strings/records and release them with
`fwp_release_NAME`. Returning two aliases needs one extra owner; eligible record
fields return directly without a temporary box. Read-only inputs still copy.
Failed map/set callbacks and allocations now release partial output: 32 caught
failures leave zero bytes instead of 2,048. Windows DLL exports, toolchains,
newlines, executable paths and cancellation fixtures were repaired before the
final gate; six original production failures and eight focused failures were
not counted as passes.

[PR #165](https://github.com/e6qu/fun-with-pipes/pull/165) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39094927776) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39094927727) · [library-results-2026-10-18](measurements/library-results-2026-10-18.json) · [map-failures-2026-10-18](measurements/map-failures-2026-10-18.json)

## Server entries, exact JSON and WebAssembly task owners (PR #164)

Generated REST and MCP entries can use checked ARC. JSON keeps number text until
conversion: large integers and F128 values no longer lose precision through F64.
WebAssembly task cleanup frees the last state snapshot and pooled stacks;
browser-loader callback exceptions propagate once. Loader tests run in Node,
so actual browser-engine coverage remains open. Native cache keys now include
compiler/header identity. CSV goldens, Intel scheduling and a failed artifact
upload were repaired/retried before acceptance. The scheduling report is a
simulation, not a measured speedup.

[PR #164](https://github.com/e6qu/fun-with-pipes/pull/164) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39087594221) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39087594154) · [server-entries-2026-10-18](measurements/server-entries-2026-10-18.json) · [wasm-host-owners-2026-10-18](measurements/wasm-host-owners-2026-10-18.json) · [ci-scheduling-2026-10-18](measurements/ci-scheduling-2026-10-18.json)

## HTTP server owners and fixed function storage (PR #163)

HTTP request/connection/task owners now clean up on failure and cancellation.
A 24-byte combined handle replaces separate handle/job allocations; a 64 KiB
receive buffer moves to the stack. Socket waits use readiness and deadlines.
Keeping one copy of the existing ARC check reduces code size without removing
checks. Fixed function captures use static records: approximately 899 → 722
allocations and 2,318 → 1,901 retains per HTTP request. Paired Linux request
measurements are 4–6% faster than older fwp, not a C/Rust comparison. Failure
injection and UDP counter fixtures were repaired before acceptance.

[PR #163](https://github.com/e6qu/fun-with-pipes/pull/163) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39073022259) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39073022233) · [fixed-functions-2026-10-18](measurements/fixed-functions-2026-10-18.json)

## HTTP client owners and complete connection keys (PR #162)

HTTP clients own pooled connections, requests and copied responses through
errors/cancellation. Full connection keys distinguish long TLS options.
Repeated-call memory is bounded in the measured interval, but each extra call
still costs 237 allocations and 543 retains. ARC code is larger in this revision;
later shared-check placement addresses that. Windows socket/loading/header-order
fixtures and a stale cleanup injection were fixed before the full passing gate.
HTTP server acceptance follows in #163.

[PR #162](https://github.com/e6qu/fun-with-pipes/pull/162) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39055466891) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39055442588) · [http-client-owners-2026-10-17](measurements/http-client-owners-2026-10-17.json)

## Remote calls without tracing and record-field moves (PR #161)

Checked ARC now covers supported gRPC clients and services, including replies,
channel deliveries, errors and iterator handler lifetimes. Unique record fields
move into compiled calls; shared records retain independent owners. A greeting
needs two retains instead of three, plus one per connection. Memory counts stay
bounded, but code size grows; no elapsed-time or C/Rust parity claim follows.

[PR #161](https://github.com/e6qu/fun-with-pipes/pull/161) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39044644736) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39044644846) · [remote-arc-field-moves-2026-10-17](measurements/remote-arc-field-moves-2026-10-17.json)

## Server cleanup and borrowed fold values (PR #160)

Server tasks, jobs, method values, channels, requests and connections gain
explicit cleanup. For example, 256 greetings no longer leave per-call storage;
final charge is 544 bytes on Linux and zero on the other measured platforms.
Known fold callbacks borrow captures, removing 64 retain/release pairs per
64-message channel call. A separate 32,000-call ARM64 test exposed process-memory
growth missed by narrower counters; the complete repair passes its unchanged
8 MiB growth bound.

[PR #160](https://github.com/e6qu/fun-with-pipes/pull/160) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39030633846) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39030633906)

## Streamed input cleanup and continuation moves (PR #159)

Remote clients release sent iterators, background senders and completed tasks.
Unique iterator nodes move their continuation (the function producing the next
node); shared nodes preserve it. Repeated-call storage becomes bounded, but
complete-input modes still perform 5.7–36.8% more retains than the old
tracing-dependent implementation. Those percentages measure count operations,
not elapsed time. Early completion records actual input work because scheduling
can change how much is sent.

[PR #159](https://github.com/e6qu/fun-with-pipes/pull/159) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39016595534) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39016595480)

## Closed connections and completed I/O tasks (PR #158)

Closing a socket now also leads to release of connection/task records after
their last users finish. Previously 256 closed Linux AMD64 connections left
about 1 MiB charged; afterward only the live root-task remainder stays.
Shared connections add three retains per connection; uniquely owned internal
tasks free without task count updates. Failure/cancellation and recoverable TLS
startup errors remain covered.

[PR #158](https://github.com/e6qu/fun-with-pipes/pull/158) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39011071759) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39011071706) · [closed-remote-ownership-2026-10-17](measurements/closed-remote-ownership-2026-10-17.json)

## Freed requests and transferred selected fields (PR #157)

Completed requests and unread messages free when their owners finish, without
turning reader release into remote cancellation. A unique record can transfer
its selected owned field; shared records retain it. At 256 full reads, the
combined path uses 50,178 retains rather than 66,562 after request cleanup alone.
Allocation counts are unchanged. TLS-settings partial-construction cleanup is
also checked.

[PR #157](https://github.com/e6qu/fun-with-pipes/pull/157) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39004098429) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39004095234) · [remote-projection-moves-2026-10-17](measurements/remote-projection-moves-2026-10-17.json)

## Released stream caches and moved closure captures (PR #156)

Remote stream positions now own and release their saved values after the last
reader. Retaining an old iterator deliberately keeps its history. Unique closures
move captures into calls instead of retaining them again; shared closures keep
separate owners. At 16,384 received integers, retain counts fall from 81,921 to
49,154 versus cache ownership alone. Counts remain higher than the earlier
tracing-dependent path; connection/queue ownership follows in later deliveries.

[PR #156](https://github.com/e6qu/fun-with-pipes/pull/156) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38996879616) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38996879603) · [remote-client-capture-moves-2026-10-17](measurements/remote-client-capture-moves-2026-10-17.json)

## Shared remote reads and bounded chain cleanup (PR #155)

Repeated reads of a remote position preserve the same value. Combining its
unread source and completed result saves eight bytes per position (24 → 16).
Record/optional/tuple chains release through loops rather than one recursive
cleanup call per link, with aliases preserved. This bounds the measured cleanup
stack growth; it does not guarantee constant stack for arbitrary source recursion.

[PR #155](https://github.com/e6qu/fun-with-pipes/pull/155) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38990872293) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38990872208) · [remote-stream-compact-2026-10-17](measurements/remote-stream-compact-2026-10-17.json) · [wrapped-chain-cleanup-2026-10-17](measurements/wrapped-chain-cleanup-2026-10-17.json)

## Service settings and iteration storage (PR #154)

Service settings and outgoing headers get scoped owners; eligible captures and
argument storage avoid heap records. `each` walks with a fold instead of building
and discarding a mapped result list. A million-element counting example uses
about half the elapsed time and one fewer result-node allocation per element
than the repaired old-definition control. The first attempt was slower; known
callback specialization resolved that measured regression.

[PR #154](https://github.com/e6qu/fun-with-pipes/pull/154) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38977201910) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38977126983) · [service-context-iteration-2026-10-16](measurements/service-context-iteration-2026-10-16.json)

## Owned decoded values and network resources (PR #153)

Decoded values, DNS/socket results and temporary network buffers gain explicit
owners and partial-failure cleanup. CPU tensor execution writes directly to its
result array: 8,193 F64 outputs no longer need a separate 65,544-byte temporary
and full copy. Input/workspace storage remains; this was a memory comparison,
not a timing comparison with C/Rust.

[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38958379514) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38955543617) · [service-values-2026-10-16](measurements/service-values-2026-10-16.json)

## Less temporary memory in hashing and numerics (PR #152)

Hash pipelines avoid temporary tuples/range lists and borrow array fields.
For the measured small/large hash programs, surrounding managed requests become
two and retains zero. Fixed numeric lanes eliminate eligible list/product/splat
storage; actual loops use registers/vector instructions. Paired C/Rust reports
retain remaining overhead and slower samples. These specific programs do not
establish free abstractions for arbitrary vectors or callbacks.

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38901011355) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38901011298) · [vector-paired-2026-10-16](measurements/vector-paired-2026-10-16.json)

## Synchronous WASI ownership and streaming hashes (PR #151)

Synchronous WASI main/function/CLI entries can use checked ARC and release
module-owned values at shutdown. Native structural hashing feeds bytes directly
into FNV-1a instead of allocating an encoded buffer; output still agrees with
the interpreter. Hash-buffer allocation disappears, while surrounding pipeline
costs remain at this revision.

[PR #151](https://github.com/e6qu/fun-with-pipes/pull/151) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38872161681) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38872161673)

## Numeric zip intermediates and owned list/text results (PR #150)

Known numeric `zip | map` pipelines avoid temporary pairs and zip list nodes.
Returned lists still need storage. List/text constructors gain owned-result and
failure cleanup; WASI size checks preserve 32-bit request limits. Derivative
allocation/count savings are measured separately from timing; small cases can
still be slower.

[PR #150](https://github.com/e6qu/fun-with-pipes/pull/150) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38851567232) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38851565415) · [zip-maps-2026-10-16](measurements/zip-maps-2026-10-16.json) · [zip-map-cpu-2026-10-16](measurements/zip-map-cpu-2026-10-16.json)

## Owned processes and numeric mapped arrays (PR #149)

Process/pipe results and interrupted operations gain cleanup with correct signal
behavior. Numeric `map | array.from-list` skips temporary mapped list nodes while
preserving callbacks and traps. Direct numeric work improves substantially;
repeated derivative and tiny nested cases have their own mixed timings. Windows
process probes use native executable and handle rules.

[PR #149](https://github.com/e6qu/fun-with-pipes/pull/149) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38841118993)

## Record moves and application utilities (PR #148)

Unique flattened/boxed records transfer fields; shared aliases keep owners.
Working-directory, clock, empty-map/set and Boolean results get checked ownership.
Missing directories report errors in both engines and logs emit one newline.
The matrix output-pointer experiment was not adopted: smaller code did not give
a dependable speed improvement.

[PR #148](https://github.com/e6qu/fun-with-pipes/pull/148) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182)

## Numerical precision and filesystem ownership (PR #147)

Six F64 solvers own scratch/results, and array loops borrow invariant data
addresses. Reverse differentiation preserves F128 seeds, weights and accumulated
derivatives without narrowing through F64. Console/environment/filesystem results
clean up on failure; paths reject embedded zero bytes before OS access. This
preserves precision and ownership, not universal numerical speed parity.

[PR #147](https://github.com/e6qu/fun-with-pipes/pull/147) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38814786923) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38814787519)

## Checked boundaries and numerical kernels (PR #146)

Checked C-library calls initially accept copied inputs and pointer-free results;
later #165 adds owned strings/records. Channel payload restrictions reject values
that could capture the channel. List transpose cleans partial columns; allocator
charging includes its first small allocation. Fixed-size copies expose matrix
vectorization and proved taskless programs omit scheduler ticks. An Intel
compiler abort passed an unchanged retry; its historical cause remains unknown.

[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349673) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349640) · [numerical-memory-modes-2026-10-15](measurements/numerical-memory-modes-2026-10-15.json)

## Infix arithmetic and numeric loop cleanup (PR #145)

`2 + 3 * 4` now uses standard mathematical precedence while functions remain
curried and single-argument. Proven bounded internal array increments avoid
per-element cleanup; ARC omits tracing liveness barriers. Benchmark order is
rotated, and tutorial source/output copies agree again. The sampled fused
reductions allocate no intermediate storage; changed timing methods prevent an
isolated before/after speed claim.

[PR #145](https://github.com/e6qu/fun-with-pipes/pull/145) · [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284746) · [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284697) · [ownership-performance-2026-10-15](measurements/ownership-performance-2026-10-15.json)

## Documentation rewrite (PR #142)

The guides/tutorials gained introductory explanations and explicit C/Rust
benchmark baselines. Tutorial fixes also repaired a C-buffer leak and incorrect
bill-remainder distribution. Merge `bbdbf8dc` matches PR head `4ea1b687`, but
was made **before CI finished**. The [production run](https://github.com/e6qu/fun-with-pipes/actions/runs/38752839908)
found a stale OpenAPI description expectation; [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38752840023)
also has its own record. PR #143 supplied the fixture repair; later accepted
#145 includes the corrected documentation/tutorial checks. The early merge
itself is not passing platform evidence.

[PR #142](https://github.com/e6qu/fun-with-pipes/pull/142)

## Accepted paired metadata allocations (PR #141)

[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141) merged as
`41f30475c5e59951e784fe686aa6c69c7f2738e3`. Its tested head was
`f31f7b66b8ea625c86161cf2978732bcd9be310d`, with identical files.
[Four-platform derivative tests](https://github.com/e6qu/fun-with-pipes/actions/runs/38726490082)
and [both WebAssembly checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38726508454)
passed at runtime revision `24620eadbcc8c03fa1aefc2190bf1af483720840`.
The final production/docs gates are in the table above.

[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141) · [Recorded measurements](measurements/ad-metadata-2026-10-15.json)

## Source identities

[Preparation records](preparation-records.md) retain the immutable commit/tag
mapping used by the documentation audit. The detailed pre-overhaul narrative is
available in [the merged source](https://github.com/e6qu/fun-with-pipes/blob/380fa8412327e52db420b96918d20e2528bbfc7c/docs/roadmap-history.md).
It is historical evidence, not instructions for current work. Numerical samples
and acceptance records remain in the repository with their original identities.
