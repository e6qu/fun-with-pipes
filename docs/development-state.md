# Current work

**Next:** add G1's entry/rejection checklist and tests to the same PR as A1,
after the current PR #212 revision passes CI. Preparation is in
`/private/tmp/fwp-ownership-admission`, branch `ownership-admission`.
[PR #212](https://github.com/e6qu/fun-with-pipes/pull/212) is the only active PR:
head `6666b5ea488f8d990ef17a8c038174c85cc3ddba`, production `40151422882`,
documentation `40151422775`. The user explicitly requested bundling the next task
into #212 once this run passes: do not merge the array-only revision or create
another PR. After its ten gates pass, fast-forward `array-moves-delivery` to this
preparation, update #212's title/description and push the combined changes.
Require all nine production jobs and documentation again for the combined head,
plus ownership review. Squash with
`Reduce array ownership costs and define GC removal checks`, an empty body and
no trailers. Then record A1/G1's actual acceptance and continue G2–G3.

## G1 preparation

[The matrix](ownership-admission.md) maps executable, command, C-library, foreign,
HTTP/gRPC/REST/MCP, WASI and browser-loader entries to actual tests. It separates
invalid derivative scopes, conservative cycle rejection and C host obligations.
Unknown producer controls are explicitly internal-IR tests, not invented source
syntax. Scoped C callbacks do not establish a retained-callback release contract.

Seven existing rejection examples now have named source fixtures. Their test
requires tracing emission and precise ARC rejection in both raw/optimized IR;
rejected builds must return status 1 without emitting C. Invalid scope examples
are never executed just because tracing emits them. No compiler/runtime behavior
or supported lifetime API changed in this preparation.

Focused checks through `python3 scripts/local-guard.py`:

- Verified/downloaded the macOS ARM64 package from #211's passing production run
  `40139343820`: source `9f36f2f5ae4a1a2361a2c9ed8cb8bcc27a7680b3`, compiler SHA-256
  `ac389632d50137a880371d2ea05ad7a22d7f01e6aa5884acbecf440f9054db10`.
  Package is `/private/tmp/fwp-compiler-211/fwp-macos-arm64/fwp`.
- Formatted the seven fixtures with that compiler and ran all 28 compile-only
  admission observations with expected results (14 tracing emissions, 14 ARC
  rejections), plus no unexpected stdout.
- `cargo fmt --all` passed.
- Extracted the exact changed Rust test function to `/private/tmp/fwp-admission-test.rs`,
  changing only fixture include paths to absolute paths. Compiled it with Rust O1,
  debug assertions and overflow checks, then ran
  `arc_rejects_unproved_runtime_boundaries_and_disabled_counting`: one test passed,
  including disabled-counting controls. This is not a full Rust-target build.

- `python3 scripts/check-roadmap.py`: 156 Markdown link sets, 106 immutable
  preparation records and eight milestones passed; whitespace check passed.

Pending: final whole-target compilation/clippy and native execution in CI.
No full local build/suite/benchmark was run. The downloaded
compiler predates A1; it validates the unchanged admission implementation, not
A1's runtime change. The seven production/source fixtures remain in the repo.

## Baseline and unresolved issue

The user merged #211 as `afebaac99f9b45235df369a6460f8e4c081ec5b3`, with the
same tree as tested head `9f36f2f5ae4a1a2361a2c9ed8cb8bcc27a7680b3`. All nine
production jobs `40139343820` and documentation `40139343796` passed. #212 is
based on that merge; this preparation is based on #212's head.

A1's focused six-host/native and Linux cost evidence is in
[the array report](measurements/array-sort-ownership.md). It still needs final
integrated acceptance. Do not repeat unchanged finished measurements.

The original intermittent Intel macOS compiler abort remains unexplained.
[The investigation](measurements/compiler-abort.md) preserves evidence; #210's
interpreter lifetime repairs are not an established cause or cure. The user
requested source-first review; do not restart allocator-cookie/disassembly-led
experiments. The primary checkout is still detached at #209 with an operational
handoff pointing to these worktrees; do not use its obsolete plan.

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
