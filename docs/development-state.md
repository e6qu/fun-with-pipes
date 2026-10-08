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

Main is `ff29c268eed8669d812d40d1050e0c4bd188d52c` (#106).
Accepted head `5683df1c8a96bad30e3c679987e87694387c3b62` passes all six
production jobs in CI38006543549 and roadmap_docs38006543521. Explicit
match-head squash at2026-10-10T00:44:53Z has the entire58-character message
`Protect live compiler owners across calls and cancellation`, with empty body
and no trailers/attribution. Complete tree943eb09f97dbf03a03fa69c59aeb6ff39f17dfc5
matches the accepted head. Raw-message and tree proofs are saved locally.
Duplicate main CI38010369877 is cancelled only after this parity/gate proof;
main roadmap_docs38010369880 passes too. All11 docs are backed up and hashed
in /private/tmp/fwp-main-docs-pre106 and restored byte-for-byte after main FF.
Refresh that snapshot before the next main update.

#74–#106 deliver native macOS and selected typed ownership through compiler
reuse-token and live caller/pending-argument cleanup. Phase1 is done; phase2
remains incomplete; phases3–6 are pending. Tracing remains the fallback.
PR107 is open: https://github.com/e6qu/fun-with-pipes/pull/107. Its exact head is
1dcbe79ac0777b83cad6f49b8ab4b28ad140c854 on actual squash baseff29c268eed8669d812d40d1050e0c4bd188d52c.
Row28 protects runtime application/pending-argument cleanup and incorporates the
original row34 capture-preparation repair. Both implementation commits survive
the rebase; source/tests/scripts/workflows match prior131ec8ebdd06 byte-for-byte.
All14 focused integration tests33.34CPU/67.02elapsed,13 IR controls3.29/6.83s,
focused clippy2.34/4.66s, format0.34/0.61s and strong audit0.47/3.67s pass.
All11 live docs are copied into the PR. Prior remote131ec8ebdd06 is retained at
roadmap/revision-028-131ec8ebdd06 before exact-lease publication. Freeze this head
except for actual fixes; record fresh production/documentation run IDs and wait
for all seven exact-head gates before squash. Production CI38011227462 is running;
its benchmark and ARM GC jobs pass. Roadmap docs38011227532 passes, all at head1dcbe79. While CI runs, refresh66–112 and
scoped evidence using their recorded actual bases. Next production delivery29
opens only after107 merges and its squash message/tree are verified.
Squash subject: `Protect runtime application owners through preparation and unwind`;
empty body, at most80 characters. Do not reopen or rewrite accepted106.

Current106 repair preserves stack/reuse allocation limits while protecting
computed, duplicated and scalar-final argument lifetimes. All final17 focused
integration/allocation checks and13 ownership-IR checks, lint/format and audit
pass before the seven full gates. Failed9c1b5a8/7a550b7 heads and runs are
retained and archived; neither was accepted. Original pipe/effect/trap semantics
and allocation assertions are unchanged.

Later preparation repairs are separate:33 adds bound/inline Again record
normalization and an emitted-layout cancellation observer;35 corrects new IR
controls to select their pending calls;47 preserves evaluated CAFs during later
scalar evaluation. Existing alias/release/scalar-bit assertions remain intact.
Combined evidenceba3a0f2412f8380a6b8a1c1e60e1496c425b73f5 passesCI38008988824
on current41 at172912b7b1c66e3d6e50a60090b8b7559ffc4ffa, including all18 IR
checks and original stack/reuse gates. All three loop checks pass13.79CPU/27.69elapsed
locally, all18 IR checks3.33/7.13s. Rows42–49 exact repair refresh passes
8.26CPU/93.23elapsed;50–57 passes8.53/92.92s;58–65 passes8.39/92.32s.
Every prior head is retained; immutable OLD anchors stay fixed. Current65 is
98f5c04f6260e56d57c86e437486bb04d392aa7d on actual04811432dc3d.
Rows66–73 now inherit the reviewed repairs. The guard initially stopped on the
row69 observer and row73 ResourceRegion compiler conflicts; both were reviewed:
keep the generic observer plus the original flattened-field assertion, and retain
both inline Again normalization and resource traversal. Original probe assertions
and both row73 commits survive. Serial bounded parts:3.28CPU/37.18elapsed stopped
at69;4.55/51.41s stopped at73;1.24/16.12s completes. Documentation-only continuations
pass0.00/0.13–0.14s; an initial resolver invoked from root safely refuses without
changing files. Current73 is006aba78f1f5f16406a4c7cca5864781f959cdcf on2990083331a2.
Rows74–81 refresh passes8.66CPU/93.03elapsed with exact reviewed source
inheritance; original probes and actual-WASI requirements remain unchanged.
Rows82–89 refresh passes8.50CPU/93.22elapsed; both row85 commits and HTTP GC
fixture controls remain intact. Rows90–97 refresh passes8.57CPU/93.54elapsed with strict compiler/runtime/probe
parity apart from the reviewed inherited fixes. Rows98–105 refresh passes8.56CPU/92.90elapsed. Next refresh106–112 after diagnosing
the failed cache/task conversion negative control; completed journals stay fixed.
The table records actual bases; all earlier focused evidence predates these
repairs unless stated otherwise. Each production delivery still needs its own
final squash-base rebase and all seven fresh gates. Skip duplicate34 only after28
full acceptance, preserving its immutable anchor and coverage.

The merged million-step native tail regression passes O1/O2 with GCoff/on
against a200-step FWP_NO_OPT=1 oracle. Full-size raw100000 local execution
exceeds1GiB and was stopped; keep it on GitHub. Release-runner evidence81362c7
CI37997969782 passes the same full-size raw program/output, using1893164KiB
peak RSS; the debug runner overflows its existing4GiB stack. Neither proves
constant raw interpreter stack or a speedup. Exact metadata and logs are in
history. Never raise local or stack limits to repeat those probes.

Cache/task evidence329e8db/CI38011548324 fails an original conversion negative
control (exit7 instead of4). Local source52 reproduces8.10CPU/16.53elapsed.
The emitted boxed match-to-worker conversion lacks a checkpoint for remaining
caller owners. Repair it at row43 by recording the completed consumed match
state; keep operation/duplicate checkpoints unchanged. A new precise IR control
fails before the fix3.35CPU/7.11elapsed. With the fix, all20 row43 IR controls
pass3.25/6.97s; seven native conversion/caller/partial-retain tests pass26.91/53.88s,
including every original positive and exact negative assertion at O1/O2 with
GC stress/verification and reuse poisoning. Focused lint2.38/4.81s, format0.35/0.63s
pass. Original native probes and compiler allocation gates are unchanged.
Row43 repair8c74505 is published with prior b42bfee retained. Refresh44–51
passes in two bounded parts:3.23CPU/35.30elapsed stops at a CAF control insertion
conflict;5.25/60.14s completes after preserving both exact controls.
Rows52–59 now refresh successfully8.33CPU/93.48elapsed.
Refresh60–112 from their actual bases and rerun the
failed cache/task evidence on repaired52. Prior later source passes do not
accept this new checkpoint. Keep PR107 frozen; its source lacks the later row43
conversion feature. Log /private/tmp/fwp-task-runtime-38011548324-failure.clean.log
and /private/tmp/fwp-match-conversion-owner-control.rs preserve local diagnosis.

Typed-holder evidence372375a/CI38011999875 fails the original zero-parent-box
variant-frame assertion (mode1 exit33). Local row83 reproduces8.96CPU/18.63elapsed.
The general variant heuristic excludes direct constructors; the frame-holder
analysis reused it after the argument repair made this constructor direct.
Allow direct nonempty, eligible variant constructors only for original frame
holders, respecting the variant-return flag. All five original variant/record/frame
tests pass20.72CPU/41.72elapsed, preserving zero-parent-box and boxed controls,
File lifetimes, returned aliases, inactive tags, GCoff/on, O1/O2 and reuse modes.
Focused lint2.34CPU/4.77elapsed and format0.45/0.86s pass.
No probe or allocation assertion changes. Row83 repair0621574 is published
with prior8bf7da6 retained; strong audit0.42CPU/3.47elapsed passes. Include
its exact code in later preparation refreshes, then rerun typed-holder evidence.
Log /private/tmp/fwp-holders-38011999875-failure.clean.log preserves the failure.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 28 ownership-runtime-call-cleanup | 1dcbe79ac077 | ff29c268eed8 | Final squash-base source parity; fourteen focused integration tests33.34CPU/67.02elapsed pass; thirteen IR controls3.29/6.83s, focused lint2.34/4.66s and format0.34/0.61s pass; strong audit0.47/3.67s passes; PR107 exact-head full CI pending |
| 29 ownership-map-unwind | 25eda7b24ef5 | 131ec8ebdd06 | Seven tests24.26/48.82s; lint2.51/5.05s, format0.44/0.61s and strong audit pass; final sequential gates follow |
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
| 60 ownership-library-resources | b2b3e2d73da8 | 2184aa897572 | Test8.04/18.34s; lint2.48/4.99s and format0.41/0.86s pass |
| 61 ownership-grpc-server-cleanup | 15ed94b82b00 | b2b3e2d73da8 | Test9.94/19.99s; lint2.46/4.95s and format0.44/0.86s pass |
| 62 ownership-tls-cache-failures | 004eccb1f092 | 15ed94b82b00 | Test7.17/16.27s; lint2.43/4.95s and format0.40/0.73s pass |
| 63 ownership-tls-wire-preparation | f1915b15033e | 004eccb1f092 | Test7.54/16.19s; lint2.45/4.96s and format0.45/0.86s pass |
| 64 ownership-connect-cancellation | 04811432dc3d | f1915b15033e | Test7.77/17.05s; lint2.31/4.60s and format0.44/0.60s pass |
| 65 ownership-unboxed-worker-locals | 98f5c04f6260 | 04811432dc3d | Two tests8.07/16.86s; lint2.36/4.73s and format0.35/0.62s pass |
| 66 ownership-tls-peer-subject | bde11299c626 | 98f5c04f6260 | Test7.47/16.47s; lint2.33/4.59s and format0.44/0.84s pass |
| 67 ownership-tls-alpn-roots | ff4e98c6979e | bde11299c626 | Test6.99/14.97s; lint5.72/11.65s and format0.44/0.84s pass |
| 68 ownership-ci-probe-repairs | 3135b0d66ba3 | ff4e98c6979e | Timer test10.28/21.81s; lint5.61/11.71s and format0.46/0.87s pass |
| 69 ownership-nested-loop-boxing | 17d47b91a8f6 | 3135b0d66ba3 | Three tests14.44/29.19s; lint5.60/11.68s and format0.35/0.63s pass |
| 70 ownership-file-construction | 3d10c5dd387d | 17d47b91a8f6 | Test7.49/16.08s; lint5.42/11.61s and format0.36/0.76s pass |
| 71 ownership-file-write-visibility | 8c332516937b | 3d10c5dd387d | Two tests8.14/17.09s; lint5.55/11.78s and format0.35/0.75s pass |
| 72 ownership-file-io-errors | 2990083331a2 | 8c332516937b | Three tests14.85/30.79s; lint5.53/11.82s and format0.35/0.62s pass |
| 73 ownership-resource-frames | 006aba78f1f5 | 2990083331a2 | Three integrations12.65/25.47s; three units3.81/7.73s; lint6.13/12.55s and format0.44/0.84s pass |
| 74 ownership-file-runtime-owners | 38d83189cedb | 006aba78f1f5 | Test8.17/18.29s; lint5.82/12.43s and format0.43/0.83s pass |
| 75 ownership-file-discard | f7b57915dd7a | 38d83189cedb | Test13.04/26.17s; lint5.83/12.17s and format0.44/0.83s pass |
| 76 ownership-file-runtime-boundaries | 4c6618c4eb91 | f7b57915dd7a | Test18.99/38.40s; lint5.98/12.65s and format0.46/0.84s pass |
| 77 ownership-wasm-resource-counts | 8d4ba07d6def | 4c6618c4eb91 | Actual WASI gates remain required; native bump checks are not WASI proof |
| 78 ownership-wasm-count-disposal | e037bc5a06dc | 8d4ba07d6def | Actual WASI gates required; source unchanged except inherited harness repairs |
| 79 ownership-resource-frame-fields | d6eabb576bd2 | e037bc5a06dc | Test10.09/21.47s; lint6.10/13.03s and format0.55/1.08s pass |
| 80 ownership-file-inline-path | 19ed00f179a3 | d6eabb576bd2 | Two tests10.54/21.29s; lint6.87/13.94s and format0.54/1.07s pass |
| 81 ownership-file-storage-disposal | 5a4d180478bb | 19ed00f179a3 | Test8.53/19.18s; lint6.72/13.84s and format0.45/0.84s pass |
| 82 ownership-file-construction-disposal | 1dc8cfe230fc | 5a4d180478bb | Test8.16/18.70s; lint6.09/12.99s and format0.44/0.83s pass |
| 83 ownership-resource-frame-variants | 06215746caae | 1dc8cfe230fc | Direct frame-constructor repair: five original native tests20.72CPU/41.72elapsed, lint2.34/4.77s and format0.45/0.86s pass; strong audit0.42/3.47s passes; source0621574 published, prior head retained; propagation/runner/full gates follow |
| 84 ownership-resource-frame-binding-kinds | 9a4fb29ee416 | 8bf7da674bb5 | Test10.45/23.67s; lint6.18/12.88s and format0.45/0.83s pass |
| 85 ownership-match-scrutinee-types | b7e0cc99cf22 | 9a4fb29ee416 | Two tests12.49/27.27s; lint6.11/13.31s and format0.44/0.83s pass |
| 86 ownership-resource-record-binding-kinds | 807afa9962aa | b7e0cc99cf22 | Test10.49/22.84s; lint6.03/12.91s and format0.41/0.86s pass |
| 87 ownership-nominal-source-context | 67f022e93858 | 807afa9962aa | Raw source/native test13.09/26.43s; lint6.14/13.07s and format0.45/0.86s pass |
| 88 ownership-channel-cycle-lifetimes | f194c55d4351 | 67f022e93858 | Two cycle/queue tests13.30/26.87s; lint5.94/13.04s and format0.46/0.87s pass |
| 89 ownership-http2-body-roots | c2c14e491c30 | f194c55d4351 | GCC stale-root fixture passes normal Linux37990203134 and ARM15.46/31.62s; later propagation follows |
| 90 fix-http2-body-bounds | 7f2d4f4ffd46 | c2c14e491c30 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 91 ownership-http2-peer-cleanup | dee3f126a131 | 7f2d4f4ffd46 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 92 ownership-grpc-peer-completion | 307010912bf9 | dee3f126a131 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 93 ownership-grpc-status-cleanup | fec93c5ec707 | 307010912bf9 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 94 ownership-grpc-receive-cleanup | d1f35d6121a4 | fec93c5ec707 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 95 ownership-grpc-force-cleanup | 1e5a5b4f4fb3 | d1f35d6121a4 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 96 ownership-grpc-render-cleanup | d94a2784952d | 1e5a5b4f4fb3 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 97 ownership-grpc-send-cleanup | 080be7e655e3 | d94a2784952d | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 98 ownership-grpc-request-encoding | 6bddc3977352 | 080be7e655e3 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 99 ownership-grpc-canonical-encoding | af556a1cf605 | 6bddc3977352 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 100 ownership-grpc-response-encoding | 3bec687cea7d | af556a1cf605 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 101 ownership-grpc-client-requests | 2ac08dea923a | 3bec687cea7d | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 102 ownership-grpc-client-failure-text | 04e8557ca5e8 | 2ac08dea923a | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
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

Prepared focused evidence and source-parity proofs remain in history.
The guard repair is current, then row26. Detailed commands, full hashes,
fixture failures and omission controls remain in history. Every production PR
requires six exact-head full gates and the documentation audit.

Use actual bases above for final rebases, never OLD anchors or rewritten
predecessor heads. Preserve all ten root docs for conflict resolution and
inherited CLI/GC harness fixes. Row26 is based on main1033bb3426; rows27–28
are refreshed onto their current preceding preparations. The table records
actual bases; historical evidence bases below do not override them.
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
After row28 passes full acceptance, skip the duplicate implementation PR at
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
| Row110 environment cache | 46aacfbb3f6bd5d0058aa0b6f60b2d030ff63944 | CI37948869170 passes focused Linux checks |
| Row111 packed TLS options | 823af3475560ed7709f958478580e364d89bdddf | CI37950759037 passes focused Linux checks |
| Row112 full connection addresses | 4dbd0dcedfc297f8f0859aca22142a55cc0dd79d | CI37958243461 passes after formatting repair7621175 |
| TLS/listener combined | 9bcae30119028b1870efb8fecfcf9746f5808acb | CI37730777345 all six pass |
| WASM/resource combined | 5fd2ed65385a23f3226b2bef02eb10196f51aeb4 | CI37771769436 all six pass, including required actual WASI |
| Rows101–106 gRPC client/connect/context | e4a5c1cab0b01d5b6dd9f7bc7a1859185a7f69e0 | CI37989574765 passes after fixture identity repair; runtime unchanged |
| Rows92–100 gRPC serving and encoding | 3aca5cf20d779fa1e9abbfd89e0588032940fb91 | CI37993159029 passes; historical sourcee6ae6c8, inherited HTTP2 control repaired |
| Rows89–91 HTTP2 roots/bounds/peer cleanup | 8e79458951a8b148e3a3c6a1df488e7f09470fba | CI37990203134 passes normal Linux checks; ARM focused checks pass |
| Rows79–88 typed holders and explicit cycles | 372375a15557b0c295cb5365b5536b4f3fe7f8ab | CI38011999875 fails the original variant-frame zero-parent-box check (mode1 exit33) on source88 f194c55d4351; original holder/cycle/tracing probes, all20 IR controls and stack/reuse gates. Strong audit0.43/3.49s passes. Prior3f0c430/CI37982696642 predates the repairs; explicit draining does not prove automatic cycle reclamation |
| Rows77–78 actual WASI counts/disposal | 24e7e57103f8c74bd3057ac856c7ba8e54378951 | CI38011802620 passes on repaired source78 e037bc5a06dc; required actual WASI, original resource/tracing probes, all20 IR controls and stack/reuse gates. Strong audit0.44/3.47s passes. Prior dc731c1/CI37980359907 predates the repairs |
| Rows69–76 File and original resource frames | c5665d02622883499cdf8a1a9419dc835b1daed2 | CI38011728123 passes on repaired source76 4c6618c4eb91; original File/frame/loop probes, all20 IR controls, stack/reuse and tracing gates. Strong audit0.43/3.46s passes. Prior4a448ea/CI37980022336 predates the repairs |
| Rows63–68 TLS roots, worker locals and timers | b9a6d7f46801d6c4c54b2fd612f2cd03f35bb61a | CI37978789380 passes focused Linux ownership/tracing and docs; source933deb7, actual basebbde0fa |
| Rows57–62 external resource lifetimes | cd3a9d666bb21d6a682e541ae985e9f10de2e096 | CI37976525768 passes focused Linux lifetimes/tracing and docs; productionc61df65, actual base044ceae |
| Rows53–56 channel/library runtime | 3d80e4fa8e2bd3c7927abe36013187db381378f0 | CI37974795204 passes Linux ownership/tracing and docs; productionac6de59, actual base625ac77 |
| Rows47–52 cache and task runtime | 2d5d52fd941c03b6bd0ff0c908ff6edeaf3c634f | Fresh repaired run pending on source52 cb32c2cea9bb; all21 IR controls and unchanged native conversion/stack/reuse gates; strong audit0.43/3.46s passes. Prior329e8db/CI38011548324 failed matched conversion and is retained |
| Rows42–46 records and type contexts | 20b948f8eac1c13b059e64b74d6c9a786c2fed9a | CI37972496949 passes Linux ownership/tracing and docs; productionf2262f9, actual base0b00524 |
| Rows26–41 callback/constructor/typed conversion | ba3a0f2412f8380a6b8a1c1e60e1496c425b73f5 | CI38008988824 passes on current41 at172912b; loop/observer and exact pending-call controls repaired; allocation gates, full IR module, tracing/lint/docs |
| Rows35–37 constructor/worker cleanup | c7e26bb43b6b7edd0c93afbbc25bc7c8e8eaf16f | CI37970487617 passes constructor/worker cleanup, tracing and docs; production3bd34da, actual base6032ecf |
| Rows26–34 callback/loop/argument cleanup | d9017e310a326a885dd65ccb82b810f0d7eb7564 | CI38001360466 passes combined ownership/tracing/lint/docs; source/tests/scripts/production workflows match historical sourcec37df3b |
| Row32 fold callback unwind | ef1e5826ffdeb2f2ee1bd238233d4f6e7fa2aff7 | CI37969003113 passes focused Linux and all-doc/tag checks; production4592876, actual basea282f63 |
| Row31 zip callback unwind | c5da11f3b32df3c67422b470fc6c327001119026 | CI37967629573 passes normal Linux checks and all-doc/tag audit; productiona282f63, actual baseca33d31 |
| Row30 selection callback unwind | 7a6ca031fc0b6a10295dc86e07bb83ef0601a295 | CI37966690637 passes normal repaired checks; productionca33d31, actual base84ef548 |
| Row29 map callback unwind and preparation | 79dcc10eb1806d481600d2c7ccd9141b60d7376b | CI38000551924 passes focused ownership/tracing/lint/docs; source/tests/scripts/production workflows match published4c7d5ba; prior3389a973 CI37995710137 passed on78ed19f |
| Row28 runtime application and preparation | 44f4297f270fd57ab34a20734e4635c65c6d40b2 | CI38000484752 passes ownership/tracing/lint/docs; source/tests/scripts/production workflows match published3e7ab59; prior2234160 CI37994225608 passed on7cfbe03 |
| Row27 compiler call liveness | 550cd9bd7f3431bf6e25a7db35917c8ab2119444 | CI37962382433 passes focused Linux and all-doc/tag checks; productionc4eb75e, actual basebb77c07 |
| Row26 compiler reuse tokens | 25fc86811242133c05c247b7ec766b55327b21d2 | CI37992999275 passes; source matches published0a7203f; shared immutable auditor |
| Resource frames / stack binder | bf05481ac5c6e60c4e05872a241a2ff436cb457f | CI37798736754 all six pass |

Evidence workflows never enter production ancestry. Every sequential PR still
requires all six gates at its own current head. Preserve row85's repaired typed
whole-stack binder and nominal File disposal; row86's actual base97dca76 already
contains that repair. Failed and superseded logs remain in history.

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

The fun-refactor guard applies to the other repository. The shared target is
last belonged to /private/tmp/fwp-runtime-call-worktree after the final
squash-base rebase and bounded rebuild. Four focused integration targets pass
14 tests33.34CPU/67.02elapsed; all13 IR controls3.29/6.83s, focused lint2.34/4.66s
and format0.34/0.61s pass. Commands: cargo test --test runtime_call_ownership
--test argument_preparation_ownership --test compiler_call_liveness --test unwind_cleanup;
cargo test --lib rc::tests; cargo clippy for those four targets -- -D warnings;
cargo fmt --all -- --check, all through the absolute-root guard with OpenSSL.
It subsequently belonged to /private/tmp/fwp-record-conversion-worktree after bounded
clean of source52(0.00CPU/0.14elapsed) and rebuild for the matched-result repair.
The runtime28 clean before source52 reproduction passed0.07/0.38s.
Current target belongs to /private/tmp/fwp-resource-frame-variants-worktree after
bounded source43 clean0.07/0.38s and rebuild for the frame-holder repair.
Prior compiler/loop target switches, failures and measurements are archived in
[history](roadmap-history.md). Never assume a shared native binary belongs to a
checkout until its bounded package clean and rebuild finish.

The complete argument repair and later loop/control refresh preserve original
allocation and alias assertions. Temporary helpers and their journals live in
/private/tmp; the table, actual bases and retained remote tags are the durable
recovery record. Completed journals must not be rerun blindly. Full-size raw
tail evidence stays on GitHub because it exceeds local RSS limits.

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
to links, refs or commit subjects. Merged row26 is archived and removed from
the live preparation table; its queue anchor and accepted source head stay fixed.

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
