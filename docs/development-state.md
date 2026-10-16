# Session handoff

Updated 2026-10-16. [PR #149](https://github.com/e6qu/fun-with-pipes/pull/149)
merged as `58ed740cc785382b0cd818d4af970a1fa49516e6` after all nine production jobs in
[38841142126](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126) and
[docs 38841118993](https://github.com/e6qu/fun-with-pipes/actions/runs/38841118993)
passed for `5748f7496a8f1db0e93145c53e380a0703affc2f`. Tree equality, parent and the
one-line subject with empty body were verified. Duplicate post-merge production
`38851195546` was requested canceled; its final status is checked separately. [History](roadmap-history.md) records the
delivery and remaining limits.

Current delivery branch: `owned-list-text-delivery` in the root worktree, based
on accepted `58ed740c`. It transfers only preparation changes after `1850f832`
through `83f62bb7`, preserving #149's final mapped-array CPU report and explanation.
The preparation worktree `/private/tmp/fwp-zip-map` retains its original branch;
never replay its parent commits. The only open delivery is [PR #150](https://github.com/e6qu/fun-with-pipes/pull/150).

Standing authorization covers fixes, publication and squash merge after all nine
production jobs plus documentation pass for the exact final head. Commit messages
are one line, at most 80 characters, with an empty body and no attribution or
trailers. JIT is excluded. Local checks use `python3 scripts/local-guard.py`;
full builds, gates and benchmarks run on GitHub. Do not raise resource limits.

## Next action and unresolved results

Next: require all nine production jobs plus docs for #150's exact final combined
head, fix any failures, then squash merge with an explicit one-line subject and
empty body. Verify the merge tree/message and continue. Focused acceptance below
does not replace the final gate. Queued CI stops merging, not independent work.

[Windows repair run 38850334050](https://github.com/e6qu/fun-with-pipes/actions/runs/38850334050)
passes on both native Windows architectures at `ed015878`. Combined list checks
in `38847420495` pass on all four Unix hosts and both actual WASI count jobs.
Windows first exposed CRLF assertions in older probes, then a cancellation crash.
[Diagnostic 38849794851](https://github.com/e6qu/fun-with-pipes/actions/runs/38849794851)
confirmed the synthetic canceled task lacked its Windows stack scan boundary.
The repair supplies that boundary in zip/map/selection/fold probes, following the
established loop fixture. Fold also gets binary stdout and joins full Windows
coverage. These fixture repairs now pass; no earlier failing run is acceptance.
The combined delivery's source/runtime/tests/workflows match that passing repair.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion. None of its seven whole areas is done.

| Step | Status | Progress and remaining direction |
|---|---|---|
| 1 | In progress | Validate text/list cleanup, then remaining deployment boundaries and less counting |
| 2 | In progress | Accept zip elimination; measure more closure, state and collection costs |
| 3 | In progress | Retain instruction evidence; address C/Rust gaps, layout and cache behavior |
| 4 | In progress | Accept fewer intermediates; address tape/workspace costs and memory scaling |
| 5 | Pending | Broaden kernels; resolve runtime OpenCL compilation |
| 6 | In progress | Keep repeated timings, equivalent work and physical storage checks |
| 7 | In progress | Accept todo/grep ARC coverage, then larger and long-running applications |

## Changes and acceptance criteria

Numeric `zip | map` combines corresponding input elements and immediately applies
a known function. For inline numeric inputs, the candidate passes the two values
directly to that function, removing temporary pairs and list nodes. Preserve
input evaluation order, shorter-list truncation, callback effects/traps and
aliases. Managed inputs keep their existing lifetimes. Earlier fold/array
optimizations run first so this change cannot reintroduce their removed output
lists. `FWP_ZIP_MAP=0` disables only this transformation for comparison.

Zip, unzip, repeat, chunks, scan and iterate now protect pending references,
temporary buffers and partial results across failures. Retain and callback order
stay unchanged. A positive I64 chunk size no longer wraps to zero on 32-bit WASI;
4,294,967,296 produces one chunk for a three-element list.

Text reads have a fresh-string ownership contract; replacement writes borrow
their inputs. Existing protected runtime implementations are reused. Source
comments and generated docs explain that `file.write-new` creates or truncates.
Maintained todo/grep functions run 64 times with retained results; real CLI checks
cover file arguments, stdin, Unicode, replacement, subcommands and exit status.

Acceptance compares raw/optimized interpretation with native O1/O2 tracing/ARC,
retained aliases and scalar bits that resemble addresses. Probes force retain,
callback and allocation failures, including wide-counter overflow, collect during
construction and deliberately omit individual cleanup actions. Missing cleanup
must fail; lower allocation counts alone do not establish correctness or speed.

## Retained evidence

| Check | Result |
|---|---|
| Numeric zip/map, six native hosts | [38842838108](https://github.com/e6qu/fun-with-pipes/actions/runs/38842838108), passed at `91146d68` |
| Text files and maintained programs, six hosts | [38845110123](https://github.com/e6qu/fun-with-pipes/actions/runs/38845110123), passed at `0bae98f7` |
| Expanded list cleanup and actual WASI counts | [38847420495](https://github.com/e6qu/fun-with-pipes/actions/runs/38847420495), Unix/WASI passed; Windows fixture repairs pass in `38850334050` |
| Four-host zip costs | [38842840316](https://github.com/e6qu/fun-with-pipes/actions/runs/38842840316), all passed |
| Independent verified-binary repeat | [38846124783](https://github.com/e6qu/fun-with-pipes/actions/runs/38846124783), all passed |

[Allocation/timing evidence](measurements/zip-maps-2026-10-16.json) compares the
same fwp compiler with only zip elimination changed. Repeated derivative requests
fall from 23,087,625 to 18,892,809 and retains from 10,492,416 to 8,395,264; peak
memory stays 840,888 bytes. The direct loop contains ARM64 vector multiply and
AMD64 unrolled scalar multiply. These are not total instruction/spill counts or
C/Rust parity claims.

[The independent repeat](measurements/zip-map-cpu-2026-10-16.json) preserves sixteen
alternating elapsed/child-CPU samples, source/binary hashes, hardware and flags.
Substantial direct/derivative CPU times improve on all four hosts. Tiny macOS
ARM64 nested ARC remains 1.017 CPU / 1.027 elapsed, with overlapping samples;
no universal speedup is claimed. Normal traced direct work collects twice in both
variants on every host; other profiles collect zero times. Final storage is zero.
[Benchmarks](benchmarks.md) explains the inputs, timing scope and limitations.

Guarded local probes supplement these runner checks. Edited-C controls reproduce
old zip/unzip/list leaks, pass the repairs and reject omitted cleanup at O1/O2 in
both modes. The latest standalone zip harness compiles (0.26 s) and its two Mac
tests pass (8.93 s). Formatting passes (1.11 s); docs pass (2.52 s). No full compiler
build was run locally. The accepted #148 Mac compiler is at
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`; its verified package revision
is `93b1741a`. [The earlier preparation record](https://github.com/e6qu/fun-with-pipes/blob/ed015878/docs/development-state.md)
preserves detailed probe commands, original failures and superseded runs.

## Following independent preparation

`/private/tmp/fwp-wasi-arc`, branch `checked-wasi-ownership`, is anchored at
`e5e05748`; transfer only later changes after this zip/list/text batch is accepted.
It prepares synchronous WASI ARC with physical-free controls, function/CLI entry
checks and actual module inspection. Browser re-entry and host fibers remain
unproved. Its handoff records the active run and failures. It has no PR and does
not yet establish supported WASI ARC.

After transfer, formatting passes (1.02 s), docs pass (2.53 s), and primitive
inventory passes (1.11 s): 261 contracts, six scalar signatures, 19 templates and
82 remaining review symbols. Source/runtime/tests/workflows match preparation
`83f62bb7`; the transferred benchmark guide retains #149's final CPU investigation.
