# Prepared roadmap queue

Updated 2026-10-08. These published branches are preparation, not merged support.
Open one PR at a time in this order after the previous PR passes all six gates
and squash-merges. Merged PR #91/inference retains immutable OLD head `89b7bde2`; wide counts
are next (row14).
Completed rows remain immutable anchors; do not reopen rows through inference.

For a branch, rebase with `git rebase --onto NEW_MAIN OLD_PARENT BRANCH`.
Preserve OLD head/parent below permanently: children were prepared from original
heads, not later rewrites or squash commits. Replace outdated plan/handoff copies
with current root docs when resolving documentation conflicts. Re-run focused
checks after rebasing; original evidence is in [the history](roadmap-history.md).
Publish with an explicit lease against the remote current head, then create the
sole next PR. Full exact-head CI is required anew for every PR.

Current heads change on rebase; OLD anchors never change. Rows through13 are
merged; row14/wide is the sole open PR92. Merge/run evidence is in
[the handoff](development-state.md) and [history](roadmap-history.md).
Resource frames retain OLD `dcc5bbac318f`; current `368dafc5567d` also includes
the fusion correction. File runtime owners (row 74) inherit corrected current 368dafc; that is their
actual immutable parent, not the frame row's original dcc5bba. The discard branch inherits row 74. Queue 77 retains OLD 046f7e8 after its
WASI descriptor predicate rewrite to c889479; queue 78 inherits actual c889479,
which is its immutable parent.
Row14 wide is now final-rebased on actual main3c0685c after PR91 squash.
Its next rebase uses actual current3c0685c, not OLD89b7bde.
Its OLDhead3a791dc and row15 OLDparent stay immutable.
Row15 is prepared on current widecb0d7e6; its later rebase must use that
actual current base. OLDheadc835578 and row16 OLDparent stay immutable.
Row16 is prepared on current list-order5fe5692; use that actual current base
for its later squash rebase. OLDhead66bc713 and row17 OLDparent stay immutable.
Row17 is prepared on current sort-callback5c19337; use that actual current
base later. OLDhead0a90b05 and row18 OLDparent stay immutable.
Row18 is prepared on current sequence15743b8; use that actual current base
later. OLDhead787763d and row19 OLDparent stay immutable.
Row19 is prepared on current loop112f3c8; use that actual current base later.
OLDheadc05a5d9 and row20 OLDparent stay immutable.
For a rewritten branch, use its actual current base
when rebasing again. Ancestry checks use OLD parent → OLD head, not current head. Prefixes uniquely resolve
in this repository; use resolved full hashes for publication/merge head checks.
Checkout paths are `/private/tmp/fwp-NAME-worktree` with NAME below.

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
| 17 | state-sequence | `ownership-state-sequences` | `15743b853d6a` | `0a90b0520cc1` | `66bc713dea67` |
| 18 | loop | `ownership-loop-state` | `112f3c8de87b` | `787763d2e4b6` | `0a90b0520cc1` |
| 19 | structure | `ownership-list-structure` | `6ce37fb180e1` | `c05a5d9c7d86` | `787763d2e4b6` |
| 20 | generation | `ownership-list-generation` | `7741d09dd8cf` | `fad9b1ad08f6` | `c05a5d9c7d86` |
| 21 | array-element | `ownership-array-elements` | `443524ef6b6d` | `636414fabf18` | `fad9b1ad08f6` |
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
| 32 | fold-unwind | `ownership-fold-unwind` | `968dac7ed9cf` | `968dac7ed9cf` | `c2a364544d92` |
| 33 | loop-unwind | `ownership-loop-unwind` | `988f2a3be97f` | `988f2a3be97f` | `968dac7ed9cf` |
| 34 | argument-preparation | `ownership-argument-preparation` | `49739182ecb6` | `49739182ecb6` | `988f2a3be97f` |
| 35 | constructor-unwind | `ownership-constructor-unwind` | `608ae7bb2d24` | `608ae7bb2d24` | `49739182ecb6` |
| 36 | worker-boxing | `ownership-worker-boxing` | `dc4f9461571b` | `dc4f9461571b` | `608ae7bb2d24` |
| 37 | worker-preparation | `ownership-worker-preparation` | `c97dd03f8d89` | `c97dd03f8d89` | `dc4f9461571b` |
| 38 | loop-preparation | `ownership-loop-preparation` | `b879eca20812` | `b879eca20812` | `c97dd03f8d89` |
| 39 | variant-preparation | `ownership-variant-preparation` | `1bb11bece9ae` | `1bb11bece9ae` | `b879eca20812` |
| 40 | constructor-types | `ownership-constructor-types` | `b0219671dca3` | `b0219671dca3` | `1bb11bece9ae` |
| 41 | variant-conversion | `ownership-variant-conversion` | `34873f41a4c4` | `34873f41a4c4` | `b0219671dca3` |
| 42 | record-update | `ownership-record-update` | `5c5875d30b8e` | `5c5875d30b8e` | `34873f41a4c4` |
| 43 | record-conversion | `ownership-record-conversion` | `614dd3b19c13` | `614dd3b19c13` | `5c5875d30b8e` |
| 44 | variant-alias | `ownership-variant-alias` | `de8562194d54` | `de8562194d54` | `614dd3b19c13` |
| 45 | typed-expression | `ownership-match-context` | `3f61f51521d9` | `3f61f51521d9` | `de8562194d54` |
| 46 | field-context | `ownership-field-context` | `085dc716d599` | `085dc716d599` | `3f61f51521d9` |
| 47 | caf-ownership | `ownership-caf-cache` | `68cf7bf2f7ca` | `68cf7bf2f7ca` | `085dc716d599` |
| 48 | inline-caf | `ownership-inline-caf` | `6734248e7c0d` | `6734248e7c0d` | `68cf7bf2f7ca` |
| 49 | retained-thunk | `ownership-task-thunks` | `7208e4a2d93e` | `7208e4a2d93e` | `6734248e7c0d` |
| 50 | task-within | `ownership-task-within` | `14a76de5b8bb` | `14a76de5b8bb` | `7208e4a2d93e` |
| 51 | task-scope | `ownership-task-scope` | `7da15d9c8ea3` | `7da15d9c8ea3` | `14a76de5b8bb` |
| 52 | task-handle | `ownership-task-handles` | `bb6f9c49a043` | `bb6f9c49a043` | `7da15d9c8ea3` |
| 53 | channel-queue | `ownership-channel-queues` | `ab44b7de0812` | `ab44b7de0812` | `bb6f9c49a043` |
| 54 | library-result | `ownership-library-results` | `5b34382167da` | `5b34382167da` | `ab44b7de0812` |
| 55 | library-input | `ownership-library-inputs` | `a6ebc1da9637` | `a6ebc1da9637` | `5b34382167da` |
| 56 | library-unload | `ownership-library-unload` | `5d0dc220fa1c` | `5d0dc220fa1c` | `a6ebc1da9637` |
| 57 | opencl | `ownership-opencl-lifetime` | `d8b4d88da98d` | `d8b4d88da98d` | `5d0dc220fa1c` |
| 58 | interpreter-opencl | `ownership-interpreter-opencl` | `abc128581b61` | `abc128581b61` | `d8b4d88da98d` |
| 59 | tls-listener | `ownership-tls-listeners` | `3f6154b4bf67` | `3f6154b4bf67` | `abc128581b61` |
| 60 | library-resource | `ownership-library-resources` | `07092cb06e1d` | `07092cb06e1d` | `3f6154b4bf67` |
| 61 | grpc-server | `ownership-grpc-server-cleanup` | `6364bedd9a5c` | `0d5d3098e782` | `07092cb06e1d` |
| 62 | tls-cache | `ownership-tls-cache-failures` | `4ab1f7ddd6f8` | `4ab1f7ddd6f8` | `0d5d3098e782` |
| 63 | tls-wire | `ownership-tls-wire-preparation` | `f6598e440a59` | `f6598e440a59` | `4ab1f7ddd6f8` |
| 64 | connect-cleanup | `ownership-connect-cancellation` | `0cc612650ab9` | `0cc612650ab9` | `f6598e440a59` |
| 65 | unboxed-worker | `ownership-unboxed-worker-locals` | `b8f3752d236f` | `b8f3752d236f` | `0cc612650ab9` |
| 66 | peer-subject | `ownership-tls-peer-subject` | `6bda2c815a71` | `6bda2c815a71` | `b8f3752d236f` |
| 67 | tls-alpn-root | `ownership-tls-alpn-roots` | `e0f11626f609` | `e0f11626f609` | `6bda2c815a71` |
| 68 | ci-probe-repairs | `ownership-ci-probe-repairs` | `e503e10a9780` | `e503e10a9780` | `e0f11626f609` |
| 69 | nested-loop-boxing | `ownership-nested-loop-boxing` | `b00215dc10f5` | `b00215dc10f5` | `e503e10a9780` |
| 70 | file-construction | `ownership-file-construction` | `722224705f7c` | `e9d575fdf990` | `b00215dc10f5` |
| 71 | file-write-visibility | `ownership-file-write-visibility` | `5ac710398a14` | `5ac710398a14` | `e9d575fdf990` |
| 72 | file-io-errors | `ownership-file-io-errors` | `22a520c26219` | `06419f4c5989` | `5ac710398a14` |
| 73 | resource-frames | `ownership-resource-frames` | `368dafc5567d` | `dcc5bbac318f` | `06419f4c5989` |
| 74 | file-runtime-owners | `ownership-file-runtime-owners` | `e21c92ea2f6c` | `e21c92ea2f6c` | `368dafc5567d` |
| 75 | file-discard | `ownership-file-discard` | `923ad4a4fb07` | `923ad4a4fb07` | `e21c92ea2f6c` |
| 76 | file-runtime-boundaries | `ownership-file-runtime-boundaries` | `30fe112db93c` | `30fe112db93c` | `923ad4a4fb07` |
| 77 | wasm-resource-counts | `ownership-wasm-resource-counts` | `c889479eed7a` | `046f7e85a9eb` | `30fe112db93c` |
| 78 | wasm-count-disposal | `ownership-wasm-count-disposal` | `681dd55136b0` | `681dd55136b0` | `c889479eed7a` |
| 79 | resource-frame-fields | `ownership-resource-frame-fields` | `658e5b73ae1c` | `658e5b73ae1c` | `681dd55136b0` |
| 80 | file-inline-path | `ownership-file-inline-path` | `2d903d6617d9` | `2d903d6617d9` | `658e5b73ae1c` |
| 81 | file-storage-disposal | `ownership-file-storage-disposal` | `750a5cffd46b` | `750a5cffd46b` | `2d903d6617d9` |
| 82 | file-construction-disposal | `ownership-file-construction-disposal` | `17869223a502` | `17869223a502` | `750a5cffd46b` |
| 83 | resource-frame-variants | `ownership-resource-frame-variants` | `786e4bbb99f1` | `786e4bbb99f1` | `17869223a502` |
| 84 | resource-frame-binding-kinds | `ownership-resource-frame-binding-kinds` | `ae00e6929e86` | `ae00e6929e86` | `786e4bbb99f1` |
| 85 | match-scrutinee-types | `ownership-match-scrutinee-types` | `872372452a10` | `3a0cbdb33b79` | `ae00e6929e86` |
| 86 | resource-record-binding-kinds | `ownership-resource-record-binding-kinds` | `f85cc4e09db4` | `f85cc4e09db4` | `3a0cbdb33b79` |
| 87 | nominal-source-context | `ownership-nominal-source-context` | `8abfd46b3476` | `8abfd46b3476` | `f85cc4e09db4` |
| 88 | channel-cycle | `ownership-channel-cycle-lifetimes` | `291f8f75f196` | `dc2ad1febc5d` | `8abfd46b3476` |

The record-reconstruction branch `b21203da65d3` was incorporated into record-update
`5c5875d30b8e`; do not open an extra PR for it. The evidence branch is separate:
its workflow commits and equivalent baseline repairs never enter this chain.

