# Current work

**Next:** finish PR #231 verification at `377cf9ce25c65afba595b6413e5bb1d50721ea7a`:
production run `41128213017`, documentation `41128213024`. All nine production
jobs and docs must pass and be audited before the authorized squash merge.
Keep the subject at most 80 characters and the body empty.

Work continues on `generated-array-folds` in `/private/tmp/fwp-ownership-peer-baselines`.
The separate temporary checkout was removed to recover disk space. This branch
has no PR. The active PR remains [#231](https://github.com/e6qu/fun-with-pipes/pull/231),
whose remote head stays `377cf9ce`; do not push to `ownership-peer-baselines`.
Its live handoff is saved in local-only commit `23839191` on that branch.
Documentation and the benchmark gate pass with complete audits. The repaired
wait tests pass on both macOS and Windows architectures. macOS ARM ownership
job `124312094852` also passes: all 127 summaries / 366 tests were audited, with
only the existing OpenSSL installation notice. Seven native jobs are still
running without reported failed steps. The docs/benchmark audits are
`/private/tmp/fwp-docs-231-377c.audit.json` and `/private/tmp/fwp-231-bench-377c.audit.json`.

Prepared here: [all four current buffer sessions](measurements/buffer-current.md),
their complete source/artifact/hash index and the [next allocation proof and
acceptance requirements](measurements/generated-array-folds.md). 25/48 copy
controls fail; no case passes all four sessions. No failed measured session was
rerun. Four wrong-CPU attempts were rejected before any build or timing.

Declaration `97c8eac6` is published before implementation. The reference compiler
is frozen at `377cf9ce25c65afba595b6413e5bb1d50721ea7a`. Implement the restricted
producer-to-fold proof, shared size validation and focused semantics/storage/
cleanup controls while monitoring #231. The first implementation is in the
working tree: a generated producer in `src/fuse.rs`, an internal checked-count
operation sharing constructor validation, raw/optimized/native semantic cases
and O1/O2, packing on/off allocation controls. Native Windows now selects the
existing numeric-fusion test target too. No compiler change is verified yet.

Next implementation check: dispatch `scalar-fold-checks` on this branch after
publishing the coherent first batch. It now covers numeric fusion and array
size limits as well as the existing scalar/cleanup targets, retaining artifacts.
Finish dedicated generated-loop failure/cancellation evidence, update the
materialized-scan storage observers and comparison reference/budgets, run G2
checks and the final production gate before calling this task complete.
The old scan/storage scripts assume an allocated scan array; do not run them
against the new candidate until their explicit expectations are updated.

Guarded local checks: rustfmt 0.37s; primitive inventory 1.41s (394 declarations,
384 symbols, 40 aliases, no review symbols); workflow lint 6.28s. Inventory
records the working source hashes at `/private/tmp/fwp-generated-array-inventory.json`.
No local compiler build or full test suite ran. Keep builds and validation on
GitHub; use guarded local focused checks only.

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
