# Current work

**Next:** run the repaired directory-failure checks on all six native hosts,
then audit every result. Finish the remaining Intel macOS audit from
[the first run](https://github.com/e6qu/fun-with-pipes/actions/runs/40965474997) too. Source `55eec5e0` is on
`application-allocation-failures` in `/private/tmp/fwp-application-failures`.
This is preparation for the next grouped PR; only PR #227 is active.

## Directory-report failure checks

The new test adds four allocation boundaries: initial scratch storage, a
partially collected name list, scratch growth and result-list construction.
At C O1/O2, recoverable traps must release owners and directory handles, preserve
a caller's path alias and permit a successful retry. Deliberately omitted close
and builder cleanup must fail their respective observers.

A separate subprocess invokes the real managed-heap OOM handler at each boundary:
its contract is diagnostic plus exit 102, not recovery or pre-exit cleanup.
The tests do not exhaust host memory. See [application acceptance](application-acceptance.md#repeated-directory-and-file-work).
Native verification is pending. Local guarded rustfmt, roadmap and whitespace
checks pass; no local full build or benchmark ran.

Focused run `40965474997` uses all six native hosts, production compilers and
O1 Rust harnesses. Linux ARM64/AMD64, both Windows hosts and ARM macOS failed only the new test: its harness searched
for a function entry after ordinary main compilation could inline/remove it.
All nine other tests pass on those hosts; complete logs are audited. Intel macOS is still finishing. The repair compiles the probe entry with
explicit `--fn report-once`, keeps a separate ordinary build for result
comparison and retains both emitted sources. Failed test logs will be uploaded
before the admission inventory. Guarded formatting and workflow lint pass;
The repair has no native result yet; preserve the failed first-run logs. Artifacts retain the generated C, every native probe and
its output/status under `failures/record-ownership/directory-allocation`.
Independent artifact auditor: `/private/tmp/fwp-audit-directory-failures.py`.

## Active delivery: PR #227

[PR #227](https://github.com/e6qu/fun-with-pipes/pull/227) stays frozen at
`8e29187617eaa84fd29a2f6a55d954d28d385266` on `ad-eager-captures`, worktree
`/private/tmp/fwp-ad-captures`. Preserve its head while gates run.

- Production `40962967746`: benchmark correctness and both macOS ARM64 jobs
  pass with full audits (626 regular tests/132 summaries, 363 ownership tests/127
  summaries). Six platform jobs are running without reported failed steps.
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
The pending question about retaining the derivative improvement with its failed
goal open has no answer. Do not merge solely because correctness CI passes.

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
