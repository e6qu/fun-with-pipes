# Next: finish the grouped derivative PR's native validation

**Next:** verify all nine production jobs, documentation and both G2 hosts on
this branch’s final evidence commit, then audit every completed target and
compiler diagnostic before squash-merging [PR #226](https://github.com/e6qu/fun-with-pipes/pull/226).
Use one subject line of at most 80 characters and an empty body. The prior native
repair and focused analysis runs are fully audited; they do not replace the final
commit’s gates. Worktree `/private/tmp/fwp-ad-recording`, branch `ad-recording-costs`.
Keep this delivery’s production code unchanged while its checks run.

## Current checks

| Source / run | Status and evidence |
|---|---|
| `80da3971` / `40863393272` | All nine production jobs pass. Every test target and compiler diagnostic is audited; no unresolved failure remains in this run. |
| `7af1a518` / `40866146124` | Both G2 hosts pass: Linux job 123421318020, Intel job 123421317692. Each passes 223 tests in three summaries and all-target lint. All 13,824 durations, medians and limits independently audited. |
| `7af1a518` / `40866128330` | Documentation passes; full log audited, including the intentionally failing test-runner controls. |

G2's ignored measurement test now interleaves fresh proofs. Production analysis
and every original limit remain unchanged. Identical-copy variation is at most
0.16% on Linux and 0.69% on Intel. The [analysis report](measurements/ownership-analysis.md)
retains the original noisy failure, the later 6.89% failed control and the passing
repair. Earlier passing samples do not erase either failed observation.

The native repair corrects the foreign-callback test's expected record name to
`CallbackWords`. The inference fix preserves nominal record identity; ownership
and unwind checks are unchanged. The original run `40849857724` at `04efac8a`
was fully audited: this was the only failure on six native platforms; both macOS
ownership jobs and benchmarks passed. The exact CI compiler also reproduces the
correct name in raw execution and native Clang O1/O2. At 80da3971, regular ARM
macOS passes all callback lifetime and deliberately broken cleanup controls.
Optional golden-failure uploads allow absent files when another target fails;
mandatory test logs and evidence remain checked.

Full local job logs are `/private/tmp/fwp-226-*-80da.log` and `*-7af1.log`.
Each regular macOS job has 132 summaries/622 passing tests; each ownership job
has 127/362; each Linux job has 257/987; each Windows job has 202/805; benchmarks
have 2/2. Final-head acceptance remains outstanding.

## What this PR delivers

**Keep the allocation reduction; D2 remains open.** This is the user's explicit
decision, not a change to the frozen timing rule. Source `8e299f9f` proves that
scalar `ad.push` copies its four fields without retaining the argument pointer.
Existing stack analysis removes that temporary heap record; typed
`ad.push-owned` is excluded. The 256-operation fixture removes exactly 256 heap
records at O1/O2 with workspace reuse on/off. Derivative and failure/cancellation,
mixed/stale-node, caller-record overwrite and nested-scope checks pass.

Four sessions at `98b252a8`, run `40837836845`, are fully audited: 368 images,
320 stack reports, every output/timing/storage ledger and deliberately broken
control. Allocation, cleanup, code and stack limits pass. The combined timing
rule fails: all one-update cases and some AMD history cases miss 5%; one AMD case
is 1.42% slower. The [results](measurements/descent-costs.md#scalar-recording-results-allocation-reduction-retained-speed-goal-open)
retain the frozen limits, all failures, raw reports/logs and 5,352 file identities.
CI rejects erased failures or a false acceptance label.

The named-record inference repair preserves shared selector constraints and
record-specific arithmetic. Infinite-type, alias, callback and overflow tests
pass focused Linux checks. The intended named `Acc` and `CallbackWords` output
expectations replace anonymous-record snapshots.

**D1:** four repeated-solve baseline sessions at `a31f24c4`, run `40829884152`,
are audited and [archived](measurements/descent-costs.md#repeated-solve-results).
**D3:** the [18-case depth comparison](measurements/ad-depth.md) at `8e299f9f`,
run `40837334009`, passes both Linux hosts. F64/F128 accuracy, first three
derivatives, finite differences, branches, checkpoints and cleanup are covered.
All managed/raw ledgers end at zero. F64 allocation counts fall; F128 counts and
peak storage do not. Short depth timings are diagnostic, not speed acceptance.

## Next optimization after delivery

Follow [D2](../PLAN.md#5-differentiation); do not repeat the rejected comparison
unchanged. `/private/tmp/fwp-next-d2-notes.md` records source investigations.
F64 result conversion builds another list, but raw/native NaN payloads differ;
no general bitwise-identity claim is justified. An instrumented saved C program
also counts 22 partial-application allocations per three-coordinate one-update
solve. It preserves all 512 outputs; it is not a timing result. Investigate eager
capture bindings before changing inlining limits or adding runtime machinery.
The next candidate is isolated on `ad-eager-captures` in
`/private/tmp/fwp-ad-captures`, with no second PR. Its comparison was published
at `8a495a72` before implementation `89d0dfa1`; focused run `40871650124` passes
299 tests/18 summaries and lint on Linux ARM/AMD and ARM macOS. All three logs
are audited. Compiler/runtime/test source is unchanged at `4ffeb0d2`, whose four
predeclared comparison sessions are queued in run `40876515001`. Follow that worktree’s handoff separately.
Do not mix its unverified code into this delivery.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | Final grouped native gates; D2 whole-program speed goal remains open |
| 6 | Pending | N1–N2 numerical kernels |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |

## Resume safely

PR #225 merged as `6735c4e3` after every gate passed; its tree matches tested
head `fbed316b`. [History](roadmap-history.md#decimal-counting-and-current-derivative-baselines-pr-225)
owns that delivery. Do not restart in the primary checkout: it remains detached
at #209 with a recovery pointer and an untracked compiler-abort report to preserve.
The original intermittent Intel abort is still unexplained; investigate source
and input if it recurs. Other worktrees retain evidence. No agents are running.

Use `scripts/local-guard.py` serially; full builds/suites stay on GitHub. About
64.7 GiB disk is free; do not bypass the 64 GiB, 1 GiB RSS or 180-second limits.
Latest focused checks pass: both G2 log/sample audits, completed native log audits,
and documentation (177 link sets, 106 immutable preparation pairs, eight steps;
0.31 CPU seconds, 2.59 elapsed). `git diff --check` passes. No production compiler
or runtime code changed after `8e299f9f`; later commits repair tests and evidence.

Local disk recovery compressed 676 retained assembly text artifacts from the four
`/private/tmp/fwp-descent-output-{1,2}-{arm,amd}` directories. Every decompressed
byte count and SHA-256 was verified before removing its uncompressed copy; no
evidence was discarded. About 721 MiB reclaimed. Paths/hashes are retained in
`/private/tmp/fwp-compressed-artifacts.jsonl`; use `.asm.gz` for those local files.
