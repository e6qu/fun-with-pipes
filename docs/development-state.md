# Current work

**Next:** monitor [PR #248](https://github.com/e6qu/fun-with-pipes/pull/248)'s exact-head
nine-job production matrix and documentation. Audit every failed job and completed
target before batching repairs; audit all passing logs before squash merge.
All focused checks and all four timing archive audits are complete. PR #247 is
verified and merged; #248 is the sole active PR.

## Branch and delivery

Worktree `/private/tmp/fwp-array-consumption`, branch `derivative-temporary-storage`.
Primary checkout untouched. The complete batch was rebased onto verified main
`389337b9`; reviewed checkpoint `44407aff` includes all four sessions, the report
checker, regression tests, workflow integration and streamlined tracking. The
final tracking update adds this PR link before production validation starts.
Compiler and test sources are byte-identical to measured `a4f3200c`; the rebased
compiler commit is `b08cdf91`. Immutable measurement tags remain unchanged.
Use `gh pr checks 248` / `gh pr view 248 --json headRefOid,statusCheckRollup` to
identify the final head and run IDs; do not treat draft/skipped jobs as validation.

Initial head `b06a36baa4bc71d56a5a5b4ab821a047f5602196` ran production
`41522419557` and documentation `41522418627`. The documentation failure is a
stale scalar-array reference test comparing current entire C generation against
an old baseline. Repair pins both sides of that historical comparison and adds
a current-source round-trip check preserving unrelated changes; all three tests
pass (0.14s). The complete failed documentation log is retained in verification.
All other completed documentation controls are audited; the apparent earlier
Rust failure is the intentional native-runner propagation control.

The benchmark job `125541517034` passes both tests with no diagnostics. Every
production job was checked before the repair push; no production failure was
reported. Supersede the unfinished initial run when publishing this test/docs-only
repair rather than let two complete matrices consume runners. No production
compiler or native test source changes. Identify the new final run IDs through
PR #248; keep a local status update while gates run rather than restart CI solely
to publish their IDs. Draft/skipped jobs are not validation.

[PR #247](roadmap-history.md#benchmark-driver-comparison-pr-247) merged as
`389337b9495f8fc2c4343339765707c4503b9984`. All nine production jobs and documentation
pass on `bb2e5b29fa6f53b3f187c3fba3fd15d38ff4085b`; every job/target log is audited.
The final macOS ARM64 job `125524990804` passes 126 targets / 379 tests and all
85 corpus programs; full log: 128 summaries / 381 passes / 20 ignored. Its only
diagnostic is an already-installed OpenSSL notice. Two earlier attempts had no
runner. The squash has the identical tested tree and a verified 50-character
single-line message. Duplicate same-tree main runs `41521347856` and `41521347736`
are confirmed cancelled. Full final logs and artifacts remain `/private/tmp/fwp-247-*`.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Fresh baseline and protocol frozen before compiler edits |
| 2 | Verified | Packed storage lowering preserves evaluation order and callback owners |
| 3 | Verified | Both native Linux GCC/Clang suites; all 96 count observations and broken cleanup controls |
| 4 | Verified | All four timings and four rejected hosts audited; the failed timing limit remains open |
| 5 | In progress | PR #248 complete batch; run/audit all final gates, then squash-merge |

## Compiler and correctness evidence

[Report, protocol and verification](measurements/derivative-temporary-storage-2026-11-02/README.md).
A sole-use mapped numeric-record collection becomes one owned word buffer.
All map calls finish before folding; seed evaluation stays at its source position.
Numeric bits own no children. Existing typed cleanup releases the buffer on failure.

| Checkpoint | Source / run | Result |
|---|---|---|
| Baseline | `bb2e5b29` / `41497441785` | Both GCC hosts; all 96 observations audited |
| Frozen protocol | `15aa4c0a` | Published before compiler edits |
| Initial compiler/counts | `229ea441` / `41505591902` | All 96 limits pass; full archives and logs audited |
| First cleanup controls | `0c5b9827` / `41507658382` | GCC/Clang O1/O2; 22 passes per host |
| Expanded callback controls | `76069cfa` / `41509110166` | Boxed fixture omitted stdout initialization; both failures retained |
| Combined repair | `a4f3200c` / `41511493637` | Both native jobs pass 40 tests; counts and actual probes fully audited |

Immutable tags: `roadmap/derivative-temporary-storage-protocol-2026-11-02`,
`roadmap/derivative-temporary-storage-counts-2026-11-02` and
`roadmap/derivative-temporary-storage-runner-2026-11-02`.
Full measured source: `a4f3200c9b97b955c3f3603788eacbfac19fde4e`.

Largest current-only O2 solve: 208,086 → 156,943 managed requests;
21,888 → 17,824 peak managed bytes. Retains, raw tape/workspace storage and
operation counts are unchanged; final storage is zero. All 96 observations match
`2*n+1` fewer requests / `48*n+16` fewer requested bytes per update,
where `n=coordinates-1`. All 52 generated case/control C sources match the initial
implementation; the later compiler repair skips use scans for unrelated bindings.

Coverage includes scalar/boxed callback owners; map/between-stage/fold traps;
cancellation; buffer/final allocation failure; aliases; nine selection exclusions;
and deliberately omitted physical destruction. Eight ordinary probes per host
return zero; eight missing-release probes return 90. Related autodiff, worker
preparation and zip-unwind tests pass. Final archives and independent audits are
`/private/tmp/fwp-packed-final-*`; failed expanded evidence is
`/private/tmp/fwp-packed-expanded-*`. See verification for retained identities.

## Paired timing evidence

All sessions use the immutable `a4f3200c` runner tag and an exact same-source
reference disabling only packed-record lowering. No completed measurement is
repeated. The frozen identical-copy and regression limits are unchanged.

| Measured run / jobs | Result | Independent report |
|---|---|---|
| `41514265188`: ARM1 `125513671132`, ARM2 `125513671731` | Both pass | `41517598393` passes |
| `41514265188`: AMD2 `125513671211` | Zero-update history 2.024% slower, limit 2%; all other limits pass | Same report preserves failure |
| `41518220615`: AMD1 `125527179997` | Pass; complete log has no diagnostics | `41521413075` passes |

Four session-1 CPU rejections stopped before building/timing: runs `41514265188`
(EPYC 9V74), `41514783218` (9V45), `41515994738` (9V74), `41517608442` (9V45).
Their independent reports `41517598393`, `41517734538`, `41517746039`,
`41518209544` all pass. The fifth host had the required EPYC 7763.

Compact reports, complete compressed logs, source/binary identities and full
archive metadata are retained in
`docs/measurements/derivative-temporary-storage-2026-11-02/timing/`.
[Readable tables](measurements/derivative-temporary-storage-2026-11-02/timing.md)
show all 24 cases. Across all four sessions, cases with at least 199 updates use 5.1–14.2% less time. All copy controls pass;
the failed AMD64 zero-update limit and separate D2 goals remain open.

Use `scripts/report-packed-records.py` to regenerate/check the final tables.
The final compact archive and metadata are `/private/tmp/fwp-packed-final-report*`;
artifact `13178215928` is digest-verified. Full final retained archive is
`13177398568`; full original retained archives are identified in each run's
`report-artifacts.json`. Full native archives were independently audited on
GitHub; only compact results were downloaded locally. Final local replay and
render pass (0.26s / 0.74s); no unexpected job diagnostics.

## Focused checks and resources

- Count/archive replay: pass (4.10s). Actual-probe/binary audits: pass (0.13/0.14s).
  Source/count equivalence: pass (0.26s). Full logs have no unexpected diagnostics.
- Reference mutation checks: three pass; timing budgets: twelve; historical
  archive checks: eleven; evidence retention: three. Longest guard run: 50.92s.
- New compact-report checks: five pass (1.93s), rejecting changed medians,
  erased failures and damaged payload/binary/reference identities. Workflow lint
  passes (0.26s). Four-session report replay/render passes (0.74s).
- Last published docs: 218 link sets, 106 immutable pairs and five plan steps
  pass (2.89s). Run the link check after the final docs/plan changes.

No local full Rust build, suite or benchmark. One saved-C fixture repair was
compiled/run under the guard earlier; full work remains on GitHub. Last free
space: 65.4 GiB; no generated local target data. Keep focused checks serial with
`python3 scripts/local-guard.py`; do not raise or bypass resource limits.

Merge only after all exact-head gates and audits pass. Supply a single-line
subject of at most 80 characters and an empty body; verify raw message and tree.
