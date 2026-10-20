# Session handoff

## Next action

Next: monitor [PR #181](https://github.com/e6qu/fun-with-pipes/pull/181), branch
`borrow-local-channels-and-preserve-cleanup`, and audit every production job
and complete log for its exact head. Publish these reports and mark the draft
ready to start the full platform run. Focused
Linux validation and measurement audits are complete. Require all nine production
jobs and documentation before squash merge, with a one-line subject of at most
80 characters and an empty body. Verify the merge tree and message afterward.
Standing authorization covers publication, repairs and merge.

The branch starts at accepted PR #180's merge `fe491a97`. Root implementation
`f320ed01` has the same tree as focused source `62ed1045` before the report and
handoff updates. The old preparation worktree `/private/tmp/fwp-local-channel-aliases`
preserves source history; continue edits in the root checkout.

## Current batch

- Borrow temporary channel names through enclosing bindings, matches and
  borrowing calculations inside record fields. Reject stored aliases,
  consuming/unknown uses, different-field lifetime evidence and resource scopes.
- Keep changed error payload/type fields and task-scope child metadata valid
  across C `longjmp`, using volatile fields without adding heap objects.
- Test normal return, failure and cancellation at O0/O2/O3, independent owners,
  callback-context destruction, GC verification, reuse poisoning and deliberately
  broken ownership controls. A separate test fails after spawning 65 children
  and compares interpreter output and complete native cleanup four times.
- Record counts, generated C, actual binaries, stack frames and equivalent-work
  C/Rust comparisons. Saved-binary repeats retain elapsed and child CPU samples.

### Verified focused results

Source `62ed104504b9e9a032434223120785e3cc37a47f`
(`roadmap/revision-record-borrows-62ed1045`) passes **217 checks per host**
in [run 39469883481](https://github.com/e6qu/fun-with-pipes/actions/runs/39469883481):
161 compiler checks, 54 integration checks and two measurements. Both full logs
are clean. Receipt: `/private/tmp/fwp-record-alias-audit.json`; artifacts:
`/private/tmp/fwp-record-alias-costs`.

[The report](measurements/channel-local-borrows.md) audits 180 profiles and
20 ordinary channel binaries. Relative to source `37de5ba4`, closed-function
retains fall 1→0 and shared-text retains 3→2 per message. Allocations and peak
charge are unchanged; ARC ends with zero charge and no collections. ARC loop
frames shrink 424→344 / 416→352 bytes for closed sends and 552→456 / 512→432
for shared text (AMD64 / ARM64). No channel execution-time claim.

All seven numerical fwp binaries and their C/Rust peers are byte-identical to
those from `37de5ba4` on each architecture. The final host models are EPYC 9V74
and Neoverse-N2. Equivalent decimal-counting medians show fwp 7.8%/3.6% above C;
keep the larger earlier EPYC 7763 gaps as well. The record-field extension changes
only shared-text binaries/counts relative to intermediate source `b15488ad`.

The [saved-binary repeat](measurements/local-borrows-repeat-2026-10-20.json)
uses measurement source `373aa1902c7329be58c15fadbd782a5ec79c97c0`
(`roadmap/revision-borrow-repeat-373aa190`),
[run 39468533196](https://github.com/e6qu/fun-with-pipes/actions/runs/39468533196),
and `b15488ad` binaries from run `39465380125`. Both logs and all artifacts are
audited: 24 balanced timing rounds, two warmups, three separate RSS/count samples,
source/binary hashes and an injected-allocation control. Receipts/artifacts:
`/private/tmp/fwp-alias-repeat-audit.json`, `/private/tmp/fwp-alias-repeat-memory`.

On EPYC 7763, fwp's median elapsed time is 53.9% above C and child CPU time
55.3% above C. The spread occurs in CPU time too; descheduling alone cannot
explain it. Neoverse-N2 gaps are 3.7% elapsed and 3.8% CPU. The cause remains
under investigation; no timing fix is implemented. Byte-identical benchmark
binaries rule out this channel-borrow change as its cause. Inspect the generated
counting loop and use controlled same-host comparisons before proposing a fix.

## Accepted baseline

[PR #180](https://github.com/e6qu/fun-with-pipes/pull/180) passed all nine
production jobs in `39457866569` and documentation in `39457866666` at
`64cfa0081dab2f6b19b6157e844c49481749a605`. All full logs were audited. Merge
`fe491a97466d9b6d972059553c95886ad850aacb` has identical tree
`38bdbac28bbd381b98b5b326c4fea3af1efb1530` and the verified one-line message
`Borrow function channels and eliminate temporary integer text`.
Receipt: `/private/tmp/fwp-180-acceptance.json`. Only duplicate post-merge
runs `39470377254` and `39470376880` were cancelled.
See [delivery history](roadmap-history.md#function-channel-borrows-and-integer-text-pr-180).

## Local checks and resources

Every local check uses `python3 scripts/local-guard.py`; full builds, suites,
native compilation and benchmarks run on GitHub. Preserve 64 GiB free disk,
target below 2 GiB, sampled aggregate RSS below 1 GiB and the 180-second limit.
No limits were raised. Root target remains 4 KiB.

After disk space fell below the reserve, checks stopped until it recovered.
At the user's request, 1411 generated files from five obsolete CI download trees
were removed only after verifying their remote artifacts remain available.
Reclaimed 2.607 GiB; free space afterward was 72.210 GiB. Reports, logs, source
examples, current evidence and working changes remain. Recovery manifest:
`/private/tmp/fwp-disk-cleanup-2026-10-20.json`. No unrelated process was stopped.

Recent guarded commands and results:

- `python3 /private/tmp/fwp-audit-record-alias.py`: full logs clean, 3.28s.
- `gh run download 39469883481 --dir /private/tmp/fwp-record-alias-costs`: 16.39s.
- `python3 scripts/summarize-channel-costs.py --run 39469883481 --source 62ed104504b9e9a032434223120785e3cc37a47f --artifacts /private/tmp/fwp-record-alias-costs --output docs/measurements/channel-record-borrows-2026-10-20.json`: pass, 1.57s.
- `python3 scripts/summarize-scalar-text.py --run 39469883481 --source 62ed104504b9e9a032434223120785e3cc37a47f --artifacts /private/tmp/fwp-record-alias-costs --output docs/measurements/record-borrows-benchmarks-2026-10-20.json`: pass, 2.04s.
- `python3 /private/tmp/fwp-audit-record-comparison.py`: profiles, hashes and 217-check totals pass, 0.13s.
- Saved C/assembly inspection: shared-text channel alias removed; recorded frames
  verified from actual prologues, 0.13s each. No local native binaries executed.
- `python3 scripts/check-roadmap.py`: previously caught a missing status table and
  next-action marker; both restored, then 72 link sets, 106 tag pairs and seven
  roadmap steps passed in 2.89s. Final reports, whitespace and equality with the focused implementation
  source then passed together in 3.28s.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |

All seven areas in [PLAN.md](../PLAN.md) remain open. Default native execution
still includes tracing GC; JIT is excluded. Persistent subscriptions, retained
resources, resource-owning tail frames and mutual recursion need further proofs.
Captured-channel eligibility needs provenance as well as payload types. Weak
handles remain a proposal. Measured shared-message costs remain; completed
microbenchmarks do not complete the roadmap.
