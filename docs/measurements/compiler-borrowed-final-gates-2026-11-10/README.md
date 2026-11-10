# Compiler borrowing: verified delivery

[PR #275](https://github.com/e6qu/fun-with-pipes/pull/275) merged as
`13d31fc4041a664129ed5674845750836faa0a84` after all final checks passed.
Its tree `c408d2eb804c3152c680dc327b48ccdf1145fbcc` equals the verified head
`a232e1e35062a37aa013975ac77bbd8cb4620663`, retained by
`roadmap/compiler-borrowed-delivery-2026-11-10`. The squash message is exactly
`Reduce compiler type copying and compilation time`, with no body or trailers.

| Gate | Run | Result |
|---|---|---|
| Nine native production jobs | `42767361217`, attempt 1 | All pass |
| Documentation | `42767360650`, job `129666864000` | Pass |
| Complete-log audit | `42778134759`, job `129701400605` | Pass; no issues |

Production covers Linux ARM64/AMD64, regular and ownership/corpus macOS
ARM64/AMD64, Windows ARM64/AMD64, and C/Rust benchmarks. The audit checks 257
Linux targets per host, 131 regular and 126 ownership macOS targets per
architecture, and 57 primary Windows targets plus their native probe logs.
Deliberate scheduler panic and test-runner failure controls pass their containing
tests; they are not overlooked production failures.

[audit.zip](audit.zip) retains all ten exact-head reports and an empty
`issues-all.json`. Every archive CRC, its 1,179,710-byte size and SHA-256
`671aaa052ea3c9c77f69ea8c26130e361292a0c85ed7d8018b524ff5be0835d7`
were verified. [Artifact metadata](artifact.json) and the
[complete audit log](audit-job.log.gz) identify the source and runner.

After verifying equal trees, duplicate main runs `42779270202` (production) and
`42779270047` (docs) were cancelled. [The receipt](duplicate-main.json) records
those cancellations; they are not additional coverage.

Delivery does not resolve the [four noisy AMD64 compiler-growth comparisons](../compiler-type-time-2026-11-10/README.md).
All complete-application timing targets and memory limits pass. Full milestone 6
growth-timing acceptance remains open.
