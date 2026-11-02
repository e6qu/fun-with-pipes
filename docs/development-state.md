# Current work

**Next:** monitor [PR #248](https://github.com/e6qu/fun-with-pipes/pull/248)'s exact-head
nine-job production matrix and documentation. Audit every failed job and completed
target before batching repairs; audit all passing logs before squash merge.
All focused checks and all four timing archive audits are complete. PR #247 is
verified and merged; #248 is the sole active PR.

## Branch and delivery

Worktree `/private/tmp/fwp-array-consumption`, next-batch branch
`numeric-owner-transfers`, based on published PR #248 head `32aae4f7`.
The PR branch `derivative-temporary-storage` remains unchanged at that head.
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

Local live status: repaired head `32aae4f79b66f5e88e9aded39d6df794439b7430` runs
production `41524286630`. Benchmark job `125547928770` passes both tests; its
full log has no diagnostics. Other production jobs are running or queued with
no reported failed steps. Documentation `41524286169` passes on attempt 2,
job `125552574269`: 75 Python groups / 477 tests, tutorial copy, 218 doc link
sets, 106 immutable pairs and the complete four-session timing replay.
Full logs: `/private/tmp/fwp-248-final-{docs,bench}.log`; guarded audits pass
(0.13s / 0.14s). The docs log's duplicate/unknown-target errors and deliberate
Rust failure are native-runner rejection/propagation controls, verified against
`scripts/test-native-test-runner.py`; no unexpected diagnostics. The superseded
production run `41522419557` is confirmed stopped. This status paragraph is
intentionally unpushed while the final gates run.

Both macOS corpus artifacts (`13180805582` Intel, `13180378374` ARM64) pass
independent digest/head checks: each has 85 unique programs start and finish,
one test passes, no diagnostics. Archives
`/private/tmp/fwp-248-macos-{amd,arm}-corpus.zip`, audit helper
`/private/tmp/fwp-248-audit-corpus.py` (0.14s). Production target-archive helper
`/private/tmp/fwp-248-audit-targets.py` pins the current head and checks the exact
native shard inventory, every test summary and compiler diagnostics.

Windows initial target archives also pass: ARM64 `13181790848`, AMD64
`13180623483`; each has 57 logs / 135 summaries / 431 passing tests / two ignored,
with no diagnostics. Native host identities and archive digests match. Files
`/private/tmp/fwp-248-windows-{arm,amd}.zip`, guarded audits 0.13s / 0.14s.
Their full jobs still require TLS/executable checks and complete-log audits.

Apple Silicon regular artifact `13181552842` passes: 131 targets / 650 tests /
four ignored, no diagnostics, correct digest/head/shard inventory. Archive
`/private/tmp/fwp-248-macos-arm-regular.zip`; audit 0.14s. The complete job
`125547928724` now passes and is audited: 132 Rust summaries / 651 passes / four
ignored, plus 11 process and 13 SDK tests. Diagnostics are the already-installed
OpenSSL notice and the echoed `-W error::ResourceWarning` command, not a warning.
Full log `/private/tmp/fwp-248-final-macos-arm-regular.log`.

Apple Silicon ownership job `125547928273` also passes and is fully audited:
128 Rust summaries / 384 passes / 20 ignored, only the OpenSSL notice. Target
artifact `13181114405`: 126 targets / 382 passes / 20 ignored, no diagnostics.
Full log `/private/tmp/fwp-248-final-macos-arm-ownership.log`, target archive
`/private/tmp/fwp-248-macos-arm-ownership.zip`; both audits 0.14s.

Documentation attempt 1 completed every check and checkout cleanup by 21:04:09Z,
about 3m20s after its 21:00:49Z start, without a test failure. GitHub nevertheless
marked it cancelled for the five-minute limit at 21:06:55Z. Preserve that as a
non-passing attempt; the same-head targeted rerun now passes. Evidence:
`/private/tmp/fwp-248-docs-final.log` and `/private/tmp/fwp-248-docs-timeout-*.json`.
Do not change compiler code or widen limits based on this runner-finalization delay.

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

## Next source investigation after this delivery

[The next-batch investigation](measurements/derivative-owner-transfers.md) now
retains the proof requirements and all source-attributed observations in the
repository. `scripts/check-derivative-owner-sites.py` replays both native count
archives with explicit paths/source; 48 sources / 96 observations pass (0.50s).
Its output equals the independent temporary audit exactly (0.14s). No compiler
source or production test changes, no new measurement run, no second PR.

The retained `a4f3200c` largest current-only O2 profile has 77,411 effective
retains. Two mapper-argument preparations contribute 25,472 each; a tuple-field
projection contributes another 25,472. Together they account for 76,416 retains
(98.7%). These are source-attributed counts, not a proven optimization or speedup.

In saved `129-199-current-O2/ownership-base.c`, the mapper sites are
`fwp_args164` lines 17284–17285. The other site is `w124`, an ordinary function
from `(Rev[F64], Rev[F64])` to `Rev[F64]`: it copies field 0 into `l117`, retains
it, copies field 1, then drops the original field-0 owner before arithmetic.
No disassembly inference was used. IDs apply only to that saved source.

The source audit now verifies all 48 saved C sources and 96 observations:
mapper inputs contribute `2*p` retains and the separated-field transfer `p`,
where `p=(coordinates-1)*updates`. Guarded replay passes (0.38s); helper
`/private/tmp/fwp-audit-next-arc-sites.py`, output `/private/tmp/fwp-next-arc-sites.json`.
Next preparation should examine two separate proofs: transferring already separated field owners
without a retain/release pair; and borrowing mapper inputs while their input
lists remain owned. Preserve boxed/function-value entries, aliases, failure and
cancellation cleanup. Existing selection deliberately keeps owning callback
entries; removing `fwp_args` alone would be unsafe. Freeze selection and counts
before changing either contract. Do not claim all three sites can be removed.

Source review confirms `parameter_type` and `continuing_owners` currently reject
nested records, while packed-map callbacks explicitly retain owning entries.
Thus removing their argument retains requires more than enabling a flag. Draft
proofs, exclusions, cleanup tests and compiler-cost checks are saved in
`/private/tmp/fwp-next-arc-protocol.md`. It is preparation, not a frozen protocol;
publish numerical requirements before any next-batch compiler edits. Consider
passing proved numeric leaves directly as well as borrowing element boxes.
The saved mapper `w164` only forwards `l1, l0` to `w124`; there is no later
local read proving continuing ownership. Borrowing must carry the outer list's
lifetime through that forwarding call. Numeric-leaf passing instead needs both
calls coordinated, since the current ABI splits one record level only.

The next branch now freezes the first implementation stage in
[field-owner-transfer-protocol.md](measurements/field-owner-transfer-protocol.md):
complete bounded transfers of two to eight already-separated counted fields,
at least `p` fewer retains across the existing 96 observations, mapper input
ownership unchanged. Publish its immutable tag before compiler edits. This is
part of the grouped next PR, not an extra small PR or a repeat full matrix.

Protocol published at `5cf8813a` under the immutable tag above, before edits.
Next-stage candidate code: `src/cgen/field_transfers.rs` and its call from
`bind_local`. The matcher recognizes the exact complete projection group and
retains original IR/call-liveness pointers; three unit controls cover reordered
and eight-field transfers, interrupted/repeated/partial/live-parent rejection.
Rustfmt passes (0.14s); an initial missing `fn` in a test name was corrected.
No Rust build or candidate runtime verification yet. Native direct/boxed/shared
owner controls, two/eight fields, repeated child aliases and deliberate extra
retain / omitted physical release are drafted in `record_conversion_ownership`
and `tests/fixtures/field_owner_transfer*`. `field_owner_unwind_probe.c` covers
entry/post-transfer traps and real cancellation, result-boxing allocation failure,
retained aliases and deliberately missing physical release. All controls still
require compiled runner verification. This is not verified support and not PR #248 code.

Focused suite `field-owner-checks` in `numerics.yml` runs both native Linux hosts:
build/lint, three selection tests, primitive inventory, five GCC target groups
and three Clang groups, retaining toolchain/source identities and every probe/log.
No timings or full matrix in that suite. Workflow lint passes (6.28s), Rust
format check passes (0.27s). Publish an immutable candidate tag and dispatch
this focused suite; continue monitoring/auditing PR #248 separately.

Candidate `0d5e852c08080b56b77db75da8686b432f217df2` is now published as
`roadmap/field-owner-checks-2026-11-03`. Focused run `41533745677` was cancelled
while both jobs were still queued: `125580257436` / `125580257834`, both with
empty step lists. Source review found repeated continuation scans could become
quadratic. The repair lazily indexes last local mentions once per eligible
function and checks each complete group in constant time; a fourth unit control
checks enclosing continuations. No source trees are cloned or mutated. Metadata
of the unstarted run: `/private/tmp/fwp-field-owner-superseded-jobs.json`.
Publish the combined repair and a new immutable probe tag before dispatching
the replacement focused suite. Neither this
branch nor the focused run changes PR #248's exact head `32aae4f7`. Mapper-input
borrowing, measured count reduction and final timing acceptance remain unproved.

PR #248's ARM64 compiler artifact `13181104014` is verified by archive digest,
manifest source and binary digest, extracted to `/private/tmp/fwp-248-macos-arm`.
It formats the new fwp fixture (0.01s), interprets the expected reversed tuples
(0.26s), and emits baseline C (0.26s) to `/private/tmp/fwp-field-transfer-baseline.c`.
These are fixture/baseline checks, not verification of the candidate. The package
contains a tarball plus manifest (not a bare binary); only its regular executable
was extracted. `fmt --help` is not supported; the documented `fmt PATH` was used.

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
