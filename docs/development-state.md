# Session handoff

Updated 2026-10-08. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
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

Main is 3c0685c34f9808db82ef9a9b151a6fcfb8eddb47 (#91). All six
CI37774239006 gates passed at 7018086b8f9851f576350ba24e8af5041c3bb594.
Whole squash message verified: `Keep call effect contexts separate from pure callback types`.
#74–#91 deliver native macOS and ownership through synchronous optional list
results. Phase 1 is done; phase 2 remains incomplete; phases 3–6 are pending.

Sole open [PR #92](https://github.com/e6qu/fun-with-pipes/pull/92):
ownership-wide-counts, /private/tmp/fwp-wide-worktree, exact
bd7a20bfd83369e87ca9100c75503ab4ad73e8d5 on actual main 3c0685c.
CI37786675129 passes Linux, bench and both dedicated macOS GC gates; both
regular macOS gates are running. Final sharing check passes 7.16 s CPU /15.00 s
elapsed; all three unfiltered wide_counts tests pass 7.28 s /14.80 s; format
0.33 s /0.60 s. The initial filtered call ran zero wide tests; the separate
unfiltered rerun supplies coverage. Source matches verified cb0d7e6.

After all six pass, squash with subject
`Keep native reference counts exact beyond byte-sized metadata`, empty body,
matching the exact head. Preserve all nine live docs before updating main.
Then rebase row 15 from actual base cb0d7e6 onto the real #92 squash,
check it, refresh docs, publish and open the sole next PR. Do not rebase from
OLD3a791 or newer bd7a20b: neither is row 15's actual current base.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 14 ownership-wide-counts | bd7a20bfd833, PR92 | 3c0685c34f98 | 7.28 /14.80 s final wide tests |
| 15 ownership-list-order | 5fe569218a4b | cb0d7e6db7e5 | 11.16 /22.44 s |
| 16 ownership-sort-callbacks | 5c19337f216d | 5fe569218a4b | 12.54 /25.46 s |
| 17 ownership-state-sequences | 15743b853d6a | 5c19337f216d | 12.09 /24.23 s |
| 18 ownership-loop-state | 112f3c8de87b | 15743b853d6a | 19.08 /38.44 s |
| 19 ownership-list-structure | 6ce37fb180e1 | 112f3c8de87b | 16.10 /32.47 s |
| 20 ownership-list-generation | 7741d09dd8cf | 6ce37fb180e1 | 13.69 /27.47 s |

Row 18 head 112f3c8 includes only doc changes after tested code 7af6961.
Row 20 full head 7741d09dd8cf214396e7938e07fbbd1f7263d9f7 is published
clean; all three tests, lint 2.48 s /4.89 s and format 0.43 s /0.83 s pass.
Repeated aliases and generated spines reclaim by counting; boxed128-bit numeric
payload representation remains shared. Do not claim numeric payload ownership.

Current independent work: row 21 ownership-array-elements is rebased from
OLD parent fad9b1a onto current row 20 head 7741d09 (temporary da904ea).
Both source oracles now explicitly use FWP_NO_OPT=1; all three focused tests
pass 14.23 s CPU /28.81 s elapsed. Lint 2.51 s /4.99 s and format 0.33 s /0.60 s pass; publish without
opening another PR.
Its later final rebase must use actual base 7741d09; preserve OLD636414f.
Worktree paths are in the queue/history.

## Repaired resource evidence

Current separate evidence: ownership-evidence-resource-frames,
/private/tmp/fwp-resource-evidence-worktree, exact
bf05481ac5c6e60c4e05872a241a2ff436cb457f, CI37798736754 queued. It includes
rows 79–88 plus the required stack_match_ownership regression. No evidence PR.
Evidence workflows and baseline repairs never enter production ancestry.

Previous ee4bd2238e078238cf1a0867e1c891cbf3170279 /CI37780278972 passes
bench and fails all five other gates (HTTP, REST/TLS/web and native std).
A whole pattern binder retained only the outer pointer of a stack aggregate,
while its newly typed scrutinee dropped child owners. Propagating those typed
children into the binder repairs Dup/Drop and preserves nominal File disposal.
Omission control, raw interpreter agreement, O1/O2, related resource tests and
exact HTTP golden in four GC-off/on poison modes pass. Full repaired gates
remain required. [Repair details](roadmap-history.md#resource-evidence-http-ownership-repair-2026-10-08)
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
belongs to /private/tmp/fwp-array-element-worktree; all focused array checks pass; no local workload is active.
Run guarded cargo clean -p fwp before switching checkouts (last 0.05 /0.25 s).
Last guarded doc audit passes eleven link/heading sets, 82 immutable queue
ancestry pairs and whole commit messages (0.10 s CPU /0.71 s elapsed).
Rerun /private/tmp/fwp-check-handoff.py after meaningful doc changes.

Preserve all nine root docs before fast-forward/rebase conflict resolution:
PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md and docs/concurrency.md. Latest snapshot is
/private/tmp/fwp-main-docs-pre91; refresh all nine immediately before updating
main. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.
