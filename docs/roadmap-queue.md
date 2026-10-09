# Prepared roadmap queue

Updated 2026-10-09. Rows through19 are merged; queue20 is the next delivery.
Current merge status, actual rewritten bases and checks live only in
[the handoff](development-state.md). This table preserves preparation ancestry;
a published preparation is not verified main support.

Open one PR at a time after the previous PR passes all six exact-head gates
and squash-merges. Rebase with `git rebase --onto NEW_MAIN ACTUAL_BASE BRANCH`.
Use the current actual base from the handoff; immutable OLD parents describe
original preparation and can differ after rewrites. Never replace OLD anchors.
Resolve documentation conflicts with all ten current root docs, rerun focused
checks and publish with an explicit lease against the actual remote current head.
Every final PR needs new six-job exact-head CI. Prior evidence and superseded
queue instructions are preserved in [history](roadmap-history.md).

Ancestry checks use OLD parent → OLD head. Prefixes uniquely resolve here;
resolve full hashes before publication or merge. Checkout paths use
`/private/tmp/fwp-NAME-worktree`; consult the handoff for exceptions.

| Order | NAME | Branch | Current head | Immutable OLD head | Immutable OLD parent |
|---|---|---|---|---|---|
| 7 | fold | `ownership-fold-transfers` | `a090f1f5ac6c` | `a180c3fb5f42` | `1ea7f079043c` |
| 8 | zip | `ownership-zip-callbacks` | `cf8ce6e61295` | `bdb750f6d46b` | `a180c3fb5f42` |
| 9 | right-fold | `ownership-right-fold` | `8be65d1ae2ec` | `adc7947a25f2` | `bdb750f6d46b` |
| 10 | prefix | `ownership-list-prefix` | `42cf518f2ec5` | `376e77ae9469` | `adc7947a25f2` |
| 11 | list-copy | `ownership-list-copies` | `bcdfb163c565` | `bb00baa4ab95` | `376e77ae9469` |
| 12 | list-option | `ownership-list-options` | `8e6a891eadfa` | `34023f35a42f` | `bb00baa4ab95` |
| 13 | inference | `inference-call-effects` | `7018086b8f98` | `89b7bde2c8f0` | `34023f35a42f` |
| 14 | wide | `ownership-wide-counts` | `bd7a20bfd833` | `3a791dc7e9f3` | `89b7bde2c8f0` |
| 15 | order | `ownership-list-order` | `d2e0e296888d` | `c83557825d8a` | `3a791dc7e9f3` |
| 16 | sort-callback | `ownership-sort-callbacks` | `9f4e3bbc211c` | `66bc713dea67` | `c83557825d8a` |
| 17 | state-sequence | `ownership-state-sequences` | `5d0a3f302e47` | `0a90b0520cc1` | `66bc713dea67` |
| 18 | loop | `ownership-loop-state` | `03d25acc581a` | `787763d2e4b6` | `0a90b0520cc1` |
| 19 | structure | `ownership-list-structure` | `65fedd8d8543` | `c05a5d9c7d86` | `787763d2e4b6` |
| 20 | generation | `ownership-list-generation` | `de969ee71615` | `fad9b1ad08f6` | `c05a5d9c7d86` |
| 21 | array-element | `ownership-array-elements` | `c8d4b57092e5` | `636414fabf18` | `fad9b1ad08f6` |
| 22 | map-set | `ownership-map-set-elements` | `1689c03ff621` | `a8a7d119712b` | `636414fabf18` |
| 23 | old-reclamation | `ownership-old-reclamation` | `f4716a027a1b` | `6774aa5bb426` | `a8a7d119712b` |
| 24 | task-boundary | `ownership-task-boundaries` | `cde58f461f78` | `02beec353ec7` | `6774aa5bb426` |
| 25 | unwind-runtime | `ownership-unwind-runtime` | `123d8b5928aa` | `3e314222ff7c` | `02beec353ec7` |
| 26 | unwind-liveness | `ownership-reuse-tokens` | `216e673ff2dd` | `33cf86466e2f` | `3e314222ff7c` |
| 27 | call-liveness | `ownership-call-liveness` | `786f1700236e` | `7392f2d67151` | `33cf86466e2f` |
| 28 | runtime-call | `ownership-runtime-call-cleanup` | `e3c49d965cd0` | `bee3f1659ae5` | `7392f2d67151` |
| 29 | map-unwind | `ownership-map-unwind` | `8093bf382210` | `62add7e4a85f` | `bee3f1659ae5` |
| 30 | selection-unwind | `ownership-selection-unwind` | `69b1ad1e33e5` | `b8f4c2469215` | `62add7e4a85f` |
| 31 | zip-unwind | `ownership-zip-unwind` | `6a0913896eb7` | `c2a364544d92` | `b8f4c2469215` |
| 32 | fold-unwind | `ownership-fold-unwind` | `1e8d1e34bc78` | `968dac7ed9cf` | `c2a364544d92` |
| 33 | loop-unwind | `ownership-loop-unwind` | `dc9bfd5e626b` | `988f2a3be97f` | `968dac7ed9cf` |
| 34 | argument-preparation | `ownership-argument-preparation` | `ada6a3a62df1` | `49739182ecb6` | `988f2a3be97f` |
| 35 | constructor-unwind | `ownership-constructor-unwind` | `646cca038ed8` | `608ae7bb2d24` | `49739182ecb6` |
| 36 | worker-boxing | `ownership-worker-boxing` | `df5862861e71` | `dc4f9461571b` | `608ae7bb2d24` |
| 37 | worker-preparation | `ownership-worker-preparation` | `3b6bf091127c` | `c97dd03f8d89` | `dc4f9461571b` |
| 38 | loop-preparation | `ownership-loop-preparation` | `7ae78137d444` | `b879eca20812` | `c97dd03f8d89` |
| 39 | variant-preparation | `ownership-variant-preparation` | `f0049c4aabe0` | `1bb11bece9ae` | `b879eca20812` |
| 40 | constructor-types | `ownership-constructor-types` | `c90fe5a9d170` | `b0219671dca3` | `1bb11bece9ae` |
| 41 | variant-conversion | `ownership-variant-conversion` | `3956d5cadd86` | `34873f41a4c4` | `b0219671dca3` |
| 42 | record-update | `ownership-record-update` | `f22b5b587de6` | `5c5875d30b8e` | `34873f41a4c4` |
| 43 | record-conversion | `ownership-record-conversion` | `e2f944c256b6` | `614dd3b19c13` | `5c5875d30b8e` |
| 44 | variant-alias | `ownership-variant-alias` | `610fd745b973` | `de8562194d54` | `614dd3b19c13` |
| 45 | typed-expression | `ownership-match-context` | `321cc3146089` | `3f61f51521d9` | `de8562194d54` |
| 46 | field-context | `ownership-field-context` | `6d01e927c086` | `085dc716d599` | `3f61f51521d9` |
| 47 | caf-ownership | `ownership-caf-cache` | `762cc824fa08` | `68cf7bf2f7ca` | `085dc716d599` |
| 48 | inline-caf | `ownership-inline-caf` | `af073c78c443` | `6734248e7c0d` | `68cf7bf2f7ca` |
| 49 | retained-thunk | `ownership-task-thunks` | `427076c60d2c` | `7208e4a2d93e` | `6734248e7c0d` |
| 50 | task-within | `ownership-task-within` | `aa181f8f2c3a` | `14a76de5b8bb` | `7208e4a2d93e` |
| 51 | task-scope | `ownership-task-scope` | `28de1794f39f` | `7da15d9c8ea3` | `14a76de5b8bb` |
| 52 | task-handle | `ownership-task-handles` | `4b6a2cb08da5` | `bb6f9c49a043` | `7da15d9c8ea3` |
| 53 | channel-queue | `ownership-channel-queues` | `ccbf2957f351` | `ab44b7de0812` | `bb6f9c49a043` |
| 54 | library-result | `ownership-library-results` | `82f32b2cde03` | `5b34382167da` | `ab44b7de0812` |
| 55 | library-input | `ownership-library-inputs` | `f240ecd56f3b` | `a6ebc1da9637` | `5b34382167da` |
| 56 | library-unload | `ownership-library-unload` | `878b25aad627` | `5d0dc220fa1c` | `a6ebc1da9637` |
| 57 | opencl | `ownership-opencl-lifetime` | `5b6e65f365d6` | `d8b4d88da98d` | `5d0dc220fa1c` |
| 58 | interpreter-opencl | `ownership-interpreter-opencl` | `00013d55d078` | `abc128581b61` | `d8b4d88da98d` |
| 59 | tls-listener | `ownership-tls-listeners` | `838cf5dee220` | `3f6154b4bf67` | `abc128581b61` |
| 60 | library-resource | `ownership-library-resources` | `d56a24e48d7e` | `07092cb06e1d` | `3f6154b4bf67` |
| 61 | grpc-server | `ownership-grpc-server-cleanup` | `c299edbc33eb` | `0d5d3098e782` | `07092cb06e1d` |
| 62 | tls-cache | `ownership-tls-cache-failures` | `0be508308064` | `4ab1f7ddd6f8` | `0d5d3098e782` |
| 63 | tls-wire | `ownership-tls-wire-preparation` | `66e80d399e65` | `f6598e440a59` | `4ab1f7ddd6f8` |
| 64 | connect-cleanup | `ownership-connect-cancellation` | `ae05b2bfc32c` | `0cc612650ab9` | `f6598e440a59` |
| 65 | unboxed-worker | `ownership-unboxed-worker-locals` | `2ba7084abe25` | `b8f3752d236f` | `0cc612650ab9` |
| 66 | peer-subject | `ownership-tls-peer-subject` | `b728cf5f2adb` | `6bda2c815a71` | `b8f3752d236f` |
| 67 | tls-alpn-root | `ownership-tls-alpn-roots` | `22b95b0ddb74` | `e0f11626f609` | `6bda2c815a71` |
| 68 | ci-probe-repairs | `ownership-ci-probe-repairs` | `7d8ab6719e55` | `e503e10a9780` | `e0f11626f609` |
| 69 | nested-loop-boxing | `ownership-nested-loop-boxing` | `821e6c1baaef` | `b00215dc10f5` | `e503e10a9780` |
| 70 | file-construction | `ownership-file-construction` | `0d09a61aaab7` | `e9d575fdf990` | `b00215dc10f5` |
| 71 | file-write-visibility | `ownership-file-write-visibility` | `8a061cb9b8ab` | `5ac710398a14` | `e9d575fdf990` |
| 72 | file-io-errors | `ownership-file-io-errors` | `d4611644084a` | `06419f4c5989` | `5ac710398a14` |
| 73 | resource-frames | `ownership-resource-frames` | `3c87e1f63b51` | `dcc5bbac318f` | `06419f4c5989` |
| 74 | file-runtime-owners | `ownership-file-runtime-owners` | `4b5da4aa946a` | `e21c92ea2f6c` | `368dafc5567d` |
| 75 | file-discard | `ownership-file-discard` | `db3bcf0da8d6` | `923ad4a4fb07` | `e21c92ea2f6c` |
| 76 | file-runtime-boundaries | `ownership-file-runtime-boundaries` | `b4860bf2c392` | `30fe112db93c` | `923ad4a4fb07` |
| 77 | wasm-resource-counts | `ownership-wasm-resource-counts` | `b4482c259c1e` | `046f7e85a9eb` | `30fe112db93c` |
| 78 | wasm-count-disposal | `ownership-wasm-count-disposal` | `9609b73ef5ed` | `681dd55136b0` | `c889479eed7a` |
| 79 | resource-frame-fields | `ownership-resource-frame-fields` | `35c2aeb2923e` | `658e5b73ae1c` | `681dd55136b0` |
| 80 | file-inline-path | `ownership-file-inline-path` | `e7d3882b67ae` | `2d903d6617d9` | `658e5b73ae1c` |
| 81 | file-storage-disposal | `ownership-file-storage-disposal` | `faac017dc60d` | `750a5cffd46b` | `2d903d6617d9` |
| 82 | file-construction-disposal | `ownership-file-construction-disposal` | `06c93eff77af` | `17869223a502` | `750a5cffd46b` |
| 83 | resource-frame-variants | `ownership-resource-frame-variants` | `f3c9ee4ec354` | `786e4bbb99f1` | `17869223a502` |
| 84 | resource-frame-binding-kinds | `ownership-resource-frame-binding-kinds` | `d2936a008fd2` | `ae00e6929e86` | `786e4bbb99f1` |
| 85 | match-scrutinee-types | `ownership-match-scrutinee-types` | `97dca7626158` | `3a0cbdb33b79` | `ae00e6929e86` |
| 86 | resource-record-binding-kinds | `ownership-resource-record-binding-kinds` | `5915ac0607ac` | `f85cc4e09db4` | `3a0cbdb33b79` |
| 87 | nominal-source-context | `ownership-nominal-source-context` | `f08611023cec` | `8abfd46b3476` | `f85cc4e09db4` |
| 88 | channel-cycle | `ownership-channel-cycle-lifetimes` | `e91dcb307c61` | `dc2ad1febc5d` | `8abfd46b3476` |
| 89 | http2-body-roots | `ownership-http2-body-roots` | `d29dda936dff` | `d29dda936dff` | `e91dcb307c61` |
| 90 | http2-body-bounds | `fix-http2-body-bounds` | `6f310b5483a8` | `6f310b5483a8` | `d29dda936dff` |
| 91 | http2-peer-cleanup | `ownership-http2-peer-cleanup` | `3c268c34d15b` | `3c268c34d15b` | `6f310b5483a8` |
| 92 | grpc-peer-completion | `ownership-grpc-peer-completion` | `09751c8c65ac` | `09751c8c65ac` | `3c268c34d15b` |
| 93 | grpc-status-cleanup | `ownership-grpc-status-cleanup` | `a92c951fa6d9` | `a92c951fa6d9` | `09751c8c65ac` |
| 94 | grpc-receive-cleanup | `ownership-grpc-receive-cleanup` | `8bd9e78743ab` | `8bd9e78743ab` | `a92c951fa6d9` |
| 95 | grpc-force-cleanup | `ownership-grpc-force-cleanup` | `6b82bc5b8b2f` | `6b82bc5b8b2f` | `8bd9e78743ab` |
| 96 | grpc-render-cleanup | `ownership-grpc-render-cleanup` | `ea79bdee1191` | `ea79bdee1191` | `6b82bc5b8b2f` |
| 97 | grpc-send-cleanup | `ownership-grpc-send-cleanup` | `671ada6ec85d` | `671ada6ec85d` | `ea79bdee1191` |
| 98 | grpc-request-encoding | `ownership-grpc-request-encoding` | `663ef599a438` | `663ef599a438` | `671ada6ec85d` |
| 99 | grpc-canonical-encoding | `ownership-grpc-canonical-encoding` | `4114b709fb4b` | `4114b709fb4b` | `663ef599a438` |
| 100 | grpc-response-encoding | `ownership-grpc-response-encoding` | `b44f53c9a60f` | `b44f53c9a60f` | `4114b709fb4b` |
| 101 | grpc-client-requests | `ownership-grpc-client-requests` | `2339ff08e421` | `2339ff08e421` | `b44f53c9a60f` |
| 102 | grpc-client-failure-text | `ownership-grpc-client-failure-text` | `33661b298f96` | `33661b298f96` | `2339ff08e421` |
| 103 | grpc-client-receive | `ownership-grpc-client-receive` | `c48864ce7231` | `c48864ce7231` | `33661b298f96` |

The record-reconstruction branch `b21203da65d3` was incorporated into record-update
`5c5875d30b8e`; do not open an extra PR for it. The evidence branch is separate:
its workflow commits and equivalent baseline repairs never enter this chain.

