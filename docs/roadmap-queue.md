# Prepared roadmap queue

Updated 2026-10-10. This file preserves preparation ancestry.
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
Resolve documentation conflicts with all 11 authoritative docs listed in the
handoff, plus other modified tracked documents. Rerun focused
checks and publish with an explicit lease against the actual remote current head.
Every final PR needs all six production jobs and roadmap_docs at its exact head. Prior evidence and superseded
queue instructions are preserved in [history](roadmap-history.md).

Ancestry checks use OLD parent → OLD head. Prefixes uniquely resolve here;
resolve full hashes before publication or merge. Checkout paths use
`/private/tmp/fwp-NAME-worktree`; consult the handoff for exceptions.

Row34's argument/capture preparation repair and regression probe are now moved
into row28 to protect callback entry earlier. Current34 is documentation-only
relative to refreshed33. Row28 passed full acceptance in PR107; skip the duplicate
implementation PR at34 and keep its immutable anchor and later regression coverage.

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
| 27 | call-liveness | `ownership-call-liveness` | `5683df1c8a96` | `7392f2d67151` | `33cf86466e2f` |
| 28 | runtime-call | `ownership-runtime-call-cleanup` | `1dcbe79ac077` | `bee3f1659ae5` | `7392f2d67151` |
| 29 | map-unwind | `ownership-map-unwind` | `3c69084cec04` | `62add7e4a85f` | `bee3f1659ae5` |
| 30 | selection-unwind | `ownership-selection-unwind` | `8371fc50c9bf` | `b8f4c2469215` | `62add7e4a85f` |
| 31 | zip-unwind | `ownership-zip-unwind` | `05d354f57167` | `c2a364544d92` | `b8f4c2469215` |
| 32 | fold-unwind | `ownership-fold-unwind` | `f3585147985d` | `968dac7ed9cf` | `c2a364544d92` |
| 33 | loop-unwind | `ownership-loop-unwind` | `0ec280e18416` | `988f2a3be97f` | `968dac7ed9cf` |
| 34 | argument-preparation | `ownership-argument-preparation` | `49705971b287` | `49739182ecb6` | `988f2a3be97f` |
| 35 | constructor-unwind | `ownership-constructor-unwind` | `bbd74db2977a` | `608ae7bb2d24` | `49739182ecb6` |
| 36 | worker-boxing | `ownership-worker-boxing` | `bcd3b392050b` | `dc4f9461571b` | `608ae7bb2d24` |
| 37 | worker-preparation | `ownership-worker-preparation` | `8c4e9ffd71a5` | `c97dd03f8d89` | `dc4f9461571b` |
| 38 | loop-preparation | `ownership-loop-preparation` | `4289528c436b` | `b879eca20812` | `c97dd03f8d89` |
| 39 | variant-preparation | `ownership-variant-preparation` | `dd8444579ed0` | `1bb11bece9ae` | `b879eca20812` |
| 40 | constructor-types | `ownership-constructor-types` | `cccbe406449f` | `b0219671dca3` | `1bb11bece9ae` |
| 41 | variant-conversion | `ownership-variant-conversion` | `172912b7b1c6` | `34873f41a4c4` | `b0219671dca3` |
| 42 | record-update | `ownership-record-update` | `2b61f8cad333` | `5c5875d30b8e` | `34873f41a4c4` |
| 43 | record-conversion | `ownership-record-conversion` | `8c7450568632` | `614dd3b19c13` | `5c5875d30b8e` |
| 44 | variant-alias | `ownership-variant-alias` | `5e436e6ee6f5` | `de8562194d54` | `614dd3b19c13` |
| 45 | typed-expression | `ownership-match-context` | `44e720054249` | `3f61f51521d9` | `de8562194d54` |
| 46 | field-context | `ownership-field-context` | `3a87da04a671` | `085dc716d599` | `3f61f51521d9` |
| 47 | caf-ownership | `ownership-caf-cache` | `7e507e993e58` | `68cf7bf2f7ca` | `085dc716d599` |
| 48 | inline-caf | `ownership-inline-caf` | `3dd5219cb896` | `6734248e7c0d` | `68cf7bf2f7ca` |
| 49 | retained-thunk | `ownership-task-thunks` | `2c14070a6347` | `7208e4a2d93e` | `6734248e7c0d` |
| 50 | task-within | `ownership-task-within` | `f35dd8c34ea4` | `14a76de5b8bb` | `7208e4a2d93e` |
| 51 | task-scope | `ownership-task-scope` | `bb1e6b94fcfd` | `7da15d9c8ea3` | `14a76de5b8bb` |
| 52 | task-handle | `ownership-task-handles` | `cb32c2cea9bb` | `bb6f9c49a043` | `7da15d9c8ea3` |
| 53 | channel-queue | `ownership-channel-queues` | `69bc96667a52` | `ab44b7de0812` | `bb6f9c49a043` |
| 54 | library-result | `ownership-library-results` | `f53cccc88d45` | `5b34382167da` | `ab44b7de0812` |
| 55 | library-input | `ownership-library-inputs` | `067d547b3bfd` | `a6ebc1da9637` | `5b34382167da` |
| 56 | library-unload | `ownership-library-unload` | `0d30f4e3da51` | `5d0dc220fa1c` | `a6ebc1da9637` |
| 57 | opencl | `ownership-opencl-lifetime` | `9dc98a72cac1` | `d8b4d88da98d` | `5d0dc220fa1c` |
| 58 | interpreter-opencl | `ownership-interpreter-opencl` | `013b07eac021` | `abc128581b61` | `d8b4d88da98d` |
| 59 | tls-listener | `ownership-tls-listeners` | `64fc39f9738e` | `3f6154b4bf67` | `abc128581b61` |
| 60 | library-resource | `ownership-library-resources` | `aa8dfb3a703e` | `07092cb06e1d` | `3f6154b4bf67` |
| 61 | grpc-server | `ownership-grpc-server-cleanup` | `91f9a30742f9` | `0d5d3098e782` | `07092cb06e1d` |
| 62 | tls-cache | `ownership-tls-cache-failures` | `0ba865002ace` | `4ab1f7ddd6f8` | `0d5d3098e782` |
| 63 | tls-wire | `ownership-tls-wire-preparation` | `52bc4e64547b` | `f6598e440a59` | `4ab1f7ddd6f8` |
| 64 | connect-cleanup | `ownership-connect-cancellation` | `d364e70df274` | `0cc612650ab9` | `f6598e440a59` |
| 65 | unboxed-worker | `ownership-unboxed-worker-locals` | `60b03078c3cd` | `b8f3752d236f` | `0cc612650ab9` |
| 66 | peer-subject | `ownership-tls-peer-subject` | `cfe905046796` | `6bda2c815a71` | `b8f3752d236f` |
| 67 | tls-alpn-root | `ownership-tls-alpn-roots` | `f7a0bd2eba93` | `e0f11626f609` | `6bda2c815a71` |
| 68 | ci-probe-repairs | `ownership-ci-probe-repairs` | `351b21daafbb` | `e503e10a9780` | `e0f11626f609` |
| 69 | nested-loop-boxing | `ownership-nested-loop-boxing` | `925724e0994d` | `b00215dc10f5` | `e503e10a9780` |
| 70 | file-construction | `ownership-file-construction` | `823b86c74a68` | `e9d575fdf990` | `b00215dc10f5` |
| 71 | file-write-visibility | `ownership-file-write-visibility` | `de6667643951` | `5ac710398a14` | `e9d575fdf990` |
| 72 | file-io-errors | `ownership-file-io-errors` | `4aeff2223e3f` | `06419f4c5989` | `5ac710398a14` |
| 73 | resource-frames | `ownership-resource-frames` | `c5bc20fc095b` | `dcc5bbac318f` | `06419f4c5989` |
| 74 | file-runtime-owners | `ownership-file-runtime-owners` | `d3fa39b37c83` | `e21c92ea2f6c` | `368dafc5567d` |
| 75 | file-discard | `ownership-file-discard` | `4b8202419941` | `923ad4a4fb07` | `e21c92ea2f6c` |
| 76 | file-runtime-boundaries | `ownership-file-runtime-boundaries` | `b5aee4eb6e95` | `30fe112db93c` | `923ad4a4fb07` |
| 77 | wasm-resource-counts | `ownership-wasm-resource-counts` | `231568d07731` | `046f7e85a9eb` | `30fe112db93c` |
| 78 | wasm-count-disposal | `ownership-wasm-count-disposal` | `c7ba897d8d9c` | `681dd55136b0` | `c889479eed7a` |
| 79 | resource-frame-fields | `ownership-resource-frame-fields` | `8053dc693a13` | `658e5b73ae1c` | `681dd55136b0` |
| 80 | file-inline-path | `ownership-file-inline-path` | `0ea8a1c94115` | `2d903d6617d9` | `658e5b73ae1c` |
| 81 | file-storage-disposal | `ownership-file-storage-disposal` | `2fffa57d369d` | `750a5cffd46b` | `2d903d6617d9` |
| 82 | file-construction-disposal | `ownership-file-construction-disposal` | `c6cbacac0db9` | `17869223a502` | `750a5cffd46b` |
| 83 | resource-frame-variants | `ownership-resource-frame-variants` | `53440f785f65` | `786e4bbb99f1` | `17869223a502` |
| 84 | resource-frame-binding-kinds | `ownership-resource-frame-binding-kinds` | `073a20c8d7ef` | `ae00e6929e86` | `786e4bbb99f1` |
| 85 | match-scrutinee-types | `ownership-match-scrutinee-types` | `1236f09a1d85` | `3a0cbdb33b79` | `ae00e6929e86` |
| 86 | resource-record-binding-kinds | `ownership-resource-record-binding-kinds` | `f5a017db54da` | `f85cc4e09db4` | `3a0cbdb33b79` |
| 87 | nominal-source-context | `ownership-nominal-source-context` | `08beb7c2bc23` | `8abfd46b3476` | `f85cc4e09db4` |
| 88 | channel-cycle | `ownership-channel-cycle-lifetimes` | `b2d374878677` | `dc2ad1febc5d` | `8abfd46b3476` |
| 89 | http2-body-roots | `ownership-http2-body-roots` | `3b72f38e6814` | `d29dda936dff` | `e91dcb307c61` |
| 90 | http2-body-bounds | `fix-http2-body-bounds` | `1b4be82fe9b6` | `6f310b5483a8` | `d29dda936dff` |
| 91 | http2-peer-cleanup | `ownership-http2-peer-cleanup` | `9900cc0d5229` | `3c268c34d15b` | `6f310b5483a8` |
| 92 | grpc-peer-completion | `ownership-grpc-peer-completion` | `e89105300eb3` | `09751c8c65ac` | `3c268c34d15b` |
| 93 | grpc-status-cleanup | `ownership-grpc-status-cleanup` | `f1a357fb78da` | `a92c951fa6d9` | `09751c8c65ac` |
| 94 | grpc-receive-cleanup | `ownership-grpc-receive-cleanup` | `df82d27c917b` | `8bd9e78743ab` | `a92c951fa6d9` |
| 95 | grpc-force-cleanup | `ownership-grpc-force-cleanup` | `ab5723156bca` | `6b82bc5b8b2f` | `8bd9e78743ab` |
| 96 | grpc-render-cleanup | `ownership-grpc-render-cleanup` | `8aa292c5a24a` | `ea79bdee1191` | `6b82bc5b8b2f` |
| 97 | grpc-send-cleanup | `ownership-grpc-send-cleanup` | `bf2371572323` | `671ada6ec85d` | `ea79bdee1191` |
| 98 | grpc-request-encoding | `ownership-grpc-request-encoding` | `b82589474d2a` | `663ef599a438` | `671ada6ec85d` |
| 99 | grpc-canonical-encoding | `ownership-grpc-canonical-encoding` | `3c67663986c7` | `4114b709fb4b` | `663ef599a438` |
| 100 | grpc-response-encoding | `ownership-grpc-response-encoding` | `3883d1abaccc` | `b44f53c9a60f` | `4114b709fb4b` |
| 101 | grpc-client-requests | `ownership-grpc-client-requests` | `9bdd82863c39` | `2339ff08e421` | `b44f53c9a60f` |
| 102 | grpc-client-failure-text | `ownership-grpc-client-failure-text` | `7e011508db02` | `33661b298f96` | `2339ff08e421` |
| 103 | grpc-client-receive | `ownership-grpc-client-receive` | `b7961a14d5dd` | `c48864ce7231` | `33661b298f96` |
| 104 | grpc-connect-cleanup | `ownership-grpc-connect-cleanup` | `392a5721e544` | `b244d5f7c423` | `c48864ce7231` |
| 105 | grpc-connect-startup | `ownership-grpc-connect-startup` | `96174aaaf6be` | `cb20833c018f` | `b244d5f7c423` |
| 106 | grpc-context-restore | `ownership-grpc-context-restore` | `8c53b11ae1d0` | `7a89dd017ae4` | `cb20833c018f` |
| 107 | grpc-context-resources | `ownership-grpc-context-resources` | `e36c9af3743f` | `ea18e54f0eee` | `7a89dd017ae4` |
| 108 | grpc-capture-resources | `ownership-grpc-capture-resources` | `edac8c6a96dc` | `36ad63424530` | `ea18e54f0eee` |
| 109 | grpc-tls-pool-identity | `fix-grpc-tls-pool-identity` | `1c471fb6b348` | `d178d86dca2b` | `36ad63424530` |
| 110 | grpc-environment-cache | `ownership-grpc-environment-cache` | `93d088fb187d` | `6f4bfba80ef3` | `d178d86dca2b` |
| 111 | grpc-packed-options | `ownership-grpc-packed-options` | `73e37788e5c6` | `2bb665596390` | `6f4bfba80ef3` |
| 112 | grpc-connection-addresses | `ownership-grpc-connection-addresses` | `12a2f3a988b2` | `edbc5e8d0e62` | `2bd17608388d` |

The record-reconstruction branch `b21203da65d3` was incorporated into record-update
`5c5875d30b8e`; do not open an extra PR for it. The evidence branch is separate:
its workflow commits and equivalent baseline repairs never enter this chain.

