# Current work

**Next:** verify the escaping/static array controls, then finish A5's docs and
full final-head matrix in one PR. Keep monitoring focused CI; fix all failures
before another publication. A5 is not complete and no final matrix has run yet.

## Active worktree

`/private/tmp/fwp-unique-array`, branch `unique-array-storage`. Rebased onto verified #218; the rebased tree matched the measured source exactly. The current working
tree corrects the escaping probe's entry selection and adds static-memory probes.

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

## Verification and known repairs

Prototype `04bb2033f6b30f8a34049ae973e2c5b24c6dbd7b`, run `40487837146`, passed
native Linux AMD64/ARM64: 196 unit tests, 11 array-element tests, array borrowing/
unwind, library unload, six allocator tests and Clippy. Complete logs/artifacts audited.

At `b9d637b6336f8a66b05c0b721f7b010aaa5aa998`, run `40492232784`, all 13 paired
count/metadata measurements passed on both hosts. Hashes, rows, three samples per
input and cross-host totals were audited. The report/JSON retain every result;
immutable tag `evidence/unique-array-storage-2026-10-27` preserves the source.
The completed-array test failed because its `tap` expression transferred the array
through a temporary local, outside this proof. The corrected fixture uses a known
borrowed read that fails while the same array owner remains live.

At `7cf8baf8`, run `40494835629`, native success/partial/completed/cancellation
probes all passed (24 variants per host), as did actual WASI cleanup (18 variants),
all other focused targets, Clippy and compiler-cost measurements. Both logs were
audited. One test-harness failure remained: an ordinary main build removed exports
needed by the escaping probe. The working tree builds an explicit function entry
before selecting those exports. The native harness collects all executable-probe
failures instead of stopping at the first variant. All 42 native/WASI probe statuses per host were independently checked, with
empty stdout/stderr and their intended fault exits. The complete compiler-cost
reports were reviewed on both hosts.

Compiler measurements use 16/32/64 source calls, five samples after a warmup;
actual selected sites are recorded because inlining partitions larger inputs.
These measure the complete compiler command through C emission, not isolated
proof time. The proof's worst-case O(MN) walk is documented; preserve G2 budgets.
`unique-array-checks` reruns affected native/WASI/compiler controls without repeating
the unchanged count measurements. The compiler/runtime source is unchanged since b9.

## Remaining acceptance

1. Publish the entry-selection repair with static generated-array probes and verify
   both Linux hosts; retain all fault statuses and actual C/binaries.
2. Audit the remaining artifacts and compiler-cost samples. Finish the report,
   ownership/diagnostic docs and plan with precise tested limits.
3. Open one coherent PR and run the complete nine-job production
   matrix plus documentation and existing compiler-analysis budgets. Squash-merge
   only after final-head success; explicit subject <=80 characters, empty body.
4. Continue A3/A4/A6 from the measured owner breakdown. General regions and other
   element types are not part of the initial A5 selection.

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
