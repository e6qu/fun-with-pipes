# Session handoff

## Next action

Next: complete the eight-job focused matrix for [PR #184](https://github.com/e6qu/fun-with-pipes/pull/184),
then publish the evidence and require all nine production jobs plus documentation
at the final head. Squash-merge only after those gates pass, with one subject
under 80 characters and an empty body. Standing authorization remains in effect.

Branch `prove-retained-resource-ownership` is based on accepted PR #183 merge
`447a18f8b1ac4b7faa2c655fa2ea7a24d4e0c44c`. The latest tested compiler is `572b59a5`;
local changes share the handler fixture with WASI and enable both WASI jobs when
`queued-sockets` runs with `native_runner=all`. Publish these together, dispatch
that matrix, and audit every complete job log before proceeding.

## Current implementation

Queued callbacks can capture `UdpSocket`, `Listener` and `Conn`. Their runtime
objects cannot own a callback or queue; existing shared ownership keeps the
socket alive and closes it on final release. Files retain their single-use rule.
Channels, tasks, HTTP/2 streams and gRPC cells remain excluded as captures.
The [ownership contract](ownership.md#functions-stored-in-channels) explains this
subset. The 64-round fixture checks delivery, repeated calls, aliases, undrained
queues, errors, blocked sends and cancellation during socket IO. Test-only
counters check live socket objects and descriptor closure, with deliberately
broken cleanup controls. Ordinary runtime representation is unchanged.

The fixture investigation also exposed `attempt (apply ())` incorrectly retaining
its handled Error effect. `src/infer.rs::argument_type` now preserves the shared
remaining row in the handler's result. Traversal distinguishes produced functions
from accepted callbacks and follows actual record/variant fields. Tests include
Error and State handlers, aliases, returned records, missing-IO rejection and
existing callback-weakening cases. `tests/fixtures/handled_callbacks.fwp` is shared
by native and WASI tests. No new syntax or named-handler special cases were added.

## Validation and evidence

- Socket matrix `39563352313` at `2121a9b5` passed all six native platforms. All
  complete logs and 24 O0/O2 ARC/tracing binaries were audited. Archive digests,
  architectures, outputs and disassembly agree; ARC omits collector routines,
  while tracing controls retain them. This predates the inference repair.
  `/private/tmp/fwp-184-socket-evidence/report.json` records that scope;
  `/private/tmp/fwp-184-sockets.json` retains the log audit.
- Handler probe `39567130285` at `572b59a5` passed on Linux AMD64, including all
  compiler unit tests, all 14 `call_effects` tests, queued functions and adjacent
  socket/resource tests. Complete log audit:
  `/private/tmp/fwp-184-handlers-direction.json`.
- Earlier broad run `39561654177` passed both WASI jobs; all six native jobs had
  only the subsequently fixed socket fixture effect errors. Probe `39566088635`
  exposed four handler-test failures, repaired in `572b59a5`. Their full audits
  remain in `/private/tmp/fwp-184-focused.json` and
  `/private/tmp/fwp-184-handlers-probe.json`; no known failure is being deferred.
- Local guarded checks passed: project Rust formatting, whitespace, doc links,
  primitive inventory (394 declarations, 384 symbols, 40 aliases), and all 11
  native-runner tooling tests. No local native build or full suite was run.

Audit scripts are `/private/tmp/fwp-audit-184-direction.py`,
`/private/tmp/fwp-audit-184-sockets.py`, `/private/tmp/fwp-184-download-evidence.py`
and `/private/tmp/fwp-184-report-evidence.py`. Their source/run constants are
explicit: update them or make a separate copy for the final matrix. The older
socket report must not be presented as acceptance of later compiler changes.

## Local resources

Use `python3 scripts/local-guard.py` for serial local checks. Keep 64 GiB free,
target data below 2 GiB, sampled aggregate RSS below 1 GiB and the 180-second
limit. Last free-space check: 65.22 GiB. Builds, native execution, full suites
and measurements run on GitHub; no limits were raised.

The hash-verified accepted PR #183 macOS ARM64 compiler is
`/private/tmp/fwp-183-macos-compiler/fwp-macos-arm64/fwp`; receipts are beside it.
It can format source and check unchanged semantics, including the new Consumer
preservation control. It predates both compiler changes and rejects the handler
regression; do not use it to claim candidate acceptance. Its raw/optimized
interpretation passed the earlier socket fixture before that fixture was changed
to exercise the handler repair. Accepted older delivery details are in
[history](roadmap-history.md#checked-product-bounds-pr-183), not a competing plan.

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
