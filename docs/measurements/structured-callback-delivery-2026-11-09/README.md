# Known array callbacks: verified delivery

[PR #272](https://github.com/e6qu/fun-with-pipes/pull/272) merged as
`32d643d0a3e29c25a55d9b05c5492c0ab73e7c20`. Its tree matches tested source
`8e7cdb94337c6fdac5656dfcbdab768d4a36e985` exactly:
`e394f66db1a745e94f2fa142f4c9f0657fe673dd`. The merge message is one line,
under 80 characters, with no body or trailers.

| Gate | Result |
|---|---|
| [Nine production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42516732838) | Pass, attempt 1 |
| [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42516732902) | Pass, job `128841273815` |
| [Complete log/artifact audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42525276460) | Pass, job `128867428878` |

The [complete archive](audit.zip) matches the SHA-256 in
[GitHub's artifact metadata](artifact.json). [The audit log](audit.log.gz) records
all ten job audits: 257 target logs per Linux host, 131 per regular macOS host,
126 per macOS ownership host, and 57 per Windows host. Each Windows job also
matches all 155 started targets to successful retained results. No unexpected
failed target or compiler diagnostic remains.

Known `array.map`/`array.generate` callbacks now avoid temporary numeric inputs
through existing bounded specialization. General gradients, nested AD, F128,
shared inputs, evaluation order and cleanup retain their coverage.
[Measured results](../structured-array-callbacks-2026-11-08/README.md) show
85–91% less large-case computation on both ARM64 sessions. At 129 inputs,
neighbor-gradient requests fall from 1,284 to 260 and independent loss from
518 to 260. Peak managed storage stays 9,536 bytes.

AMD64 identical-copy noise leaves the combined timing target open. This delivery
neither changes that acceptance rule nor establishes parity with C/Rust/Swift.
Milestone 4 continues with [explicit ownership comparisons](../ownership-peers.md).
