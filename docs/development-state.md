# Session handoff

Updated 2026-10-10. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the live handoff;
[queue](roadmap-queue.md) preserves immutable anchors and
[history](roadmap-history.md) preserves detailed checks and superseded status.
Prepared branch docs are historical snapshots; current root docs are authoritative.

## Execution contract

Complete the roadmap automatically, one focused PR at a time. Publication,
PR creation, repairs and squash merges are authorized across sessions. Failing
checks are repair tasks; CI gates merging while independent work continues.
Keep tacit, curried, data-last pipes, immutable values, tracked effects, checked
arithmetic, affine resources and evaluation/trap order. Use FWP_NO_OPT=1
explicitly for raw interpreter oracles. Prepared work is not merged support.

Every entire commit message is one line, at most 80 characters, with no body,
trailers or attribution. Use ordinary author metadata. Require all six passing
jobs at the current exact PR head: test, bench, macos (macos-15), macos
(macos-15-intel), macos_gc (macos-15), macos_gc (macos-15-intel). Regular macOS
excludes only golden_programs_under_gc_stress; dedicated GC jobs execute it.
Queued/skipped/cancelled/superseded/old runs are never passing gates. Squash:

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Main and next delivery

Main is `c9b9f835ebf2e3a868bfa4bdf256f0f16800786c` (PR107). Accepted head
`1dcbe79ac0777b83cad6f49b8ab4b28ad140c854` passes all six production jobs in
CI38011227462 and roadmap_docs38011227532. Match-head squash at2026-10-10T01:46:24Z
has the exact65-character message `Protect runtime application owners through preparation and unwind`,
with one line, an empty body and no trailers/attribution. Complete tree
`2efc86ee42fb4cef265ca976bf1dcf43e618bfa0` matches the tested head. Raw-message,
tree and final-gate proofs are saved locally; full acceptance is in history.
All11 docs were hashed/backed up in /private/tmp/fwp-main-docs-pre107 and restored
byte-for-byte after main FF. Refresh that now-stale backup before the next FF.
Duplicate main CI38014464073 is cancelled only after parity/gate proof; main
roadmap_docs38014464086 passes. Native macOS and selected ownership are delivered
through runtime application/capture preparation and compiler caller/reuse cleanup.
Phase2 remains incomplete; phases3–6 remain pending; tracing stays the fallback.

