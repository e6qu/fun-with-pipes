# Session handoff

Updated 2026-10-17 UTC. All seven areas in [PLAN.md](../PLAN.md) remain open.
Standing policy: very early pre-alpha; no backward compatibility requirement,
including existing binaries. Layouts, calling conventions, APIs and formats may
change. Rebuild consumers and update current tests/docs; do not add machinery
solely for old code. [AGENTS.md](../AGENTS.md) preserves this across sessions.
Current delivery branch: **checked-remote-arc**, based on accepted PR #160.
The root now combines checked remote ARC, typed reply/error cleanup, unique record
field transfers, bounded native CI groups and documentation cleanup. [PR #161](https://github.com/e6qu/fun-with-pipes/pull/161) is a draft; immutable
native validation uses **efaab358**. Full production waits for the final report
commit. AGENTS.md is streamlined to 78 lines and records the no-compatibility
policy; the plan/reference/handoff agree. Documentation audit passes (3.06s). Preparation branches are evidence sources, not separate next actions.

## Next action

Next: validate the platform-fixture repairs at tag
`evidence/remote-arc-platform-fixes-20261017`, inspect actual ARM64/AMD64 binaries,
and collect
all six hosts with `--comparison server-arc-moves --split-checks` against
`docs/measurements/server-borrows-2026-10-17.json`. Fix failures; require all 18
focused jobs. Retain the report and explain measured costs before marking the
combined draft PR ready. Run all nine production gates plus docs on the final head before
squash merge. Every commit message is one line, at most 80 characters, with an
empty body and no trailers or attribution.

## Accepted baseline

PR #160 is accepted as **8ae595dffb006753597c39ca739e620aef8d3b94**. All nine
production jobs **39030633846** and docs **39030633906** passed at
**a8fa519d6befc34655d4b9298883ca1c5c69c3b8**. Parent #159, tree and message were
verified; `/private/tmp/fwp160-merge-record.json` retains the checks. Complete
message: `Free server call storage and borrow values in fold callbacks`.
Duplicate postmerge **39036532034** is confirmed cancelled. Watcher 75491 exited
successfully. [History](roadmap-history.md) preserves the repair and acceptance.

The baseline's four repeated server workloads use 1/16/256 calls, three repeats
and 64-element streams. Every request/connection finalizes; remaining managed
storage is constant at 544 bytes on Linux and zero on macOS/Windows. Retains per
call are 3/66/132/4 plus one per connection. Allocation/count/managed-storage
measurements exclude raw buffers, stack pools, OS/TLS, allocator metadata,
whole-process RSS and elapsed time. The separate long-running RSS regression also
passes. Actual binary costs are in the report and benchmark guide.

## Implementation and evidence

ARC preparation worktree: `/private/tmp/fwp-prove-remote-arc`, branch
`prove-remote-arc`, source **947981ff**. It derives from #160 head a8fa519d.
The implementation admits checked gRPC clients/services, proves when iterator
continuations run, borrows remote arguments, protects decoded replies until final
status/delivery, and releases caught error records/messages. Data-only channel
cycle restrictions remain; HTTP/REST/MCP/browser boundaries remain open.

The first prototype correctly failed the unchanged ARC escape guard because
remote entries converted borrowed counted arguments to tracing-managed storage.
The repair removes that conversion, not the guard. Scope tests cover later
continuations, detached senders and returned iterators with expired local handlers.
Real calls compare interpreter/ARC clients and servers at O1/O2. Deliberately
omitted reply cleanup, queue owners and error owners must fail.

Linux probe **39033267465** passes at **c5952f14**. Its 32,000-call RSS samples
are **[16084, 16084, 16084, 16084, 16084] KiB**. All 36 memory rows match baseline
allocations, requested bytes and retains, with constant final storage. Its strict
collector passed (1.48s), report `/private/tmp/fwp-remote-arc-linux-report.json`.
All-six run **39034262363**, source **e796ea63ef28162367f9bf4a29d94ea1eab5528d**,
tag `evidence/remote-arc-six-hosts-20261017`, has five passing hosts; Intel Mac hit the unchanged 25-minute job limit
during real-call tests. The run is cancelled, not accepted as six-host evidence. Runtime/compiler are unchanged from c5952f14. Artifacts are under
`/private/tmp/fwp-server-memory-evidence/39034262363`; both Linux reviews exist.
Preserve those partial results, but use the replacement combined run below for
final evidence. Do not infer six-platform support from the Linux-only probe.

Actual ARC binaries exclude scan/mark/sweep routines. AMD64 fold frame is 264
instead of 280 bytes; ARM64 is 320 instead of 336. Reader frames are unchanged.
Text grows **261813 -> 269131** bytes on AMD64 and **246445 -> 254547** on ARM64:
legacy function entries inline ownership-contract checks. ARM64 file growth also
includes 64 KiB segment alignment padding; the actual ELF load segments and
explanation are retained in its binary review. Keep these costs explicit; there
is no measured speed benefit. Downloaded binaries were inspected, never executed.

Worker-field preparation: `/private/tmp/fwp-move-worker-record-inputs`, branch
`move-worker-record-inputs`, derives from ARC source 947981ff. Compiler/test source
**97ee3dc5056df1cba16d1c5bfb89bb18f68fd040**, tag
`evidence/worker-record-moves-20261017`; later docs commit **6971bc86**. The measured
greeting entry duplicated a record field before its direct worker call. The change
snapshots fields, transfers counted fields from unique plain-data records and
retains shared fields. It protects partial transfers and keeps the original box
alive through the call. Resource-containing records preserve existing lifetimes.

Focused Linux **39035085462 passes**: preparation failures, entry cancellation,
shared parent/field aliases, scalar bits, result boxing, liveness and field/resource
regressions. The unsplit six-native run **39035855561** is superseded and confirmed
cancelled. First split run **39036291837** used source
**273d516b64342356c82dbe48b65da7dee2c7f45d**, tag
`evidence/remote-arc-moves-split-20261017`. It splits server cleanup, client cleanup
and real-call measurements into three native jobs per host, retaining every
previous test command and the 25-minute limit. Worker ownership tests are added
to the measurement jobs. The collector requires all 18 jobs with `--split-checks`
and compares with server-borrows using `--comparison server-arc-moves`. Expected
saving is one retain per greeting and no allocation or final-storage change;
Both Linux hosts verify all 36 memory rows against these expectations. Final
all-host evidence remains pending the replacement run. Do not describe these
36 memory rows as 108; three tables record different measurements. Workflow actionlint passes
(1.10s); command preservation/collector syntax check passes (0.13s). Inspect actual binaries and compare every row;
require matching work, no extra allocations and bounded remaining storage before
including the change. All nine final PR gates still need this compiler revision.

The split run exposed two fixture problems. ARM Mac server checks exited 237 at
`grpc_server_connections` stage 7; log `/private/tmp/fwp-arc-moves-mac-failure.log`.
The driver counted unsuccessful nonblocking accepts as a connection. It now counts
successful accepts, forces a readiness retry, and verifies that restoring the old
assumption fails. Recovery diagnostics distinguish the other causes of code 237;
this repair still needs native confirmation in replacement **39037037021**
at **efaab358e730595f40aa5d46e6df6a8ec0151a5c**. Windows AMD64 worker controls passed
their ownership checks but failed exact output because their replacement C mains
left stdout in text mode. All seven such probes now select binary stdout like
ordinary generated programs; the three target suites are added to the normal
Windows gate. Log `/private/tmp/fwp-arc-moves-windows-failure.log`.
Superseded run **39036291837** is confirmed cancelled. Its two Linux measurement
jobs pass, with artifacts under `/private/tmp/fwp-server-memory-evidence/39036291837`.
They are partial evidence only. The replacement run must pass every platform.
Formatting passes (1.24s), workflow actionlint (1.22s); these do not verify the
native repairs. Compiler/runtime code remains identical to 273d516b.

The published PR body is `/private/tmp/fwp-remote-arc-pr.md`; update its validation
before marking the PR ready. The root already includes the combined code and documentation. It
also records #160 acceptance and removes obsolete candidate/exclusion statements. Historical experiment
notes are saved in `/private/tmp/fwp160-handoff-before-streamlining.md`.

## Local checks and limits

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, suites,
benchmarks and large regeneration run on GitHub. Preserve 64 GiB free disk, target
data below 2 GiB and sampled aggregate workload RSS below 1 GiB; deadline 180s.
Stop rather than raising limits. The fun-refactor guard is for another repository.

Formatting, collector syntax and bounded static binary inspection pass. New
worker documentation audit passes in 2.72s; the streamlined root handoff audit
passes in 2.93s after restoring the required `Next:` marker. These do not replace native CI.
Every commit is one line, at most 80 characters, with no body/trailers/attribution.
Squash merge only after all nine production jobs and docs pass at the exact head.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Checked remote ARC, remaining host boundaries and cycles; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

Complete GC removal remains open. JIT is excluded. Choose optimizations from
measurements and preserve simple pipes, inference, effects and failure order.
