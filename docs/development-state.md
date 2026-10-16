# Session handoff

Updated 2026-10-16. This is the independent allocation-profiling preparation in
`/private/tmp/fwp-ad-allocation-sites`, branch `profile-ad-allocations`, based on
`6e122959`. Only the workflow, profiling script and this handoff differ from that
anchor. No runtime or language behavior is changed; no profiling PR is open.

The only active PR is [#148](https://github.com/e6qu/fun-with-pipes/pull/148), at
`93b1741abcf5ab2a61460746c0077564e0328c0e`, in the root worktree. Its final
[production run 38825629531](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531)
has six passing jobs; both Linux jobs and Intel macOS stress remain running.
[Documentation 38825487182](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182)
passes. The previous delivery merged in #147 as `c9127d2d` after all gates passed.

The following process/terminal batch is published at `6e122959` in
`/private/tmp/fwp-process-utilities`, branch `owned-process-utilities`. Its full
handoff is authoritative for that preparation. Combined six-host validation
[38831045963](https://github.com/e6qu/fun-with-pipes/actions/runs/38831045963)
is queued/running; old queued `38830176031` is confirmed canceled. Transfer only
changes after `81d113aa` onto the accepted #148 squash before opening the next PR.

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

Next: finish and merge #148, then accept the combined process/terminal delivery.
In parallel, run this diagnostic preparation on four native hosts, inspect the
largest allocation sites and choose a concrete optimization from that evidence.
Transfer only its changes after `6e122959` onto the later accepted main; do not
replay either parent preparation or open a competing PR.

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
