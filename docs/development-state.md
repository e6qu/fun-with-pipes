# Current work

**Next:** review complete-log audit `42525276460` for
[PR #272](https://github.com/e6qu/fun-with-pipes/pull/272), then squash-merge
only if it passes. All nine production jobs in `42516732838` and docs
`42516732902` pass on final head `8e7cdb94337c6fdac5656dfcbdab768d4a36e985`.
The audit is queued; green production jobs alone do not finish this gate.
Measured compiler source: `4a32c102f74f738433c1d55969936b023a5510f0`.
This receipt belongs to the next branch; preserve #272's tested head.
After the verified merge, rebase `ownership-peer-comparisons` onto the actual
merge and continue milestone 4 in one substantial PR.

## Roadmap status

| Step | Status | Delivered or verified | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance remains open. |
| 2 | In progress | #271 captured maps and empty-owner transfer | Noisy timing acceptance remains open. |
| 3 | In progress | #272 implementation/reports; focused safety, four measurement audits and all final production/docs jobs pass | Complete-log audit and merge; retain AMD timing misses. |
| 4 | In progress | [Native buffer/parser checks](measurements/ownership-peer-checks-2026-11-08/README.md) pass on ARM64/AMD64 | Complete and verify Swift/C/Rust buffers, returned functions, weak subscriptions and parser workspaces. |
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
macOS ARM64 regular `128841273786` also passes; its complete main log has no
unexpected compiler/test diagnostic: `/tmp/fwp-pr272-final-mac-arm.log`.
Linux AMD64 `128841273718` and Windows AMD64 `128841273836` pass. Their complete
main logs are reviewed: Linux has no unexpected diagnostic; Windows panic messages
are named scheduler lifetime controls, followed by passing test results.
Logs: `/tmp/fwp-pr272-final-{linux-amd,windows-amd}.log`.

## Next-branch preparation

[Scope](measurements/ownership-peers.md) and
[first native report](measurements/ownership-peer-checks-2026-11-08/README.md)
record the protocol, observations and limits. Repair source
`4c6cda41fc2739569cdeda241da85b2a7310b89c` is preserved by immutable tag
`roadmap/ownership-peer-checks-2026-11-08`. Native Linux run `42522747197`
passes on ARM64 (`128859624064`) and AMD64 (`128859624152`): 630 buffer cases
per host, twelve evidence-reader tests, C/Rust parser allocation lifetimes,
Rust frames, cleanup and deliberately broken observer controls. Both full main
logs and raw command records are reviewed. No peer timing is claimed.

The first run `42520124080` reported success but its Rust observer aborted on
invalid input. It incorrectly charged releases of allocations made outside the
measurement scope. The repair tracks allocation identities and ends observation
on unwind; strict exit-status checks now reject crashes instead of accepting
any nonzero exit as a language error. The report retains both runs and controls.
Run `42519237679` was cancelled before either job started to combine the checks.

Remaining work: matched buffer barriers and returned-buffer phases, scalar Swift
closure allocation attribution, weak registrations and allocator-internal parser
peaks/reservations/RSS. Swift allocation counts are not ARC operation counts.
Do not rerun unchanged failed timing controls to manufacture qualification.

## Local limits and resume

Disk cleanup on 2026-11-08 restored free space from 8.6 GiB to about 106 GiB
(the net change also includes concurrent disk activity). Removed duplicate tracked
files from seven inactive fwp worktrees using sparse checkout; each uncommitted
handoff was preserved byte-for-byte. Source/history/evidence remain in Git.
Removed 23 old completed Homebrew downloads (0.85 GiB), inactive Theseus Rust
build caches (about 11 GiB), and 110 Git-ignored Terraform provider binaries
(36.25 GiB logical). Preserved installed tools, infrastructure state/configuration,
lockfiles, databases, models and active emulator scratch data. Affected Terraform
projects need `terraform init` before use. Cleanup manifest:
`/tmp/fwp-provider-cleanup.json`. The active branch was left intact; its sparse checkout was later expanded to
restore documentation, examples, SDK and vendor inputs for link validation.

Local focused checks can resume through `python3 scripts/local-guard.py COMMAND...`
while the 64 GiB reserve holds. Full builds/suites/benchmarks still run remotely.
The earlier report-check refusal remains a non-pass; no limits were bypassed.
The first resumed attempt could not sample processes inside the sandbox; the
authorized guarded retry exposed absent sparse-checkout inputs, not broken
repository links. After restoring those inputs,
`python3 scripts/local-guard.py python3 scripts/check-roadmap.py` passes:
398 tracked Markdown link sets including the staged report, 106 preparation
pairs/tags and five roadmap steps (0.42 CPU seconds, 3.16 seconds elapsed).

Earlier guarded tutorial checks passed in raw interpretation and Clang O2
(3.29 seconds, 1.46 CPU); receipt `/tmp/fwp-structured-tutorial/checks.json`.
The full native matrix covers the tutorial again. Seven statistical controls,
workflow syntax and the then-current 395 Markdown link sets passed before disk
fell; newer docs still require their final remote audit.

Small report extracts: `/tmp/fwp-callback-reports/`.
Current PR description file: `/tmp/fwp-structured-gradient-pr.md`.
One-off HTTP-range reader: `/tmp/fwp-read-artifact-report.py` (inspection only).
