# Current work

**Next:** finish the exact-head CI audit and delivery of
[PR #253](https://github.com/e6qu/fun-with-pipes/pull/253). Keep its tested head
fixed while production jobs run. Independently run the prepared next change's
focused checks; open no second PR until #253 merges.

## Active PR: direct calls in scalar array maps

- Worktree `.worktrees/direct-array-callbacks`; final head
  `893942291b0f1e51a23488c9dea2a9d811acfab1`.
- Production run `41662326563`: nine jobs. Benchmark job passed full-log audit;
  the other eight jobs are running or queued, with no reported failures.
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
  effects and deliberately omitted cleanup. Existing failure/cancellation tests
  remain in the focused group.

Publish the grouped implementation and dispatch `scalar-identity-checks`. It uses
GCC ARM64/AMD64 and Clang ARM64, production Rust settings, the existing eight
array targets, float-format/core targets and the selector unit test. Audit all
completed targets before a repair push. No new timing or second PR exists yet.

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
