# Prepared roadmap queue

Updated 2026-10-10. This table preserves preparation ancestry. Current merge
status, actual rewritten bases and checks live in [the handoff](development-state.md).
A published preparation is not verified main support.

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
Every final PR needs all six production jobs and roadmap_docs at its exact head.
Prior evidence and superseded queue instructions are preserved in [history](roadmap-history.md).

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
| 32 | fold-unwind | `ownership-fold-unwind` | `58986d22a451` | `968dac7ed9cf` | `c2a364544d92` |
| 33 | loop-unwind | `ownership-loop-unwind` | `ac24ea45cbe0` | `988f2a3be97f` | `968dac7ed9cf` |
| 34 | argument-preparation | `ownership-argument-preparation` | `49705971b287` | `49739182ecb6` | `988f2a3be97f` |
| 35 | constructor-unwind | `ownership-constructor-unwind` | `54249400ef16` | `608ae7bb2d24` | `49739182ecb6` |
| 36 | worker-boxing | `ownership-worker-boxing` | `759bc59437a7` | `dc4f9461571b` | `608ae7bb2d24` |
| 37 | worker-preparation | `ownership-worker-preparation` | `8c4e9ffd71a5` | `c97dd03f8d89` | `dc4f9461571b` |
| 38 | loop-preparation | `ownership-loop-preparation` | `4289528c436b` | `b879eca20812` | `c97dd03f8d89` |
| 39 | variant-preparation | `ownership-variant-preparation` | `d98205af88df` | `1bb11bece9ae` | `b879eca20812` |
| 40 | constructor-types | `ownership-constructor-types` | `5ebcb2d6b0e2` | `b0219671dca3` | `1bb11bece9ae` |
| 41 | variant-conversion | `ownership-variant-conversion` | `cca935846750` | `34873f41a4c4` | `b0219671dca3` |
| 42 | record-update | `ownership-record-update` | `cd2c8fa4251a` | `5c5875d30b8e` | `34873f41a4c4` |
| 43 | record-conversion | `ownership-record-conversion` | `6b809877a1ac` | `614dd3b19c13` | `5c5875d30b8e` |
| 44 | variant-alias | `ownership-variant-alias` | `b094ffbe7e46` | `de8562194d54` | `614dd3b19c13` |
| 45 | typed-expression | `ownership-match-context` | `2b7dc81c7d1f` | `3f61f51521d9` | `de8562194d54` |
| 46 | field-context | `ownership-field-context` | `6255a8f54f54` | `085dc716d599` | `3f61f51521d9` |
| 47 | caf-ownership | `ownership-caf-cache` | `7e1c164a0e81` | `68cf7bf2f7ca` | `085dc716d599` |
| 48 | inline-caf | `ownership-inline-caf` | `36fb4e1de52e` | `6734248e7c0d` | `68cf7bf2f7ca` |
| 49 | retained-thunk | `ownership-task-thunks` | `215e0edec0f1` | `7208e4a2d93e` | `6734248e7c0d` |
| 50 | task-within | `ownership-task-within` | `5cfbbf10087a` | `14a76de5b8bb` | `7208e4a2d93e` |
| 51 | task-scope | `ownership-task-scope` | `f36bacf80bfc` | `7da15d9c8ea3` | `14a76de5b8bb` |
| 52 | task-handle | `ownership-task-handles` | `df26a860c99f` | `bb6f9c49a043` | `7da15d9c8ea3` |
| 53 | channel-queue | `ownership-channel-queues` | `b304e91f628c` | `ab44b7de0812` | `bb6f9c49a043` |
| 54 | library-result | `ownership-library-results` | `46afd27c986c` | `5b34382167da` | `ab44b7de0812` |
| 55 | library-input | `ownership-library-inputs` | `96ee4fd963e3` | `a6ebc1da9637` | `5b34382167da` |
| 56 | library-unload | `ownership-library-unload` | `6c367aa9a921` | `5d0dc220fa1c` | `a6ebc1da9637` |
| 57 | opencl | `ownership-opencl-lifetime` | `3dd39a69a430` | `d8b4d88da98d` | `5d0dc220fa1c` |
| 58 | interpreter-opencl | `ownership-interpreter-opencl` | `4119be1cdaf9` | `abc128581b61` | `d8b4d88da98d` |
| 59 | tls-listener | `ownership-tls-listeners` | `f5e2a298537d` | `3f6154b4bf67` | `abc128581b61` |
| 60 | library-resource | `ownership-library-resources` | `3eb64f54869f` | `07092cb06e1d` | `3f6154b4bf67` |
| 61 | grpc-server | `ownership-grpc-server-cleanup` | `ca75ca461682` | `0d5d3098e782` | `07092cb06e1d` |
| 62 | tls-cache | `ownership-tls-cache-failures` | `0b51abc49371` | `4ab1f7ddd6f8` | `0d5d3098e782` |
| 63 | tls-wire | `ownership-tls-wire-preparation` | `2c2c562401ab` | `f6598e440a59` | `4ab1f7ddd6f8` |
| 64 | connect-cleanup | `ownership-connect-cancellation` | `d7641a1ab055` | `0cc612650ab9` | `f6598e440a59` |
| 65 | unboxed-worker | `ownership-unboxed-worker-locals` | `e217ad8ce0d9` | `b8f3752d236f` | `0cc612650ab9` |
| 66 | peer-subject | `ownership-tls-peer-subject` | `7250692d5758` | `6bda2c815a71` | `b8f3752d236f` |
| 67 | tls-alpn-root | `ownership-tls-alpn-roots` | `6d80e63524c2` | `e0f11626f609` | `6bda2c815a71` |
| 68 | ci-probe-repairs | `ownership-ci-probe-repairs` | `c0cdb26eb99b` | `e503e10a9780` | `e0f11626f609` |
| 69 | nested-loop-boxing | `ownership-nested-loop-boxing` | `7a68a54d2660` | `b00215dc10f5` | `e503e10a9780` |
| 70 | file-construction | `ownership-file-construction` | `ab3a93780dc3` | `e9d575fdf990` | `b00215dc10f5` |
| 71 | file-write-visibility | `ownership-file-write-visibility` | `702cd9b0a69a` | `5ac710398a14` | `e9d575fdf990` |
| 72 | file-io-errors | `ownership-file-io-errors` | `eee4807a3954` | `06419f4c5989` | `5ac710398a14` |
| 73 | resource-frames | `ownership-resource-frames` | `3dba256655a3` | `dcc5bbac318f` | `06419f4c5989` |
| 74 | file-runtime-owners | `ownership-file-runtime-owners` | `8d5cb3c4e3e4` | `e21c92ea2f6c` | `368dafc5567d` |
| 75 | file-discard | `ownership-file-discard` | `423a7ddcc760` | `923ad4a4fb07` | `e21c92ea2f6c` |
| 76 | file-runtime-boundaries | `ownership-file-runtime-boundaries` | `603bb0b914db` | `30fe112db93c` | `923ad4a4fb07` |
| 77 | wasm-resource-counts | `ownership-wasm-resource-counts` | `f4a26004d5a8` | `046f7e85a9eb` | `30fe112db93c` |
| 78 | wasm-count-disposal | `ownership-wasm-count-disposal` | `13c77dbb7b82` | `681dd55136b0` | `c889479eed7a` |
| 79 | resource-frame-fields | `ownership-resource-frame-fields` | `2f842d5d266f` | `658e5b73ae1c` | `681dd55136b0` |
| 80 | file-inline-path | `ownership-file-inline-path` | `010e622f064e` | `2d903d6617d9` | `658e5b73ae1c` |
| 81 | file-storage-disposal | `ownership-file-storage-disposal` | `6e5063786651` | `750a5cffd46b` | `2d903d6617d9` |
| 82 | file-construction-disposal | `ownership-file-construction-disposal` | `ecfd9a28c39e` | `17869223a502` | `750a5cffd46b` |
| 83 | resource-frame-variants | `ownership-resource-frame-variants` | `7b7e45b20230` | `786e4bbb99f1` | `17869223a502` |
| 84 | resource-frame-binding-kinds | `ownership-resource-frame-binding-kinds` | `e2a2baa977fa` | `ae00e6929e86` | `786e4bbb99f1` |
| 85 | match-scrutinee-types | `ownership-match-scrutinee-types` | `ebe69e13a935` | `3a0cbdb33b79` | `ae00e6929e86` |
| 86 | resource-record-binding-kinds | `ownership-resource-record-binding-kinds` | `a0de231a4c0c` | `f85cc4e09db4` | `3a0cbdb33b79` |
| 87 | nominal-source-context | `ownership-nominal-source-context` | `5a4ef15301c8` | `8abfd46b3476` | `f85cc4e09db4` |
| 88 | channel-cycle | `ownership-channel-cycle-lifetimes` | `3db25573057b` | `dc2ad1febc5d` | `8abfd46b3476` |
| 89 | http2-body-roots | `ownership-http2-body-roots` | `5bc4f862bd5a` | `d29dda936dff` | `e91dcb307c61` |
| 90 | http2-body-bounds | `fix-http2-body-bounds` | `fabe0ac7b24a` | `6f310b5483a8` | `d29dda936dff` |
| 91 | http2-peer-cleanup | `ownership-http2-peer-cleanup` | `9900cc0d5229` | `3c268c34d15b` | `6f310b5483a8` |
| 92 | grpc-peer-completion | `ownership-grpc-peer-completion` | `e89105300eb3` | `09751c8c65ac` | `3c268c34d15b` |
| 93 | grpc-status-cleanup | `ownership-grpc-status-cleanup` | `f1a357fb78da` | `a92c951fa6d9` | `09751c8c65ac` |
| 94 | grpc-receive-cleanup | `ownership-grpc-receive-cleanup` | `df82d27c917b` | `8bd9e78743ab` | `a92c951fa6d9` |
| 95 | grpc-force-cleanup | `ownership-grpc-force-cleanup` | `ab5723156bca` | `6b82bc5b8b2f` | `8bd9e78743ab` |
| 96 | grpc-render-cleanup | `ownership-grpc-render-cleanup` | `8aa292c5a24a` | `ea79bdee1191` | `6b82bc5b8b2f` |
| 97 | grpc-send-cleanup | `ownership-grpc-send-cleanup` | `bf2371572323` | `671ada6ec85d` | `ea79bdee1191` |
| 98 | grpc-request-encoding | `ownership-grpc-request-encoding` | `b82589474d2a` | `663ef599a438` | `671ada6ec85d` |
| 99 | grpc-canonical-encoding | `ownership-grpc-canonical-encoding` | `3c67663986c7` | `4114b709fb4b` | `663ef599a438` |
| 100 | grpc-response-encoding | `ownership-grpc-response-encoding` | `61a0def48b7d` | `b44f53c9a60f` | `4114b709fb4b` |
| 101 | grpc-client-requests | `ownership-grpc-client-requests` | `c05384110969` | `2339ff08e421` | `b44f53c9a60f` |
| 102 | grpc-client-failure-text | `ownership-grpc-client-failure-text` | `7931f680a003` | `33661b298f96` | `2339ff08e421` |
| 103 | grpc-client-receive | `ownership-grpc-client-receive` | `38e1e7ab8048` | `c48864ce7231` | `33661b298f96` |
| 104 | grpc-connect-cleanup | `ownership-grpc-connect-cleanup` | `54cffe881e1f` | `b244d5f7c423` | `c48864ce7231` |
| 105 | grpc-connect-startup | `ownership-grpc-connect-startup` | `c07c37877b47` | `cb20833c018f` | `b244d5f7c423` |
| 106 | grpc-context-restore | `ownership-grpc-context-restore` | `43757843a1b3` | `7a89dd017ae4` | `cb20833c018f` |
| 107 | grpc-context-resources | `ownership-grpc-context-resources` | `f63fbe1de7c0` | `ea18e54f0eee` | `7a89dd017ae4` |
| 108 | grpc-capture-resources | `ownership-grpc-capture-resources` | `cd31bd02464f` | `36ad63424530` | `ea18e54f0eee` |
| 109 | grpc-tls-pool-identity | `fix-grpc-tls-pool-identity` | `6b206eae08ec` | `d178d86dca2b` | `36ad63424530` |
| 110 | grpc-environment-cache | `ownership-grpc-environment-cache` | `0caead68a6c3` | `6f4bfba80ef3` | `d178d86dca2b` |
| 111 | grpc-packed-options | `ownership-grpc-packed-options` | `b2350957e6ff` | `2bb665596390` | `6f4bfba80ef3` |
| 112 | grpc-connection-addresses | `ownership-grpc-connection-addresses` | `0da68ea8cdb1` | `edbc5e8d0e62` | `2bd17608388d` |

The record-reconstruction branch `b21203da65d3` was incorporated into record-update
`5c5875d30b8e`; do not open an extra PR for it. The evidence branch is separate:
its workflow commits and equivalent baseline repairs never enter this chain.