[PR108](https://github.com/e6qu/fun-with-pipes/pull/108) delivers queue29 map
unwind. Its frozen exact head is `3c69084cec04ad0a5db3c2f8813a683140d3f40c`
on actual squash base `c9b9f835ebf2e3a868bfa4bdf256f0f16800786c`. Both implementation/
probe commits survive the rebase; source/tests/scripts/production workflows
match prior25eda7b byte-for-byte. Nine focused map/runtime tests22.95CPU/46.05elapsed,
focused clippy2.32/4.65s, format0.34/0.62s and strong audit0.42/3.45s pass.
All11 live docs are copied into the PR; prior25eda7b is retained under
roadmap/revision-029-25eda7b24ef5 before exact-lease publication. Freeze this head
except for real fixes. Production CI38015157922 is running; roadmap_docs38015157960
passes. Require all seven exact-head gates before merging.
Squash subject: `Release map callback owners and partial results during unwind`;
empty body and explicit --match-head-commit. After the accepted squash's message/
tree proof and protected main update, deliver queue30 selection unwind next.
Keep one production PR open at a time; continue independent preparation while CI runs.

Queue34 is now a verified duplicate of the preparation code/probe delivered
in107. Skip its implementation PR when reached after33; preserve its immutable
anchor, current source ancestry and all later regression coverage.

## Staged repairs and next independent work

Row33 normalizes bound/inline Again records and reads cancellation owners by
the actual emitted layout;35 selects the intended pending-call IR checkpoints;
47 protects evaluated CAFs during later scalar evaluation. Original allocation,
alias, release and scalar-bit assertions stay intact. Earlier source-specific
passes and superseded heads are archived; they never accept rewritten sources.

Cache/task evidence329e8db/CI38011548324 exposed missing remaining-owner cleanup
during boxed match-to-worker conversion. Local reproduction fails too. Row43
repair `8c7450568632` adds the completed consumed-match checkpoint without
replacing operation/retain checkpoints. Its new IR control fails before the fix;
all20 row43 IR controls and seven original native tests then pass, including all
three exact omission controls, O1/O2, raw interpreter, GC verification and reuse
poisoning. Original native probes are unchanged. Repaired cache/task evidence
`2d5d52fd941c` runs CI38013532481 on repaired source52 `cb32c2cea9bb` and includes
all21 IR controls and the original stack/reuse gates. The scoped run passes;
this validates its Linux source, while each production PR still needs full gates.

Typed-holder evidence372375a/CI38011999875 exposed a parent-box allocation
regression for a direct resource variant constructor. Row83 repair
`06215746caae` admits eligible direct constructors only for original frame
holders, respecting the variant-return flag. All five original variant/record/
frame tests, lint, format and audit pass. Zero/one parent-box, File lifetime,
alias and inactive-payload assertions are unchanged. Refreshed holder evidence `f7d7585b89ad` is byte-identical in source, native
probes, scripts and production workflows to repaired source88 `acce7492f8d3`.
All21 ownership IR controls and original stack/reuse gates remain required.
CI38015529998 is running; failed CI38011999875 remains archived, not support.

Both repairs now propagate through83. Matched-result refresh44–59 is complete,
including both CAF/converted-result controls. Refresh60–67 passes8.35CPU/92.10elapsed;
68–75 passes after the strict resource-layout adjustment (5.27/58.64s stopped,
3.26/38.44s completed);76–83 passes8.42/92.36s. Both original resource commits
and the additional frame-holder repair survive. Refresh84–91 passes8.63CPU/92.12elapsed, preserving both row85 commits and
original HTTP fixture controls. Continue92–112 in bounded
batches using /private/tmp/fwp-refresh-matched-conversion.py and actual bases.
It verifies exact inherited code, original probes and commit counts, retains each
prior head remotely, publishes with an exact lease and audits the handoff.
It additionally carries the exact row83 frame-holder patch into84 and later.
Completed journals must not be rerun. Prepare fresh serving/storage evidence
after propagation; prior passes predate these repairs. All full gates remain
required for each sequential production PR. Temporary helpers may disappear;
the table, actual bases and retained remote tags are the durable recovery record.

The million-step native tail regression is merged and tested at O1/O2 with
GCoff/on against a200-step raw oracle. Full-size raw100000 exceeds local RSS;
release runner evidence81362c7/CI37997969782 passes using1893164KiB peak RSS,
while debug exceeds its existing4GiB stack. Keep those workloads on GitHub;
never raise local/stack limits. Neither result claims constant raw stack or a
speedup. Exact hardware, flags and measurements are in history.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 29 ownership-map-unwind | 3c69084cec04 | c9b9f835ebf2 | Nine focused tests22.95CPU/46.05elapsed, lint2.32/4.65s, format0.34/0.62s and audit0.42/3.45s pass; PR108 full exact-head CI pending |
| 30 ownership-selection-unwind | 9979e9fd1a27 | 25eda7b24ef5 | Seven tests24.42/48.98s; lint2.24/4.54s, format0.36/0.76s and strong audit pass; final sequential gates follow |
| 31 ownership-zip-unwind | 47776e738c26 | 9979e9fd1a27 | Seven tests24.32/48.75s; lint2.35/4.66s, format0.36/0.75s and strong audit pass; final sequential gates follow |
| 32 ownership-fold-unwind | c434692ccb6f | 47776e738c26 | Eight tests22.49/45.05s; lint2.37/4.77s, format0.34/0.62s and strong audit pass; final sequential gates follow |
| 33 ownership-loop-unwind | 527f84d405b77 | c434692ccb6f | Inline/bound Again repair: two loop tests10.45CPU/20.96elapsed, lint2.32/4.58s, format0.36/0.76s, audit0.44/3.37s pass; full sequential gates remain required |
| 34 ownership-argument-preparation | 734d3383addf | 527f84d405b7 | Source/tests/scripts/workflows identical to33; docs only; audit0.44/3.50s passes; skip duplicate PR after28 full acceptance |
| 35 ownership-constructor-unwind | be0032a15ee3 | 734d3383addf | Six tests22.36/45.17s; exact unit3.39/7.02s; lint2.28/4.73s, format0.35/0.74s and strong audit pass |
| 36 ownership-worker-boxing | e171da5957fd | be0032a15ee3 | Three tests15.44/31.12s; lint2.40/4.94s, format0.35/0.62s and strong audit pass; final sequential gates follow |
| 37 ownership-worker-preparation | ba9f0f293ac8 | e171da5957fd | Three tests15.91/31.88s; lint2.33/4.78s, format0.35/0.63s and strong audit pass; final sequential gates follow |
| 38 ownership-loop-preparation | 2a45666b37a1 | ba9f0f293ac8 | Four tests16.61/33.35s; lint2.26/4.59s, format0.34/0.62s and strong audit pass; final sequential gates follow |
| 39 ownership-variant-preparation | dd8444579ed0 | 2a45666b37a1 | Three tests16.18/32.57s; exact retain unit3.33/7.00s, lint2.40/4.91s, format0.35/0.75s and strong audit pass |
| 40 ownership-constructor-types | cccbe406449f | dd8444579ed0 | Three tests16.23/32.69s plus fifteen IR tests3.32/6.89s; lint2.36/4.59s, format0.35/0.75s and strong audit pass |
| 41 ownership-variant-conversion | 172912b7b1c6 | cccbe406449f | Three tests16.62/33.51s; exact conversion IR unit3.23/6.74s, lint2.32/4.72s, format0.35/0.62s and strong audit pass |
| 42 ownership-record-update | 2b61f8cad333 | 172912b7b1c6 | Two updates15.01/30.20s; unit3.22/6.67s; lint2.28/4.57s and format0.34/0.60s pass |
| 43 ownership-record-conversion | 8c7450568632 | 2b61f8cad333 | Matched-result checkpoint repair: all20 IR controls3.25/6.97s, seven native tests26.91/53.88s, lint2.38/4.81s, format0.35/0.63s pass; strong audit0.43/3.47s passes; source8c74505 published with prior head retained; runner/full gates follow |
| 44 ownership-variant-alias | 5e436e6ee6f5 | 8c7450568632 | Two tests8.67/17.52s; lint2.32/4.66s and format0.35/0.73s pass |
| 45 ownership-match-context | 44e720054249 | 5e436e6ee6f5 | Two tests8.71/18.12s; lint2.55/5.06s and format0.44/0.84s pass |
| 46 ownership-field-context | 3a87da04a671 | 44e720054249 | Two tests9.08/18.73s; lint2.42/4.93s and format0.43/0.83s pass |
| 47 ownership-caf-cache | 7e507e993e58 | 3a87da04a671 | Three tests11.54/24.96s; lint2.38/4.80s and format0.44/0.83s pass |
| 48 ownership-inline-caf | 3dd5219cb896 | 7e507e993e58 | Two tests12.68/26.01s; lint2.47/4.90s and format0.35/0.73s pass |
| 49 ownership-task-thunks | 2c14070a6347 | 3dd5219cb896 | Two tests10.19/20.78s; lint2.33/4.82s and format0.35/0.73s pass |
| 50 ownership-task-within | f35dd8c34ea4 | 2c14070a6347 | Test8.95/18.26s; inventory unit3.33/6.98s; lint2.43/4.79s and format0.35/0.73s pass |
| 51 ownership-task-scope | bb1e6b94fcfd | f35dd8c34ea4 | Test9.76/20.17s; lint2.45/4.85s and format0.34/0.62s pass |
| 52 ownership-task-handles | cb32c2cea9bb | bb1e6b94fcfd | Test11.24/23.29s; lint2.34/4.73s and format0.44/0.74s pass |
| 53 ownership-channel-queues | 69bc96667a52 | cb32c2cea9bb | Test11.45/23.08s; inventory3.40/7.25s; lint2.43/4.79s and format0.45/0.87s pass |
| 54 ownership-library-results | f53cccc88d45 | 69bc96667a52 | Test7.86/17.88s; lint2.44/4.85s and format0.34/0.61s pass |
| 55 ownership-library-inputs | 067d547b3bfd | f53cccc88d45 | Two tests8.27/18.38s; lint2.34/4.68s and format0.34/0.61s pass |
| 56 ownership-library-unload | 0d30f4e3da51 | 067d547b3bfd | Test8.98/21.43s; lint2.42/4.81s and format0.45/0.74s pass |
| 57 ownership-opencl-lifetime | 9dc98a72cac1 | 0d30f4e3da51 | Fake API test7.78/22.85s; lint2.36/4.71s and format0.45/0.75s pass |
| 58 ownership-interpreter-opencl | 013b07eac021 | 9dc98a72cac1 | Fake API interpreter/native11.27/27.44s; lint2.32/4.69s and format0.34/0.62s pass |
| 59 ownership-tls-listeners | 64fc39f9738e | 013b07eac021 | Test8.61/19.51s; lint2.46/5.00s and format0.35/0.75s pass |
| 60 ownership-library-resources | aa8dfb3a703e | 64fc39f9738e | Test8.04/18.34s; lint2.48/4.99s and format0.41/0.86s pass |
| 61 ownership-grpc-server-cleanup | 91f9a30742f9 | aa8dfb3a703e | Test9.94/19.99s; lint2.46/4.95s and format0.44/0.86s pass |
| 62 ownership-tls-cache-failures | 0ba865002ace | 91f9a30742f9 | Test7.17/16.27s; lint2.43/4.95s and format0.40/0.73s pass |
| 63 ownership-tls-wire-preparation | 52bc4e64547b | 0ba865002ace | Test7.54/16.19s; lint2.45/4.96s and format0.45/0.86s pass |
| 64 ownership-connect-cancellation | d364e70df274 | 52bc4e64547b | Test7.77/17.05s; lint2.31/4.60s and format0.44/0.60s pass |
| 65 ownership-unboxed-worker-locals | 886f8b0083c9 | d364e70df274 | Two tests8.07/16.86s; lint2.36/4.73s and format0.35/0.62s pass |
| 66 ownership-tls-peer-subject | d8b4e2407fb1 | 886f8b0083c9 | Test7.47/16.47s; lint2.33/4.59s and format0.44/0.84s pass |
| 67 ownership-tls-alpn-roots | 221d8fa6ffcc | d8b4e2407fb1 | Test6.99/14.97s; lint5.72/11.65s and format0.44/0.84s pass |
| 68 ownership-ci-probe-repairs | 4f37224b0f6f | 221d8fa6ffcc | Timer test10.28/21.81s; lint5.61/11.71s and format0.46/0.87s pass |
| 69 ownership-nested-loop-boxing | 04d75ff8a0e1 | 4f37224b0f6f | Three tests14.44/29.19s; lint5.60/11.68s and format0.35/0.63s pass |
| 70 ownership-file-construction | fa6e27813f3d | 04d75ff8a0e1 | Test7.49/16.08s; lint5.42/11.61s and format0.36/0.76s pass |
| 71 ownership-file-write-visibility | 55a6b0c6c7c5 | fa6e27813f3d | Two tests8.14/17.09s; lint5.55/11.78s and format0.35/0.75s pass |
| 72 ownership-file-io-errors | 54d816de6a93 | 55a6b0c6c7c5 | Three tests14.85/30.79s; lint5.53/11.82s and format0.35/0.62s pass |
| 73 ownership-resource-frames | e3bfb67a9244 | 54d816de6a93 | Three integrations12.65/25.47s; three units3.81/7.73s; lint6.13/12.55s and format0.44/0.84s pass |
| 74 ownership-file-runtime-owners | ddbee893478e | e3bfb67a9244 | Test8.17/18.29s; lint5.82/12.43s and format0.43/0.83s pass |
| 75 ownership-file-discard | ef04da0f3049 | ddbee893478e | Test13.04/26.17s; lint5.83/12.17s and format0.44/0.83s pass |
| 76 ownership-file-runtime-boundaries | f0034b6ab7c1 | ef04da0f3049 | Test18.99/38.40s; lint5.98/12.65s and format0.46/0.84s pass |
| 77 ownership-wasm-resource-counts | 8a2d845523c5 | f0034b6ab7c1 | Actual WASI gates remain required; native bump checks are not WASI proof |
| 78 ownership-wasm-count-disposal | 43773a07a269 | 8a2d845523c5 | Actual WASI gates required; source unchanged except inherited harness repairs |
| 79 ownership-resource-frame-fields | ec96643bfe26 | 43773a07a269 | Test10.09/21.47s; lint6.10/13.03s and format0.55/1.08s pass |
| 80 ownership-file-inline-path | 143444f5c43e | ec96643bfe26 | Two tests10.54/21.29s; lint6.87/13.94s and format0.54/1.07s pass |
| 81 ownership-file-storage-disposal | c4110b410f56 | 143444f5c43e | Test8.53/19.18s; lint6.72/13.84s and format0.45/0.84s pass |
| 82 ownership-file-construction-disposal | af8561c68820 | c4110b410f56 | Test8.16/18.70s; lint6.09/12.99s and format0.44/0.83s pass |
| 83 ownership-resource-frame-variants | ed1091ff988c | af8561c68820 | Direct frame-constructor repair: five original native tests20.72CPU/41.72elapsed, lint2.34/4.77s and format0.45/0.86s pass; strong audit0.42/3.47s passes; source0621574 published then rebased toed1091ff988c with exact code/probe parity; runner/full gates follow |
| 84 ownership-resource-frame-binding-kinds | 26f529e6ba91 | ed1091ff988c | Test10.45/23.67s; lint6.18/12.88s and format0.45/0.83s pass |
| 85 ownership-match-scrutinee-types | 719905a41225 | 26f529e6ba91 | Two tests12.49/27.27s; lint6.11/13.31s and format0.44/0.83s pass |
| 86 ownership-resource-record-binding-kinds | 8ebd4cbcc3ba | 719905a41225 | Test10.49/22.84s; lint6.03/12.91s and format0.41/0.86s pass |
| 87 ownership-nominal-source-context | 69f606200622 | 8ebd4cbcc3ba | Raw source/native test13.09/26.43s; lint6.14/13.07s and format0.45/0.86s pass |
| 88 ownership-channel-cycle-lifetimes | acce7492f8d3 | 69f606200622 | Two cycle/queue tests13.30/26.87s; lint5.94/13.04s and format0.46/0.87s pass |
| 89 ownership-http2-body-roots | 9d8a6fb2a7df | acce7492f8d3 | GCC stale-root fixture passes normal Linux37990203134 and ARM15.46/31.62s; later propagation follows |
| 90 fix-http2-body-bounds | 71d875caed41 | 9d8a6fb2a7df | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 91 ownership-http2-peer-cleanup | 36ea28337198 | 71d875caed41 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 92 ownership-grpc-peer-completion | 5b15ee436b69 | 36ea28337198 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 93 ownership-grpc-status-cleanup | e7408fee761a | 5b15ee436b69 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 94 ownership-grpc-receive-cleanup | 7c94141a1a9a | e7408fee761a | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 95 ownership-grpc-force-cleanup | 279f9f73e3f3 | 7c94141a1a9a | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 96 ownership-grpc-render-cleanup | 8302c3468190 | 279f9f73e3f3 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 97 ownership-grpc-send-cleanup | 351073f7254d | 8302c3468190 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 98 ownership-grpc-request-encoding | 1f6f668eff38 | 351073f7254d | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 99 ownership-grpc-canonical-encoding | 96f523dfad9e | 1f6f668eff38 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 100 ownership-grpc-response-encoding | a3d88c0b8f3d | 96f523dfad9e | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 101 ownership-grpc-client-requests | e0db0123a16c | a3d88c0b8f3d | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 102 ownership-grpc-client-failure-text | 4c58f019e707 | e0db0123a16c | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 103 ownership-grpc-client-receive | 6f1f030dfcce | 04e8557ca5e8 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 104 ownership-grpc-connect-cleanup | ac9558374a4d | 6f1f030dfcce | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 105 ownership-grpc-connect-startup | 2711a516ee34 | ac9558374a4d | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 106 ownership-grpc-context-restore | 29104d944907 | a8ed839d69f5 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 107 ownership-grpc-context-resources | c34c313ccfb0 | 29104d944907 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 108 ownership-grpc-capture-resources | 8f66e28763b4 | c34c313ccfb0 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 109 fix-grpc-tls-pool-identity | cf14552bdba5 | 8f66e28763b4 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 110 ownership-grpc-environment-cache | 393456e6e5ca | cf14552bdba5 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 111 ownership-grpc-packed-options | a4f347499f19 | 393456e6e5ca | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 112 ownership-grpc-connection-addresses | 215d7badbd49 | a4f347499f19 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |

Prepared focused evidence, detailed commands and earlier source-parity proofs
remain in history. The Main and next delivery section supplies the sole live
next action. Every production PR requires six exact-head full gates and the
documentation audit.

Use actual bases above for final rebases, never OLD anchors or rewritten
predecessor heads. Preserve all 11 root docs for conflict resolution and
inherited CLI/GC harness fixes. The table records actual bases; historical
evidence bases never override them.
Rows77–78 require real WASI on Linux in both free modes; native bump checks
supply no WASI acceptance. Row20 boxed128-bit payloads remain shared. Network
context wrappers retain tracing compatibility; no complete ARC claim. Channel
close preserves queued values; explicit drain breaks its counted cycle, while
automatic unreachable-cycle reclamation remains unproved.

## Earlier argument-preparation repair

Row28 now includes row34's capture-preparation correction: supplied arguments
stay owned until capture duplication succeeds, and partial duplicated captures
have registered cleanup. The unchanged negative control catches its omission.
The live preparation/evidence tables above give current heads and checks;
previous revisions and propagation results are in history.
Row28 passed full acceptance in PR107. Skip the duplicate implementation PR at
row34 while preserving its immutable anchor and regression coverage. Current
row34 differs from row33 only in docs. No general exceptional-ownership claim.

## Fixture repair status

Earlier row29 production84ef5480f4938e78c11c10823bf498a8a1a4e6f9 passes normal
Linux evidence5c24e0d34ea3b0d9ff4639ba4f0e1bf50c407135, CI37966274872:
format/lint, map/call/reuse/cleanup/task ownership, actual tracing and all-doc/tag
checks. No diagnostics remain. GDB identified a fixture call to
fwp_gc_chunk_of(ci=NULL), which requires an output pointer; using local ci
preserves all assertions and changes no runtime/compiler code.
Row30 ca33d3141a96 inherits that fix on actual84ef548 and fixes its identical
observer. Normal evidence7a6ca031fc0b6a10295dc86e07bb83ef0601a295,
CI37966690637, passes.
Rows29–32 and34 bring the known row68 mandatory output-pointer repair into
their earlier deliveries. Keep the later row68 repair from overwriting these
fixtures or inherited CLI/GC changes. Preserve
all alias/reclamation assertions. Detailed failed/diagnostic logs stay in history.

## Separate evidence and remaining audits

Earlier passed evidence predates the complete PR106 call repair unless stated
otherwise. Refresh scoped evidence on the repaired source; no historical pass
accepts a current production head. Superseded runs are archived in history.

| Scope | Exact evidence head | Run / status |
|---|---|---|
| Rows107–112 storage and repaired root controls | e5bbfd84736f35f79d631b48373fb8b328251b5f | CI37992657684 passes; historical source215d7ba |
| Rows92–100 gRPC serving and encoding | 3aca5cf20d779fa1e9abbfd89e0588032940fb91 | CI37993159029 passes; historical sourcee6ae6c8, inherited HTTP2 control repaired |
| Rows79–88 typed holders and explicit cycles | f7d7585b89ad76f69ffac20e9437db620fb022f4 | CI38015529998 running on repaired source88 acce7492f8d3; original holder/cycle/tracing probes, all21 IR controls and stack/reuse gates. Strong audit0.42/3.35s passes. Failed372375a/CI38011999875 exposed direct-constructor boxing; its retained head and fix are in history. Explicit draining does not prove automatic cycle reclamation |
| Rows77–78 actual WASI counts/disposal | 24e7e57103f8c74bd3057ac856c7ba8e54378951 | CI38011802620 passes on repaired source78 e037bc5a06dc; required actual WASI, original resource/tracing probes, all20 IR controls and stack/reuse gates. Strong audit0.44/3.47s passes. Prior dc731c1/CI37980359907 predates the repairs |
| Rows69–76 File and original resource frames | c5665d02622883499cdf8a1a9419dc835b1daed2 | CI38011728123 passes on repaired source76 4c6618c4eb91; original File/frame/loop probes, all20 IR controls, stack/reuse and tracing gates. Strong audit0.43/3.46s passes. Prior4a448ea/CI37980022336 predates the repairs |
| Rows47–52 cache and task runtime | 2d5d52fd941c03b6bd0ff0c908ff6edeaf3c634f | CI38013532481 passes on repaired source52 cb32c2cea9bb; all21 IR controls and unchanged native conversion/stack/reuse gates; strong audit0.43/3.46s passes. Prior329e8db/CI38011548324 failed matched conversion and is retained |
| Rows26–41 callback/constructor/typed conversion | ba3a0f2412f8380a6b8a1c1e60e1496c425b73f5 | CI38008988824 passes on current41 at172912b; loop/observer and exact pending-call controls repaired; allocation gates, full IR module, tracing/lint/docs |

Earlier scope heads and full run IDs are preserved in
[the evidence archive](roadmap-history.md#earlier-scoped-evidence-handoff).

Evidence workflows never enter production ancestry. Every sequential PR still
requires all six gates at its own current head. Preserve both row85 commits: its repaired typed
whole-stack binder and nominal File disposal. Failed and superseded logs remain in history.

Row111 verifies one TLS-option allocation, exact requested bytes, alignment,
copied inputs, last-owner release and allocation-failure cleanup. It makes no
elapsed-speed or whole-program tracing-free claim. Row110 verifies read-once
cache teardown after blocked tasks and finalizers; row111 changes selected
cache releases from ten malloc allocations to five. Row112 locally verifies long-address loopback/pool reuse, copied inputs and
requested bytes below the legacy short-address layout atO1/O2 with GC/reuse
variants. Focused Linux CI37958243461 also passes; full sequential platform gates remain required.

Canonical C decode scratch already frees on normal success/error paths;
reconstructed decoded aggregates remain shared. Audit typed reconstruction,
partial construction, retained runtime contexts and automatic unreachable-cycle
reclamation against the finite phase2 exit criteria in ownership.md. Channel
close preserves queued values; explicit drain alone proves its counted cycle
can be broken. Preserve raw interpreter comparisons and original pipe semantics.

## Accepted guard and fixture controls

The guard sampling repair is merged in PR104, with all exact-head platform gates.
It suspends workloads during target-size sampling and preserves every resource
limit. Three deterministic integration checks cover suspension/resumption,
sampler errors and the original target-size limit. The stronger handoff audit
merged in PR105 verifies recorded live heads and actual source-base ancestry.
Commands and current limits are below; old diagnostics are archived in history.

Preserve accepted HTTP2 omission controls: GCC x86-64 isolates allocation and
clears only stale callee-saved registers in the test hook; other compilers keep
the original probe. Positive collection, strict omission failures, payloads and
finalizer checks remain mandatory. Accepted evidence8e79458951a8b148e3a3c6a1df488e7f09470fba
passesCI37990203134; ARM focused checks also pass. Rejected broad-clobber,
forced-inline and Clang fallback approaches are archived, never production fixes.

Preserve client controls using static handler/TypeInfo fixture objects. Exact
descriptor identity, code14 and transport-failure text remain checked. Accepted
evidencee4a5c1cab0b01d5b6dd9f7bc7a1859185a7f69e0 passesCI37989574765 with ARM
focused checks. Runtime behavior and original assertions are unchanged. Both
fixture corrections propagate through90–112; subsequent argument/loop repairs
require refreshed evidence and final exact-head full gates.

## Local limits and durable docs

Full builds/tests, benchmarks and large regeneration run on GitHub. Focused
local work is serial and low priority: sampled aggregate RSS below 1 GiB,
target below 2 GiB, free disk at least 64 GiB, deadline 180 seconds. Stop at
limits and move work to CI; never raise or bypass them. Use:

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

The fun-refactor guard applies to the other repository. Current shared target
belongs to /private/tmp/fwp-map-unwind-worktree after bounded package clean of
row83(0.06CPU/0.37elapsed) and the final-squash rebase/rebuild. Focused command:
cargo test --test map_unwind_ownership --test map_ownership --test runtime_call_ownership,
through the absolute-root guard with OpenSSL; all nine tests pass22.95/46.05s.
Before switching Rust checkouts, bounded cargo clean -p fwp in this checkout
then rebuild the requested target. Earlier switches/checks are in history;
never infer source identity from a shared target directory. Full gates run on
GitHub. Temporary helpers may disappear; actual bases and retained tags are
the durable recovery record.

The preparation table gives current focused results; earlier package checks,
refusals and superseded revisions are archived in history. Every workload
samples current limits; historical observations never authorize bypassing the
guard. Full-size raw tail evidence stays on GitHub because it exceeds local
RSS. No local full gate was run.

The stronger shared audit is merged in PR105: live heads must match the queue,
and their recorded actual bases must be ancestors of those heads. It also
checks all tracked Markdown link sets, immutable tags and whole commit messages.
Isolated stale-head and stale-base controls fail as expected; corrected controls
pass. Run the shared checker through the root guard:

```sh
python3 scripts/local-guard.py python3 scripts/check-roadmap.py
```

Fetch full history, immutable tags and retained PR heads on a fresh clone.
The roadmap_docs workflow checks the actual PR head. Audit again after changes
to links, refs or commit subjects. Merged rows26–27 are archived and removed from
the live preparation table; their queue anchors and accepted heads stay fixed.

Preserve all 11 authoritative docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md and docs/numerics.md. The numerics page
keeps phase2 exit gates ahead of representation work and links historical
incomplete timings to the archive. Preserve any other modified tracked files too.
Latest 11-doc snapshot is /private/tmp/fwp-main-docs-pre105 with sha256.json;
all were restored byte-for-byte after updating main. Refresh before the next
main update. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
