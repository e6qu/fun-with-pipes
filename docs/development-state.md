# Current work

**Next:** publish and run the paired [direct string-result comparison](measurements/direct-string-results.md), while watching PR #228's final gates. Keep one active PR. Its final head remains `f3eb5072`; do not push preparation work to it.

Preparation is on `direct-string-results` in `/private/tmp/fwp-direct-string-results`.
Protocol `e0fb1a09` precedes runtime/test source `089465bb`. `replace` counts
non-overlapping matches and fills its final String; `string.repeat` fills its
checked final size. Both avoid temporary libc buffers. They preserve input aliases,
managed allocation/ownership contracts and the distinct terminal OOM versus
String-size failure rules. No application speed claim is accepted.

## Checks and measurements in progress

PR #228 production `41018509811`: benchmarks, macOS ARM regular (626 tests/132
summaries) and ARM ownership (364/127) pass with full audits. Six native jobs
remain running without reported failed steps. Documentation `41018509711` and
both G2 hosts `41018512169` pass; G2 has 226 tests/three summaries each.

Focused string run `41021988225` passes all six native hosts at `089465bb`.
Every host passes 18 integration tests/seven summaries; GCC AMD64 additionally
passes 224 library tests and 20 native-runner controls. Complete logs are audited,
including intentional missing-compiler/runner failures. Independent audit checks
all 954 saved subprocess outputs/statuses and 162 native image headers/hashes.
Artifacts are in `/private/tmp/fwp-direct-focused-089465bb`; the audit is
`/private/tmp/fwp-direct-focused-audit.json`. WASI run `41023744074` is queued on
both Linux architectures and remains required.

The paired runner restores exactly two frozen runtime bodies in generated C,
without an older compiler. It records separate candidate/reference and C/Rust
comparisons, independent raw/managed profiles, all subprocess streams, native
images, sections and stack reports. Its checker recomputes all 18,510 observations
per complete session, including failed timing decisions; corrupted-evidence tests
must also pass. Four qualified host sessions remain required. Keep the existing
limits and retain failed/inconclusive sessions; never retry unchanged timings.

Guarded checks: six allocation/acceptance tests pass with small Clang O2 probes;
144 size/control exits pass at Clang O0/O1/O2; Rust formatting, Python syntax and
workflow lint pass. These local checks do not establish GCC or WASI coverage.
Full builds, measurements and final production checks remain on GitHub.

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

## Current word-frequency baseline

Protocol `6d4df06b` precedes measured source
`dc963bb500748dabe393dfaed20f92a333f5996e`. All four sessions are complete and
audited: ARM jobs `123799636907`/`123799637188` in `40974666332`; AMD job
`123801495592` in `40975221824` and `123804111260` in `40976014339`.
The [report](measurements/wordfreq-current.md) records all 37,080 child
observations, complete logs, native headers/hashes, code/stack costs and memory.
Three earlier AMD host rejections occurred before building/timing and remain
in the archive. No measured session was retried.

Large-input fwp/C is 2.49 on ARM64 and 3.03–3.04 on AMD64. All sessions report
225,937 managed allocations, 69,642 retains and zero final managed charge for
65,536 words. Identical-copy variation reaches 3.90% on the short input and
0.38% on the large input. The report declares separate future-candidate limits;
no candidate is implemented or accepted, and D2/N1 limits remain unchanged.

`check-current-wordfreq.py` independently checks all outputs, the fixed schedule,
statistics, files and native identities. Seven evidence tests reject damaged
observations, including internally consistent changed hashes. They run in the
measurement workflow after recording and in documentation CI against the saved
archive. Guarded `test-current-wordfreq-evidence.py --retained-index` passes all
four sessions (28 tests). `actionlint` passes both modified workflows;
`check-roadmap.py` passes 182 link sets, 106 preparation pairs and eight steps;
`git diff --check` passes. No local full
build or benchmark ran. The compressed evidence reconstructs every retained
text and binary byte exactly; ordinary documentation CI rechecks all four sessions.

## Previous delivery and unresolved timing

The user merged [PR #227](https://github.com/e6qu/fun-with-pipes/pull/227) as
`0e114aa5`, with the exact tested tree from `8e291876`. All nine production jobs,
documentation and both G2 hosts passed and were fully audited; the compact
[delivery record](roadmap-history.md#eager-captures-and-typed-numerical-loops-pr-227)
owns the identities and counts. Its message satisfies the one-line rule.

D2's zero-update recheck is **1.022815765 > 1.02** in `40912773534`; N1's
small-array inclusive copy control is **1.030786192 > 1.02** in `40951090783`.
The [timing report](measurements/timing-variation.md) retains these observations
and all diagnostics. The cause remains unresolved. The user merge settles the
delivery choice, not these performance requirements. Do not discard failures,
relax their limits or repeat unchanged measurements until they pass.

## Resume and delivery rules

[PLAN.md](../PLAN.md) owns acceptance; [history](roadmap-history.md) owns completed
deliveries. User-merged #227 is `0e114aa5`, matching verified tree `830e41b3`.
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
| 8 | In progress | Integrate directory failure coverage and current word-frequency budgets; finish remaining V1/V2 rows |
