# Session handoff

Updated 2026-10-14. The user requested continued development after PR #136
completed the six-step roadmap. Current branch: `autodiff-active-prefix`, [PR #137](https://github.com/e6qu/fun-with-pipes/pull/137) (draft).
Publication, fixes and squash merge after all final-head gates remain authorized.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Streamlined docs and session handoff |
| 2 | Verified | Expanded typed collector-free ownership |
| 3 | Verified | Array producer fusion, numeric tail loops and wide workers |
| 4 | Verified | Nested reverse AD, checkpointing and lifetime controls |
| 5 | Verified | Actual F16/BF16/F128 and protocol v2 |
| 6 | Verified | Native Windows ARM64/AMD64 and standalone packages |
| 7 | In progress | Numeric backward-pass prefix bounds, regression controls and measurements |

## Accepted baseline

[PR #136](https://github.com/e6qu/fun-with-pipes/pull/136) merged as `2684241d`,
tree-identical to `26f2c68a`. All nine production jobs and docs pass; see
[the acceptance record](roadmap-history.md#pr-136-merge-acceptance).
Historical preparation anchors are not work to replay.

## Current work

Numeric backward passes currently reserve adjoints and scan the entire tape,
including nodes recorded after every seeded output. The follow-up computes the
last relevant node in output validation order, retains every input adjoint and
processes only that prefix. Parents precede children, so the suffix cannot
contribute. Both Rust interpretation and native C change together. Forward
recording and managed nested-tape behavior stay intact.

Implementation and regression controls are ready for focused runner checks;
no new native support or performance result is verified yet.
Required controls include duplicate/constant/empty outputs, truncated seed/output
pairs, invalid/mixed tokens and diagnostic precedence, nested AD, workspace
reuse, physical cleanup after validation/allocation failure and cancellation,
and deliberate broken implementations. Measure actual adjoint allocation and
scan bounds, retain generated C/native instructions and compare equivalent
workloads on GitHub. Do not use stale local compiler binaries as an oracle.

## Local checks

All checks use `python3 scripts/local-guard.py`: `cargo fmt --all` (0.99s),
`cargo clippy --all-targets -- -D warnings` (24.14s initially, 0.37s after tests),
`cargo test --lib tape_validation_tests -- --test-threads=1` (four pass, 19.47s),
current-runtime C syntax (0.27s), current formatter compilation (0.39s) and AST/
idempotence validation of `ad_unused_suffix.fwp` (0.52s), measurement-script
syntax (0.15s), and `python3 scripts/check-roadmap.py` (48 link sets, 106 anchors,
7 steps, 2.87s) pass. Full native/WASM suites and measurements remain on runners.

Workspace growth refinement: all four focused interpreter tests pass again
(13.52s). New native controls exercise cold/warm storage with GC and reuse
verification and reject full-storage/full-scan regressions. Growing an existing
adjoint workspace retains geometric growth; a cold workspace uses only the
required prefix. Workflow lint passes (0.89s).

## Boundaries

Checked native ARC still rejects unproved cycles, mutable/retained graphs and
State/AD lifetimes. Service/remote/library/WASM executable ARC admission is
outside the completed bundle. Generic wide values and some lazy producers can
allocate. Checkpointing trades work for memory; prior measurements remain in
[benchmarks](benchmarks.md). No universal collector-free or C/Rust speed claim.

## Next action

Next: dispatch and monitor the `autodiff` and `wasm` focused workflows for the
current head. Initial runs 38600695264/38600698982 at `5f2aeac0` were cancelled
while queued because they predate the workspace growth refinement. They are
not final evidence.
Fix every failure, record measured results, then require all nine production
jobs plus docs on the final head before squash merge with one line of at most
80 characters and an empty body. Keep this follow-up together in one PR.

Use `python3 scripts/local-guard.py COMMAND...` for serial local checks; preserve
64 GiB free disk, target below 2 GiB, sampled aggregate RSS below 1 GiB and the
180-second deadline. Full builds, suites and measurements belong on GitHub.
