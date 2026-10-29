# Next: matched derivative recording comparisons

**Next:** prepare a repeated-process, balanced-order D1 baseline on matching native
Neoverse-N2 and EPYC 7763 hosts before changing the scalar `ad.push` contract.
Worktree `/private/tmp/fwp-ad-recording`, branch `ad-recording-costs`, based on
`fbed316b9f31bf792702c0e6914fbb77c86ba643`. Measurement preparation is local; no compiler/runtime changes or publication yet.
Read PLAN.md, docs/measurements/descent-costs.md and the output report.

## Current delivery to finish

PR #225 in `/private/tmp/fwp-cpu-phases` is at fbed316b, final CI `40821277777`.
All nine jobs actually run; docs `40821277750` and benchmark `123274076330` pass
and are fully audited. Monitor/fix all remaining jobs and squash only after all
nine plus docs pass. One line <=80 characters, empty body, no attribution/trailers;
verify merged/tested trees and message. Keep one active PR and preserve this head.
Original run 40813465621 is fully audited, with only known Windows CRLF and macOS
artifact EILSEQ failures. Both original Linux jobs pass, 257 summaries/981 tests each.

## Evidence and next proof

Eight current-source derivative/output sessions at 21a1 are audited and archived
in #225. ARM repeats match; AMD sessions have differing CPUs and short identical
controls are noisy. Never pool hosts or relax/discard those observations. Define
fixed budgets before candidate timing. Source 21a1 is remotely retained by tag
`roadmap/derivative-baseline-21a1de32`; D1 reports contain the original file hashes.

The concrete D2 candidate is the four-scalar argument record passed to `ad.push`.
Current generated C heap-allocates it for every push; runtime copies all fields
and retains no tuple address. Existing escape analysis can use a proved
`borrows_without_escape` contract. Do not add a wrapper, new source syntax or
extend the rule to `ad.push-owned`. Prove failure/cancellation, stale/mixed/full
nodes and nested gradients; compare exact allocations/retains, stack/code size
and paired timings. D3 F64/F128 precision/nesting follows. No contract changed yet.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free ownership and cycle checks |
| 2 | Verified | Maintain A1–A6; no universal ARC-free claim |
| 3 | Verified | Maintain F1–F3 call/recursion guarantees |
| 4 | In progress | Finish PR #225 final gates |
| 5 | In progress | D1 matched-host budgets, then D2/D3 |
| 6 | Pending | N1–N2 CPU numerical kernels |
| 7 | In progress | Broader B1/B2 coverage |
| 8 | Pending | V1–V2 larger applications |

## Recovery and resource limits

The older `/private/tmp/fwp-ad-refresh` worktree is retained measurement source,
not another active delivery. Primary checkout is detached at #209; preserve its
recovery pointer and untracked compiler-abort report. Historical Intel abort and
original macOS EILSEQ origin remain unexplained. No agents. Focused local checks
must use scripts/local-guard.py serially; full builds/tests/benchmarks run on
GitHub. About 68 GiB free, target zero. Do not raise guard limits.

## Preparation checks

The balanced schedule and round recorder pass seven focused Python tests,
including changed output/status and interrupted-round preservation. Command:
`python3 scripts/local-guard.py python3 scripts/test-descent-schedule.py`.
A 98-round protocol groups 7/21/42 fresh processes per label; original 56-round
reports remain unchanged. Explicit host qualification precedes compiler builds.
The existing three ownership-budget controls and actionlint pass, each under the
local guard. Documentation audit also passes (176 link sets, 106 anchors and eight
roadmap rows). Publish only this measurement preparation branch, then dispatch
descent-peers with native_runner=all. Do not open a second PR while #225 is active.
