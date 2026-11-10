# Application and compiler-cost delivery

[PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) was squash-merged as
`e8997ac874f2c57009a5a13a7a5192c4f762272e`. Its tree equals verified source
`9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`, retained by
`roadmap/application-delivery-format-2026-11-10`.

| Gate | Passing run |
|---|---|
| Nine production jobs | [42749157893](https://github.com/e6qu/fun-with-pipes/actions/runs/42749157893), attempt 1 |
| Documentation | [42749157995](https://github.com/e6qu/fun-with-pipes/actions/runs/42749157995), job `129608390924` |
| Complete-log audit | [42759900526](https://github.com/e6qu/fun-with-pipes/actions/runs/42759900526), job `129642883683` |

The audit covers all main logs and 257 target logs per Linux host; 131 regular
and 126 ownership targets per macOS architecture; 57 primary Windows targets
plus all 155 started native targets per Windows host. It also verifies exact
source/artifact identities, benchmarks and documentation. No unresolved diagnostic
remains. Both final Windows jobs pass the repaired backpressure test.

[The complete archive](audit.zip) contains all ten audit reports and retained
logs/source receipts. Its SHA-256, byte size, ZIP CRC and empty issue list were
verified against [artifact identity](artifact.json). The audit runner's complete
log is retained as `audit-job.log.gz`. The squash message was verified as exactly
one line under 80 characters, without a body, trailers or attribution.

This completes milestone 5's delivery. It includes compiler phase reports,
independent-generic-use bounds, complete application/tool workflows, sustained
HTTP measurements and the Windows test repair. [Results and limits](../application-compiler-load-2026-11-10/README.md)
remain explicit: these observations establish no universal C/Rust/Swift parity,
and later fine-grained reporter overhead is unmeasured. Original milestone 1–3
timing acceptance remains open.
