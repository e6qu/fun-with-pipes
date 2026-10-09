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

Main is 2c1003cad114a544aa3f5ba7386b9a46dcb0dc47 (#97). All six
CI 37917260081 gates passed at 65fedd8d85430216539031553f88705ea72db5b4.
Explicit match-head squash at 2026-10-09T11:43:18Z verifies the entire one-line
message: `Own typed zip unzip and chunks results and release scratch storage`.
#74–#97 deliver native macOS and selected ownership through typed nested
zip/unzip/chunks, loop-state/Step/ABI wrappers and exact native wide counts.
Phase 1 is done; phase 2 remains incomplete; phases 3–6 are pending.

Sole open [PR #98](https://github.com/e6qu/fun-with-pipes/pull/98),
ownership-list-generation, /private/tmp/fwp-generation-worktree, exact
de969ee7161531406fecf1812e11ddb4ad03078c on actual main2c1003c.
Final rebase from ACTUAL prior base6ce37fb preserves source/runtime/generation tests/workflows exactly against7741d09.
Second commit542fc08 repairs only the CLI helper and adds its regression;
third commitde969ee repairs the tracing-only GC churn fixture. All ten current root docs resolve historical
conflicts. Three final tests pass13.79 / 27.85 s, focused lint2.38 / 4.68 s
and format0.34 / 0.60 s. Require all six exact-head jobs before squash with
`Own repeated aliases and generated numeric list nodes`, empty body.
Completed previous-main CI37916609315 at d174e73 fails Linux only:
cli::multi_command_program panics writing stdin with BrokenPipe. All other
five jobs pass; full logs /private/tmp/fwp-main96-failure.log. Legal add-all
case ignores supplied stdin and exits0. The helper must tolerate only closed
stdin and still assert exact child stdout/stderr/status. Repair in PR98 checkout passes focused multi-command23.59 / 47.48 s and
deterministic early-close0.18 / 0.73 s, final lint0.09 / 0.26 s and format
0.36 / 0.73 s. Repair published at542fc080e8818c26fb3da2ebbc295cd9fb864ee5. Require all six
new exact-head gates atde969ee; superseded37925910460 is confirmed cancelled to free runners. Old head6b1cd9b supplies no acceptance for the repair.
After merge, row21 ACTUAL refreshed base isde969ee7161531406fecf1812e11ddb4ad03078c;
rebase onto the real squash, preserving immutable OLD anchors. Later branches
prepared before CLI and collector-fixture fixes must inherit both on final
rebase; source comparisons against older preparations should allow these
explicitly inherited repairs.
Ten current docs were backed up and byte-verified in
/private/tmp/fwp-main-docs-pre97 before main fast-forward from d174e73 and
restored byte-for-byte afterward. Independent preparations through row104 are published with focused checks;
row21 is refreshed against the repaired delivery. Prior checks remain in history.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 18 ownership-loop-state | 03d25acc581a, merged #96 | 60e5d6216d0f | 18.66 / 37.70 s final + exact unit 3.15 / 6.61 s |
| 19 ownership-list-structure | 65fedd8d8543, merged #97 | d174e73fecb9 | 16.32 / 32.95 s final + exact unit 3.24 / 6.73 s |
| 20 ownership-list-generation | de969ee71615, PR98 | 2c1003cad114 | 13.79 / 27.85 s final |
| 21 ownership-array-elements | c8d4b57092e5 | de969ee71615 | 14.39 / 29.34 s |
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
Preparations through row104 are published with focused checks recorded in
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
focused lint2.47 / 5.05 s and format0.45 / 0.83 s pass; publish next.
Remaining audit: canonical decode and broader callback/context teardown. Prepared
work is not sequential full acceptance; phase2 remains incomplete.
Preserve all ten current docs before main refresh/rebase; OLD anchors stay immutable.
PR98 is the sole delivery atde969ee, full CI37936505408: bench passes;
ARM GC also passes; Linux, both Intel jobs and regular ARM macOS run.
Previous exact-head CI37929002304:
Completed CI37929002304: bench and all four ARM/Intel macOS jobs pass;
Linux fails gc::long_loop_runs_in_bounded_memory at tests/gc.rs194: zero
collections, while output/allocation assertions preceding it pass; RSS has not run.
Full log /private/tmp/fwp-pr98-linux-failure.log. Collector repair explicitly disables
FWP_FREE/FWP_REUSE for this tracing-only workload, preserving all assertions.
Focused GC lint passes2.32 / 4.59 s and format0.34 / 0.60 s; local execution
is skipped by /proc availability and is not verified support. Repair published
atde969ee7161531406fecf1812e11ddb4ad03078c; require six fresh gates.
Old five passes do not cover this repair.
Linux execution must pass on fresh exact-head CI; local macOS skips this test.
Superseded CI37925910460 at6b1cd9b supplies no new-head acceptance. Row21
ACTUAL refreshed base isde969ee; final rebase follows the eventual PR98 squash.

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
belongs to /private/tmp/fwp-grpc-connect-startup-worktree; startup tests run.
Run guarded cargo clean -p fwp before switching checkouts (last 0.07 / 0.36 s).
Last guarded doc audit passes eleven link/heading sets, 97 immutable queue
ancestry pairs and whole commit messages (0.21 s CPU / 1.45 s elapsed).
Rerun /private/tmp/fwp-check-handoff.py after meaningful doc changes.

Preserve all ten current root docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre97; refresh all ten
immediately before updating main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
