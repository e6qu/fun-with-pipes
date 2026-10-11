# Session handoff

Updated 2026-10-11. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff. The
[queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
contains detailed checks and superseded instructions. Root docs are authoritative;
prepared branch docs are historical snapshots.

Durable recovery: `roadmap/handoff-pr123-20261011`. The latest completed
checkpoint is becc2fae2deceeec90afda6eb526801b64acb92f; the current cache-lifetime
checkpoint publication is recorded in /private/tmp/fwp-cache-lifetime-checkpoint.json.
It retains all11 authoritative docs and fourteen recovery/inventory/repair drafts
under `scripts/roadmap-recovery/`. Restore helpers there if /private/tmp is lost;
copy the inventory pair into repo `scripts/` before running its audit on GitHub.
Publication verifies source blobs, not draft execution or production acceptance.
The latest accepted-status corrections and cache recipe await the new exact-head
recovery audit. Earlier cancelled audit records are archived in history.

The saved goal controller is active again, verified by get_goal on this resumed
turn. Keep the full objective active: phases2–6 remain unfinished. Queued CI and
failing tests remain work to monitor and fix, not roadmap stop conditions.

## Execution contract

Finish the plan automatically, one coherent bundle production PR at a time. The
user requested larger related bundles to reduce testing cycle time. Preserve
all included regression/negative controls; run the full matrix once per final
bundle head. Keep one production PR open at a time. Publication,
repairs and squash merges are authorized across sessions. Fix failing checks;
CI gates merging while independent preparation continues. Preserve the language
semantics and phase order in PLAN. Require all six exact-head jobs and roadmap_docs:
`test`, `bench`, `macos (macos-15)`, `macos (macos-15-intel)`,
`macos_gc (macos-15)`, `macos_gc (macos-15-intel)`. Skipped, queued, cancelled,
superseded or earlier-head runs do not pass a gate. Regular macOS excludes only
the golden GC stress suite; dedicated GC jobs execute it.
The user also authorized the boy scout rule: fix encountered issues and bugs
even outside the current roadmap item. Preserve original controls and record
actual validation; bundle coherent fixes without changing the phase order.

Every entire commit message is one line, at most 80 characters, with no body,
trailers or attribution. Use ordinary author metadata. Squash with an explicit
subject, empty body and exact-head match. Verify the raw resulting message,
one parent and complete-tree parity before updating main.

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Main and next delivery

Main is `68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4` (PR #122). Accepted frozen head
`31d038c4ea78cbea81e1001f1662ef7bb771bbfa` passes all six jobs in CI38123585926 and
roadmap_docs38123585877 before match-head squash at 2026-10-11T09:15:55Z.
Subject `Own typed compiler values and task and channel lifetimes` has 56 characters, one line,
empty body and no trailers or attribution. One parent `0f32e7560398c048478c4186c63d90c32e7c1727`
and complete tree `ccb67ec38e9ee3adfa222dcd1979374da688a9d7` match the tested head. All11 live docs
were hashed in /private/tmp/fwp-main-docs-pre122 and restored byte-for-byte.
Protected main update0.05CPU/0.26elapsed and acceptance record0.00CPU/0.14elapsed
pass; docs audit44/106/59 passes0.73CPU/5.16elapsed. Actual-main docs38127751825
is queued. Duplicate production38127751789 has the identical tested tree and
was cancelled after strict gate/tree proof checks,0.15CPU/3.18elapsed.
Queue33 and35–53 are accepted; queue34 is a verified duplicate. Bundle44–53
adds direct typed variant alias transfer, nominal match/field cleanup context,
CAF cache/evaluation ownership, retained task captures, deadlines/scopes,
counted task handles and typed channel queues. Original regression and negative
controls remain unchanged, including GC/reuse and raw interpreter agreement.
Channel close preserves queued values; automatic unreachable-cycle reclamation
remains unproved. Phase2 is incomplete; phases3–6 are pending.

[PR123](https://github.com/e6qu/fun-with-pipes/pull/123) is the sole open
production PR, bundling library/OpenCL/TLS/file/resource items54–73 plus the
pointer and raw-memory string-copy repairs. Published head
b0ae00d5512df825271970cafcf569f52dbfc0cd, nativefd930e541db6, is on this actual
PR122 squash. All42 original commits and probes plus both new repairs remain;
accepted diagnostics inherit exactly. Eight focused tests and65 library units,
lint and format pass at identical native source hashes. Publication2.41CPU/
22.57elapsed and PR creation0.18CPU/4.35elapsed pass. Full CI38128387224 and
docs38128387231 remain pending. Intel macOS GC stress passes. Regular ARM job
114437427481 started at11:39:35UTC; formatting and lint pass, and its full
non-GC test gate is running. The other four production jobs and docs are queued.
Require all seven passing gates before squash. Latest remote
status: /private/tmp/fwp-roadmap-active-ci-status.json; refresh with the remote
administration helper /private/tmp/fwp-monitor-roadmap-ci.py.
Next concrete action: monitor/fix those gates, then squash with the recorded
one-line subject and empty body. Prepare74–112 on a GitHub runner while CI runs;
open its production PR after123 merges. Independent evidence does not replace
production gates. Phases2–6 remain incomplete.

Prepared acceptance helpers (not executed): /private/tmp/fwp-merge-pr123.py
requires every exact-head gate; /private/tmp/fwp-protect-main-after123.py checks
the raw squash message, parent/tree parity and protects all11 docs before FF;
/private/tmp/fwp-record-pr123-acceptance.py removes20 accepted live rows and
updates the next bundle. The acceptance update is a draft, not a passed check.
Run local updates and audits through the guard when resource limits permit;
move final bundle rebasing to GitHub if the reserve remains below64GiB.

## Evidence and preservation requirements

Completed independent evidence is archived in
[history](roadmap-history.md#archived-completed-evidence-before-pr122-acceptance).
Original tests ran once per architecture, with zero ignored; controls,
C/binaries/flags/disassembly and proof JSON remain retained. These runs do not
replace the final production gates or establish speed/collector-free support.

| Evidence | Passing CI | Frozen evidence head | Proof in /private/tmp |
|---|---|---|---|
| Queue44 variant alias | 38104532520 | ded20c6239f6 | fwp-variant-alias-layout-passing-proof.json |
| Queue45 nominal match | 38105588952 | 8d138284bdd2 | fwp-match-context-layout-passing-proof.json |
| Queue46 field projection | 38106022932 | 1494a3300d23 | fwp-field-context-layout-passing-proof.json |
| Queue47 CAF caches | 38106592858 | 1a873414e446 | fwp-caf-layout-passing-proof.json |
| Queue48 inlined CAF arguments | 38124620463 | 15c2f44d32ec | fwp-inline-caf-layout-passing-proof.json |
| Queue43 record conversion, accepted #121 | 38101505851 | 342d7d47a729 | fwp-record-conversion-layout-passing-proof.json |
| Prepared112 primitive inventory | 38099556010 | 669c19e7cb67 | fwp-primitive-inventory-passing-proof.json |
| Full prepared112 integration, seven gates | 38048222203 | 0f8c53199b2c | fwp-full-0f8c531-passing-proof.json |

Preserve inherited worker, HTTP2/x86 root and static-handler fixture repairs,
exact omission/allocation controls, raw interpreter comparisons and original
multi-commit repairs. Rows77–78 require actual mandatory WASI on Linux in both
free modes. OpenCL57–58 fake APIs do not establish hardware coverage. Recheck
the finite primitive inventory against actual merged source at phase2 exit.

PR123 branch: `ownership-library-resource-bundle`; worktree:
/private/tmp/fwp-library-resource-bundle-worktree. The final rebase preserves
every tested native byte. Publication journal:
/private/tmp/fwp-library-resource-bundle-publication.json.

## Remaining ownership deliveries

Original focused checks are preserved in
[history](roadmap-history.md#prepared-ownership-checks-retained-during-handoff-streamlining).
Use actual bases below, never immutable OLD parents. Preserve all11 root docs
when resolving conflicts. Remove a live row only after verified acceptance or
a verified duplicate, retaining its queue anchor and history. All listed
preparations need final squash rebases and all seven exact-head production gates.

| Row / branch | Current head | Actual current base | Delivery status |
|---|---|---|---|
| 54 ownership-library-results | 46afd27c986c | b304e91f628c | PR123 exact-head gates pending |
| 55 ownership-library-inputs | 96ee4fd963e3 | 46afd27c986c | PR123 exact-head gates pending |
| 56 ownership-library-unload | 6c367aa9a921 | 96ee4fd963e3 | PR123 exact-head gates pending |
| 57 ownership-opencl-lifetime | 3dd39a69a430 | 6c367aa9a921 | PR123 exact-head gates pending |
| 58 ownership-interpreter-opencl | 4119be1cdaf9 | 3dd39a69a430 | PR123 exact-head gates pending |
| 59 ownership-tls-listeners | f5e2a298537d | 4119be1cdaf9 | PR123 exact-head gates pending |
| 60 ownership-library-resources | 3eb64f54869f | f5e2a298537d | PR123 exact-head gates pending |
| 61 ownership-grpc-server-cleanup | ca75ca461682 | 3eb64f54869f | PR123 exact-head gates pending |
| 62 ownership-tls-cache-failures | 0b51abc49371 | ca75ca461682 | PR123 exact-head gates pending |
| 63 ownership-tls-wire-preparation | 2c2c562401ab | 0b51abc49371 | PR123 exact-head gates pending |
| 64 ownership-connect-cancellation | d7641a1ab055 | 2c2c562401ab | PR123 exact-head gates pending |
| 65 ownership-unboxed-worker-locals | e217ad8ce0d9 | d7641a1ab055 | PR123 exact-head gates pending |
| 66 ownership-tls-peer-subject | 7250692d5758 | e217ad8ce0d9 | PR123 exact-head gates pending |
| 67 ownership-tls-alpn-roots | 6d80e63524c2 | 7250692d5758 | PR123 exact-head gates pending |
| 68 ownership-ci-probe-repairs | c0cdb26eb99b | 6d80e63524c2 | PR123 exact-head gates pending |
| 69 ownership-nested-loop-boxing | 7a68a54d2660 | c0cdb26eb99b | PR123 exact-head gates pending |
| 70 ownership-file-construction | ab3a93780dc3 | 7a68a54d2660 | PR123 exact-head gates pending |
| 71 ownership-file-write-visibility | 702cd9b0a69a | ab3a93780dc3 | PR123 exact-head gates pending |
| 72 ownership-file-io-errors | eee4807a3954 | 702cd9b0a69a | PR123 exact-head gates pending |
| 73 ownership-resource-frames | 3dba256655a3 | eee4807a3954 | PR123 exact-head gates pending |
| 74 ownership-file-runtime-owners | 8d5cb3c4e3e4 | 3dba256655a3 | 39-item runner rebase and full gates pending |
| 75 ownership-file-discard | 423a7ddcc760 | 8d5cb3c4e3e4 | 39-item runner rebase and full gates pending |
| 76 ownership-file-runtime-boundaries | 603bb0b914db | 423a7ddcc760 | 39-item runner rebase and full gates pending |
| 77 ownership-wasm-resource-counts | f4a26004d5a8 | 603bb0b914db | 39-item runner rebase and full gates pending |
| 78 ownership-wasm-count-disposal | 13c77dbb7b82 | f4a26004d5a8 | 39-item runner rebase and full gates pending |
| 79 ownership-resource-frame-fields | 2f842d5d266f | 13c77dbb7b82 | 39-item runner rebase and full gates pending |
| 80 ownership-file-inline-path | 010e622f064e | 2f842d5d266f | 39-item runner rebase and full gates pending |
| 81 ownership-file-storage-disposal | 6e5063786651 | 010e622f064e | 39-item runner rebase and full gates pending |
| 82 ownership-file-construction-disposal | ecfd9a28c39e | 6e5063786651 | 39-item runner rebase and full gates pending |
| 83 ownership-resource-frame-variants | 7b7e45b20230 | ecfd9a28c39e | 39-item runner rebase and full gates pending |
| 84 ownership-resource-frame-binding-kinds | e2a2baa977fa | 7b7e45b20230 | 39-item runner rebase and full gates pending |
| 85 ownership-match-scrutinee-types | ebe69e13a935 | e2a2baa977fa | 39-item runner rebase and full gates pending |
| 86 ownership-resource-record-binding-kinds | a0de231a4c0c | ebe69e13a935 | 39-item runner rebase and full gates pending |
| 87 ownership-nominal-source-context | 5a4ef15301c8 | a0de231a4c0c | 39-item runner rebase and full gates pending |
| 88 ownership-channel-cycle-lifetimes | 3db25573057b | 5a4ef15301c8 | 39-item runner rebase and full gates pending |
| 89 ownership-http2-body-roots | 5bc4f862bd5a | 3db25573057b | 39-item runner rebase and full gates pending |
| 90 fix-http2-body-bounds | fabe0ac7b24a | 5bc4f862bd5a | 39-item runner rebase and full gates pending |
| 91 ownership-http2-peer-cleanup | 5029a447bcec | fabe0ac7b24a | 39-item runner rebase and full gates pending |
| 92 ownership-grpc-peer-completion | 26545f1b279b | 5029a447bcec | 39-item runner rebase and full gates pending |
| 93 ownership-grpc-status-cleanup | 9ad102d5a16f | 26545f1b279b | 39-item runner rebase and full gates pending |
| 94 ownership-grpc-receive-cleanup | ec0fd11c6b26 | 9ad102d5a16f | 39-item runner rebase and full gates pending |
| 95 ownership-grpc-force-cleanup | 91ab62452636 | ec0fd11c6b26 | 39-item runner rebase and full gates pending |
| 96 ownership-grpc-render-cleanup | b4087dc07beb | 91ab62452636 | 39-item runner rebase and full gates pending |
| 97 ownership-grpc-send-cleanup | 0203804096d8 | b4087dc07beb | 39-item runner rebase and full gates pending |
| 98 ownership-grpc-request-encoding | 9c2c91fa8e21 | 0203804096d8 | 39-item runner rebase and full gates pending |
| 99 ownership-grpc-canonical-encoding | 58bf72dbf3df | 9c2c91fa8e21 | 39-item runner rebase and full gates pending |
| 100 ownership-grpc-response-encoding | 3b13964722ba | 58bf72dbf3df | 39-item runner rebase and full gates pending |
| 101 ownership-grpc-client-requests | a584b59ec896 | 3b13964722ba | 39-item runner rebase and full gates pending |
| 102 ownership-grpc-client-failure-text | 4e6dbbddf888 | a584b59ec896 | 39-item runner rebase and full gates pending |
| 103 ownership-grpc-client-receive | 09b5e3e70117 | 4e6dbbddf888 | 39-item runner rebase and full gates pending |
| 104 ownership-grpc-connect-cleanup | 518e5cfaca02 | 09b5e3e70117 | 39-item runner rebase and full gates pending |
| 105 ownership-grpc-connect-startup | 4802e1dfb8a5 | 518e5cfaca02 | 39-item runner rebase and full gates pending |
| 106 ownership-grpc-context-restore | 2308b7c1db43 | 4802e1dfb8a5 | 39-item runner rebase and full gates pending |
| 107 ownership-grpc-context-resources | a2b3b132f094 | 2308b7c1db43 | 39-item runner rebase and full gates pending |
| 108 ownership-grpc-capture-resources | ef437370ca74 | a2b3b132f094 | 39-item runner rebase and full gates pending |
| 109 fix-grpc-tls-pool-identity | c9d841ee5a9d | ef437370ca74 | 39-item runner rebase and full gates pending |
| 110 ownership-grpc-environment-cache | bf297ac299ea | c9d841ee5a9d | 39-item runner rebase and full gates pending |
| 111 ownership-grpc-packed-options | 5a01572cb2c6 | bf297ac299ea | 39-item runner rebase and full gates pending |
| 112 ownership-grpc-connection-addresses | b45e93a71d40 | 5a01572cb2c6 | 39-item runner rebase and full gates pending |

## Finish phase2, then continue the plan

A separate FFI boundary preparation, branch `ownership-ffi-pointer-arithmetic`,
head227f15356da8f9a5c7675eea9fda074a6be8857a on actual main120 passes all
three platform jobs in CI38123787995. Two original tests per platform execute,
zero ignored. Twelve retained sanitizer binaries have exact success0/overflow1
statuses; old signed-expression controls report signed integer overflow.
Collector0.29CPU/9.19elapsed verifies C/binary hashes and hardware/compiler
reports. Proof: /private/tmp/fwp-pointer-boundary-passing-proof.json; artifacts:
/private/tmp/fwp-pointer-boundary-227f153-artifacts. Earlier38109876885 failed
ARM exit assertion and Intel toolchain DNS provisioning. Explicit sanitizer
exit policy, distinct binaries and diagnostics preserve the strict control.
Include the repair in bundle54–73 with final actual-squash rebase and full
production gates. No separate pointer-only PR. ptr.at wraps unsigned native
pointer-width multiplication/addition; ordinary checked arithmetic is unchanged.
The tests cover84 independently specified address boundaries and12
ordinary numeric pointer types, raw/native O1/O2 agreement with GC/reuse, and an
old signed-expression UBSan control. No boundary address is dereferenced.
F16/128-bit, WebAssembly widths and raw-buffer lifetime acceptance remain separate.

One guarded baseline run reproduces the old raw-interpreter panic101 after
I8/U8 succeed; emitted C contains signed I16 arithmetic. Shared compiler SHA
4a04b1c4c0000627b845469d817672612a936db3c669bc5e9affb823398ebdb9
is recorded without inferring its source head. Evidence:
/private/tmp/fwp-pointer-boundary-baseline/report.json. Corrected fixture check
0.75CPU/1.44elapsed passes; preparation0.55/5.94s, format0.45/0.84s,
format check0.33/0.61s and publication repairs0.13/3.08s +0.31/6.57s pass.
Superseded preparation runs38109666010/38109740663 were cancelled, not passed.
Independent boundary support is verified on three64-bit native platforms;
merged acceptance and wider raw-memory coverage remain pending.
Publication journal: /private/tmp/fwp-pointer-arithmetic-publication.json.

After queue112 is delivered, recheck the finite [ownership exit gates](ownership.md#phase-2-exit-gates)
and [primitive contracts](primitive-ownership.md) against merged source. The
prepared112 audit resolves373 declarations into363 runtime symbols after40
aliases:134 explicit contracts,19 ordinary IR combinators,12 flat scalar
signatures and208 review declarations representing198 symbols. Missing metadata
alone is not a sharing bug. Preserve conservative fallbacks until concrete
typed ownership and teardown are proved.

Review borrowed metadata roots, reconstruction/partial failure, retained
callbacks/contexts and resource disposal. The source-reviewed fallback list also
includes generic list.flat-map/list.ap reconstruction and per-task State slots;
see [primitive contracts](primitive-ownership.md). Typed slot teardown and
callback/temporary ownership remain acceptance work, without a reproduced
failure or new reclamation claim. Channel close preserves queued values;
explicit drain breaks its counted cycle, while automatic unreachable-cycle
reclamation remains unproved. Scalar AD tape handles do not prove external
buffer lifetimes. Numeric lifetime findings and future regressions are in
[numerics](numerics.md). Complete phase2 before representation, numerics/AD,
performance and tracing-free work. Phases3–6 still require implementation and
measured acceptance; the prepared ownership queue is not the whole plan.

## Local resource incident and next preparation

The attempted future bundle preparation was refused before execution when free
disk fell below64GiB; observed available62.17GiB and project target101MiB.
No refused compiler/check/preparation ran outside the guard, and limits were
unchanged. Remote GitHub merge and Git metadata verification continued. Disk
subsequently returned above64GiB without project cleanup, enabling guarded
main update and final54–73 rebase. Disk again fell below reserve after PR123
creation; stop local workloads. At 11:36 UTC, available space is approximately
57.7 GiB. No local build, test or bundle preparation is authorized while the
guard refuses the workload. Read-only source review and remote administration
continue.
The current remote preparation drivercfcb70d16044915206c2e681a72618021ba0ea97,
branch ownership-roadmap-preparation, runs CI38130008122 (queued). It targets
original112 b45e93a71d40
FROM73 3dba256655a3 onto published123 candidateb0ae00d5512d. It prepares
all39 remaining rows74–112 as one resource/network bundle, preserving85
original commits and exact tested raw-memory changes. It publishes
ownership-resource-network-bundle as a preparation only, with both accepted
golden diagnostics and mandatory WASI retained. Runner full validation and final
actual123-squash rebase remain required. Driver workflow is outside production
ancestry; no extra production PR is open. The earlier20-item preparation
CI38129146591, head96f6b3d2c073, was verified cancelled before publishing its
replacement; cancellation is not a passing check. The cancellation request
initially remained queued, so publication waited for confirmed cancellation.
Expansion journal: /private/tmp/fwp-resource-network-expanded-runner-publication.json.
Its source112 already includes mandatory WASI test environment;
preserve that alongside inherited golden artifact diagnostics when rebasing.
The phase2 exit inventory draft is /private/tmp/fwp-check-primitive-inventory-exit.py
with /private/tmp/fwp-primitive-inventory-exit.rs. It compares every parsed
declaration and actual Rust contract with the frozen669c19e baseline, allowing
only the nine intentional raw-memory contract additions and preserving every
other row. It has not executed or established new counts. Copy it into an
evidence branch on actual merged112-equivalent source and run on GitHub after
the resource/network bundle is accepted; retain the old JSON as baseline.

New GC harness source-review finding: tests/gc.rs returns None for every native
build failure, so a failed valid O2 compilation can silently leave stress
coverage. Draft /private/tmp/fwp-gc-strict-build-draft.rs instead compares build
errors with expected snapshots, records real exit/signal/core status and keeps
failed binaries/C/reports outside the temporary directory. A real failing-CC
control checks propagation and retained C/status. This draft has not compiled
or executed; run focused checks on GitHub and include it in the next bundle,
preserving every original regression. /private/tmp/fwp-gc-diagnostics-ci-draft.yml
adds failure artifacts to both macOS GC jobs. Apply only its added GC steps to
the future workflow; copying the whole draft would lose mandatory WASI.
PR123's frozen head remains unchanged. Current gates are required as recorded;
the later harness repair does not count as passed support.
Published independent validation branch: ownership-evidence-gc-build-diagnostics,
heada44c3da1aa344266262fc99471b331b053db371b on PR123 native source.
CI38136959809 is queued. Superseded38132388036 and38135741797 were confirmed
cancelled while unstarted before adding the compiler and cache repairs.
The replacement runs formatting, focused lint, a real failing-CC
control and a positive native GC
execution, then requires exact Rust test exit101 and the specific diagnostic
when compiler failure reporting is deliberately silenced. Artifacts include
generated C, the positive binary, real statuses, hardware/compiler and hashes.
Evidence is pending, with no production PR or extra full matrix. Copy only the
tested gc.rs and added GC failure steps into the next bundle; keep the evidence
workflow outside production ancestry and preserve mandatory actual WASI.
Compiler source review also found that native and interpreter FFI builds discard
compiler stdout and termination details. Published repairs share diagnostic
rendering, preserve stdout/stderr and exit/signal/core status, and detect OpenSSL
errors in stdout as well as stderr. Two new compiler_diagnostics tests cover
stdout-only and mixed errors, status37, signal15, TLS hints and successful
native/raw-interpreter execution. A deliberately discarded stdout control must
fail with exact Rust exit101 and its specific diagnostic. These tests have not
run yet. Journals: /private/tmp/fwp-combined-compiler-diagnostics-publication.json
and /private/tmp/fwp-cache-compiler-diagnostics-publication.json.
The AOT cache source also allowed pruning to delete the executable returned for
execution: zero limits removed all entries, and a future-dated older entry could
make the just-built file sort first. The candidate reserves one entry for the
current executable, prunes only older entries and applies reduced limits on cache
hits. Two cache_lifetime tests cover zero/one limits, future timestamps, native
execution against a raw interpreter and limit reduction on a hit. An omitted
current-file protection control must fail with exact Rust exit101 and its
specific eviction diagnostic. No cache tests have run yet.
After focused evidence passes, apply the exact compiler-diagnostics-patch.json
transforms to the final resource bundle; do not copy older whole cgen/ffi files
over its85 prepared commits. The recipe now includes src/aot.rs; include both
tests/compiler_diagnostics.rs and tests/cache_lifetime.rs. The finalizer verifies
that each recipe reproduces the exact tested/formatted evidence source before
applying it to the later bundle. Formatting repairs must update the recipes too.
For the original85-commit preparation, preserve accepted base CI plus the
intentional mandatory WASI requirement. After the GC repair is verified and
integrated, additionally allow its explicit GC failure-artifact steps. Preserve
all six job names, full test commands and inherited golden diagnostics; do not
resolve either change by replacing the entire workflow with an older snapshot.

Runner finalization draft: /private/tmp/fwp-finalize-resource-network-on-runner.py
and its matching .yml. Publish its separate driver only after PR123 merges,
the85-commit preparation passes and the focused GC repair passes. It requires
all seven original PR123 gates completed before squash, validates the raw
one-line message/parent/tree, restores all11 authoritative recovery docs and
records acceptance in a runner worktree. It then rebases the verified preparation
onto the actual squash, preserves its complete tree and original subjects,
and adds the tested GC harness/artifact steps, compiler/cache transforms and
tests, plus fresh accepted docs. Its candidate reference documents the minimum
one-entry cache and current-executable protection only alongside that repair.
An exact old-head push lease protects concurrent edits. This is an unexecuted
draft, with final documentation audit and all production gates still required.
Its workflow bindings must follow any repaired evidence heads. Local main
requires a separate guarded protection/update when the disk reserve permits.

## Local checks and durable recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local work
is serial, low priority and guarded: sampled aggregate RSS below1GiB, target
below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits and move
work to CI; never raise or bypass limits. The fun-refactor guard applies only to
that other repository.

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
python3 scripts/local-guard.py python3 scripts/check-roadmap.py
```

Last Rust checkout is /private/tmp/fwp-library-resource-bundle-worktree,
Current source ed442426ff6e0ce4e646913720c95c098596da02 passes focused
raw-memory/pointer/resource-frame tests,65 library units, lint and format.
Smaller candidate9664d0607d16 checks are scoped to that previous source;
clean removed68files131.2MiB,0.00CPU/0.14elapsed before the expanded rebuild.
The previous compiler/task package clean removed62 files/99.1MiB,
0.00CPU/0.13elapsed. Source/check hashes:
/private/tmp/fwp-library-raw-memory-focused-checks.json. Combined first run
passes both pointer tests but fails raw-memory fixture RC insertion; corrected
fixtures pass. History records subsequent fixture corrections and guard refusal.
Before switching Rust checkouts, use the absolute root guard
with cargo clean -p fwp in that last checkout, then rebuild requested targets.
Do not infer source identity from shared outputs. Refusals and prior metrics
remain in history; each new guard invocation samples current resources.

Protect all11 docs with a fresh hashed snapshot before each main fast-forward:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md and docs/numerics.md. Preserve other tracked
user changes too. Latest snapshot: /private/tmp/fwp-main-docs-pre122, restored
byte-for-byte. Actual bases, immutable preparation tags and retained revision
tags are the recovery record if temporary helpers disappear. The shared audit
checks all tracked links, whole commit messages, immutable ancestry and live
head/base consistency. Audit again after links, refs or subjects change.
