# Current work

**Next:** audit final production `42516732838` and docs `42516732902` on
[PR #272](https://github.com/e6qu/fun-with-pipes/pull/272), then dispatch the
complete-log audit. Final head: `8e7cdb94337c6fdac5656dfcbdab768d4a36e985`;
measured compiler source: `4a32c102f74f738433c1d55969936b023a5510f0`.
At 20:25 UTC, docs and C/Rust benchmarks pass. Seven production jobs are running;
the macOS ARM64 ownership job remains queued. No failing step is reported. This receipt belongs
to the next branch; do not push it onto the final PR head and restart verification.
Do not merge before all nine production jobs, docs and the complete-log audit
pass for the final commit. Preserve that final head while checks run.
The report was verified on `structured-autodiff-report-review` before publication;
that temporary verification branch has no separate PR.

## Roadmap status

| Step | Status | Delivered or verified | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance remains open. |
| 2 | In progress | #271 captured maps and empty-owner transfer | Noisy timing acceptance remains open. |
| 3 | In progress | #272 implementation/reports; focused safety, four measurement audits and final docs/bench jobs pass | Remaining final platform/audit gates; retain AMD timing misses. |
| 4 | Pending | [Concrete comparison scope](measurements/ownership-peers.md); unverified Swift buffer fixture | Complete and verify Swift/C/Rust buffers, returned functions, weak subscriptions and parser workspaces. |
| 5 | Pending | Existing tools and correctness tests | Three application paths, compiler phase/scaling costs and sustained-load measurements. |

The local-pair gradient remains experimental. Independent loss uses existing
`array.map (derivative loss)`; no new public gradient API is selected. Do not
rerun unchanged timing sessions to obtain qualification.

## Source and worktree

PR branch `structured-autodiff-comparison` remains at final head `8e7cdb943`.
The same worktree `.worktrees/recording-capacity-gate` now has local branch
`ownership-peer-comparisons`, based on that head. No second PR is open.
Preserve unrelated root-worktree changes. Verified base #271 merge:
`b76306b20a1d7727917ef6184c9a8716967ceb89`, same tree as its tested head.
[Delivery receipt](measurements/captured-map-delivery-2026-11-08/README.md)
records all nine passing production jobs, docs, full audit and merge verification.

Frozen comparison baseline: `04ddc0ac5d296ec895364236c4120341d7328e41`.
Acceptance commit: `412b50b52d5f694ffb0b7d871b807715cdde3dda`.
Published tags `roadmap/structured-gradient-baseline-2026-11-08` and
`roadmap/structured-gradient-acceptance-2026-11-08` preserve them after squash.
`roadmap/structured-gradient-candidate-2026-11-08` preserves measured candidate
`4a32c102f74f738433c1d55969936b023a5510f0`. Do not move these tags.

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
Report files join the implementation in this publication.
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
`e085e2306d3a938e7253d2f9f3586252e54057eb`, has the same compiler implementation;
later changes add documentation, retained reports and their documentation audit.
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

Superseded production `42508955007`: benchmark `128817627716` and Windows AMD64
`128817627957` pass. Cancellation was requested for the seven unfinished jobs
when the complete report was ready, freeing runners for the final commit.
All five interrupted running-job logs are now reviewed: cancellation and missing
artifacts from unexecuted steps are the only error/warning diagnostics; no test
failure or compiler warning was found. The two ARM macOS jobs never started.
Logs: `/tmp/fwp-pr272-old-{linux-arm,linux-amd,mac-amd,mac-amd-ownership,windows-arm}.log`.
Docs `42508954924`, job
`128817627196`, pass. Reviewed docs diagnostics are deliberate negative controls;
Windows panic messages are named lifetime-test controls. Local logs:
`/tmp/fwp-pr272-{bench,docs,windows-amd}.log`. Full final-head audit is pending.

Report-review docs `42515588460` / `128837762893` reproduce all saved timings,
storage, primary binary hashes and stack reports. Documentation/control tests
pass, but the shortened handoff omitted the required status column; the restored
column keeps the existing audit unchanged. Later docs targets were skipped.
Complete log: `/tmp/fwp-pr272-report-docs.log`.
Corrected report/docs run `42516046373`, job `128839176998`, passes at `4bf18f4f2`.
It checks all retained measurements, tutorials, immutable references and evidence
controls. Run `42515982996` was cancelled while queued after a renamed benchmark
heading needed its incoming link updated. Final publication adds only the
remaining-container explanation, service-load plan details and this receipt.
Complete passing log reviewed: `/tmp/fwp-pr272-report-docs-pass.log`; only named
negative-control failures occur. Final docs job: `128841273815`.
Final docs and benchmark `128841273778` logs are reviewed: only expected runner
rejection controls, no unexpected diagnostic. Logs:
`/tmp/fwp-pr272-final-{docs,bench}.log`. Full artifact-log audit remains pending.

## Next-branch preparation

Milestone 4 has a [concrete scope](measurements/ownership-peers.md). Prepared,
not yet tested: native Swift Array peer, common peer result/error
checks with explicit language selection, and `ownership-peer-checks` in
`numerics.yml`. It runs C/Rust O1/O2 and Swift Onone/O on native Linux ARM64/AMD64
without rebuilding fwp. Initial source `9f0dae655` was published and focused run
`42519237679` queued. Its unstarted jobs will be replaced with the combined parser
and Swift batch. The existing C/Rust workflow caller now selects its
languages explicitly. No peer timing has been collected or acceptance declared.
The parser batch adds C/Rust allocation-transition observers, four existing tree
shapes, real omitted-release controls, eight semantic controls, 32 damaged-record
controls and Rust compiler frames with unchanged ordinary instruction bytes.
These are prepared checks, not passes. They observe successful API requests and
release; allocator-internal overlap, input loading and RSS remain outside scope.
The parser job executes even if the earlier buffer step fails so both failures
can be repaired together. Diagnostic clock values are not performance evidence.
Swift uses external input/result barriers; matched timing peers must all use
the same barriers before ratios are meaningful. Remaining work includes returned
buffers, scalar-closure allocation attribution, weak registrations and parser peaks.
After #272's verified merge, carry this branch onto the actual merge and bundle
the remaining comparison work into one substantial PR.

## Local limits and resume

Free disk is about 14 GiB, below the required 64 GiB. Local validation, builds
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
