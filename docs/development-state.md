# Session handoff

Updated 2026-10-16. [PR #148](https://github.com/e6qu/fun-with-pipes/pull/148)
merged as `853d6669dbf7dea78483376865190c218c9fece6` after all nine production
jobs in [38825629531](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531)
and [docs 38825487182](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182)
passed for `93b1741abcf5ab2a61460746c0077564e0328c0e`. Tree equality and the exact
single-line subject with empty body were verified. Duplicate post-merge production
`38835480889` was canceled; documentation `38835480750` may finish normally.
[History](roadmap-history.md) records this and the earlier accepted #147.

Current delivery branch: `owned-process-delivery` in
`/Users/zardoz/projects/fun-with-pipes`, based on accepted `853d6669`. It contains
changes after `81d113aa` from preparation `owned-process-utilities` at
`ad53a46a`, including verified derivative reports/profiling through `cfdf4d79`, plus numeric
map-to-array preparation after that anchor.
Preparation revisions are preserved under remote `roadmap/revision-process-*`
tags. No old parent preparation should be replayed. The single open delivery is draft [PR #149](https://github.com/e6qu/fun-with-pipes/pull/149).

Standing authorization: fix failures, require all nine production jobs and docs
for the exact final head, then squash merge with a supplied one-line subject of
at most 80 characters and an empty body. No trailers or attribution. Continue to
the next substantial batch without another permission request. JIT is excluded.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion; none of the seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept process and terminal ownership, then remaining deployment boundaries |
| 2 | In progress | Validate numeric mapped-array construction without temporary list nodes |
| 3 | In progress | Measure CPU effects and preserve actual native instructions |
| 4 | In progress | Reduce confirmed derivative intermediates and retain mixed layout results |
| 5 | Pending | Broaden CPU kernels; resolve runtime OpenCL compilation under no-JIT policy |
| 6 | In progress | Preserve repeated comparable measurements and regression criteria |
| 7 | In progress | Accept maintained process composition and real terminal checks |

Next: finish the numeric mapped-array timing investigation below, then run all
nine production jobs and docs for draft #149's final combined head.
Fix failures, merge only when all pass, and continue. A queued gate stops merging,
not independent development.

## Combined delivery and evidence

Process calls own argument scratch, pipe endpoints, child resources, capture
buffers, copied strings and their record. NUL arguments fail before OS calls;
read/wait errors are reported and interrupted waits retried. Failure cleanup
closes endpoints and reaps POSIX children or closes Windows handles. POSIX child
SIGPIPE behavior agrees with interpretation; parent writes preserve the host
handler, mask and already-pending signal. Calls remain synchronous: this is not
proof of cancellation/deadline responsiveness while waiting for a child.

Secret terminal input restores echo on success and traps. Windows interpretation
uses console APIs for echo and width. Tty/width observations return immediate
values with explicit contracts; public tty arguments remain I32. CLI tests use
native executable suffixes and directly connected processes. The maintained shell
normalization tool runs 64 times with retained results and final cleanup checks.

All six native hosts passed process/signal/terminal/CLI regressions in
[38831045963](https://github.com/e6qu/fun-with-pipes/actions/runs/38831045963)
at `6e122959`; its only failure was a missing tty ownership contract. The repair
and width comparison are at `8926a2fb`.
[Combined rerun 38833152028](https://github.com/e6qu/fun-with-pipes/actions/runs/38833152028)
passes on all six native hosts at `8926a2fb`. Later preparation
changes add measurement scripts/reports/docs only, without changing tested
runtime/compiler/fixtures. Final production acceptance is still required.

Four-host derivative comparisons pass in
[38828198160](https://github.com/e6qu/fun-with-pipes/actions/runs/38828198160)
(paired versus old separate allocations),
[38829628017](https://github.com/e6qu/fun-with-pipes/actions/runs/38829628017)
(interleaved operation pairs), and
[38832271631](https://github.com/e6qu/fun-with-pipes/actions/runs/38832271631)
(native allocation sites). The three 2026-10-16 reports retain raw data, hashes,
host/compiler details and actual instruction evidence where measured. Benchmark
prose explains the comparisons and limits. Production tape layout stays unchanged;
smaller code and fewer allocations did not establish a portable timing win.

Focused local checks use `python3 scripts/local-guard.py COMMAND...`. After transfer, `cargo fmt --all -- --check` passes (1.01 s), primitive
inventory passes (1.11 s), and `python3 scripts/check-roadmap.py` passes (2.78 s). Inventory: 259 contracts, six scalar
signatures, 94 review declarations, 19 templates and 84 review symbols.
Edited-C mechanism probes pass process/signal failures and negative controls,
maintained shell composition and real terminal restoration. They use the accepted
#147 compiler plus current C, so they are supplemental, not changed-compiler
acceptance. Full builds, full suites and timing runs remain on GitHub.

## Numeric mapped-array construction

The candidate source/tests from `0fff9c2e` are now transferred into this combined
PR, including Windows binary-stdout repair in the older scalar-array test. The
preparation worktree `/private/tmp/fwp-ad-allocation-sites`, branch
`profile-ad-allocations`, has anchor `cfdf4d79`; earlier parents were already in
this delivery. Do not replay them. Remote `roadmap/revision-mapped-*` tags preserve
`d16592be`, `da56521c` and `0fff9c2e` behind the measurements.

The transformation constructs arrays from mapped inline numbers without temporary
list nodes. Callback order, borrowed inputs and scratch cleanup are preserved.
Known callbacks keep direct calls, including captures; unknown functions use
ordinary dynamic calls. Boxed/managed results keep their existing path.
[Six-host tests 38836403883](https://github.com/e6qu/fun-with-pipes/actions/runs/38836403883)
pass at `0fff9c2e`, including raw/optimized/native agreement, O1/O2 tracing/ARC,
checked traps, aliases, allocation counts and deliberate cleanup omissions.
Earlier fixture failures are repaired; superseded runs are canceled.

Three four-host comparisons pass: generic callbacks in
[38834969974](https://github.com/e6qu/fun-with-pipes/actions/runs/38834969974),
preserved direct callbacks in
[38836050029](https://github.com/e6qu/fun-with-pipes/actions/runs/38836050029),
and their independent repeat in
[38837662593](https://github.com/e6qu/fun-with-pipes/actions/runs/38837662593).
[The report](measurements/mapped-arrays-2026-10-16.json) retains every sample,
verified binary/source hashes and actual ARM64/AMD64 instructions. Direct numeric
requests fall from 532,996 to 8,708; repeated derivative requests fall from
25,184,777 to 23,087,625. Retains and derivative peak memory do not change. Known
callbacks preserve vectorized doubling. These compare fwp with itself, not C/Rust.

The independent repeat's derivative ARC ratios enabled/disabled are Linux AMD64
0.919, Linux ARM64 0.919, macOS ARM64 0.909 and macOS AMD64 0.895. Intel macOS
tracing remains slower (1.019, versus 1.070 in the first run), and its tiny nested
ARC case changes from 0.966 to 1.124. Investigate before final adoption: the new
`mapped-array-repeat` suite reuses verified binaries from `38837662593`, records
16 alternating child CPU/elapsed samples and separate normal/off collector
profiles. It avoids another compiler build. Full acceptance has not started.

Guarded local checks after transfer: formatting passes (1.26 s), inventory passes
(1.12 s; the first invocation omitted its required arguments), docs pass (2.75 s).
The script parses (0.18 s). Retention verifies all twelve host reports (0.38 s).
Actual runner-emitted direct callback loops pass success, callback/final-allocation
failures, collection and missing-free controls at O1/O2 in tracing/ARC (3.65 s).
This small Mac probe supplements, rather than replaces, native CI.

The accepted #148 Mac compiler is available for small local fixture checks at
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`. Package revision `93b1741a`
and SHA-256 `9e79c06d7db07a45de341bd7769739a2eda6c58bbeeaff077cb77bbb1268fb43`
are verified. No local full compiler build was run.

After resolving the remaining timing concern, finalize the report and run all
nine production jobs plus docs for the combined final head. Merge only after all
pass, then continue measured derivative intermediates and ownership boundaries.
