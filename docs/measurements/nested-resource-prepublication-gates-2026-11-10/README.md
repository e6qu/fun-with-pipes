# Nested borrowing: production checks before final reports

All nine production jobs, documentation and the complete-log audit pass at
`d80357c8c81d206c9d9934b141b5a5fafe97c430` in [PR #276](https://github.com/e6qu/fun-with-pipes/pull/276).
This validates the production compiler change. Later diagnostic/report commits
still require their own final-head delivery gates; this record does not merge them.

| Gate | Run | Result |
|---|---|---|
| Nine native production jobs | `42798426347`, attempt 1 | Pass |
| Documentation | `42798426476`, job `129769434906` | Pass |
| Complete-log audit | `42810654258`, job `129810941999` | Pass; no issues |

Coverage includes Linux ARM64/AMD64; regular and ownership/corpus macOS on both
architectures; native Windows ARM64/AMD64; and C/Rust benchmarks. Complete logs
include target coverage, diagnostic review and deliberate failure controls.

[audit.zip](audit.zip) retains all ten reports, complete logs and an empty
`issues-all.json`. Its size, SHA-256 and member CRCs pass local verification:

- Bytes: 1182416.
- SHA-256: `a5e228822848a833db151065d669f08c542c8e691c5c27f59aa8cf1f7151023b`.
- GitHub artifact: `13760124978`.

The [runtime report](../nested-resource-time-2026-11-10/README.md) retains one noisy
runtime comparison, one noisy compiler comparison and four missed RSS limits.
Passing production tests does not change those performance outcomes.
