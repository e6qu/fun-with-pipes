# Current work

**Next:** publish the preparation-counter repair and dispatch the four declared
array-consumption sessions. Audit every native control and raw result before
selecting the next performance change. Original timing limits remain unchanged.

## Branch and delivery

- Branch `array-consumption-diagnostics`, worktree
  `/private/tmp/fwp-array-consumption`, based on merged main `c43f05c2`.
  Preserve the primary checkout and other worktrees. Open one draft PR for this
  combined diagnostic, its regression controls, findings and plan updates.
- [PR #245](roadmap-history.md#direct-numeric-array-callbacks-pr-245) passed all
  nine production jobs and documentation at `d53fb07a`. All full job logs and
  target archives are audited, including 257 targets per Linux architecture.
  Squash `c43f05c22ed36277b491490b7d9e222dfd0af025` has the tested tree and the
  required one-line message, empty body and no trailers.
- Duplicate same-tree main runs `41471361931` / `41471361814` were cancelled.
- Keep one active PR. Final merge requires the nine exact-head production jobs
  and documentation, full log audits, an explicit subject of at most 80 characters
  and an empty squash body. Verify the resulting message and tree.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | [Retained sample analysis](measurements/array-sample-positions.md) replays both four-session datasets without removing failures |
| 2 | Implemented | [Preparation protocol and harness repair](measurements/array-consumption-setup.md); native controls must complete on both architectures |
| 3 | Pending | Four qualified-host sessions; no timing has started |
| 4 | Pending | Interpret preparation/copy/CPU observations without replacing original acceptance limits |
| 5 | Pending | Combined PR, exact-head full production/documentation gates, audit and squash merge |

## Frozen sources and first-run repair

- Protocol `5a581248`, tag `roadmap/array-consumption-protocol-2026-11-02`,
  predates implementation. Rebase retained the tag's original commit.
- First runner `275b1514badf544c48109821679b7aee72e272cf`, tag
  `roadmap/array-consumption-runner-2026-11-02`.
- Run `41467873605`: ARM64 jobs `125353433276` / `125353433200` failed before
  any warmup or timing. The harness expected 1,025 release checks, but the counter
  covers the reduction's 1,024 calls; final caller destruction uses a different
  function. Storage returned to zero. Fix the expectation, not runtime ownership.
- Both full logs and all 28 completed commands were audited. Artifacts
  `13153628638` / `13153659470` and retained
  [profiles/logs/identities](measurements/array-consumption-failures-2026-11-02/index.json)
  preserve the failure. Queued AMD64 jobs `125353432836` / `125353433506` were
  cancelled before starting; no completed timing was repeated.
- The repair preserves zero-live-storage and omitted-final-release controls and
  adds an assertion rejecting the extra incorrectly counted release.

## Checks and resource limits

Guarded checks pass: five harness tests (0.14s), both failed raw profile/command
replays (0.14s), all 48 retained C source variants (0.38s), Python syntax (0.13s),
actionlint (6.63s). Native diagnostic controls and independent full-data audits
still need to run. No local compiler build, full suite or benchmark.

Keep at least 64 GiB free disk, sampled workload RSS below 1 GiB and generated
target data below 2 GiB. Use `python3 scripts/local-guard.py` for focused work;
full workloads stay on GitHub. Last observed free space: about 65 GiB.
