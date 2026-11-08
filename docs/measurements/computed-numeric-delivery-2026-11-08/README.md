# Computed numeric inputs: verified delivery

[PR #269](https://github.com/e6qu/fun-with-pipes/pull/269) merged as
`bbcaafea00d6bf9e26feea60f90d8d440aa16d00`. Its tree equals tested source
`e7965762490c89d2a39f5937fe8322291ea906fc`:
`3a6d513c61e331f86f10824b5a1926b4306db543`. The squash message is one line,
under 80 characters, without a body or trailers.

| Gate | Result |
|---|---|
| [Nine production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42422580747) | Pass, attempt 1 |
| [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42422580660) | Pass, job `128553981338` |
| [Complete log/artifact audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42430683595) | Pass, job `128578680532` |

The [complete archive](audit.zip) retains the ten job audits, full logs and
native target/probe logs. [Artifact metadata](artifact.json) identifies its
source and SHA-256 digest; [the audit job log](audit.log.gz) records each host's
result. The downloaded archive's digest was checked before retention.

These gates verify correctness and delivery. The separate
[runtime and allocation results](../computed-numeric-time-2026-11-07/README.md)
and [compiler costs](../computed-numeric-analysis-2026-11-07/README.md) retain
three inconclusive timing controls. Passing CI does not turn those into passes.
