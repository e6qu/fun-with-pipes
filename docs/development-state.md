# Current work

**Next:** publish the unused-loop-entry and analysis-order repairs, then verify
all three focused hosts and both G2 hosts. Repair `f82016d9` passes all 247 Rust
cases on each focused host, but code-size budgets fail on both Linux hosts;
G2's Intel identical-copy timing control also fails. Keep all original limits.
Focused run `41158976900`, G2 run `41158981359`. The three focused
jobs are GCC AMD `124412028515`, GCC ARM `124412028732`, Clang ARM `124412028844`.
G2 jobs: Intel macOS `124412043318`, Linux AMD `124412043370`.
Audit all completed targets and diagnostics before any further repair push. First focused
run `41157639553` at `855f53ce8d3dd3aaebb62e97112a3afb6a860226` is fully audited:
Linux has one failing exact-cost case each; macOS has that case and two
missing-OpenSSL-header failures. All other completed targets pass.
The [predeclared contract](measurements/state-range-folds.md) also needs existing
G2 budgets and complete final-head production validation before delivery.
Publishing this preparation branch does not open a second PR. Open the next
delivery PR only after #232 passes and merges.

Preparation worktree `/private/tmp/fwp-state-range-folds`, branch
`state-range-folds`, based on `05d96484`. Its sparse checkout excludes large
immutable evidence archives to preserve the local disk floor. The active
delivery worktree has the full documentation.

## Active delivery

[PR #232](https://github.com/e6qu/fun-with-pipes/pull/232) remains the only open
PR. Its worktree is `/private/tmp/fwp-ownership-peer-baselines`; preserve head
`05d96484a77241c9782a420e76ea69094b965e11` while final gates run. Production run
`41153845461`, docs run `41153845377`: documentation, benchmarks, both ARM macOS
jobs, Intel ownership and both Windows hosts pass with complete log audits. Two Linux jobs remain
running; Intel regular passes its tests but artifact creation fails with DNS
`ENOTFOUND`. GitHub refuses a job rerun until the original run finishes (HTTP 403).
The active
worktree's handoff owns every job ID, prior failure audit and recovery details.
Squash-merge only after all nine production jobs and docs pass, with one subject
of at most 80 characters and an explicitly empty body. Verify the merged tree.

## Source investigation

The retained macOS compiler at `d92939b8` has the same compiler/runtime as the
preparation base. Guarded IR/C emission for `each-count` passes (0.25s), retained
as `/private/tmp/fwp-state-range-before.{c,ir,stdout}`. Its known callback consumes
the input through a fold after a trivial unit binding; the range remains outside
the State handler. The unchanged interpreter passes the new semantic/cancellation fixture. A Clang
O2 preflight of its before-teardown observer passes; omitting State scratch release
exits 239 as required (1.94s total). Compiler/Rust-test formatting passes. These
checks do not validate the drafted compiler. No full local build or suite ran.
Five rejected-shape fixtures type-check with the unchanged compiler; both new
arithmetic-trap fixtures match their expected output and exit 101 (1.08s).
The first focused run compiles/lints successfully on all three hosts. All new
State semantic, trap, cancellation and rejected-shape tests pass. Linux passes
225 library cases and 21 of 22 integration cases; macOS passes 224 library cases
and 20 of 22 integration cases. Failures: the initial loop tuple's unit field
incorrectly prevents direct field entry (one extra 32-byte box); the focused
macOS workflow omits `FWP_OPENSSL_DIR`. Both causes are repaired together.
Complete logs: `/private/tmp/fwp-state-range-{amd,arm,mac}-855f.log`; AMD archive
`13025312268` retains the generated C used to identify the box. The analysis
snapshot regression passes; new functions outside the snapshot stay unproved.

Guarded repair preflights: `cargo fmt --all` passes (1.60s), measurement controls
pass (2 cases, 0.14s), workflow lint passes (4.90s). The retained C with the direct
field entry passes Clang O0/O2 at 32/128: exactly two allocations / 152 bytes and
restored storage (1.35s). This isolates the cause but does not test rebuilt Rust.
The size-check harness passes six reference inputs and cleanup (0.73s), after
restoring the root-completion call bypassed by replacing CLI dispatch. Its
initial observer failure was a harness defect, not a runtime leak. No full
local build or suite ran. Final runner measurements and repaired compiler
checks remain pending; do not claim either from these preflights.

## Remaining focused repairs

At `f82016d9`, all three hosts pass 247 Rust cases; macOS's complete log audit
passes. Both Linux jobs also pass two measurement controls, but worker code
grows 13.62%/16.26% (ARM/AMD), above the frozen 5%. Frames are unchanged.
Retained ARM generated C identifies an unused boxed-step entry kept through the
runtime function table. The repair avoids marking that entry for direct loops;
other function-value uses still require it. A new regression tests both uses.
The new regression's source/output preflight passes (0.61s); its first draft
used invalid record syntax/function application, corrected before publication.

G2 Linux passes all checks (227 Rust cases, complete log audit). All three failed
Linux size/Intel G2 jobs are completely audited; there are no other diagnostics
or failed targets. Intel passes
units, lint, counts, absolute limits and startup, but N=32's identical copies
differ by 5.63% (>5%). Logs and audits use `/private/tmp/fwp-state-*-f820.*`.
The repaired six-order sequence balances each 64-triplet batch's copy positions,
not merely the whole run. No sample count, batch size, median or limit changes.
An extracted production-O1 Rust check passes the new schedule and rejects the
old one (1.34s). This repairs a protocol imbalance; it does not establish that
the Intel variation is resolved. The complete failed observation stays recorded
in [the analysis report](measurements/ownership-analysis.md#state-range-recheck).

Preserve the dirty detached primary checkout and original CI archives. Full
builds, broad tests and measurements belong on GitHub. No local guard limit may
be raised or bypassed. Timing acceptance for prior changes remains open.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and cycle guarantees |
| 2 | Verified | Preserve scoped A1–A6; broader ARC costs remain in B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's remaining timing requirement |
| 6 | In progress | Resolve N1's control before N2 timing acceptance |
| 7 | In progress | Deliver generated-array elimination; finish B1/B2 |
| 8 | In progress | Finish numerical and integrated V1/V2 acceptance |
