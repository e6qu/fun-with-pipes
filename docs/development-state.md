# Current work

**Next:** monitor PR #219's production gate `40498383568` at
`aab8fe71f4f08ff4dcc8a13624dcfdacfd45e031`. Documentation `40498379836`
and both analysis hosts `40498382182` passed. Seven production jobs passed: benchmark, all four macOS jobs and both native
Windows jobs. Complete logs were audited: 126 passing summaries per macOS
ownership job and 201 per Windows job. Only Linux AMD64/ARM64 remain running.
Fix any failure, audit all completed targets and squash-merge only after every
final-head gate passes. Keep the head unchanged while passing gates run. A5 is
not complete until that integrated verification passes.

## Active worktree

`/private/tmp/fwp-unique-array`, branch `unique-array-storage`, PR
[#219](https://github.com/e6qu/fun-with-pipes/pull/219). Rebased onto verified #218;
the rebased tree matched the measured source exactly. Focused source
`0f500ab347bc6025c09235f0e243467d9dc2a8ac` passed. The final update changes only
documentation. Read PR checks for the exact final head and gate IDs; the primary
checkout pointer records them once dispatch completes.

- Lifetime proof: selected local `Array[I64]` generation by a known callback with
  no captures, outside specialized loops. No independent aliases, captures or
  unknown calls may use its count-free storage. Failure/cancellation free it directly.
- Native chunk headers are 40 bytes with an optional 8-byte count pointer.
  Unique chunks have no count slots; counted metadata is separately allocated
  and may remain cached. WASI unique arrays bypass the separate count table.
- A padding-pointer bounds fix prevents unused bytes at the end of a small chunk
  from indexing past its shorter count array. Allocator and reuse tests passed.
- [The report](measurements/unique-array-storage.md) records implemented limits,
  exact counts, metadata, code/stack costs and outstanding acceptance. No timing
  improvement, RSS reduction or universal count-free-array support is claimed.

## Next batch preparation

A4 is now included in this batch: selected `(I64, String)` keys use a contiguous
field buffer and the existing direct worker. The implementation and tests are
not yet verified. [The declared protocol](measurements/inline-sort-keys.md) fixes
the allocation/count budget before measurement. New probes cover stable order,
String owners, every scratch/output allocation failure and callback entry failure;
source checks cover freshly allocated keys and cancellation. Run the focused
`arc-costs` suite on both Linux hosts before the combined final matrix. Twelve
evidence-reader controls pass locally under the fixed guard. No compiler build
or broad test suite runs locally. Preserve the prior A3 report as the baseline.

Worktree `/private/tmp/fwp-sort-key-fields`, branch `borrow-sort-key-fields`, starts
from #219's final head. No second PR until #219 merges. A scalar record projection
prototype emits its existing boxed body directly for function-value calls, while
keeping the direct worker for callers that already hold separate fields. Selection
requires one consumed record, an immediate scalar result and a pure field read;
resource records and borrowed-worker contracts are excluded. This avoids retaining
unrelated fields merely to release them in the worker.

The record-conversion probe covers unique/shared parents, String results,
pointer-shaped scalar bits, physical release and interruption at the entry tick.
Prototype `00957a15e95cc3b6d584749dcd32ac32b724c3b1` passed both Linux hosts in
`40499978041`. All completed targets and six ordinary/fault artifacts per host
were audited. The related sort-key change adds `sort-by` to existing known-callback
specialization, with capture-order, failure and cancellation controls.

Combined source `a44ed18ee72301fd9363ef934596064b55eb751f` completed
`40501234007`. Both hosts passed all correctness targets and produced all 13
measurements. The budget failed on an incorrect expectation about successful
last-owner queries: removed queries returned false, so successes stay unchanged.
The repaired reader now requires exact attempt reductions and the 2D effective
owner saving. It also updates the per-owner String/pair decomposition. Both local
artifact audits pass, including every hash, row, sample and metadata observation;
all complete target logs and six scalar/fault artifacts per host were audited.
Artifact-only runner audit `40503213568` passed at reader source `2baf3ec0`,
verifying unchanged compiler/runtime code and all evidence without rebuilding.
The complete report is retained in `measurements/sort-key-ownership-2026-10-27.json`.
Tag `evidence/sort-key-ownership-2026-10-27` retains a44 across the coming rebase.
[The protocol](measurements/sort-key-ownership.md) defines exact checks and limits.
Local formatting, workflow lint, eleven evidence-reader controls and 166 doc link
sets passed through the fixed guard; no local compiler build ran. Documentation
clarifications after a44 do not change the measured compiler/runtime.

## Passing focused checks

Run `40496623447` at `0f500ab347bc6025c09235f0e243467d9dc2a8ac` passed both
native Linux hosts: 196 unit tests, all 11 array-element tests, array borrowing/
unwind, library unload, six allocator tests, Clippy, actual WASI and compiler-cost
observations. All complete logs were audited. Each host's 36 native/static/escape
and 18 WASI probe statuses and empty outputs were independently checked.
Artifacts: `/private/tmp/fwp-unique-0f5-{amd64,arm64}`; full log:
`/private/tmp/fwp-unique-0f5-complete.log`.

## Retained measurements and repairs

All 13 paired count/metadata cases passed on both hosts in `40492232784`, source
`b9d637b6336f8a66b05c0b721f7b010aaa5aa998`. Hashes, rows and three samples per
input were audited. Tag `evidence/unique-array-storage-2026-10-27` preserves that
source. The compiler/runtime is unchanged since b9; later changes are tests/docs.
Compiler-cost samples from `40494835629` use 16/32/64 source calls and five samples
after warmup. Actual emitted sites are recorded because inlining partitions larger
inputs. Tag `evidence/unique-array-probe-7cf8baf8` preserves that source. Reports
retain both costs and limits; whole-command time is not isolated proof time.

The completed-array probe initially used a temporary transfer outside this proof;
it now fails during a known borrowed read while the array remains live. The escape
probe initially lost exports during main optimization; it now builds an explicit
function entry. Both repairs, static allocation and all fault controls pass 0f5.
Native/WASI harnesses collect all executable-probe failures before asserting.

## Remaining acceptance

1. Run the complete nine-job production matrix, documentation and existing G2
   compiler-analysis budgets on the final head. Do not repeat the unchanged
   operation-count measurements: their compiler/runtime sources are identical.
2. Audit every completed log and artifact. Squash-merge only on final-head success,
   with an explicit subject <=80 characters and empty body; verify message and tree.
3. Continue the measured A3/A4 word-frequency sort-key work in PLAN.md. Start with
   the numeric selector's D unnecessary String retain/drop pairs and investigate
   related pair duplication together. A6's parser workspace remains separate.

## Local checks and recovery

All local checks used the fixed guard. Formatting, workflow lint, roadmap and
primitive inventory pass; all ten ownership-reader controls pass. Bounded Clang
O1/O2 diagnostics used saved actual generated C to check allocator padding,
escaping-owner faults and cancellation/omitted-free controls. These do not replace
GCC/current-compiler validation. No full local build or suite ran; no maintained
build depends on a previous fwp compiler. Free disk was about 78 GiB.

Primary checkout remains detached at #209 with a worktree pointer and an untracked
`docs/measurements/compiler-abort.md`; preserve both. The original Intel compiler
abort remains unexplained. Preserve its evidence and investigate source/input on
recurrence. No detached merger is running; active timed checks monitor CI.

## Verified deliveries and roadmap

#218 merged as `cd0b53e27ff71bb266658415886c7bfc117ce9cb`, identical tree to tested
`4e504ee381d1d85f2172b508459d026300013ba5`. All nine production jobs `40480893046`,
docs `40480892776` and both analysis hosts `40480891997` passed. All complete logs
were audited. The one-line squash subject is 69 characters with no body/trailers.
Duplicate postmerge CI/docs `40495744117`/`40495743977` were cancelled.

Tracing GC removal shipped in #217 (`9dfa014596e1954e3e67c653123dad77a14f5241`),
identical tree to tested `2721bf14a389f685e3dd64f5bf3d6921f61a6212`. Production
`40433794313`, docs `40433794300` and analysis `40433851517` passed.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and binary checks |
| 2 | In progress | Finish A5, then measured A3/A4/A6 work |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
