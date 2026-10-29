# Current work

**Next:** run and audit all four sessions of the [current word-frequency baseline](measurements/wordfreq-current.md),
implemented after declaration `6d4df06b`. This prepares
V1/B1's next budget; it does not resolve D2/N1 or authorize a speed claim.

The directory-failure batch passes [all six focused native hosts](https://github.com/e6qu/fun-with-pipes/actions/runs/40967686175)
at `1f364c09ae9d4fe43405fdc66c46849cc4aae6d5`; its compact archive and report are
published in `5556353c`. Worktree `/private/tmp/fwp-application-failures`, branch
`application-allocation-failures`. Only PR #227 is active.

## Directory-report failure checks

The new test adds four allocation boundaries: initial scratch storage, a
partially collected name list, scratch growth and result-list construction.
At C O1/O2, recoverable traps must release owners and directory handles, preserve
a caller's path alias and permit a successful retry. Deliberately omitted close
and builder cleanup must fail their respective observers.

A separate subprocess invokes the real managed-heap OOM handler at each boundary:
its contract is diagnostic plus exit 102, not recovery or pre-exit cleanup.
The tests do not exhaust host memory. See [application acceptance](application-acceptance.md#repeated-directory-and-file-work).
All six hosts pass ten focused tests each; complete logs and all 84 saved
probe executions are independently audited. The [report](measurements/directory-failures.md)
links the retained archive. Full production coverage is still required when
this preparation is integrated. Local guarded checks pass; no local full build
or benchmark ran.

The first run, `40965474997` at `55eec5e0`, is fully audited on all six native
hosts. Each failed only the new test: the harness searched for a function entry
after ordinary main compilation could inline/remove it. All nine other tests
pass per host; there are no unrelated diagnostics.

Repair `1f364c09` compiles the probe entry explicitly with `--fn report-once`,
keeps a separate ordinary build for result comparison and retains both emitted
sources. Failed-test logs now upload before the admission inventory. Formatting,
workflow lint, roadmap and whitespace checks pass under the local guard.
The repaired native run passes on all six hosts; the archive retains both runs.

Artifacts retain generated C, native probes and each output/status under
`failures/record-ownership/directory-allocation`. Independent auditors:
`/private/tmp/fwp-audit-directory-failure-logs.py` checks the exact old failure;
`/private/tmp/fwp-audit-directory-failures.py` checks the new artifacts.

## Active delivery: PR #227

[PR #227](https://github.com/e6qu/fun-with-pipes/pull/227) stays frozen at
`8e29187617eaa84fd29a2f6a55d954d28d385266` on `ad-eager-captures`, worktree
`/private/tmp/fwp-ad-captures`. Preserve its head while gates run.

- Production `40962967746`: all nine jobs pass with complete log audits. Linux
  has 992 tests/257 summaries per host; regular macOS 626/132; ownership macOS
  363/127; Windows 810/202; benchmark 2/2.
- Documentation `40962940196` passes; its complete log is audited.
- Both G2 jobs in `40962971405` pass with full audits: 226 tests/3 summaries each.
- Typed-state focused run `40959086200` passes on GCC ARM64/AMD64 and Clang
  ARM64: 253 tests/14 summaries per host. Exact bits, mixed owners, cleanup and
  deliberately corrupted precision are checked. This is not measured speed.
- Older production `40947897224` passes all nine jobs, fully audited. It does
  not replace final-head coverage.

Two performance requirements remain open. D2's zero-update recheck is
**1.022815765 > 1.02** in `40912773534`; N1's small-array inclusive copy control is
**1.030786192 > 1.02** in `40951090783`. Preserve all observations and limits.
The delivery choice was presented again after all CI passed: retain the new
closure improvements with D2/N1 timing goals open, or keep the PR open until
the original timing requirements are resolved. No answer has arrived. Do not merge solely because correctness CI passes.

The [timing report](measurements/timing-variation.md) links the retained reports,
source identities, rejected hosts and diagnostics. Resource-counter run
`40961695545` retains all 512 child-process observations. Identical reference
copies also differ in CPU time; the cause remains unresolved. No diagnostic or
unchanged acceptance experiment is running. Do not discard failures or repeat
unchanged measurements until they pass.

## Resume and delivery rules

[PLAN.md](../PLAN.md) owns acceptance; [history](roadmap-history.md) owns completed
deliveries. User-merged #226 is `cdf881067d`, matching verified tree `02e4ee21`.
The original Intel compiler abort remains unexplained; retain its
[report](measurements/compiler-abort.md) and diagnose any recurrence from source.

The primary checkout stays detached at #209 with a recovery handoff and an
untracked compiler-abort report; preserve both. Full builds/suites/measurements
belong on GitHub. Local checks remain serial and resource-guarded. All nine
exact-head production jobs, documentation and G2 require full audits before
merge. Use one squash subject of at most 80 characters and an empty body.

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
