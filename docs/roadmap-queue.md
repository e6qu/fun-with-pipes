# Prepared roadmap queue

Updated 2026-10-08. These published branches are preparation, not merged support.
Open one PR at a time in this order after the previous PR passes all six gates
and squash-merges. Merged PR #86/zip has immutable OLD head `bdb750f6`; right-fold is next (row 9).
Completed rows remain as immutable anchors; do not reopen fold or zip.

For a branch, rebase with `git rebase --onto NEW_MAIN OLD_PARENT BRANCH`.
Preserve OLD head/parent below permanently: children were prepared from original
heads, not later rewrites or squash commits. Replace outdated plan/handoff copies
with current root docs when resolving documentation conflicts. Re-run focused
checks after rebasing; original evidence is in [the history](roadmap-history.md).
Publish with an explicit lease against the remote current head, then create the
sole next PR. Full exact-head CI is required anew for every PR.

Current head changes on rebase; OLD anchors never change. Fold's final published
head `a090f1f5ac6c` passed all six CI `37728301773` gates and squash-merged as
`d4e52617eac2`. Zip final `cf8ce6e61295` passed all six CI `37733658893` jobs and merged as
`90affeb3954a`. Right-fold now rebases from OLD zip onto that squash.
For a rewritten branch, use its actual current base
when rebasing again. Ancestry checks use OLD parent → OLD head, not current head. Prefixes uniquely resolve
in this repository; use resolved full hashes for publication/merge head checks.
Checkout paths are `/private/tmp/fwp-NAME-worktree` with NAME below.

| Order | NAME | Branch | Current head | Immutable OLD head | Immutable OLD parent |
|---|---|---|---|---|---|
| 7 | fold | `ownership-fold-transfers` | `a090f1f5ac6c` | `a180c3fb5f42` | `1ea7f079043c` |
| 8 | zip | `ownership-zip-callbacks` | `cf8ce6e61295` | `bdb750f6d46b` | `a180c3fb5f42` |
| 9 | right-fold | `ownership-right-fold` | `adc7947a25f2` | `adc7947a25f2` | `bdb750f6d46b` |
| 10 | prefix | `ownership-list-prefix` | `376e77ae9469` | `376e77ae9469` | `adc7947a25f2` |
| 11 | list-copy | `ownership-list-copies` | `bb00baa4ab95` | `bb00baa4ab95` | `376e77ae9469` |
| 12 | list-option | `ownership-list-options` | `34023f35a42f` | `34023f35a42f` | `bb00baa4ab95` |
| 13 | inference | `inference-call-effects` | `89b7bde2c8f0` | `89b7bde2c8f0` | `34023f35a42f` |
| 14 | wide | `ownership-wide-counts` | `3a791dc7e9f3` | `3a791dc7e9f3` | `89b7bde2c8f0` |
| 15 | order | `ownership-list-order` | `c83557825d8a` | `c83557825d8a` | `3a791dc7e9f3` |
| 16 | sort-callback | `ownership-sort-callbacks` | `66bc713dea67` | `66bc713dea67` | `c83557825d8a` |
| 17 | state-sequence | `ownership-state-sequences` | `0a90b0520cc1` | `0a90b0520cc1` | `66bc713dea67` |
| 18 | loop | `ownership-loop-state` | `787763d2e4b6` | `787763d2e4b6` | `0a90b0520cc1` |
| 19 | structure | `ownership-list-structure` | `c05a5d9c7d86` | `c05a5d9c7d86` | `787763d2e4b6` |
| 20 | generation | `ownership-list-generation` | `fad9b1ad08f6` | `fad9b1ad08f6` | `c05a5d9c7d86` |
| 21 | array-element | `ownership-array-elements` | `636414fabf18` | `636414fabf18` | `fad9b1ad08f6` |
| 22 | map-set | `ownership-map-set-elements` | `a8a7d119712b` | `a8a7d119712b` | `636414fabf18` |
| 23 | old-reclamation | `ownership-old-reclamation` | `6774aa5bb426` | `6774aa5bb426` | `a8a7d119712b` |
| 24 | task-boundary | `ownership-task-boundaries` | `02beec353ec7` | `02beec353ec7` | `6774aa5bb426` |
| 25 | unwind-runtime | `ownership-unwind-runtime` | `3e314222ff7c` | `3e314222ff7c` | `02beec353ec7` |
| 26 | unwind-liveness | `ownership-reuse-tokens` | `33cf86466e2f` | `33cf86466e2f` | `3e314222ff7c` |
| 27 | call-liveness | `ownership-call-liveness` | `7392f2d67151` | `7392f2d67151` | `33cf86466e2f` |
| 28 | runtime-call | `ownership-runtime-call-cleanup` | `bee3f1659ae5` | `bee3f1659ae5` | `7392f2d67151` |
| 29 | map-unwind | `ownership-map-unwind` | `62add7e4a85f` | `62add7e4a85f` | `bee3f1659ae5` |
| 30 | selection-unwind | `ownership-selection-unwind` | `b8f4c2469215` | `b8f4c2469215` | `62add7e4a85f` |
| 31 | zip-unwind | `ownership-zip-unwind` | `c2a364544d92` | `c2a364544d92` | `b8f4c2469215` |
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
| 61 | grpc-server | `ownership-grpc-server-cleanup` | `0d5d3098e782` | `0d5d3098e782` | `07092cb06e1d` |
| 62 | tls-cache | `ownership-tls-cache-failures` | `4ab1f7ddd6f8` | `4ab1f7ddd6f8` | `0d5d3098e782` |
| 63 | tls-wire | `ownership-tls-wire-preparation` | `f6598e440a59` | `f6598e440a59` | `4ab1f7ddd6f8` |
| 64 | connect-cleanup | `ownership-connect-cancellation` | `0cc612650ab9` | `0cc612650ab9` | `f6598e440a59` |
| 65 | unboxed-worker | `ownership-unboxed-worker-locals` | `b8f3752d236f` | `b8f3752d236f` | `0cc612650ab9` |
| 66 | peer-subject | `ownership-tls-peer-subject` | `6bda2c815a71` | `6bda2c815a71` | `b8f3752d236f` |
| 67 | tls-alpn-root | `ownership-tls-alpn-roots` | `e0f11626f609` | `e0f11626f609` | `6bda2c815a71` |

| 68 | ci-probe-repairs | `ownership-ci-probe-repairs` | `e503e10a9780` | `e503e10a9780` | `e0f11626f609` |

| 69 | nested-loop-boxing | `ownership-nested-loop-boxing` | `b00215dc10f5` | `b00215dc10f5` | `e503e10a9780` |
| 70 | file-construction | `ownership-file-construction` | `e9d575fdf990` | `e9d575fdf990` | `b00215dc10f5` |
| 71 | file-write-visibility | `ownership-file-write-visibility` | `5ac710398a14` | `5ac710398a14` | `e9d575fdf990` |
| 72 | file-io-errors | `ownership-file-io-errors` | `06419f4c5989` | `06419f4c5989` | `5ac710398a14` |

The record-reconstruction branch `b21203da65d3` was incorporated into record-update
`5c5875d30b8e`; do not open an extra PR for it. The evidence branch is separate:
its workflow commits and equivalent baseline repairs never enter this chain.
