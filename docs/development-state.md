# Current work

**Next:** audit the compiler-cost and runtime comparisons for identity F64 array
maps, finish their report, then run the complete final-head matrix and merge the
one grouped PR. Preserve every completed timing and missed limit. Replace only
hosts rejected before building or measuring.

## Checkout and frozen sources

- Worktree/branch: `.worktrees/scalar-array-identities` / `scalar-array-identities`.
  Scratch: `.worktrees/gradient-work`. [Draft PR #254](https://github.com/e6qu/fun-with-pipes/pull/254)
  is the only active PR; keep it draft until the complete report is ready.
- PR #253 merged as `ed5b8830a3cb90a4b6a248464d279ac8d1d0ccc7`; the next branch
  was rebased onto it with identical before/after trees. Leave the detached primary
  checkout's recovery edits and old worktrees alone.
- Contract: `97c47a422a029e9913953ecba5aa6f4cb81414f4`, immutable tag
  `roadmap/scalar-array-identities-protocol-2026-11-03`, before implementation.
- Native checks and measurements: `beddd406153f1976fed00847292207bff9053e22`,
  immutable tag `roadmap/scalar-array-identity-measurement-2026-11-03`.
  Current compiler/runtime/library/tooling sources match that source. Later changes
  add documentation, storage observations to the C probe and distinct BF16 NaN
  test payloads; no compiler/runtime/library/tooling changes.
- Same-type conversion preserving all bits is the stated working rule; the pending
  design question has no recorded reply. Cross-type conversion is unchanged.
  If the answer changes, revise the contract explicitly before delivery.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve scalar semantics, narrow selection and frozen reference |
| 2 | Verified | Keep three-host bit, owner, failure and source/native evidence |
| 3 | In progress | Audit both compiler jobs and four qualified runtime sessions |
| 4 | Pending | Complete report; final nine production jobs plus docs; verified squash |

## Verified behavior and storage

[Run 41672290329](https://github.com/e6qu/fun-with-pipes/actions/runs/41672290329)
passes on GCC ARM64/AMD64 and Clang ARM64: 50 integration tests, the selection
unit test and 54 new observations per host. Every full/target log is audited.
[The complete index](measurements/scalar-array-identities-2026-11-03/native/index.json)
retains sources, controls and matching cross-host transcripts. All 948 saved native
images have checked headers/hashes; 32 GCC entry images were also inspected.

The selected F64 map transfers its input owner before reference-count insertion.
Same-type scalar conversion preserves all five formats' bits; generic F128 still
returns an independently owned box. Tests cover source effects, aliases, slices,
updates and cleanup. Fatal allocator failure exits 102; recoverable traps and
cancellation unwind. The fault probe declares a task so real unwind code is enabled.
Two earlier queued batches were cancelled before any job started to complete that
harness; no executed test was discarded.

The [storage report](measurements/scalar-array-identities-2026-11-03/README.md)
adds eight local Clang O1/O2 executions and 32 observations, using saved generated
C with only the probe extended. It shows both saved allocation and a unique slice
retaining its larger backing array. The exact Rust-generated extension still needs
the final platform matrix. Source review also corrected a duplicated BF16 NaN
payload: `0x42` set its quiet bit, so use `0x21` and require distinct test patterns.
The frozen run has 18 distinct BF16 patterns; final tests have 20. This changes no
runtime semantics. Do not rerun the unchanged eight-target focused group.

## Measurements in progress

- [Compiler-cost run `41678571054`](measurements/scalar-array-identity-analysis-2026-11-03/README.md):
  both jobs and all 480 commands pass full audit. Maximum time increase 0.832%,
  peak RSS increase 0.142%, identical-copy difference 1.767%.
  Scratch `audit-identity-analysis.py` and `identity-analysis/`.
- Runtime run `41678576958`: both ARM64 sessions completed. Each reports eight
  missed 5% speed gains, with no other failed limits. Full job logs are inspected
  in `identity-runtime-first/`; raw audit run `41682284697` is queued.
- Four AMD64 hosts were rejected before building/timing (two 9V74, two 9V45,
  instead of frozen 7763). Their complete logs and qualification artifacts are
  audited under scratch `identity-host-rejections/`.
- AMD64 session 2 completed in `41679275708`, with eight missed 5% gains and
  no other failed limits in its full log. Raw audit: `41684684676`. Session 1
  was rejected there and again in `41682465813`; only its unmeasured replacement
  is being rescheduled. Do not repeat measured sessions.
- Draft documentation run `41681546983` at `602f449c` exhausted its five-minute
  budget after a 4m14s full-history fetch. Every completed check passed; cancellation
  interrupted the buffer-control group. The repair retains full commits/tags with
  `blob:none` fetching, including review heads, and adds the identity reference
  control to this gate. Its fresh-clone result remains to be verified in CI.
  The draft production workflow is intentionally skipped, not a verified gate.
- Correctness prerequisite for every measurement is `41672290329`. The reference
  disables only map removal; both sides include the scalar repair. Count budgets
  require at least one removed array per selected update. Keep the frozen compiler,
  timing/noise and stack limits and all older timing goals explicit.

## Completed delivery

PR #253's nine production jobs (`41662326563`) and documentation (`41662323124`)
pass at `893942291b0f1e51a23488c9dea2a9d811acfab1`; all logs are audited and
[retained](measurements/direct-array-callbacks-2026-11-03/platforms/final-gates.json).
Its squash message is exactly `Call known scalar array functions directly`, with
no body/trailers, and its tree equals that tested head. Duplicate same-tree main
runs `41680031792` and `41680031784` were cancelled after verifying no failed steps.
Keep its sixteen speed misses and one noisy result open in [PLAN.md](../PLAN.md).

## Local checks and limits

Passing guarded checks: Rust formatting; generated standard-library docs; workflow
lint; unchanged primitive inventory (394 declarations, 384 symbols); reference,
budget, compiler-analysis and raw-evidence controls. The documentation audit
caught and repaired a missing roadmap-status heading; keep that required section.
Latest audit: 245 document link sets, 106 anchors, four plan steps (2.51s).
The saved-source storage probes pass in 3.45s; retained evidence reconciles in 0.25s.
The checkout repair passes workflow lint (0.25s), identity-reference controls
(3 tests, 0.12s) and documentation audit (2.51s). No compiler build, full suite
or benchmark ran locally.

Use `python3 scripts/local-guard.py` serially: 64 GiB free disk, target data below
2 GiB, sampled RSS below 1 GiB, 180 seconds. Full work stays on GitHub runners.
Old run `38888712709` is a service-status ghost: all six jobs completed October 16;
its errors were fixed by `9bf203d7` and verified in #252. It has no active work.
