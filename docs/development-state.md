# Current work

**Next:** audit production run `41454128868` and documentation `41453962382`
at exact head `d53fb07a639214739d7648fcd1dd2a022d9b8e10`, then squash merge if all pass.
Documentation passed and its full log was audited; all nine production gates remain pending.

## Branch and delivery

- Active follow-up worktree `/private/tmp/fwp-array-consumption`, branch
  `array-consumption-diagnostics`; no second PR. Current PR validation stays at
  `/private/tmp/fwp-array-construction`, branch `array-construction-costs`.
  [PR #245](https://github.com/e6qu/fun-with-pipes/pull/245) is ready for review.
  Preserve the primary checkout and other worktrees.
- [PR #244](roadmap-history.md#paired-matrix-columns-pr-244) passed all nine jobs
  and documentation. Verified squash merge `e70f0e2d30112df0c7ee0912a77bac251092a539`
  has the tested tree and one message line, without a body or trailers.
- Keep one PR. Merge #245 only after the exact final head passes all required
  gates and every completed target/job log is audited. Use an explicit subject
  of at most 80 characters and an empty squash body; verify the result.
- Retain verified reductions with missed timing goals explicitly open, as directed
  in earlier batches. Do not erase or relax frozen limits, or claim the whole
  roadmap is complete. [PLAN.md](../PLAN.md) names the next investigation.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Original construction diagnostic: GCC ARM64/AMD64 O1/O2, exact values/storage/cleanup controls |
| 2 | Verified | All four baseline sessions audited; both ARM64 and AMD64 session 2 pass, AMD64 session 1 retains six copy failures |
| 3 | Verified | Repaired focused safety: five targets / 22 tests per host, all three hosts pass; complete logs/probes audited |
| 4 | Implemented | Four paired sessions audited; ARM64 passes every limit; AMD64 retains four consumption and four copy failures; storage/cleanup pass |
| 5 | In progress | Exact head `d53fb07a` runs production `41454128868` and docs `41453962382`; audit all nine jobs and documentation |

## Source and verification identities

- [Construction diagnostic](measurements/array-construction-costs.md#diagnostic-results-november-2-2026):
  run `41427397530`, source `d3ddc94d6eb8c5c58af74159051670241dd23e5b`, tag
  `roadmap/array-construction-diagnostics-2026-11-02`. Both materialized paths
  allocate once; composed source allocates zero. Full raw/source audits pass.
- [Phase baseline](measurements/array-construction-phases-2026-11-02/README.md):
  source `f05e25f8730453103f862a354324f1d660a3550d`, tag
  `roadmap/array-construction-phase-runner-2026-11-02`. Initial run `41437433015`;
  completed AMD64 session 2: `41445523250` / job `125277535727`. All four archives
  audited; six AMD64 session-1 failures and five prebuild host rejections retained.
- Candidate protocol `5cf1c80f`, tag `roadmap/scalar-array-selection-protocol-2026-11-02`,
  predates the selection-rule change. The source change adds ordinary numeric
  captures to existing direct-callback eligibility; no runtime change or syntax.
- [Focused safety](measurements/scalar-array-safety-2026-11-02/README.md):
  run `41448056587`, source `240d889742e2fffc3e6a4375bec8a2b52e4900f3`.
  macOS ARM64 job `125286026052`, Linux ARM64 `125286026439`, Linux AMD64
  `125286026473`; artifacts `13143626431`, `13144385796`, `13144565684` respectively.
  All 15 target logs, 30 callback probe executions and both Linux construction
  reports audited. No compiler diagnostic remains. The linked record explains
  both test-harness repairs from failed run `41442126003`.
- [Paired timings](measurements/scalar-array-captures-2026-11-02/README.md):
  source `f8a558daa42fc07930f7a93870b6dcbcf2580bb3`, immutable tag
  `roadmap/scalar-array-timing-2026-11-02`. Both compilers use the same source;
  the reference disables only the recorded selection rule. Safety trees match.

| Paired session | Run / job | Artifact | Outcome |
|---|---|---|---|
| ARM64 1 | `41449731209` / `125291685373` | `13143169442` | Pass; raw audit 1.66s |
| ARM64 2 | `41449731209` / `125291685304` | `13144423532` | Pass; raw audit 1.68s |
| AMD64 1 | `41451889484` / `125298862465` | `13146010459` | Three failed limits retained; raw audit 1.86s |
| AMD64 2 | `41449731209` / `125291685261` | `13144686686` | Five failed limits retained; raw audit 1.85s |

Three undeclared AMD64 session-1 hosts stopped before building; all qualification
archives/logs are retained. No completed timing was retried. ARM64 construction
uses 84.5–84.9% less time, total 81.2–81.6% less; managed storage is unchanged.
AMD64 large-array copy controls pass, but consumption is 4.93–5.23% slower.
Generated consumption C is unchanged; this does not explain the time difference.
The failed goals remain in the plan. Candidate/reference memory profiles pass.

## Checks and resources

- All raw phase/paired archives audited against source, flags, every saved file,
  outputs, cleanup controls, samples and summaries. Compact audits reproduce all
  original failures; documentation CI runs baseline and candidate modes.
- Focused local checks use `python3 scripts/local-guard.py`, serially: Rust format,
  selected saved-C Clang probes, source/reference controls, raw-evidence audits,
  actionlint and roadmap links. These do not replace native runner checks.
- Final-head documentation run `41453962382` / job `125305832207` passes
  at `d53fb07a`; full log audited, including intentional test-runner failures.
- Independent next-task preparation uses retained data only: sample analysis
  `/private/tmp/fwp-array-sample-positions.py` and `.json` (guarded, 0.25s),
  draft protocol `/private/tmp/fwp-array-consumption-protocol.md`. Large AMD64
  consumption excess is mostly early within-process samples; this is not a cause
  or an acceptance change. No new experiment has been dispatched.
- No local compiler build, full suite or benchmark. Last free disk: 65 GiB.
  Preserve the guard's 64 GiB / 1 GiB RSS / 2 GiB target / 180-second limits.

## Follow-up preparation while production runs

[Sample analysis](measurements/array-sample-positions.md) retains every process,
sample position and original failed limit. `summarize-array-samples.py` reproduces
16 dataset/session/case records (guarded, 0.25s). The [fixed diagnostic](measurements/array-consumption-setup.md)
uses retained C, explicit 0/1,024 preparation calls and both wall/CPU observations.
Its implementation and measurement remain pending; no runtime change is selected.
