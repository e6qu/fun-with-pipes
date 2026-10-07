# Prepared roadmap queue

Updated 2026-10-10. Rows through25 are merged. Queue26 is next after merged
local guard sampling repair #104.
Current merge status, actual rewritten bases and checks live only in
[the handoff](development-state.md). This table preserves preparation ancestry;
a published preparation is not verified main support.

Open one PR at a time after the previous PR passes all six exact-head gates
and squash-merges. Rebase with `git rebase --onto NEW_MAIN ACTUAL_BASE BRANCH`.
Immutable OLD heads are retained remotely by lightweight tags
`roadmap/preparation-007` through `roadmap/preparation-112`. Their ancestor
parents remain reachable through those tags. On a clean clone, fetch tags
before ancestry verification. Never move these tags or rewrite OLD anchors.
Before force-rewriting a published current head used by a handoff snapshot,
retain it under `roadmap/revision-NNN-SHA12`; those tags are immutable too.
This keeps earlier evidence snapshots verifiable after later branch rewrites.

Use the current actual base from the handoff; immutable OLD parents describe
original preparation and can differ after rewrites. Never replace OLD anchors.
Resolve documentation conflicts with all ten current root docs plus additional
modified tracked documents, including current docs/numerics.md. Rerun focused
checks and publish with an explicit lease against the actual remote current head.
Every final PR needs new six-job exact-head CI. Prior evidence and superseded
queue instructions are preserved in [history](roadmap-history.md).

Ancestry checks use OLD parent → OLD head. Prefixes uniquely resolve here;
resolve full hashes before publication or merge. Checkout paths use
`/private/tmp/fwp-NAME-worktree`; consult the handoff for exceptions.

