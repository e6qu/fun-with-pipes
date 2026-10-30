# Measurement reports

Each report names the measured source, inputs, implementation variants and limits.
Read [the benchmark guide](../benchmarks.md) first for ratios and memory terms.
The files here are evidence at recorded revisions, not live project status.
[The plan](../../PLAN.md) owns unfinished work; [delivery history](../roadmap-history.md)
records merges and platform validation. Raw JSON retains samples and source/tool
identities. Do not edit observations to make an old experiment describe new code.

## Ownership costs

- [Directory allocation-boundary failures](directory-failures.md): partial-owner cleanup, caller aliases, deliberate leak controls and the separate terminal OOM contract.

- [Parser workspace comparison](parser-workspace.md): four accepted sessions, C/Rust gaps, allocation tradeoffs and retained failed controls.

- [Remaining ARC operations after GC removal](arc-residual-costs.md): per-owner attribution and static-callback reduction.
- [Unique local arrays without counts](unique-array-storage.md): verified storage, lifetime proof and native/WASI cleanup.
- [Scalar reads and sort callbacks](sort-key-ownership.md): remove temporary String and pair owners.
- [Contiguous sort keys](inline-sort-keys.md): remove key boxes, with exact allocation budgets and separate sorting-time controls.

## Function calls and recursion

- [Call-cost matrix and mutual-loop decision](../functional-costs.md): verified scopes and budgets, measured comparisons and remaining costs.

## Numerical applications

- [Nested derivative costs](ad-depth.md): audited F64/F128 depth/size comparisons with explicit fwp formulas, including allocation, code and stack costs; verified in #226.

- [Eager capture bindings](eager-captures.md): 13–72% less updated-solve time in initial sessions; a repaired-source zero-update recheck still exceeds its limit. All outcomes and C/Rust gaps remain visible.
- [Current derivative costs](descent-costs.md): initial and matched-host sessions, phase/memory observations and unresolved short-case timing noise.
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

## Current CPU kernels

- [Array and matrix baselines](kernel-baselines.md): four sizes, exact output checks and separate computation/allocation-inclusive timings; one expanded array noise control remains inconclusive.
- [Timing variation and GCC reports](timing-variation.md): retained failed controls, the matrix sampling repair and the typed loop-state experiment. Representation checks alone do not prove a speedup.

## Compiler cost

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
