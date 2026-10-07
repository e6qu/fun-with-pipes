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

Main is 3606f2c44499cfe8f51f3af4cbc85e1c7b5e4258 (#92). All six
CI37786675129 gates passed at bd7a20bfd83369e87ca9100c75503ab4ad73e8d5.
Whole squash message verified:
`Keep native reference counts exact beyond byte-sized metadata`.
#74–#92 deliver native macOS, ownership through optional synchronous list
results, isolated call effects and exact native counts beyond254. Phase1 is
done; phase2 remains incomplete; phases3–6 are pending.

Sole open [PR #93](https://github.com/e6qu/fun-with-pipes/pull/93):
ownership-list-order, /private/tmp/fwp-order-worktree, exact
d2e0e296888d5ca3577412f5a1687af1d4a494dd on actual main3606f2c.
CI37862207155: all six gates are running at this exact head. Both focused
tests pass10.26 s CPU /20.80 s elapsed, lint2.30 s /4.64 s, format0.34 s
/0.60 s. Source/runtime/tests/workflows match verified previous5fe5692 exactly.
Explicit raw interpreter oracles remain intact. Whole message is one line,
empty body. Squash only after all six pass, using subject
`Own sorted and unique list elements and release scratch buffers`, empty body,
matching this exact head. Then rebase row16 from ACTUAL base5fe5692 onto
its real squash; preserve OLD66bc713/parentc835578 and current root docs.

All nine root docs were preserved in /private/tmp/fwp-main-docs-pre92 before
main fast-forward and restored afterward. Original #91 main/head/message and
#92 focused checks are preserved in history; no current progress was discarded.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 15 ownership-list-order | d2e0e296888d, PR93 | 3606f2c44499 | 10.26 /20.80 s final |
| 16 ownership-sort-callbacks | 5c19337f216d | 5fe569218a4b | 12.54 /25.46 s |
| 17 ownership-state-sequences | 15743b853d6a | 5c19337f216d | 12.09 /24.23 s |
| 18 ownership-loop-state | 112f3c8de87b | 15743b853d6a | 19.08 /38.44 s |
| 19 ownership-list-structure | 6ce37fb180e1 | 112f3c8de87b | 16.10 /32.47 s |
| 20 ownership-list-generation | 7741d09dd8cf | 6ce37fb180e1 | 13.69 /27.47 s |
| 21 ownership-array-elements | 443524ef6b6d | 7741d09dd8cf | 14.23 /28.81 s |
| 22 ownership-map-set-elements | 1689c03ff621 | 443524ef6b6d | 14.98 /30.15 s |

Row 18 head 112f3c8 includes only doc changes after tested code 7af6961.
Row 20 full head 7741d09dd8cf214396e7938e07fbbd1f7263d9f7 is published
clean; all three tests, lint 2.48 s /4.89 s and format 0.43 s /0.83 s pass.
Repeated aliases and generated spines reclaim by counting; boxed128-bit numeric
payload representation remains shared. Do not claim numeric payload ownership.

Row 21 full head 443524ef6b6d5183f010899902a94a9d53c5dc55 is clean after
amend; all three tests, lint 2.51 s /4.99 s and format 0.33 s /0.60 s pass.
Preserve immutable OLD636414f/parentfad9b1a; later final rebase uses actual
current base 7741d09. Row 22 full head 1689c03ff621bb2ff41759f89b42e606dd738a2a is clean after
amend; all three tests, lint 2.33 s /4.67 s and format 0.34 s /0.61 s pass.
Preserve OLDa8a7d11/parent636414f; final rebase uses actual base443524e.
Current independent preparation is row23 old-value reclamation, rebased from
OLD parenta8a7d11 onto actual current row22 head1689c03 (temporary c4af7a9).
All three focused tests pass9.50 s CPU /19.72 s elapsed, lint4.59 s /9.15 s,
format0.91 s /1.77 s. It remains unpublished at c4af7a9; finish its docs
amend/publication next; PR93 is already open.
The full GC gate stays on CI.
Preserve OLD6774aa5 and record actual base1689c03 before publication.

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
belongs to /private/tmp/fwp-order-worktree; all final row15 focused checks pass; no local workload is active.
Run guarded cargo clean -p fwp before switching checkouts (last 0.00 /0.14 s).
Last guarded doc audit passes eleven link/heading sets, 82 immutable queue
ancestry pairs and whole commit messages (0.10 s CPU /0.71 s elapsed).
Rerun /private/tmp/fwp-check-handoff.py after meaningful doc changes.

Preserve all nine root docs before fast-forward/rebase conflict resolution:
PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre92; refresh all nine immediately before updating
main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
