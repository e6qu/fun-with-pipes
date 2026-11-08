# Current work

**Next:** finish auditing production run `42508955007`, then publish the prepared
measurement report/docs together and require the complete final-head matrix.
Validate the report on `structured-autodiff-report-review` with the documentation
workflow while the current PR's native jobs continue; this is a verification
branch, not another PR.
[PR #272](https://github.com/e6qu/fun-with-pipes/pull/272) is open, non-draft,
at `4a32c102f74f738433c1d55969936b023a5510f0`. Do not merge before all nine
production jobs, docs and the complete-log audit pass for the final commit.
No known failing job remains. Preserve running checks while preparing docs.

## Roadmap status

| Step | Delivered or verified | Remaining |
|---|---|---|
| 1 | #270 docs and fresh F64 stores | Original AMD timing acceptance remains open. |
| 2 | #271 captured maps and empty-owner transfer | Noisy timing acceptance remains open. |
| 3 | #272 known array callbacks; focused safety and four measurement audits pass | Publish reports; final platform/docs/audit gates; retain AMD timing misses. |
| 4 | Comparison scope in PLAN.md | Swift/C/Rust buffers, returned functions, weak subscriptions and parser workspaces. |
| 5 | Existing tools and correctness tests | Three application paths, compiler phase/scaling costs and sustained-load measurements. |

The local-pair gradient remains experimental. Independent loss uses existing
`array.map (derivative loss)`; no new public gradient API is selected. Do not
rerun unchanged timing sessions to obtain qualification.

## Source and worktree

Branch `structured-autodiff-comparison`, worktree `.worktrees/recording-capacity-gate`.
Preserve unrelated root-worktree changes. Verified base #271 merge:
`b76306b20a1d7727917ef6184c9a8716967ceb89`, same tree as its tested head.
[Delivery receipt](measurements/captured-map-delivery-2026-11-08/README.md)
records all nine passing production jobs, docs, full audit and merge verification.

Frozen comparison baseline: `04ddc0ac5d296ec895364236c4120341d7328e41`.
Acceptance commit: `412b50b52d5f694ffb0b7d871b807715cdde3dda`.
Published tags `roadmap/structured-gradient-baseline-2026-11-08` and
`roadmap/structured-gradient-acceptance-2026-11-08` preserve them after squash.
Do not move these tags.

## What this batch proves

[Initial method study](measurements/structured-gradient-methods-2026-11-08/README.md):
41 method/input combinations, four sessions, all evidence audits pass. It
compares complete fwp gradients with each other, not peer-language parity.

[Candidate study](measurements/structured-array-callbacks-2026-11-08/README.md):
14 cases, 256 gradients per process, four sessions in `42510222540`; all jobs and
source/binary/evidence-rejection audits pass. Both ARM sessions meet the 10%
primary target (about 91% and 85% less computation). AMD copy noise fails the
original rule; combined timing acceptance stays open. Counts, cleanup and peak
storage meet their bounds. At 129 inputs, requests fall 1,284→260 for neighbors
and 518→260 for independent loss. Compiler, stack and RSS tradeoffs are explicit.
Report files are prepared locally for the next batched publication.
`scripts/check-structured-callback-report.py` reconstructs retained timings and
checks storage, primary image hashes and stack reports in documentation CI.

Implementation reuses bounded known-function worker specialization for array
callbacks. It removes only a closed function argument, preserving other captures
and resource identities. Numeric-input selection now accepts nonresource data
bindings without moving their original evaluation scopes. No analysis budgets,
arithmetic rules or lifetime guarantees are relaxed.

[Earlier failures and repairs](measurements/structured-array-callback-first-2026-11-08/README.md)
retain the first missed allocation limit and incorrect resource test fixture.
Source `3203b635a` still allocated two derivative inputs per edge; the new numeric
proof fixes that underlying cause. A later formatting failure was repaired
exactly; formatting now runs independently of native checks. The result checksum
was also fixed so even repeat counts cannot cancel an altered result.

## Checks and active jobs

Focused run `42508330680`, source
`e085e2306d3a938e7253d2f9f3586252e54057eb`, differs from PR head only in handoff.
All three jobs pass: AMD GCC `128815743055`, ARM GCC `128815743093`, macOS Clang
`128815743162`. Eight specialization and eleven numeric-proof tests, mixed owners,
32 exact gradient outputs, callback order, unwinding, nested AD, F128, allocation
limits, physical release and deliberate observer faults pass. Reviewed logs:
`/tmp/fwp-array-final-{amd,arm,mac}.log`.

Measurement jobs: ARM1 `128821483731`, ARM2 `128821483673`, AMD1 `128821483738`,
AMD2 `128821483759`. Complete logs reviewed; no unexpected diagnostics.
Reports preserve every noisy observation. Original archives remain in GitHub;
small report/sample/source/image entries were read with HTTP ranges and ZIP CRC
checks while disk was low. No local whole-archive digest check is claimed.

Production `42508955007`: benchmark `128817627716` and Windows AMD64
`128817627957` pass; other seven jobs run or queue. Docs `42508954924`, job
`128817627196`, pass. Reviewed docs diagnostics are deliberate negative controls;
Windows panic messages are named lifetime-test controls. Local logs:
`/tmp/fwp-pr272-{bench,docs,windows-amd}.log`. Full final-head audit is pending.

## Local limits and resume

Free disk is about 15 GiB, below the required 64 GiB. Local validation, builds
and large downloads remain paused. Do not raise or bypass the guard. Continue
source/docs edits, small report inspection and remote verification. Use
`python3 scripts/local-guard.py COMMAND...` when the reserve is restored.
The guard refused the new report check: `local-guard: stopped: less than 64 GiB
free disk`; no local report-check pass is claimed.

Earlier guarded tutorial checks passed in raw interpretation and Clang O2
(3.29 seconds, 1.46 CPU); receipt `/tmp/fwp-structured-tutorial/checks.json`.
The full native matrix covers the tutorial again. Seven statistical controls,
workflow syntax and the then-current 395 Markdown link sets passed before disk
fell; newer docs still require their final remote audit.

Small report extracts: `/tmp/fwp-callback-reports/`.
Current PR description file: `/tmp/fwp-structured-gradient-pr.md`.
One-off HTTP-range reader: `/tmp/fwp-read-artifact-report.py` (inspection only).
