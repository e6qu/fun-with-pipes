# Continue PR #227: derivative costs and numerical kernels

**Next:** run and audit the [declared resource-counter diagnostic](measurements/timing-variation.md#resource-counter-diagnostic-declared-before-implementation)
for the retained failed array/history programs. Record child CPU time, faults
and context switches without changing their binaries or acceptance rules. The
[typed-state experiment](measurements/timing-variation.md#typed-state-results)
passes focused correctness checks on three hosts and removes the two accumulator
bit conversions from both GCC reports. No speedup has been measured.

Active worktree `/private/tmp/fwp-ad-captures`, branch `ad-eager-captures`.
[PR #227](https://github.com/e6qu/fun-with-pipes/pull/227) is draft and groups D2,
its record-return repair and N1. Typed state passes focused bit-pattern, mixed-owner and failure checks;
full-platform and timing acceptance remain open.
[PLAN.md](../PLAN.md) owns acceptance; [history](roadmap-history.md) owns completed
deliveries. User-merged #226 is `cdf881067d`, tree identical to verified `02e4ee21`;
all nine jobs, documentation and both G2 hosts were audited before proceeding.

## Implemented compiler repair

`694e31b7` repairs a C-generator defect exposed by eager captures. An authorized
REST DELETE returning `RestReply[()]` crashed: one match arm read a boxed local
after its value had been split into fields. Both interpreters passed; exact
production Clang O1 reproduced the fault. Every arm now emits the fields required
by its caller. Regressions cover authorization outcomes, dynamic/direct records,
aliases and repeated exceptional cleanup. REST tests retain server exit/stderr.
The stale collection-evidence count is also repaired (seven tests, not six).

Focused `40909968650` at `694e31b7` passes 333 tests/22 summaries per Linux
ARM64/AMD64 and ARM macOS host, plus lint and raw interpreter corpus. Full logs
and documentation `40909967190` are audited. The older production run at
`56528ffb` is fully audited: only the two REST cases failed on regular Linux/macOS;
Windows, ownership jobs, benchmark and both old G2 hosts passed. No disassembly
was used to diagnose the defect. Reproducer/source/logs: `/private/tmp/fwp-227-*`.

## Measurements: what passes and what remains open

[Eager-capture results](measurements/eager-captures.md) retain four initially
passing sessions (13–72% less elapsed time in updated solves, largest case still
44–58 times handwritten C). The repaired-source recheck at `694e31b7` is fully
audited: three sessions pass, AMD session 1 (`40912773534`) fails zero-update
history at **1.022815765 > 1.02**. All emitted C matches the earlier version.
Profiles and the inspected zero-update entry/loop show no added operations;
that is not proof of equal machine cost. Every original/recheck outcome remains.
The user has been asked whether to retain the broader improvement with that
failed goal open; no answer has arrived, so preserve the original requirement.

The [timing diagnostic](measurements/timing-variation.md), declared at `cbd9fd7c`,
ran at `535031b3` in `40949475361`. All 1,089 processes are independently audited.
CPU pinning did not fix matrix variation; all 2,560 observed data offsets were
`(8,8,8)` modulo 64 KiB. EPYC 9V45 rejection `40949274713` is archived. These
observations do not establish the cause or count as acceptance measurements.

[Kernel sampling](measurements/kernel-baselines.md) increased only the small
matrix to 256 processes per label per round, declared at `3870a1bf` before
implementation `37da7441`. Run `40951090783` completed all four qualified sessions:

| Session | Job | Result |
|---|---|---|
| ARM64 1 | `123719104529` | Pass |
| ARM64 2 | `123719104149` | Pass |
| AMD64 1 | `123719104558` | Pass |
| AMD64 2 | `123719104625` | Small-array allocation-inclusive noise **1.030786192 > 1.02** |

All matrix and computation-only array controls pass. Overall N1 remains
inconclusive. Independent audits cover 144 ELF images, 96 frame reports, 77,968
commands and all outputs/cleanup/observations. The compressed archive retains
156,716 file identities and complete logs. Auditors are
`/private/tmp/fwp-audit-kernels-expanded.py` and its `-failure.py` counterpart;
the latter requires the exact failed metric rather than accepting it. No
measurement job remains running. Initial/repaired/sampling failures remain in
their original archives; no failed session was retried unchanged.

## Production CI and publication

Run `40947897224` at `cbd9fd7c` began while the PR was ready. Keep its remaining
jobs and audit every full log. Already passed and audited: both macOS regular
jobs (625 tests/132 summaries each), both macOS ownership jobs (363/127 each),
benchmark (2/2), both Windows jobs (809/202 each) and Linux ARM64 (991/257).
Linux AMD64 remains running without reported failed steps. Documentation
`40959037712` at `80edb379` and `40958169641` at `2678a1b0` pass with complete logs
audited, including the intentional test-runner failure and invalid-selection controls.
These do not establish final-head coverage for later changes.

Keep the PR draft during focused work. After complete evidence, require all nine
production jobs, documentation and both G2 hosts for the final commit, with full
log audits. Then squash-merge using one explicit subject <=80 characters and an
empty body; no trailers or attribution. Continue the roadmap after verified merge.

## Typed-state focused evidence

Run `40959086200` at `80edb379` passes all three jobs: Linux AMD64
`123746823560`, ARM64 `123746823951`, macOS ARM64 `123746824079`. Each passes
253 tests/14 summaries, all-target lint and raw interpreter corpus; full logs
are audited. All 36 new program/bit/precision-loss probe binaries and outputs
are independently audited. Both array sizes match exact results and free all
storage; both GCC reports keep the accumulator as a double across iterations.
[The archive](measurements/typed-loop-state-artifacts-2026-10-29.json) retains
957 file identities, sources, compiler reports, probe results and complete logs.
This is a correctness/representation result, not timing or final-head coverage.
Auditors: `/private/tmp/fwp-audit-typed-state.py` and
`/private/tmp/fwp-audit-production-log.py`.

## Local checks and retained state

Guarded, serial checks pass: two real-child/resource-counter controls, seven scheduling/oracle controls, seven archive
controls (including the retained array failure), three diagnostic controls,
workflow lint and roadmap links. Typed-state edits are Rust-formatted;
their Rust compilation and native checks run on GitHub, not locally. No local full build, suite or benchmark ran.
Full workloads remain on GitHub; guard limits are unchanged.

Incidental cleanup removes stale GC-root/finalization comments and an unused
former root local. The application table now links current evidence. Final
native validation still covers the resulting source.

The primary checkout stays detached at #209 with a recovery handoff and untracked
`docs/measurements/compiler-abort.md`; preserve both. The original intermittent
Intel compiler abort is unexplained. The older ARM crash artifact was an
intentional negative control, not a recurrence. Obsolete-worktree handoff backups
are in `/private/tmp/fwp-obsolete-checkout-handoffs`; lossless compression hashes
are in `/private/tmp/fwp-compressed-artifacts.jsonl`. Preserve all retained evidence.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call and recursion scope |
| 4 | Verified | Preserve delivered decimal cost reduction and recorded loop gap |
| 5 | In progress | Resolve D2's zero-update timing requirement |
| 6 | In progress | Resolve N1's inclusive array control; investigate computation cost |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 integrated application validation |

Documentation runs at `fc037501` and `553fb24f` failed because the handoff rewrite
omitted this required status table. Both complete logs show that same defect.
The table is restored and the next audit passes; keep the existing audit contract.
