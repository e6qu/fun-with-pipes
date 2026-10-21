# Session handoff

## Next action

Next: require all nine production jobs plus documentation for the final head of
[PR #184](https://github.com/e6qu/fun-with-pipes/pull/184). Audit every completed log
and fix every failure before merging.
Then squash-merge with one subject under 80 characters and an empty body.
Standing authorization remains in effect; no merge is authorized by focused
checks alone.

Branch `prove-retained-resource-ownership` is based on accepted PR #183 merge
`447a18f8b1ac4b7faa2c655fa2ea7a24d4e0c44c`. Implementation `d0d27930` passed all
eight jobs in focused run `39568125065`: six native platforms and two WASI hosts.
The review commit adds the evidence report and documentation only.

## Current implementation

Queued callbacks can capture `UdpSocket`, `Listener` and `Conn`. Their runtime
objects cannot own a callback or queue; existing shared ownership keeps the
socket alive and closes it on final release. Files retain their single-use rule.
Channels, tasks, HTTP/2 streams and gRPC cells remain excluded as captures.
The [ownership contract](ownership.md#functions-stored-in-channels) explains this
subset. Ordinary runtime representation is unchanged.

The same PR fixes `attempt (apply ())` incorrectly retaining its handled Error
effect. `src/infer.rs::argument_type` preserves the shared remaining effect row
through returned functions, records and variants, while distinguishing accepted
callbacks from produced values. Tests cover Error/State handlers, aliases,
returned records, required IO and ordinary callback rules. The shared
[handler fixture](../tests/fixtures/handled_callbacks.fwp) runs in the interpreter,
native code and WASI. No syntax or named-handler special cases were added.

## Validation and evidence

The [evidence guide](measurements/queued-callbacks.md) explains the scope and links
the machine-readable report. All complete focused logs were audited. All 24
native socket binaries match their platform and expected output; ARC excludes
collector routines and tracing controls retain marking. Socket-object counts,
descriptor closure and managed allocator teardown pass, including deliberately
broken cleanup controls. Four WASI handler modules match interpretation and pass
physical-allocation, byte and count-table teardown checks. These are correctness
results, not performance or total-process memory claims.

Receipts and reproducible audit scripts are under `/private/tmp`:
`fwp-184-final-focused.json`, `fwp-audit-184-final-focused.py`,
`fwp-184-final-download.py`, `fwp-184-wasi-evidence.py` and
`fwp-184-final-report.py`. Downloaded artifacts and digest receipts are in
`fwp-184-final-evidence/`. Source and run constants are explicit; do not reuse
an older receipt as acceptance of a changed compiler.

Earlier runs exposed fixture effects and handler-row inference failures. Their
complete logs remain in `fwp-184-focused.json`, `fwp-184-handlers-probe.json` and
`fwp-184-handlers-direction.json`; the final focused run verifies the repairs.
No known failure is being deferred. Local guarded formatting, whitespace,
primitive inventory and native-runner tooling checks passed. Full builds and
native execution ran on GitHub, not locally.

## Local resources

Use `python3 scripts/local-guard.py` for serial local checks. Preserve 64 GiB
free disk, target data below 2 GiB, sampled workload RSS below 1 GiB and the
180-second limit. Move builds, full suites and measurements to GitHub.

The hash-verified PR #183 macOS ARM64 compiler is
`/private/tmp/fwp-183-macos-compiler/fwp-macos-arm64/fwp`; receipts are beside it.
It can format source and check unchanged semantics, but predates both compiler
changes here. Do not use it to claim candidate acceptance. Accepted older
delivery details are in [history](roadmap-history.md#checked-product-bounds-pr-183).

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
