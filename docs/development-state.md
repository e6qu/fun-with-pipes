# Current work

**Next:** finish the exact-head CI audit and delivery of
[PR #253](https://github.com/e6qu/fun-with-pipes/pull/253). Keep its tested head
fixed while production jobs run. Independently run the prepared next change's
focused checks; open no second PR until #253 merges.

## Active PR: direct calls in scalar array maps

- Worktree `.worktrees/direct-array-callbacks`; final head
  `893942291b0f1e51a23488c9dea2a9d811acfab1`.
- Production run `41662326563`: eight of nine jobs pass and are fully audited.
  Linux AMD64 has finished its suite and is completing packaging/uploads,
  without reported failures.
- Documentation run `41662323124`, job `126008450991`: passed full-log audit.
- Scratch `.worktrees/gradient-work/collect-253.py` downloads and audits each
  completed gate. Require all nine production jobs plus docs before squash.
- Squash subject: `Call known scalar array functions directly`, empty body.
  Verify the raw one-line message and equality with the tested tree.
- The [complete report](measurements/direct-array-time-2026-11-03/README.md)
  retains four original runtime sessions, 16 speed misses and one noisy case.
  Do not repeat completed timings or relabel those limits as passed.
- [Native checks](measurements/direct-array-callbacks-2026-11-03/README.md) and
  [compiler costs](measurements/direct-array-analysis-2026-11-03/README.md) pass.
  Their frozen sources, repairs and recovered reference identities are retained.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve direct-call selection and ownership contract |
| 2 | Verified | Keep three-host native and cleanup evidence |
| 3 | Verified | Preserve all original runtime/compiler outcomes and failed limits |
| 4 | In progress | Audit final gates, squash and verify the merge tree |

## Prepared next group: same-type conversions

Checkout `.worktrees/scalar-array-identities`, branch `scalar-array-identities`,
starts at #253's final head. Its [contract](measurements/scalar-array-identities.md)
is frozen at `97c47a422a029e9913953ecba5aa6f4cb81414f4`, tag
`roadmap/scalar-array-identities-protocol-2026-11-03`, before runtime/optimizer edits.

The draft uses the recommended rule that same-type conversion preserves all bits;
the pending user question has no recorded reply. This is an explicit working
choice, not a recorded user decision. Cross-type rules remain unchanged. If the
answer changes, revise the contract explicitly before delivery or measurement.

Implemented; all three focused native hosts pass. Final-platform verification remains:

- Same-type F16/BF16/F32/F64/F128 conversions preserve bits. Generic F128 still
  allocates an independently owned result box.
- The optimizer removes only `array.map` of the known `F64 -> F64` conversion
  primitive before ownership insertion. No representation or API changes.
- Tests compare exact bits through raw/optimized interpreter and native entries;
  check selector exclusions, moves, aliases, slices, immutable updates, source
  effects and deliberately omitted cleanup. Explicit trap/cancellation probes
  check the generated owner around the following array read. Native allocator
  exhaustion is fatal exit 102, not an unwind; its separate control requires the
  exact status and diagnostic. The contract records this source-review finding.
  Existing failure/cancellation targets also remain in the focused group.

Focused run `41672290329` tests `beddd406153f1976fed00847292207bff9053e22`.
All three jobs pass full-log/artifact audit: 50 integration tests, the selector
unit test and 54 new observations per host. All 948 saved native images have
checked headers/hashes; generated C and 32 GCC native entry images were inspected.
The [complete index](measurements/scalar-array-identities-2026-11-03/native/index.json)
retains logs, sources, controls and matching cross-host transcripts.
Earlier batches `41667037137` and `41670309514`
were cancelled before any jobs started, to include the complete fault checks
and correct their task context. The fault probe now declares a reachable task
function so C generation enables unwinding; ordinary language cases stay task-free.
The three-host batch uses
GCC ARM64/AMD64 and Clang ARM64, production Rust settings, the existing eight
array targets, float-format/core targets and the selector unit test. Audit all
completed targets before a repair push. The extended result-lifetime probe passes eight local Clang O1/O2 executions
(32 storage observations, packed on/off). Saved generated C was recompiled with
only the probe fixture changed; no compiler build ran locally. The
[storage report](measurements/scalar-array-identities-2026-11-03/README.md) records
both the saved allocation and longer backing retention for unique slices.
The exact Rust-generated fixture still needs final platform verification.
Batch its source/docs with any native-check fixes; do not rerun unchanged eight-target
checks merely for this probe extension.
Measurements are frozen at focused-tested `beddd406`, tag
`roadmap/scalar-array-identity-measurement-2026-11-03`. Compiler-cost run
`41678571054` is measuring both compiler hosts. Runtime run `41678576958`
continues both ARM64 sessions; its two AMD64 hosts were rejected before building
or timing (9V74 instead of the frozen 7763). Both full logs and qualification
artifacts are audited in scratch `identity-host-rejections/41678576958`.
Replacement AMD64 sessions are run `41679275708`; do not replace any session
that has begun measurement.
Both use correctness run `41672290329`. No second PR exists yet. The newer branch
adds only the storage probe and documentation; compiler/runtime/library/tooling
sources still match the measured source. Preserve both immutable tags on rebase.
Committed tooling provides a same-source reference disabling only map elimination;
its count budget requires one removed array per update, with existing time/noise
limits. Reference controls (3), budget controls (18), compiler-analysis controls
(7) and raw-source/evidence controls (16) pass in one guarded 20.85s batch.
Grouped-report controls (12), retention controls (3) and reference-upload controls
(2) pass in 5.48s; workflow lint passes in 6.15s.
The first reference-marker check failed because Rust formatting joined the
condition onto one line; the marker was corrected and all controls pass.

## Local checks and limits

Passing guarded checks: Rust formatting (0.13s), standalone standard-library doc
regeneration (1.03s), workflow lint (6.15s), saved-source storage probes (3.45s), unchanged primitive inventory
(394 declarations, 384 symbols, zero review items; 0.64s). The source review's
roadmap audit passed before implementation (242 link sets, 106 anchors; 2.63s).
The earlier documentation audit passed (243 link sets, 106 anchors; 2.50s).
A later handoff rewrite omitted the required roadmap-status heading; the audit
caught it, and the heading is restored without weakening the check. The repaired
audit passes all 244 link sets, 106 anchors and four steps (2.51s).
No compiler build ran locally.

Use `python3 scripts/local-guard.py` serially. Keep at least 64 GiB free disk,
target data below 2 GiB and sampled RSS below 1 GiB, with the 180-second deadline.
Full builds, suites, benchmarks and large regeneration stay on runners.

Leave the detached primary checkout's recovery edits and old worktrees alone.
Parent PR #252 merged as `3034a9d047c2bef44744c6ffc1807146570ced57`; its one-line
message and equality with tested `e2d55aa8` were verified. All ten gate logs are
[retained](measurements/gradient-array-storage-2026-11-03/platforms/final-gates.json).

## Old workflow status checked

Run `38888712709` still appears running, but all six jobs ended October 16.
Every failure was audited in scratch `stale-path-run`: four device negative
controls and two Windows unload setup errors. Commit `9bf203d7` repaired them;
#252's complete native logs verify the affected targets, including both Windows
unload tests. GitHub refuses cancellation because the run is already completed,
while its status endpoints still say running. No active job was stopped. This
service-status inconsistency is not evidence of today's queue cause.
