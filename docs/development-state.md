# Current work

**Next:** monitor the final-head matrix on [PR #236](https://github.com/e6qu/fun-with-pipes/pull/236/checks).
Audit every completed target and compiler diagnostic; fix any failure. Require
nine production jobs plus documentation on the exact final head before
squash-merging. Focused passes do not replace those gates.

All ten steps in [PLAN.md](../PLAN.md), publication and merge are authorized.
Worktree `/private/tmp/fwp-returned-callables`, branch `language-design-review`,
base `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`. Preserve unrelated changes in the
primary checkout. Keep one active PR. Commit messages must be one line, at most
80 characters, with an empty body and no attribution or trailers.

## Verified source and pending matrix

Compiler source `d339f8a701df6b48d32b3ea864690e53843bd3d2` is verified below.
`bbce38e10c299446cdcfad6c6b067fc6037e350e` changes tests, workflow and handoff only:

| Run | Checks | Result |
|---|---|---|
| `41268079378` at `bbce38e1` | Linux ARM64/AMD64 and macOS ARM64: all 11 REPL tests, CLI, local bindings, call cleanup, both fold controls/unwind, iterator/vector behavior, returned-function costs and iteration allocation probes | All three jobs pass; all logs audited |
| `41267001566` | Linux and Intel macOS: 234 unit tests, all-target Clippy, analysis scaling and raw server startup | Both pass; all logs audited; limits unchanged |
| `41268066813` at `bbce38e1` | Documentation and retained evidence readers | Pass; log audited |

Production run `41265952785` at `bed8b365` exposed a saved-function REPL failure
in both Windows native socket/library steps; every target in those artifacts is
audited, and only `saved_lexical_closures_keep_their_code_and_captures` fails.
Constant-function optimization promoted a saved result to an argument-taking
entry, violating the session's zero-argument evaluation contract. The repair
marks saved entries in IR, preserves the marker during session linking and
excludes them from stage promotion. IR validation checks that contract; the
constructor unit test covers saved and ordinary entries with constant/computed
captures. Focused lexical probes now include the complete REPL target.
The repair passes all three focused platform jobs above. The benchmark and
documentation jobs pass at `bed8b365`. Its completed macOS ARM64 regular job
has only the same REPL failure; all 131 target logs and final steps are audited.
Remaining production jobs continue and must be audited. That superseded matrix
cannot verify the repair.

Windows AMD64's later callback step exposed an ineffective right-fold test
control. Its C-text injection still targeted `z`, while the generic runtime now
stores the result in `owner.value`. The old source-change assertion could pass
merely because joining lines removed a trailing newline. The repair targets the
actual accumulator and requires exactly one matching callback statement. The
left-fold control gets the same exact-match check. Both still require a real
retained-owner leak, zero live storage in the ordinary program and the original
release margin. No runtime behavior or threshold changes. The repaired fold and
unwind tests pass on all three focused hosts. Both Windows resource/callback
artifacts have been audited and contain only these known failures.
The completed macOS ARM64 ownership job has the same sole right-fold failure;
all 128 test summaries and compiler diagnostics were audited.

The full matrix must test the exact repaired PR head. Local checks use
`python3 scripts/local-guard.py`; formatting, workflow syntax and documentation
checks pass. No full compiler build, suite or benchmark ran locally.

The superseded production run `41261060185` at `20109cf0` is completely audited.
Its only failures were CLI stdin, iterator callback scope, vector fusion and the
`iter.each` allocation probe, all repaired and verified in the focused checks.
Logs/artifacts are under `/private/tmp/fwp-236-*`; do not treat an artifact named
`compiler-crashes-*` as a crash without an actual crash report.

## Repairs included

Function construction runs before later argument evaluation. Generic primitive
results and trait aliases preserve that rule. Pure constructors combine stages
only after a bounded proof excludes computations, traps and observable resources.
Small literal F64 splats preserve exact bits and obey the existing size budget.

CLI, REST, MCP, gRPC and C libraries use the complete public argument type;
internal construction stages remain intact. Tests cover stdin, metadata,
served calls, C exports and retained C callbacks at O1/O2. Lifetime analysis
keeps finite outer construction-site identities so unrelated returned callbacks
do not mix. Removing a State handler still rejects its callback.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Implemented | Final-head local-name, pattern, type and strict-evaluation checks on all supported hosts |
| 2 | Implemented | Final tooling, macro, tutorial and documentation gates |
| 3 | Implemented | Final protocol, constructor and known-call cost checks |
| 4 | Implemented | Final alias/failure controls and zero/one-retain String loops |
| 5 | Implemented | Final direct scalar record/variant cost checks |
| 6 | Implemented | Final collection fusion and effect/trap-order checks |
| 7 | Implemented | Final numerical cost/cleanup controls; timing acceptance remains open |
| 8 | Implemented | Final gradient-list/phase controls; original D2 speed goal remains open |
| 9 | Verified | Numerical/Swift records audited and retained; individual Swift ARC counts unmeasured |
| 10 | Pending | Application families, nine production jobs and documentation on the integrated head |

The [application matrix](application-acceptance.md) defines the final coverage.
After a verified squash merge, update the next batch rather than declaring the
broader roadmap complete.

## Measurements and limits to preserve

[Numeric array traversal](measurements/array-list-traversal.md) retains all six
cases, frozen limits, raw observations and failed results. At `f7f5309c`, eight
129-coordinate solves remove 208,552 requests and 6,622,720 requested bytes;
retains and peak managed storage do not change. Run `41258782085` passes all
correctness/allocation/cleanup limits. AMD64 session 2 fails identical-copy
variation (2.1023% versus 2%); the combined timing result remains inconclusive.
Retention/audit `41260368842` passes. Final gradient-list conversion is outside
the six runtime phase clocks, so these savings are not forward-recording gains.

Earlier `dc0a6407` allocation failures, the `9a2e954e` final-order repair and
`9d47a5fc` timing rejection remain in that report and immutable source archives.
A later pass does not erase them. Source tags are
`roadmap/array-lists-{first,repaired,pure-constructors}-2026-11-01` and
`roadmap/swift-allocations-2026-11-01`. Historical readers use their recorded
source adapters. Do not compare old generated C with today's adapter.

[Swift allocation profiles](measurements/swift-allocations.md) pass both hosts
at `9d47a5fc` (`41256208614`, audit `41257220044`). fwp's directly mapped managed
heap is outside heaptrack: report its requests/live storage separately from
native allocator traffic. Do not add independent peaks or invent ARC-operation
counts. [Swift timings](measurements/swift-peers.md) retain four separate sessions.

GC removal and scoped ARC reductions remain maintained guarantees. Baseline
#235's tree `9eda0ac6113d18741d9b0f85c1dcadbba409b2ac` matches verified head
`adeb9794544cd12deae3f7050fef79cf874a3f55`; production `41229416050` and docs
`41229416071` pass. Broader ARC minimization, D2 derivative speed and N1/N2 kernel
timing remain open. The [callable study](measurements/callable-phases.md) retains
Xeon construction regressions of 8.6–16.1%; another CPU does not settle them.
The [Intel compiler abort](measurements/compiler-abort.md) has no established
root cause. Diagnose a recurrence from its input/source path; do not resume
speculative disassembly-led allocator changes.
