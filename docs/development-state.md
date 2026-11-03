# Current work

**Next:** finish the exact-head CI audit and delivery of
[PR #253](https://github.com/e6qu/fun-with-pipes/pull/253). Keep its tested head
fixed while production jobs run. Independently run the prepared next change's
focused checks; open no second PR until #253 merges.

## Active PR: direct calls in scalar array maps

- Worktree `.worktrees/direct-array-callbacks`; final head
  `893942291b0f1e51a23488c9dea2a9d811acfab1`.
- Production run `41662326563`: nine jobs. Benchmark and regular macOS ARM64 jobs passed full-log audit (131 target logs
  for macOS). The other seven jobs are running, with no reported failures.
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

Implementation is prepared but unverified:

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

Focused run `41667037137` at `b361fa451cea35674c90830e1fbff325455acaf5` is
was cancelled before any of its three jobs started so the complete fault checks
and measurement tooling can run together. Replacement run `41670309514` at
`9bbbc9f50ef3b03ef4405f49f77550efebd1cf98` has not started. Source review found
the fault probe must declare a reachable task function so C generation enables
unwinding; the ordinary language cases stay task-free. Replace this unstarted
batch after that harness correction, rather than executing a knowingly invalid
probe. The three-host batch uses
GCC ARM64/AMD64 and Clang ARM64, production Rust settings, the existing eight
array targets, float-format/core targets and the selector unit test. Audit all
completed targets before a repair push. No new timing or second PR exists yet. Measurement tooling is prepared locally: a
same-source reference disables only map elimination while preserving scalar fixes;
its count budget requires one removed array per update, with existing time/noise
limits. Reference controls (3), budget controls (18), compiler-analysis controls
(7) and raw-source/evidence controls (16) pass in one guarded 20.85s batch.
Grouped-report controls (12), retention controls (3) and reference-upload controls
(2) pass in 5.48s; workflow lint passes in 6.15s.
The first reference-marker check failed because Rust formatting joined the
condition onto one line; the marker was corrected and all controls pass.

## Local checks and limits

Passing guarded checks: Rust formatting (0.13s), standalone standard-library doc
regeneration (1.03s), workflow lint (6.15s), unchanged primitive inventory
(394 declarations, 384 symbols, zero review items; 0.64s). The source review's
roadmap audit passed before implementation (242 link sets, 106 anchors; 2.63s).
The updated documentation audit passes (243 link sets, 106 anchors; 2.50s).
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
