# Current work

**Next:** monitor all four `record-zip-time` jobs in run `41325932590`, audit their
saved observations and exact reference patch, then fix failures together before
running the final production gates for [PR #239](https://github.com/e6qu/fun-with-pipes/pull/239).

Worktree `/private/tmp/fwp-returned-callables`, branch `derivative-forward-costs`.
Published head `0dd02a4e`; base `c124d0c8` (verified PR #238). Preserve unrelated
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
verified candidate. All four jobs were queued at the last check:

| Session | Job |
|---|---|
| AMD64 1 | `124905745526` |
| AMD64 2 | `124905745487` |
| ARM64 1 | `124905745488` |
| ARM64 2 | `124905745590` |

Use the frozen qualified hosts, 98 rounds, seven fresh processes, 5% speed limit
and 2% identical-copy limit. Preserve failed/noisy observations. A slow status
request is not a stopped job; poll the same handle before taking action.

Documentation `41324800221` passes on `a4cef01b`; its complete log was audited.
The current-head documentation run is `41326183619`, last seen queued. Superseded
queued docs `41319949124` and `41324313889` were cancelled. No current failure is
known. The final nine-job matrix has not run; draft skips are not passing gates.

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

Focused checks used `python3 scripts/local-guard.py` serially:
`test-derivative-ownership-profile.py` (9 pass), `test-record-zip-reference.py`
(3), `test-descent-budgets.py` (10), `test-descent-groups.py` (12),
`test-descent-phases.py --cc clang` (4), and `test-array-list-evidence.py` (8).
The three updated ZIP/patch controls also pass separately. `check-roadmap.py`
and workflow `actionlint -shellcheck= -pyflakes=` pass.

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

Keep the unchanged guard: 64 GiB free disk, target data below 2 GiB, sampled RSS
below 1 GiB, 180-second deadline. Full builds, suites, benchmarks and large evidence
regeneration belong on GitHub. Disk is near the floor; avoid duplicate downloads.
D2/N1/N2 timings, original Xeon regressions and individual Swift ARC counts remain
open as recorded in the plan. The new measured reduction does not settle them.
