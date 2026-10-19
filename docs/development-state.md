# Session handoff

## Next action

Branch: `cycle-safe-channel-ownership`, based on merged PR #169 at
`bbb3d530e497549316d563671f1c74c51b772934`. Its files match tested head
`2429292d6f82d0cde46519fe7cb23c7527887e8d`.
All nine production jobs (`39233047574`), docs (`39232286485`), language/tools
(`39232335383`) and three-host shutdown checks (`39232331253`) passed before the
user merged. [History](roadmap-history.md#static-constants-and-complete-shutdown-checks-pr-169)
records the completed storage repair; do not repeat it as new work.
Post-merge docs `39247754197` also passed. Duplicate production run
`39247754322` was cancelled after confirming identical files and complete PR-head
acceptance, freeing its runners for the new batch; cancellation is not a pass.

[PR #170](https://github.com/e6qu/fun-with-pipes/pull/170) is open at
`262a73b8a099d222e5d597f572ab6abaa5603e94`.
Full production `39249106161` exposed the same executable-filename failure on
both Windows hosts; docs `39249106113` passed. Next: publish the filename repair
below and audit all nine production jobs plus documentation on the new head.
The full matrix includes compiler proof units, native ownership controls and
actual WebAssembly checks; no additional duplicate suite is needed.
Squash-merge only after all required gates pass, with one explicit subject of at
most 80 characters and an empty body. No trailers or attribution.

## Current batch

### Windows inspection repair

The new `arc_tasks` symbol check requested `arc-O1`, but Windows emitted
`arc-O1.exe`. Execution had inferred the suffix; `nm` and artifact copying do not.
The test now supplies an explicit `.exe` path to every consumer and asserts that
the compiler produced that file. Tracing-symbol checks, cleanup ledgers and all
negative controls remain intact. CONTRIBUTING records this portable convention.

Audited both complete Windows ownership logs and all available Linux/Mac target
logs in `/private/tmp/fwp-170-targets`. The only reported failure is this path in
`arc_tasks`. Both Linux jobs, regular ARM Mac, both Mac GC jobs and benchmarks
passed. The compiler proof units, all four Linux/Mac task-cleanup checks and
actual Linux WebAssembly checks pass at the original head. Intel Mac regular
and the remaining Windows AMD64 stages are still running; audit their results
too. The full Windows ARM job has no other failed step. Full logs are retained
in `/private/tmp/fwp-170-windows-arm.log`.

Local `python3 scripts/local-guard.py cargo fmt --all -- --check` refused to run
because free disk fell below 64 GiB. No limit was changed or bypassed; verify the
repair on CI. `git diff --check` passes. No new local compiler build was attempted.

### Acyclic channel proof

Checked ARC previously rejected every channel inside another queue, even when
its payload could not refer back. The compiler now checks each channel's reachable
payload types independently. A path back to the same channel type is rejected;
acyclic nested channels and recursive immutable containers of safe channels pass.
Functions, tasks and HTTP stream handles remain excluded because their captures
can hide an owning path. No runtime checks, new syntax, weak handles, implicit
draining or collector substitution are added.

Proof tests cover nested queues, immutable recursive trees, hidden captures and
a cycle reached through an already visited sibling. Diagnostic tests retain
direct cycles and add mutually recursive channel types. This is a type-based
proof; a rejected type is not evidence that every value of that type is cyclic.

The shared native/WebAssembly task fixture now includes channel aliases, nested
list/variant messages, closed queues, undrained repeated work, failure and
cancelled sends/receives. Existing allocation ledgers and deliberately omitted
release controls remain required. Native ARC binaries are inspected for tracing
symbols and retained with their C and symbol lists when artifacts are enabled.
Lesson 23 introduces sending an inbox through a routing queue and explains both
layers of Option in the output. Live docs remove the obsolete blanket ban.

## Checks and limits

Local commands use `python3 scripts/local-guard.py`; no compiler rebuild or full
suite runs locally. The existing `target/debug/fwp` predates this change, so its
runs verify fixture syntax/semantics only, not the new acceptance proof.

- `env FWP_NO_OPT=1 target/debug/fwp run --interp tests/fixtures/task_channel_ownership.fwp`:
  pass, 0.96 seconds; output matches the explicitly written expected values.
  An initial fixture placed an effectful channel constructor in a definition;
  moving it into the callback fixed the error without implicit effect timing.
- `target/debug/fwp fmt tests/fixtures/task_channel_ownership.fwp docs/tutorials/23-ownership-scopes/main.fwp`:
  pass, 0.15 seconds.
- `env FWP_NO_OPT=1 target/debug/fwp run --interp docs/tutorials/23-ownership-scopes/main.fwp`:
  pass, 0.62 seconds; the five lines match `main.out`.
- `target/debug/fwp check /private/tmp/fwp-mutual-channel.fwp`: pass, 0.72 seconds.
  The negative fixture reaches the ownership check, rather than a syntax error.
- `cargo fmt --all`: pass, 1.42 seconds.
  A final helper rename needed one line wrap; formatter reapplied in 1.54 seconds
  and the correction was published before opening the PR.
- `python3 scripts/check-roadmap.py`: pass, 2.70 seconds (60 document sets,
  106 immutable anchors and seven work areas). `git diff --check`: pass.
- CI results and the remaining Windows repair are recorded above. Final-head
  full platform acceptance is still required.

This batch removes a compile-time rejection, not allocation or ARC operations.
It adds no runtime representation and makes no speed or C/Rust parity claim.
Shared channel handles still need reference counts; arbitrary owning cycles,
unknown captures and default tracing removal remain unfinished.

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

All seven work areas in [PLAN.md](../PLAN.md) remain open. JIT is excluded.
After this batch, select the next ownership/performance gap from representative
programs; persistent subscriptions and weak handles remain design work, not
implemented APIs. Keep one current handoff and preserve completed evidence in
history.
