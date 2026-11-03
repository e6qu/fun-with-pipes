# Current work

**Next:** finish and audit #254's Intel macOS ownership retry, then squash the
verified head. In parallel, retain the final-iteration measurements already running
at the frozen source. Open its delivery PR only after #254 merges.

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

### Measurements in progress

- Compiler costs: run `41729365239`. ARM64 passes; AMD64 field-transfer has 2.043%
  identical-copy variation against 2%, so that timing case is inconclusive.
  All 480 commands, inputs, native compiler images and raw records are audited;
  [retained results](measurements/final-iteration-analysis-2026-11-04/README.md).
  Do not repeat this session. ARM64/AMD64 audits took 45.24s/4.85s under the guard.
- Runtime: run `41729376533`. Both ARM64 sessions are measuring. Both AMD64 hosts
  were rejected before build/timing (Xeon 6975P-C instead of EPYC 7763).
  Audited rejections are in scratch `final-iteration-host-rejections/41729376533`.
  Replacement AMD64-only sessions in `41730462251` qualified and are measuring.
  [Run/host records](measurements/final-iteration-time-2026-11-04/README.md).
  Never rerun completed timings.
- Once sessions finish, dispatch `final-iteration-report` against each run on the
  frozen tag, with `source_revision=bb5433b688c26c60f0b2561a59420deb0f0e95ed`.
  Retain full/raw audits, every missed limit, compiler cost and stack observations.
- Reference restores reverse/head and disables only history removal. Both sides
  keep count and cleanup repairs. Reference, budget and evidence controls pass.
- After reconciliation onto #254's squash, require nine final-head production
  jobs plus docs before delivery. No final production matrix has been dispatched.

### Local checks and resume tools

- Guarded focused checks: formatting 1.70s; docs (253 link sets) 2.55s; workflow
  lint 6.85s; inventory 395 declarations/374 contracts, baseline unchanged;
  shard coverage 255 targets. Final focused evidence audit 1.85s, retention 3.82s.
  Updated tracked-document links and handoff checks pass (3.12s).
- Scratch collectors/auditors live in `../gradient-work`: `collect-final-platforms.py`,
  `collect-final-iteration-checks.py`, `audit-final-iteration-success.py`,
  `audit-final-iteration-analysis.py`, `collect-final-iteration-runtime.py` and
  `audit-final-iteration-rejected-hosts.py`. Collection alone is not acceptance.
- Run focused checks serially with `python3 scripts/local-guard.py`. No local full
  builds/suites/benchmarks; never bypass disk, RSS, generated-data or deadline limits.
- Preserve dirty primary and old worktrees. Keep one active delivery PR.
