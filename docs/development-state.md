# Session handoff

Updated 2026-10-15. Current draft: [PR #145](https://github.com/e6qu/fun-with-pipes/pull/145),
branch `measured-ownership-performance`, based on
`e94cc4a6` (PR #144). The user requested cancellation of remaining old CI runs
and the next large combined PR. The currying discussion is settled: retain
explicit `curry`/`uncurry` and pursue the single-argument function model.
`f x y` means `(f x) y`; tuples are single values. Do not add implicit conversion
between tuple-taking and curried functions. The user also requested infix
arithmetic with standard precedence, alongside prefix calls and pipes.

## Roadmap status

| Step | Status | Current scope |
|---|---|---|
| 1 | Pending | Remove tracing GC; use moves/borrows and limit ARC to necessary sharing |
| 2 | In progress | Inspect avoidable costs in fused array/iterator loops |
| 3 | In progress | Establish comparable numerical measurements and inspect generated loops |
| 4 | In progress | Reproduce the derivative metadata timing regressions |
| 5 | Pending | Broaden numerical kernels; resolve runtime OpenCL compilation under no-JIT policy |
| 6 | In progress | Improve sample ordering and baseline comparability |
| 7 | In progress | Select numerical, collection-heavy and repeated workloads |

## Merge and cancellation record

The user merged [PR #144](https://github.com/e6qu/fun-with-pipes/pull/144) as
`e94cc4a6`; its files match final head `5ec27257`, and the one-line merge message
meets the commit rules. At their explicit request, cancelled remaining runs
`38765035981`, `38765035723`, `38762453518`, `38761771511` and `38752839908`.
Do not restart these old runs or count cancellation as a pass. The instruction
applies to those remaining runs; the new implementation delivery still needs
its own focused checks and full final-commit CI before merge.

PR #143 fixed PR #142's stale bookstore OpenAPI fixture; its four focused
OpenAPI comparisons passed locally without regeneration. PR #144 documents that
JIT is explicitly excluded, not deferred. Earlier delivery evidence remains in
[history](roadmap-history.md). The active project work is in [PLAN.md](../PLAN.md).

## Combined delivery scope

- Establish runner measurements for current numerical arrays/matrices, repeated
  derivative calculations and complete programs, with source/compiler/CPU data.
- Improve comparison fairness: rotate implementation order, retain samples and
  distinguish compile-time-known dimensions and algorithms from runtime work.
- Investigate the per-element checked index/cleanup work in fused array loops
  and tracing-only compiler fences still present in checked ARC executables.
  Prove any removed work unnecessary before changing it; preserve arithmetic
  traps, failure cleanup, alias behavior and task cancellation.
- Reproduce paired derivative-buffer slowdowns before selecting a change there.
- Preserve single-argument functions, ordinary partial application and explicit
  `curry`/`uncurry`; optimize their compiled costs without changing call semantics.
- Add fixed-precedence infix arithmetic using the existing numeric traits;
  preserve checked operations, left-to-right operand evaluation, negative
  literals and hyphenated names. Update formatting, macros, examples and docs.

Acceptance requires raw-interpreter/native agreement, allocation/retain/cleanup
counts, generated binary inspection, explicit before/after comparisons on Linux
and macOS ARM64/AMD64, and all nine production jobs plus documentation. Keep
source and result provenance; fewer allocations alone is not a speed claim.

## Progress and checks

Read the current compiler/ownership contracts and emitted one existing numeric
array program with the guarded command:
`target/debug/fwp build --fn reduce64 --emit-c -o /private/tmp/fwp-baseline-array.c tests/fixtures/numeric_array_fusion.fwp`.
It passed in 0.63 seconds. This uses the existing compiler for inspection only;
runner builds establish current source behavior. No local benchmark was run.

The emitted loop already avoids intermediate arrays and per-element retains,
but registers a cleanup around each checked index increment. Array headers
reserve their high bit for views, bounding length by I64's maximum; a successful
read therefore bounds the next index. The ARC runtime also retains compiler
memory fences originally intended to keep conservative GC roots alive. These
are candidate costs to validate, not accepted optimizations yet.

A new explicit `performance` selection in the numerical workflow groups focused
ownership tests and numerical/derivative/program measurements on four native
hosts. Initial results establish the pre-change baseline; this dispatch is not
the full production acceptance gate.

The pre-change performance dispatch is
[run 38767826317](https://github.com/e6qu/fun-with-pipes/actions/runs/38767826317)
at preparation commit `711ac295`. All four Linux/macOS ARM64/AMD64 jobs passed.
This is baseline evidence, not final-head acceptance.
The ARM macOS profile confirms one cleanup registration per element in the fused
array loop (129/257 registrations for 129/257 elements), with zero intermediate
allocations or retains. Timings vary substantially; no speedup is claimed.

Infix arithmetic was published at `0ae0737a` (`+ - * / %` and unary
negation). Inference and native lowering use the existing arithmetic operations;
the syntax tree retains notation for formatting. Added precedence/formatting,
macro, numeric-width, operand-effect and competing-trap controls. Full compiler
and interpreter/native validation is pending on runners.

Commit `c32b95f1` additionally removes checked increments from the bounded
internal array index and omits unwind scopes for immediate wrapping integer
operations. Wide boxed integers and ordinary checked arithmetic keep their
protection. Checked ARC also omits conservative-GC root fences; tracing mode
retains them. Existing allocation/cleanup and ARC reclamation controls are the
acceptance tests, with the array cleanup bound tightened to constant work.
These runtime/compiler changes are not yet verified on runners.

The obsolete, still-queued syntax dispatch `38768610721` was cancelled and
replaced by [run 38769658801](https://github.com/e6qu/fun-with-pipes/actions/runs/38769658801)
at `c32b95f1`. Its arithmetic/formatter/type checks and array/ARC/unwind tests
finished with one failure: the new arithmetic fixture omitted signatures for
its constant-input `left`/`right` helpers, which would otherwise be generic.
Added explicit `() -> I64 ! {IO}` signatures. The arithmetic runtime comparison
must rerun; it failed before execution. Rust formatting, Clippy, existing parse
and type snapshots, formatting, array fusion, ARC reclamation and loop unwind
controls passed. This failed overall run does not authorize merging.

Measurement preparation now rotates complete-program C/Rust/fwp execution order
over six samples, reports medians and compilation time/binary size, and uses
sorted Rust pairs to match the C/fwp map representation. Numerical measurements
hide C/Rust dimensions from constant propagation, use disjoint C output storage,
and collect six rotating batches of five samples. Historical results retain
their original methods; new timings are pending. No local benchmark was run.

The derivative comparison now balances eight process samples and adds a
512-calculation case to reduce startup noise, retaining the short controls.
The baseline identity case showed timing variation even with zero metadata
allocation requests; that variation is not evidence of a metadata-layout cost.

Focused local checks, all through `python3 scripts/local-guard.py`:

- `python3 /private/tmp/fwp-infix-local.py`: standalone lexer/parser/formatter
  harness passed two precedence/layout/round-trip tests and six lexer tests
  (1.83 s), including macros, type sizes, long expressions and comments.
- `cargo fmt --all -- --check`: passed (1.08 s).
- Existing interpreter float-display probe: passed (0.63 s); this establishes
  fixture output spelling only, not the changed compiler's correctness.
- `python3 scripts/check-roadmap.py`: passed after the documentation updates
  (2.82 s); `git diff --check` also passed.
- `python3 /private/tmp/fwp-measurement-checks.py`: benchmark harness, Rust map,
  numerical C/Rust fixtures (timing and profiling) compile; measurement script
  parses. This is a compile check only; output equivalence and timing run on CI.
- Existing interpreter check of the tutorial's explicit curry/uncurry signatures
  and corrected effectful fixture helpers: passed (0.65 s), printing `5`, `5`,
  `left`, `right`, `7`. This does not replace changed-compiler infix validation.

An attempted display probe using `fwp eval` failed because that CLI command does
not exist; the corrected probe used `fwp run --interp` with a temporary file.

## Next action

Next: dispatch the four-host `performance` suite at the fixed branch head. It
now includes the arithmetic interpreter/native test, so this reruns the failed
control while collecting the remaining evidence without a separate compiler
build. Fix any failures. Review operation counts and generated instructions;
do not compare old and new timing methods as an isolated optimization speedup.
The current baseline confirms the old cleanup cost, but a controlled same-method
before/after timing comparison and ARC-specific timings are still needed.
Keep all changes in this combined PR;
mark it ready only when its final content and evidence are reviewable.

Use `python3 scripts/local-guard.py COMMAND...` for focused serial local checks.
Full builds, suites, benchmarks and large regeneration stay on GitHub runners.
Preserve fixed resource limits and the one-line, <=80-character commit format
without body, trailers or attribution. Update this handoff after meaningful
progress; the project remains active until PLAN.md's criteria are met.
