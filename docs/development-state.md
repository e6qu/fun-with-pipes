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

Main is 559f4acc3d279755c42be0e0fbc7de92348b9813 (#98). All six
CI37936505408 gates pass atde969ee7161531406fecf1812e11ddb4ad03078c.
Explicit match-head squash at2026-10-09T14:25:51Z verifies the entire one-line
message: `Own repeated aliases and generated numeric list nodes`.
#74–#98 deliver native macOS and selected ownership through typed repeat/range,
zip/unzip/chunks, loop-state/Step/ABI wrappers and exact native wide counts.
Phase1 is done; phase2 remains incomplete; phases3–6 are pending.

Open delivery PR99: https://github.com/e6qu/fun-with-pipes/pull/99
ownership-array-elements, /private/tmp/fwp-array-element-worktree, exact head
 dc85b679407a7adda1438989051ca7eaf70072e5 on actual main559f4acc.
Final source/runtime/tests/workflows match prior c8d4b57 exactly, including
inherited CLI/GC repairs. Array tests pass 14.57 / 29.32 s CPU / elapsed;
focused lint passes 2.44 / 4.83 s; formatting passes 0.33 / 0.60 s.
Published with explicit lease; require six new exact-head gates.
After passing CI, squash with `Own typed array elements across copies updates and callbacks`
and empty body, then continue row22. Row22 ACTUAL base remains443524e until
its own refresh; never replace immutable OLD anchors.

Later preparations must inherit both CLI early-stdin-close and tracing-fixture
repairs on final rebases. The repaired Linux gate actually verifies the
collector churn output, allocation/collection thresholds and RSS bound.
Ten authoritative docs backed up to/private/tmp/fwp-main-docs-pre98 were
restored byte-for-byte after main fast-forward2c1003c→559f4ac. Preparations
through107 are published; PR99 CI37945913789 is queued at exact dc85b679.
Prior delivery checks and failures remain in history.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 18 ownership-loop-state | 03d25acc581a, merged #96 | 60e5d6216d0f | 18.66 / 37.70 s final + exact unit 3.15 / 6.61 s |
| 19 ownership-list-structure | 65fedd8d8543, merged #97 | d174e73fecb9 | 16.32 / 32.95 s final + exact unit 3.24 / 6.73 s |
| 20 ownership-list-generation | de969ee71615, merged #98 | 2c1003cad114 | 13.79 / 27.85 s final |
| 21 ownership-array-elements | dc85b679407a, PR99 | 559f4acc3d27 | 14.57 / 29.32 s final |
| 22 ownership-map-set-elements | 1689c03ff621 | 443524ef6b6d | 14.98 / 30.15 s |
| 23 ownership-old-reclamation | f4716a027a1b | 1689c03ff621 | 9.50 / 19.72 s |
| 24 ownership-task-boundaries | cde58f461f78 | f4716a027a1b | 9.51 / 19.21 s |
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

Rows 18–99 are published preparations with passing focused tests, lint and
format checks; detailed commands, full hashes and measurements are in history.
Their final rebases use the actual bases above, never rewritten predecessor
heads or immutable OLD parents. Source/runtime changes were checked before
publication; each still needs its own six exact-head full gates. Row20 leaves
boxed128-bit payloads shared. Row26's native bump C fixture is not WASI evidence.

Rows77–78 require actual WASI on Linux CI, in both free modes. Their native
host bump-C checks supply no actual WASI acceptance; physical bump storage
remains allocated. Prepared layout/allocation controls establish no speed claim.
Rows85–91 source/control details and full hashes are archived in history;
the table above keeps actual bases and focused checks. Row91 uses unwind
ownership for the temporary HTTP/2 subject copy; no additional PR.
Rows92–93 publish explicit peer owners through child/detached-sender joins
and owned final statuses through encoding/unwind. Their table entries and
history retain full heads, commands, failures and omission controls. Network
context storage and other buffers still use tracing; no complete ARC claim.
Rows94–96 publish unary receive, streaming force and rendered-error scratch
cleanup with unchanged bytes, diagnostics and memo behavior. Full preparation
hashes and detailed checks are in history; the table keeps actual bases.
Preparations through row106 are published with focused checks recorded in
[history](roadmap-history.md). Row21 is published atc8d4b57092e54fe292ccc04dc0b813652fdc2617.
Rebase to PR98 headde969ee completed from ACTUAL542fc08, inheriting the
collector fixture repair. Three array tests pass14.39 / 29.34 s; focused
lint2.48 / 4.88 s and format0.34 / 0.60 s pass; published without a PR. Preserve inherited CLI/GC harness fixes in source comparisons.
Independent row103 ownership-grpc-client-receive starts on33661b2,
/private/tmp/fwp-grpc-client-receive-worktree. Client first/next receives scope
dequeued messages, status text and decoder why strings across retry, errors
and cancellation. Failure-text transfer clears the old owner before raising.
All three focused receive/failure/request tests pass13.79 / 27.82 s;
lint2.54 / 5.14 s and format0.45 / 0.82 s pass. Published clean at
c48864ce72313d5aff87aca59f768023e17dbd26, no competing PR.
Independent row104 ownership-grpc-connect-cleanup starts on c48864c,
/private/tmp/fwp-grpc-connect-cleanup-worktree. Existing connect-owner cleanup
now protects gRPC socket/address resources, with an SSL scope through
handshake and until transfer to the connection. Real loopback cancellation,
refusal and handoff checks pass9.33 / 20.92 s; background startup is injected
in the fixture. Lint2.54 / 5.15 s and format0.45 / 0.83 s pass. Published at
b244d5f7c423edffc9159b1dd1a7fdac1934727a, no competing PR.
Independent row105 ownership-grpc-connect-startup starts on b244d5f,
/private/tmp/fwp-grpc-connect-startup-worktree. Temporary startup owner and
per-task reservations protect both background spawn boundaries. Abort marks
unpublished context dead without allocating, cancels any reader/writer and
releases owners; its static marker is excluded from malloc finalization.
Both actual-task/failure and pending-connect tests pass6.11 / 12.61 s;
focused lint2.47 / 5.05 s and format0.45 / 0.83 s pass. Published clean at
cb20833c018f8af3cd6bfb13bdb7696c503b7c6a, no competing PR.
Independent row106 ownership-grpc-context-restore starts oncb20833,
/private/tmp/fwp-grpc-context-restore-worktree. Existing cleanup stack now
restores dynamic gctx on raw trap/cancellation as well as normal/typed return.
Handler restoration remains in existing catch boundaries; cleanup changes only
the saved context pointer. Both focused context/failure-text tests pass8.46 / 18.21 s;
nested normal/typed/raw/cancel restoration and omission control pass.
Focused lint2.48 / 4.94 s and final format0.45 / 0.82 s pass. Published clean
at7a89dd017ae49f1a7deae49745e15ee807f46b2d, no competing PR.
Independent row107 ownership-grpc-context-resources starts on7a89dd0,
/private/tmp/fwp-grpc-context-resources-worktree. Scoped TLS options gain
checked users held by dynamic callbacks and original inheriting task contexts.
Task preparation reserves/rolls back context owners; completion drops them
after child joins. Context hooks/one private pointer are emitted only for
services/web programs. Environment options preserve read-once cache lifetime.
All three context/resources/task-handle tests pass7.45 / 16.78 s, including
escaped/detached/cancelled/failed-prepare and overflow owner checks.
Focused lint2.68 / 5.39 s and format0.45 / 0.83 s pass; published at
ea18e54f0eeeee5ec470d44e770d31d3f42456af with actual base7a89dd0.
Independent row108 ownership-grpc-capture-resources starts on ea18e54,
/private/tmp/fwp-grpc-capture-resources-worktree. Response captures now reserve
constructor/scope/task owners; metadata snapshots survive later child appends.
Both TLS/capture counters validate before either increments; new TLS options
retain a constructor cleanup while inherited capture acquisition can trap.
All three capture/resources/restore tests pass11.62 / 25.50 s CPU / elapsed;
added combined-counter/TLS-constructor rollback regression passes2.08 / 5.20 s.
Final lint passes0.07 / 0.26 s. Final formatting passes0.46 / 0.86 s; publication follows.
Remaining audit: complete TLS pool identity, cache teardown and canonical decode. Prepared
work is not sequential full acceptance; phase2 remains incomplete.
Preserve all ten current docs before main refresh/rebase; OLD anchors stay immutable.
PR98 acceptance and its repaired collector fixture are recorded above; superseded
failures and logs remain in history. The next delivery is row21 on actual main
559f4ac; row22 retains actual base443524e until its own final refresh.

## Repaired resource evidence

Current separate evidence: ownership-evidence-resource-frames,
/private/tmp/fwp-resource-evidence-worktree, exact
bf05481ac5c6e60c4e05872a241a2ff436cb457f, CI 37798736754: all six gates pass at this exact head. It includes
rows 79–88 plus the required stack_match_ownership regression. No evidence PR.
Evidence workflows and baseline repairs never enter production ancestry.

Previous ee4bd2238e078238cf1a0867e1c891cbf3170279 /CI 37780278972 passes
bench and fails all five other gates (HTTP, REST/TLS/web and native std).
A whole pattern binder retained only the outer pointer of a stack aggregate,
while its newly typed scrutinee dropped child owners. Propagating those typed
children into the binder repairs Dup/Drop and preserves nominal File disposal.
Omission control, raw interpreter agreement, O1/O2, related resource tests and
exact HTTP golden in four GC-off/on poison modes pass. The repaired full gates pass; each sequential production PR still needs
its own exact-head gates. [Repair details](roadmap-history.md#resource-evidence-http-ownership-repair-2026-10-08)
retain failed logs, commands, controls and measurements.

Production row85 repair is refreshed above, preserving the whole-stack binder
regression and nominal File ownership. Row86 now inherits the stack repair on actual97dca76; its next final
rebase must preserve that repair without replaying it. OLD anchors stay unchanged.
Rows 79–88 are prepared, not delivered. Channel close preserves queued values;
explicit drain breaks its counted cycle; automatic cycle reclamation is unproved.

Earlier combined evidence passed all six: TLS/listener 9bcae30119028b1870efb8fecfcf9746f5808acb,
CI 37730777345; WASM/resource 5fd2ed65385a23f3226b2bef02eb10196f51aeb4,
CI 37771769436 (required actual WASI/File stage, both free modes).
Each production PR still needs its own exact-head gates. Baseline root/cache/
tutorial/boxing, WASI fstat, binary reads and listener/constructor control
repairs are preserved in history; failed runs supply no acceptance.

## Local limits and durable docs

Full builds/tests, benchmarks and large regeneration run on GitHub. Focused
local work is serial and low priority: sampled aggregate RSS below 1 GiB,
target below 2 GiB, free disk at least 64 GiB, deadline 180 seconds. Stop at
limits and move work to CI; never raise or bypass them. Use:

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

The fun-refactor guard is for the other repository. Shared target currently
belongs to /private/tmp/fwp-array-element-worktree; final array tests run.
Run guarded cargo clean -p fwp before switching checkouts (last 0.07 / 0.37 s).
Last guarded doc audit passes eleven link/heading sets, 99 immutable queue
ancestry pairs and whole commit messages (0.20 s CPU / 1.44 s elapsed).
Rerun /private/tmp/fwp-check-handoff.py after meaningful doc changes.

Preserve all ten current root docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre98; refresh all ten
immediately before updating main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
