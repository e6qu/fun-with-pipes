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

Main is60e5d6216d0f01306b457f65c00807df7d932cb1 (#95). All six
CI37901758334 gates passed at5d0a3f302e476dfada1b3ea71aa56dae4086d905.
Explicit match-head squash has verified whole one-line message:
`Own scan and iterate states while borrowing synchronous callbacks`.
#74–#95 deliver native macOS, selected ownership through scan/iterate states,
isolated call effects and exact native counts beyond254. Phase1 is done;
phase2 remains incomplete; phases3–6 are pending.

No open PR while preparing row18 loop-state ownership. Rebase its ACTUAL
current base15743b853d6a190a53ea4a95532eb9845b4c685a onto actual main60e5d62,
nine authoritative doc conflicts resolved. Source/runtime/tests/workflows
exactly match verified112f3c8; doc-only follow-up becomes empty. Final
five loop tests pass18.66 /37.70 s, exact unit3.15 /6.61 s, lint2.30 /4.69 s
and format0.33 /0.60 s. Final docs and exact-lease publication follow
against112f3c8, followed by only the next PR.
Require six exact-head full gates before squash.

All nine root docs were preserved in /private/tmp/fwp-main-docs-pre95 before
main fast-forward from1358267 and restored afterward. Current independent
row55 C input preparation is in doc conflicts; finish after row18 publication.
Prior main/heads/messages, failed evidence and focused checks remain in history.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 18 ownership-loop-state | 112f3c8de87b | 15743b853d6a | 19.08 /38.44 s |
| 19 ownership-list-structure | 6ce37fb180e1 | 112f3c8de87b | 16.10 /32.47 s |
| 20 ownership-list-generation | 7741d09dd8cf | 6ce37fb180e1 | 13.69 /27.47 s |
| 21 ownership-array-elements | 443524ef6b6d | 7741d09dd8cf | 14.23 /28.81 s |
| 22 ownership-map-set-elements | 1689c03ff621 | 443524ef6b6d | 14.98 /30.15 s |
| 23 ownership-old-reclamation | f4716a027a1b | 1689c03ff621 | 9.50 /19.72 s |
| 24 ownership-task-boundaries | cde58f461f78 | f4716a027a1b | 9.51 /19.21 s |
| 25 ownership-unwind-runtime | 123d8b5928aa | cde58f461f78 | 8.80 /17.94 s |
| 26 ownership-reuse-tokens | 216e673ff2dd | 123d8b5928aa | 15.26 /30.66 s |
| 27 ownership-call-liveness | 786f1700236e | 216e673ff2dd | 19.89 /39.90 s |
| 28 ownership-runtime-call-cleanup | e3c49d965cd0 | 786f1700236e | 15.73 /31.57 s |
| 29 ownership-map-unwind | 8093bf382210 | e3c49d965cd0 | 16.12 /32.46 s |
| 30 ownership-selection-unwind | 69b1ad1e33e5 | 8093bf382210 | 22.29 /44.76 s |
| 31 ownership-zip-unwind | 6a0913896eb7 | 69b1ad1e33e5 | 17.02 /34.21 s |
| 32 ownership-fold-unwind | 1e8d1e34bc78 | 6a0913896eb7 | 24.13 /48.48 s |
| 33 ownership-loop-unwind | dc9bfd5e626b | 1e8d1e34bc78 | 28.65 /57.61 s |
| 34 ownership-argument-preparation | ada6a3a62df1 | dc9bfd5e626b | 24.82 /49.89 s |
| 35 ownership-constructor-unwind | 646cca038ed8 | ada6a3a62df1 | 20.98 /42.20 s + exact unit3.40 /6.85 s |
| 36 ownership-worker-boxing | df5862861e71 | 646cca038ed8 | 24.61 /49.42 s |
| 37 ownership-worker-preparation | 3b6bf091127c | df5862861e71 | 23.82 /47.71 s |
| 38 ownership-loop-preparation | 7ae78137d444 | 3b6bf091127c | 26.30 /52.71 s |
| 39 ownership-variant-preparation | f0049c4aabe0 | 7ae78137d444 | 19.77 /39.78 s + exact unit3.28 /6.82 s |
| 40 ownership-constructor-types | c90fe5a9d170 | f0049c4aabe0 | 16.17 /32.40 s + two exact units |
| 41 ownership-variant-conversion | 3956d5cadd86 | c90fe5a9d170 | 16.53 /33.31 s + exact unit3.31 /7.05 s |
| 42 ownership-record-update | f22b5b587de6 | 3956d5cadd86 | 19.15 /38.35 s + exact unit3.59 /7.44 s |
| 43 ownership-record-conversion | e2f944c256b6 | f22b5b587de6 | 18.02 /36.18 s |
| 44 ownership-variant-alias | 610fd745b973 | e2f944c256b6 | 15.62 /31.47 s |
| 45 ownership-match-context | 321cc3146089 | 610fd745b973 | 14.67 /29.51 s |
| 46 ownership-field-context | 6d01e927c086 | 321cc3146089 | 14.06 /28.50 s |
| 47 ownership-caf-cache | 762cc824fa08 | 6d01e927c086 | 21.58 /43.40 s |
| 48 ownership-inline-caf | af073c78c443 | 762cc824fa08 | 16.28 /33.20 s |
| 49 ownership-task-thunks | 427076c60d2c | af073c78c443 | 13.40 /26.90 s + exact unit3.58 /7.29 s |
| 50 ownership-task-within | aa181f8f2c3a | 427076c60d2c | 15.44 /31.48 s + exact unit3.27 /6.86 s |
| 51 ownership-task-scope | 28de1794f39f | aa181f8f2c3a | 14.91 /29.90 s + exact unit3.23 /6.67 s |
| 52 ownership-task-handles | 4b6a2cb08da5 | 28de1794f39f | 22.60 /46.01 s + exact unit3.25 /6.66 s |
| 53 ownership-channel-queues | ccbf2957f351 | 4b6a2cb08da5 | 18.97 /38.17 s + exact unit3.42 /7.08 s |
| 54 ownership-library-results | 82f32b2cde03 | ccbf2957f351 | 8.09 /17.77 s |

Rows18–54 are published preparations with passing focused tests, lint and
format checks; detailed commands, full hashes and measurements are in history.
Their final rebases use the actual bases above, never rewritten predecessor
heads or immutable OLD parents. Source/runtime changes were checked before
publication; each still needs its own six exact-head full gates. Row20 leaves
boxed128-bit payloads shared. Row26's native bump C fixture is not WASI evidence.

Row54 library-results82f32b2cde036be328c769e5dcdee701ea67713a is clean
on actual baseccbf295, published with exact lease against OLD5b34382.
One focused test passes8.09 /17.77 s, lint2.28 /4.61 s, format0.34 /0.60 s.
Next independent task: row55 copied C inputs rebases from ACTUAL old
parent5b34382 onto current row54 head82f32b2, then checks/publication.
Preserve immutable OLD anchors; no additional PR.
PR95 merged after all six gates; row18 final rebase is the next delivery.

## Repaired resource evidence

Current separate evidence: ownership-evidence-resource-frames,
/private/tmp/fwp-resource-evidence-worktree, exact
bf05481ac5c6e60c4e05872a241a2ff436cb457f, CI37798736754: all six gates pass at this exact head. It includes
rows 79–88 plus the required stack_match_ownership regression. No evidence PR.
Evidence workflows and baseline repairs never enter production ancestry.

Previous ee4bd2238e078238cf1a0867e1c891cbf3170279 /CI37780278972 passes
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
CI37730777345; WASM/resource 5fd2ed65385a23f3226b2bef02eb10196f51aeb4,
CI37771769436 (required actual WASI/File stage, both free modes).
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
belongs to /private/tmp/fwp-loop-worktree; final loop checks are complete; no local workload is active.
Run guarded cargo clean -p fwp before switching checkouts (last 0.00 /0.13 s).
Last guarded doc audit passes eleven link/heading sets, 82 immutable queue
ancestry pairs and whole commit messages (0.13 s CPU /0.94 s elapsed).
Rerun /private/tmp/fwp-check-handoff.py after meaningful doc changes.

Preserve all nine root docs before fast-forward/rebase conflict resolution:
PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre95; refresh all nine immediately before updating
main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
