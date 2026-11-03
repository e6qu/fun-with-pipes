# Current work

**Next:** publish the completed direct-array-call report in
[PR #253](https://github.com/e6qu/fun-with-pipes/pull/253), mark it ready, and monitor
its exact final head through nine production jobs plus documentation. Audit every
full/target log before the authorized one-line squash; verify the merge tree.
Keep missed timing goals open. Select the next storage change only after declaring
its proof, scope and measurement; the review below does not select an implementation.

## Checkout and sources

- Worktree/branch: `.worktrees/direct-array-callbacks` / `direct-array-callbacks`.
  Scratch: `.worktrees/gradient-work`. Leave the detached primary checkout's
  recovery edits alone.
- Frozen contract: `776e8d98`, tag
  `roadmap/direct-array-callbacks-protocol-2026-11-03`, before implementation.
- Frozen measurements: `e649da78c41dab8fa6f191d7670b1efba79811b0`, tag
  `roadmap/scalar-array-map-measurement-2026-11-03`. Compiler/runtime/library/test
  trees equal focused-tested `5e921fb8517d59cfa0ef452c2c2264ffa00be325` and current
  implementation. Rebase changed working-branch commit IDs, not frozen tags.
- Parent PR #252 merged as `3034a9d047c2bef44744c6ffc1807146570ced57`; its tree
  equals tested `e2d55aa8`. All ten gates and the one-line squash are verified,
  with [full gate records](measurements/gradient-array-storage-2026-11-03/platforms/final-gates.json).
  Duplicate same-tree main run `41652287872` was cancelled with no failed steps.

## Roadmap status

[The contract](measurements/direct-array-callbacks.md) selects closed ordinary-scalar
array callbacks. It changes no layout, API or language syntax. [The runtime report](measurements/direct-array-time-2026-11-03/README.md)
separates verified work reductions, unchanged storage counts and unresolved limits.
The [storage review](measurements/remaining-gradient-storage.md) records same-type
conversions, boxed inputs and unused history; those candidates remain unselected.

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve the pre-implementation scope and limits |
| 2 | Verified | Three native hosts; all targets, selection checks, images and cleanup audited |
| 3 | Verified | Four original sessions audited; 16 speed misses and one noise failure stay open |
| 4 | In progress | Final nine production jobs plus docs, complete log audit and verified squash |

## Completed evidence

- [Focused native checks](measurements/direct-array-callbacks-2026-11-03/README.md):
  run `41646433358`, GCC ARM64/AMD64 and Clang ARM64. Each passes 40 tests,
  24 selections, eight semantic executions and ten cleanup observations. All
  762 native images and full/target logs audited. Both earlier repaired attempts
  remain recorded: an escaped-C-brace compile failure and a main-only/export-root
  inspection error.
- [Compiler costs](measurements/direct-array-analysis-2026-11-03/README.md):
  run `41649281445`; all 480 observations audited. Maximum elapsed increase
  0.688%, peak RSS increase 0.185%, identical-copy difference 1.288%.
- Original runtime runs: ARM64 1/2 `41649285227`; AMD64 1 `41654861200`;
  AMD64 2 `41655262486`. All completed; none was repeated for a better result.
- [Reference recovery](measurements/direct-array-callbacks-2026-11-03/evidence-repair/README.md):
  the upload condition omitted the new directory. Ordinary audit `41654788718`
  failed correctly. Tooling `80b5f93e` rebuilt the frozen references and required
  every recorded compiler/source/patch hash to match. Recovery runs `41656720253`,
  `41658007799`, `41658488279` all pass. Every original log and all 5,336 raw-file
  records reconcile; reconstructed artifacts are explicitly identified.
- Four-session outcomes: larger cases improve 4.8–5.2% on ARM64 and 5.5–8.1%
  on AMD64. Sixteen required 5% gains fail. AMD64 session 2's 3/1 current has
  3.53% identical-copy variation against 2%; that comparison is inconclusive.
  All 48 managed/raw profiles match reference, including disabled workspace.
  AMD64 current-only RSS observations rise 6–14%. Frame growth ≤64 bytes.
- [Seven host rejections](measurements/direct-array-time-2026-11-03/rejected-hosts/index.json)
  occurred before building/timing. Six EPYC 9V74 and one 9V45 did not match 7763.
- Draft docs `41655295706` exposed a stale collection count: four map tests were
  present, but the inventory expected three. Producer and controls now require
  four (59 tests across collection targets). Repaired docs `41656730058` pass;
  all diagnostics audited. Historical benchmark wording now correctly says both
  forms print only the final vector; the history form retains intermediates.

## Local checks and limits

Run focused checks serially through `python3 scripts/local-guard.py`. Full builds,
full suites, benchmarks and large regeneration stay on GitHub. Preserve 64 GiB
free disk, target data <2 GiB, sampled RSS <1 GiB and the 180-second deadline.
Last free space about 77 GiB; no local compiler build is running.

Passing repair checks: recovery controls 2 (0.25s), collection controls 8 (0.26s),
source/patch/binary controls 15 (19.30s), retention controls 3 (0.13s), workflow
lint after selector cleanup (6.30s). Earlier reference, budget, grouping and
native checks remain linked above; no implementation changed afterward.

Scratch collection is complete. `collect-direct-runtime.py` independently audited
ARM/AMD1/AMD2 summaries and full logs in 5.86s/5.97s/5.74s.
`retain-direct-time.py` reconciled four sessions (0.50s);
`summarize-direct-memory.py` checked all 48 complete memory-profile pairs (0.25s).
Those outputs and seven host-rejection records are already retained; do not rerun
helpers whose output directory must be empty. The measured compiler is frozen.
