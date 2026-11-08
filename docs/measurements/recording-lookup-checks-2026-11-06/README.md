# Recording lookup safety checks

All three focused jobs pass at `6a0ae280c4616f791df507b44cbd31935a16cd67`:
Linux ARM64/AMD64 with GCC and macOS ARM64 with Clang.
[Native run](https://github.com/e6qu/fun-with-pipes/actions/runs/42129223759),
[complete artifact audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42134128147).

Each host passes 25 native test targets and 302 compiler unit tests, with four
existing ignored unit tests. Formatting, lint, primitive contracts and selection
checks also pass. The [audit summary](audit/summary.json) reports no unresolved
issues: 848 native images and 864 recorded probe observations checked per host.

The new recording probe checks two appends sharing one tape lookup. It covers
buffer growth, exact weight bits, gradients, invalid/expired tape IDs, slot reuse,
inactive inputs, validation order and cleanup after a trap. O1/O2 builds run with
workspace reuse enabled and disabled. Deliberately broken lookup, parent-check
and error-order observers fail as required. Recording outside an autodiff scope
is still rejected. Real-program source checks find six direct recording sites
sharing local state in the Rosenbrock objective worker.

The auditor inspected every retained target log, generated-source digest, probe
result and native image header. Its reports retain the exact jobs and original
artifact identities: [ARM64](audit/arm-audit.json), [AMD64](audit/amd-audit.json),
[macOS](audit/mac-audit.json). The corresponding `*-records.zip` files contain
logs, observations and selected generated sources. Full native images remain in
the original CI artifacts; their hashes and checked architectures are recorded.

[Audit job metadata](audit-job.json), [its complete log](audit-job.log.gz) and
[downloaded artifact identity/digest](artifact.json) establish the audit source.
The local retention check verified archive, log and record-bundle digests.

These are focused correctness checks. The subsequent [delivery](../recording-lookup-delivery-2026-11-06/README.md)
passes the full platform matrix. The [frozen comparison](../recording-lookups.md)
and [runtime results](../recording-lookup-time-2026-11-06/README.md) keep timing
acceptance separate: all 32 original long-case speed targets remain unmet.
