# Current work

**Next:** publish the audited iteration-buffer count correction and run the
three-host `final-iteration-checks` batch. Monitor #254 independently; retry its
Intel macOS ownership job after the remaining production jobs finish. Open the
next delivery PR only after #254's verified squash. No new timing session has started.

## PR #254: final gates

- PR: https://github.com/e6qu/fun-with-pipes/pull/254.
- Head: `8bf9c65bc247bbd94903d0a31fb0823d1e335391`, branch/worktree
  `scalar-array-identities`. Production run `41713252299` is still running.
- Bench, regular Intel macOS, ARM64 macOS ownership and docs `41713252267` /
  job `126186525051` pass. Full/target audits are in scratch
  `../gradient-work/platforms-254-repaired`; 131 regular and 126 ownership logs pass.
- Intel macOS ownership job `126186525953` passed all tests, binary inspection and
  archive verification, but three artifact uploads failed DNS lookup (`ENOTFOUND`).
  [Retained failed attempt](measurements/scalar-array-identities-2026-11-03/upload-failure/README.md).
  GitHub rejected the immediate retry with HTTP 403 because the workflow is still
  running. After the other jobs finish, rerun **only this job on the same head**.
  Preserve both attempts and audit the retry. No code fix follows from this upload failure.
- Earlier Windows failures were custom probe mains missing binary-stream setup.
  [Diagnosis](https://github.com/e6qu/fun-with-pipes/blob/8bf9c65bc247bbd94903d0a31fb0823d1e335391/docs/measurements/scalar-array-identities-2026-11-03/windows-repair/README.md)
  retains 1,600 exact conversion rows and 32 correct fatal-allocation exits.
- Measurements are complete; compiler/runtime/library match frozen `beddd406`.
  Keep [all 32 missed speed goals](measurements/scalar-array-identity-time-2026-11-03/README.md)
  open. Never repeat completed timing sessions for a pass.
- Require nine production jobs plus docs at the exact head. Squash subject:
  `Preserve float bits and remove redundant F64 array copies`. Empty body,
  one line ≤80 characters, no trailers/attribution; verify the tested tree.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve #254's conversion and exact selection contract |
| 2 | Verified | Finish repaired-probe checks in final native CI |
| 3 | Verified | Keep completed measurements and all missed speed targets |
| 4 | In progress | Retry upload failure, finish gates, audit and squash #254 |

## Next group: final iteration values

Branch/worktree: `iteration-final-value`, published `81a978b7322618426e854bb9435c5af4de8c3ec6`.
No delivery PR. [Contract](measurements/final-iteration-storage.md) frozen at
`2a257a3eea7b6005c350f1f860e27755b18b25c2`, tag
`roadmap/final-iteration-storage-protocol-2026-11-03`, before implementation.

Implemented: direct `last`; exact single-use numeric `iterate` → `last` owner
transfer; interpreter/native count-bound agreement; fresh optional-wrapper cleanup.
Shared histories and resource-bearing states remain excluded from fusion.
Docs/tutorials explain inputs and results; generated library docs were imported
from matching GCC artifacts. Prior #249/#251/#252 verification status is corrected.
The Windows probe stream fix from #254 is carried into this branch.

### Focused checks and repairs

| Run / source | Complete audit and action |
|---|---|
| `41715801311` / `f599dfba` | Both GCC hosts: private `Value` import prevented integration compilation. Fixed import; queued obsolete macOS cancelled. [Evidence](measurements/final-iteration-storage-2026-11-03/compile-repair/README.md). |
| `41720302662` / `73426169` | Both GCC hosts: two hand-built IR fixtures lacked list layouts. Each passed 44 integrations; fixed outer/inner/file list shapes. Queued obsolete macOS cancelled. [Evidence](measurements/final-iteration-storage-2026-11-03/layout-repair/README.md). |
| `41723211349` / `81a978b7` | All three hosts: 45 integrations pass; one scalar allocation assertion omits iterate's temporary pointer buffer. All other native observations pass. Exact count correction is ready. [Evidence](measurements/final-iteration-storage-2026-11-03/count-repair/README.md). |

Each host in the last run passes 268 units (4 ignored), all twelve real-program
selections, inventory, docs and tutorial. Every full log, nine target logs and 429
native observations was audited. Only sixteen old/direct scalar observations per
host have the count mismatch. Selected-loop aliases/captures/slices, reuse,
trap/cancellation, omitted cleanup and generic-last file lifetimes pass.

For positive scalar count k, old/direct/selected totals are **2k+2, k+2, 1**:
list nodes plus one option, plus the retained iterator's pointer buffer. The frozen
2k list-node saving remains unchanged. Three actual emitted C probes pass locally
with the corrected total at Clang O2 (1.48 guarded seconds), including cleanup.
This is not GCC or Rust-generator verification. Next CI must check the actual fixture.

### Measurement and delivery

- Reference tooling restores reverse/head and disables only history removal;
  both sides preserve count and cleanup repairs. Five corruption controls pass.
- Nineteen budget, seventeen raw-evidence, seven compiler-cost and three retention
  controls pass. Workflow integration is published. No timing session has started.
- After focused checks pass, freeze the measured source and run declared
  compiler/runtime/stack comparisons. Keep every failure and original session.
  Then require nine final-head production jobs plus docs before delivery.
- Scratch `../gradient-work/collect-final-iteration-checks.py` collects full logs,
  artifact identities and native observations; collection alone is not acceptance.
  A plain-language PR draft is in `../gradient-work/final-iteration-pr.md`.
- Guarded checks: formatting 1.70s; docs 251 link sets 2.66s; workflow lint 6.85s;
  inventory 395 declarations/374 contracts, frozen baseline unchanged; shard
  coverage 255 targets. Count-failure retention/audit took 0.26s.
- No local compiler build, full suite or benchmark. Use `python3 scripts/local-guard.py`
  serially; never bypass 64 GiB disk, 2 GiB target, 1 GiB RSS or 180-second limits.
- Preserve dirty primary/old worktrees. Before rebasing onto #254's verified
  squash, retain this branch's evidence source with an immutable tag. Keep one
  active delivery PR. The old `38888712709` run is a service ghost without active jobs.
