# Current work

**Next:** monitor the final-head matrix on [PR #236](https://github.com/e6qu/fun-with-pipes/pull/236/checks).
Audit every completed target and compiler diagnostic; fix any failure. Require
nine production jobs plus documentation on the exact final head before
squash-merging. Focused passes do not replace those gates.

All ten steps in [PLAN.md](../PLAN.md), publication and merge are authorized.
Worktree `/private/tmp/fwp-returned-callables`, branch `language-design-review`,
base `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`. Preserve the primary checkout.
Keep one active PR. Commit messages: one line, at most 80 characters, empty body,
no attribution or trailers.

## Verified repairs and pending integration

Compiler source is `d339f8a701df6b48d32b3ea864690e53843bd3d2`.
Subsequent changes through `2de5980b3d9b8a919d5d92c14220813dc91b78c5` affect
only tests, workflows and documentation. These checks pass; all logs are audited:

| Run and source | Coverage |
|---|---|
| `41268079378`, `bbce38e1` | Linux ARM64/AMD64 and macOS ARM64: CLI, local bindings, all 11 REPL tests, call cleanup, fold controls/unwind, iterator/vector behavior, returned-callable costs and iteration allocations |
| `41267001566`, `d339f8a7` | Linux and Intel macOS: 234 unit tests, all-target lint, analysis scaling and raw server startup; limits unchanged |
| `41271608106`, `2de5980b` | Both Linux hosts: actual WASI fixed-capture execution with stack promotion off/on, each at O1/O2; C, source and WASM retained |
| `41271600167`, `2de5980b` | Documentation, source copies and retained evidence readers |

The superseded matrix `41268735692` at `786f90b0` passes benchmarks and both
macOS ARM64 jobs; documentation `41268726225` passes. Those logs are audited.
Both Windows hosts pass the former REPL step and ARM64 also passes the fold
step. Other jobs continue and need complete audits. This matrix lacks the WASI
test repair, so it cannot establish final acceptance.

Both earlier complete matrices (`41261060185` at `20109cf0`, `41265952785` at
`bed8b365`) are fully audited. CLI stdin, iterator callback scope, vector fusion
and the iteration allocation probe were repaired and verified. The later repairs:

| Failure | Repair and verification |
|---|---|
| Saved REPL functions gained arguments during optimization | Explicit cached-value IR marker preserves zero-argument entries through optimization and session linking; IR validation and all REPL tests pass |
| Right-fold leak control injected an extra owner into an obsolete variable | Target the actual accumulator; both fold controls require exactly one source match, an observed leak in the broken control and zero live storage in ordinary code; original release margin retained |
| WASI fixture demanded static captures with stack promotion enabled | Supply both storage settings; require static objects and initialization with promotion off, and unchanged program output in both settings at O1/O2 |

Local checks use `python3 scripts/local-guard.py`: formatting, workflow syntax
and documentation pass. No full build, suite or benchmark ran locally. A bounded
emission check used the passed `786f90b0` package:
`python3 scripts/local-guard.py env FWP_STACK=0
/private/tmp/fwp-236-786-mac-package/fwp-macos-arm64/fwp build --target wasm32-wasi
--emit-c tests/run/static_functions.fwp -o /private/tmp/fwp-236-static-stack0.c`,
then the same command with `FWP_STACK=1` and `stack1.c`. These produced three and
zero static captured-function objects respectively. Actual WASI execution is
verified by the runner checks above. Logs/artifacts are `/private/tmp/fwp-236-*`;
an artifact named `compiler-crashes-*` is not itself evidence of a crash.

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
