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

Main is d174e73fecb96cb5aef85fa20eb8471a48dc0948 (#96). All six
CI37909273494 gates passed at 03d25acc581a69c1a16f0add88e4768777072683.
Explicit match-head squash verifies the whole one-line message:
`Transfer owned loop states and reclaim typed Step and ABI payloads`.
#74–#96 deliver native macOS and selected ownership through loop-state/Step/ABI
wrappers, separate call effects and exact native wide counts. Phase 1 is done;
phase 2 remains incomplete; phases 3–6 are pending.

No PR is open. Next delivery is queue19 ownership-list-structure,
/private/tmp/fwp-structure-worktree, final-rebased on actual main d174e73 (resolve the branch head before publication).
Rebased from ACTUAL prior base 112f3c8de87beddab2374f51e19d6dc94846919d;
source/runtime/tests/workflows exactly match verified previous 6ce37fb.
Four final structural ownership tests pass 16.32 / 32.95 s. Exact contract unit
passes 3.24 / 6.73 s; lint passes 2.29 / 4.59 s and format 0.34 / 0.60 s.
Final docs and exact-lease publication follow; six full gates run only on GitHub.
Preserve all ten root docs, verify tested feature source, rerun focused checks,
exact-lease publication against 6ce37fb, then open the sole next PR.

Ten current docs were byte-verified in /private/tmp/fwp-main-docs-pre96 before
main fast-forward from 60e5d62 and restored afterward. Independent preparations
through row75 are published with focused checks. The next independent task
is row76 borrowed File roots.
Prior main/heads/messages, failed evidence and focused checks remain in history.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 18 ownership-loop-state | 03d25acc581a, merged #96 | 60e5d6216d0f | 18.66 / 37.70 s final + exact unit 3.15 / 6.61 s |
| 19 ownership-list-structure | 6ce37fb180e1 | 112f3c8de87b | 16.10 / 32.47 s |
| 20 ownership-list-generation | 7741d09dd8cf | 6ce37fb180e1 | 13.69 / 27.47 s |
| 21 ownership-array-elements | 443524ef6b6d | 7741d09dd8cf | 14.23 / 28.81 s |
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

Rows 18–75 are published preparations with passing focused tests, lint and
format checks; detailed commands, full hashes and measurements are in history.
Their final rebases use the actual bases above, never rewritten predecessor
heads or immutable OLD parents. Source/runtime changes were checked before
publication; each still needs its own six exact-head full gates. Row20 leaves
boxed128-bit payloads shared. Row26's native bump C fixture is not WASI evidence.

Row75 mandatory original-frame release is published clean at
db3bcf0da8d6dbb5c5b4c4f4781c544fa622cbc0 on actual base 4b5da4a.
Five tests pass 22.99 / 46.22 s, lint 2.59 / 5.18 s, format 0.44 / 0.84 s.
Source opens/discards respect descriptor bounds without GC and with reuse/free
disabled. Original parameter lifetimes and owned aliases remain preserved.
Independent row76 rebases from ACTUAL old parent 923ad4a onto current row75 head db3bcf0.
Preserve all ten current docs before main refresh or rebase; OLD anchors stay immutable.
Delivery row19 now final-rebases from ACTUAL112f3c8 onto main d174e73 before sole next PR.

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

Production row 85 repair is published clean as
872372452a1071db124f8e4cc8ae16027cc8f337, following immutable OLD3a0cbdb.
Its five focused tests pass 16.71 s /36.11 s, lint 2.45 s /4.96 s, format
0.45 s /0.86 s. Row 86 actual base remains 3a0cbdb; do not replay this fix
when rebasing row 86 onto row 85's eventual squash. OLD anchors stay unchanged.
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
belongs to /private/tmp/fwp-structure-worktree; row19 tests/lint complete; no local workload is active.
Run guarded cargo clean -p fwp before switching checkouts (last 0.05 / 0.37 s).
Last guarded doc audit passes eleven link/heading sets, 82 immutable queue
ancestry pairs and whole commit messages (0.14 s CPU / 1.04 s elapsed).
Rerun /private/tmp/fwp-check-handoff.py after meaningful doc changes.

Preserve all ten current root docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre96; refresh all ten
immediately before updating main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
