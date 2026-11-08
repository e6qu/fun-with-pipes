# Fresh F64 output stores: verified delivery

[PR #270](https://github.com/e6qu/fun-with-pipes/pull/270) merged as
`f87796b52081889b96859dbd72bf4af9a6726207`. Tested source
`e8226a4229f0726c4aafac65a0e52d751be3e3b5` has the same tree:
`dc4282cdc34cbe7d9c13cecec0d55f3a037088c8`. The squash message is one line,
under 80 characters, without a body or trailers.

| Gate | Result |
|---|---|
| [Nine production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42445576778) | Pass, attempt 1 |
| [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42445576736) | Pass, job `128623674414` |
| [Complete log/artifact audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42466806957) | Pass, job `128688101490` |

The [archive](audit.zip) retains all ten job audits, full logs and target/probe
records. Its digest matches [GitHub's artifact metadata](artifact.json).
[The audit log](audit.log.gz) records the host results.

The [first audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42466048122)
flagged two Intel macOS checkout errors. The first fetch timed out; checkout's
existing retry repeated the same command, fetched the exact requested commit,
and completed successfully. Tests then passed. The repaired auditor keeps those
diagnostics in `expectedDiagnostics` only after proving the identical retry and
successful exact-source checkout. Wrong-source, incomplete, failed or unexpected
errors still fail its ten controls. The passing archive retains the full log
and both recovered diagnostics; it does not erase the initial finding.

Delivery does not resolve every performance target. [Original results](../fresh-array-costs-2026-11-08/README.md)
show 26–31% less large-array computation on ARM64. AMD64 timing acceptance stays
open, including noisy copy comparisons and a qualified zero-update regression.
The user merged the improvement; [milestone 1](../../../PLAN.md#milestones)
remains incomplete.
