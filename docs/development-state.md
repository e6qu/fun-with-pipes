# Current work

**Next:** publish the complete four-session archive audit while all checks at
`93ee0dc8` remain queued, then preserve the resulting head of
[PR #232](https://github.com/e6qu/fun-with-pipes/pull/232) through its production
and documentation gates. Queued runs `41143677115` / `41143677127` can be
superseded before execution; do not restart running gates for status-only edits.
Initial head `76ee7a80` used production run `41142900417` and docs `41142900328`.
Documentation found a stale expected
count: `numeric_array_fusion` now has three tests, not two. Both the collection
report inventory and its synthetic complete log/total are repaired (54 tests).
Its callers in collection/map/hash reports retain the completeness check;
historical measurement counts remain untouched. All nine old production jobs
had no failed steps when the repair was published. Their superseded run was
cancelled to avoid duplicate full suites. All nine partial logs were reviewed:
completed tests pass; cancellation before evidence generation explains the
missing-artifact errors. No additional compiler/test failure was found.
Squash-merge only after
all nine production jobs and documentation pass and their full logs are audited;
use an explicit one-line subject of at most 80 characters and an empty body.
Keep failed timing controls visible; never retry a collected result or loosen
its limit. Allocation removal and timing acceptance are separate.

Worktree: `/private/tmp/fwp-ownership-peer-baselines`, branch
`generated-array-folds`. Measured candidate source
`899ad012c19a9f49abce941070cdbfef610725d5` remains the timing run's checkout.
Subsequent changes strengthen an observer's zero-storage assertion and update
documentation; compiler/runtime and timed programs remain unchanged.
Local merge `4bfe94da` records main's squash ancestry without changing files:
main's tree exactly matched the already-contained `377cf9ce` ancestor.

## Delivered

[#231](https://github.com/e6qu/fun-with-pipes/pull/231) passed all nine production
jobs and documentation, with complete log audits, and was squash-merged as
`97b2c29ae15ebec84f2534c523b8f1260fd2fb67`. Its tree matches tested head
`377cf9ce25c65afba595b6413e5bb1d50721ea7a`; its 54-character subject has no body
or trailers. Duplicate post-merge CI was cancelled after verification.
[Delivery history](roadmap-history.md#direct-scalar-folds-and-process-timing-pr-231)
owns the job IDs, counts and limits. Scalar-fold timing acceptance remains open,
as the user accepted. Do not push the old `ownership-peer-baselines` branch.

## Prepared allocation reduction

[Generated-array elimination](measurements/generated-array-folds.md) removes an
immediately consumed numeric array when known, pure, terminating callbacks and
their trap behavior permit one loop. It shares the real constructor's count
validation and preserves argument order. Reused arrays, resources, F128 and
unknown callbacks retain storage. Declaration `97c8eac6` preceded implementation;
the reference is frozen at `377cf9ce`, using identical compiler inputs from
retained ordinary binaries at `3ca66b54`. No compiler implementation changed
after `826e447f`.

Focused native run `41138032240` at `899ad012` passes on ARM64 job
`124345218388` and AMD64 job `124345218402`: thirteen tests across five targets
per host. Complete logs and artifacts were audited. The
[check index](measurements/generated-array-checks-2026-10-31.json) records 48
allocation cases, twelve cleanup variants and twenty native images per host.
Zero storage/count costs and deliberate missing-cleanup failures are verified.
The observer now rejects equal nonzero initial/peak/final count storage too.
Both Python controls pass; retained observations pass the stronger rule.

The initial run `41135554961` at `048c92c5` failed one new test on each host:
its global C marker matched four loops. The repair locates the selected worker's
specific loop and requires exactly one interruption boundary there. The six
retained-C macOS Clang O1/O2 controls and both repaired GCC suites pass.
No cleanup assertion was relaxed. All independent observer steps at `048c92c5`
passed and remain applicable to the unchanged implementation. Code grows by
336 instruction bytes on each host (3.17% / 3.03%), within the 5% budget;
largest reported frame components remain 368 / 320 bytes.

Both G2 hosts pass run `41138040099`: Linux AMD64 `124345244380` and Intel macOS
`124345244038`. Each passes 224 unit tests, all-target lint and independently
reconstructed analysis/startup budgets. This measures ownership analysis, not
the whole optimizer. The final production matrix is still required.

## Measurements in progress

Paired sessions use runs `41139714279` (session one) and `41139722605` (session
two), source `899ad012`, with unchanged limits and explicit `generated-array`
reference selection. Both original ARM jobs completed; their 2,736 process
records per session were independently reconstructed. Both fail the 2% copy
control and must not be rerun. AMD session two also fails its old and new copy
controls. All allocation/code/frame checks pass. The
[timing index](measurements/generated-array-timings-2026-10-31.json) records all
four sessions. AMD session one passes its copy and elapsed limits at ratio
0.664728; CI and the local archive audit reconstruct all 2,736 observations.
Its full log was reviewed:
six native tests and all damaged-evidence controls pass without diagnostics.
All four original archives and local reconstructions are retained. Copy ratios
are 1.019470 / 1.019270 for AMD session one; the other three sessions fail at
least one unchanged 1.02 control. Overall timing acceptance remains open.

AMD attempts received incorrect EPYC 9V74/9V45 hosts and stopped before any
build or timing. Their qualification artifacts are retained; only these
unmeasured jobs were replaced. Session two's third attempt qualified on EPYC
7763, completed and was independently audited. Session one's seventh attempt,
job `124361211274`, completed on the qualified host. Six earlier attempts
rejected wrong CPUs before measuring. Original rejection ZIPs and
logs for all rejections remain retained. Query direct
job endpoints because aggregate Actions listings can be stale.

The [four full-buffer baselines](measurements/buffer-current.md) retain 25/48
failed copy controls; no case qualifies in all four. D2/N1 and #231 timing
acceptance remain open. No failed measured session was retried.

## Local checks and recovery

Guarded checks pass: rustfmt; primitive inventory (394 declarations, 384 symbols,
40 aliases, no review symbols); workflow lint; two observer rejection tests;
Python parsing; six macOS Clang interruption controls. Artifact audits verify
source IDs, hashes, raw observations and deliberate failures. No full local
compiler build, suite or benchmark ran. Run the roadmap audit again after these
documentation edits. The roadmap audit passed after the history/plan rewrite
(188 link sets, 106 immutable pairs, eight steps); later edits need the CI audit.
The focused collection-inventory repair check was initially refused below
64 GiB free. After disk space recovered, all eight tests pass in 0.13s through
the guard. The fourth archive audit passes in 0.86s, and the complete timing
index verifies all four archive hashes and eight wrong-host rejections.

Preserve the primary checkout at `/Users/zardoz/projects/fun-with-pipes`: detached
#209, dirty recovery handoff and untracked compiler-abort report. Automatic
approval review rejected replacing its handoff; do not retry. Backup:
`/private/tmp/fwp-primary-recovery-before-file-checks.md`. Keep original CI ZIPs;
extract only needed files. Free space temporarily fell from about 65 to 57 GiB
while local build directories stayed empty, then recovered above the 64 GiB
floor. No limits were bypassed and no original evidence was deleted. Recheck
headroom before local work; full validation stays on GitHub.

The [plan](../PLAN.md) owns remaining work: D2 timing, N1/N2 acceptance, B1/B2
comparisons and V1/V2 applications. GC removal, scoped A1–A6 and F1–F3 are
verified. The original intermittent Intel compiler abort remains unexplained;
preserve its report and diagnose any recurrence from source and inputs.

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
