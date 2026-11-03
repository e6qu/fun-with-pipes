# Scalar buffer runtime comparison

**Status:** measurements and independent audits are in progress. Compiler costs
[pass separately](../scalar-map-zip-analysis-2026-11-03/README.md). Runtime acceptance
is not established by the verified allocation reduction.

Candidate and reference use source `da510f18`, identical to merged PR #250; only
the reference's scalar-map buffer selection is disabled. Both execute the same
complete derivative solves and preserve the previous optimizations.
[Exact inputs, timing scope, batching, hosts and limits](../temporary-list-storage.md#execution-of-the-frozen-comparison).

## Completed ARM64 observations

Original [run 41591978166](https://github.com/e6qu/fun-with-pipes/actions/runs/41591978166):
session 1 job `125770553887`, session 2 `125770553867`.
Both finish all work and fail their final timing budget assertion. Their logs
report no output, ownership, allocation, raw-work or final-storage failure.

| Case / form | Session 1 candidate/reference | Session 2 | Required limit |
|---|---:|---:|---:|
| 3/0 current only | 1.03320 | 1.03320 | ≤1.02 |
| 3/199 current only | 0.95683 | 0.95433 | ≤0.95 |
| 3/199 history | 0.96073 | 0.95721 | ≤0.95 |
| 3/1999 history | 0.95736 | 0.95297 | ≤0.95 |

Session 2's 3/1999 current-only case also misses 0.95 at 0.95423. A ratio of
1.03320 means 3.32% slower; 0.95683 means 4.32% less time. The complete results
and raw-sample audit pass in run `41593988021`: [verified reports and logs](arm-audit.zip),
[artifact identities](arm-audit-artifacts.json). Audit success confirms the records; timing observations remain
failures; no completed session is rerun for a better result. Diagnose the saved
zero-update source and driver before attributing the slowdown to any cause.

## AMD64 host qualification

Required runtime CPU: EPYC 7763. Each rejected job stops **before** compiler
builds or timing. Full logs, host records, archive digests and skipped work were
checked. These are host rejections, not measured performance failures.

| Request | Session | Result / retained evidence |
|---|---:|---|
| Original `41591978166` | 1 | Intel 6975P-C rejected; [record](rejected-hosts/initial-amd1.json.gz), [log](rejected-hosts/initial-amd1.log.gz) |
| Original `41591978166` | 2 | Intel 6973P-C rejected; [record](rejected-hosts/initial-amd64-session2.json.gz), [log](rejected-hosts/initial-amd64-session2.log.gz) |
| Replacement `41592143741` | 2 | EPYC 9V74 rejected; [record](rejected-hosts/replacement1-amd2.json.gz), [log](rejected-hosts/replacement1-amd2.log.gz) |
| Replacement `41592549006` | 1 / 2 | EPYC 9V74 / 9V45 rejected; [independent audit](rejected-hosts/replacement2.zip), run `41593021814` |
| Replacement `41593285140` | 1 | Intel 6973P-C rejected; [record](rejected-hosts/replacement3-amd1.json.gz), [log](rejected-hosts/replacement3-amd1.log.gz) |
| Replacement `41593285140` | 2 | Qualified; job `125774733224` completed, timing limits failed |
| Replacement `41594132242` | 1 | Intel 8573C rejected; [record](rejected-hosts/replacement4-amd1.json.gz), [log](rejected-hosts/replacement4-amd1.log.gz) |
| Replacement `41595396878` | 1 | Qualified; job `125781458554` is measuring |

Only unmeasured, rejected sessions receive replacement requests. Required CPUs,
source, inputs, sample order, thresholds and completed outcomes remain unchanged.

## Completed AMD64 session 2

Qualified EPYC 7763 job `125774733224` completed all six cases. Four timing
requirements fail: candidate/reference is 0.97536 (3/199 current), 0.95767
(3/199 history), 0.96861 (3/1999 current) and 0.96334 (3/1999 history), against
0.95. The full job has no other diagnostics. Independent raw audit `41595559659`
passes: [reports and logs](amd-session2-audit.zip),
[artifact identities](amd-session2-audit-artifacts.json). Preserve these misses;
session 1 remains in progress. No completed timings are repeated.

## Zero-update source review

The saved current-only C changes the positive-update branch of `fs170` and its
boxed worker: mapped-list construction becomes a scalar buffer, followed by its
zip consumer. The zero-update branch still returns the input list directly.
The zero branch, repeated-solve main and outer loop are textually unchanged.
The source review identifies no extra operation on that path. It does not
establish why elapsed time increased; changes to untaken code can still affect
native execution. Do not infer an ownership defect or a resolved timing goal.
The complete original C and driver evidence remain in the retained audit archive
(artifact `13211059421`); no benchmark or acceptance threshold was changed.

## All completed timing comparisons

Values below are candidate time divided by same-source reference time. For example,
`0.90` means 10% less elapsed time. Each cell uses 98 recorded samples;
process launch, repeated complete solves, output and teardown are included.
The two ARM64 sessions and AMD64 session 2 have independently audited raw samples.
Allocation counters were measured separately; they do not explain a timing ratio.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 2 |
|---|---|---:|---:|---:|
| 3 / 0 | current | 1.03320 | 1.03320 | 1.01843 |
| 3 / 0 | history | 1.00103 | 0.99935 | 1.01906 |
| 3 / 1 | current | 0.99780 | 0.99813 | 1.01869 |
| 3 / 1 | history | 0.99805 | 0.99654 | 1.00857 |
| 3 / 199 | current | 0.95683 | 0.95433 | 0.97536 |
| 3 / 199 | history | 0.96073 | 0.95721 | 0.95767 |
| 3 / 1999 | current | 0.94993 | 0.95423 | 0.96861 |
| 3 / 1999 | history | 0.95736 | 0.95297 | 0.96334 |
| 33 / 199 | current | 0.91730 | 0.91757 | 0.92624 |
| 33 / 199 | history | 0.91827 | 0.91870 | 0.92723 |
| 129 / 199 | current | 0.91458 | 0.91469 | 0.92694 |
| 129 / 199 | history | 0.91489 | 0.91520 | 0.91623 |
