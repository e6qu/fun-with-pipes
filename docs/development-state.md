# Current work

**Next:** publish the [recording-call diagnostic](measurements/recording-call-costs.md)
and run its native GCC builds. Audit every retained report before selecting a change.
Use saved C and original executable hashes; do not repeat runtime timings.

Branch `recording-call-costs`, worktree `.worktrees/scalar-constant-lowering`.
No active PR yet. Base: [verified PR #262](measurements/recording-lookup-delivery-2026-11-06/README.md),
merge `9a9dc49c53212b562cd9de06f908248ceb6109af`, tree
`66f69ee54dcc207be2a9041d2cae9e89ad3d9aa3`, identical to tested `a8e427e8`.
The squash message is one line, 54 characters, without body or trailers.
Duplicate post-merge CI/docs runs `42152999846`/`42152999847` were cancelled after
confirming tree equality; they are not additional validation.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Delivery receipt and all four sessions' generated-source hashes agree. |
| 2 | In progress | Diagnostic and failure controls implemented; native GCC reports and exact executable equality pending. |
| 3 | Pending | Choose and freeze a production change from the reports; no cause or optimization is established yet. |
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
