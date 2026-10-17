# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Delivery sequence

PR #158 is accepted at `a96871c9` after all nine production jobs and docs.
Root input delivery [PR #159](https://github.com/e6qu/fun-with-pipes/pull/159)
is open at `91398527`: production `39016595534`, docs `39016595480` pending.
Do not create a competing PR or alter its final-gate head without a repair.

Input preparation `9a4e2ace` passed six-host evidence at `06f3ac6f` in
`39013126818`. It bundles the six-host server baseline. Combined sampler probe
`39015439403` passes on Linux; all 36 final/categorical rows and 3,276 checkpoints
match the frozen server baseline exactly. Root delivery preserves #158's later
allocation-test repairs, which are not in this preparation's ancestry.

## Server call storage preparation

This worktree `/private/tmp/fwp-server-call-owners`, branch
`own-server-call-storage`, starts at input preparation `9a4e2ace`. It is isolated
preparation, with no PR. Transfer only its later delta after input acceptance.

The [server baseline](measurements/server-call-baseline-2026-10-17.json) is
`0643295938a432cefedb4a3d0c1f263aa9482ee2`, retained by
`evidence/server-call-baseline-20261017`; all six hosts pass `39014733093`.
Four workloads retain increasing memory after calls/tasks finish and the
connection closes. Actual Linux ARM64/AMD64 instructions show traced task/job
retention. Client memory and timing are excluded; this is not checked ARC.

The candidate targets job/task records and keeps temporary argument slots on
the serving task stack, before decoded values and response iterators. A serving context becomes the first member of its job,
so its existing peer-user count owns the whole allocation. Detached senders keep
that allocation alive; ordinary joined children borrow it. Last-owner cleanup
frees peer/status text and the job. No new allocation or reference counter.

Serving-task completion clears the request's borrowed task pointer and the
retained context's task pointer before releasing its job owner. A later failure
through a surviving context still traps, without dereferencing a freed task.
Server reader/writer and serving tasks use unique scheduler ownership when no
scope retains their identity. With a scope, scheduler and scope are two explicit
owners and use the existing counted policy. These are actual owner relationships,
not fallback implementations. Request/connection records remain tracing-owned.

Tests are being adapted to observe actual managed frees without reading freed
records. Controls cover omitted job/task disposal, premature cleanup and loss of
scope ownership. Retained sender context, status replacement, pre-publication
failure and counter overflow remain covered. Assertion failures exit immediately
so library teardown cannot mask their diagnostic with a secondary error.
The server workflow now runs all real gRPC tests plus peer/status/receive/response/
send/task ownership regressions before measuring repeated calls.

The runtime already uses stack arrays sized by a function's arity during ordinary
application. Server argument slots can use the same approach: their bound comes
from the compiled method signature, and application copies values, never the
array. Keep the zeroed slots on the serving task stack. No job field or explicit
array cleanup is needed; the slot storage ends on return, failure or cancellation.
Decoded values keep their existing ownership. Existing response regressions cover
these exit paths; repeated-call comparisons must show one fewer allocation per
call and no new count operations. Review stack use in actual ARM64/AMD64 code.
This refinement replaces the intermediate heap-array cleanup probe.

Expected result: one fewer allocation per call, released job and serving/I/O
records, unchanged retain counts, and lower retained bytes. Remaining decoded
arguments, results, incoming sources, request/connection records and channels
are outside this change; memory is not expected to be constant yet. Do not claim
server GC removal or lower execution time from a smaller memory total.

Next: retain the result of heap-slot probe `39017350539` at `d5adce34`;
stack-slot candidate `c298bdcd` passes Linux probe `39017473996`.
Its all-six run `39017837346` found an existing C-host text assertion expecting
LF on Windows ARM64, whose `puts` emits CRLF. Normalize only that fixture text.
All preceding Windows ARM64 lifetime fixtures passed. Rerun all six on the repair.
Retain the repaired source and collect
comparisons with `--baseline-report docs/measurements/server-call-baseline-2026-10-17.json`.
The collector requires one fewer allocation per call, fewer requested bytes by
the old argument-array size, unchanged retains and lower final storage.
The focused lifetime fixtures now precede ordinary networking tests so fixture
failures are reported earlier without removing coverage.
Fix failures, then measure
all six hosts and review actual ARM64/AMD64 instructions. Keep the input delivery
moving independently; publish only one delivery PR at a time.

## Next value-lifetime work after this storage probe

The baseline's generated service entry `e0` explicitly marks its argument/result
as traced. Served functions are reachable but are not marked in `used_closures`,
so their function table has no typed owning entry. Internal iterator helpers do
have one. The next change should supply typed service entries and transfer decoded
arguments into them, with cleanup for partially decoded argument lists and owned
results/errors through encoding. Preserve trap order and children joining before
response cleanup. This is investigated, not implemented or tested.

Incoming iterator nodes already have typed owners, but their server request and
connection remain traced. Output channels currently contain a separate sink
record without its own disposal hook. These must be accounted for before
claiming complete server ownership; merely switching to `fwp_apply_owned` would
leave these boundaries and response iterators unresolved. Reuse the same four
workloads and compare counter changes, not only final memory.

## Passing intermediate Linux probe

Heap-slot candidate `d5adce34` passes `39017350539`: ordinary networking, all
selected lifetime/task fixtures and repeated server measurements. All 36 Linux
AMD64 samples match the baseline minus 2,336 bytes per call and 3,584 bytes for
two I/O tasks. At 256 calls final bytes are 119,648 / 1,885,024 / 1,151,840 /
369,504 for greetings / returned streams / sent streams / channel output.
Allocation/retain counts are unchanged. Its extra job pointer requests eight
bytes per call, in the same allocation class. Stack-slot candidate `c298bdcd`
removes that pointer and the argument allocation; measure it separately.
Guarded download passed in 3.39s and comparison in 0.15s. Private artifacts:
`/private/tmp/fwp-server-memory-evidence/39017350539/server-calls-ubuntu-latest`.

## Checks and artifacts

Use `python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py` with
fixed limits. Native builds, full suites and measurement run on GitHub.
Candidate formatting passed in 1.32s and documentation audit in 3.20s;
argument-array formatting passed in 1.29s. The comparison collector requires
identical language workloads/sampling text and lower final bytes at every size;
runtime and tests are not yet verified.
Stack-slot formatting passed in 1.29s and documentation audit in 3.49s.
No local native build or downloaded executable execution occurred.
Baseline artifacts: `/private/tmp/fwp-server-memory-evidence/39014733093`.
The baseline preparation's handoff retains deeper lifetime-review notes.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Typed stream and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

Linux probes `39016150516` (`ebc1590d`) and `39016597763` (`8eab6729`) passed
ordinary networking checks but failed in fixture instrumentation. The first
renamed allocator definitions along with calls; the second assumed one definition,
but generated C contains two alternatives selected by preprocessing. Restore both
real definitions explicitly in peer and response fixtures. Neither failed run
collected server measurements. Formatting passed in 1.18s/1.29s; updated docs
passed in 3.26s and the comparison collector syntax check in 0.14s.

Probe `39016938682` at `62a63f50` passed ordinary networking and peer-lifetime
negative controls, then failed the scoped-task assertion with reuse verification
on. That mode deliberately poisons counted storage instead of physically freeing
it. Observe logical disposal separately and require physical freeing only with
poisoning off; with poisoning on, require the retained first word to be cleared.
This is a fixture correction; no runtime failure was identified by that result.

Final stack-slot Linux probe: all 36 cases remove one allocation and 24 requested
bytes per call, preserve retain counts, and retain the same lower bytes as the
heap-slot probe. Both managed argument-storage counters are zero. Download
passed in 3.52s, comparison in 0.19s, static AMD64 inspection in 0.15s.
Private artifacts: `/private/tmp/fwp-server-memory-evidence/39017473996`.
