# Scalar append inlining: verified delivery

[PR #263](https://github.com/e6qu/fun-with-pipes/pull/263) merged as
`53bd2d78e7a19afc5c7f697bf22ee380c4f9b2ac`. Its tree matches tested source
`a90f793e485aa91736156ae87dfc3ae36ec9cbad` exactly. The squash message is one
42-character line, with no body or trailers.

- All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42166013453) pass.
- [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42166011721) passes at the same source.
- The [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42175642051)
  verifies every job log, target log and artifact identity with no unresolved finding.

Coverage: 257 Linux targets per architecture; 131 regular and 126 ownership
macOS targets per architecture; 57 early Windows targets plus 155 native targets
per architecture. Benchmark and documentation logs are included. The downloaded
archive digest, all ten source receipts and retained log hashes were checked.

[The receipt](receipt.json), `audit.zip`, [audit job](audit-job.json) and
[complete log](audit-job.log.gz) retain the evidence. Duplicate postmerge runs
were cancelled only after verifying identical tested/merged trees.

The checked scalar append body is now inlined. Allocation and validation counts
are unchanged; maximum reported frame growth is 16 bytes on ARM64 and zero on
AMD64. [Long runtime cases](../recording-inline-time-2026-11-06/README.md) improve
2.26–8.12%; 13/32 meet the frozen 5% target, with 19 goals still open. Small-case
and copy limits pass. [One compiler-time copy control](../recording-inline-analysis-2026-11-06/README.md)
remains inconclusive. Delivery does not turn those limits into passes.
