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

Main is `2ef5510154cd52f9f4e94a4a5a2778a20e43ec01` (#105).
All six production jobs CI37997170222 and roadmap_docs CI37997170102 pass
at accepted head `9a21fd6cc844c0960cedd283fd09ab354ee32338`. Explicit
match-head squash at 2026-10-09T22:55:27Z has the entire one-line message:
`Protect compiler reuse tokens through transfer and unwind` (57 characters).
Its complete tree `7213b49ea3b8b983c5f8dbc6f2ad9c75504106c9` matches the
accepted PR head. Raw message has no body/trailers/attribution. Initial manual
verification wrongly required a terminal newline; GitHub stores this subject
without one. Correct byte-for-byte subject verification passes.
Duplicate post-merge main CI38001796693 is cancelled only after all accepted
gates and tree parity. Main roadmap_docs38001796557 also passes.
All 11 current docs were backed up and hashed in /private/tmp/fwp-main-docs-pre105
and restored byte-for-byte after main FF. Refresh the backup before the next FF.

#74–#105 deliver native macOS and selected typed ownership, old-storage
reclamation, task result/deadline boundaries, registered runtime unwind cleanup,
the bounded guard repair and compiler reuse-token transfer/unwind cleanup.
Phase1 is done; phase2 remains incomplete; phases3–6 are pending. Tracing remains
the fallback. Prior acceptance details and failed/superseded runs are in history.
[PR106](https://github.com/e6qu/fun-with-pipes/pull/106) is the only open
production PR, exact head9c1b5a861b156a48d9e4e55b96c336fc6e852e18 on actual
main1052ef5510154cd52f9f4e94a4a5a2778a20e43ec01. Fresh full CI38002299110
and roadmap_docs38002299186 are queued/running. Freeze this head; update root
status without rewriting the PR just to embed run IDs. Require all seven
exact-head passing checks, then squash with the subject
`Protect live compiler owners across calls and cancellation` and empty body.

Final rebase from actual9a21fd6 gives source3e82eca on accepted squash2ef5510;
the final docs commit gives9c1b5a8. Compiler/runtime/tests/scripts/production
workflows match prior2a2458b exactly. Twelve focused integration tests pass
30.59CPU/61.49elapsed; eleven ownership-IR tests3.27/6.84s, lint2.39/4.79s,
format0.34/0.60s and final strong44/106/86 audit0.41/3.44s pass. All11 live docs
are copied into the PR. Retained roadmap/revision-027-2a2458b93d6c before
exact leased publication. Earlier preparation evidence stays in history.
Next: prepare row28 runtime-call cleanup from its recorded actual base2a2458b
onto currentPR1069c1b5a8; after106 merges, final-rebase from that actual new
base9c1b5a8 onto its squash. Keep later work separate and open28's PR only then.

The merged million-step native tail regression passes O1/O2 with GCoff/on
against a200-step FWP_NO_OPT=1 oracle. Full-size raw100000 local execution
exceeds1GiB and was stopped; keep it on GitHub. Release-runner evidence81362c7
CI37997969782 passes the same full-size raw program/output, using1893164KiB
peak RSS; the debug runner overflows its existing4GiB stack. Neither proves
constant raw interpreter stack or a speedup. Exact metadata and logs are in
history. Never raise local or stack limits to repeat those probes.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 27 ownership-call-liveness | 9c1b5a861b15 | 2ef5510154cd | PR106; twelve tests30.59/61.49s plus eleven IR tests3.27/6.84s; lint/format/audit pass; exact-head full CI follows |
| 28 ownership-runtime-call-cleanup | fbb3bc84847b | 9c1b5a861b15 | Source unchanged; ten tests27.43/55.06s, lint2.37/4.77s, format0.34/0.63s and strong audit pass; final sequential gates follow |
| 29 ownership-map-unwind | 4147e018d2e0 | fbb3bc84847b | Seven tests24.26/48.82s; lint2.51/5.05s, format0.44/0.61s and strong audit pass; final sequential gates follow |
| 30 ownership-selection-unwind | c17d4a693b32 | 4c7d5ba45082 | Seven tests24.42/48.98s; lint2.24/4.54s, format0.36/0.76s and strong audit pass; final sequential gates follow |
| 31 ownership-zip-unwind | 5d411a886b73 | c17d4a693b32 | Seven tests24.32/48.75s; lint2.35/4.66s, format0.36/0.75s and strong audit pass; final sequential gates follow |
| 32 ownership-fold-unwind | a8e662267bbc | 5d411a886b73 | Eight tests22.49/45.05s; lint2.37/4.77s, format0.34/0.62s and strong audit pass; final sequential gates follow |
| 33 ownership-loop-unwind | c37df3b0520c | a8e662267bbc | Five tests18.85/37.91s; lint2.24/4.52s, format0.35/0.63s and strong audit pass; final sequential gates follow |
| 34 ownership-argument-preparation | 819fd83c48e2 | c37df3b0520c | Source/tests/scripts/workflows identical to33; docs only; audit0.44/3.50s passes; skip duplicate PR after28 full acceptance |
| 35 ownership-constructor-unwind | 26375deb676e | 819fd83c48e2 | Six tests22.36/45.17s; exact unit3.39/7.02s; lint2.28/4.73s, format0.35/0.74s and strong audit pass |
| 36 ownership-worker-boxing | 928c619289bd | 26375deb676e | Three tests15.44/31.12s; lint2.40/4.94s, format0.35/0.62s and strong audit pass; final sequential gates follow |
| 37 ownership-worker-preparation | 3bd34dafb62f | 6032ecffcb7d | Test9.50/19.16s; lint2.65/5.23s and format0.34/0.60s pass |
| 38 ownership-loop-preparation | 032a764c1d33 | 3bd34dafb62f | Test9.88/19.92s; lint2.40/4.81s and format0.34/0.71s pass |
| 39 ownership-variant-preparation | 5a72ba8763e4 | 032a764c1d33 | Native10.28/20.75s; unit3.40/7.06s; lint/format pass |
| 40 ownership-constructor-types | dd6c405c77eb | 5a72ba8763e4 | Native10.03/20.20s; two units; lint2.42/4.95s and format0.43/0.59s pass |
| 41 ownership-variant-conversion | 67e37717ecf2 | dd6c405c77eb | Native10.20/20.63s; unit3.37/7.04s; lint2.29/4.47s and format0.33/0.59s pass |
| 42 ownership-record-update | 4ea62b69a2c4 | 67e37717ecf2 | Two updates15.01/30.20s; unit3.22/6.67s; lint2.28/4.57s and format0.34/0.60s pass |
| 43 ownership-record-conversion | ffbbcf9d5119 | 4ea62b69a2c4 | Native10.68/21.43s; lint2.26/4.47s and format0.34/0.72s pass |
| 44 ownership-variant-alias | b31400d03ac7 | ffbbcf9d5119 | Two tests8.67/17.52s; lint2.32/4.66s and format0.35/0.73s pass |
| 45 ownership-match-context | 0b00524a0a03 | b31400d03ac7 | Two tests8.71/18.12s; lint2.55/5.06s and format0.44/0.84s pass |
| 46 ownership-field-context | f2262f94ada4 | 0b00524a0a03 | Two tests9.08/18.73s; lint2.42/4.93s and format0.43/0.83s pass |
| 47 ownership-caf-cache | fcfa8fb2d296 | f2262f94ada4 | Three tests11.54/24.96s; lint2.38/4.80s and format0.44/0.83s pass |
| 48 ownership-inline-caf | ece7166b7a79 | fcfa8fb2d296 | Two tests12.68/26.01s; lint2.47/4.90s and format0.35/0.73s pass |
| 49 ownership-task-thunks | ec9a4133a2c1 | ece7166b7a79 | Two tests10.19/20.78s; lint2.33/4.82s and format0.35/0.73s pass |
| 50 ownership-task-within | 1b5fb056fa00 | ec9a4133a2c1 | Test8.95/18.26s; inventory unit3.33/6.98s; lint2.43/4.79s and format0.35/0.73s pass |
| 51 ownership-task-scope | 245a0a24370e | 1b5fb056fa00 | Test9.76/20.17s; lint2.45/4.85s and format0.34/0.62s pass |
| 52 ownership-task-handles | fe8ed51eb078 | 245a0a24370e | Test11.24/23.29s; lint2.34/4.73s and format0.44/0.74s pass |
| 53 ownership-channel-queues | a30c1829d0d0 | fe8ed51eb078 | Test11.45/23.08s; inventory3.40/7.25s; lint2.43/4.79s and format0.45/0.87s pass |
| 54 ownership-library-results | f4d3784f4657 | a30c1829d0d0 | Test7.86/17.88s; lint2.44/4.85s and format0.34/0.61s pass |
| 55 ownership-library-inputs | 625ac7793f84 | f4d3784f4657 | Two tests8.27/18.38s; lint2.34/4.68s and format0.34/0.61s pass |
| 56 ownership-library-unload | ac6de597fddc | 625ac7793f84 | Test8.98/21.43s; lint2.42/4.81s and format0.45/0.74s pass |
| 57 ownership-opencl-lifetime | 4ae80b641da1 | ac6de597fddc | Fake API test7.78/22.85s; lint2.36/4.71s and format0.45/0.75s pass |
| 58 ownership-interpreter-opencl | a5ebb52578e3 | 4ae80b641da1 | Fake API interpreter/native11.27/27.44s; lint2.32/4.69s and format0.34/0.62s pass |
| 59 ownership-tls-listeners | 99b769bff921 | a5ebb52578e3 | Test8.61/19.51s; lint2.46/5.00s and format0.35/0.75s pass |
| 60 ownership-library-resources | ac17bf61276c | 99b769bff921 | Test8.04/18.34s; lint2.48/4.99s and format0.41/0.86s pass |
| 61 ownership-grpc-server-cleanup | 044ceae9f0c5 | ac17bf61276c | Test9.94/19.99s; lint2.46/4.95s and format0.44/0.86s pass |
| 62 ownership-tls-cache-failures | c61df653dfb2 | 044ceae9f0c5 | Test7.17/16.27s; lint2.43/4.95s and format0.40/0.73s pass |
| 63 ownership-tls-wire-preparation | d0e29ddbf182 | c61df653dfb2 | Test7.54/16.19s; lint2.45/4.96s and format0.45/0.86s pass |
| 64 ownership-connect-cancellation | 446d60c378dc | d0e29ddbf182 | Test7.77/17.05s; lint2.31/4.60s and format0.44/0.60s pass |
| 65 ownership-unboxed-worker-locals | 46f7f4b17226 | 446d60c378dc | Two tests8.07/16.86s; lint2.36/4.73s and format0.35/0.62s pass |
| 66 ownership-tls-peer-subject | ec16c6630686 | 46f7f4b17226 | Test7.47/16.47s; lint2.33/4.59s and format0.44/0.84s pass |
| 67 ownership-tls-alpn-roots | bbde0fa9c254 | ec16c6630686 | Test6.99/14.97s; lint5.72/11.65s and format0.44/0.84s pass |
| 68 ownership-ci-probe-repairs | 933deb78f600 | bbde0fa9c254 | Timer test10.28/21.81s; lint5.61/11.71s and format0.46/0.87s pass |
| 69 ownership-nested-loop-boxing | 7047b100dbbe | 933deb78f600 | Three tests14.44/29.19s; lint5.60/11.68s and format0.35/0.63s pass |
| 70 ownership-file-construction | 41a76ee080e5 | 7047b100dbbe | Test7.49/16.08s; lint5.42/11.61s and format0.36/0.76s pass |
| 71 ownership-file-write-visibility | 6fdf20ca82a9 | 41a76ee080e5 | Two tests8.14/17.09s; lint5.55/11.78s and format0.35/0.75s pass |
| 72 ownership-file-io-errors | 82e51ba8ea16 | 6fdf20ca82a9 | Three tests14.85/30.79s; lint5.53/11.82s and format0.35/0.62s pass |
| 73 ownership-resource-frames | 3dc1c36adbad | 82e51ba8ea16 | Three integrations12.65/25.47s; three units3.81/7.73s; lint6.13/12.55s and format0.44/0.84s pass |
| 74 ownership-file-runtime-owners | 4155bc9fce74 | 3dc1c36adbad | Test8.17/18.29s; lint5.82/12.43s and format0.43/0.83s pass |
| 75 ownership-file-discard | 5179067d6635 | 4155bc9fce74 | Test13.04/26.17s; lint5.83/12.17s and format0.44/0.83s pass |
| 76 ownership-file-runtime-boundaries | da4acc398637 | 5179067d6635 | Test18.99/38.40s; lint5.98/12.65s and format0.46/0.84s pass |
| 77 ownership-wasm-resource-counts | 295b0da5c1f0 | da4acc398637 | Actual WASI gates remain required; native bump checks are not WASI proof |
| 78 ownership-wasm-count-disposal | 1a5f5ba98a32 | 295b0da5c1f0 | Actual WASI gates required; source unchanged except inherited harness repairs |
| 79 ownership-resource-frame-fields | 76374abb1077 | 1a5f5ba98a32 | Test10.09/21.47s; lint6.10/13.03s and format0.55/1.08s pass |
| 80 ownership-file-inline-path | 8454a97667bb | 76374abb1077 | Two tests10.54/21.29s; lint6.87/13.94s and format0.54/1.07s pass |
| 81 ownership-file-storage-disposal | d39b6145cb55 | 8454a97667bb | Test8.53/19.18s; lint6.72/13.84s and format0.45/0.84s pass |
| 82 ownership-file-construction-disposal | 47abf911f844 | d39b6145cb55 | Test8.16/18.70s; lint6.09/12.99s and format0.44/0.83s pass |
| 83 ownership-resource-frame-variants | 6d3fcd7444ad | 47abf911f844 | Test10.02/22.30s; lint6.31/13.11s and format0.44/0.83s pass |
| 84 ownership-resource-frame-binding-kinds | 2f67969e9985 | 6d3fcd7444ad | Test10.45/23.67s; lint6.18/12.88s and format0.45/0.83s pass |
| 85 ownership-match-scrutinee-types | c0263af654c4 | 2f67969e9985 | Two tests12.49/27.27s; lint6.11/13.31s and format0.44/0.83s pass |
| 86 ownership-resource-record-binding-kinds | d0e41c87e547 | c0263af654c4 | Test10.49/22.84s; lint6.03/12.91s and format0.41/0.86s pass |
| 87 ownership-nominal-source-context | b83d77ce5da8 | d0e41c87e547 | Raw source/native test13.09/26.43s; lint6.14/13.07s and format0.45/0.86s pass |
| 88 ownership-channel-cycle-lifetimes | e15c6fc1f0c3 | b83d77ce5da8 | Two cycle/queue tests13.30/26.87s; lint5.94/13.04s and format0.46/0.87s pass |
| 89 ownership-http2-body-roots | 59c59a882d67 | e15c6fc1f0c3 | GCC stale-root fixture passes normal Linux37990203134 and ARM15.46/31.62s; later propagation follows |
| 90 fix-http2-body-bounds | fb5765a9ec36 | 59c59a882d67 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 91 ownership-http2-peer-cleanup | 05f1a8841609 | fb5765a9ec36 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 92 ownership-grpc-peer-completion | 84b6d877fa9b | 05f1a8841609 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 93 ownership-grpc-status-cleanup | a36f5538df30 | 84b6d877fa9b | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 94 ownership-grpc-receive-cleanup | 01de4770d750 | a36f5538df30 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 95 ownership-grpc-force-cleanup | 6a4ceee25582 | 01de4770d750 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 96 ownership-grpc-render-cleanup | 05d8c33dc305 | 6a4ceee25582 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 97 ownership-grpc-send-cleanup | 9330eab6253e | 05d8c33dc305 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 98 ownership-grpc-request-encoding | 6e2236f73519 | 9330eab6253e | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 99 ownership-grpc-canonical-encoding | b0d7d1b7d2a9 | 6e2236f73519 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 100 ownership-grpc-response-encoding | e6ae6c83dc46 | b0d7d1b7d2a9 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 101 ownership-grpc-client-requests | b1c6a68771c7 | e6ae6c83dc46 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 102 ownership-grpc-client-failure-text | 5f4c3b2423ac | b1c6a68771c7 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 103 ownership-grpc-client-receive | e25cebbd8ac3 | 5f4c3b2423ac | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 104 ownership-grpc-connect-cleanup | 9f6e7092f00c | e25cebbd8ac3 | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
| 105 ownership-grpc-connect-startup | a8ed839d69f5 | 9f6e7092f00c | Verified fixture repairs inherited; compiler/runtime unchanged; sequential exact-head gates remain required |
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

| Scope | Exact evidence head | Run / status |
|---|---|---|
| Rows107–112 storage and repaired root controls | e5bbfd84736f35f79d631b48373fb8b328251b5f | CI37992657684 passes; source matches current row112215d7ba |
| Row110 environment cache | 46aacfbb3f6bd5d0058aa0b6f60b2d030ff63944 | CI37948869170 passes focused Linux checks |
| Row111 packed TLS options | 823af3475560ed7709f958478580e364d89bdddf | CI37950759037 passes focused Linux checks |
| Row112 full connection addresses | 4dbd0dcedfc297f8f0859aca22142a55cc0dd79d | CI37958243461 passes after formatting repair7621175 |
| TLS/listener combined | 9bcae30119028b1870efb8fecfcf9746f5808acb | CI37730777345 all six pass |
| WASM/resource combined | 5fd2ed65385a23f3226b2bef02eb10196f51aeb4 | CI37771769436 all six pass, including required actual WASI |
| Rows101–106 gRPC client/connect/context | e4a5c1cab0b01d5b6dd9f7bc7a1859185a7f69e0 | CI37989574765 passes after fixture identity repair; runtime unchanged |
| Rows92–100 gRPC serving and encoding | 3aca5cf20d779fa1e9abbfd89e0588032940fb91 | CI37993159029 passes; source matches current row100e6ae6c8, inherited HTTP2 control repaired |
| Rows89–91 HTTP2 roots/bounds/peer cleanup | 8e79458951a8b148e3a3c6a1df488e7f09470fba | CI37990203134 passes normal Linux checks; ARM focused checks pass |
| Rows79–88 typed holders and explicit cycles | 3f0c430477bf261a54cbffb3c39a17826e7677f5 | CI37982696642 passes focused Linux ownership, cycles, tracing, lint and docs |
| Rows77–78 actual WASI counts/disposal | dc731c19e001bdee07c71d866d707d681682b394 | CI37980359907 passes required actual WASI and related Linux/tracing/docs; source1a5f5ba, actual base295b0da |
| Rows69–76 File and original resource frames | 4a448ea21e5ca197b8e7efed1796a8578d7e0761 | CI37980022336 passes focused Linux File/frame/ownership/tracing and docs; sourceda4acc3, actual base5179067 |
| Rows63–68 TLS roots, worker locals and timers | b9a6d7f46801d6c4c54b2fd612f2cd03f35bb61a | CI37978789380 passes focused Linux ownership/tracing and docs; source933deb7, actual basebbde0fa |
| Rows57–62 external resource lifetimes | cd3a9d666bb21d6a682e541ae985e9f10de2e096 | CI37976525768 passes focused Linux lifetimes/tracing and docs; productionc61df65, actual base044ceae |
| Rows53–56 channel/library runtime | 3d80e4fa8e2bd3c7927abe36013187db381378f0 | CI37974795204 passes Linux ownership/tracing and docs; productionac6de59, actual base625ac77 |
| Rows47–52 cache and task runtime | 7dfe64894b1dc1107859a5cde550850fdb672973 | CI37973911726 passes focused Linux ownership/tracing and docs; productionfe8ed51, actual base245a0a2 |
| Rows42–46 records and type contexts | 20b948f8eac1c13b059e64b74d6c9a786c2fed9a | CI37972496949 passes Linux ownership/tracing and docs; productionf2262f9, actual base0b00524 |
| Rows38–41 loop/retain/typed conversion | 3a9fcb512a37a745e65629b29b15e1d06ec0a992 | CI37971602336 passes Linux ownership/tracing and docs; production67e3771, actual basedd6c405 |
| Rows35–37 constructor/worker cleanup | c7e26bb43b6b7edd0c93afbbc25bc7c8e8eaf16f | CI37970487617 passes constructor/worker cleanup, tracing and docs; production3bd34da, actual base6032ecf |
| Rows26–34 callback/loop/argument cleanup | d9017e310a326a885dd65ccb82b810f0d7eb7564 | CI38001360466 passes combined ownership/tracing/lint/docs; source/tests/scripts/production workflows exactly match current33c37df3b; prior1ac6dc9 CI37969742246 passed on9f56744 |
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

## Current guard repair

Row105 lint stopped when rustc removed temporary rmetaJAcTae during target du.
This is incomplete verification, not a resource-limit waiver. No workload remains.
Separate branch fix-local-guard-sampling in /private/tmp/fwp-guard-sampling-worktree
has final sourced4c832188d3563e85410adeb8763bf6a74f4833b on actual
main3bb34267997479794aeac9fff3447da94c16ca4d, with scripts/workflow identical
to focused-accepted063f4ca. Pause the guarded workload during target sampling; keep
RSS, disk, target, CPU and deadline limits unchanged and fail on sampling errors.
All three deterministic integration checks pass under the original root guard:
Initial CPU0.17/elapsed1.24s; final-rebase repeat passes0.20CPU/1.36elapsed. They verify suspension/resumption, sampler errors and the
unchanged target-size limit. Negative control against the original guard fails
all three with workload-not-suspended (CPU0.20/elapsed0.87s), as expected.
The initial test fixture escaping failure was corrected before this acceptance.
The roadmap_docs workflow runs these checks on Linux too. PR103 is merged;
PR104 is merged after all six exact-head gates and roadmap_docs pass.
Post-merge root guard integration repeat passes0.18CPU/1.36elapsed.
Linux guard evidence9eece7440f19a71586ac1a5630816a5054c0dca6, CI37986986407,
passes all three integration checks (0.688s) and the documentation audit.

## Active evidence repairs

HTTP2 CI37983077375 and serving CI37984431678 fail only the inherited
body-owner omission control on GCC. GCC assembly in diagnostic37988293141
shows omitted call/stream roots retained in callee-saved registers. Construction
isolation alone fails. Register-clobber evidenceeec7ef8 passes Linux37989065155,
but its ARM macOS omission control fails (7.71CPU/15.94elapsed); forcing both
hooks inline also fails locally0.76CPU/2.33elapsed. These are rejected fixture
approaches and stay out of production.

Independent Clang fallback5ca597d also fails on Linux37989581687 and is
rejected. Normal HTTP2 evidence8e79458951a8b148e3a3c6a1df488e7f09470fba,
CI37990203134, passes normal Linux lint/format, body roots/limits/peer cleanup,
related resources, actual tracing churn and docs. It scopes the stale-register
control to GCC x86-64 and keeps the original probe on other compilers. ARM
focused checks pass15.46CPU/31.62elapsed after guarded clean. All positive
and strict omission assertions remain; no diagnostics or extra compiler
dependency remains. Fixture repair is published in row8959c59a882d67d1f8ea191a1cf576c395e3a22522,
unchanged actual basee15c6fc. Revision089-f45a7dbbd33d retains the prior head.
Serial guarded propagation through90–112 completed3.50CPU/98.11elapsed.
All current heads and actual bases are in the table; prior heads are retained
under immutable revision tags. Compiler/runtime/workflows are unchanged.

Client CI37985348012 fails its typed handler check. Static handler alone fails
37987135273. Diagnostic37987861321 shows correct code14 and transport-failure
text, but descriptor identity mismatch. Static fixture descriptorsf1318ed pass
Linux37988968135. Normal evidencee4a5c1cab0b01d5b6dd9f7bc7a1859185a7f69e0,
CI37989574765, passes normal format/lint, exact trap/typed error/omission checks,
related ownership/context/startup tests, actual tracing churn and docs. ARM
focused checks pass8.63CPU/17.84elapsed under the original root guard.
Validated static fixture objects are published in row102488801a9f2f74734b60e9516edd8ca92a32edf1d,
with unchanged actual basec6b5ad8. Revision102-222e199ca735 retains the prior head.
Current row102 is5f4c3b2423ac after propagation; the table is authoritative.
All90–112 inherit the accepted fixtures, preserving original OLD anchors.

Rows109–112 are published with actual refreshed predecessor bases in the table.
Combined storage evidencefb9e59fef93ead188c8b8f82ce7147290a9b5e6e,
CI37988444009, passes scoped TLS/captures/full pool identities/environment
teardown/packed options/full-address checks, interpreter identity, lint/format,
actual tracing churn and the documentation audit. Compiler/runtime/tests match
row11293783d4 exactly. Earlier37988054909 lacked the main auditor and failed
before tests; superseded37987994602 is cancelled. Neither is acceptance.
Validated HTTP2/client fixture repairs are propagated through rows90–112,
preserving every immutable OLD anchor. Refreshed evidencee5bbfd8 passes
CI37992657684 against current215d7ba, including both accepted root controls.
Fresh serving evidence3aca5cf passes CI37993159029; source matches current
row100e6ae6c8 and only its inherited HTTP2 fixture differs from old accepted
production source. Reuse evidence25fc868 passes CI37992999275 against
current0a7203f. Old evidence heads are retained remotely under roadmap/evidence-*
tags before leased publication. Each eventual production
PR requires its own final rebase and six exact-head gates plus roadmap_docs.

## Local limits and durable docs

Full builds/tests, benchmarks and large regeneration run on GitHub. Focused
local work is serial and low priority: sampled aggregate RSS below 1 GiB,
target below 2 GiB, free disk at least 64 GiB, deadline 180 seconds. Stop at
limits and move work to CI; never raise or bypass them. Use:

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

The fun-refactor guard is for the other repository. Shared target now belongs
to /private/tmp/fwp-call-liveness-worktree after absolute-root guarded package
clean0.07CPU/0.38elapsed. Twelve final call/token/unwind tests pass30.59CPU/
61.49elapsed. Eleven focused ownership-IR module tests pass3.27CPU/6.84elapsed.
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
