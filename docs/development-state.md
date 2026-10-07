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

## Main and sole open PR

Main is 90762aacd7f469cf94ad54a90ebcaa4aec79829a (#93). All six
CI37862207155 gates passed at d2e0e296888d5ca3577412f5a1687af1d4a494dd.
Explicit match-head squash has verified whole message:
`Own sorted and unique list elements and release scratch buffers`.
#74–#93 deliver native macOS, selected ownership through ordered list results,
isolated call effects and exact native counts beyond254. Phase1 is done;
phase2 remains incomplete; phases3–6 are pending.

Sole open [PR #94](https://github.com/e6qu/fun-with-pipes/pull/94):
ownership-sort-callbacks, /private/tmp/fwp-sort-callback-worktree, exact
9f4e3bbc211cdc52229ba39429f9a2bc74d4d7df on actual main90762aa.
CI37897207787 passes bench and regular ARM macOS at this exact head;
the other four gates are running. Three focused tests pass12.30 s CPU /24.97 s elapsed, lint2.02 s
/4.06 s, format0.35 s /0.62 s. Source/runtime/tests/workflows match previously
verified5c19337 exactly; raw FWP_NO_OPT=1 interpreter oracles remain intact.
Whole subject is one line with empty body. Require all six passing gates
before explicit match-head squash with subject
`Borrow sort-by callbacks and reclaim typed keys and copied results`, empty body.
After its eventual merge, row17's ACTUAL current base remains5c19337;
rebase from that base onto its real squash, preserving OLD0a90b05/parent66bc713.

All nine root docs were preserved in /private/tmp/fwp-main-docs-pre93 before
main fast-forward and restored afterward. Prior main/heads/messages, failed
evidence and focused checks remain in history; no current progress was lost.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 16 ownership-sort-callbacks | 9f4e3bbc211c, PR94 | 90762aacd7f4 | 12.30 /24.97 s final |
| 17 ownership-state-sequences | 15743b853d6a | 5c19337f216d | 12.09 /24.23 s |
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

Rows17–30 are published preparations with passing focused tests, lint and
format checks; detailed commands, full hashes and measurements are in history.
Their final rebases use the actual bases above, never rewritten predecessor
heads or immutable OLD parents. Source/runtime changes were checked before
publication; each still needs its own six exact-head full gates. Row20 leaves
boxed128-bit payloads shared. Row26's native bump C fixture is not WASI evidence.

Row30 final head69b1ad1e33e5801a0c451c6b0f38ac4053849db1 is clean on
actual base8093bf3, published with exact lease against OLDb8f4c24. Six tests
pass22.29 s CPU /44.76 s elapsed, lint2.45 s /4.95 s, format0.34 s /0.61 s.
Current independent task: row31 zip-unwind rebased from OLDparentb8f4c24
onto actual row30 head69b1ad1 (temporarye1b9839). The new raw source
oracle sets FWP_NO_OPT=1; zip_unwind_ownership and zip_ownership tests
pass all four17.02 s CPU /34.21 s elapsed; lint2.39 s /4.85 s and
format0.35 s /0.62 s pass. Final amend/publication follow. Preserve
immutable OLD anchors; no additional PR.
PR94 remains the sole open delivery.

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
belongs to /private/tmp/fwp-zip-unwind-worktree; focused zip checks are complete; no local workload is active.
Run guarded cargo clean -p fwp before switching checkouts (last 0.00 /0.14 s).
Last guarded doc audit passes eleven link/heading sets, 82 immutable queue
ancestry pairs and whole commit messages (0.12 s CPU /0.84 s elapsed).
Rerun /private/tmp/fwp-check-handoff.py after meaningful doc changes.

Preserve all nine root docs before fast-forward/rebase conflict resolution:
PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre93; refresh all nine immediately before updating
main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
