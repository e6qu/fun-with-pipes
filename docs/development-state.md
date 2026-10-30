# Current work

**Next:** publish the audited B1 buffer report and frozen 4,096-element scan budget,
then inspect the scan's source/ownership costs before selecting a candidate. All
four baseline sessions at `fadebf713e0854d6d132fc6e3666f275b214fc17` are audited;
35/48 case controls fail. Only scan/4,096 passes on both architectures in both
sessions. Keep those failures explicit; no unchanged numerical rerun.
[Draft PR #231](https://github.com/e6qu/fun-with-pipes/pull/231), branch
`ownership-peer-baselines`, worktree `/private/tmp/fwp-ownership-peer-baselines`.
Keep one active PR. Once the grouped report and fixes are complete, require all
nine final-commit production jobs plus docs before the authorized squash merge.

## Active measurements

Session 1: `41103040883`; session 2: `41103049899`. Each requests both native
architectures through `numerics.yml`, `suite=buffer-baselines`, `native_runner=all`,
and explicit `comparison_session=1` or `2`. Session 1 jobs: AMD `124224640229`,
ARM `124224640595`; session 2: AMD `124224672478`, ARM `124224673013`.
All raw records and files are verified; collection success does not override failed copy controls.
The current source differs from the passing focused source only in workflow
placement and tracking docs; compiler, runtime, fixtures and scripts are identical.

Each session fixes three entries, four sizes, two warmup and 36 measured rounds,
twelve processes per label/round, seed 20261030: 32,832 ordinary attempts and 72
separate maximum-resident observations. Every language has an identical copy.
The copy-control limit is 1.02 in either direction. Keep all observations, failed
controls and partial artifacts; never increase samples or retry a numerical failure.
Derive future optimization budgets before selecting an implementation change.

## Verified focused checks

Source `6eca1176422afab433229a43afaec763917d3449`, run `41102080961`:
ARM job `124220853949`, artifact `12999368591`; AMD job `124220854136`, artifact
`13000720175`. Both full logs and archives are audited. Each archive has 829 files,
136 native commands, 432 peer commands, 108 phase commands, 126 storage commands,
142 memory commands and 31 ordinary-program build/inspection commands.

Both architectures pass 420 peer cases, 42 interpreter comparisons/84 native
executions, 90 phase cases/270 events/180 damaged-result controls, 90 allocation
cases including 18 intentional leaks, 38 memory parsing controls/72 Linux memory
executions, nine ordinary programs plus copies, compiler stack reports, nine
numerical-consumer result sets, and eleven synthetic-evidence damage controls.
All six clock helpers pass 48 checks. Synthetic records cannot validate as observed
measurements. No ordinary timings are present in these focused artifacts.

Archives/logs/audits: `/private/tmp/fwp-buffer-peer-{arm,amd}-6eca.{zip,log,audit.json}`.
Archive SHA-256: ARM `0e25625b97c2e6c48b758d8764e1011f7941683efbcff190a65fb2cb1e1afe46`;
AMD `ff073da9332fb3a3d8e1e08ecf654e29a25bc94ece87fbbcc5974471e1c81a4d`.
Local audit script: `/private/tmp/fwp-audit-buffer-6eca.py`.

Docs at `bd4b4343` pass run `41101370978`, job `124219006941`; full log audited:
`/private/tmp/fwp-229-docs-231-bd4b.log`. Final docs run `41102321920`, job
`124221503714`, also passes with a complete audit:
`/private/tmp/fwp-229-docs-231-fade.log`. GitHub status responses have lagged behind completed
logs: check actual logs rather than assuming a queued response means no execution.

## Repairs included in this PR

- Accept horizontal tabs in Linux memory values; retain strict number/unit checks.
- Use stable Rust 1.99.1 compiler frame remarks; require unchanged instruction bytes.
- Give objcopy an explicit output, preserving both inspected input executables.
- Link C observers into Rust through explicit native static libraries, before
  system libraries. Repair both existing descent-output callers too; their untimed
  result/cleanup checks pass. No D2/N1 benchmark was rerun.
- Retain all peer commands and benchmark attempts, including cancellation/timeout.
  Reconstruct summaries independently and reject missing, altered or synthetic data.
- Start the long WebAssembly ownership target earlier and interleave the existing
  two-worker queues, preserving every assignment. All 21 runner controls pass.

Earlier failed runs `41097911057` and `41100000646` and their complete artifacts
remain in `/private/tmp/fwp-buffer-peer-{arm,amd}-{230b,2acb}.{zip,log}`. The
[report](measurements/unique-buffer-peers.md) records causes and fixes. Superseded
run `41101368377` had cancellation requested before use; it contains no baseline observations.

## Local checks and recovery

Use `python3 scripts/local-guard.py` serially. Latest local results: five process/
file controls (0.74s), six schedule/result controls (0.24s), six build-failure
controls (1.48s), 38 memory parser controls/18 links (3.45s), workflow lint (5.82s),
and the roadmap audit (2.62s) pass. The complete older synthetic archive passed ten
damage controls (4.86s); the new eleventh passes native CI. No full local build,
benchmark or suite ran. Preserve at least 64 GiB free disk and the other guard limits.

The primary checkout is detached at #209 with a dirty recovery handoff and untracked
compiler-abort report. Preserve both. Automatic approval review rejected replacing
that handoff; do not retry or work around it. Backup:
`/private/tmp/fwp-primary-recovery-before-file-checks.md`. Former #229/#230 worktrees
also retain local handoffs; do not publish status-only changes there. Four older
expanded descent archives were compacted with all 5,784 files verified; their
`.tar.gz` and `.archive-audit.json` files remain under `/private/tmp`.

## Prior delivery and remaining failures

[PR #230](https://github.com/e6qu/fun-with-pipes/pull/230) is verified and merged:
squash `3639f4fad3da318346340f92a89d8ba127f04e73` has the tested `e2fad32c` tree,
a one-line 55-character message and no trailers. All nine jobs `41075128588` and
docs `41071247882` pass with full log audits. [History](roadmap-history.md#file-cleanup-portability-and-measurement-clocks-pr-230)
owns the delivery details; it is not a backlog.

D2 remains **1.022815765 > 1.02** in `40912773534`; N1 remains
**1.030786192 > 1.02** in `40951090783`. No unchanged rerun or relaxed limit.
The [Intel compiler abort](measurements/compiler-abort.md) remains unexplained;
preserve evidence and diagnose its source/input if it recurs, not disassembly.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and cycle guarantees |
| 2 | Verified | Preserve A1–A6; broader ARC costs remain in B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's remaining timing requirement |
| 6 | In progress | Resolve N1's control before N2 timing acceptance |
| 7 | In progress | Finish buffer comparisons, then the other B1/B2 gaps |
| 8 | In progress | Finish numerical and integrated V1/V2 acceptance |

## Baseline audit files

All four logs/archives/audits are `/private/tmp/fwp-buffer-baseline-{arm,amd}-{1,2}-fade.{log,zip,audit.json}`.
Session 1 artifacts: ARM `13000780683`, AMD `12998559197`; session 2: ARM
`12999084366`, AMD `13000896652`. `/private/tmp/fwp-audit-buffer-baseline.py`
reconstructs complete evidence under the guard (1.08–1.33s per archive), extracts
only into a temporary directory after checking disk headroom, then removes that
verified temporary copy. Original archives remain. Free disk is only about
64.2 GiB; do not download or generate large files without checking the limit.
The report and new artifact index replace obsolete preparation-only text.
No candidate implementation or paired candidate timing has run yet.
