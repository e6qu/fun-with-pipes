# Session handoff

Updated 2026-10-16. Preparation worktree: `/private/tmp/fwp-zip-map`, branch
`fuse-numeric-zip-maps`, anchored at `1850f832`. Current source and fixtures are
`91146d684d723d835474e2a893a8adbe23004996`. Transfer only changes after the anchor;
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
| 1 | In progress | Validate partial zip cleanup and remaining deployment boundaries |
| 2 | In progress | Validate elimination of immediately mapped numeric zip pairs/nodes |
| 3 | In progress | Measure direct calls, instructions and reference-count traffic |
| 4 | In progress | Reduce measured derivative initialization intermediates |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain repeated timings, CPU time and normal-collector profiles |
| 7 | In progress | Preserve maintained applications across ownership changes |

Next: fix any failures in this batch's six-host test run and four-host cost run
below; inspect emitted code and actual instructions before adopting a timing
claim. Continue monitoring #149, merge it only after exact-head acceptance, then
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
and [four-host costs 38842840316](https://github.com/e6qu/fun-with-pipes/actions/runs/38842840316)
are queued/running at `91146d68`. The earlier queued runs `38842464287` and
`38842467115` are confirmed canceled; the liveness correction superseded them
before any job started. No current changed-compiler acceptance is claimed.

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
  binding fixtures await rebuilt-compiler CI.
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
