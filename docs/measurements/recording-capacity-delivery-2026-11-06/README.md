# Checked capacity calls: verified delivery

[PR #264](https://github.com/e6qu/fun-with-pipes/pull/264) merged as
`d992a5734a12cf976c1ca20f75e9829a18bde0cc`. Its tree matches tested source
`d453662e4226dbf613b5c8accc467a67fa12a359` exactly. The squash message is one
38-character line, with no body or trailers.

- All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42186095529) pass.
- [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42186063070) passes at the same source.
- The [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42197602289)
  verifies every job log, target log and artifact identity with no unresolved finding.

Coverage: 257 Linux targets per architecture; 131 regular and 126 ownership
macOS targets per architecture; 57 early Windows targets plus 155 native targets
per architecture. Benchmark and documentation logs are included. The downloaded
archive digest, all ten source receipts and retained log hashes were checked.

[The receipt](receipt.json), `audit.zip`, [audit job](audit-job.json) and
[complete log](audit-job.log.gz) retain the evidence. Duplicate postmerge runs
were cancelled only after verifying identical tested/merged trees.

The capacity check stays at its caller; buffer growth keeps its existing shared
body. Bounds, failure cleanup, allocation and validation counts are unchanged.
[Memory measurements](../recording-capacity-census-2026-11-06/README.md) show no
increase in live storage or largest reported frame. All 14
[compiler comparisons](../recording-capacity-analysis-2026-11-06/README.md) qualify.

[Long runtime cases](../recording-capacity-time-2026-11-06/README.md) improve
1.86–14.02%; 17/32 meet the frozen 5% target. Fifteen speed targets and one AMD64
identical-copy limit remain open. Small-case limits pass. No qualified timing
was repeated. Delivery does not turn those missed limits into passes.
