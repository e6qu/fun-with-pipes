# Current work

**Next:** audit PR #244's remaining production gates, then squash-merge only its
passing final head. Meanwhile run the frozen array phase comparison; do not change
compiler selection rules before measuring the source/driver boundary.

## Active PR and independent preparation

- PR: https://github.com/e6qu/fun-with-pipes/pull/244
- Final head: `555c4981695f4819586ef0a57114a36c2c9476ef`; preserve it unless CI needs repair.
- Production `41425537461`: benchmark, both macOS ARM64 jobs, Intel ownership,
  Linux ARM64 and Windows ARM64 pass; Linux AMD64, Intel regular and Windows AMD64 remain.
- Docs `41425537447` / `125211125800` passes. Benchmark/docs full logs audited;
  documentation test-runner failures are intentional negative controls.
- macOS ARM64 ownership archive `13134110468`: all 126 target logs pass, no
  unexpected diagnostics; the full completed job log is also audited clean.
- PR worktree: `/private/tmp/fwp-matrix-calculation`, branch `matrix-calculation-costs`.
- Independent branch/worktree: `array-construction-costs`, `/private/tmp/fwp-array-construction`.
  It starts at #244's tested head. Open no second PR. After #244 merges, preserve
  measured-source tags and rebase only the new commits onto its verified squash tree.

[PR #243](roadmap-history.md#current-numerical-costs-pr-243) is fully verified and
merged as `ea9938de`; its identical-tree duplicate main checks were cancelled.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Matrix protocol published before diagnostics |
| 2 | Verified | `41412675762` reproduces original binaries on both GCC architectures |
| 3 | Verified | Paired-loop diagnostic `41416927586`; safety `41417716203` passes both GCC hosts and Clang ARM64 |
| 4 | Verified | Four sessions/three host rejections retained; audit `41422907313` passes; six timing controls remain open |
| 5 | In progress | #244 final production gates, full-log audits and verified squash merge |

[Matrix results and source IDs](measurements/matrix-calculation-costs.md) retain
about 33% less calculation time on ARM64 and 31% less for large AMD64, unchanged
managed storage, 48 extra worker-frame bytes and 128/320 extra code bytes.
Six small-AMD64 copy limits remain open. Keep the qualified gains under the user's
standing preference; do not turn those failed controls into passes.

The stack-table renderer incorrectly required a fixed frame for AMD64 driver
`main`; GCC reports `dynamic,bounded`. Repair run `41425270814` at `fce7b3cc`
passes and the regenerated tables verify. All preparation/measurement/audit
sources have remote retention tags. Do not repeat completed timings.

## Next batch: array construction

[Protocol and results](measurements/array-construction-costs.md):

- Protocol `afbd14dd`, tag `roadmap/array-construction-protocol-2026-11-02`.
- Native diagnostic `41427397530`, source `d3ddc94d6eb8c5c58af74159051670241dd23e5b`,
  retained as `roadmap/array-construction-diagnostics-2026-11-02`.
- AMD64 job `125217227607` / artifact `13132143987`; ARM64 job `125217227733` /
  artifact `13132374453`. Both pass at O1/O2 with production Rust O1 compilers.
  Full logs, every recorded file identity and all ordinary/profile outputs audited.
- Both materialized paths allocate once; composed source already allocates zero.
  Exact results, small interpreter cases and missing-release controls pass.
- Materialized scalar captures retain generic callback dispatch in generated and
  optimized GCC source. The phase protocol now fixes six roles, two sizes, two
  sessions/architecture, construction/consumption/inclusive timers and separate
  instrumented phase observations. The runner completes both sizes' builds,
  exact-output/storage checks and missing-release controls before any timing.
  Baseline comparisons impose noise controls, not a speculative required speedup.
  Ordinary profiles and instrumented phases have separate raw artifacts.
- Earlier run `41426573182` failed only source formatting on both hosts. The fixture
  was fixed with #243's verified package; failure logs and source tag remain.

[Sample-position analysis](measurements/matrix-sample-positions.md) keeps all four
matrix sessions and locates much of the mismatch in early within-process samples.
It establishes no cause, changes no acceptance rule, and requires no new timing.

## Local checks and resources

Focused checks run serially through `python3 scripts/local-guard.py`:

- Matrix: patch/schedule/evidence/retention/table controls; formatting and actionlint
  pass. Both generated table sets verify; final roadmap audit passes (2.87s).
- Array: six evidence controls (0.13s), actionlint (5.52s), roadmap audit (2.99s),
  full archive/file/output checks (2.32s), retained-sample reduction (2.67s).
  Persistent `check-array-construction.py` reproduces source/observer mutations,
  results, storage and all command outcomes for both archives (2.46s).
- Phase runner: six timer-boundary controls pass (0.13s); 13 shared-evidence
  controls pass (5.34s). Actionlint passes (6.29s); both historical table sets
  reproduce with explicit metric selection (7.08s and 7.36s).
- No local compiler build, full suite or benchmark. #243's downloaded release
  package was used only for formatting/small interpreter preflights, not native
  GCC acceptance. Last free disk: 66 GiB; keep the guard's fixed limits.
