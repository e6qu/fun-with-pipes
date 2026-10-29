# Startup repairs and CPU algorithm comparisons

**Next:** validate and measure the exact decimal-threshold tree on both qualified
CPU hosts, retaining the original grouped-division baseline and frozen limits.
Bundle the result with startup fixes, phase diagnostics and all rejected results
in one PR; run the nine production gates plus docs after the batch is ready.

PR #224 is merged as `52e8da582644a93d996816d344894fdf5435a92f`.
All nine production jobs `40790143419` and docs `40790141513` passed and were
audited at `b4e004d5788f2b2479b085a7dc6a48c435cce477`. Merge tree
`baca4d6d34a96828c49c3200ba942ef3375754e2` equals that tested tree. Verified
subject: `Test scalar boundaries and retain rejected CPU experiments`, empty
body, no trailers. Duplicate postmerge production `40801397077` was cancelled.

Current worktree: `/private/tmp/fwp-cpu-phases`, branch `cpu-execution-costs`.
Rebased onto #224's squash with identical tree before new edits; no active PR.
Original measured history is remotely retained by immutable tag
`roadmap/revision-decimal-count-df80c15e`. Do not relabel old measurements with
rebased source IDs. Startup and phase evidence below remains applicable.

## Source findings and current repair

Startup review found ignored POSIX attribute/stack configuration results and a
silent switch to the process stack on thread-creation failure. Signal-stack and
handler installation could also fail without stopping startup. Static numerical
worker attributes had the same unchecked results. These are source error-handling
findings, not a diagnosis of the historical Intel compiler abort.

Prepared changes:
- Main-thread attribute initialization and stack configuration must succeed;
  created attributes are destroyed, thread-creation failure traps explicitly,
  and failed join/destroy operations abort instead of returning an unverified result.
- Stack-overflow handler registration must succeed, matching the Windows rule.
- Static worker setup stops on attribute failure, destroys valid attributes and
  joins previously started workers before the existing numerical-worker trap.
- `stack` adds dynamic/static O0/O2 fault controls for attribute setup, stack
  configuration, thread creation, alternate signal stack, mask and both handlers.
  Before-thread failures verify attribute cleanup and no language output.
- `cpu_kernel_ownership` adds static partial-worker startup controls at O0/O2,
  checking joins, attributes and temporary storage. An omitted stack-error check
  must fail the control without using an invalid pthread object. Test output is
  static storage so worker writes survive setjmp recovery correctly.

Guarded Rustfmt passes using the repository's **edition 2021** and
`skip_children=true`. An initial edition-2024 invocation caused unrelated formatting;
all of that churn was restored before applying the correct settings. Final guarded Actionlint and the 172-link-set documentation audit also pass.
Startup checkpoint `3db10b5a9f1e22d1bc1d93c6faea055f484f90ad` passed focused
run `40792244152` on native Linux/macOS ARM64/AMD64. All four logs are audited:
each has two passing targets and 11 tests, with no compiler diagnostics. Each
artifact has seven native images, 32 main startup outcomes and three partial-worker
or deliberately omitted-check outcomes, independently verified without local
execution. This is focused evidence, not the final production matrix.

Diagnostic source `c92fed4208a16627f0f420f58ce1f7729bf0f061` completed ARM64
job `123191020317` in `40795538429` and AMD64 job `123191404460` in `40795656380`.
The first run rejected AMD64 EPYC 9V45 before timing; its host record is retained.
All job logs and artifacts pass independent audits. Every raw sample, original
peer/memory report and artifact identity is saved in `docs/measurements/cpu-phases-*.json`.
The permanent verifier reconstructs both results; six reader/instrumentation
control groups pass. Actionlint and 173 documentation link sets passed before
publication. Both small Rust diagnostic peers compiled locally without execution.

Calculation dominates the diagnostic intervals, but fwp loop instrumentation
changes elapsed time by +19.84% ARM64/+12.24% AMD64. AMD64 loop's identical-code
p95 control exceeds the frozen limit; retain it as inconclusive. Both text controls
pass, AMD64 narrowly. No speedup is accepted from this experiment. The report
states exact inputs, intervals, code/stack/storage costs and all limitations.

## Decimal experiment and current implementation

Table candidate `df80c15ee894c437df0f0216db211abefc27115c` is rejected overall.
ARM64 run `40800093045`, job `123205860349`, qualifies with 19.28% less text time.
AMD64 run `40800624780`, job `123207612147`, does not: text median is 10.45%
slower and both noise controls exceed frozen limits. Preserve those as
inconclusive AMD64 decisions, not a reliable regression estimate or an accepted
speedup. Earlier AMD64 jobs in `40800093045` and `40800351080` rejected Xeon 8370C
before building/timing. No timing retry or budget reset is justified.

Both qualified logs pass audit (two targets/eight tests). Independent artifact
audits verify every sample, seven paired programs, 21 ordinary images, 14 storage
images, actual table bytes and 16 semantic/control images per host. Complete raw
reports and artifact identities are in `docs/measurements/decimal-count-*.json`;
`scripts/check-decimal-records.py` reconstructs the original decisions. Retain
initial reader failure `40799193551`: it used nonexistent `text`, corrected to
actual `strings` before paired timing. All partial records remain archived.

The next candidate replaces bit-width estimation and its table with exact
balanced decimal comparisons. It uses at most five comparisons, no division or
indexed table, and unchanged unsigned magnitude for signed minima. Tests retain
all runtime-input boundaries at O0/O1/O2/O3; the emitted-helper snprintf oracle
must catch an intentionally omitted one/two-digit comparison. Source inspection
checks the full set of 19 thresholds; native execution checks branch wiring.
The comparison runner keeps the original grouped-division helper, inputs, sample
counts, compiler flags, output checks and fixed limits. No speedup is claimed.

## Latest focused checks

Guarded five Python control groups, eight small Clang O0/O1/O2/O3 helper/control
cases, Rustfmt and Actionlint pass. The retained decimal-record verifier passes.
An initial documentation audit caught the missing required status table during
handoff cleanup; restored it before publication. No local fwp build or benchmark.
GCC/native emission and the full production matrix remain runner work.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain named A1–A6 guarantees |
| 3 | Verified | Maintain scoped F1–F3 call and recursion guarantees |
| 4 | In progress | Verify decimal comparisons and startup repairs |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed baselines beyond the CPU cases |
| 8 | Pending | Larger-program correctness, cleanup and scale |

## Recovery

G1–G5, named A1–A6 and F1–F3 are verified, not universal zero-cost guarantees.
P2/P3 remain open; next come D1–D3 differentiation, N1–N2 kernels, broader B1/B2
baselines and V1–V2 applications. PLAN.md owns the concrete acceptance criteria.
The historical Intel compiler abort is still unexplained; startup error handling
is not its diagnosis. Preserve source/input evidence on recurrence.

Raw artifacts/logs: `/private/tmp/fwp-decimal-{arm,amd}`, two rejected-host
folders, phase/startup folders and `/private/tmp/fwp-224-final-*.log`.
The primary checkout stays detached at #209 with a recovery pointer and untracked
compiler-abort evidence; preserve both. No local full builds/suites/benchmarks.
Use the guard for serial focused checks with 64 GiB free disk, 2 GiB target,
1 GiB RSS and 180 seconds. Final-head gates still required before merging.
