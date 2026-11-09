# Measurement reports

Each report names the measured source, inputs, implementation variants and limits.
Read [the benchmark guide](../benchmarks.md) first for ratios and memory terms.
The files here are evidence at recorded revisions, not live project status.
[The plan](../../PLAN.md) owns unfinished work; [delivery history](../roadmap-history.md)
records merges and platform validation. Raw JSON retains samples and source/tool
identities. Do not edit observations to make an old experiment describe new code.

## Current diagnosis

[Returned arrays across fwp/C/Rust/Swift](returned-buffer-time-2026-11-09/README.md)
now separate construction, reading, release and RSS. ARM64 shows lower overall
time on some large cases but slower reading and costly empty-array churn. Many
AMD64 comparisons remain inconclusive under the unchanged copy controls.

[Structured-gradient methods](structured-gradient-methods-2026-11-08/README.md)
compares reverse, forward, local and tensor AD across three objective shapes.
All four sessions pass correctness/storage audits; noisy timing controls remain
inconclusive. [Known array callback results](structured-array-callbacks-2026-11-08/README.md)
now verify fewer derivative-object allocations and 85–91% less large-case
computation in both ARM64 sessions. AMD64 timing acceptance remains open because
copy controls fail. [Full platform delivery passes](structured-callback-delivery-2026-11-09/README.md).
[Frozen candidate contract](structured-autodiff.md#selected-change-known-array-callbacks).

[Weak phases, storage and actual target reuse now pass](weak-operation-verification-2026-11-09/README.md)
on Linux ARM64/AMD64. [Weak timings](weak-operation-time-2026-11-09/README.md)
show substantial C/Rust lookup gaps and mixed Swift results. The
[fwp census](weak-operation-census-2026-11-09/README.md) verifies a temporary
16-byte result allocation per successful lookup in this caller.
[Queued-service results and cleanup](weak-callback-service-2026-11-09/README.md)
and [native service allocation profiles](weak-callback-profiles-2026-11-09/README.md)
pass. [Complete-service timing](weak-callback-time-2026-11-09/README.md) now passes
both sessions on both hosts: large full delivery takes 18.65–20.23× C's time and
5.12–6.70× Swift's, with less process RSS than Swift but more than C/Rust.
[Parser process memory](parser-process-memory.md) exposed
[an entry cleanup bug](parser-entry-cleanup-2026-11-09/README.md); its repair and
the memory observations pass on both Linux hosts. [Actual parser accounting](parser-process-accounting-2026-11-09/README.md)
now separates accountable address ranges from resident pages. Allocator resize
calibration also passes; actual parser internal peaks remain open.

## Latest deliveries

Merged #272 delivers known array callback specialization and structured-gradient
comparisons. [All final gates pass](structured-callback-delivery-2026-11-09/README.md);
its original timing-control limits remain explicit.

Merged #271 delivers [captured scalar array-map reuse](captured-array-maps.md);
[all final gates pass](captured-map-delivery-2026-11-08/README.md).
[Initial safety checks](captured-map-checks-2026-11-08/README.md) pass.
[Repaired measurements](captured-map-repaired-2026-11-08/README.md) show 84–94%
less computation on both largest applications and no qualified regression.
Noisy controls leave combined timing acceptance open.
[Initial results](captured-map-initial-2026-11-08/README.md) remain unchanged.

Merged #270 passes [all delivery gates](fresh-array-delivery-2026-11-08/README.md).
Its [shared loop/array investigation](shared-loop-array-costs.md) retains unmet
performance targets.
The [metadata candidate](borrowed-array-metadata-2026-11-08/README.md) misses
its target; these are diagnostic results, not another delivered optimization.
The [fresh F64 output diagnostic](fresh-array-diagnosis-2026-11-08/README.md)
selects the replacement candidate. [Production comparison](fresh-array-costs-2026-11-08/README.md)
confirms ARM64 gains and unchanged managed costs; AMD64 timing acceptance remains
open. [C/Rust computation and process memory](loop-array-peers-2026-11-08/README.md)
separate useful work from input construction and release.

- [Computed numeric inputs and local derivatives](computed-numeric-time-2026-11-07/README.md):
  #269 removes 407,552 temporary requests from its largest measured process;
  qualified long cases take 48–65% less time than ordinary reverse AD. The helper
  remains experimental and one runtime copy control is inconclusive.
- [Compiler costs](computed-numeric-analysis-2026-11-07/README.md): all fourteen
  time/RSS comparisons meet 5% limits; two copy controls remain inconclusive.
- [Native proof cases](computed-numeric-inputs-2026-11-07/README.md): values,
  shared inputs, evaluation/trap order and the actual four-number call.

These results lead to the [structured autodiff comparison](structured-autodiff.md)
in [PLAN.md](../../PLAN.md).
Older reports below retain their own sources and decisions; “current” in a dated
experiment names its measured variant, not the latest compiler.

## Ownership costs

- [Scalar Swift closure allocations](swift-scalar-closures-2026-11-09/README.md): one 24-byte native request per closure on both architectures; actual omitted-release and unwinder controls. ARC operations remain unmeasured.

- [Matched four-language buffers](four-language-buffers-2026-11-09/README.md): 840 native cases, 42 interpreter checks and 24 real barrier-fault builds per host; no timing claim.

- [Native weak registrations](weak-peer-checks-2026-11-09/README.md): C/Rust/Swift cancellation, active-owner lifetime and expiration; six actual fault builds per host. No time or ARC-count claim.

- [First ownership peer checks](ownership-peer-checks-2026-11-08/README.md): Swift/C/Rust buffer correctness, C/Rust parser allocation lifetimes and native stack frames on ARM64/AMD64. Includes the repaired observer failure; no new peer timing claim.
- [Returned-buffer phases and storage](returned-buffer-phases-2026-11-09/README.md): four-language phase correctness and native C/Rust/Swift allocation/release checks on both architectures. Separates Swift metadata from array storage and retains all initial failures; timings remain uncollected.

- [Swift allocation attribution](swift-allocations.md): pipeline/map allocator stacks and separate fwp managed counters; audited ARM64/AMD64 profiles and allocation/release controls; individual ARC counts remain unmeasured.

- [Swift, C, Rust and fwp](swift-peers.md): seven programs on four native sessions, elapsed time and resident RAM; repeated ARM64 results, failed noise controls and different AMD64 CPUs remain explicit.

- [File errors and borrowed handles](file-boundary-portability.md): native Windows coverage, legal C recovery contexts and exact cleanup/error controls; complete delivery verified in #230.

- [Direct string results](direct-string-results.md): two rejected experiments and a byte-search candidate with four qualified sessions, explicit C/Rust gaps, allocation savings and code/stack costs; complete delivery verified in #229.

- [File-read allocation failures](file-read-failures.md): text/byte scratch, handle and prior-result cleanup probes; focused Clang/GCC and complete six-host production checks pass in #229.

- [Directory allocation-boundary failures](directory-failures.md): partial-owner cleanup, caller aliases, deliberate leak controls and the separate terminal OOM contract.

- [Parser workspace comparison](parser-workspace.md): four accepted sessions, C/Rust gaps, allocation tradeoffs and retained failed controls.

- [Remaining ARC operations after GC removal](arc-residual-costs.md): per-owner attribution and static-callback reduction.
- [Unique local arrays without counts](unique-array-storage.md): verified storage, lifetime proof and native/WASI cleanup.
- [Unique-buffer C/Rust comparison](unique-buffer-peers.md): verified direct folds and array elimination; failed timing controls and remaining peer comparisons stay open.
- [Scalar reads and sort callbacks](sort-key-ownership.md): remove temporary String and pair owners.
- [Contiguous sort keys](inline-sort-keys.md): remove key boxes, with exact allocation budgets and separate sorting-time controls.

## Function calls and recursion

- [Returned functions](returned-callables.md): C/Rust storage baseline, borrowed-call count reductions and the retained ARM code-size rejection; Swift ownership controls and phase timing are tracked separately.

- [Call-cost matrix and mutual-loop decision](../functional-costs.md): verified scopes and budgets, measured comparisons and remaining costs.

## Numerical applications

- [Gradient call storage](gradient-call-storage.md): scoped input borrowing, fold fields, direct backward seeds and coordinate scratch; delivered in #259, with timing misses retained.
- [Gradient allocation sites after numeric-storage reuse](gradient-storage-2026-11-05/README.md): audited phase counts, constructors and two retain sites at the recorded source.

- [Private derivative inputs](packed-derivative-inputs.md): one buffer replaces
  private record boxes and list cells while keeping evaluation order. Native
  correctness and compiler-cost limits pass. [Runtime results](packed-input-time-2026-11-04/README.md)
  show lower allocation/live managed storage and faster long solves; three AMD64
  timing limits remain open.
- [Immediately matched list results](matched-option-time-2026-11-04/README.md):
  removes one temporary allocation and retain per history solve; some larger
  cases remain slightly slower within the declared limit. Verified in PR #256.

- [Final iteration values](final-iteration-time-2026-11-04/README.md): four audited
  sessions; largest history case uses 97.7% less peak managed storage and runs
  5.1–5.9% faster. Five speed targets and one small-case regression remain open.
  [Native verification](final-iteration-storage-2026-11-03/README.md) is separate
  from final platform delivery.

- [Materialized array construction](array-construction-phases-2026-11-02/README.md):
  source generator, C driver, C and Rust with separate construction/consumption
  timers; repeated ARM64 results, failed AMD64 controls and explicit storage costs.
- [Direct scalar-capture calls](scalar-array-captures-2026-11-02/README.md): verified
  safety and lower call costs, 84.5–84.9% less ARM64 construction time, unchanged
  managed storage, remaining C/Rust gaps and eight failed AMD64 timing limits.

- [Typed derivative owners](typed-derivative-owners.md): F128/nested-tape work
  delivered in #237; stack-record, initialization and result-transfer counts, plus alias,
  failure and cancellation controls. Counts are not timing evidence.

- [Array traversal without temporary lists](array-list-traversal.md): verified allocation reductions in numerical and gradient results; rejected allocation and timing observations retained.

- [Nested derivative costs](ad-depth.md): audited F64/F128 depth/size comparisons with explicit fwp formulas, including allocation, code and stack costs; verified in #226.

- [Eager capture bindings](eager-captures.md): 13–72% less updated-solve time in initial sessions; a repaired-source zero-update recheck still exceeds its limit. All outcomes and C/Rust gaps remain visible.
- [Earlier derivative costs](descent-costs.md): initial and matched-host sessions, phase/memory observations and unresolved short-case timing noise.
- [Current output versus checksum costs](descent-output-current.md): four audited sessions; short noisy controls and host differences remain visible.

These reports follow different versions of derivative descent. Read the variant table and timing boundary before comparing ratios across reports. A protocol describes an experiment, not an outstanding task.

- [Gradient descent: keeping weights without keeping their history](ad-application.md)
- [Derivative descent compared with explicit C and Rust](descent-peers.md)
- [Descent with packed arrays instead of intermediate lists](packed-descent.md)
- [Array-owner moves: half the retains, uncertain timing gains](array-owner-moves.md)
- [Borrowing array captures in numerical descent](array-capture-descent.md)
- [Smaller binaries for directly called functions](direct-call-entries.md)
- [Keeping known callback captures in local variables](callback-locals.md)
- [Checking memory after every solve](descent-observers.md)
- [Separating repeated work from process-startup noise](descent-batch-protocol.md)
- [Repeating complete numerical solves](descent-batches.md)
- [Comparable coordinate work in fwp, C and Rust](coordinate-work-protocol.md)
- [Matching the numerical formula in C and Rust](coordinate-work.md)
- [Separating numerical work from output construction](descent-output-protocol.md)
- [Initial output-cost diagnostic](descent-output-initial.md)
- [Repeated output-cost measurements](descent-output-longer.md)
- [Reusing rounded digits when printing floats](float-text.md)
- [Float printing: repeated results](float-text-results.md)
- [Removing temporary numeric lists](array-text.md)
- [Array allocation, layout and startup costs](array-native-results.md)
- [Numerical output after removing temporary lists](array-output-results.md)
- [Array and matrix kernels: recorded comparison](numerical-kernels.md)

## CPU kernel comparisons

- [November 2 array and matrix costs](current-kernel-costs.md): fwp at the recorded revision, a same-source word-state reference, C and Rust; separate calculation/allocation timings and two identical-copy controls.
- [Earlier array and matrix baselines](kernel-baselines.md): predates typed loop state; exact output checks and four sizes, with one expanded array noise control still inconclusive.
- [Timing variation and GCC reports](timing-variation.md): retained failed controls, the matrix sampling repair, typed loop-state checks and the unsuccessful executable-name diagnostic. Representation checks alone do not prove a speedup.

## Compiler cost

- [Packed input compiler cost](packed-input-analysis-2026-11-04/README.md): seven
  inputs on two architectures; maximum time/RSS increases of 4.32%/0.82%, with
  all live-work and identical-copy checks passing.
- [Final-iteration compiler cost](final-iteration-analysis-2026-11-04/README.md):
  nine passing timing cases, one noisy AMD64 case and separate process-memory bounds.
- [Ownership analysis: creation-site correctness, paired cost and size budgets](ownership-analysis.md)
- [CI compiler build cost](ci-compiler-profiles.md)

## C and Rust comparisons

- [CPU calculation, startup and output: measured diagnostics](cpu-phases.md)
- [Decimal counting: accepted tree measurements and retained failures](decimal-count.md)

These compare complete implementations, including the differences each report names. Use checked-peers for the signed-overflow-aligned seven-program snapshot; older reports retain their original arithmetic rules.

- [Checked arithmetic in the benchmark peers](checked-peers.md)
- [Checked ARC compared with C and Rust](arc-comparison.md)
- [Current word-frequency costs and fixed limits](wordfreq-current.md): four audited sessions, complete C/Rust comparisons and explicit short-input variation.
- [Word-frequency application: first C/Rust comparison](wordfreq.md)
- [Avoiding copies when text stays unchanged](unchanged-text.md)
- [Moving strings through a list map](string-map-ownership.md)
- [Count characters without building integer text](integer-text.md)
- [Count integer characters with less arithmetic](integer-counting.md)
- [Keep numeric bounds through checked multiplication](checked-products.md)
- [fwp, C and Rust: complete-program elapsed time](range-set-peers-2026-10-19.md)
- [fwp, C and Rust: complete-program elapsed time](numeric-hash-pre-repair-peers-2026-10-19.md)
- [fwp, C and Rust: complete-program elapsed time](numeric-output-peers-2026-10-20.md)

## Ownership and storage

These establish selected ownership, allocation, layout or cleanup properties. Count and byte savings do not by themselves establish a timing improvement. Reports that also time programs state their comparison separately.

- [ARC allocator metadata and late diagnostic options](arc-metadata.md)
- [Reading captured arrays without extra owners](array-capture-borrows.md)
- [Owning strings received by C callbacks](callback-inputs.md)
- [Borrowing a channel during a direct call](channel-direct-borrows.md)
- [Borrow a channel through temporary local names](channel-local-borrows.md)
- [Keeping loop state in local fields](channel-loop-state.md)
- [Matching local callbacks without temporary tuples](channel-match-results.md)
- [Receiving a message without allocating its wrapper](channel-receive-results.md)
- [Counting channel ownership operations](channel-transfer-protocol.md)
- [Moving a matched variant's payload](channel-variant-moves.md)
- [Cleanup when collection operations fail](collection-cleanup.md)
- [File applications: repeated edits and failed work](file-applications.md)
- [Borrow channels carrying functions](function-channel-borrows.md)
- [Memory between JSON API requests](http-application-memory.md)
- [Cleaning up interrupted list copies](list-copy-cleanup.md)
- [List and array sort storage](list-sort-storage.md)
- [Moving list elements and reusing array storage](array-sort-ownership.md)
- [C pointers without tracing collection](manual-pointers.md)
- [Checking queued callbacks and handled errors](queued-callbacks.md)
- [Checking callbacks that retain data queues](queued-data-channels.md)
- [Queued callbacks that send service responses](queued-grpc-responses.md)
- [Queued callbacks that retain task handles](queued-task-handles.md)
- [Checking value and call cleanup without tracing](record-cleanup.md)
- [Moving an array owner out of a temporary record](stack-array-ownership.md)
- [Matching task results without a temporary box](task-await-fields.md)
- [Cancellation state on task stacks](task-cancellation.md)
- [Sending task handles through channels](task-channels.md)
- [Saved CPU state in task stacks](task-contexts.md)
- [Compact task records](task-records.md)

## Rejected or inconclusive experiments

These are completed experiments, not instructions to adopt or retry the candidate. Keep their slower results and failed screens visible when proposing related work.

- [Test whether checked arithmetic hides useful numeric bounds](checked-bounds-protocol.md)
- [Checked arithmetic experiment: no compiler change selected](checked-bounds-results.md)
- [Forward derivative allocation and ownership accounting](derivative-forward-costs.md): original protocol and verified #239 delivery; its failed timing limits remain open.
- [Measuring the remaining numerical helper call](descent-call-protocol.md)
- [Scalar helper calls: inlining did not meet the speed target](descent-call-costs.md)
- [Measure work skipped by an already ordered sort](map-order-protocol.md)
- [Ordered-sort experiment results](map-order-results.md)

## Open investigation

This is a correctness investigation, not a performance measurement or evidence that the cause was repaired.

- [Intel macOS compiler abort: investigation](compiler-abort.md)

## Earlier implementation comparisons

These reports preserve the protocols, slower results and limitations formerly
embedded in the benchmark overview. Each describes recorded revisions, including
intermediate implementations that have since been replaced.

- [List iteration compared with its previous definition](list-iteration.md)
- [Numeric backward prefix](ad-backward-prefix.md)
- [Operation-only autodiff metadata](ad-operation-storage.md)
- [Autodiff registry growth](ad-registry-growth.md)
- [Autodiff registry search](ad-registry-search.md)
- [Paired autodiff metadata allocations](ad-metadata-layout.md)
- [Selecting invariant array data once](array-loop-borrows.md)
- [Where derivative allocations occur](ad-allocation-sites.md)
- [Building numeric arrays without temporary list nodes](mapped-array-construction.md)
- [Mapping numeric pairs without building a temporary zip](numeric-zip-maps.md)
- [Hashing values without constructing their encoded bytes](numeric-hashing.md)
- [CPU tensor output storage](cpu-tensor-storage.md)
- [Fixed-size lane calculations against C and Rust](vector-lanes.md)
- [Storage for received stream values](received-stream-storage.md)
- [Stack use when releasing wrapped chains](chain-cleanup.md)
- [Memory used by complete remote-stream clients](remote-client-storage.md)
- [Memory left behind by repeated remote calls](repeated-remote-storage.md)
- [Server memory after completed remote calls](remote-server-storage.md)
- [Fixed function values in the HTTP server](fixed-functions.md)
- [Generated REST and MCP server memory](generated-server-storage.md)
- [WebAssembly task and browser-loader ownership](wasm-host-storage.md)
- [Returning owned values to C callers](library-results.md)
- [Cleanup after failed map and set operations](map-failure-cleanup.md)
- [Building numeric maps and sets without temporary lists](numeric-collections.md)

## Earlier datasets

Some early experiments have a JSON record without a separate prose report.
These are historical observations, not current compiler budgets:

| Dataset | Comparison or check |
|---|---|
| [Numerical kernels](numerical-kernels-2026-10-12.json) | Earlier array/matrix C/Rust measurements |
| [Ownership and ARC](ownership-and-arc-2026-10-12.json) | Earlier memory-mode and scoped-lifetime checks |
| [Native ownership](native-ownership-2026-10-13.json) | Iterator transformations and derivative buffer reuse |
| [Construction and workers](reconstruction-and-workers-2026-10-13.json) | Direct array/state paths and numeric workers |
| [Wide records](wide-records-2026-10-14.json) | Typed and generic numeric boundaries |
| [Checkpointing](checkpoint-2026-10-14.json) | Storage versus recomputation at recorded checkpoint intervals |
| [Ownership/performance](ownership-performance-2026-10-15.json) | Recorded reduction cleanup and derivative allocation counts |

Other dated JSON files are linked by their corresponding reports or delivery
records. A missing or expired external artifact is a limitation of that evidence;
regenerating a binary does not recreate the original measured binary.

[Functional call observations](functional-calls-2026-10-28.json) retain the eight
known/boundary pairs. The [second mutual-recursion session](mutual-recursion-2026-10-28-second.json)
retains an inconclusive noisy row; [the guide](../functional-costs.md) explains
why the accepted comparison uses longer batches with unchanged acceptance limits.

[CPU baselines](cpu-baselines.md) define the current repeated loop/text-length
comparison and frozen-budget rules. [Longer recursion measurements](mutual-recursion-2026-10-28-long.json)
complete the accepted scalar-pair decision without discarding the noisy session.

[Proved scalar bounds](proved-scalar-bounds.md) rejects both range-index and
character-sum candidates under the unchanged CPU limits. Boundary tests, all
observations and report-integrity checks remain; no compiler speedup is accepted.

[Returned-function phases](callable-phases.md) freezes the next C/Rust/Swift/fwp
construction, invocation and release comparison, including the same-source control.
