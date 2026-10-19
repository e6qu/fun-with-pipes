# Session handoff

## Next action

[PR #168](https://github.com/e6qu/fun-with-pipes/pull/168), branch
`ownership-tail-recursion`, is draft while fixing CI. PR #167 is merged; its
[delivery record](roadmap-history.md#interactive-tools-and-cached-map-borrows-pr-167)
contains the accepted revision and evidence.

Next: publish the shutdown repair, dispatch `numerics.yml` with `suite=shutdown`
and `suite=language`, and audit every result. Then mark the PR ready to run the
complete production matrix. Require all nine production jobs, documentation and
both focused suites on the final head before squash merging. Use a one-line
subject of at most 80 characters and an explicitly empty body.

## Current batch

PR #168 adds eligible self-tail frame reuse, cycle-proof diagnostics and lesson
23's scoped callback, channel, cancellation and graph examples. The compiler
keeps the original expression trees so native record, variant and wide-number
layouts remain available. It prepares arguments before replacing locals, retires
reuse tokens and preserves cancellation checks. REPL remapping retains the proof.
Native executable teardown also releases scheduler storage exposed by lesson 23.
Default tracing removal and all seven roadmap areas remain unfinished.

## CI failures and repair

All jobs at `7bc07ff662220d53ae4d01b36ba60cd600d0f0e6` were audited.
[Production run 39178860004](https://github.com/e6qu/fun-with-pipes/actions/runs/39178860004)
**failed acceptance**: all eight execution jobs timed out, with failures before
the stalls. Benchmarks passed. Linux stalled in `aot` and `examples`; regular
macOS in `aot` and `services`; GC macOS in `examples` and `web`. Windows stalled
in native networking after reporting seven test failures. Queues are not the cause.
Logs: `/private/tmp/fwp-pr168-7bc0` and `/private/tmp/fwp-pr168-stalls`.

Repairs awaiting runner verification:

- Network I/O tasks defer cancellation. Executable teardown now closes their
  connections before draining tasks, as library teardown already does. A new
  native regression covers pooled and unpooled connections at O1/O2 with GC
  enabled/disabled; deliberately omitting connection closure must time out.
- Ten final-memory ledgers used an allowance for the scheduler root that teardown
  now frees. They now require release of the full initial allocation budget,
  so a freed root cannot hide leaked task results or command arguments.
- Collection and map tests now insert their ledger check after closure cleanup
  without assuming it immediately follows CAF cleanup. The library shutdown
  negative control targets its own drain loop, not the new executable loop.
- The cached-map test preserves status and stderr when a rejected runtime setting
  closes stdin before the parent writes; all expected diagnostics remain checked.
- The native test runner has an explicit per-target deadline: 1800 seconds in
  production, 900 in focused shutdown checks. It kills the timed-out process
  group, records failure and continues other targets. Coverage is unchanged.

The new `shutdown` suite covers every failed/stalled target and every changed
ledger on Linux AMD64 and macOS ARM64. It does not replace full native acceptance.

## Existing evidence and limits

At `7bc07ff6`, [focused run 39178030845](https://github.com/e6qu/fun-with-pipes/actions/runs/39178030845)
passed formatting, all-target Clippy, 49 Rust tests (zero skips), eleven Python
checks, the real browser and recursion measurements. Documentation `39178000702`
also passed. These results do not verify the current shutdown repair.

Runner measurements compare recursive fwp with an explicit fwp loop, not C/Rust.
On Linux AMD64/Xeon 6973P-C/GCC 13.3, all eight variants have one 10-byte request
(16 charged bytes), zero retains and zero final charge at both 1,000 and 1,000,000
iterations. O0 recursive/explicit medians: tracing 3.60/5.85 ms; ARC 3.54/5.98 ms,
including process startup/output/shutdown. **O2 eliminates the recursive countdown
but retains the explicit loop**, so its timings do not establish equivalent
executed-loop performance. All eight actual binary hashes match their disassembly
in `/private/tmp/fwp-pr168-7bc0-evidence`. No general speedup is claimed.

## Local checks

Checks use `python3 scripts/local-guard.py`; no local compiler build or full suite.
The guard initially refused an artifact download below 64 GiB free disk. After
free space recovered above the unchanged limit:

- `cargo fmt --all`: pass, 1.59 seconds.
- `python3 scripts/test-native-test-runner.py`: nine tests pass, 3.88 seconds;
  the deliberate timeout fails, kills its child and preserves later coverage.

Cross-platform compiler/runtime verification remains on GitHub runners.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership/cycle contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

The seven project work areas in [PLAN.md](../PLAN.md) remain open. Default tracing
removal is unfinished. JIT is excluded. After this delivery, the next substantial
work is the next ownership/performance gap selected from representative programs
and the measured results of this batch. Do not repeat this batch as a new task.
