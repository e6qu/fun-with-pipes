# Current work

**Next:** dispatch and audit the frozen same-source timing comparison using
verified safety run `41448056587`; retain every completed outcome.
Keep source, safety checks, timing, docs and final validation in one substantial PR.

## Branch and last verified delivery

- Worktree: `/private/tmp/fwp-array-construction`; branch `array-construction-costs`.
- Draft PR: https://github.com/e6qu/fun-with-pipes/pull/245. Draft status skips the
  full production matrix; mark ready only after focused safety, timings and docs
  are complete. Final-head nine production gates and documentation still gate merge.
- [PR #244](roadmap-history.md#paired-matrix-columns-pr-244) passed all nine production
  jobs plus documentation; every completed target/job log was audited. Squash merge
  `e70f0e2d30112df0c7ee0912a77bac251092a539` has the tested tree and exactly one
  message line with no body/trailers. Identical-tree main runs were cancelled.
- The array branch rebases only its ten new commits onto that verified merge.
  Original protocol/diagnostic/measurement sources have remote retention tags.
  No second PR was opened while #244 ran. Finish the current batch in #245.
- Preserve the primary checkout and existing worktrees. No local compiler build,
  full suite or benchmark; use runners for those workloads.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Construction diagnostic `41427397530`: both production GCC architectures at O1/O2, exact source/storage/control audit |
| 2 | In progress | All four sessions audited; both ARM64 and AMD64 session 2 pass; AMD64 session 1 retains six failed timing-copy limits |
| 3 | Verified | Repair `240d8897` passes all three hosts in `41448056587`; every target/probe and Linux construction record audited |
| 4 | Pending | Acceptance frozen; paired runner prepared, timing requires all three focused safety jobs first |
| 5 | Pending | Publish one coherent PR; nine final-head production gates, docs, audit and verified squash merge |

## Array construction evidence

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
- Phase measurement `41437433015` at `f05e25f8730453103f862a354324f1d660a3550d`:
  both ARM64 sessions pass and independently audit (0.59s/0.60s). AMD64 session 1
  audits (0.83s) with six failed copy limits retained, never retried. Source/driver
  construction differs 7.16–7.48 times on qualified ARM64; filling dominates.
  [Results and identities](measurements/array-construction-phases-2026-11-02/README.md)
  retain compressed reports, every file hash and full job logs.
  AMD64 session 2 rejected five undeclared CPUs before any build/timing; all
  qualification records and full logs are retained. Run `41445523250`, job
  `125277535727`, artifact `13141323354` finally used the declared EPYC 7763:
  all correctness, storage and copy limits pass. Raw archive audit passes (0.85s).
  The source is retained as `roadmap/array-construction-phase-runner-2026-11-02`.
  All four complete archives have been audited; session 1's six failures remain.
- Existing static-callback tests now also cover scalar captures, count-before-capture
  order, callback reuse and partial cleanup. Fixture formatting, raw interpreter
  preflight and Rust formatting pass (0.02s, 0.27s, 0.27s). Native checks remain
  for the combined batch. `array_callback` now also accepts all-plain-scalar
  captures while retaining existing owned-capture eligibility. The expanded probe
  counts generic dispatch, preserves signed-zero/NaN/subnormal bits and checks
  cancellation after two stores, including omitted-cleanup and extra-dispatch
  controls. Size tests add captured arithmetic overflow and array-size rejection.
  Protocol tag: `roadmap/scalar-array-selection-protocol-2026-11-02`.
  Grouped suite: `scalar-array-checks` (GCC ARM64/AMD64 and Clang ARM64), using
  five existing targets plus Linux construction diagnostics. No full CI yet.
- [Focused safety](measurements/scalar-array-safety-2026-11-02/README.md) passes
  run `41448056587` at `240d8897`: macOS job `125286026052`, Linux ARM64
  `125286026439`, Linux AMD64 `125286026473`. All 15 target logs, 30 callback
  probe executions and both Linux construction reports audited (3.01s). No compiler
  diagnostic remains. Five targets / 22 tests pass per host; source still allocates
  once when materialized and zero times when composed. Saved manifests identify
  artifacts `13143626431`, `13144385796`, `13144565684` respectively.
  The linked record explains the two repaired harness defects in `41442126003`;
  no production runtime change was required. Clang local probe checks preceded
  this independent GCC/Clang runner verification.
- Paired timing suite `scalar-array-time` is prepared but not dispatched. It
  requires `evidence_run` naming the successful focused run and compares its exact
  `src/runtime/lib/tests` trees. `prepare-scalar-array-reference.py` changes only
  the recorded selection clause; two patch controls pass (0.12s). The reference
  codegen file exactly matches the baseline. The audit's explicit comparison mode
  still reproduces original ARM64 raw evidence (0.59s); actionlint passes (6.27s).
  The compact retained-record audit also reconstructs all four sessions and six
  failed AMD64 limits (0.49s); documentation CI runs it with explicit comparison
  selection. Its candidate mode also checks reference/safety identities and
  reconstructs the frozen speed and storage limits; candidate evidence is pending.
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
