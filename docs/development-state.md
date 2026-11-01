# Current work

**Next:** monitor timing runs `41325932590` and replacement `41327509981`; after
each completes, dispatch `record-zip-report` with its full source ID to audit the
saved observations on GitHub. Fix failures together before
running the final production gates for [PR #239](https://github.com/e6qu/fun-with-pipes/pull/239).

Worktree `/private/tmp/fwp-returned-callables`, branch `derivative-forward-costs`.
Base `c124d0c8` (verified PR #238); timing-audit repair `844ff77f`. Preserve unrelated
primary-checkout edits. One active PR; publication and squash merge after all
final-head gates pass remain authorized. Every commit has one line, at most
80 characters, with no body, trailers or attribution.

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
verified candidate. Both ARM64 sessions and AMD64 session 1 are measuring.
AMD64 session 2 stopped before building: GitHub assigned an EPYC 9V45 instead
of the frozen EPYC 7763. The replacement run `41327509981` uses source
`844ff77ff17e9a3edec5ef73362faad130c351e7`, with unchanged measured code and tools.
Its AMD64 session 2 job `124910457839` was queued at the last check.

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
Documentation `41327106604` passes on `844ff77f`. Its complete log is
`/private/tmp/fwp-239-docs-844ff77f.log`; diagnostics are the expected runner controls.
Superseded docs `41319949124`, `41324313889`, `41326183619` and `41326898762` were
cancelled; the last had started but had no failed steps before cancellation.
The host rejection is the only known current CI failure; no measurement ran in
that job. The final nine-job matrix has not run; draft skips are not passing gates.

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
  The remote retention job will verify its API digest and preserve it with the
  completed measurements. The local retention command was stopped by the disk guard.
- Immutable tag `roadmap/derivative-record-zip-sources-2026-11-01` points to
  `844ff77f` and retains the baseline, frozen requirements and measured sources
  through the eventual squash merge.

Focused checks used `python3 scripts/local-guard.py` serially:
`test-derivative-ownership-profile.py` (9 pass), `test-record-zip-reference.py`
(3), `test-descent-budgets.py` (10), `test-descent-groups.py` (12),
`test-descent-phases.py --cc clang` (4), and `test-array-list-evidence.py` (8).
The three updated ZIP/patch controls also pass separately. `check-roadmap.py`
and workflow `actionlint -shellcheck= -pyflakes=` pass.
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

Local checks are currently stopped: the guard found less than 64 GiB free disk
(about 62.2 GiB at inspection). Known local build caches are empty; this PR's
temporary data cannot restore the missing headroom. Do not bypass the guard.
`record-zip-report` moves artifact download, audit and compression to GitHub,
retaining partial output on audit failure. Its new download/rejection controls
must pass CI; they have not run locally because of the disk limit.

Keep the unchanged guard: 64 GiB free disk, target data below 2 GiB, sampled RSS
below 1 GiB, 180-second deadline. Full builds, suites, benchmarks and large evidence
regeneration belong on GitHub. Disk is near the floor; avoid duplicate downloads.
D2/N1/N2 timings, original Xeon regressions and individual Swift ARC counts remain
open as recorded in the plan. The new measured reduction does not settle them.