Row34's argument/capture preparation repair and regression probe are now moved
into row28 to protect callback entry earlier. Current34 is documentation-only
relative to refreshed33. After28 passes its full acceptance, skip the duplicate
implementation PR at34; keep its immutable anchor and later regression coverage.

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
| 21 | array-element | `ownership-array-elements` | `dc85b679407a` | `636414fabf18` | `fad9b1ad08f6` |
| 22 | map-set | `ownership-map-set-elements` | `b5d658aa1a06` | `a8a7d119712b` | `636414fabf18` |
| 23 | old-reclamation | `ownership-old-reclamation` | `6fddf4f0b073` | `6774aa5bb426` | `a8a7d119712b` |
| 24 | task-boundary | `ownership-task-boundaries` | `51cf1c698788` | `02beec353ec7` | `6774aa5bb426` |
| 25 | unwind-runtime | `ownership-unwind-runtime` | `1537961db5da` | `3e314222ff7c` | `02beec353ec7` |
| 26 | unwind-liveness | `ownership-reuse-tokens` | `9a21fd6cc844` | `33cf86466e2f` | `3e314222ff7c` |
| 27 | call-liveness | `ownership-call-liveness` | `9c1b5a861b15` | `7392f2d67151` | `33cf86466e2f` |
| 28 | runtime-call | `ownership-runtime-call-cleanup` | `fbb3bc84847b` | `bee3f1659ae5` | `7392f2d67151` |
| 29 | map-unwind | `ownership-map-unwind` | `4147e018d2e0` | `62add7e4a85f` | `bee3f1659ae5` |
| 30 | selection-unwind | `ownership-selection-unwind` | `c0afce27ff2e` | `b8f4c2469215` | `62add7e4a85f` |
| 31 | zip-unwind | `ownership-zip-unwind` | `eadec76e75e7` | `c2a364544d92` | `b8f4c2469215` |
| 32 | fold-unwind | `ownership-fold-unwind` | `1523161a7314` | `968dac7ed9cf` | `c2a364544d92` |
| 33 | loop-unwind | `ownership-loop-unwind` | `ce5a51c330f3` | `988f2a3be97f` | `968dac7ed9cf` |
| 34 | argument-preparation | `ownership-argument-preparation` | `dcf18f01c2fb` | `49739182ecb6` | `988f2a3be97f` |
| 35 | constructor-unwind | `ownership-constructor-unwind` | `432a3332c4f7` | `608ae7bb2d24` | `49739182ecb6` |
| 36 | worker-boxing | `ownership-worker-boxing` | `0584ab3ac77b` | `dc4f9461571b` | `608ae7bb2d24` |
| 37 | worker-preparation | `ownership-worker-preparation` | `7de346c56ec4` | `c97dd03f8d89` | `dc4f9461571b` |
| 38 | loop-preparation | `ownership-loop-preparation` | `61c5f8e91cc5` | `b879eca20812` | `c97dd03f8d89` |
| 39 | variant-preparation | `ownership-variant-preparation` | `a5ac41b405dd` | `1bb11bece9ae` | `b879eca20812` |
| 40 | constructor-types | `ownership-constructor-types` | `5376d4a1f4ed` | `b0219671dca3` | `1bb11bece9ae` |
| 41 | variant-conversion | `ownership-variant-conversion` | `9033d9f1072e` | `34873f41a4c4` | `b0219671dca3` |
| 42 | record-update | `ownership-record-update` | `00b9d0901485` | `5c5875d30b8e` | `34873f41a4c4` |
| 43 | record-conversion | `ownership-record-conversion` | `3df2c9d86059` | `614dd3b19c13` | `5c5875d30b8e` |
| 44 | variant-alias | `ownership-variant-alias` | `8ebfe6f5d701` | `de8562194d54` | `614dd3b19c13` |
| 45 | typed-expression | `ownership-match-context` | `e73b5b8e7ac7` | `3f61f51521d9` | `de8562194d54` |
| 46 | field-context | `ownership-field-context` | `ae8933d991cb` | `085dc716d599` | `3f61f51521d9` |
| 47 | caf-ownership | `ownership-caf-cache` | `4f75498ad664` | `68cf7bf2f7ca` | `085dc716d599` |
| 48 | inline-caf | `ownership-inline-caf` | `ece7166b7a79` | `6734248e7c0d` | `68cf7bf2f7ca` |
| 49 | retained-thunk | `ownership-task-thunks` | `ec9a4133a2c1` | `7208e4a2d93e` | `6734248e7c0d` |
| 50 | task-within | `ownership-task-within` | `1b5fb056fa00` | `14a76de5b8bb` | `7208e4a2d93e` |
| 51 | task-scope | `ownership-task-scope` | `245a0a24370e` | `7da15d9c8ea3` | `14a76de5b8bb` |
| 52 | task-handle | `ownership-task-handles` | `fe8ed51eb078` | `bb6f9c49a043` | `7da15d9c8ea3` |
| 53 | channel-queue | `ownership-channel-queues` | `a30c1829d0d0` | `ab44b7de0812` | `bb6f9c49a043` |
| 54 | library-result | `ownership-library-results` | `f4d3784f4657` | `5b34382167da` | `ab44b7de0812` |
| 55 | library-input | `ownership-library-inputs` | `625ac7793f84` | `a6ebc1da9637` | `5b34382167da` |
| 56 | library-unload | `ownership-library-unload` | `ac6de597fddc` | `5d0dc220fa1c` | `a6ebc1da9637` |
| 57 | opencl | `ownership-opencl-lifetime` | `4ae80b641da1` | `d8b4d88da98d` | `5d0dc220fa1c` |
| 58 | interpreter-opencl | `ownership-interpreter-opencl` | `a5ebb52578e3` | `abc128581b61` | `d8b4d88da98d` |
| 59 | tls-listener | `ownership-tls-listeners` | `99b769bff921` | `3f6154b4bf67` | `abc128581b61` |
| 60 | library-resource | `ownership-library-resources` | `ac17bf61276c` | `07092cb06e1d` | `3f6154b4bf67` |
| 61 | grpc-server | `ownership-grpc-server-cleanup` | `044ceae9f0c5` | `0d5d3098e782` | `07092cb06e1d` |
| 62 | tls-cache | `ownership-tls-cache-failures` | `c61df653dfb2` | `4ab1f7ddd6f8` | `0d5d3098e782` |
| 63 | tls-wire | `ownership-tls-wire-preparation` | `d0e29ddbf182` | `f6598e440a59` | `4ab1f7ddd6f8` |
| 64 | connect-cleanup | `ownership-connect-cancellation` | `446d60c378dc` | `0cc612650ab9` | `f6598e440a59` |
| 65 | unboxed-worker | `ownership-unboxed-worker-locals` | `46f7f4b17226` | `b8f3752d236f` | `0cc612650ab9` |
| 66 | peer-subject | `ownership-tls-peer-subject` | `ec16c6630686` | `6bda2c815a71` | `b8f3752d236f` |
| 67 | tls-alpn-root | `ownership-tls-alpn-roots` | `bbde0fa9c254` | `e0f11626f609` | `6bda2c815a71` |
| 68 | ci-probe-repairs | `ownership-ci-probe-repairs` | `933deb78f600` | `e503e10a9780` | `e0f11626f609` |
| 69 | nested-loop-boxing | `ownership-nested-loop-boxing` | `7047b100dbbe` | `b00215dc10f5` | `e503e10a9780` |
| 70 | file-construction | `ownership-file-construction` | `41a76ee080e5` | `e9d575fdf990` | `b00215dc10f5` |
| 71 | file-write-visibility | `ownership-file-write-visibility` | `6fdf20ca82a9` | `5ac710398a14` | `e9d575fdf990` |
| 72 | file-io-errors | `ownership-file-io-errors` | `82e51ba8ea16` | `06419f4c5989` | `5ac710398a14` |
| 73 | resource-frames | `ownership-resource-frames` | `3dc1c36adbad` | `dcc5bbac318f` | `06419f4c5989` |
| 74 | file-runtime-owners | `ownership-file-runtime-owners` | `4155bc9fce74` | `e21c92ea2f6c` | `368dafc5567d` |
| 75 | file-discard | `ownership-file-discard` | `5179067d6635` | `923ad4a4fb07` | `e21c92ea2f6c` |
| 76 | file-runtime-boundaries | `ownership-file-runtime-boundaries` | `da4acc398637` | `30fe112db93c` | `923ad4a4fb07` |
| 77 | wasm-resource-counts | `ownership-wasm-resource-counts` | `295b0da5c1f0` | `046f7e85a9eb` | `30fe112db93c` |
| 78 | wasm-count-disposal | `ownership-wasm-count-disposal` | `1a5f5ba98a32` | `681dd55136b0` | `c889479eed7a` |
| 79 | resource-frame-fields | `ownership-resource-frame-fields` | `76374abb1077` | `658e5b73ae1c` | `681dd55136b0` |
| 80 | file-inline-path | `ownership-file-inline-path` | `8454a97667bb` | `2d903d6617d9` | `658e5b73ae1c` |
| 81 | file-storage-disposal | `ownership-file-storage-disposal` | `d39b6145cb55` | `750a5cffd46b` | `2d903d6617d9` |
| 82 | file-construction-disposal | `ownership-file-construction-disposal` | `47abf911f844` | `17869223a502` | `750a5cffd46b` |
| 83 | resource-frame-variants | `ownership-resource-frame-variants` | `6d3fcd7444ad` | `786e4bbb99f1` | `17869223a502` |
| 84 | resource-frame-binding-kinds | `ownership-resource-frame-binding-kinds` | `2f67969e9985` | `ae00e6929e86` | `786e4bbb99f1` |
| 85 | match-scrutinee-types | `ownership-match-scrutinee-types` | `c0263af654c4` | `3a0cbdb33b79` | `ae00e6929e86` |
| 86 | resource-record-binding-kinds | `ownership-resource-record-binding-kinds` | `d0e41c87e547` | `f85cc4e09db4` | `3a0cbdb33b79` |
| 87 | nominal-source-context | `ownership-nominal-source-context` | `b83d77ce5da8` | `8abfd46b3476` | `f85cc4e09db4` |
| 88 | channel-cycle | `ownership-channel-cycle-lifetimes` | `e15c6fc1f0c3` | `dc2ad1febc5d` | `8abfd46b3476` |
| 89 | http2-body-roots | `ownership-http2-body-roots` | `59c59a882d67` | `d29dda936dff` | `e91dcb307c61` |
| 90 | http2-body-bounds | `fix-http2-body-bounds` | `fb5765a9ec36` | `6f310b5483a8` | `d29dda936dff` |
| 91 | http2-peer-cleanup | `ownership-http2-peer-cleanup` | `05f1a8841609` | `3c268c34d15b` | `6f310b5483a8` |
| 92 | grpc-peer-completion | `ownership-grpc-peer-completion` | `84b6d877fa9b` | `09751c8c65ac` | `3c268c34d15b` |
| 93 | grpc-status-cleanup | `ownership-grpc-status-cleanup` | `a36f5538df30` | `a92c951fa6d9` | `09751c8c65ac` |
| 94 | grpc-receive-cleanup | `ownership-grpc-receive-cleanup` | `01de4770d750` | `8bd9e78743ab` | `a92c951fa6d9` |
| 95 | grpc-force-cleanup | `ownership-grpc-force-cleanup` | `6a4ceee25582` | `6b82bc5b8b2f` | `8bd9e78743ab` |
| 96 | grpc-render-cleanup | `ownership-grpc-render-cleanup` | `05d8c33dc305` | `ea79bdee1191` | `6b82bc5b8b2f` |
| 97 | grpc-send-cleanup | `ownership-grpc-send-cleanup` | `9330eab6253e` | `671ada6ec85d` | `ea79bdee1191` |
| 98 | grpc-request-encoding | `ownership-grpc-request-encoding` | `6e2236f73519` | `663ef599a438` | `671ada6ec85d` |
| 99 | grpc-canonical-encoding | `ownership-grpc-canonical-encoding` | `b0d7d1b7d2a9` | `4114b709fb4b` | `663ef599a438` |
| 100 | grpc-response-encoding | `ownership-grpc-response-encoding` | `e6ae6c83dc46` | `b44f53c9a60f` | `4114b709fb4b` |
| 101 | grpc-client-requests | `ownership-grpc-client-requests` | `b1c6a68771c7` | `2339ff08e421` | `b44f53c9a60f` |
| 102 | grpc-client-failure-text | `ownership-grpc-client-failure-text` | `5f4c3b2423ac` | `33661b298f96` | `2339ff08e421` |
| 103 | grpc-client-receive | `ownership-grpc-client-receive` | `e25cebbd8ac3` | `c48864ce7231` | `33661b298f96` |
| 104 | grpc-connect-cleanup | `ownership-grpc-connect-cleanup` | `9f6e7092f00c` | `b244d5f7c423` | `c48864ce7231` |
| 105 | grpc-connect-startup | `ownership-grpc-connect-startup` | `a8ed839d69f5` | `cb20833c018f` | `b244d5f7c423` |
| 106 | grpc-context-restore | `ownership-grpc-context-restore` | `29104d944907` | `7a89dd017ae4` | `cb20833c018f` |
| 107 | grpc-context-resources | `ownership-grpc-context-resources` | `c34c313ccfb0` | `ea18e54f0eee` | `7a89dd017ae4` |
| 108 | grpc-capture-resources | `ownership-grpc-capture-resources` | `8f66e28763b4` | `36ad63424530` | `ea18e54f0eee` |
| 109 | grpc-tls-pool-identity | `fix-grpc-tls-pool-identity` | `cf14552bdba5` | `d178d86dca2b` | `36ad63424530` |
| 110 | grpc-environment-cache | `ownership-grpc-environment-cache` | `393456e6e5ca` | `6f4bfba80ef3` | `d178d86dca2b` |
| 111 | grpc-packed-options | `ownership-grpc-packed-options` | `a4f347499f19` | `2bb665596390` | `6f4bfba80ef3` |
| 112 | grpc-connection-addresses | `ownership-grpc-connection-addresses` | `215d7badbd49` | `edbc5e8d0e62` | `2bd17608388d` |

The record-reconstruction branch `b21203da65d3` was incorporated into record-update
`5c5875d30b8e`; do not open an extra PR for it. The evidence branch is separate:
its workflow commits and equivalent baseline repairs never enter this chain.

