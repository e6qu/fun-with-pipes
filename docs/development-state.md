# Current work

Preparation worktree `/private/tmp/fwp-returned-callables`, branch
`returned-callable-peers`, contains only the next B1
[callable comparison plan](measurements/returned-callables.md). It is based on
State preparation `903b1819`; no callable implementation or measurement has run,
and no PR is open for it. Finish the active deliveries below first. Historical
measurement copies are omitted by sparse checkout in this preparation worktree;
their Git objects are preserved. Its new links have a focused local check;
the complete documentation audit belongs to the eventual integrated source.

**Next:** monitor PR #232's Intel macOS retry `124422281020`, audit its full log,
and squash-merge only after all gates pass. Then publish
the prepared State range batch as the next single PR and run its full matrix.
Keep one active PR. Preserve passing heads while remaining gates run.

## Active delivery: PR #232

Worktree `/private/tmp/fwp-ownership-peer-baselines`, branch `generated-array-folds`,
head `05d96484a77241c9782a420e76ea69094b965e11`. Production run `41153845461`,
documentation run `41153845377`. Nine gates pass with complete log audits:
docs, benchmarks, both ARM macOS jobs, Intel ownership, both Windows hosts and
both Linux hosts. Linux AMD completed with 997 Rust / 12 Python cases.

Intel regular job `124396181638` passes all tests (628 Rust / 22 Python cases)
but artifact creation fails with DNS `ENOTFOUND`. Its single-job retry began at
02:58 UTC as `124422281020`, attempt 2 of the same run/head. Earlier passing jobs
are carried forward under new IDs; they were not rerun. The initial HTTP 403
refusal ended when the original run completed. Do not waive the upload. The
active worktree's handoff owns all job IDs/audits.
Squash subject: `Eliminate temporary arrays in numeric folds`; supply an empty
body, verify one line <=80 characters and the merged tree against the tested head.

## Prepared State range batch

Worktree `/private/tmp/fwp-state-range-folds`, branch `state-range-folds`, based
on #232's head. No second PR is open. Protocol `68c99a3d` preceded implementation.
Current compiler/test source: `ea0f300b2c553b519a1a9ae266b7b974c388bdd7`.
Documentation and evidence distinguish focused success from final acceptance.
Tracked documentation is restored for the complete roadmap/link audit.

The [contract and results](measurements/state-range-folds.md) describe the scope:
replace a known single-use I64 range input to a State consumer with scalar bounds,
keep the handler, effects and failure order, and reject unproved shapes. Correct
unit-field loop entry avoids an initial box. Direct loops no longer retain an
unused runtime callback entry; actual function values retain theirs.

Focused run `41160459668` passes on all three hosts, with complete audits:
GCC AMD `124416661976`, GCC ARM `124416662138`, Clang ARM `124416662052`. Each
passes 226 library + 23 integration cases; Linux also passes two measurement
controls. At O0/O2 and n=32/128, exactly two allocations / 152 bytes remain.
Worker bytes shrink 1,880 -> 1,104 on ARM and 1,814 -> 1,103 on AMD. Largest frame
components stay 944/1,008 bytes. Both frozen code/stack budgets pass.

G2 run `41160463103` passes and is fully audited: AMD `124416671214`, Intel macOS
`124416671326`, each with 228 Rust cases, all-target lint and startup checks.
The corrected schedule balances identical-copy positions within each compared
batch. Samples, batch sizes, medians and limits are unchanged. Maximum copy
variation is 0.42%/1.32%, below 5%; this is not a compiler speedup claim.

[Passing evidence](measurements/state-range-focused-2026-10-31.json) retains
cost rows, code/stack reports, verified binary identities, commands and 13,824
analysis timings. [Rejected evidence](measurements/state-range-rejected-2026-10-31.json)
retains the earlier code-size failures and all 13,824 prior timings. At `f82016d9`,
all semantics/cleanup passed, but worker code grew 13.62%/16.26% and Intel's
identical-copy difference was 5.63%. Those failures are not overwritten. The
first `855f53ce` run exposed the unit-field box and missing focused macOS
`FWP_OPENSSL_DIR`; both are fixed and verified. Full production remains pending.

The maintained `scripts/check-state-range-evidence.py` now recomputes both saved
decisions. Its three tests preserve the rejected code/timing results and reject
15 kinds of missing or damaged evidence. Documentation CI runs these controls;
no benchmark or full compiler suite is repeated for this audit addition.

## Local checks and recovery

No full local build, suite or benchmark ran. All focused checks used the guard:
Rust format 1.69s; diff check 0.14s; workflow lint 5.59s; two measurement controls
0.14s; retained-C unit-field repair at O0/O2 1.35s; reference measurement harness
0.73s; loop-function-value source preflight 0.61s; extracted production-O1 timing
schedule test 1.34s (new order passes, old order fails). Complete log audits and
evidence recomputation also pass under the guard. These do not replace runner gates.
The retained-evidence controls pass in 0.13s. Their first run correctly rejected
a damaged startup limit but raised `ValueError`; an explicit cardinality check
now reports the intended assertion failure, and every damage control passes.

Raw logs/metadata/audits/archives use `/private/tmp/fwp-state-*`; suffixes `855f`,
`f820`, `ea0f` identify sources. Record generators and auditors are temporary
`/private/tmp/fwp-record-state-*` and `/private/tmp/fwp-audit-state-*` scripts.
The primary detached checkout now has a current-worktree pointer; its old handoff
is preserved byte-for-byte below it and in
`/private/tmp/fwp-primary-handoff-before-current-pointer-2026-10-31.md`.
Preserve its other edits. Three clean historical worktrees omit duplicate archived
measurement files to restore the 64-GiB disk floor; no evidence was removed from Git.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Preserve scoped A1–A6; broader costs belong to B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the recorded loop gap |
| 5 | In progress | Meet D2's remaining timing requirement |
| 6 | In progress | Resolve N1 controls before N2 timing acceptance |
| 7 | In progress | Deliver array/State reductions and finish B1/B2 comparisons |
| 8 | In progress | Complete numerical and integrated V1/V2 acceptance |

Keep the limits and retained failures in [PLAN.md](../PLAN.md); these allocation
reductions do not close D2/N1 execution-timing acceptance.
