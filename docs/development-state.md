# Session handoff

Updated 2026-10-16. The only delivery PR is
[#149](https://github.com/e6qu/fun-with-pipes/pull/149), at
`5748f7496a8f1db0e93145c53e380a0703affc2f`, based on accepted `853d6669`.
Its [production run](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126)
has eight successful jobs; Linux AMD64 is still running.
[Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38841118993)
passes. The root worktree owns that delivery. Do not open a second PR.

This worktree, `/private/tmp/fwp-zip-map`, branch `fuse-numeric-zip-maps`, prepares
the following substantial delivery. Its anchor is `1850f832`; transfer only
changes after that anchor once #149 merges. Preserve #149's later mapped-array
CPU report and explanation when combining documentation. Do not replay parent
preparation commits. Current source/fixture repair: `ed015878`.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs plus documentation pass for the exact final head. Commit messages
are one line, at most 80 characters, with an empty body and no attribution or
trailers. JIT is excluded. Local checks use `python3 scripts/local-guard.py`;
full builds, gates and benchmarks run on GitHub. Do not raise resource limits.

## Next action and unresolved results

Next: finish [Windows repair run 38850334050](https://github.com/e6qu/fun-with-pipes/actions/runs/38850334050)
at `ed015878`. Earlier combined tests pass all four Unix hosts and both actual
WASI count jobs. Windows initially exposed CRLF output assertions in older C
probes. The binary-stdout repair passes those assertions but exposes a later zip
cancellation access violation. [Diagnostic run 38849794851](https://github.com/e6qu/fun-with-pipes/actions/runs/38849794851)
at `523a6e07` confirms it occurs in the synthetic cancellation case after ordinary
callback and allocation-failure cases pass.

The repair gives synthetic zip/map/selection/fold tasks the correct Windows stack
scan boundary, following the established loop fixture. Fold also gets binary
stdout and joins Windows coverage. These are fixture repairs, not changes to
runtime behavior. Native runner acceptance is pending; do not claim the crash is
resolved yet. All newly added runtime cleanup tests already pass on both Windows
hosts. Failing or canceled runs never count as acceptance.

Monitor #149 concurrently. Once its last job passes, verify the exact head, all
nine successes and docs, squash merge with an explicit subject and empty body,
verify the merge tree/message, then prepare this batch's one combined PR. Require
its own final production gate. Queued CI stops merging, not independent work.

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
| Expanded list cleanup and actual WASI counts | [38847420495](https://github.com/e6qu/fun-with-pipes/actions/runs/38847420495), Unix/WASI passed; Windows fixture failures described above |
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
