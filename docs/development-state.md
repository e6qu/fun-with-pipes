# Current work

**Next:** incorporate AMD64 session 1 from `41518220615`, job `125527179997`,
which obtained the required CPU and is building its same-source reference.
The other three sessions and all four host rejections are independently audited
and retained in the repository. Source `a4f3200c` is retained by
`roadmap/derivative-temporary-storage-runner-2026-11-02`. Both ARM64 sessions
pass; AMD64 session 2 retains a 2.024% zero-update history regression against
the frozen 2% limit. Do not repeat completed measurements. PR #247 has eight verified
production passes; its macOS ARM64 attempt-3 retry, job `125524990804` in run
`41497408964`, has started.

## Branch and delivery

Worktree `/private/tmp/fwp-array-consumption`, branch `derivative-temporary-storage`,
based on PR #247 head `bb2e5b29fa6f53b3f187c3fba3fd15d38ff4085b`. Primary checkout
untouched. Keep one active PR: `array-observation-diagnostics` remains at that
head while the next compiler batch develops on its separate branch.

[PR #246](roadmap-history.md#array-preparation-diagnostic-pr-246) is verified and
merged as `7e48e438`; identical-tree duplicate main jobs were cancelled.
[PR #247](https://github.com/e6qu/fun-with-pipes/pull/247) delivers the completed
[three-driver comparison](measurements/array-observations-2026-11-02/README.md).
Its four complete native sessions and four rejected hosts are retained. All 96
roles are audited; thirteen small-AMD64 copy failures and all old timing goals
remain explicit. No production compiler/runtime change belongs to that PR.

Production run `41497408964`; documentation run `41497408857`:

| Gate | Job | Status / audit |
|---|---|---|
| Linux AMD64 | `125455859870` | Pass; full log and all 257 native targets audited |
| Linux ARM64 | `125455860365` | Pass; full log and all 257 native targets audited |
| macOS AMD64 regular | `125455860276` | Pass; full log and all 131 native targets audited |
| macOS ARM64 regular | `125455860363` | Pass; full log and all 131 native targets audited |
| macOS AMD64 ownership | `125455860541` | Pass; full log and all 126 targets audited |
| macOS ARM64 ownership | `125524990804` | Attempt-3 retry running; both earlier attempts had no runner |
| Windows ARM64 | `125455860399` | Pass; full log, initial target archive and reuse checks audited |
| Windows AMD64 | `125455860474` | Pass; full log and initial target archive audited |
| C/Rust benchmarks | `125455860614` | Pass; full log audited |
| Documentation | `125455859455` | Pass; full log audited |

The original macOS ARM64 job executed no steps because of hosted-runner capacity.
Once all other jobs finished, GitHub accepted its targeted retry. That attempt
also received no runner; attempt 3 has started. Successful jobs
were carried forward without rerunning; their original IDs above identify the
audited logs. Original annotations are saved at
`/private/tmp/fwp-247-macos-arm-ownership-cancellation.json`; retry annotations
are `/private/tmp/fwp-247-macos-arm-retry-annotations.json`. No source failure is
known in PR #247. Queued/cancelled work does not establish native support.

Completed audits:

- Each Linux host: 258 Rust summaries, 1,035 passes, 20 ignored. Its native target
  archive has 257 targets / 1,034 passes / no diagnostics.
- Each macOS regular job: 132 summaries / 651 passes / four ignored; target
  archive: 131 targets / 650 passes. Only benign Homebrew already-installed
  OpenSSL notices and echoed warning flags appear in the full logs.
- Intel macOS ownership: 128 summaries / 381 passes / 20 ignored; its 126-target
  archive has 379 passes and no diagnostics.
- Each Windows host: 206 summaries / 853 passes / 12 ignored. Their sixteen intentional
  scheduler panics match `src/sched.rs` controls. Both Windows initial archives
  have 57 logs / 428 passes / two ignored. Both hosts' separate 12 reuse tests pass.
- Intel macOS corpus: all 85 programs finish. Benchmark: two passing summaries.
  Documentation: 73 Python groups / 465 tests, 213 link sets, 106 immutable pairs
  and five plan steps; intentional runner failures match their test controls.

Full logs and target archives use `/private/tmp/fwp-247-*`. Current metadata is
`/private/tmp/fwp-247-final-artifacts.json`. Auditors:
`/private/tmp/fwp-247-audit-targets.py` and `/private/tmp/fwp-audit-full-job.py`.
Run these serially through the local guard; review diagnostics rather than
ignoring warnings or intentional-failure output wholesale.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Frozen three-driver boundaries and exact source reconstruction |
| 2 | Verified | Native numerical, ownership, omitted-destruction and failed-clock controls |
| 3 | Verified | Four complete archives audited; every host rejection preserved |
| 4 | Verified | Complete 96-role report preserves timing limits and failures |
| 5 | In progress | PR #247 final production gates, targeted capacity retry and merge |

## Next batch: temporary derivative records

[Report, frozen requirements and evidence](measurements/derivative-temporary-storage-2026-11-02/README.md)
contain the full baseline and first candidate counts. The change keeps a sole-use
mapped numeric-record collection in one owned word buffer. All map calls still
finish before folding; seed evaluation stays at its original point. Numeric
bits have no child owners. Existing typed cleanup releases the buffer on failure.

| Checkpoint | Source / run | Result |
|---|---|---|
| Baseline | `bb2e5b29` / `41497441785` | Both native GCC hosts; all 96 observations audited |
| Frozen protocol | `15aa4c0a` | Published before compiler edits |
| Initial compiler/counts | `229ea441` / `41505591902` | All 96 limits pass; full archives and logs audited |
| Initial cleanup controls | `0c5b9827` / `41507658382` | GCC and Clang O1/O2 on both hosts; 22 passes per host |
| Expanded callback controls | `76069cfa` / `41509110166` | Harness output-stream failure; all targets audited |
| Combined repair | `a4f3200c` / `41511493637` | Pass; both native jobs, 40 tests each, all counts and actual probes audited |

Immutable tags retain protocol `roadmap/derivative-temporary-storage-protocol-2026-11-02`
and first counts `roadmap/derivative-temporary-storage-counts-2026-11-02`.
Largest current-only O2 solve: 208,086 → 156,943 managed allocations;
21,888 → 17,824 peak managed bytes. Retains and raw tape/workspace observations
are unchanged; final storage is zero. These are memory/count results, not speed.

Expanded tests cover scalar and boxed callback input owners, map/between-stage/
fold traps, cancellation, buffer/final allocation failure, input aliases and
intentional missing buffer destruction. Nine exclusions cover shared/escaping
lists, right fold, dynamic/captured callbacks and managed/nested/wide fields.
The related autodiff, worker-preparation and zip-unwind targets also run.

Both failed jobs showed only the boxed fixture's null `fwp_prog_out`: its first
print crashed because the standalone driver bypassed executable startup. Each
host had 38 passing tests and two instances of that failure. Repair explicitly
initializes stdout. The exact failed C with that one-line fix passes guarded
local Clang O1 compilation (0.62s) and execution (0.73s); this is not GCC coverage.
The same checkpoint moves use counting after cheap mapper eligibility checks,
avoiding whole-body scans for unrelated `let` bindings. Source-level ordering and
representation remain unchanged. Failed logs and artifact identities are retained
in [verification](measurements/derivative-temporary-storage-2026-11-02/verification.md); full probes are `/private/tmp/fwp-packed-expanded-arm64.zip`.

The same-source reference disables only packed-record lowering, retaining old
record-fold optimizations. Tests pass: reference mutations (three), timing/memory
limits (twelve), archive/historical evidence (eleven), artifact retention (three).
The longest guarded audit took 50.92s; formatting, workflow lint and roadmap links
also pass. Timing and independent archive audits are running. Preserve every completed/rejected session;
do not rerun unchanged noisy measurements to obtain a pass.

Focused validation is complete: independent archive replay (4.10s), actual-probe
and binary audits (0.13/0.14s), complete job logs and source/count equivalence
(0.26s) pass. All 48 case C sources plus four control sources are unchanged from
the first implementation. Every count matches the exact saving of `2*n+1`
requests / `48*n+16` bytes per update for `n=coordinates-1`.

Original timing jobs: ARM64 session 1 `125513671132`, ARM64 session 2
`125513671731`, AMD64 session 2 `125513671211`; rejected AMD64 session 1
`125513671580`. Its CPU was EPYC 9V74 rather than frozen EPYC 7763. Full log,
job record and artifact `13174047975` are retained at
`/private/tmp/fwp-packed-timing-amd1-rejection*`; guard verifies CPU-only rejection
before building or measuring (0.13s). The second CPU-only rejection is job
`125515446874`, artifact `13173453867`, retained at
`/private/tmp/fwp-packed-timing-amd1-rejection2*`. Third rejection run
`41515994738`, job `125519605648`, artifact `13174793593` received EPYC 9V74.
All three stopped before compilation or timing. Independent rejection reports
are `41517734538` and `41517746039`; the original report includes rejection 1.
The fourth attempt `41517608442`, job `125525061276`, also received EPYC 9V45;
its report `41518209544` passes. Original report `41517598393` and both earlier
rejection reports pass too. Complete logs have no unexpected diagnostics.
All compact reports, log hashes and archive identities are retained under
`docs/measurements/derivative-temporary-storage-2026-11-02/timing/`; local digest,
report and budget replay passes (0.49s). [Readable timing tables](measurements/derivative-temporary-storage-2026-11-02/timing.md)
include all 18 completed cases, RSS, C/Rust ratios and code/frame sizes. No
completed measurement is repeated. Fourth and fifth attempts were requested
after the qualified AMD64 session 2 finished.

Remaining: two qualified timing sessions per architecture, full archive
audit/report, then one substantial PR and the complete final matrix.
Do not mark D2 complete merely because allocations fall.

## Resources and merge rules

No local Rust build, full suite or benchmark. One focused saved-C probe was
compiled and run under the guard. Keep all other focused checks serial, preserve
64 GiB free and do not raise resource limits. Last observed free space: 66 GiB.

Merge only after all exact-head gates and audits pass: squash with an explicit
single-line subject, at most 80 characters, empty body and no attribution/trailers.
Verify merged tree and raw message. Cancel only proven duplicate same-tree main
checks. Rebase the next batch while preserving source tags, then continue PLAN.md.

Documentation is split into results, baseline, frozen protocol and verification;
all 217 link sets, 106 immutable pairs and five plan steps pass (3.04s).
