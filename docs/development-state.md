# Current work

**Next:** implement the frozen [scalar append inlining](measurements/recording-inline.md)
and update every declaration-sensitive probe. Prepare its same-source comparison
and focused checks before running the final measurement/platform batch.

Branch `recording-call-costs`, worktree `.worktrees/scalar-constant-lowering`.
Draft [PR #263](https://github.com/e6qu/fun-with-pipes/pull/263). Base: [verified PR #262](measurements/recording-lookup-delivery-2026-11-06/README.md),
merge `9a9dc49c53212b562cd9de06f908248ceb6109af`, tree
`66f69ee54dcc207be2a9041d2cae9e89ad3d9aa3`, identical to tested `a8e427e8`.
The squash message is one line, 54 characters, without body or trailers.
Duplicate post-merge CI/docs runs `42152999846`/`42152999847` were cancelled after
confirming tree equality; they are not additional validation.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Delivery receipt and all four sessions' generated-source hashes agree. |
| 2 | Verified | All 72 native diagnostic images reproduce their originals; complete reports/logs audited. |
| 3 | Verified | Freeze explicit scalar append inlining; preserve checks, same-source reference and original measurement limits. |
| 4 | Pending | Implement the related group and run its final measurement/platform batch once ready. |

## Evidence and limits

PR #262 production run `42141696622`, docs `42141693447` and complete audit
`42151713370` all pass. The retained delivery receipt includes every job/log,
target-log and nested artifact hash. Audit artifact `13472887762` has no issues.

The [source review](measurements/recording-call-review-2026-11-06/README.md)
finds exactly one local state declaration and six changed calls in the saved
129-coordinate/199-update worker. Candidate/reference arithmetic is unchanged.
This does not establish optimized instruction costs or explain AMD64's slowdown.

Diagnostic inputs: previous candidate `76690b385514c58ad94c5591da3553fa48218535`;
new reference/candidate `31c04650527d7a3c9efdd63bd5b4eae8a15d5732`.
The previous release has a four-argument append helper; both new versions share
the five-argument helper. Compare all three before attributing a change to reuse.

[Original timing results](measurements/recording-lookup-time-2026-11-06/README.md)
retain all 32 missed long-case targets. ARM64 ranges from 0.14% slower to 2.33%
faster; AMD64 current-result cases slow by 1.13–3.90%. Small-case/copy, tracked
memory, cleanup and reported-frame limits pass. The AMD64 large callback-worker
compiler-time control remains inconclusive (2.854% identical-copy variation).
A passing artifact audit does not turn these results into timing passes.

## Checks and workspace

Guarded local checks: complete final-audit hashes 0.13 seconds; delivery retention
0.13 seconds; saved-source verifier 0.24 seconds. Branch switching reapplied the
sparse checkout, initially hiding required saved reports; restoring those exact
small tracked inputs fixed the source check. No native workload reran.
Full builds, benchmarks and large audits remain on GitHub. About 80 GiB was free
at the last check. Scratch helpers are `/tmp/fwp-recording-*`; evidence scratch is
`../gradient-work/`. Keep imports at the top and commit subjects one line/≤80 chars.

Diagnostic contract frozen at `4e7ff3ef` before tool implementation. Four focused
control tests pass (0.13 seconds), including altered commands, corrupt sources,
stale outputs, compiler failure/deadline, missing reports and changed images.
Workflow syntax check passes (0.13 seconds). No production code changed.

[Native call reports](measurements/recording-call-analysis-2026-11-06/README.md)
pass at `7d68bcea91b27023f0408ca7543058eb6f592873`, run `42155555677`.
ARM64 job `127688745853`, AMD64 `127688745884`; all 72 exact images, reports,
source hashes and complete logs verified. GCC does not inline the append body in
any compared version; its generated wrapper is already inlined. This supports
testing explicit body inlining, not a claim about the previous slowdown's cause.
Docs run `42155558291` passes at that source. No runtime timing was repeated.
Full source/report audit and summary each took 0.13 seconds; 351 documentation
links and all four plan/handoff rows pass (0.25 seconds).
