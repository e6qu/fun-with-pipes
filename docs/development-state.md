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

Main is c4d820e0d032a010c4fa933d879bdaeee9cefc37 (#99). All six
CI37945913789 gates pass at dc85b679407a7adda1438989051ca7eaf70072e5.
Explicit match-head squash at 2026-10-09T16:12:45Z verifies the entire
one-line message: `Own typed array elements across copies updates and callbacks`.
#74–#99 deliver native macOS and selected ownership through typed repeat/range,
zip/unzip/chunks, loop-state/Step/ABI wrappers, exact native wide counts and arrays.
Phase1 is done; phase2 remains incomplete; phases3–6 are pending.

Next delivery is row22, ownership-map-set-elements, final-rebased from actual
dc85b679 onto main c4d820e. Source/runtime/tests/workflows match the focused
GitHub-accepted c9ef3d88211f exactly, including inherited CLI/GC repairs.
Published with an explicit lease as f71c002d5339c827f8b506ff1c75c1cb4b24371d.
PR100 https://github.com/e6qu/fun-with-pipes/pull/100 is open;
CI37958351622 is superseded by the publication-status documentation commit;
require six fresh gates at the updated PR head. The queue records published
sourcef71c002, retained in the updated branch ancestry; retrieve the actual
current PR head before gating or squash. OLD anchors stay immutable.
Row23 pre-delivery refresh495411d uses actual basef71c002.

Later preparations must inherit both CLI early-stdin-close and tracing-fixture
repairs on final rebases. The repaired Linux gate actually verifies the
collector churn output, allocation/collection thresholds and RSS bound.
Ten authoritative docs backed up to /private/tmp/fwp-main-docs-pre99 were
restored byte-for-byte after main fast-forward559f4ac→c4d820e. Preparations
through112 are published. Row112 CI37952655033 failed formatting before
lint/tests. Both fixture formatting corrections are published at762117573367;
evidence4dbd0dcedfc297f8f0859aca22142a55cc0dd79d, CI37958243461,
follows the repair and is queued.
Duplicate main CI37957464783 cancellation confirmed after matching
all-six-accepted PR99 source/runtime/tests/workflows.
Duplicate main CI37944119691 was cancelled after matching all-six-accepted
PR98 source/runtime/tests/workflows; cancellation is not acceptance.
Refreshed maps published c9ef3d88211f6ce982c629dd27b0664ec9bdf68a on actual
dc85b679. Focused GitHub evidence ownership-evidence-map-set, checkout
/private/tmp/fwp-map-set-evidence-worktree, exact960a242d54d4a689730e7591854716ca4c5615a2,
CI37953564015 fails before tests: OLD parent c889479eed7a is missing on
a clean runner. Log /private/tmp/fwp-map-audit-failure.log. All106 OLD heads
are now published atomically as lightweight roadmap/preparation-007…112
tags, retaining their parents without source-branch changes. Refreshed map
evidence c79544b74d30e6d285f64e0f500891434a2e91f7 follows the tag repair,
CI37955579519 passes: handoff audit, format, lint and focused ownership tests.
The independent checks also run if an audit fails, while preserving job failure.
It audits current/immutable queue-head messages,
links/anchors and focused map tests/lint/format without another PR. Its audit
uses durable queue references and fetches retained review heads; retired c8/79bc
preparation heads are not remote ancestors and are no longer audit inputs.
Superseded352affa/51639d3/96e3804 evidence runs are cancelled, not acceptance.
Workflow changes never enter production ancestry; focused evidence is not
six-gate acceptance.
Prior delivery checks and failures remain in history.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 22 ownership-map-set-elements | f71c002d5339 | c4d820e0d032 | GitHub CI37955579519 passes unchanged source; fresh local guard refused |
| 23 ownership-old-reclamation | 495411d33f60 | f71c002d5339 | Refreshed tests 9.89 / 20.19 s; lint/format pass; GitHub tracing pending |
| 24 ownership-task-boundaries | 1741ab5fa64e | 495411d33f60 | Refreshed tests13.56/27.29s; lint/format pass; remote evidence pending |
| 25 ownership-unwind-runtime | 123d8b5928aa | cde58f461f78 | 8.80 / 17.94 s |
| 26 ownership-reuse-tokens | 216e673ff2dd | 123d8b5928aa | 15.26 / 30.66 s |
| 27 ownership-call-liveness | 786f1700236e | 216e673ff2dd | 19.89 / 39.90 s |
| 28 ownership-runtime-call-cleanup | e3c49d965cd0 | 786f1700236e | 15.73 / 31.57 s |
| 29 ownership-map-unwind | 8093bf382210 | e3c49d965cd0 | 16.12 / 32.46 s |
| 30 ownership-selection-unwind | 69b1ad1e33e5 | 8093bf382210 | 22.29 / 44.76 s |
| 31 ownership-zip-unwind | 6a0913896eb7 | 69b1ad1e33e5 | 17.02 / 34.21 s |
| 32 ownership-fold-unwind | 1e8d1e34bc78 | 6a0913896eb7 | 24.13 / 48.48 s |
| 33 ownership-loop-unwind | dc9bfd5e626b | 1e8d1e34bc78 | 28.65 / 57.61 s |
| 34 ownership-argument-preparation | ada6a3a62df1 | dc9bfd5e626b | 24.82 / 49.89 s |
| 35 ownership-constructor-unwind | 646cca038ed8 | ada6a3a62df1 | 20.98 / 42.20 s + exact unit 3.40 / 6.85 s |
| 36 ownership-worker-boxing | df5862861e71 | 646cca038ed8 | 24.61 / 49.42 s |
| 37 ownership-worker-preparation | 3b6bf091127c | df5862861e71 | 23.82 / 47.71 s |
| 38 ownership-loop-preparation | 7ae78137d444 | 3b6bf091127c | 26.30 / 52.71 s |
| 39 ownership-variant-preparation | f0049c4aabe0 | 7ae78137d444 | 19.77 / 39.78 s + exact unit 3.28 / 6.82 s |
| 40 ownership-constructor-types | c90fe5a9d170 | f0049c4aabe0 | 16.17 / 32.40 s + two exact units |
| 41 ownership-variant-conversion | 3956d5cadd86 | c90fe5a9d170 | 16.53 / 33.31 s + exact unit 3.31 / 7.05 s |
| 42 ownership-record-update | f22b5b587de6 | 3956d5cadd86 | 19.15 / 38.35 s + exact unit 3.59 / 7.44 s |
| 43 ownership-record-conversion | e2f944c256b6 | f22b5b587de6 | 18.02 / 36.18 s |
| 44 ownership-variant-alias | 610fd745b973 | e2f944c256b6 | 15.62 / 31.47 s |
| 45 ownership-match-context | 321cc3146089 | 610fd745b973 | 14.67 / 29.51 s |
| 46 ownership-field-context | 6d01e927c086 | 321cc3146089 | 14.06 / 28.50 s |
| 47 ownership-caf-cache | 762cc824fa08 | 6d01e927c086 | 21.58 / 43.40 s |
| 48 ownership-inline-caf | af073c78c443 | 762cc824fa08 | 16.28 / 33.20 s |
| 49 ownership-task-thunks | 427076c60d2c | af073c78c443 | 13.40 / 26.90 s + exact unit 3.58 / 7.29 s |
| 50 ownership-task-within | aa181f8f2c3a | 427076c60d2c | 15.44 / 31.48 s + exact unit 3.27 / 6.86 s |
| 51 ownership-task-scope | 28de1794f39f | aa181f8f2c3a | 14.91 / 29.90 s + exact unit 3.23 / 6.67 s |
| 52 ownership-task-handles | 4b6a2cb08da5 | 28de1794f39f | 22.60 / 46.01 s + exact unit 3.25 / 6.66 s |
| 53 ownership-channel-queues | ccbf2957f351 | 4b6a2cb08da5 | 18.97 / 38.17 s + exact unit 3.42 / 7.08 s |
| 54 ownership-library-results | 82f32b2cde03 | ccbf2957f351 | 8.09 / 17.77 s |
| 55 ownership-library-inputs | f240ecd56f3b | 82f32b2cde03 | 9.42 / 22.58 s |
| 56 ownership-library-unload | 878b25aad627 | f240ecd56f3b | 12.24 / 31.36 s |
| 57 ownership-opencl-lifetime | 5b6e65f365d6 | 878b25aad627 | 10.33 / 32.03 s |
| 58 ownership-interpreter-opencl | 00013d55d078 | 5b6e65f365d6 | 14.19 / 34.79 s |
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
| 112 ownership-grpc-connection-addresses | 762117573367 | 2bd17608388d | Formatting repaired; fresh remote evidence pending |

Rows21–109 have prior focused test/lint/format evidence at their recorded
heads; rows18–21 are merged. The current row22 refresh has unchanged runtime/
compiler source and inherits CLI/GC repairs, but its guard refused fresh local
checks. Its separate GitHub evidence CI37955579519 passes. Detailed commands,
full hashes, fixture failures and omission controls are in history. Every
production PR still requires six exact-head full gates; prepared is not merged.

Use actual bases above for final rebases, never OLD anchors or rewritten
predecessor heads. Preserve all ten root docs for conflict resolution. Row22
has final-rebased from dc85b679 onto actual PR99 squash c4d820e; row23 now rebases
from actualf71c002 after row22 merges. Preserve inherited CLI/GC harness fixes.
Rows77–78 require real WASI on Linux in both free modes; native bump checks
supply no WASI acceptance. Row20 boxed128-bit payloads remain shared. Network
context wrappers retain tracing compatibility; no complete ARC claim. Channel
close preserves queued values; explicit drain breaks its counted cycle, while
automatic unreachable-cycle reclamation remains unproved.

## Separate evidence and remaining audits

| Scope | Exact evidence head | Run / status |
|---|---|---|
| Row22 maps and handoff | c79544b74d30e6d285f64e0f500891434a2e91f7 | CI37955579519 passes; production source unchanged atf71c002 |
| Row23 reclamation and tracing | 7783afaef9a7431a40cf34b530c2c43386a06d0b | CI37958839569 queued; production495411d, actual basef71c002 |
| Row110 environment cache | 46aacfbb3f6bd5d0058aa0b6f60b2d030ff63944 | CI37948869170 passes focused Linux checks |
| Row111 packed TLS options | 823af3475560ed7709f958478580e364d89bdddf | CI37950759037 passes focused Linux checks |
| Row112 full connection addresses | 4dbd0dcedfc297f8f0859aca22142a55cc0dd79d | CI37958243461 queued after formatting repair7621175 |
| TLS/listener combined | 9bcae30119028b1870efb8fecfcf9746f5808acb | CI37730777345 all six pass |
| WASM/resource combined | 5fd2ed65385a23f3226b2bef02eb10196f51aeb4 | CI37771769436 all six pass, including required actual WASI |
| Row24 task boundaries | 5e4fd6fe2549da35374b11838af9845c066375be | CI37959126658 queued; production1741ab5, actual base495411d |
| Resource frames / stack binder | bf05481ac5c6e60c4e05872a241a2ff436cb457f | CI37798736754 all six pass |

Evidence workflows never enter production ancestry. Every sequential PR still
requires all six gates at its own current head. Preserve row85's repaired typed
whole-stack binder and nominal File disposal; row86's actual base97dca76 already
contains that repair. Failed and superseded logs remain in history.

Row111 verifies one TLS-option allocation, exact requested bytes, alignment,
copied inputs, last-owner release and allocation-failure cleanup. It makes no
elapsed-speed or whole-program tracing-free claim. Row110 verifies read-once
cache teardown after blocked tasks and finalizers; row111 changes selected
cache releases from ten malloc allocations to five. Row112's long-address
loopback/pool and requested-byte claims remain unverified pending fresh CI.

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

The fun-refactor guard is for the other repository. Previous shared target
belonged to /private/tmp/fwp-grpc-tls-pool-identity-worktree. The map clean
previously refused at61.84GiB free disk and138.93MiB target. Disk subsequently
recovered above64GiB (df71884308KiB available); unchanged guard allowed row23
package clean0.00/0.14s, focused tests9.89/20.19s, lint2.36/4.80s and
format0.34/0.61s. Shared target now belongs to
/private/tmp/fwp-task-boundary-worktree; no workload is running.
Stop at limits; do not bypass the guard, including for package clean.
Latest guarded doc audit passes eleven link/heading sets, all106 immutable
queue ancestry pairs and whole commit messages (0.23 s CPU / 1.68 s elapsed).
Command: `env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 scripts/local-guard.py python3 /private/tmp/fwp-check-handoff.py`.
The helper derives current/OLD queue heads; evidence runner
scripts/check-handoff-evidence.py verifies its published snapshot. Later doc
updates do not inherit a passing audit without checking their changed links/refs.

Preserve all ten current root docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre99; refresh all ten
immediately before updating main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
