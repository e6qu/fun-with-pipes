# Session handoff

Updated 2026-10-16. This worktree `/private/tmp/fwp-ad-allocation-sites`, branch
`profile-ad-allocations`, now prepares numeric mapped-array construction. The
allocation diagnostic through `cfdf4d79` has been bundled into the process batch;
only changes after that anchor belong to this following compiler delivery. No
second PR is open. Earlier parent changes must not be replayed.

PR #148 merged as `853d6669` after all nine production jobs and docs passed
for `93b1741a`; tree and one-line message were verified. Duplicate post-merge
production `38835480889` was canceled. The only active PR is now draft
[#149](https://github.com/e6qu/fun-with-pipes/pull/149), root branch
`owned-process-delivery`, at initial head `17696b4`. It contains the process,
terminal and derivative reports. Root's handoff is the current delivery record.

The following process/terminal batch is published at `ad53a46a` in
`/private/tmp/fwp-process-utilities`, branch `owned-process-utilities`. Its
handoff is authoritative. All six hosts passed process/signal/terminal/CLI
checks at `6e122959`; the only failure was the tty ownership contract, fixed at
`8926a2fb`. Combined [rerun 38833152028](https://github.com/e6qu/fun-with-pipes/actions/runs/38833152028)
is queued/running. Later additions only bundle measurements/docs. Transfer its
diff after `81d113aa` onto #148's accepted squash before opening that next PR.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs and docs pass for the exact final head. Commits have one subject
line of at most 80 characters and no body, trailers or attribution. Keep one PR
active, then continue. JIT is excluded. Failing tests are repair tasks.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion; none of the seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept record/application ownership, then process and terminal boundaries |
| 2 | In progress | Attribute remaining derivative temporary allocations before optimizing |
| 3 | In progress | Compare native instructions and confirm layout timing effects |
| 4 | In progress | Profile derivative allocations and repeat promising layout comparisons |
| 5 | Pending | Broaden CPU kernels; resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Preserve equivalent-work profiles, raw samples and regression criteria |
| 7 | In progress | Accept maintained application, process and terminal checks |

Next: finish draft #149 and its combined final-head gate.
In parallel, validate this numeric map-to-array candidate on six hosts and run
four-host repeated comparisons. Fix failures before selecting it for the later
PR. Transfer only changes after `cfdf4d79` onto accepted process main; no second
PR should be opened while the current delivery is still active.

## Why profile allocations

The repeated 512-VJP workload makes 25,184,777 managed allocation requests and
10,492,416 retains. Paired tape storage itself makes only 7,681 requests without
reuse or 16 with reuse. Final charged memory is zero, but the temporary objects
still cost work. The report and actual ARM64/AMD64 instructions are retained in
`docs/measurements/ad-metadata-repeat-2026-10-16.json`.

The interleaved tape experiment passes correctness and allocation checks on all
four hosts in [38829628017](https://github.com/e6qu/fun-with-pipes/actions/runs/38829628017)
at `aff0e087`. Sustained timings improve on ARM macOS but are mixed elsewhere;
production tape layout remains unchanged. Repeat promising timings before adoption,
and preserve source/failure semantics if a candidate is selected.

## Diagnostic design and current checks

`scripts/measure-ad-allocation-sites.py` compares the existing aggregate allocation
instrumentation with two deliberately non-inlined allocation entries that record
native return addresses. The diagnostic uses an explicit 1024-site table, adds no
profiling heap storage, excludes constant initialization, and requires identical
managed/tape counts and peak/final memory in both variants. It records no timing
claim. Return addresses are normalized against `fwp_main_thread`, then resolved
through native symbols and debug locations to C functions and generated language
signatures. Unknown debug locations fail the measurement instead of being hidden.

The four-host `ad-sites` suite measures identity, mapped, sustained and nested
reverse derivatives. Raw interpretation supplies expected outputs; native ARC
with workspace reuse enabled supplies profiles. Source, binary hashes, compile
commands, hardware/compiler details and raw symbol locations are retained.

Local checks use `python3 scripts/local-guard.py COMMAND...`. Script parsing
passes (0.13 s). A tiny two-element derivative built with the accepted #147
compiler resolves 25 native sites covering 43 requests; totals and peak/final
memory match the existing instrumentation (1.82 s). This is a focused mechanism
check, not a full benchmark or changed-compiler acceptance. Full compiler builds
and workload profiles run only on GitHub. The local script/output are under
`/private/tmp/fwp-ad-site-check*`. All four hosts pass in run `38832271631` at `507ec27`. The retained report
`docs/measurements/ad-allocation-sites-2026-10-16.json` verifies all source/binary
hashes and aggregate counts (guarded retention check: 0.13 s). The benchmark
guide explains the observed costs. Bundle this diagnostic and report into the
process delivery before opening its PR; it needs no separate acceptance cycle.

## Selected next optimization

The profile attributes 41.65% of requests to mapped list nodes. Prepare direct
construction for `map f | array.from-list` when the output is an inline numeric
type. Preserve callback/input evaluation order, complete callbacks before packing
the array, and retain existing behavior for boxed or managed element types. This
is an internal compiler transformation, with no new surface primitive or syntax.
The callback and input remain borrowed; numeric scratch and the result have
explicit owners. This initial scope avoids changing boxed-value cleanup timing.

Acceptance must compare raw/optimized interpretation and native tracing/ARC at
O1/O2, including aliasing inputs, effects, checked failures, empty lists, numeric
widths and negative cleanup controls. CI must measure allocations and repeated
timings against the same compiler with this transformation disabled, including
the derivative workload. Do not infer speed from allocation reduction. The candidate is now implemented but unaccepted. `FWP_MAP_ARRAY=0` disables
only this transformation for controlled comparisons; `FWP_ARRAY_FUSION=0` also
disables it with the other array transformations. New regressions compare raw
and optimized engines, effects/traps, managed-result exclusion, counts and
callback-failure cleanup. The initial local probe accidentally requested a
collection in ARC mode; its fixture now uses the actual `FWP_ARC_ONLY` guard.
Edited-C mechanism checks pass in ARC and tracing (1.17 s each), including a
missing-free negative control. Formatting passes. These use the accepted #147
compiler plus current helper C, not the changed compiler. Full acceptance and
performance evidence remain on CI. The next focused suite is `mapped-arrays`.

The new Rust test harness compiles against the existing library after correcting
a mutable Command borrow. Old queued `38834469846` is confirmed canceled.
[Candidate run 38834524334](https://github.com/e6qu/fun-with-pipes/actions/runs/38834524334)
at `3ad4f223` reached compiler checks but stopped on the test's new Clippy
`chunks_exact_to_as_chunks` lint. The test now uses fixed-size chunks and asserts
the full expected count length. Cancel that superseded run and replace it at the
repair. Final-array allocation failure checks are also included. Edited-C
success/callback/allocation-failure and missing-free controls pass in tracing
and ARC (1.19/1.22 s). No changed-compiler acceptance is claimed yet.

`scripts/measure-mapped-arrays.py` compares the same compiler with only
`FWP_MAP_ARRAY` off/on, in tracing and ARC, using direct numeric work, repeated
reverse derivatives and nested derivatives. It retains one warmup, eight
alternating process samples, separate allocation profiles, peak/final memory,
compiler/hardware/flags, compilation time, binary size and actual disassembly.
Timed scope includes process startup and output; this is fwp versus fwp, not
C/Rust parity. Script parsing passes (0.14 s); no local timing claim is made.
The runner suite is `mapped-array-costs`. Four-host run `38834969974` is queued/running at `d16592be`; the later
Clippy repair changes tests/docs only. Results remain pending.

The first cost comparison passes ARM Linux/macOS: direct numeric requests fall
from 532,996 to 8,708 and the repeated derivative requests from 25,184,777 to
23,087,625. Direct ARC time ratios are 0.788/0.868 and derivative ARC ratios
0.966/0.950 respectively. Nested timings are mixed; retain all four-host results
when complete. No general speed claim or full acceptance follows from two hosts.
The old candidate lost known callback direct calls during fusion. The current
revision preserves them as inline generated loops using the existing typed
callback ownership entry, and adds real dynamic/captured callback cases. Unknown
callbacks retain ordinary dynamic calls. Final semantics and timing must rerun
for this change. Formatting passes; raw callback fixtures pass under the guard.
