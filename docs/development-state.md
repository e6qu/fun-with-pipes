# Next: verify derivative accuracy and reliable timing

**Next:** verify the pending-field effect query with the focused `descent-checks`
suite, then repair every remaining inference/precision failure before measuring.
The preparation is in `/private/tmp/fwp-ad-recording`, branch `ad-recording-costs`.
One active PR: #225 remains in `/private/tmp/fwp-cpu-phases` at
`fbed316b9f31bf792702c0e6914fbb77c86ba643`. Do not change `ad.push` until D1's
comparison limits are recorded.

## Current delivery to finish

Final production run `40821277777`: documentation `40821277750`, benchmarks
`123274076330`, regular macOS ARM `123274075968` and ownership macOS ARM
`123274076322` pass and are fully audited. The macOS jobs have 132 summaries/619
passed tests and 127/359 respectively. Packaging verified/uploaded 3,297 and
2,914 evidence files. Intel ownership job `123274076326` also passes: 127 summaries/359 tests audited.
Remaining Linux, regular Intel macOS and Windows jobs are running
without reported failures. Both Windows hosts passed the repaired decimal test.

Preserve this final head. Squash only after all nine production jobs plus docs
pass and are audited; explicit one-line subject <=80 characters and empty body.
Verify merged/tested trees and message. Original run `40813465621` is fully audited:
only the repaired Windows CRLF oracle and macOS artifact EILSEQ failures occurred.
The original EILSEQ cause and older Intel compiler abort remain unexplained.

## New preparation and encountered bug

Published source `b1ca235415d4d2caabdb4f568d9300cf50a59400`, run `40822958582`,
passed all four matched-host sessions. ARM 1/2 jobs: 123279381257/123279381252;
AMD 1/2: 123279381308/123279381298. Complete raw artifacts/logs are audited:
80 images, 68 stack reports and every process observation per session.
Reports/logs and all 4,628 file identities are retained in the `descent-groups`
archive. Fresh-process grouping still leaves up to 6.2% identical-code median
variation; no derivative speedup or timing acceptance. Do not discard these rows.

The next protocol repeats independent complete solves within each process.
Exact sizes, counts, timing scope and cleanup checks are in
[the derivative report](measurements/descent-costs.md). No observer limit rises.
Current D3 tests compare F64/F128 analytic, numerical, nested/checkpointed and
branch-domain results. A raw-interpreter check exposed a real inference defect:
a selector in `if (.value | lt 0) neg id` erases a named record's identity.
Preparation `9d8431299bd0678534da3f8cb50b894197d80fef`, run `40826160826`,
failed. ARM jobs 123289571101/123289571107 and AMD job 123289571013 all encountered
the same three standard-library effect mismatches in io:60, websocket:266 and
rest:1200. Both precision tests, type snapshots and interpreter snapshots failed;
no repeated-solve measurements completed. AMD session 2 (123289571216) correctly
rejected an EPYC 9V45 host before building. Retain this outcome; never mix it into
the EPYC 7763 baseline. Logs: `/private/tmp/fwp-descent-repeat-9d-{arm,amd}-{1,2}.log`.

The delayed selector constraint hid callback fields from effect relationship
queries. The proposed repair exposes pending field types to that query without
forcing an anonymous row. It is **not yet verified**. The focused workflow now
uses explicit Bash pipefail, runs independent checks after failures, and offers
`descent-checks` without lengthy measurement or host-model restrictions. Verify
all snapshots, native O1/O2 and both precision tests, then both G2 analysis hosts.
No ownership contract changed. An untracked scalar-recording fixture prepares D2;
it has only been formatted, not executed. The obsolete collector-symbol prefix
in `scripts/measure-descent-batches.py` was repaired in 9d.

## Next ownership proof

D2 targets the four-scalar argument to `ad.push`: runtime copies its fields and
retains no record address. Prove `borrows_without_escape`, then use existing stack
analysis. Do not extend the rule to typed `ad.push-owned`. Check exact allocations,
retains, code/stack costs, failure/cancellation, stale/mixed/full nodes and nesting.
The raw tape already reuses buffers; a larger cache is not the selected change.
Bundle D2, D3 and the incidental inference repair into the next substantial PR.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free ownership and cycle checks |
| 2 | Verified | Maintain A1–A6; no universal ARC-free claim |
| 3 | Verified | Maintain F1–F3 call/recursion guarantees |
| 4 | In progress | Finish PR #225 final gates |
| 5 | In progress | D1 reliable timing limits, D2 recording arguments, D3 accuracy/costs |
| 6 | Pending | N1–N2 CPU numerical kernels |
| 7 | In progress | Broader B1/B2 coverage |
| 8 | Pending | V1–V2 larger applications |

## Checks and recovery

Focused guard checks pass: schedule/recorder (7), old baseline rejection (6),
grouped-report rejection (5), original ownership budgets (3); full raw grouped
artifact audit and archive reader pass. Rust formatting passes. Two-solve AD,
history and packed fixtures pass the raw interpreter with independent output
checks. The compiler is the exact fbed package, hash verified, downloaded to
`/private/tmp/fwp-225-repaired-compiler`; this does not verify the new inference
code. Updated workflow/docs validation passes; the new golden source is formatted.
Publish the pending-field query and run descent-checks before further measurements.
The native production compilers must verify the inference change; the local
current-compiler run only reproduced the original defect.

Temporary auditor: `/private/tmp/fwp-audit-descent-groups.py`; raw evidence/logs:
`/private/tmp/fwp-descent-groups-{arm,amd}-{1,2}`. The old `fwp-ad-refresh` worktree
is retained source, not another delivery. Primary checkout is detached at #209;
preserve its recovery pointer and untracked compiler-abort report. No agents.
Local work stays serial under scripts/local-guard.py: 64 GiB free, target <2 GiB,
RSS <1 GiB, 180 seconds. Currently about 67 GiB free and no local target. Full
builds/tests/benchmarks run on GitHub. Never raise or bypass the limits.
