# Current work

**Next:** monitor [PR #248](https://github.com/e6qu/fun-with-pipes/pull/248)'s exact-head
nine-job production matrix and documentation. Audit every failed job and completed
target before batching repairs; audit all passing logs before squash merge.
All focused checks and all four timing archive audits are complete. PR #247 is
verified and merged; #248 is the sole active PR.

## Checkout and final gates

Worktree `/private/tmp/fwp-array-consumption`, branch `numeric-owner-transfers`,
published head `6d490362b62cd354f33894a4e8f7806ebdfab96c`. It contains the next
batch, based on PR #248 head `32aae4f79b66f5e88e9aded39d6df794439b7430`.
PR branch `derivative-temporary-storage` is unchanged. Primary checkout untouched.

Production run `41524286630`; documentation `41524286169`, both on `32aae4f7`.
Eight production jobs pass and are audited; Linux AMD64 is still running.

| Gate | Job | Audit |
|---|---|---|
| Linux ARM64 | `125547928713` | Pass; 258 Rust summaries / 1,038 passes / 20 ignored |
| Linux AMD64 | `125547928815` | Native tests running; final log and target audit pending |
| macOS ARM64 regular | `125547928724` | Pass; 132 summaries / 651 passes / four ignored |
| macOS AMD64 regular | `125547928730` | Pass; same counts |
| macOS ARM64 ownership | `125547928273` | Pass; 128 summaries / 384 passes / 20 ignored |
| macOS AMD64 ownership | `125547928688` | Pass; same counts |
| Windows AMD64 | `125547928872` | Pass; 206 summaries / 856 passes / 12 ignored |
| Windows ARM64 | `125547930919` | Pass; same counts |
| C/Rust benchmarks | `125547928770` | Pass; two tests, no diagnostics |
| Documentation, attempt 2 | `125552574269` | Pass; 75 Python groups / 477 tests, tutorial copies, 218 link sets, 106 immutable pairs and four timing reports |

Full logs: `/private/tmp/fwp-248-final-*.log`. Completed target archives have
verified source, digest, shard inventory and summaries. Metadata:
`/private/tmp/fwp-248-final-artifacts.json`. Audit helpers:
`/private/tmp/fwp-248-audit-{targets,corpus,docs}.py` and
`/private/tmp/fwp-audit-full-job.py`; guarded checks take 0.13–0.14s.

- Linux ARM target artifact `13184911088`: 257 targets / 1,037 passes / 20 ignored.
- macOS regular targets: ARM `13181552842`, AMD `13182584956`; each 131 targets /
  650 passes. Ownership: ARM `13181114405`, AMD `13183716026`; 126 / 382.
- macOS corpus: ARM `13180378374`, AMD `13180805582`; each 85 programs complete,
  one test passes, no diagnostics.
- Windows initial targets: ARM `13181790848`, AMD `13180623483`; each 57 logs /
  135 summaries / 431 passes / two ignored. Reuse: ARM `13184275520`, AMD
  `13184375671`; each 12 passes.

No unexpected diagnostics. macOS reports an already-installed OpenSSL notice.
The `-W error::ResourceWarning` text is an echoed command. Windows' 16 deliberate
panics are caught entry/child failure controls in `src/sched.rs:668–715`.
Documentation's duplicate/unknown-target errors and deliberate Rust failure are
rejection/propagation controls in `scripts/test-native-test-runner.py`.

Initial documentation run `41522418627`, job `125541513412`, failed because
`test-scalar-array-reference.py` compared an entire current generator with an old
baseline. Repair pins both historical sources and checks that the transformation
preserves unrelated current changes. Three tests pass (0.14s); compiler/native
sources are unchanged. The complete failed log is retained in verification.
Superseded production `41522419557` is confirmed cancelled; completed benchmark
`125541517034` passes both tests. No other production step failed before repair.

Documentation attempt 1 completed all checks/cleanup in about 3m20s, but GitHub
cancelled runner finalization at its five-minute limit. Preserve that non-passing
attempt; the same-head retry passes. Evidence: `/private/tmp/fwp-248-docs-final.log`
and `fwp-248-docs-timeout-*.json`. No compiler change or deadline increase.

[PR #247](roadmap-history.md#benchmark-driver-comparison-pr-247) merged as
`389337b9495f8fc2c4343339765707c4503b9984`: all gates/logs audited, identical tested
tree and 50-character single-line message verified. Duplicate main runs
`41521347856` / `41521347736` are confirmed cancelled.

When #248 passes, supply an explicit subject of at most 80 characters and empty
body; verify the raw message and identical tested tree. Rebase only next-batch
commits after `32aae4f7` onto that squash. Preserve immutable probe tags. Cancel
duplicate main CI only after proving tree identity.

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

## Next grouped ARC batch

[Investigation and exact sites](measurements/derivative-owner-transfers.md):
48 generated sources / 96 observations attribute `2*p` retains to mapper input
preparation and `p` to the first tuple-field projection, where
`p=(coordinates-1)*updates`. At the largest input, these are 76,416 of 77,411
retains (98.7%). This is an opportunity, not a verified saving or speedup.
The repository source audit reproduces the independent report (0.50s).

1. **Complete field transfers.** Frozen at `5cf8813a` under
   `roadmap/field-owner-transfer-protocol-2026-11-02`; see the
   [selection, cleanup and count requirements](measurements/field-owner-transfer-protocol.md).
   Candidate `src/cgen/field_transfers.rs` moves all two-to-eight separately owned
   counted fields, retaining original IR/liveness identities. Borrowed/resource,
   repeated/partial/interrupted transfers and live parents are excluded.
2. **Callback input owners.** Not implemented or frozen yet. The forwarding
   callback has no continuing local owner; enabling nested borrows or deleting
   argument retains alone is unsafe. Compare a proved borrowed call chain with
   passing numeric leaves through both internal calls. Freeze selection and
   count/compiler-cost limits before changing this contract.
3. **Combined verification and delivery.** Focused checks/counts during development;
   paired timing and one final full platform matrix after the related batch is
   complete. Preserve allocation savings, arithmetic and cleanup.

### Current focused candidate

Head `6d490362b62cd354f33894a4e8f7806ebdfab96c`, immutable tag
`roadmap/field-owner-linear-checks-2026-11-03`; run
[41535112048](https://github.com/e6qu/fun-with-pipes/actions/runs/41535112048).
Both native jobs build/lint successfully and pass all four selection unit tests.
All eight target logs per host are audited, with source and archive digests checked.
Each compiler fails the two new native tests at their selection assertions; all
other targets pass (22 passes / four failures per host across GCC and Clang).
Both complete job logs are now audited; all diagnostics are those selection
failures and their propagated exits. Complete compressed logs and artifact IDs
are retained in `docs/measurements/field-owner-transfer-checks-2026-11-03/`.

The cause is pointer identity across different trees: C emission clones the
stored body, while the candidate indexed the stored body. The repair puts the
lazy index on `FnGen`, tied to the exact emission root used by call liveness.
All four emission paths were checked: worker, boxed entry, borrowed callback and
normalized loop. No added tree copy or per-binding scan. Publish the combined
repair and dispatch the focused suite; runtime/count savings remain unverified.

The repaired focused suite also reuses its built compiler for all 96 derivative
count observations. The new `field-owners` policy requires at least `p` fewer
retains, no allocation/peak growth, unchanged raw storage/work and zero final
storage. Twelve observer/acceptance tests pass locally (13.81s); workflow lint
passes (6.72s). Full timings and platform matrix wait for the grouped batch.

Four selection tests cover complete/reordered/eight-field transfers, exclusions
and enclosing continuations. Native controls in `record_conversion_ownership`
and `tests/fixtures/field_owner_transfer*` cover direct/boxed/shared owners,
two/eight fields, repeated child aliases, exact counts, traps, actual cancellation,
result-boxing allocation failure and deliberately omitted physical release.
The focused workflow runs five GCC and three Clang target groups at production
Rust settings and generated O1/O2. No new target or reduced coverage.

First probe `41533745677` was cancelled before either job started. Review found
repeated continuation scans could be quadratic; the repair indexes last local
mentions once per eligible function, including enclosing continuations. Pointers
are compared only; the original expression is neither cloned nor mutated.
Metadata: `/private/tmp/fwp-field-owner-superseded-jobs.json`.

Local formatting passes (0.37s); workflow lint (6.28s); docs audit (3.00s).
Verified PR #248 compiler artifact `13181104014` formats and interprets the new
fixture and emits baseline C (0.01s / 0.26s / 0.25s). Executable:
`/private/tmp/fwp-248-macos-arm`; these are baseline checks, not candidate validation.

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
