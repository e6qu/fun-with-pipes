# Current work

**Next:** finish PR #231 verification at `377cf9ce25c65afba595b6413e5bb1d50721ea7a`:
production run `41128213017`, documentation `41128213024`. All nine production
jobs and docs must pass and be audited before the authorized squash merge.
Keep the subject at most 80 characters and the body empty.

Branch `generated-array-folds` prepares the next related batch. Its temporary
worktree may be removed while #231 runs to preserve disk space; the committed
branch retains all preparation. It has no PR and no
compiler changes. The active PR remains [#231](https://github.com/e6qu/fun-with-pipes/pull/231)
in `/private/tmp/fwp-ownership-peer-baselines`; its handoff has the latest live
job status and full earlier repair audit. Preserve that head while CI runs.

Prepared here: [all four current buffer sessions](measurements/buffer-current.md),
their complete source/artifact/hash index and the [next allocation proof and
acceptance requirements](measurements/generated-array-folds.md). 25/48 copy
controls fail; no case passes all four sessions. No failed measured session was
rerun. Four wrong-CPU attempts were rejected before any build or timing.

Before changing compiler code, publish this declaration and freeze the reference
at #231's final tested source. Then implement the restricted producer-to-fold
proof, its size validation and focused semantics/storage/cleanup controls. Keep
all full builds and validation on GitHub; use guarded local focused checks only.
Do not describe this proposal as implemented or verified.

## Evidence and limits

The [current buffer index](measurements/buffer-wait-repair-artifacts-2026-10-30.json)
records exact source, runs, jobs, archives, hashes, hosts and every case result.
Local independent audits are `/private/tmp/fwp-buffer-baseline-{arm,amd}-{1,2}-3ca6.audit.json`;
the matching ZIPs and logs remain retained. Timing acceptance stays open for
#231's scalar folds, D2 and N1; their earlier failures remain in their reports.
The [plan](../PLAN.md) lists the remaining B1/B2 and V1/V2 work.

## Recovery and resources

Preserve the primary checkout at `/Users/zardoz/projects/fun-with-pipes`: detached
#209, dirty recovery handoff and untracked compiler-abort report. Automatic
approval review rejected replacing its handoff; do not retry. Its backup is
`/private/tmp/fwp-primary-recovery-before-file-checks.md`. Other delivery worktrees
retain their local handoffs; do not publish there.

Keep all original CI archives. Previous #224 and descent-output evidence is
compressed with verified file-hash audits; no evidence was discarded. Free space
is close to the 64 GiB floor. Use `scripts/local-guard.py` for serial focused
checks and stop if refused; full builds, suites and measurements run on GitHub.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and cycle guarantees |
| 2 | Verified | Preserve A1–A6; broader ARC costs remain in B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's remaining timing requirement |
| 6 | In progress | Resolve N1's control before N2 timing acceptance |
| 7 | In progress | Remove the selected intermediate array; finish B1/B2 |
| 8 | In progress | Finish numerical and integrated V1/V2 acceptance |
