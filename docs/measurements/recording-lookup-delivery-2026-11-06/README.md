# Recording lookup reuse: verified delivery

[PR #262](https://github.com/e6qu/fun-with-pipes/pull/262) merged as
`9a9dc49c53212b562cd9de06f908248ceb6109af`. Its tree exactly matches tested
source `a8e427e8cf57a36110c2cdf4ab63569a0d503666`. The squash message has one
54-character line, with no body or trailers.

- All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42141696622) pass.
- [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42141693447) passes at the same source.
- The [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42151713370)
  verifies every job log, test log and artifact identity without unresolved issues.

Coverage: 257 Linux targets per architecture; 131 regular and 126 ownership
macOS targets per architecture; 57 early Windows targets plus 155 native targets
per architecture matched to successful executions. The audit also covers the
benchmark and docs jobs. Downloaded archive and retained-log hashes were verified.

[The receipt](receipt.json), `audit.zip`, [audit job](audit-job.json) and its
[full log](audit-job.log.gz) preserve the identities and checks. Two duplicate
postmerge runs were cancelled only after verifying identical tested/merged trees.

The implementation reduces tape lookups from eight to three per pair/update.
[Allocations, tracked memory and reported maximum frames](../recording-lookup-census-2026-11-06/README.md)
are unchanged. [All 32 long-case speed targets](../recording-lookup-time-2026-11-06/README.md)
remain unmet, including AMD64 slowdowns. [One compiler-time control](../recording-lookup-analysis-2026-11-06/README.md)
is inconclusive. These outcomes remain open under the agreed policy to retain
verified reductions; delivery does not turn them into timing passes.
