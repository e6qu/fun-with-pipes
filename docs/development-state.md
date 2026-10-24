# Current work

**Next:** publish and validate plan **A1**, the combined array conversion/sorting
change, from `/private/tmp/fwp-array-moves-delivery`, branch `array-moves-delivery`.
Require all nine production jobs, documentation and the source/binary ownership
review on the final revision before squash merge. Use the single-line subject
`Move unshared list elements and reuse unique arrays when sorting`, an empty
body and no trailers. After delivery, continue G1's supported-execution matrix;
the concrete requirements are in [PLAN.md](../PLAN.md).

The prepared implementation applies cleanly to current compiler/runtime source.
Two workflow conflicts are resolved by retaining #210's SDK compiler prerequisites
and interpreter-lifetime suite alongside the added array checks. Raw preparation
measurements are copied unchanged. Focused integration checks pass; full native
delivery checks remain pending. The historical runs do not validate this branch's
whole compiler.

## Baseline and unresolved issue

The user merged [#211](https://github.com/e6qu/fun-with-pipes/pull/211) on
2026-10-25. Tested head `9f36f2f5ae4a1a2361a2c9ed8cb8bcc27a7680b3` and merge
`afebaac99f9b45235df369a6460f8e4c081ec5b3` have identical trees.
All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40139343820)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40139343796)
passed. This branch is rebased onto that merge; the service-guide correction
and all interpreter cleanup repairs remain present.

The original intermittent Intel macOS compiler abort remains unexplained.
[Its investigation](measurements/compiler-abort.md) records source review and
preserved evidence. The interpreter lifetime fixes are not an established cause
or cure. The user requested source-level safety review; do not resume allocator-
cookie experiments or disassembly-led diagnosis.

## Applicable preparation evidence

Plan task **A1** is already prepared in `/private/tmp/fwp-array-sort-ownership`,
branch `array-sort-ownership`, checkpoint `9824e22e827cfd6116c55ac2fcc2651ed02a7dcc`.
Tested source is `e0c4dd51bae37c0e09be10fcb373dd035279f815`.
It moves unshared list prefixes into arrays and reuses unique arrays for sorting.
All six native jobs in `40100508025` and both Linux cost jobs in `40100509770`
passed; focused logs and independent reviews are complete. The report in that
checkout is `docs/measurements/array-sort-ownership.md`.
The integrated runtime, code generation, ownership contracts and native array
probes match that tested preparation. Final integrated validation is still
required; do not repeat finished preparation or claim this code is merged.

## Verification for the integrated array change

The following focused checks passed under `python3 scripts/local-guard.py` on
the integrated working tree:

- `cargo fmt --all -- --check`.
- `actionlint .github/workflows/ci.yml .github/workflows/numerics.yml .github/workflows/windows.yml`.
- `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-array-delivery-inventory.json`:
  392 declarations, 382 symbols, 40 aliases, 371 contracts, 19 IR and two flat
  entries; no unreviewed contract.
- `python3 scripts/test-native-test-runner.py`: all 19 coverage/runner controls.
- `python3 scripts/check-roadmap.py`: 155 Markdown link sets, 106 immutable
  preparation records and eight milestones.

These working-tree checks are not final-commit evidence. Full compiler builds
and native semantic checks run on GitHub; do not repeat the prepared measurements
unless changed behavior invalidates their applicability. Final production
evidence must name the integrated source, including actual binaries and
deliberately broken cleanup controls.

The primary checkout remains detached at #209, with its local handoff pointing
here and the abort report preserved. Do not use its older plan. Keep actual
published source/run IDs there while final gates run without changing their head.

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
