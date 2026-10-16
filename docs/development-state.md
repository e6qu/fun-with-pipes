# Session handoff

Updated 2026-10-16. Preparation worktree: `/private/tmp/fwp-zip-map`, branch
`fuse-numeric-zip-maps`, anchored at `1850f832`. Current source and fixtures are
`91146d684d723d835474e2a893a8adbe23004996` for zip/map; text-file changes follow it. Transfer only changes after the anchor;
its parents are part of the preceding delivery.

The only active delivery is [PR #149](https://github.com/e6qu/fun-with-pipes/pull/149),
ready at `5748f7496a8f1db0e93145c53e380a0703affc2f`. Exact-head production
[38841142126](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126) is
running/queued; [docs 38841118993](https://github.com/e6qu/fun-with-pipes/actions/runs/38841118993)
passes. Its authoritative handoff is in the root worktree. Do not open another
PR before it merges. Its four-host CPU/collector diagnostic passes, but the nine
production jobs remain required. Failing tests are tasks to fix.

Standing authorization covers publication and squash merge only after all nine
production jobs and docs pass for the exact final head. Supply a one-line subject
of at most 80 characters and an empty body; no trailers or attribution. JIT is
excluded. Local checks are serial under `python3 scripts/local-guard.py COMMAND...`
without raising its limits. Full builds, suites and timings run on GitHub.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion. None of its seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Validate text-file ownership and partial zip cleanup |
| 2 | In progress | Validate elimination of immediately mapped numeric zip pairs/nodes |
| 3 | In progress | Measure direct calls, instructions and reference-count traffic |
| 4 | In progress | Reduce measured derivative initialization intermediates |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain repeated timings, CPU time and normal-collector profiles |
| 7 | In progress | Validate maintained todo/grep functions and command lines under ARC |

Next: validate the related list-construction cleanup repairs on all six hosts
and the large chunk-size regression on actual WASI; inspect any failures.
Continue monitoring #149, merge it only after exact-head acceptance, then
transfer this batch for the next substantial PR. Queued CI does not block fixes
or independent preparation.

## Change and acceptance criteria

The earlier derivative profile attributes 4,194,304 of 25,184,777 managed requests
to zip pairs and their list nodes. #149 removes a different 2,097,152 requests.
Numeric derivative initialization builds pairs and immediately maps a known
callback over them. This candidate uses existing zip-with ownership and a
specialized callback whose pair fields can remain local, without new syntax.

Preserve eager argument order, shorter-list truncation, callback effects/traps,
aliases and result cleanup. Only inline numeric inputs qualify; managed inputs
keep their original path. Numeric producer bindings stay around the replacement;
resource-bearing bindings cannot extend through callbacks. Rejoin single-use
intermediates through a record prefix only when its earlier fields are plain
locals/constants, stopping at calls and resource regions.

Run zip replacement after existing fold/array consumers: replacing map earlier
would hide their input and reintroduce output lists. Dedicated tests preserve
those optimizations. `FWP_ZIP_MAP=0` disables only the new transformation for
comparison. Native code must show removed pairs and known direct callback calls;
a smaller allocation count alone does not establish faster execution.

Review also found ordinary zip left scratch and already duplicated fields
unprotected when a later retain traps. The repair owns both pending fields,
completed pairs and the partial output list. Borrowed inputs remain live through
final list allocation. This repair applies independently of the optimization.

Acceptance compares raw/optimized interpretation with native O1/O2 tracing/ARC,
including empty/unequal lists, captures, numeric bindings, checked failures,
returned tuples/managed results and excluded managed inputs. Counts include
retained aliases and final storage. Cleanup probes force retain, second-scratch,
pair and list failures, actual retain overflow, real collection and three
intentional cleanup omissions. Final delivery still needs the full nine jobs.

## Checks and active evidence

[Six-host tests 38842838108](https://github.com/e6qu/fun-with-pipes/actions/runs/38842838108)
pass at `91146d68`, including the newest consumer-order and numeric-binding
fixtures. [Four-host costs 38842840316](https://github.com/e6qu/fun-with-pipes/actions/runs/38842840316)
passes on all four hosts. The earlier queued runs `38842464287` and
`38842467115` are confirmed canceled; the liveness correction superseded them
before any job started. Focused acceptance does not replace the final production gate.

The cost suite compares the same compiler with only `FWP_ZIP_MAP` changed, keeping
mapped-array construction and other fusion enabled. Direct work constructs 128
numeric result lists before reducing them; the other cases compute 512 reverse
derivatives and a second derivative over 256 inputs. Retain eight alternating
whole-process samples, separate allocations/retains/peak/final memory, compiler
and flags, compilation time, binary size and actual disassembly. Both variants
are fwp, not C/Rust. Timings and allocation evidence run only on GitHub.

Guarded local checks, supplemental to CI:

- The isolated transformation compiles against an existing prebuilt library
  (latest 1.25 s), and the test harness compiles (0.50 s). This avoids a full local
  compiler build; its older backend requires disabling the newer mapped-array
  primitive for these probes.
- Six fixture groups match accepted #148 raw interpretation under native tracing
  stress (7.22 s). Ordered/captured/tiny derivative cases also match native ARC
  (7.13 s). Explicit expected output follows actual argument order: the zip
  argument prints before its piped subject. The newest consumer-order and numeric
  binding fixtures now pass rebuilt-compiler CI on all six hosts.
- Allocation/alias checks and missing-result cleanup controls pass tracing/ARC
  (5.28 s). For 129 numeric pairs, requests fall from 390 to 131, requested bytes
  from 12,408 to 5,176 and retains from 129 to zero. Final storage returns to its
  starting value. These are small isolated-pass results, not workload timings.
- Edited-C cleanup probes reproduce the old leak (exit 248), pass the repair in
  both modes, and reject omitted pending-field, pair or scratch cleanup. Latest
  check includes collection during pair/list assembly and passes (3.72 s).
- A tiny direct workload prints 40.0 under raw interpretation and native ARC with
  the transformation off/on, and confirms the intended code path (2.29 s).
  Script parsing (0.13 s), formatting (0.97 s) and docs (2.62 s) pass.

The accepted #148 compiler is `/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`.
The isolated-pass harness and probes are `/private/tmp/fwp-zip-*`; they do not
replace production binaries or native acceptance. No remaining local failure is
being treated as a pass.

## Text-file ownership and maintained applications

This batch also supplies the missing `file.read` fresh-string contract and
`file.write-new` borrowed-input contract. Both use already protected runtime
implementations shared with accepted byte IO; no new wrapper or runtime path is
introduced. `file.write-new` creates or truncates a file, which source comments
and generated library documentation now explain explicitly.

Acceptance adds repeated UTF-8 reads, empty/NUL contents, replacement writes,
missing/invalid paths, invalid UTF-8 cleanup and write/close error preservation.
The cleanup fixture counts actual buffer frees, and an omitted free must fail.
An omitted string owner must fail the final live-storage check under ARC. The
existing complete path-rejection fixture now also runs under ARC.

Maintained `todo` and `grep` functions run 64 times with results retained, against
raw and optimized interpretation and O1/O2 native tracing/ARC. Separate real CLI
tests cover subcommands, file arguments, stdin, Unicode and exit statuses. CI
suite `filesystem` includes these tests on all six native targets; Windows full
acceptance includes them too. [Six-host filesystem run 38845110123](https://github.com/e6qu/fun-with-pipes/actions/runs/38845110123)
passes on all six native hosts at `0bae98f7c9b7c8a67d15d4a5e8aac26ec83da00a`.
Final production acceptance remains required.

Bounded local checks: both repeated raw fixtures pass using accepted #148 (0.49 s).
The standalone harnesses compile (0.26 s each); the C cleanup probe passes O1/O2
tracing/ARC, forced collection and four broken controls (6.16 s). A test-only C
declaration-order error was repaired before that pass. Inventory passes (0.99 s):
261 contracts, 92 review declarations, 82 review symbols. Formatting passes
(1.11 s); two source-comment additions regenerate through the standalone standard
library generator (0.38 s). These checks do not rebuild the compiler or establish
cross-platform acceptance. The documentation audit passes (2.42 s).

## Zip timing investigation

All four verified reports show derivative requests falling from 23,087,625 to
18,892,809 and retains from 10,492,416 to 8,395,264; peak memory stays 840,888 bytes.
Elapsed enabled/disabled ratios are 0.828/0.825 (tracing/ARC) on AMD64 and
0.791/0.769 on ARM64; macOS ARM64 is 0.710/0.793 and Intel 0.784/0.741.
Tiny nested cases remain mixed. [The report](measurements/zip-maps-2026-10-16.json)
retains all samples, hardware/flags, compile times, sizes and actual instructions.
Hash/count retention passes (0.14 s). ARM64 has vector multiply in the direct
loop; Linux AMD64 has unrolled scalar multiply. Neither proves total instruction
or spill counts, and these comparisons do not measure C/Rust overhead.

The existing verified-binary CPU/collector repeat script is renamed
`scripts/repeat-native-comparison.py` so both mapped-array and zip comparisons use
one implementation. [Repeat 38846124783](https://github.com/e6qu/fun-with-pipes/actions/runs/38846124783)
passes on all four hosts at `60b94e9f`, using evidence run `38842840316`. This does not rebuild the compiler;
it reuses verified timed binaries and separately instruments normal/off collector
profiles. Use it to investigate small-workload timing variation and retain all
slower cases alongside improvements. [Retained repeat evidence](measurements/zip-map-cpu-2026-10-16.json)
verifies hashes and all sixteen sample pairs (0.26 s). The first retention check
incorrectly expected zero collections in normal traced direct work; the actual
reports show two collections in both variants on every host. Other profiles have
zero collections; all final storage is zero, and all non-collection counts match.
Direct and derivative CPU ratios improve on all hosts. Tiny macOS ARM64 nested
ARC remains 1.017 CPU / 1.027 elapsed, with overlapping 1.46–2.32 ms CPU samples;
retain this limitation rather than asserting universal improvement.

## Adjacent unzip failure cleanup

Review found `unzip` left three scratch buffers, duplicated fields and either
partial output list unprotected during traps. The repair keeps typed owners for
both result lists until their outer pair exists. Retain order and left-then-right
list construction stay unchanged. Scalar fields still receive no retain.

The new probe forces failures at both output scratch allocations, both field
retains (including actual wide-counter overflow), partial left/right lists and
the outer pair. It also collects during construction and checks empty input.
Missing field/list/scratch cleanup must fail. Local edited-C checks reproduce the
old leak (248), pass the repair, and reject the three omissions at O1/O2 in both
memory modes (8.01 s). These use accepted #148, not a rebuilt compiler.

The expanded `zip-maps` suite now includes `unzip_cleanup`, `zip_ownership`,
`zip_unwind_ownership` and `list_structure_ownership` alongside prior tests. The
older scalar-structure fixture matched exact argument lists and needed updating
for added destructor arguments; it still verifies the first retain arguments are
NULL. [Expanded zip/unzip run 38846340365](https://github.com/e6qu/fun-with-pipes/actions/runs/38846340365)
is running at `ad9481220ddf2f86ec385bf037768c69d2ee6dc9`. Its changes precede the
additional repairs below.

## Related list-construction failures

The same audit found unprotected pending references/partial lists in `repeat`
and `chunks`, and unprotected state results/scratch in `scan` and `iterate`.
Their existing typed owner records now protect the whole construction. Preserve
the old retain/callback order and returned earlier states. No new runtime
abstraction or language syntax is needed. Code generation supplies concrete
element/list destructors; scalar tests still require NULL retain arguments.

An additional `chunks` bug narrowed a positive I64 chunk size directly to
32-bit `size_t`, so 4,294,967,296 became zero on WASI. Both owned and ordinary
implementations now use the existing checked count conversion and division-based
ceiling. The actual-WASI test expects one chunk for a three-element list with
that size at O1/O2 and with ownership optimization on/off.

The local edited-C probe independently reproduces all four old leaks (248 for
repeat/chunks, 249 for scan/iterate), passes the repairs and rejects five missing
cleanup controls. It covers retain/callback failures, both scratch allocations,
pending elements and partial output nodes, with real collection at O1/O2 in both
memory modes (11.11 s). The standalone Rust harness compiles (0.38 s); formatting
passes (0.99 s). These are supplemental accepted-compiler probes.

The next `zip-maps` dispatch includes these new controls, existing structural,
generation and state-sequence semantic tests on six native hosts, and a separate
required WASI count job on each Linux architecture. Full final-head production
acceptance still follows focused results. Do not mistake the earlier narrower
run for validation of these newest repairs.
