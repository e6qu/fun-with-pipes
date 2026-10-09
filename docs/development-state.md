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

Main is `b5bf33c43144f663c7da77c1f0735e372d2bc6dd` (PR #109). Accepted head
`8371fc50c9bfbbe57f0968b58e5a5541b60beefe` passes all six production jobs in
CI 38018485993 and roadmap_docs 38018485946. Match-head squash at
2026-10-10T03:31:08Z has the exact 67-character message
`Release selected list aliases and scratch storage on nonlocal exits`, with one line, an empty body and no trailers or attribution.
Complete tree `eb2cd7c97254c8f579459d563607adc4185f4c5d` matches the tested head.
Raw-message, tree and final-gate proofs are saved locally. All 11 live docs were
hashed in /private/tmp/fwp-main-docs-pre109 and restored byte-for-byte after main FF.
Duplicate main CI 38020842761 was cancelled only after that proof; main docs
38020842844 passes. Native macOS and selected ownership are delivered through
selection alias/partial-spine/scratch unwind. Phase 2 remains incomplete;
phases 3–6 remain pending and tracing remains the fallback.

Next concrete delivery: finalize queue 31 zip unwind on this actual squash base,
preserve original source/probes, run bounded focused checks, copy all 11 live
docs, publish with an exact lease and open the next focused PR. Require all
seven exact-head gates before squash. Queue 32 fold is independently prepared.
Keep one production PR open and continue repairing later evidence while CI runs.

Queue 34 is a verified duplicate of preparation code/probes delivered in #107.
Skip its implementation PR when reached after 33; preserve its immutable anchor,
current ancestry and all later regression coverage.

## Staged repairs and next independent work

Full queue evidence38016929326/3a97905c exposes the unchanged source65
unboxed-worker aliases assertion: `aliases boxed a worker argument`. Local
source65 reproduction fails6.65CPU/13.68elapsed with that exact assertion;
its generated C boxes the six-field record before the worker call. Diagnostic
file-write instrumentation is restored byte-for-byte; native assertions stay
unchanged. Worker-use recognition accepted bare locals but missed locals under
count operations after the earlier inline-argument repair. The narrow fix uses
is_local_through_counts only for complete compatible worker arguments; partial
and dynamic applications still box. All nine original worker/conversion/caller/
retain tests pass27.80CPU/56.39elapsed, clippy2.35/4.78s and format0.35/0.73s
pass. Earliest row65 repair `60b03078c3cd` is published; final commit audit
0.42CPU/3.36elapsed passes. Prior886f8b0 is retained remotely. Preserve original
native probes:66–73 refresh passes8.39CPU/91.73elapsed, preserving both
resource-frame commits. Refresh74–81 passes8.62CPU/92.55elapsed and82–89 passes8.69/92.92s; 90–97 refresh is complete; 98–105 refresh passes8.58CPU/91.68elapsed; continue106–112 in batches of at most eight through
/private/tmp/fwp-refresh-counted-worker-arguments.py, then repair the Intel HTTP/2 fixture and refresh failed full
evidence. Completed fwp-counted-worker-refresh journals must not be rerun. Full runs and
production deliveries continue; failed evidence never establishes support. Raw/clean logs:
/private/tmp/fwp-full-ownership-38016929326-arm-failure[.clean].log; emitted C:
/private/tmp/fwp-worker-alias-886f8b-generated.c.

Intel regular evidence also fails the strict HTTP/2 omitted-owner control:
http2_body_roots expected exit 1 but got 0. Its positive collection/payload/
finalizer controls pass; stale conservative roots can hide the omission.
Extend only the existing x86-64 fixture isolation to Clang, retaining the ARM
fixture and every original assertion. Verify on Intel Clang, Linux GCC/Clang
and ARM before publication and propagation from row 89 through 112. This is a
fixture repair, not verified runtime support. Old full evidence remains failed.

Row 33 normalizes bound/inline Again records and reads cancellation owners by
the actual emitted layout;35 selects the intended pending-call IR checkpoints;
47 protects evaluated CAFs during later scalar evaluation. Original allocation,
alias, release and scalar-bit assertions stay intact. Earlier source-specific
passes and superseded heads are archived; they never accept rewritten sources.

Cache/task evidence329e8db/CI 38011548324 exposed missing remaining-owner cleanup
during boxed match-to-worker conversion. Local reproduction fails too. Row 43
repair `8c7450568632` adds the completed consumed-match checkpoint without
replacing operation/retain checkpoints. Its new IR control fails before the fix;
all 20 row 43 IR controls and seven original native tests then pass, including all
three exact omission controls, O1/O2, raw interpreter, GC verification and reuse
poisoning. Original native probes are unchanged. Repaired cache/task evidence
`2d5d52fd941c` runs CI 38013532481 on repaired source52 `cb32c2cea9bb` and includes
all 21 IR controls and the original stack/reuse gates. The scoped run passes;
this validates its Linux source, while each production PR still needs full gates.

Typed-holder evidence372375a/CI 38011999875 exposed a parent-box allocation
regression for a direct resource variant constructor. Row 83 repair
`06215746caae` admits eligible direct constructors only for original frame
holders, respecting the variant-return flag. All five original variant/record/
frame tests, lint, format and audit pass. Zero/one parent-box, File lifetime,
alias and inactive-payload assertions are unchanged. Refreshed holder evidence `f7d7585b89ad` is byte-identical in source, native
probes, scripts and production workflows to repaired source88 `acce7492f8d3`.
All 21 ownership IR controls and original stack/reuse gates remain required.
CI 38015529998 passes; failed CI 38011999875 remains archived, not support.

Both repairs now propagate through row 112. Each bounded batch verifies exact
inherited code, original probes and commit counts, retains prior heads remotely,
publishes with an exact lease and audits the handoff. Both resource-frame
commits, the frame-holder repair and both nominal/whole-stack match commits
survive. Detailed commands, timings and conflict resolutions are in history.
Completed refresh journals must not be rerun. Fresh serving/storage evidence
passes on repaired source100/112; prior passes do not accept these new heads.
Every production PR still requires its own seven exact-head gates. Temporary
helpers may disappear; the table, actual bases and retained remote tags preserve
the recovery record.

The million-step native tail regression is merged and tested at O1/O2 with
GCoff/on against a200-step raw oracle. Full-size raw100000 exceeds local RSS;
release runner evidence81362c7/CI 37997969782 passes using1893164KiB peak RSS,
while debug exceeds its existing4GiB stack. Keep those workloads on GitHub;
never raise local/stack limits. Neither result claims constant raw stack or a
speedup. Exact hardware, flags and measurements are in history.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 31 ownership-zip-unwind | 05d354f57167 | b5bf33c43144 | Final actual-squash rebase preserves all source/probes/workflows; six focused tests21.57CPU/43.20elapsed, lint2.37/4.78s, format0.35/0.63s pass; publishing next focused PR; all seven exact-head gates required |
| 32 ownership-fold-unwind | 9aed23988b19 | ff84318a416d | Nine fold/runtime-call checks24.14CPU/48.48elapsed, lint2.33/4.77s, format0.35/0.62s and audit0.44/3.58s pass; exact original source/probe parity; priorc434692 retained before publication; final actual-squash rebase and all gates required |
| 33 ownership-loop-unwind | 527f84d405b77 | c434692ccb6f | Inline/bound Again repair: two loop tests 10.45CPU/20.96elapsed, lint 2.32/4.58s, format 0.36/0.76s, audit 0.44/3.37s pass; full sequential gates remain required |
| 34 ownership-argument-preparation | 734d3383addf | 527f84d405b7 | Source/tests/scripts/workflows identical to33; docs only; audit 0.44/3.50s passes; skip duplicate PR after 28 full acceptance |
| 35 ownership-constructor-unwind | be0032a15ee3 | 734d3383addf | Six tests 22.36/45.17s; exact unit3.39/7.02s; lint 2.28/4.73s, format 0.35/0.74s and strong audit pass |
| 36 ownership-worker-boxing | e171da5957fd | be0032a15ee3 | Three tests 15.44/31.12s; lint 2.40/4.94s, format 0.35/0.62s and strong audit pass; final sequential gates follow |
| 37 ownership-worker-preparation | ba9f0f293ac8 | e171da5957fd | Three tests 15.91/31.88s; lint 2.33/4.78s, format 0.35/0.63s and strong audit pass; final sequential gates follow |
| 38 ownership-loop-preparation | 2a45666b37a1 | ba9f0f293ac8 | Four tests 16.61/33.35s; lint 2.26/4.59s, format 0.34/0.62s and strong audit pass; final sequential gates follow |
| 39 ownership-variant-preparation | dd8444579ed0 | 2a45666b37a1 | Three tests 16.18/32.57s; exact retain unit3.33/7.00s, lint 2.40/4.91s, format 0.35/0.75s and strong audit pass |
| 40 ownership-constructor-types | cccbe406449f | dd8444579ed0 | Three tests 16.23/32.69s plus fifteen IR tests 3.32/6.89s; lint 2.36/4.59s, format 0.35/0.75s and strong audit pass |
| 41 ownership-variant-conversion | 172912b7b1c6 | cccbe406449f | Three tests 16.62/33.51s; exact conversion IR unit3.23/6.74s, lint 2.32/4.72s, format 0.35/0.62s and strong audit pass |
| 42 ownership-record-update | 2b61f8cad333 | 172912b7b1c6 | Two updates15.01/30.20s; unit3.22/6.67s; lint 2.28/4.57s and format 0.34/0.60s pass |
| 43 ownership-record-conversion | 8c7450568632 | 2b61f8cad333 | Matched-result checkpoint repair: all 20 IR controls 3.25/6.97s, seven native tests 26.91/53.88s, lint 2.38/4.81s, format 0.35/0.63s pass; strong audit 0.43/3.47s passes; source8c74505 published with prior head retained; runner/full gates follow |
| 44 ownership-variant-alias | 5e436e6ee6f5 | 8c7450568632 | Two tests 8.67/17.52s; lint 2.32/4.66s and format 0.35/0.73s pass |
| 45 ownership-match-context | 44e720054249 | 5e436e6ee6f5 | Two tests 8.71/18.12s; lint 2.55/5.06s and format 0.44/0.84s pass |
| 46 ownership-field-context | 3a87da04a671 | 44e720054249 | Two tests 9.08/18.73s; lint 2.42/4.93s and format 0.43/0.83s pass |
| 47 ownership-caf-cache | 7e507e993e58 | 3a87da04a671 | Three tests 11.54/24.96s; lint 2.38/4.80s and format 0.44/0.83s pass |
| 48 ownership-inline-caf | 3dd5219cb896 | 7e507e993e58 | Two tests 12.68/26.01s; lint 2.47/4.90s and format 0.35/0.73s pass |
| 49 ownership-task-thunks | 2c14070a6347 | 3dd5219cb896 | Two tests 10.19/20.78s; lint 2.33/4.82s and format 0.35/0.73s pass |
| 50 ownership-task-within | f35dd8c34ea4 | 2c14070a6347 | Test8.95/18.26s; inventory unit3.33/6.98s; lint 2.43/4.79s and format 0.35/0.73s pass |
| 51 ownership-task-scope | bb1e6b94fcfd | f35dd8c34ea4 | Test9.76/20.17s; lint 2.45/4.85s and format 0.34/0.62s pass |
| 52 ownership-task-handles | cb32c2cea9bb | bb1e6b94fcfd | Test11.24/23.29s; lint 2.34/4.73s and format 0.44/0.74s pass |
| 53 ownership-channel-queues | 69bc96667a52 | cb32c2cea9bb | Test11.45/23.08s; inventory3.40/7.25s; lint 2.43/4.79s and format 0.45/0.87s pass |
| 54 ownership-library-results | f53cccc88d45 | 69bc96667a52 | Test7.86/17.88s; lint 2.44/4.85s and format 0.34/0.61s pass |
| 55 ownership-library-inputs | 067d547b3bfd | f53cccc88d45 | Two tests 8.27/18.38s; lint 2.34/4.68s and format 0.34/0.61s pass |
| 56 ownership-library-unload | 0d30f4e3da51 | 067d547b3bfd | Test8.98/21.43s; lint 2.42/4.81s and format 0.45/0.74s pass |
| 57 ownership-opencl-lifetime | 9dc98a72cac1 | 0d30f4e3da51 | Fake API test 7.78/22.85s; lint 2.36/4.71s and format 0.45/0.75s pass |
| 58 ownership-interpreter-opencl | 013b07eac021 | 9dc98a72cac1 | Fake API interpreter/native11.27/27.44s; lint 2.32/4.69s and format 0.34/0.62s pass |
| 59 ownership-tls-listeners | 64fc39f9738e | 013b07eac021 | Test8.61/19.51s; lint 2.46/5.00s and format 0.35/0.75s pass |
| 60 ownership-library-resources | aa8dfb3a703e | 64fc39f9738e | Test8.04/18.34s; lint 2.48/4.99s and format 0.41/0.86s pass |
| 61 ownership-grpc-server-cleanup | 91f9a30742f9 | aa8dfb3a703e | Test9.94/19.99s; lint 2.46/4.95s and format 0.44/0.86s pass |
| 62 ownership-tls-cache-failures | 0ba865002ace | 91f9a30742f9 | Test7.17/16.27s; lint 2.43/4.95s and format 0.40/0.73s pass |
| 63 ownership-tls-wire-preparation | 52bc4e64547b | 0ba865002ace | Test7.54/16.19s; lint 2.45/4.96s and format 0.45/0.86s pass |
| 64 ownership-connect-cancellation | d364e70df274 | 52bc4e64547b | Test7.77/17.05s; lint 2.31/4.60s and format 0.44/0.60s pass |
| 65 ownership-unboxed-worker-locals | 60b03078c3cd | d364e70df274 | Count-wrapped worker repair: nine original controls27.80CPU/56.39elapsed, lint2.35/4.78s, format0.35/0.73s and final audit0.42/3.36s pass; prior886f8b0 retained before exact-lease publication; propagation/full evidence follow |
| 66 ownership-tls-peer-subject | cfe905046796 | 60b03078c3cd | Test7.47/16.47s; lint 2.33/4.59s and format 0.44/0.84s pass |
| 67 ownership-tls-alpn-roots | f7a0bd2eba93 | cfe905046796 | Test6.99/14.97s; lint 5.72/11.65s and format 0.44/0.84s pass |
| 68 ownership-ci-probe-repairs | 351b21daafbb | f7a0bd2eba93 | Timer test 10.28/21.81s; lint 5.61/11.71s and format 0.46/0.87s pass |
| 69 ownership-nested-loop-boxing | 925724e0994d | 351b21daafbb | Three tests 14.44/29.19s; lint 5.60/11.68s and format 0.35/0.63s pass |
| 70 ownership-file-construction | 823b86c74a68 | 925724e0994d | Test7.49/16.08s; lint 5.42/11.61s and format 0.36/0.76s pass |
| 71 ownership-file-write-visibility | de6667643951 | 823b86c74a68 | Two tests 8.14/17.09s; lint 5.55/11.78s and format 0.35/0.75s pass |
| 72 ownership-file-io-errors | 4aeff2223e3f | de6667643951 | Three tests 14.85/30.79s; lint 5.53/11.82s and format 0.35/0.62s pass |
| 73 ownership-resource-frames | c5bc20fc095b | 4aeff2223e3f | Three integrations12.65/25.47s; three units3.81/7.73s; lint 6.13/12.55s and format 0.44/0.84s pass |
| 74 ownership-file-runtime-owners | d3fa39b37c83 | c5bc20fc095b | Test8.17/18.29s; lint 5.82/12.43s and format 0.43/0.83s pass |
| 75 ownership-file-discard | 4b8202419941 | d3fa39b37c83 | Test13.04/26.17s; lint 5.83/12.17s and format 0.44/0.83s pass |
| 76 ownership-file-runtime-boundaries | b5aee4eb6e95 | 4b8202419941 | Test18.99/38.40s; lint 5.98/12.65s and format 0.46/0.84s pass |
| 77 ownership-wasm-resource-counts | 231568d07731 | b5aee4eb6e95 | Actual WASI gates remain required; native bump checks are not WASI proof |
| 78 ownership-wasm-count-disposal | c7ba897d8d9c | 231568d07731 | Actual WASI gates required; source unchanged except inherited harness repairs |
| 79 ownership-resource-frame-fields | 8053dc693a13 | c7ba897d8d9c | Test10.09/21.47s; lint 6.10/13.03s and format 0.55/1.08s pass |
| 80 ownership-file-inline-path | 0ea8a1c94115 | 8053dc693a13 | Two tests 10.54/21.29s; lint 6.87/13.94s and format 0.54/1.07s pass |
| 81 ownership-file-storage-disposal | 2fffa57d369d | 0ea8a1c94115 | Test8.53/19.18s; lint 6.72/13.84s and format 0.45/0.84s pass |
| 82 ownership-file-construction-disposal | c6cbacac0db9 | 2fffa57d369d | Test8.16/18.70s; lint 6.09/12.99s and format 0.44/0.83s pass |
| 83 ownership-resource-frame-variants | 53440f785f65 | c6cbacac0db9 | Direct frame-constructor repair: five original native tests 20.72CPU/41.72elapsed, lint 2.34/4.77s and format 0.45/0.86s pass; strong audit 0.42/3.47s passes; source0621574 published then rebased toed1091ff988c with exact code/probe parity; runner/full gates follow |
| 84 ownership-resource-frame-binding-kinds | 073a20c8d7ef | 53440f785f65 | Test10.45/23.67s; lint 6.18/12.88s and format 0.45/0.83s pass |
| 85 ownership-match-scrutinee-types | 1236f09a1d85 | 073a20c8d7ef | Two tests 12.49/27.27s; lint 6.11/13.31s and format 0.44/0.83s pass |
| 86 ownership-resource-record-binding-kinds | f5a017db54da | 1236f09a1d85 | Test10.49/22.84s; lint 6.03/12.91s and format 0.41/0.86s pass |
| 87 ownership-nominal-source-context | 08beb7c2bc23 | f5a017db54da | Raw source/native test 13.09/26.43s; lint 6.14/13.07s and format 0.45/0.86s pass |
| 88 ownership-channel-cycle-lifetimes | b2d374878677 | 08beb7c2bc23 | Two cycle/queue tests 13.30/26.87s; lint 5.94/13.04s and format 0.46/0.87s pass |
| 89 ownership-http2-body-roots | 177a08a204d7 | b2d374878677 | GCC stale-root fixture passes normal Linux37990203134 and ARM15.46/31.62s; later propagation follows |
| 90 fix-http2-body-bounds | c80d278dd53d | 177a08a204d7 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 91 ownership-http2-peer-cleanup | 16edf14e0b94 | c80d278dd53d | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 92 ownership-grpc-peer-completion | 52433827539e | 16edf14e0b94 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 93 ownership-grpc-status-cleanup | aa2a5aa9a912 | 52433827539e | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 94 ownership-grpc-receive-cleanup | e783dfc73c6a | aa2a5aa9a912 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 95 ownership-grpc-force-cleanup | a4481338b05a | e783dfc73c6a | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 96 ownership-grpc-render-cleanup | 2471ba8194d9 | a4481338b05a | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 97 ownership-grpc-send-cleanup | 0aac7d0311f4 | 2471ba8194d9 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 98 ownership-grpc-request-encoding | ae4ef94a5afb | 0aac7d0311f4 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 99 ownership-grpc-canonical-encoding | eb5ae0a4a4c2 | ae4ef94a5afb | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 100 ownership-grpc-response-encoding | 3883d1abaccc | eb5ae0a4a4c2 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 101 ownership-grpc-client-requests | 9bdd82863c39 | 3883d1abaccc | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 102 ownership-grpc-client-failure-text | 7e011508db02 | 9bdd82863c39 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 103 ownership-grpc-client-receive | b7961a14d5dd | 7e011508db02 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 104 ownership-grpc-connect-cleanup | 392a5721e544 | b7961a14d5dd | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 105 ownership-grpc-connect-startup | 96174aaaf6be | 392a5721e544 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 106 ownership-grpc-context-restore | 8c53b11ae1d0 | 96174aaaf6be | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 107 ownership-grpc-context-resources | e36c9af3743f | 8c53b11ae1d0 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 108 ownership-grpc-capture-resources | 1362d3a239bc | d4b360f6cc71 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 109 fix-grpc-tls-pool-identity | 5a6b79b7a008 | 1362d3a239bc | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 110 ownership-grpc-environment-cache | 66d7d93e57f5 | 5a6b79b7a008 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 111 ownership-grpc-packed-options | a7d089cc5153 | 66d7d93e57f5 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 112 ownership-grpc-connection-addresses | 996d5ee4ef4f | a7d089cc5153 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |

Prepared focused evidence, detailed commands and earlier source-parity proofs
remain in history. The Main and next delivery section supplies the sole live
next action. Every production PR requires six exact-head full gates and the
documentation audit.

Use actual bases above for final rebases, never OLD anchors or rewritten
predecessor heads. Preserve all 11 root docs for conflict resolution and
inherited CLI/GC harness fixes. The table records actual bases; historical
evidence bases never override them.
Rows77–78 require real WASI on Linux in both free modes; native bump checks
supply no WASI acceptance. Row 20 boxed128-bit payloads remain shared. Network
context wrappers retain tracing compatibility; no complete ARC claim. Channel
close preserves queued values; explicit drain breaks its counted cycle, while
automatic unreachable-cycle reclamation remains unproved.

## Earlier argument-preparation repair

Row 28 now includes row 34's capture-preparation correction: supplied arguments
stay owned until capture duplication succeeds, and partial duplicated captures
have registered cleanup. The unchanged negative control catches its omission.
The live preparation/evidence tables above give current heads and checks;
previous revisions and propagation results are in history.
Row 28 passed full acceptance in PR #107. Skip the duplicate implementation PR at
row 34 while preserving its immutable anchor and regression coverage. Current
row 34 differs from row 33 only in docs. No general exceptional-ownership claim.

## Fixture repair status

Earlier row 29 production84ef5480f4938e78c11c10823bf498a8a1a4e6f9 passes normal
Linux evidence5c24e0d34ea3b0d9ff4639ba4f0e1bf50c407135, CI 37966274872:
format/lint, map/call/reuse/cleanup/task ownership, actual tracing and all-doc/tag
checks. No diagnostics remain. GDB identified a fixture call to
fwp_gc_chunk_of(ci=NULL), which requires an output pointer; using local ci
preserves all assertions and changes no runtime/compiler code.
Row 30 ca33d3141a96 inherits that fix on actual84ef548 and fixes its identical
observer. Normal evidence7a6ca031fc0b6a10295dc86e07bb83ef0601a295,
CI 37966690637, passes.
Rows29–32 and34 bring the known row 68 mandatory output-pointer repair into
their earlier deliveries. Keep the later row 68 repair from overwriting these
fixtures or inherited CLI/GC changes. Preserve
all alias/reclamation assertions. Detailed failed/diagnostic logs stay in history.

## Separate evidence and remaining audits

Earlier passed evidence predates the complete PR #106 call repair unless stated
otherwise. Refresh scoped evidence on the repaired source; no historical pass
accepts a current production head. Superseded runs are archived in history.

| Scope | Exact evidence head | Run / status |
|---|---|---|
| Complete prepared ownership queue through 112 | 3a97905ca9801d4751f02798bc7240ddba2d8ccd | Full evidence38016929326 fails Linux and both regular macOS jobs on source112 996d5ee4ef4f: unchanged aliases worker-argument boxing assertion in unboxed_worker_locals. All jobs complete; bench, both macOS GC stress jobs and roadmap_docs pass; actual WASI count/File disposal checks pass on Linux. Source/native probes/scripts/production workflows are byte-identical; strong audit 0.42/3.36s passes. Runner-only evidence branch, no additional PR; never substitutes for each sequential PR head |
| Rows107–112 storage and repaired root controls | a6505b8f17c19c6736966181d1017389a4a6e109 | CI 38015942823 passes on repaired source112 996d5ee4ef4f; all 21 IR controls, original HTTP2/client/pool/storage/tracing probes and stack/reuse gates; strong audit 0.42/3.38s passes. Pure old auditor commit absorbed by stronger base; three remaining evidence commits preserved. Prior e5bbfd8/CI 37992657684 is historical |
| Rows92–100 gRPC serving and encoding | 1ec30f21bc457fe97f9d74616f97baca9f7fa10f | CI 38015884622 passes on repaired source100 a3d88c0b8f3d; all 21 IR controls, original HTTP2/gRPC/tracing probes and stack/reuse gates; strong audit 0.43/3.47s passes. Prior3aca5cf/CI 37993159029 is historical |
| Rows79–88 typed holders and explicit cycles | f7d7585b89ad76f69ffac20e9437db620fb022f4 | CI 38015529998 passes on repaired source88 acce7492f8d3; original holder/cycle/tracing probes, all 21 IR controls and stack/reuse gates. Strong audit 0.42/3.35s passes. Failed372375a/CI 38011999875 exposed direct-constructor boxing; its retained head and fix are in history. Explicit draining does not prove automatic cycle reclamation |
| Rows77–78 actual WASI counts/disposal | 2378565fcf68780e0235dc120c3533f68c8868f0 | CI 38016089987 passes on current source78 43773a07a269; mandatory actual WASI, original resource/tracing probes, all 21 IR controls and stack/reuse gates. Strong audit 0.46/3.56s passes. Prior24e7e57/CI 38011802620 predates matched-result repair |
| Rows69–76 File and original resource frames | cee001573c1ec0dd25f05097a71a57b662a03239 | CI 38016049553 passes on current source76 f0034b6ab7c1; original File/frame/loop probes, all 21 IR controls, stack/reuse and tracing gates. Strong audit 0.50/3.71s passes. Prior c5665d0/CI 38011728123 predates matched-result repair |
| Rows47–52 cache and task runtime | 2d5d52fd941c03b6bd0ff0c908ff6edeaf3c634f | CI 38013532481 passes on repaired source52 cb32c2cea9bb; all 21 IR controls and unchanged native conversion/stack/reuse gates; strong audit 0.43/3.46s passes. Prior329e8db/CI 38011548324 failed matched conversion and is retained |
| Rows26–41 callback/constructor/typed conversion | ba3a0f2412f8380a6b8a1c1e60e1496c425b73f5 | CI 38008988824 passes on current41 at 172912b; loop/observer and exact pending-call controls repaired; allocation gates, full IR module, tracing/lint/docs |

Earlier scope heads and full run IDs are preserved in
[the evidence archive](roadmap-history.md#earlier-scoped-evidence-handoff).

Evidence workflows never enter production ancestry. Every sequential PR still
requires all six gates at its own current head. Preserve both row 85 commits: its repaired typed
whole-stack binder and nominal File disposal. Failed and superseded logs remain in history.

Row 111 verifies one TLS-option allocation, exact requested bytes, alignment,
copied inputs, last-owner release and allocation-failure cleanup. It makes no
elapsed-speed or whole-program tracing-free claim. Row 110 verifies read-once
cache teardown after blocked tasks and finalizers; row 111 changes selected
cache releases from ten malloc allocations to five. Row 112 locally verifies long-address loopback/pool reuse, copied inputs and
requested bytes below the legacy short-address layout atO1/O2 with GC/reuse
variants. Focused Linux CI 37958243461 also passes; full sequential platform gates remain required.

A bounded source112 metadata inventory finds134 explicit entries among373
library primitive symbols (0.22CPU/0.86elapsed). Absent metadata is not an
effective runtime-sharing count: combinator lowering, scalars and runtime
wrappers need separate review. Findings and module lists are in history; the
primitive ownership page records this limit. Use that inventory for the finite
phase 2 exit review after sequential ownership deliveries.
Later numeric-phase review findings are in numerics.md: native backward mixed-tape
cleanup, grad failure/cancellation before backward and 32767-generation wrap
need concrete regressions. These are source-review findings; no new numeric
implementation or full-lifetime guarantee is claimed. Keep phase order unchanged.

Canonical C decode scratch already frees on normal success/error paths;
reconstructed decoded aggregates remain shared. Audit typed reconstruction,
partial construction, retained runtime contexts and automatic unreachable-cycle
reclamation against the finite phase 2 exit criteria in ownership.md. Channel
close preserves queued values; explicit drain alone proves its counted cycle
can be broken. Preserve raw interpreter comparisons and original pipe semantics.

## Accepted guard and fixture controls

The guard sampling repair is merged in PR #104, with all exact-head platform gates.
It suspends workloads during target-size sampling and preserves every resource
limit. Three deterministic integration checks cover suspension/resumption,
sampler errors and the original target-size limit. The stronger handoff audit
merged in PR #105 verifies recorded live heads and actual source-base ancestry.
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
fixture corrections propagate through 90–112; subsequent argument/loop repairs
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
belongs to /private/tmp/fwp-unboxed-worker-worktree after bounded fold-package
clean0.00CPU/0.14elapsed. Local original worker assertion fails6.65/13.68s before
the repair; nine worker/conversion/caller/retain checks pass27.80/56.39s after.
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

The stronger shared audit is merged in PR #105: live heads must match the queue,
and their recorded actual bases must be ancestors of those heads. It also
checks all tracked Markdown link sets, immutable tags and whole commit messages.
Isolated stale-head and stale-base controls fail as expected; corrected controls
pass. Run the shared checker through the root guard:

```sh
python3 scripts/local-guard.py python3 scripts/check-roadmap.py
```

Fetch full history, immutable tags and retained PR heads on a fresh clone.
The roadmap_docs workflow checks the actual PR head. Audit again after changes
to links, refs or commit subjects. Merged rows26–29 are archived and removed from
the live preparation table; their queue anchors and accepted heads stay fixed.

Preserve all 11 authoritative docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md and docs/numerics.md. The numerics page
keeps phase 2 exit gates ahead of representation work and links historical
incomplete timings to the archive. Preserve any other modified tracked files too.
Latest 11-doc snapshot is /private/tmp/fwp-main-docs-pre108 with sha256.json;
all were restored byte-for-byte after updating main. Refresh before the next
main update. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
