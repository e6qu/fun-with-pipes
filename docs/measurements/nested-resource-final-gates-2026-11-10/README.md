# Nested resource borrowing: final delivery

[PR #276](https://github.com/e6qu/fun-with-pipes/pull/276) passes every delivery gate
at `55060a061801a51a583dccc5777113e5ce49ccce`.

| Gate | Run | Result |
|---|---|---|
| Nine production jobs | `42814261330`, attempt 1 | Pass |
| Documentation | `42814261144`, job `129823185341` | Pass |
| Complete-log audit | `42828337804`, job `129871448955` | Pass; all ten reports have no issues |

Coverage includes native Linux, macOS and Windows on ARM64/AMD64, both macOS
ownership jobs, and the C/Rust benchmark job. Complete logs include target
coverage, compiler diagnostics and deliberate failure controls.

[audit.zip](audit.zip) retains the complete audit logs and reports, including the
empty `issues-all.json`. Local verification checks its exact size, SHA-256 and all
member checksums:

- Artifact: `13770546233`; bytes: 1,183,327.
- SHA-256: `15f2d8d5c04e66089e4b39c74c6ddeb6d4e24867631507ab18edf43392857cf4`.

The [merge receipt](merge.json) verifies squash commit
`b2bbd0389d227ea097ea1239d8d02ec6346f4be7` has the same tree as the tested head.
Its message is one 63-character line, without a body or trailers.
Duplicate postmerge runs `42829037660` and `42829037694` were cancelled after
equal-tree verification.

The [runtime results](../nested-resource-time-2026-11-10/README.md) retain one noisy
runtime comparison, one noisy compiler comparison and four missed ARM64 RSS limits.
Passing delivery checks does not change those performance outcomes.
