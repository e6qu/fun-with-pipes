# Current work

**Next:** finish AMD64 timing session `41330973213` and audit its observations.
Resolve the unmet timing requirements before
running the final production gates for [PR #239](https://github.com/e6qu/fun-with-pipes/pull/239).

Worktree `/private/tmp/fwp-returned-callables`, branch `derivative-forward-costs`.
Base `c124d0c8` (verified PR #238); timing-audit repair `844ff77f`. Preserve unrelated
primary-checkout edits. One active PR; publication and squash merge after all
final-head gates pass remain authorized. Every commit has one line, at most
80 characters, with no body, trailers or attribution.

This batch retains the audited reports/logs, explains all six count/timing
results, and uploads compact audit results before compressing the full archive.
Measured compiler/runtime files are unchanged. Workflow
`actionlint -shellcheck= -pyflakes=` passes through the guard after this reorder.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Protocol published at `02d4aa26`; candidate limits frozen at `73cec3e5` before compiler edits |
| 2 | Verified | Known-work, omission, wrong-phase and unfinished-sequence controls pass |
| 3 | Verified | Run `41319946864`, source `afc0f78f`: both hosts and all 96 baseline observations audited |
| 4 | In progress | Candidate correctness/count/cleanup/code/stack checks pass; paired timing and final production gates pending |

[PLAN.md](../PLAN.md) defines scope. The [protocol and results](measurements/derivative-forward-costs.md)
contain the inputs, acceptance limits and measured reductions. [History](roadmap-history.md#direct-derivative-recording-pr-238)
retains the previous delivery; do not reuse its monitor for this PR.

## Current implementation and verified results

`src/fuse.rs` extends existing zip/map fusion to flat numeric records, including
`Rev[F64]`. Both source lists stay live; pair order and shorter-list length stay
unchanged. Nested records, managed fields and boxed wide numbers remain excluded.
No public primitive or runtime switch was added.

Candidate `b094fdd8` passes run `41324329567`: AMD64 job `124900983795`, ARM64
`124900983956`. Per host: 19 affected integration cases, three fusion unit tests,
GCC O1/O2 observer controls and 48 complete-solve observations pass. Both full logs
were audited without compiler diagnostics. Independent archive audits verify
all hashes, native headers, outputs, counts, code/stack limits and saved probes.

Largest current-only solve: 51,143 fewer requests, 1,428,024 fewer requested bytes,
76,416 fewer effective retains; peak managed charge 25,952 → 21,888 bytes. Raw tape
storage and zero-update counts are unchanged. Every largest static frame is
unchanged. Both architectures agree on all detailed counts. This does not prove
a speedup; D2 timing acceptance remains open.

## Active CI

Timing run `41325932590` uses `a4cef01b`, with compiler source unchanged from the
verified candidate. It is completed: both ARM64 sessions and AMD64 session 1
measured all six cases; AMD64 session 2 rejected its host before building.
Both ARM sessions miss only the frozen 5% speed requirement for case `3-1`:
current ratios 0.990137 / 0.991153, history 0.991596 / 0.994167. Their other
reported timing/count/memory/code/stack limits pass. AMD64 session 1 misses the
same case (current 0.996431, history 0.998850), plus current zero-update time
1.025398 against 1.02. Its remaining reported limits pass. Complete log:
`/private/tmp/fwp-239-timing-amd-1.log`. Archive audit `41329444021`, job
`124916252154`, passes. Its full log is `/private/tmp/fwp-239-timing-audit-original.log`.
All original file/source hashes, outputs, process observations, profiles, images,
stack reports and reference patches agree; the seven failed timing limits remain.
Retained reports/logs and indexes are under
`docs/measurements/derivative-record-zip-2026-11-01/` (`original`, `rejected-2`,
`rejected-3`). The small summary downloads' API digests and each decompressed
report/log hash pass a guarded check. Original summary artifact `13094271343`;
full retained archive `13094620286`.

The one-update reference diagnostic puts forward work at 4.41–4.72% of process
time and all six derivative phases at 6.35–6.76%. This suggests the selected
forward-only change's 5% whole-process requirement was too aggressive. It is
not an exact upper bound: diagnostic/ordinary ratios range 0.962–1.042. The
zero-update regression remains unexplained. See the measurement note for ratios.
Source review of the saved single-solve zero-update C finds the initial count
passed as zero to `fwp_loop_fields161`; the unexecuted update branch is still
emitted. Baseline/candidate C differ. This does not establish the timing cause
or verify the repeated-solve timing images; do not infer identical code from
unchanged counts. The one-update count reports show five allocations and six
retains removed, all in forward calculation/recording, with 43 allocations left.
The updated asynchronous question includes the AMD64 regression and asks whether
to retain the verified reductions with timing requirements unmet or continue
optimization until every limit passes. No answer has arrived; do not relabel
these failures or silently weaken the frozen requirements.
AMD64 session 2 stopped before building: GitHub assigned an EPYC 9V45 instead
of the frozen EPYC 7763. The replacement run `41327509981` uses source
`844ff77ff17e9a3edec5ef73362faad130c351e7`, with unchanged measured code and tools.
Its job `124910457839` was also rejected for an EPYC 9V45 before building.
Second replacement `41328989036`, job `124914897632`, also rejected its host
before building: EPYC 9V74. Source `9ce7bdd6c7a735062e63dc05d7399e6c1d766673`,
host artifact `13092819187`; complete log `/private/tmp/fwp-239-timing-amd-2-attempt3.log`.
Retention `41330970147`, job `124920797473`, passes for that rejection; complete
log `/private/tmp/fwp-239-retain-rejected-9ce.log`. Summary `13094615699`, full
archive `13094765276`. Both rejection audits confirm no compilation/timing ran.
Third replacement `41330973213`, job `124920809825`, qualified its host and is measuring on
`215db5dea22ebbf1e2052b69660c068959e4a2c7`; measured source/tool files remain unchanged.
Only host-rejected sessions were replaced; no completed timing was rerun.

Retention run `41328986141`, job `124914887625`, passes for the first replacement.
It verifies the host-artifact digest and confirms no build or timing ran. Complete
log `/private/tmp/fwp-239-retain-rejected-844.log`; summary artifact `13093780168`,
full retained archive `13093590764`. The summary has no audit errors; its local
copy is `/private/tmp/fwp-239-rejected-844-summary.zip`, with API metadata beside it.

| Session | Job |
|---|---|
| AMD64 1 | `124905745526` |
| AMD64 2, rejected host | `124905745487` |
| ARM64 1 | `124905745488` |
| ARM64 2 | `124905745590` |

Use the frozen qualified hosts, 98 rounds, seven fresh processes, 5% speed limit
and 2% identical-copy limit. Preserve failed/noisy observations. A slow status
request is not a stopped job; poll the same handle before taking action.

Documentation `41324800221` passes on `a4cef01b`; its complete log was audited.
Documentation `41329721476`, job `124917070526`, passes on `215db5de`. Complete
log `/private/tmp/fwp-239-docs-215db5de.log`; failures in its runner-control output
are deliberate (the `intentional runner control` test), not hidden regressions.
Documentation `41328332813` passes on `9ce7bdd6`, including all three new
download/host-rejection controls. Complete log diagnostics are only intentional
runner controls. Earlier documentation `41327106604` passes on `844ff77f`; its log is
`/private/tmp/fwp-239-docs-844ff77f.log`; diagnostics are the expected runner controls.
Superseded docs `41319949124`, `41324313889`, `41326183619` and `41326898762` were
cancelled; the last had started but had no failed steps before cancellation.
Known failures are the three host rejections, three one-update timing misses
and the AMD64 zero-update regression. No correctness or storage failure is known. The final nine-job matrix
has not run; draft skips are not passing gates.

## Evidence and local checks

- Committed baseline and candidate reports:
  [baseline](measurements/derivative-forward-costs-2026-11-01.json.gz),
  [candidate](measurements/derivative-record-zip-counts-2026-11-01.json.gz).
- Baseline ZIPs: `/private/tmp/fwp-239-{aarch64,x86_64}.zip`; artifact IDs
  `13089053399` / `13089073406`. Logs: `/private/tmp/fwp-239-logs/`.
- Candidate count ZIPs: `/private/tmp/fwp-239-record-derivative-forward-evidence-{aarch64,x86_64}.zip`;
  IDs `13091590309` / `13090939053`.
- Candidate probe ZIPs: `/private/tmp/fwp-239-record-record-zip-checks-{aarch64,x86_64}.zip`;
  IDs `13091176820` / `13091261239`. Adjacent JSON files retain verified API digests.
- Native logs: `/private/tmp/fwp-239-record-{amd,arm}.log`; docs log:
  `/private/tmp/fwp-239-docs-a4cef01b.log`. Only intentional runner-failure controls
  appear as errors in the passing documentation log.
- Rejected host files: `/private/tmp/fwp-239-timing-amd-2-rejected*` (host ZIP,
  artifact metadata, job metadata and complete log); artifact `13092045996`.
  The completed original-run audit verifies its API digest and preserves it with
  the measurements. The earlier local retention command was stopped by the disk guard.
- Immutable tag `roadmap/derivative-record-zip-sources-2026-11-01` points to
  `844ff77f` and retains the baseline, frozen requirements and measured sources
  through the eventual squash merge.
- Immutable tag `roadmap/derivative-record-zip-audits-2026-11-01` points to
  `215db5de`, retaining the later audit code and replacement-session sources.

Focused checks used `python3 scripts/local-guard.py` serially:
`test-derivative-ownership-profile.py` (9 pass), `test-record-zip-reference.py`
(3), `test-descent-budgets.py` (10), `test-descent-groups.py` (12),
`test-descent-phases.py --cc clang` (4), and `test-array-list-evidence.py` (8).
The three updated ZIP/patch controls also pass separately. `check-roadmap.py`
and workflow `actionlint -shellcheck= -pyflakes=` pass.
The temporary report-retention reader `/private/tmp/fwp-239-read-retained.py`
passes all three small summary archives through the guard. Its initial missing
`scripts` import path was fixed; no archived executable was run.
Review also found and fixed a file/directory collision that could hide a ZIP
entry from traversal; directory-shadow and root-path rejection controls pass.

`summarize-derivative-forward-costs.py` passes both original archives with
`--comparison baseline` and both candidate archives with `--comparison record-zip`
and the committed baseline. `/private/tmp/fwp-239-audit-record-probes.py` verifies
all eight ordinary and eight omitted-cleanup native images, 28 alias/length cases
per ordinary image. Its initial temporary import-path error was fixed.

The extended `check-array-list-evidence.py` reuses the existing timing audit with
explicit `--protocol record-zip --input-format zip --reference REFERENCE.zip`.
It checks every process observation, image, stack report and ownership profile,
and reconstructs the reference source/patch. Use it when timing artifacts arrive;
do not execute archived binaries or extract whole archives locally.

The disk guard previously stopped local checks at 59–61 GiB free. Cleanup briefly
restored about 64 GiB, and guarded `check-roadmap.py` passed: 197 link sets,
106 preparation pairs/tags, four plan steps and commit messages; 0.28 CPU seconds,
2.49 seconds elapsed. The first retry lacked sandbox process-list permission;
the elevated unchanged guard then rejected insufficient disk until cleanup finished.
The latest retry after adding the retained-report links stopped below 64 GiB
again. Validate the final documentation batch in CI; do not bypass the guard.

Only redundant old downloads were removed: `fwp-descent-{groups,refresh}-*`,
the four `fwp-descent-output-*.tar.gz` copies, and the old accepted CPU-phase and
decimal count/tree/long/interleaved/balanced directories. Their source IDs match
committed reports/manifests, and the complete corresponding archives were confirmed
unexpired on GitHub before removal. API metadata is saved in
`/private/tmp/fwp-239-cleanup-*-artifacts.json`; the committed evidence indexes
identify original run IDs for re-download. About 3 GiB was recovered. Source
worktrees, current PR evidence, reports and logs were preserved.
All inspected `target` caches were empty. The five largest old worktrees have
uncommitted changes, including test edits in `fwp-application-cleanup-controls`;
preserve them. Disk remains close to the floor; always let the guard recheck it.
`record-zip-report` moves artifact download, audit and compression to GitHub,
retaining partial output on audit failure. Its three download/rejection controls
pass in documentation CI; they have not run locally because of the disk limit.

Keep the unchanged guard: 64 GiB free disk, target data below 2 GiB, sampled RSS
below 1 GiB, 180-second deadline. Full builds, suites, benchmarks and large evidence
regeneration belong on GitHub. Disk is near the floor; avoid duplicate downloads.
D2/N1/N2 timings, original Xeon regressions and individual Swift ARC counts remain
open as recorded in the plan. The new measured reduction does not settle them.
