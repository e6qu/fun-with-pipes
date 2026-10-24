# Current work

**Next:** finish all ten final-revision CI gates for documentation
[PR #211](https://github.com/e6qu/fun-with-pipes/pull/211) on `docs-overhaul`
in `/private/tmp/fwp-docs-overhaul`, then squash-merge under the standing
authorization. Base: merged main
`380fa8412327e52db420b96918d20e2528bbfc7c`. Fix every failed check before merging.
The squash message must be one line, at most 80 characters, with an empty body
and no trailers or attribution. After delivery, publish integrated task **A1** below.

The first published revision `29edbc03931de2a7e2f71744092a191fb3a21c85` passed
documentation `40138325016` and the benchmark job in production `40138325017`.
A final review corrected an overlooked tracing-default statement in the service
guide. The updated revision needs all gates; do not use those earlier passes as
its acceptance evidence. Check the PR for the current head and runs.

The overhaul makes [PLAN.md](../PLAN.md) the detailed backlog: GC tasks G1–G5,
ARC tasks A1–A5 and the six other milestone groups have concrete inputs, code/test
locations, dependencies and completion evidence. Ownership and architecture guides
state current contracts; benchmarks explain comparisons and link historical
protocols/results. Preparation IDs and raw measurements retain their identities.
Tutorial corrections cover browser dependencies/tail calls, proved task/channel
captures, explicit interpreter commands and navigation. The reference now includes
Windows and distinguishes ARC from tracing in static-memory builds.

## Baseline and unresolved issue

The user merged [#210](https://github.com/e6qu/fun-with-pipes/pull/210) on
2026-10-24. Tested head `36924807f0343c79c38ef42c4254a721afa60613` and merge
`380fa8412327e52db420b96918d20e2528bbfc7c` have identical trees.
All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40124698815)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40124698740)
passed. The 236-check Linux/Intel macOS interpreter suite also passed before
publication. Final-head independent binary review was not completed before the
user merged; do not turn the passing CI record into a claim that it was.

The original intermittent Intel macOS compiler abort remains unexplained.
[Its investigation](measurements/compiler-abort.md) records source review and
preserved evidence. The interpreter lifetime fixes are not an established cause
or cure. The user requested source-level safety review; do not resume allocator-
cookie experiments or disassembly-led diagnosis.

## Prepared work after this overhaul

Plan task **A1** is already prepared in `/private/tmp/fwp-array-sort-ownership`,
branch `array-sort-ownership`, checkpoint `9824e22e827cfd6116c55ac2fcc2651ed02a7dcc`.
Tested source is `e0c4dd51bae37c0e09be10fcb373dd035279f815`.
It moves unshared list prefixes into arrays and reuses unique arrays for sorting.
All six native jobs in `40100508025` and both Linux cost jobs in `40100509770`
passed; focused logs and independent reviews are complete. The report in that
checkout is `docs/measurements/array-sort-ownership.md`.
The integration is saved separately in `/private/tmp/fwp-array-moves-delivery`,
branch `array-moves-delivery`, commit `f4359dc82b19629a8779f3d5d175f082e8bdf4b7`.
It keeps #210's CI repairs. Guarded formatting, workflow lint, primitive inventory,
19 native-runner controls and 155 documentation link sets pass. After #211 merges,
move it onto the merged tree, preserve this service-guide correction, update its
handoff, and run final delivery checks. Do not repeat finished preparation or
claim this code is already merged.

## Verification for this documentation change

Focused checks passed under `python3 scripts/local-guard.py`:

- `python3 scripts/test-roadmap.py`: four controls. Code comments inside fenced
  examples can no longer masquerade as linkable headings.
- `python3 scripts/check-roadmap.py`: 154 Markdown link sets, 106 immutable
  preparation pairs/tags, eight plan/handoff milestones and commit rules.
- Standalone `tests/examples.rs`: `tutorial_readmes_match_their_programs` passes.
- Standalone `tests/stdlib_doc.rs`: `stdlib_doc_is_current` passes without blessing.
- `actionlint .github/workflows/roadmap.yml` passes.

Both standalone checkers were compiled with Rust O1, debug assertions and overflow
checks, without building the compiler. No tutorial execution, full local suite or
benchmark was run. Full production checks remain required on GitHub. The generated
library reference and vendored license/provenance documents needed no edits.

The primary checkout remains detached at #209. Its operational handoff points
here, and its local abort report is preserved. Earlier operational notes were
saved to `/private/tmp/fwp-primary-handoff-before-docs.md`; relevant source/run IDs
are recorded here and in the abort report. Old publication/merge/pruning helpers
under `/private/tmp` are source-specific; do not rerun them unchanged.

## Roadmap status

Detailed tasks and completion criteria live only in [the plan](../PLAN.md).

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | G1–G5: close lifetime contracts, replace diagnostics, delete tracing |
| 2 | In progress | A1–A5: deliver prepared moves/reuse and eliminate measured redundant counts |
| 3 | In progress | F1–F3: cost fixtures, proved tail-frame extensions and mutual-recursion decision |
| 4 | In progress | P1–P3: repeat checked comparisons and meet per-workload CPU budgets |
| 5 | In progress | D1–D3: separate and reduce AD recording/workspace costs, validate nesting |
| 6 | In progress | N1–N2: accuracy and performance budgets for selected CPU kernels |
| 7 | In progress | B1–B2: repeated baselines and enforced evidence/budget rules |
| 8 | In progress | V1–V2: finish and execute the finite application acceptance matrix |
