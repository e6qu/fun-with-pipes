# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing; prefer ownership
and borrowing, with ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** run the prepared [API memory checks](measurements/http-application-memory.md)
on GitHub, audit every host and fix all observed failures. This checkout is
`/private/tmp/fwp-http-application-memory`, branch `http-application-memory`,
prepared from `bd0dc0100a516099590c340c012f74b7b666ebd2`.

[PR #207](https://github.com/e6qu/fun-with-pipes/pull/207) remains the only active
PR. Its production run `40064764447` and documentation run `40064764348` require
all ten exact-head gates plus independent binary review before squash merge.
Benchmark/docs pass; eight native jobs are still running, with no observed failure.
Keep its delivery checkout `/private/tmp/fwp-file-http-delivery` unchanged.
Do not open another PR until #207 is verified and merged. Standing publication
and merge authorization remains active: one subject at most 80 characters,
empty body, verified merge tree and message.

The API observer covers idle managed charge, accepted sockets, metric storage,
RSS, partial-body disconnects and forced shutdown; missing-free/close controls
must fail. Eight concurrent clients exercise repeated success/error/streaming
requests. Native execution and binary review remain pending. Formatting and
16 native-runner controls pass (1.61s and 7.67s). The verified #206 compiler
emitted C (18.66s); local Clang O1 exceeded the fixed 1 GiB aggregate RSS guard
and was stopped. Move validation to GitHub, never raise or bypass that limit.
Compiler receipt: `/private/tmp/fwp-verified-206-compiler/receipt.json`.

Focused source `ef66ca9973ffe55a9d246db4d6ae8373bd7749ad`, run `40066024251`,
exposed a test-driver bug: API counters use floating text such as `80.0`.
Five completed hosts pass five older tests and fail both new memory tests at
this parser. Their complete logs show no other cause. Intel macOS is still running;
continue auditing its original job while the combined repair runs.
The corrected parser checks finite, integral floating values. An 80-response raw
interpreter probe passes (0.50s); startup's three real-child controls pass (4.90s).
Observer insertion anchors pass (2.71s). Native memory results remain unverified.
The repair also prevents sampling handshakes after shutdown begins, records
portable exit codes and adds independent binary/record inspection.


## What changed and what passed

Task files now have repeated 128/4,096-item UTF-8 edit checks, partial read/write
failures, final-content checks and independent write-handle controls. Failed runs
save output/status before result assertions. Existing production jobs retain
these application artifacts. Both macOS shards export evidence: directory tests
run in the GC shard, text/task tests in the regular shard. A new assignment-aware
coverage check rejects the missing-export bug caught before publication. Final
review combines both archives. [The report](measurements/file-applications.md)
explains the workloads, memory counters, observed process-memory growth and limits;
these are correctness/memory checks, not C/Rust timing benchmarks.

Focused file run `40058977728` at
`8e097fca79ecb82efbced4080352f0af02f5e6b2` passes six hosts with all logs audited.
Independent review verified 240 binaries, 480 executions and 120 memory series
(23,040 checkpoints). Reports are in `fwp-task-file-evidence/8e097fca79ec` under
`/private/tmp`; do not repeat completed inspections. The report generator is
COMPLETE; do not rerun it over later prose edits. The 85-example compiler inventory
accepts 81 in both modes, rejects three intentionally invalid examples in both,
and retains ARC's expired-derivative rejection. It is C-emission evidence only.

HTTP tests now check startup deadlines, child cleanup, tool results, response
framing and Windows CTRL_BREAK. Shutdown observes handler entry before signaling
and verifies the pending reply. Local O1 real-child startup controls and a bounded
raw-interpreter shutdown probe pass; neither replaces current native acceptance.
Five hosts passed focused run `40060046544`. Intel macOS reached its 25-minute
limit during the final native compilation after four complete targets passed.
The workflow now splits protocol tests from application/connection tests, keeping
all tests and the deadline. Full split run `40062164443` at
`ce8253381cf39761245ff6c674ea785920998056` passed all twelve jobs and complete log
audits. Its auditor is `/private/tmp/fwp-audit-file-http-results.py`; receipt
`fwp-file-http-results-audit.json`. Do not count the cancelled earlier run as full
acceptance. Final production still includes both HTTP targets.

Code-size descriptions now distinguish executable section bytes, including
padding, from decoded instruction counts. Six measurement/inspection scripts use
accurate field names for new output; historical raw data stays under its original
source identity. Publication checks parse the scripts and exercise the six real
compiler-process controls. Final production checks cover the new output schema.

## Previous delivery and next roadmap work

[PR #206](roadmap-history.md#array-output-storage-and-startup-stack-pr-206) is
verified and merged. Its ten gates, 8,166 saved outcomes, twelve stack objects
and 144 layouts passed; the acceptance record preserves identities. Completed
artifact inspections and publication helpers must not be rerun. Preserve unique
failed archives; only verified duplicate caches may be pruned.

After this delivery, complete the repeated long-running service scenario in the
[application acceptance plan](application-acceptance.md), including disconnects,
cancellation and live-memory samples. Continue replacing collector-specific checks
with ownership guarantees and use equivalent-work numerical comparisons to choose
optimizations. Existing HTTP correctness tests do not establish service memory
bounds; existing allocation savings do not establish C/Rust speed parity.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
