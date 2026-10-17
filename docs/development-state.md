# Session handoff

Updated 2026-10-17 UTC. All seven areas in [PLAN.md](../PLAN.md) remain open.
Current branch: **checked-remote-arc**. [PR #161](https://github.com/e6qu/fun-with-pipes/pull/161)
is the one active delivery. It combines checked gRPC ARC, reply/error cleanup,
unique record-field transfers, bounded native test groups and documentation cleanup.
Preparation branches are evidence sources, not competing next actions.

## Next action

Next: publish the library-input regression repair and require all nine production
jobs plus documentation on the new final head. Production **39038709892** failed
at **35953062** in the same `library_input_ownership` assertion on both Linux and
both regular macOS jobs. Both Windows jobs, both macOS GC jobs and benchmarks
passed; documentation **39038693710** passed. Watcher **73627** stopped on failure;
no merge occurred. Replace its pinned head/run IDs after publishing the repair.
Use `Compile remote calls with ARC and move unique record fields` as the squash
subject, with an empty body; verify parent/tree/message and cancel duplicate
postmerge production CI only after acceptance.

Standing policy: very early pre-alpha; backward compatibility is not required,
including existing binaries. Layouts, calling conventions, APIs and formats may
change; rebuild consumers with the matching compiler. [AGENTS.md](../AGENTS.md)
records this, the memory/language goals and validation rules in 81 lines, with
an explicit under-100-line limit. JIT remains excluded.

## Accepted baseline

PR #160 is accepted as **8ae595dffb006753597c39ca739e620aef8d3b94**. All nine
production jobs **39030633846** and docs **39030633906** passed at
**a8fa519d6befc34655d4b9298883ca1c5c69c3b8**. Parent #159, tree and message match;
`/private/tmp/fwp160-merge-record.json` retains verification. Complete message:
`Free server call storage and borrow values in fold callbacks`.
Duplicate postmerge **39036532034** is confirmed cancelled. Watcher 75491 exited
successfully. [History](roadmap-history.md) preserves acceptance and the repaired
long-running memory regression. The plan/ownership/design guides now reflect it.

## Verified focused evidence for #161

All **18 native jobs pass** in **39037037021**, source
**efaab358e730595f40aa5d46e6df6a8ec0151a5c**, immutable tag
`evidence/remote-arc-platform-fixes-20261017`. Subsequent compiler/runtime code is unchanged. Documentation, retained
measurements and the library-input test repair below follow this source.
The suite runs server cleanup, client cleanup and real calls/measurements as
three independent jobs per host, retaining every prior check and the 25-minute
limit. All six native platforms pass O1/O2 interpreter comparisons, typed scope
proofs, partial failure/cancellation and deliberate missing-owner controls.
Tracing-free binaries are checked explicitly, not inferred from collection-off runs.

The strict collector passes (25.32s) with `--comparison server-arc-moves
--split-checks`, against the accepted server-borrows report. Retained report:
[remote-arc-field-moves-2026-10-17.json](measurements/remote-arc-field-moves-2026-10-17.json),
plus 18 raw tables. Every host has **36 memory rows**, 216 total. The four identical
server workloads use 1/16/256 calls, three repetitions and 64-element streams.
Every request/connection finalizes. Allocations, requested bytes, peak managed
storage and final managed storage match baseline. Final storage stays at 544 bytes
on Linux and zero on macOS/Windows. Greetings use 2 retains per call instead of 3;
returned/received streams and output-channel calls remain 66/132/4. Both versions
also have one retain per connection. These are fwp comparisons, not timing or
C/Rust-parity claims; raw buffers, stack pools and OS/TLS costs are excluded.

The separate 32,000-call ARC resident-memory test passes its unchanged 8 MiB
bound. Five samples are [16084, 16084, 16084, 16084, 16084] KiB on AMD64 and
[8144, 8144, 8144, 8144, 8144] on ARM64. Actual Linux instructions transfer unique
record fields, retain shared ones and preserve typed cleanup. Greeting frames
are 184/192 bytes; channel fold frames are 264/320 on AMD64/ARM64. Text grows
by 7,686/8,430 bytes over tracing baseline; ARC contract checks and uniqueness
checks still cost code. ARM64 file growth includes 64 KiB segment padding.
[Benchmarks](benchmarks.md#remote-services-without-tracing-and-with-fewer-field-retains)
explains scope and costs. Downloaded binaries were inspected, never executed.

Artifacts, job logs and instruction reviews:
`/private/tmp/fwp-server-memory-evidence/39037037021`.
The collector enforces matching source/programs, all 18 successful jobs and actual
ARM64/AMD64 reviews. The intermediate ARC-only Linux binary comparison is pinned
by source/fingerprint and explicitly does not claim its incomplete six-host run
passed. `/private/tmp/fwp-review-arc-moves.py` reproduces the static review checks.

## Repairs retained in this delivery

- Iterator scope proofs follow later steps. Detached senders cannot inherit a
  caller's State/AD handler; returned service iterators cannot use expired local
  handlers. Valid producers with their own handlers remain accepted.
- Remote entries borrow arguments; decoded replies and caught status errors own
  their values through final status/delivery, failure and cancellation. Queue
  delivery gets an independent owner; the ARC escape guard remains unchanged.
- Unique plain-data records transfer fields at worker entry. Shared fields and
  partially prepared arguments remain protected; resource lifetimes are preserved.
- ARM Mac exposed a test driver counting failed nonblocking accepts as accepted
  connections. It now forces a readiness retry, verifies the old assumption fails,
  and reports distinct recovery conditions. All native controls pass.
- Windows probes used text stdout in replacement C mains. They now select binary
  stdout like generated programs. All three worker/control targets also run in
  the regular Windows gate. No ownership assertion was weakened.

The earlier unsplit runs exceeded the Intel Mac job budget or exposed those
fixture issues. Superseded runs **39035855561** and **39036291837** are confirmed
cancelled. Preparation history is saved at `/private/tmp/fwp161-preparation-handoff.md`;
the published body is `/private/tmp/fwp-remote-arc-pr.md`. Old preparation worktrees
remain available, but root is the integrated delivery and owns the live handoff.

## Full CI regression repair

The library-input probe expected two destructor calls for each field copied from
a C record: a worker duplicate and the original boxed owner. Unique record fields
now move, so each string has only one owner to release. The corrected check
requires exactly one release for each copied string, still checks released
records/strings and raw pointer/scalar preservation, and retains all partial
failure controls. A new control forces the old duplicate path and must fail the
count check. Focused server/field suites and regular Windows CI now include this
library-input test so preparation runs cover the affected C-library boundary.
Compiler/runtime code and the retained six-host measurement source are unchanged.
Failure logs: `/private/tmp/fwp161-production-failures.log`.
Local `python3 scripts/local-guard.py cargo test --test library_input_ownership`
passes both tests (38.25s including build), with O1/O2, poison on/off and all five
negative controls. Guarded `cargo fmt --check` and `actionlint
.github/workflows/numerics.yml .github/workflows/windows.yml` pass.

## Local validation

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, suites,
benchmarks and large regeneration run on GitHub. Preserve 64 GiB free disk,
2 GiB maximum target data, 1 GiB sampled workload RSS and the 180s deadline.
Stop rather than raising limits. Formatting, actionlint and static binary checks
pass. Final `python3 scripts/local-guard.py python3 scripts/check-roadmap.py`
passes (3.00s): 52 documentation link sets, 106 immutable preparation pairs,
seven current roadmap rows and commit subjects. The handoff heading was restored
to match the audit after streamlining; no check was weakened.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Accept checked remote ARC; remaining host boundaries/cycles; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps and measured code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

Browser/HTTP host entry, REST/MCP and asynchronous WASI remain outside checked
ARC. Choose the next ownership/optimization batch from the remaining contracts
and measurements. A completed delivery does not complete these work areas.
