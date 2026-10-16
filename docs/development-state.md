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
only changes after `81d113aa` from preparation `owned-process-utilities` at
`ad53a46a`, including verified derivative reports/profiling through `cfdf4d79`.
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

Next: finish draft #149 by evaluating the numeric mapped-array candidate
below. Include that optimization only after semantic/cleanup/profile evidence
supports adoption, then run all nine production jobs and docs for the final head.
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

## Numeric mapped-array candidate

Worktree `/private/tmp/fwp-ad-allocation-sites`, branch `profile-ad-allocations`,
is now anchored at `cfdf4d79`; only later changes belong to this candidate.
The earlier profiler/report are already in this delivery. Current published
candidate is `da56521c`. It constructs arrays directly from mapped inline numbers,
retaining callback order, borrowed inputs and scratch cleanup. Boxed or managed
results keep their existing path. Known callbacks keep direct calls, including
captured values; unknown callbacks use the ordinary dynamic call path. No new
surface syntax is added.

[Six-host tests 38836047263](https://github.com/e6qu/fun-with-pipes/actions/runs/38836047263)
and [four-host comparison 38836050029](https://github.com/e6qu/fun-with-pipes/actions/runs/38836050029)
are queued/running at that revision. Earlier missing Command-borrow and Clippy
fixture errors are repaired; superseded `38834469846` and `38834524334` are
confirmed canceled. Pre-direct-call tests `38835108890` continue for comparison.
The standalone Rust harness compiles, raw dynamic/captured callback cases pass
(0.38 s), and edited-C success/callback/final-allocation failures plus missing-free
controls pass in tracing/ARC (1.19/1.22 s). Changed-compiler acceptance is pending.

The earlier [four-host comparison 38834969974](https://github.com/e6qu/fun-with-pipes/actions/runs/38834969974)
at `d16592be` passes ARM Linux/macOS so far. Direct numeric requests fall from
532,996 to 8,708; repeated derivative requests fall from 25,184,777 to 23,087,625.
Direct ARC time ratios are 0.788/0.868 and derivative ARC ratios 0.966/0.950,
respectively. Nested timings are mixed. Retain every host/sample when complete;
this is fwp versus fwp, not C/Rust parity or a general speed claim. The latest
revision must repeat timings because it now preserves known direct callbacks.

Do not silently adopt a slower or incorrect candidate. Inspect costs and preserve
known direct callback calls when eliminating intermediates. If supported by
focused evidence before the delivery's final gate, bundle it here to avoid an
extra full CI cycle. Otherwise keep the preparation separate and continue fixes.
