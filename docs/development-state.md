# Current work

**Next:** finish and audit #254's Intel macOS ownership retry, then squash the
verified head. Final-iteration measurements and raw audits are complete. Reconcile
that branch onto the verified squash, then open its grouped PR and run final gates.

## PR #254: final gates

- PR: https://github.com/e6qu/fun-with-pipes/pull/254.
- Head: `8bf9c65bc247bbd94903d0a31fb0823d1e335391`, branch/worktree
  `scalar-array-identities`. Keep this tested head intact.
- Production run `41713252299`: eight jobs passed. Intel macOS ownership passed
  tests, binary inspection and archive verification, but three uploads failed
  DNS lookup (`ENOTFOUND`). [Original failure](measurements/scalar-array-identities-2026-11-03/upload-failure/README.md).
  Only that job was retried after the workflow finished: attempt 2, job
  `126246098084`. Audit its full/target logs and artifacts before merge.
- Docs run `41713252267`, job `126186525051`, passed. All eight passed production
  jobs and docs have full/target audits in `../gradient-work/platforms-254-attempt2`
  (26.69 guarded seconds). Original audits remain in `platforms-254-repaired`.
  GitHub assigns new job IDs to carried-over successes on retry; retain both sets.
- [Windows stream repair](https://github.com/e6qu/fun-with-pipes/blob/8bf9c65bc247bbd94903d0a31fb0823d1e335391/docs/measurements/scalar-array-identities-2026-11-03/windows-repair/README.md)
  is verified on both native Windows architectures. No assertion was weakened.
- Measurements are complete; compiler/runtime/library match frozen `beddd406`.
  Keep [all 32 missed speed goals](measurements/scalar-array-identity-time-2026-11-03/README.md)
  open. Never repeat completed timing sessions for a pass.
- Require nine production jobs plus docs at this exact head. Squash subject:
  `Preserve float bits and remove redundant F64 array copies`. Empty body,
  one line ≤80 characters, no trailers/attribution; verify the tested tree.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve #254's conversion and exact selection contract |
| 2 | Verified | Preserve native bit, ownership and cleanup evidence |
| 3 | Verified | Keep completed measurements and all missed speed targets |
| 4 | In progress | Audit upload retry, squash #254 and verify the tested tree |

## Next group: final iteration values

Branch/worktree: `iteration-final-value`; no delivery PR yet.
[Contract](measurements/final-iteration-storage.md) frozen at `2a257a3e`, tag
`roadmap/final-iteration-storage-protocol-2026-11-03`.
Measured source: `bb5433b688c26c60f0b2561a59420deb0f0e95ed`, immutable tag
`roadmap/final-iteration-measurement-2026-11-04`. Do not move this tag on rebase.

Implemented together: direct `last`; exact single-use numeric `iterate` → `last`
owner transfer; interpreter/native count-bound agreement; optional-wrapper cleanup
when retaining a child fails. Shared histories and resource-bearing iteration
states remain excluded from fusion. The Windows probe fix from #254 is included.

### Verification

[Focused run 41726742943](https://github.com/e6qu/fun-with-pipes/actions/runs/41726742943)
passes on GCC ARM64/AMD64 and Clang ARM64. Each host passes 268 units (4 ignored),
46 integrations across nine targets, twelve selection checks, primitive inventory,
docs and tutorial. Full logs, 418 native execution/image observations and eleven
interpreter/inventory statuses are audited. All 240 scalar count rows agree across
hosts. [Results and retained evidence](measurements/final-iteration-storage-2026-11-03/README.md).

For positive scalar count k, old/direct/selected totals are **2k+2, k+2, 1**.
The selected loop removes 2k list nodes and one temporary pointer buffer. This
count reduction does not establish runtime speed or whole-process peak memory.

Earlier failures are repaired and retained: private test import (`41715801311`),
missing test list layouts (`41720302662`), omitted scratch-buffer count
(`41723211349`). Their reports are linked from the verified-results page.
Compiler/runtime/library code has not changed since `f599dfba`; later fixes correct
fixtures and measurement tooling. Original source IDs remain reachable by the tag.

### Complete measurements; delivery remains

- Compiler run `41729365239`: all 480 commands, inputs, native compiler images and
  raw records are audited. Nine timing cases pass; AMD64 field-transfer copy
  variation is 2.043% against 2%, so it remains inconclusive. All observed memory
  ratios pass. [Results](measurements/final-iteration-analysis-2026-11-04/README.md).
- Runtime runs `41729376533` (ARM64) and `41730462251` (AMD64): all four sessions
  complete. Raw audits `41732080777` / `41733338891` pass; all 5,336 file records,
  full logs, reference sources, commands and native images reconcile.
- [Complete results](measurements/final-iteration-time-2026-11-04/README.md): largest
  history-form peak managed storage 838,688 → 19,360 bytes (97.7% less); 5.1–5.9%
  faster. Each 199-update solve saves 400 requests, 11,192 requested bytes and
  399 retains. Current-form counts and raw storage are unchanged; final storage
  is zero. All 48 count comparisons agree across hosts and workspace modes.
- Keep six runtime timing misses open: ARM64 3/199 and 33/199 history in both
  sessions; AMD64 session 1's 33/199 history; AMD64 session 2's 3/1 history is
  2.79% slower against 2%. All identical-copy controls pass. No timing was rerun.
  Two initial wrong-CPU AMD64 hosts stopped before building/measuring and are retained.
- No reported frame growth; native text changes −528 to +1,120 bytes. C/Rust use
  manual gradients and different storage; their ratios do not isolate language overhead.
- Both reference compilers retain count/cleanup repairs. Frozen source/tag remain
  `bb5433b6`; docs-only commits do not change those measured programs.
- After #254's verified squash, reconcile source and retained evidence onto it;
  require nine final-head production jobs plus docs. No final matrix is dispatched.

### Local checks and resume tools

- Guarded focused checks: formatting 1.70s; docs (253 link sets) 2.55s; workflow
  lint 6.85s; inventory 395 declarations/374 contracts, baseline unchanged;
  shard coverage 255 targets. Final focused evidence audit 1.85s, retention 3.82s.
  Updated documentation checks pass (255 link sets, 3.15s). Runtime collections
  5.93s/6.04s; complete retention 0.48s; 48-count audit 0.26s; report 0.25s.
  Compiler audits 45.24s/4.85s. All under the guard.
- Scratch collectors/auditors live in `../gradient-work`: `collect-final-platforms.py`,
  `collect-final-iteration-checks.py`, `audit-final-iteration-success.py`,
  `audit-final-iteration-analysis.py`, `collect-final-iteration-runtime.py` and
  `audit-final-iteration-rejected-hosts.py`. Collection alone is not acceptance.
- Run focused checks serially with `python3 scripts/local-guard.py`. No local full
  builds/suites/benchmarks; never bypass disk, RSS, generated-data or deadline limits.
- Preserve dirty primary and old worktrees. Keep one active delivery PR.
