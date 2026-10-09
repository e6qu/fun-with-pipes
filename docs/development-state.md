# Session handoff

Updated 2026-10-09. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
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

Main is eeef3b5d3f5386015c6dead55cc5da632f61d61d (#100). All six
CI37961944703 production gates and roadmap_docs CI37961944952 pass at
b5d658aa1a06391e106874bf2c3fc2b551f3a0ac. Explicit match-head squash at
2026-10-09T17:45:46Z verifies the entire one-line message:
`Own typed map and set elements across copies updates and callbacks`.
#74–#100 deliver native macOS and selected ownership through typed repeat/range,
zip/unzip/chunks, loop-state/Step/ABI wrappers, exact native wide counts, arrays,
maps and sets. Phase1 is done; phase2 remains incomplete; phases3–6 are pending.

PR101 https://github.com/e6qu/fun-with-pipes/pull/101 is the only open PR.
Its current head is 6fddf4f0b0734dd0e3a78ea7f8211f805d82dd9c, with actual
base eeef3b5d3f5386015c6dead55cc5da632f61d61d. CI37969632273 (six production jobs)
and CI37969632440 (roadmap_docs) are current production gates. roadmap_docs, bench, regular ARM macOS and both
GC stress jobs and Linux pass; regular Intel macOS runs. All six are required. Compiler/runtime/tests match
focused-accepted495411d33f60 exactly. The final publication records the merged
map/set contracts and inherits the portable roadmap audit. Require all six
production jobs and roadmap_docs at this exact head before squash with
`Reclaim old owned storage and preserve young reuse invariants` and empty body.
Superseded PR100 runs37958351622/37959781379/37960281416 are cancelled,
not acceptance. Initial PR101 CI37968881919 is superseded and cancelled;
its documentation check passed at the old head, not the current head. Row24 has actual current base495411d, so final-rebase FROM
that base ONTO the actual PR101 squash after it merges. OLD anchors stay fixed.

Later preparations inherit both CLI early-stdin-close and tracing-fixture
repairs on final rebases. Row112's formatting failure is repaired and focused
Linux/native checks pass. OLD heads remain retained by immutable tags; the
stronger tag-identity audit repairs the row112 status-update error. Detailed
failed/superseded logs and old handoffs remain in history. Current evidence
and resource limits are below.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 22 ownership-map-set-elements | b5d658aa1a06 | c4d820e0d032 | GitHub CI37955579519 passes unchanged source; fresh local guard refused |
| 23 ownership-old-reclamation | 6fddf4f0b073 | eeef3b5d3f53 | PR101 full CI follows; source matches focused-accepted495411d |
| 24 ownership-task-boundaries | 1741ab5fa64e | 495411d33f60 | Tests13.56/27.29s; lint/format and GitHub CI37959126658 pass |
| 25 ownership-unwind-runtime | 6421c025b3d5 | 1741ab5fa64e | Tests9.45/19.08s; lint/format and GitHub CI37960652006 pass |
| 26 ownership-reuse-tokens | bb77c078354f | 6421c025b3d5 | Tests18.92/38.09s; lint/format and GitHub CI37961205676 pass |
| 27 ownership-call-liveness | c4eb75e82882 | bb77c078354f | GitHub CI37962382433 passes; fresh local guard refused |
| 28 ownership-runtime-call-cleanup | b5f44e80462c | c4eb75e82882 | Source unchanged; local limits defer fresh checks to GitHub |
| 29 ownership-map-unwind | 84ef5480f493 | b5f44e80462c | Normal GitHub CI37966274872 passes after fixture pointer repair |
| 30 ownership-selection-unwind | ca33d3141a96 | 84ef5480f493 | Normal GitHub CI37966690637 passes after fixture repair |
| 31 ownership-zip-unwind | a282f630c790 | ca33d3141a96 | Six callbacks20.69/41.60s; lint/format and Linux CI37967629573 pass |
| 32 ownership-fold-unwind | 459287698745 | a282f630c790 | Two fold tests13.13/26.45s; lint2.75/5.42s and format0.44/0.82s pass |
| 33 ownership-loop-unwind | b16195bcebf3 | 459287698745 | Two tests11.07/22.31s; lint2.42/4.93s pass; fresh Linux follows |
| 34 ownership-argument-preparation | 9f56744c4eb7 | b16195bcebf3 | Test9.91/20.00s; lint2.69/5.35s and format0.34/0.61s pass |
| 35 ownership-constructor-unwind | 82f58d851b73 | 9f56744c4eb7 | Native10.06/20.35s; exact unit3.38/7.11s; lint2.44/4.84s and format0.46/0.74s pass |
| 36 ownership-worker-boxing | 6032ecffcb7d | 82f58d851b73 | Test10.21/20.62s; lint2.42/4.87s and format0.35/0.62s pass |
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
| 56 ownership-library-unload | ac6de597fddc | 625ac7793f84 | Focused checks follow; compiler/runtime unchanged |
| 57 ownership-opencl-lifetime | 4ae80b641da1 | ac6de597fddc | Fake OpenCL API ownership checks follow; no hardware numerics claim |
| 58 ownership-interpreter-opencl | a5ebb52578e3 | 4ae80b641da1 | Fake API native/interpreter failure cleanup checks follow |
| 59 ownership-tls-listeners | 838cf5dee220 | 00013d55d078 | 8.83 / 20.03 s |
| 60 ownership-library-resources | d56a24e48d7e | 838cf5dee220 | 11.76 / 31.49 s |
| 61 ownership-grpc-server-cleanup | c299edbc33eb | d56a24e48d7e | 12.59 / 28.85 s |
| 62 ownership-tls-cache-failures | 0be508308064 | c299edbc33eb | 11.21 / 26.06 s |
| 63 ownership-tls-wire-preparation | 66e80d399e65 | 0be508308064 | 11.65 / 26.15 s |
| 64 ownership-connect-cancellation | ae05b2bfc32c | 66e80d399e65 | 12.36 / 27.82 s |
| 65 ownership-unboxed-worker-locals | 2ba7084abe25 | ae05b2bfc32c | 20.34 / 58.06 s |
| 66 ownership-tls-peer-subject | b728cf5f2adb | 2ba7084abe25 | 10.79 / 25.73 s |
| 67 ownership-tls-alpn-roots | 22b95b0ddb74 | b728cf5f2adb | 11.12 / 26.13 s |
| 68 ownership-ci-probe-repairs | 7d8ab6719e55 | 22b95b0ddb74 | 30.99 / 62.26 s |
| 69 ownership-nested-loop-boxing | 821e6c1baaef | 7d8ab6719e55 | 18.32 / 36.87 s |
| 70 ownership-file-construction | 0d09a61aaab7 | 821e6c1baaef | 11.09 / 22.39 s |
| 71 ownership-file-write-visibility | 8a061cb9b8ab | 0d09a61aaab7 | 12.72 / 25.58 s |
| 72 ownership-file-io-errors | d4611644084a | 8a061cb9b8ab | 18.47 / 37.02 s |
| 73 ownership-resource-frames | 3c87e1f63b51 | d4611644084a | 21.06 / 42.34 s + three units 3.93 / 8.00 s |
| 74 ownership-file-runtime-owners | 4b5da4aa946a | 3c87e1f63b51 | 21.91 / 44.03 s |
| 75 ownership-file-discard | db3bcf0da8d6 | 4b5da4aa946a | 22.99 / 46.22 s |
| 76 ownership-file-runtime-boundaries | b4860bf2c392 | db3bcf0da8d6 | 22.08 / 46.15 s |
| 77 ownership-wasm-resource-counts | b4482c259c1e | b4860bf2c392 | Native bump 7.93 / 16.79 s + File 1.26 / 3.62 s; actual WASI awaits CI |
| 78 ownership-wasm-count-disposal | 9609b73ef5ed | b4482c259c1e | Two native bump tests 9.47 / 19.69 s + File 12.17 / 24.55 s; actual WASI awaits CI |
| 79 ownership-resource-frame-fields | 35c2aeb2923e | 9609b73ef5ed | Four tests 18.06 / 36.28 s |
| 80 ownership-file-inline-path | e7d3882b67ae | 35c2aeb2923e | Four tests 12.66 / 25.48 s |
| 81 ownership-file-storage-disposal | faac017dc60d | e7d3882b67ae | Five tests 25.15 / 54.49 s |
| 82 ownership-file-construction-disposal | 06c93eff77af | faac017dc60d | Three tests 10.55 / 25.59 s |
| 83 ownership-resource-frame-variants | f3c9ee4ec354 | 06c93eff77af | Five tests 26.37 / 53.88 s |
| 84 ownership-resource-frame-binding-kinds | d2936a008fd2 | f3c9ee4ec354 | Four tests 32.57 / 65.62 s |
| 85 ownership-match-scrutinee-types | 97dca7626158 | d2936a008fd2 | Four tests 15.67 / 33.72 s + rebuilt HTTP golden 1.19 / 6.75 s |
| 86 ownership-resource-record-binding-kinds | 5915ac0607ac | 97dca7626158 | Three tests 16.25 / 34.51 s |
| 87 ownership-nominal-source-context | f08611023cec | 5915ac0607ac | One source test 13.06 / 26.28 s |
| 88 ownership-channel-cycle-lifetimes | e91dcb307c61 | f08611023cec | Two cycle/queue tests 13.11 / 26.29 s |
| 89 ownership-http2-body-roots | d29dda936dff | e91dcb307c61 | Body root 0.57 / 2.23 s + TLS root 0.55 / 2.12 s |
| 90 fix-http2-body-bounds | 6f310b5483a8 | d29dda936dff | Engine comparison 6.00 / 12.64 s + body root 7.61 / 15.92 s |
| 91 ownership-http2-peer-cleanup | 3c268c34d15b | 6f310b5483a8 | Two peer/TLS tests 1.32 / 5.17 s |
| 92 ownership-grpc-peer-completion | 09751c8c65ac | 3c268c34d15b | Peer/server14.18 / 28.39 s + task4.65 / 10.14 s |
| 93 ownership-grpc-status-cleanup | a92c951fa6d9 | 09751c8c65ac | Status/peer6.25 / 12.74 s final |
| 94 ownership-grpc-receive-cleanup | 8bd9e78743ab | a92c951fa6d9 | Receive/status12.09 / 24.36 s |
| 95 ownership-grpc-force-cleanup | 6b82bc5b8b2f | 8bd9e78743ab | Force/receive11.15 / 23.28 s |
| 96 ownership-grpc-render-cleanup | ea79bdee1191 | 6b82bc5b8b2f | Render/force2.79 / 5.95 s |
| 97 ownership-grpc-send-cleanup | 671ada6ec85d | ea79bdee1191 | Send/force10.02 / 21.56 s |
| 98 ownership-grpc-request-encoding | 663ef599a438 | 671ada6ec85d | Request/send2.03 / 4.93 s |
| 99 ownership-grpc-canonical-encoding | 4114b709fb4b | 663ef599a438 | Canonical/request8.38 / 17.93 s |
| 100 ownership-grpc-response-encoding | b44f53c9a60f | 4114b709fb4b | 2.95 / 6.01 s |
| 101 ownership-grpc-client-requests | 2339ff08e421 | b44f53c9a60f | 9.19 / 18.71 s |
| 102 ownership-grpc-client-failure-text | 33661b298f96 | 2339ff08e421 | 9.02 / 18.93 s |
| 103 ownership-grpc-client-receive | c48864ce7231 | 33661b298f96 | 13.79 / 27.82 s |
| 104 ownership-grpc-connect-cleanup | b244d5f7c423 | c48864ce7231 | 9.33 / 20.92 s |
| 105 ownership-grpc-connect-startup | cb20833c018f | b244d5f7c423 | 6.11 / 12.61 s |
| 106 ownership-grpc-context-restore | 7a89dd017ae4 | cb20833c018f | 8.46 / 18.21 s |
| 107 ownership-grpc-context-resources | ea18e54f0eee | 7a89dd017ae4 | 7.45 / 16.78 s |
| 108 ownership-grpc-capture-resources | 36ad63424530 | ea18e54f0eee | 11.62 / 25.50 s + added rollback 2.08 / 5.20 s |
| 109 fix-grpc-tls-pool-identity | d178d86dca2b | 36ad63424530 | 1.15 / 3.31 s identity + interpreter unit 5.51 / 11.41 s |
| 110 ownership-grpc-environment-cache | 6f4bfba80ef3 | d178d86dca2b | Focused GitHub CI37948869170 passes |
| 111 ownership-grpc-packed-options | 2bd17608388d | 6f4bfba80ef3 | Focused GitHub CI37950759037 passes |
| 112 ownership-grpc-connection-addresses | 762117573367 | 2bd17608388d | Tests7.98/16.49s; lint/format and GitHub CI37958243461 pass |

Rows21–109 have prior focused test/lint/format evidence at their recorded
heads; rows18–22 are merged. Row23 source is unchanged from focused Linux
acceptance and is now in PR101 on actual main. Detailed commands, full hashes,
fixture failures and omission controls remain in history. Every production PR
requires six exact-head full gates and the documentation audit.

Use actual bases above for final rebases, never OLD anchors or rewritten
predecessor heads. Preserve all ten root docs for conflict resolution and
inherited CLI/GC harness fixes. Row24 actual base is still495411d, rather than
the newer final PR101 head; final-rebase it only after the actual squash exists.
Rows77–78 require real WASI on Linux in both free modes; native bump checks
supply no WASI acceptance. Row20 boxed128-bit payloads remain shared. Network
context wrappers retain tracing compatibility; no complete ARC claim. Channel
close preserves queued values; explicit drain breaks its counted cycle, while
automatic unreachable-cycle reclamation remains unproved.

## Fixture repair status

Row29 production84ef5480f4938e78c11c10823bf498a8a1a4e6f9 passes normal
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
| Row22 maps and handoff | c79544b74d30e6d285f64e0f500891434a2e91f7 | CI37955579519 passes; production source unchanged atf71c002 |
| Row23 reclamation and tracing | 7783afaef9a7431a40cf34b530c2c43386a06d0b | CI37958839569 passes audit, lint, ownership and actual tracing; production495411d, actual basef71c002 |
| Row110 environment cache | 46aacfbb3f6bd5d0058aa0b6f60b2d030ff63944 | CI37948869170 passes focused Linux checks |
| Row111 packed TLS options | 823af3475560ed7709f958478580e364d89bdddf | CI37950759037 passes focused Linux checks |
| Row112 full connection addresses | 4dbd0dcedfc297f8f0859aca22142a55cc0dd79d | CI37958243461 passes after formatting repair7621175 |
| TLS/listener combined | 9bcae30119028b1870efb8fecfcf9746f5808acb | CI37730777345 all six pass |
| WASM/resource combined | 5fd2ed65385a23f3226b2bef02eb10196f51aeb4 | CI37771769436 all six pass, including required actual WASI |
| Rows47–52 cache and task runtime | 7dfe64894b1dc1107859a5cde550850fdb672973 | CI37973911726 queued; productionfe8ed51, actual base245a0a2 |
| Rows42–46 records and type contexts | 20b948f8eac1c13b059e64b74d6c9a786c2fed9a | CI37972496949 passes Linux ownership/tracing and docs; productionf2262f9, actual base0b00524 |
| Rows38–41 loop/retain/typed conversion | 3a9fcb512a37a745e65629b29b15e1d06ec0a992 | CI37971602336 passes Linux ownership/tracing and docs; production67e3771, actual basedd6c405 |
| Rows35–37 constructor/worker cleanup | c7e26bb43b6b7edd0c93afbbc25bc7c8e8eaf16f | CI37970487617 passes constructor/worker cleanup, tracing and docs; production3bd34da, actual base6032ecf |
| Rows33–34 loop/argument cleanup | 1ac6dc99fde5f6813659be356f7f89c29b8a27b5 | CI37969742246 passes Linux ownership/tracing and docs; production9f56744, actual baseb16195b |
| Row32 fold callback unwind | ef1e5826ffdeb2f2ee1bd238233d4f6e7fa2aff7 | CI37969003113 passes focused Linux and all-doc/tag checks; production4592876, actual basea282f63 |
| Row31 zip callback unwind | c5da11f3b32df3c67422b470fc6c327001119026 | CI37967629573 passes normal Linux checks and all-doc/tag audit; productiona282f63, actual baseca33d31 |
| Row30 selection callback unwind | 7a6ca031fc0b6a10295dc86e07bb83ef0601a295 | CI37966690637 passes normal repaired checks; productionca33d31, actual base84ef548 |
| Row29 map callback unwind | 5c24e0d34ea3b0d9ff4639ba4f0e1bf50c407135 | CI37966274872 passes normal repaired checks; production84ef548, actual baseb5f44e8 |
| Row28 runtime application | ae907d63e277f8c62a07b20aee0dfecb3167a9c6 | CI37962723252 passes focused checks and all-doc/tag audit; productionb5f44e8, actual basec4eb75e |
| Row27 compiler call liveness | 550cd9bd7f3431bf6e25a7db35917c8ab2119444 | CI37962382433 passes focused Linux and all-doc/tag checks; productionc4eb75e, actual basebb77c07 |
| Row26 compiler reuse tokens | 3d6102af3bffcec06a541c8e8238837ff19aad9f | CI37961205676 passes focused Linux checks; productionbb77c07, actual base6421c02 |
| Row25 runtime cleanup | 971d7a120eac20bd85f379159e9ca5d77fdc23ab | CI37960652006 passes focused Linux checks; production6421c02, actual base1741ab5 |
| Row24 task boundaries | 5e4fd6fe2549da35374b11838af9845c066375be | CI37959126658 passes focused checks and audit; production1741ab5, actual base495411d |
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

## Local limits and durable docs

Full builds/tests, benchmarks and large regeneration run on GitHub. Focused
local work is serial and low priority: sampled aggregate RSS below 1 GiB,
target below 2 GiB, free disk at least 64 GiB, deadline 180 seconds. Stop at
limits and move work to CI; never raise or bypass them. Use:

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

The fun-refactor guard is for the other repository. Shared target currently
belongs to /private/tmp/fwp-argument-preparation-worktree; no workloads run. Free disk
recovered after earlier refusals (latest observation113197360KiB available).
Latest row34 guarded checks pass: clean0.00/0.14s; test9.91/20.00s;
clippy2.69/5.35s; format0.34/0.61s. Row32/33 checks are recorded above and
in history; full Linux fold evidence passes. No local full gate was run.
Stop if limits are crossed; move checks to GitHub without bypassing the guard,
including for package clean. Earlier refusal/recovery chronology is in history.
Latest guarded audit scripts/check-roadmap.py passes all44 tracked Markdown
link/heading sets,106 immutable queue pairs and tag identities, contiguous order
and entire commit messages (latest0.35CPU/2.66elapsed). It caught a status update
that accidentally replaced row112's OLD head; restored OLDedbc5e8d0e62,
CURRENT762117573367. Immutable tags never moved. The temporary11-doc auditor
could only check ancestry and did not detect this substitution.
The portable script and exact-head roadmap_docs workflow merged in PR100.
Run `python3 scripts/local-guard.py python3 scripts/check-roadmap.py`; fetch
full history, immutable tags and retained PR heads on a fresh clone. Its workflow
checks the actual PR head rather than GitHub's synthetic merge message. Later
updates need fresh audit when links, refs or subjects change.

Preserve all ten current root docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. The portable auditor is tracked on main.
Latest ten-doc snapshot is /private/tmp/fwp-main-docs-pre100; refresh all ten
immediately before updating main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
