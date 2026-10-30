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
job `124312094852` passes with 127 summaries / 366 tests audited. Regular ARM
job `124312094382` also passes: 132 summaries / 627 Rust tests, ten wait controls
on Python 3.15.2 and twelve SDK checks. Both logs have only the existing OpenSSL
installation notice. Intel macOS regular job `124312094945` now also passes: its 131-target archive
contains 626 passing tests and no diagnostics. The full job adds the package
check (132 summaries / 627 tests), audited with only the OpenSSL notice. Five
production jobs remain. Direct job endpoints are fresher than aggregate run lists.
Both Windows core/resource archives have no failures or diagnostics; their later
TLS/executable steps are still required. The docs/benchmark audits are
`/private/tmp/fwp-docs-231-377c.audit.json` and `/private/tmp/fwp-231-bench-377c.audit.json`.

Prepared here: [all four current buffer sessions](measurements/buffer-current.md),
their complete source/artifact/hash index and the [next allocation proof and
acceptance requirements](measurements/generated-array-folds.md). 25/48 copy
controls fail; no case passes all four sessions. No failed measured session was
rerun. Four wrong-CPU attempts were rejected before any build or timing.

Declaration `97c8eac6` is published before implementation. The reference compiler
is frozen at `377cf9ce25c65afba595b6413e5bb1d50721ea7a`. The branch implements the restricted
producer-to-fold proof, shared size validation and focused semantics/storage/
cleanup controls: a generated producer in `src/fuse.rs`, an internal checked-count
operation sharing constructor validation, raw/optimized/native semantic cases
and O1/O2, packing on/off allocation controls. Native Windows now selects the
existing numeric-fusion test target too. No compiler change is verified yet.

Initial queued runs `41132906311` and `41134018778` were cancelled before
execution to consolidate coverage. Combined run `41135554961` at `048c92c5`
completed on AMD64 job `124337015027` and ARM64 job `124337015493`. Both pass
12 tests and fail only the new generated-loop interruption fixture: its global
marker expected one loop, but C contains four (other exports and boxed-state
entry points). All other native semantics, size/cleanup tests and independent
observer steps pass; neither overall job passes.

The repair follows the selected worker's `fwp_loop_fields` call and requires
exactly one step boundary inside that definition. The retained C passes six
focused macOS Clang checks (O1/O2 normal, omitted trap cleanup and omitted cancel
cleanup) in 4.30s through the guard. Local follow-ups also fix executable suffixes
and add F32/F64 rounding order in both packing modes plus I8 overflow. Batch all
these repairs in the next push and rerun the affected five-target focused suite;
the unchanged independent observers need not be rebuilt again before timing.

Retained failed-source logs: `/private/tmp/fwp-generated-checks-{arm,amd}-048c.log`.
ARM artifact `13016638162` (SHA-256 `0926217b74d756665010c6103fe57449ee7ae568031dc02d0bd5c65d447c4c33`)
is retained locally as the matching ZIP. AMD artifact `13015659406` (SHA-256
`9efdab2b841678cb0705366b83f5ad04052cc0b18d1af60dc9cc74b9b968527c`) remains on GitHub.
The ARM storage report verifies zero allocations/count calls/count storage/peak
payload for scan lengths 0, 16, 4096 and 262144 at O1/O2; inserted allocations are
rejected. Cleanup acceptance still awaits the repaired native test on both GCCs.
No compiler/runtime implementation change follows `826e447f`.
Audit generated-loop failure/cancellation and observer evidence, then run both
G2 hosts and the final production gate before calling this task complete. The
paired comparison now explicitly selects `generated-array`, reusing the actual
`3ca66b54` ordinary binaries (compiler inputs match declared reference `377cf9ce`).
Exact artifact IDs avoid duplicate names from rejected-host attempts. The old
scalar-dispatch comparison remains verifiable; timing and code budgets are unchanged.
No candidate timings have run.

Guarded local checks: rustfmt 0.37s; primitive inventory 1.41s (394 declarations,
384 symbols, 40 aliases, no review symbols); workflow lint 6.28s. Inventory
records the working source hashes at `/private/tmp/fwp-generated-array-inventory.json`.
Observer rejection controls: two tests pass in 0.13s; eight edited Python scripts
parse; workflow lint passes. No local compiler build or full test suite ran. Keep builds and validation on
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
